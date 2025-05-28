import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/my_text_form_field.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/repositories/socket_repository.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/router_util.dart';
import 'package:uuid/uuid.dart';
import '../../../providers/socket_provider.dart';

class LifeStyleChat extends StatefulWidget {
  final int levelNumber;

  const LifeStyleChat({
    super.key,
    required this.levelNumber,
  });

  @override
  State<LifeStyleChat> createState() => _LifeStyleChatState();
}

class _LifeStyleChatState extends State<LifeStyleChat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool chatEnd = false;

  // Helper function to decode message
  Map<String, String> parseCustomData(String input) {
    input = input.trim();
    if (input.startsWith('{') && input.endsWith('}')) {
      input = input.substring(1, input.length - 1);
    }

    const usernameKey = 'username:';
    const messageKey = 'message:';

    final usernameIndex = input.indexOf(usernameKey);
    final messageIndex = input.indexOf(messageKey);

    if (usernameIndex == -1 || messageIndex == -1) {
      throw const FormatException("Invalid format: missing keys");
    }

    final usernameValue = input
        .substring(usernameIndex + usernameKey.length, messageIndex)
        .trim()
        .replaceAll(RegExp(r'^,|,$'), '');

    final messageValue = input
        .substring(messageIndex + messageKey.length)
        .trim()
        .replaceAll(RegExp(r'^,|,$'), '');

    return {
      'username': usernameValue,
      'message': messageValue,
    };
  }

  void _joinRoom() {
    final authProvider = context.read<AuthProvider>();
    String uuid = Uuid().v4();
    final username = authProvider.userModel.username;
    final socketProv = context.read<SocketProvider>();
    socketProv.initializeSocketListeners();
    socketProv.joinRoom(
        room: uuid,
        levelNumber: widget.levelNumber,
        username: username ?? "unknown-user");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _joinRoom();
      _checkEndChatCondition();
    });
  }

  void _checkEndChatCondition() {
    // final socketProv = context.read<SocketProvider>();
    // final lastMessage = socketProv.messages.isNotEmpty
    //     ? socketProv.messages.last.toString()
    //     : "";

    // if ((lastMessage.toLowerCase().contains("hi") ||
    //         lastMessage.toLowerCase().contains("hello")) &&
    //     !socketProv.chatEnd) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     endChat(context);
    //   });
    // }
  }

  void endChat(BuildContext cxt, {direct}) async {
    final socketProv = Provider.of<SocketProvider>(context, listen: false);
    if (!socketProv.chatEnd) {
      debugPrint("can end chat from here :\${socketProv.chatEnd}");
      socketProv.endChat();
      socketProv.leaveRoom();
      socketProv.disconnectSocket();
      await Future.delayed(Duration(seconds: 2));
      // if (mounted) {
      // setState(() {});

      cxt.pushReplacement(AppRoutes.questionnaireCompletionScreen);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final username = authProvider.userModel.username;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Consumer<SocketProvider>(
              builder: (context, socketProvider, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _checkEndChatCondition();
                  _scrollToBottom();
                });
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: socketProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = socketProvider.messages[index];
                    final data = parseCustomData(message.toString());
                    final isAi = data['username'] != username;

                    // Optional regex-based filter for system messages
                    final shouldIgnore = RegExp(
                      r'You answered \d+ out of 15 questions and earned \[\d+ × 10\] tokens',
                    ).hasMatch(data['message'] ?? '');
                    if (shouldIgnore) return const SizedBox.shrink();

                    return Row(
                      children: [
                        if (!isAi)
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: !isAi
                                  ? AppTheme.primaryColorLight.withOpacity(0.2)
                                  : Colors.transparent,
                              border: Border.all(
                                  color: !isAi
                                      ? AppTheme.primaryColorLight
                                      : Colors.grey),
                            ),
                            child: Text(data['message'] ?? ""),
                          ),
                        ),
                        if (isAi)
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    controller: _messageController,
                    hintText: "Type a message...",
                    // suffixWidget: IconButton(
                    //   icon: const Icon(Icons.send),
                    //   onPressed: () {},
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SubmitButton(
                  onTap: () {
                    // validateAndProceed(context);
                    endChat(context);
                  },
                  labelsize: 13,
                  isAtBottom: true,
                  color: Colors.transparent,
                  labelColor: AppTheme.blacktextColor(context),
                  label: "Skip Level",
                ),
              ),
              Expanded(
                child: SubmitButton(
                  onTap: () {
                    // validateAndProceed(context);
                    if (_messageController.text.isNotEmpty) {
                      context
                          .read<SocketProvider>()
                          .sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                  labelsize: 13,
                  iconAtFront: false,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 18,
                  ),
                  isAtBottom: true,
                  label: "Send",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
