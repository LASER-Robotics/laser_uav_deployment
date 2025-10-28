import launch
import launch.logging

from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, OpaqueFunction
from launch.actions import ExecuteProcess
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution, TextSubstitution
from launch_ros.substitutions import FindPackageShare
from launch_ros.actions import Node

def lr7pro(context: launch.LaunchContext, ld):
    uav_name = os.environ['UAV_NAME']
    uav_sensors = os.environ['UAV_SENSORS']
    uav_sensors = uav_sensors.split()

    fcu_frame = uav_name + '/fcu'
    fcu_frame_slashless = 'fcu_' + uav_name

    if '--enable_livox' in uav_sensors:
        # #{ livox
        livox_frame = uav_name + '/livox/link'
        livox_frame_slashless = uav_name + '_' + 'livox_link'

        # #{ static_transform_publisher
        fcu_to_livox_tf_static_publisher_node = Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name=TextSubstitution(text=fcu_frame_slashless + '_to_' livox_frame_slashless),
            arguments=['0.0', '0.0', '0.18', '0.0', '0.0', '0.0', fcu_frame, livox_frame],
            output='screen'
        )
        ld.add_action(fcu_to_livox_tf_static_publisher_node)
        # #}

        # #{ include other launch
        livox_driver_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('livox_ros_driver2'),
                    'launch',
                    'msg_MID360_launch.py'
                ])
            ]),
            # Opcional: descomente para passar argumentos para o launch incluído
            # launch_arguments={
            #    'argumento_para_outro_launch': 'valor_desse_argumento'
            # }.items()
        )
        ld.add_action(livox_driver_launch)
        # #}
        # #}

    if '--enable_d435i_front' in uav_sensors:
        # #{ realsense_front
        front_rgbd_frame = uav_name + '/front_rgbd/link'
        front_rgbd_frame_slashless = uav_name + '_' + 'front_rbgd_link'

        # #{ static_transform_publisher
        fcu_to_front_rgbd_tf_static_publisher_node = Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name='front_rbgd_tf',
            namespace=uav_name,
            name=TextSubstitution(text=fcu_frame_slashless + '_to_' front_rgbd_frame_slashless),
            arguments=['0.07', '0.0', '-0.1', '0.0', '0.0', '0.0', fcu_frame, front_rbgd_frame],
            output='screen'
        )
        ld.add_action(fcu_to_front_rgbd_tf_static_publisher_node)
        # #}

        # #{ include other launch
        front_rgbd_driver_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('realsense_camera2'),
                    'launch',
                    'rs_camera.launch.py',
                ])
            ]),
            # Opcional: descomente para passar argumentos para o launch incluído
            # launch_arguments={
            #    'argumento_para_outro_launch': 'valor_desse_argumento'
            # }.items()
        )
        ld.add_action(front_rgbd_driver_launch)
        # #}
        # #}

def x500(context: launch.LaunchContext, ld):
    uav_name = os.environ['UAV_NAME']
    uav_sensors = os.environ['UAV_SENSORS']
    uav_sensors = uav_sensors.split()

    fcu_frame = uav_name + '/fcu'
    fcu_frame_slashless = 'fcu_' + uav_name

    if '--enable_livox' in uav_sensors:
        # #{ livox
        livox_frame = uav_name + '/livox/link'
        livox_frame_slashless = uav_name + '_' + 'livox_link'

        # #{ static_transform_publisher
        fcu_to_livox_tf_static_publisher_node = Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name=TextSubstitution(text=fcu_frame_slashless + '_to_' livox_frame_slashless),
            namespace=uav_name,
            arguments=['0.0', '0.0', '0.18', '0.0', '0.0', '0.0', fcu_frame, livox_frame],
            output='screen'
        )
        ld.add_action(fcu_to_livox_tf_static_publisher_node)
        # #}

        # #{ include other launch
        livox_driver_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('livox_ros_driver2'),
                    'launch',
                    'msg_MID360_launch.py'
                ])
            ]),
        )
        ld.add_action(livox_driver_launch)
        # #}
        # #}

    if '--enable_d435i_front' in uav_sensors:
        # #{ realsense_front
        front_rgbd_frame = uav_name + '/front_rgbd/link'
        front_rgbd_frame_slashless = uav_name + '_' + 'front_rbgd_link'

        # #{ static_transform_publisher
        fcu_to_front_rgbd_tf_static_publisher_node = Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name=TextSubstitution(text=fcu_frame_slashless + '_to_' front_rgbd_frame_slashless),
            namespace=uav_name,
            arguments=['0.07', '0.0', '-0.1', '0.0', '0.0', '0.0', fcu_frame, front_rbgd_frame],
            output='screen'
        )
        ld.add_action(fcu_to_front_rgbd_tf_static_publisher_node)
        # #}

        # #{ include other launch
        front_rgbd_driver_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('realsense_camera2'),
                    'launch',
                    'rs_camera.launch.py',
                ])
            ]),
            # Opcional: descomente para passar argumentos para o launch incluído
            # launch_arguments={
            #    'argumento_para_outro_launch': 'valor_desse_argumento'
            # }.items()
        )
        ld.add_action(front_rgbd_driver_launch)
        # #}
        # #}

    if '--enable_d435i_down' in uav_sensors:
        # #{ realsense_down
        down_rgbd_frame = uav_name + '/down_rgbd/link'
        down_rgbd_frame_slashless = uav_name + '_' + 'down_rbgd_link'

        # #{ static_transform_publisher
        fcu_to_down_rgbd_tf_static_publisher_node = Node(
            package='tf2_ros',
            executable='static_transform_publisher',
            name=TextSubstitution(text=fcu_frame_slashless + '_to_' down_rgbd_frame_slashless),
            namespace=uav_name,
            arguments=['0.07', '0.0', '-0.1', '0.0', '1.57', '0.0', fcu_frame, down_rbgd_frame],
            output='screen'
        )
        ld.add_action(fcu_to_down_rgbd_tf_static_publisher_node)
        # #}

        # #{ driver_launch
        down_rgbd_driver_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('realsense_camera2'),
                    'launch',
                    'rs_camera.launch.py',
                ])
            ]),
            # Opcional: descomente para passar argumentos para o launch incluído
            # launch_arguments={
            #    'argumento_para_outro_launch': 'valor_desse_argumento'
            # }.items()
        )
        ld.add_action(down_rgbd_driver_launch)
        # #}
        # #}

def generate_launch_description():
    uav_type = os.environ['UAV_TYPE']

    ld = launch.LaunchDescription()

    if uav_type == 'x500':
        # #{ opaque function (Sua lógica original permanece)
        ld.add_action(
            OpaqueFunction(function=x500, args=[ld])
        )
        # #}
    elif uav_type == 'lr7pro':
        # #{ opaque function (Sua lógica original permanece)
        ld.add_action(
            OpaqueFunction(function=lr7pro, args=[ld])
        )
        # #}
    else:
        g_logger = launch.logging.get_logger('sensors.launch')
        g_logger.error(f"Dont't exist preset sensors configuration for this uav type: '{uav_type}'")



    return ld
