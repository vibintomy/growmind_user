import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:growmind/features/chat/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:growmind/features/home/domain/entities/notification_entities.dart';
import 'package:growmind/features/home/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/notification_bloc/notification_event.dart';
import 'package:intl/intl.dart';

class MessagePage extends HookWidget {
  final String name;
  final String imageUrl;
  final String receiverId;

  const MessagePage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final scrollController = useScrollController();

    final chatStateListener = useState<ChatState?>(null);
    
    useEffect(() {
      final userId = FirebaseAuth.instance.currentUser;
      context.read<ChatBloc>().add(LoadMessages(receiverId, userId!.uid));
      context.read<NotificationBloc>().add(SubscribeToUserTopic(userId.uid));
      return null;
    }, []);

    void scrollToBottom() {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0, // Since we're using reverse: true, 0 is the bottom of the list
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    void sendMessage() {
      final userId = FirebaseAuth.instance.currentUser;
      final text = messageController.text.trim();
      if (text.isNotEmpty) {
        final message = Message(
          senderId: userId!.uid,
          receiverId: receiverId,
          timeStamp: DateTime.now(),
          message: text,
        );

        context.read<ChatBloc>().add(SendMessages(message));
        final notification = NotificationEntities(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            body: text,
            title: "New message from ${userId.displayName ?? 'User'}",
            receiverId: receiverId,
            data: {'type': message, 'messageId': message.id},
            senderId: userId.uid,
            timeStamp: DateTime.now());
      
        context.read<NotificationBloc>().add(SendNotification(notification));
        
        messageController.clear();
        
       
        scrollToBottom();
      }
    }

    String formatMessageDate(DateTime date) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final messageDate = DateTime(date.year, date.month, date.day);

      if (messageDate == today) {
        return "Today";
      } else if (messageDate == yesterday) {
        return "Yesterday";
      } else {
        return DateFormat('MMMM d, y').format(date);
      }
    }

  
    bool shouldShowDateHeader(List<Message> messages, int index) {
      if (index == messages.length - 1) {
      
        return true;
      }
      
      final currentMessage = messages[index];
      final previousMessage = messages[index + 1]; 
      
      final currentDate = DateTime.parse(currentMessage.timeStamp.toString());
      final previousDate = DateTime.parse(previousMessage.timeStamp.toString());
      
      return currentDate.day != previousDate.day || 
             currentDate.month != previousDate.month || 
             currentDate.year != previousDate.year;
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            kwidth,
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
        
          if (state is ChatLoaded && (chatStateListener.value == null || 
             (chatStateListener.value is ChatLoaded && 
              (chatStateListener.value as ChatLoaded).message.length != state.message.length))) {
            scrollToBottom();
          }
          chatStateListener.value = state;
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatLoaded) {
            final messages = state.message;

            return Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo/download.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == receiverId;
                    final showDateHeader = shouldShowDateHeader(messages, index);
                    final messageDate = DateTime.parse(message.timeStamp.toString());

                    return Column(
                      children: [
                        if (showDateHeader)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              formatMessageDate(messageDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        Align(
                          alignment:
                              isMe ? Alignment.centerLeft : Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.grey[300] : mainColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message.message,
                                  style: TextStyle(
                                    color: isMe ? Colors.black : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat.Hm().format(messageDate),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isMe ? Colors.black54 : Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('No messages found'),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onSubmitted: (_) => sendMessage(),
                ),
              ),
              kwidth,
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: textColor, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, color: mainColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}