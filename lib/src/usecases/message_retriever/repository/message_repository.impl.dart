
import 'dart:async';

import 'package:access_control/src/data/message/stantard_mqttclient.data.dart';
import 'package:access_control/src/usecases/message_retriever/repository/message_client.dart';
import 'package:access_control/src/usecases/message_retriever/repository/message_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MessageRepositoryImpl implements MessageRepository {
  @override
  MessageClient messageClient = MessageClient.shared;

  @override
  late Function on;

  @override
  late void Function() onConnected;

  @override
  late void Function() onDisconnected;

  @override
  late void Function(String p1) onSubscribed;

  @override
  late void Function(String p1) onSubscribedFail;

  @override
  String? password = MQTTClientData.password;

  @override
  late void Function() pong;

  @override
  StreamSubscription? streamSubscription;

  @override
  String? username = MQTTClientData.user;

  @override
  String get clientID => MQTTClientData.clientID;

  @override
  int get port => MQTTClientData.port;

  @override
  String get url => MQTTClientData.url;

  @override
  Future<MqttServerClient> mqttClient({required void Function(List<MqttReceivedMessage<MqttMessage>> p1) messageHandler}) async {
    var client = this.messageClient.toMqttServerClient(url: this.url, clientID: this.clientID, port: this.port);
    client.keepAlivePeriod = 60;
    client.onConnected = this.onConnected;
    client.onDisconnected = this.onDisconnected;
    client.onSubscribed = this.onSubscribed;
    client.onSubscribeFail = this.onSubscribedFail;
    client.pongCallback = this.pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs(this.username, this.password)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .withClientIdentifier(this.clientID);

    client.connectionMessage = connMessage;
    try {
      await client.connect();
      client.subscribe('endpoint', MqttQos.atLeastOnce);
    }
    catch (e){
      print("Error: $e");
      client.disconnect();
    }
    streamSubscription = client.updates?.listen(messageHandler);
    return client;
  }

}