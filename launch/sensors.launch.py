import launch
import yaml

from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, OpaqueFunction
from launch.actions import ExecuteProcess
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution, TextSubstitution
from launch_ros.substitutions import FindPackageShare

import os

def launch_setup(context: launch.LaunchContext, ld):
    # #{ spawn drone config

    config_file_path = LaunchConfiguration('sensors_start_file').perform(context)

    # #}

    # #{ iterate file config and start the driver and static tf for each sensor

    try:
        with open(config_file_path, 'r') as file:
            config_data = yaml.safe_load(file)['/**/**']
    except EnvironmentError:
        print(f"Error: Can't find the config file in '{config_file_path}'")
        return None
    except KeyError:
        print(f"Error: The key '/**/**' don't exist in YAML.")
        return None

    sensors = (config_data.get('ros__parameters', {})).get('sensors', {})

    sensors_available = ['realsense', 'livox']

    uav_name = os.environ['UAV_NAME']

    for sensor in sensors:
        if sensor.get('type', '') in sensors_available:
            fcu_frame = uav_name + '/fcu'
            fcu_frame_slashless = 'fcu_' + uav_name

            sensor_frame = uav_name + '/' + sensor.get('name', '') + '/link'
            sensor_frame_slashless = uav_name + '_' + sensor.get('name', '') + '_link'

            transform = uav.get('transform', [])

            fcu_to_sensor_tf_static_publisher_node = Node(
                package='tf2_ros',
                executable='static_transform_publisher',
                name=TextSubstitution(text=fcu_frame_slashless + '_to_' + sensor_frame_slashless),
                namespace=uav_name,
                arguments=[transform[0], transform[1], transform[2], transform[3], transform[4], transform[5], fcu_frame, sensor_frame],
                output='screen'
            )
            ld.add_action(fcu_to_sensor_tf_static_publisher_node)

            launch_arguments = {}
            if 'realsense' == sensor.get('type', ""):
                package = 'realsense2_camera'
                launch_name = 'rs_camera.launch.py'
                launch_arguments={
                    'camera_name': sensor.get('name', '')
                }
            if 'livox' == sensor.get('type', ""):
                package = 'livox_ros_driver2'
                launch_name = 'msg_MID360_launch.py'
                launch_arguments={
                    'livox_name': sensor.get('name', '')
                }

            sensor_driver_launch = IncludeLaunchDescription(
                PythonLaunchDescriptionSource([
                    PathJoinSubstitution([
                        FindPackageShare(package),
                        'launch',
                        launch_name
                    ])
                ]),
                launch_arguments=launch_arguments.items()
            )
            ld.add_action(sensor_driver_launch)
        else:
            print(f"Error: Don't have support for this sensor.")
    # #}

def generate_launch_description():
    ld = launch.LaunchDescription()

    # #{ sensors start config
    
    ld.add_action(DeclareLaunchArgument(
        'sensors_start_file',
        default_value='',
        description='Path to config file for start sensors.'
    ))
    
    # #}

    # #{ opaque function
    
    ld.add_action(
        OpaqueFunction(function=launch_setup, args=[ld])
    )
    
    # #}

    return ld
