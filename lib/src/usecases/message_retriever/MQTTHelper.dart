
import 'package:mqtt_client/mqtt_client.dart';

class MQTTHelper {
  static Function onConnected = () => print("Connected");
  static Function onDisconnected = () => print("Disconnected");
  static Function onSubbed = (String string) => print("Subbed $string");
  static Function onSubbedFail = (String string) => print("Subbed fail $string");
  static Function on = () => print("on");
  static Function pong = () => print("pong");
  static void Function(List<MqttReceivedMessage<MqttMessage>>) messageHandler = (List<MqttReceivedMessage<MqttMessage>> messages) {
    final MqttPublishMessage receivedMessage = messages[0].payload as MqttPublishMessage;
    final String message = MqttPublishPayload.bytesToString(receivedMessage.payload.message);
    print(message);
  };
}