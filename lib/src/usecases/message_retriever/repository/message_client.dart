import 'package:mqtt_client/mqtt_server_client.dart';

class MessageClient {

  MqttServerClient toMqttServerClient({
    required String url,
    required String clientID,
    required int port,
  }) {
    MqttServerClient client = MqttServerClient.withPort(url, clientID, port);
    client.logging(on: true);
    client.secure = false;
    return client;
  }
}