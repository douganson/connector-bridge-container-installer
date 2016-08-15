This is the installation script that can pull down and start the mbed Connector bridge.

Usage:

   get_bridge.sh [watson | iothub | aws | generic-mqtt]

Arguments:

   watson - instantiate a bridge for Watson IoT

   iotub - instantiate a bridge for Microsoft IoTHub

   aws - instantiate a bridge for AWS IoT

   generic-mqtt - instantiate a bridge for a generic MQTT broker such as Mosquitto

Once completed, the selected bridge runtime will be running. You can then:

1). Open a Browser

2). Navigate to: https://<IP address of your bridge>:8234

2a). Accept the self-signed certificate

3). Default username: admin, pw: admin

4). Complete the configuration of the bridge. After entering a given value, press "Save" before editing the next value... When all values are entered and "Saved", press "Restart"

NOTE: Each bridge runtime also has "ssh" (default port: 2222) installed so that you can ssh into the runtime and tinker with it. The default username is "arm" and password "arm1234"

Enjoy!
