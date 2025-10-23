import launch
import yaml

from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, OpaqueFunction
from launch.actions import ExecuteProcess
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution, TextSubstitution
from launch_ros.substitutions import FindPackageShare

def launch_setup(context: launch.LaunchContext, ld):
    # #{ start uxrce protocol
    uxrce_script_cmd = ExecuteProcess(
        cmd=["sudo" ,"MicroXRCEAgent", "serial", "--dev", "/dev/pixhawk", "-b", "921600"],
        name="uxrce_protocol",
        output='screen'
    )
    # #}

    ld.add_action(uxrce_script_cmd)

def generate_launch_description():
    ld = launch.LaunchDescription()

    # #{ opaque function

    ld.add_action(
        OpaqueFunction(function=launch_setup, args=[ld])
    )

    # #}

    return ld
