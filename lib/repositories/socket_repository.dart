import 'package:provider/provider.dart';
import 'package:skyedge/providers/socket_provider.dart';
import 'package:skyedge/utils/router_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

class SocketRepository {
  late IO.Socket socket;
  final String socketUrl;

  SocketRepository({required this.socketUrl}) {
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      debugPrint('Socket connected  ${socket.connected}');
    });

    socket.on('join', (data) {
      debugPrint('Received message: $data');
    });
    socket.on('message', (data) {
      debugPrint('Received message: $data');
    });

    socket.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });

    socket.onError((error) {
      debugPrint('Socket error: $error');
    });

    socket.connect();
  }

  void checkLevelCompleted() {}

  void joinRoom(
      {required String room,
      required int levelNumber,
      required String username}) {
    socket.emit('join',
        {'room': room, 'level_number': levelNumber, "username": username});
  }

  void sendMessage(String message,
      {required String room, required String username}) {
    socket.emit(
        'message', {"message": message, "room": room, "username": username});
  }

  void onMessageReceived(Function(dynamic) callback) {
    socket.on('message', callback);
  }

  void leaveRoom(String room, String username) {
    socket.emit('leave', {'room': room, "username": username});
  }

  void disconnect() {
    socket.disconnect();
  }

  void dispose() {
    socket.dispose();
  }
}
