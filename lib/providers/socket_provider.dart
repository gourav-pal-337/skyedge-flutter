import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/utils/router_util.dart';

import '../repositories/socket_repository.dart';
import '../network/api_endpoints.dart';

class SocketProvider extends ChangeNotifier {
  late SocketRepository _socketRepository;
  bool _isConnected = false;
  bool chatEnd = false;

  String _roomId = "";
  String _username = "";
  List<String> _messages = [];
  int levelNumber = 1;

  SocketProvider() {
    // _initializeSocketListeners();
  }

  bool get isConnected => _isConnected;
  List<String> get messages => _messages;

  void initializeSocketListeners() {
    debugPrint(
        'Initializing SocketProvider with URL: ${Endpoints.chatSocketApi}');
    _socketRepository = SocketRepository(socketUrl: Endpoints.chatSocketApi);

    _messages = [];
    chatEnd = false;
    notifyListeners();
    debugPrint('Initializing socket listeners');
    _socketRepository.onMessageReceived((data) {
      debugPrint('New message received in provider: $data');
      _messages.add(data.toString());

      notifyListeners();
      // endChat(context, data.toString());
    });
  }

  void joinRoom(
      {required String room,
      required int levelNumber,
      required String username}) {
    debugPrint('Provider: Joining room $room with level $levelNumber');
    _roomId = room;
    _username = username;
    notifyListeners();
    _socketRepository.joinRoom(
        room: room, levelNumber: levelNumber, username: username);
  }

  void sendMessage(String message) {
    debugPrint('Provider: Sending message: $message');
    _socketRepository.sendMessage(message, room: _roomId, username: _username);
  }

  void leaveRoom() async {
    debugPrint('Provider: Leaving room $_roomId');
    await Future.delayed(const Duration(seconds: 2));
    _socketRepository.leaveRoom(_roomId, _username);
    disconnectSocket();
  }

  void endChat() async {
    chatEnd = true;
    // levelNumber += 1;
    notifyListeners();
    // debugPrint("User left chat");
    leaveRoom();
    disconnectSocket();
    // if (cxt != null) {
    //   await Future.delayed(const Duration(milliseconds: 500));
    //   if (cxt != null) {
    //     await cxt.push(AppRoutes.questionnaireCompletionScreen);
    //     if (cxt != null) {
    //       cxt.push(AppRoutes.questionnaireScreen);
    //     }
    //   }
    // } else {
    //   debugPrint("key not found...");
    // }
  }

  void disconnectSocket() async {
    debugPrint('Disposing SocketProvider');

    _socketRepository.disconnect();
    _isConnected = false;
    _roomId = "";
    _username = "";

    notifyListeners();
  }

  void updateLevet(int level, {bool force = false}) {
    if (force) {
      levelNumber = level;
      notifyListeners();
      return;
    }
    if (levelNumber < 1) {
      levelNumber = level;
      notifyListeners();
    }
  }

  // @override
  // void dispose() {
  //   debugPrint('Disposing SocketProvider');
  //   _socketRepository.dispose();
  //   super.dispose();
  // }
}
