This is the installation script that can pull down and start the mbed Connector bridge.

Usage:

   get_bridge.sh [watson | iothub | aws | generic-mqtt | generic-mqtt-getstarted {use-long-polling}]

Arguments:

   watson - instantiate a bridge for Watson IoT

   iotub - instantiate a bridge for Microsoft IoTHub

   aws - instantiate a bridge for AWS IoT

   generic-mqtt - instantiate a bridge for a generic MQTT broker such as Mosquitto
 
   generic-mqtt-getstarted - Like "generic-mqtt" but also has embedded Mosquitto and NodeRED built in by default

   OPTION: add "use-long-polling" if the bridge is to be operated behind a NAT were TCP port 28520 is not passed through to the docker host running the bridge image.

NOTE: In order to use this script, you will need:

    - either macOS or Ubuntu environment with a docker runtime installed and operational by the user account
    
    - a DockerHub account created

Once completed, the selected bridge runtime will be running (though unconfigured...). You must then:

1). Open a Browser

2). Navigate to: https://<IP address of your bridge>:8234

2a). Accept the self-signed certificate

3). Default username: admin, pw: admin

4). Complete the configuration of the bridge. After entering a given value, press "Save" before editing the next value... When all values are entered and "Saved", press "Restart"

NOTE: Each bridge runtime also has "ssh" (default port: 2222) installed so that you can ssh into the runtime and tinker with it. The default username is "arm" and password "arm1234"

NOTE: For the "getstarted" option, there is a NODEFLOW-getstarted.txt file that you can copy and paste into your NodeRED runtime located at http://<macOS or ubuntu host IP address>:2880 ... simply import and Deploy... You can then load and run the K64F sample https://github.com/ARMmbed/mbed-ethernet-sample-withdm and interact with it via the imported flow (you must change your MBED_ENDPOINT_NAME in both the endpoint code as well as the NODEFLOW nodes...)

NOTE: for the test scripts, I've had issues with paho-mqtt v1.2. Try v1.1... seems to work better.

NOTE: ./remove_bridge.sh removes the bridge if desired... it also removes the downloaded docker image

NOTE (macos): Docker on MacOS uses virtualbox which pins the default IP address to 192.168.99.100. If you happen to change this in your installation of Docker on MacOS, you will need to edit get_bridge.sh and adjust accordingly.

Enjoy!
