import 'package:access_control/src/data/message/stantard_mqttclient.data.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MessageClient {

  // static MqttServerClient sharedMqttClient = MqttServerClient.withPort(MQTTClientData.url, MQTTClientData.password, MQTTClientData.port);
  static MessageClient shared = MessageClient();
  late String mqttUrl;
  late int mqttPort;
  late String mqttClientID;
  late MqttServerClient mqttClient;

  MqttServerClient toMqttServerClient({
    required String url,
    required String clientID,
    required int port,
  }) {
    shared.mqttClientID = clientID;
    shared.mqttUrl = url;
    shared.mqttPort = port;
    MqttServerClient client = MqttServerClient.withPort(url, clientID, port);
    client.logging(on: true);
    client.secure = false;
    shared.mqttClient = client;
    return client;
  }
}