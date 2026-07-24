import subprocess

import yaml
from launch_ros.actions import Node
from launch_ros.substitutions import FindPackageShare

import launch
from launch.actions import DeclareLaunchArgument
from launch.actions import ExecuteProcess
from launch.actions import IncludeLaunchDescription
from launch.actions import OpaqueFunction
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch.substitutions import PathJoinSubstitution
from launch.substitutions import TextSubstitution


def check_if_agent_is_running():
    process_filter = "micro_ros_agent"
    cmd = ["ps", "aux"]
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    output_lines = result.stdout.splitlines()

    for line in output_lines:
        if process_filter.lower() in line.lower() and "grep" not in line:
            return True

    return False


def launch_setup(context: launch.LaunchContext, ld):

    # #{ serial_port
    serial_port = LaunchConfiguration("serial_port")
    # #}

    if not check_if_agent_is_running():
        # #{ start micro-ros-agent
        micro_ros_cmd = Node(
            package="micro_ros_agent",
            executable="micro_ros_agent",
            name="micro_ros_agent",
            output="screen",
            arguments=[
                "serial",
                "-v4",
                "-b",
                "115200",
                "-D",
                serial_port.perform(context),
            ],
        )
        # #}

        ld.add_action(micro_ros_cmd)
    else:
        print("Info: The micro_ros_agent is already running.")


def generate_launch_description():
    ld = launch.LaunchDescription()

    # #{ serial_port
    ld.add_action(
        DeclareLaunchArgument(
            "serial_port",
            default_value="/dev/fcu",
            description="Serial port to connect with flight controller.",
        )
    )
    # #}

    # #{ opaque function

    ld.add_action(OpaqueFunction(function=launch_setup, args=[ld]))

    # #}

    return ld
