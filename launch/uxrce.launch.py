import launch
import yaml
import subprocess

from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, OpaqueFunction
from launch.actions import ExecuteProcess
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution, TextSubstitution
from launch_ros.substitutions import FindPackageShare

def check_if_uxrce_is_running:
    process_filter = "MicroXRCEAgent"
    cmd = ['ps', 'aux']
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)    
    output_lines = result.stdout.splitlines()
        
    for line in output_lines:
        if process_filter.lower() in line.lower() and 'grep' not in line:
            return True
                
    return False

def launch_setup(context: launch.LaunchContext, ld):

    # #{ serial_port
    serial_port = LaunchConfiguration('serial_port')
    # #}

    if(check_if_uxrce_is_running()):
        # #{ start uxrce protocol
        uxrce_script_cmd = ExecuteProcess(
            cmd=["sudo" ,"MicroXRCEAgent", "serial", "--dev", serial_port.perform(context), "-b", "2000000"],
            name="uxrce_protocol",
            output='screen'
        )
        # #}

        ld.add_action(uxrce_script_cmd)
    else:
        print(f"Info: The MicroXRCEAgent already is running.")


def generate_launch_description():
    ld = launch.LaunchDescription()

    # #{ serial_port
    ld.add_action(DeclareLaunchArgument(
        'serial_port',
        default_value='/dev/pixhawk',
        description='Serial port to connect with fly controller.'
    ))
    # #}

    # #{ opaque function

    ld.add_action(
        OpaqueFunction(function=launch_setup, args=[ld])
    )

    # #}

    return ld
