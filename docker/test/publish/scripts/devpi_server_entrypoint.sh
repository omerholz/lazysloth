#!/bin/bash

# Path to a file that indicates that the setup has already been done
SETUP_DONE="/var/setup_done"
CONTAINER_READY="/tmp/container_ready"

# Start the server in the background
start_server_background() {
    # Start your server in the background
    devpi-server --host 0.0.0.0 &
    # Save the background server's PID
    SERVER_PID=$!
}

# Perform the setup while the server is running
perform_setup() {
    devpi use http://localhost:3141
    devpi user -c $USER_NAME password=$USER_PASSWORD
    devpi login $USER_NAME --password $USER_PASSWORD
    devpi index -c $USER_INDEX bases=root/pypi
    devpi use $USER_NAME/$USER_INDEX
}


# Check if the setup has already been done
if [ ! -f "$SETUP_DONE" ]; then
    echo "First time setup. Running setup commands..."

    start_server_background
    sleep 10 # Wait for server to fully start before setup
    perform_setup

    # Indicate that setup has been done
    touch "$SETUP_DONE"
    touch "$CONTAINER_READY"

    # Wait for the background server process to prevent the script from exiting
    # and turning the container off
    wait $SERVER_PID
else
    # Start the server normally
    touch "$CONTAINER_READY"
    devpi-server --host 0.0.0.0
fi
