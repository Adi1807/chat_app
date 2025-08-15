import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/views/message_box.dart';
import 'package:chat_app/views/message_box_container.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: 'm1',
      userId: 'virat',
      username: 'Virat Sharma',
      avatarUrl: 'https://ui-avatars.com/api/?name=Alice+Johnson',
      // text: 'Hey team — I pushed the UI changes. Can someone review?',
      text: "Hello Rohit",
      time: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    ChatMessage(
      id: 'm2',
      userId: 'virat',
      username: 'Virat Sharma',
      avatarUrl: 'https://ui-avatars.com/api/?name=Alice+Johnson',
      // text: 'Also added a small README for setup.',
      text: "How are you?",
      time: DateTime.now().subtract(const Duration(minutes: 11)),
    ),
    // ChatMessage(
    //   id: 'm3',
    //   userId: 'bob',
    //   username: 'Bob Lee',
    //   avatarUrl: 'https://i.pravatar.cc/150?img=3',
    //   text: 'Nice! I will take a look now.',
    //   time: DateTime.now().subtract(const Duration(minutes: 8)),
    // ),
    ChatMessage(
      id: 'm3',
      userId: 'you',
      username: 'You',
      avatarUrl: '',
      // text: 'Thanks — I\'ll test on web and report any issues.',
      text: "Hello Virat",
      time: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      id: 'm4',
      userId: 'you',
      username: 'You',
      avatarUrl: '',
      // text: 'Thanks — I\'ll test on web and report any issues.',
      text: "I am fine. How are you?",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatMessage(
      id: 'm5',
      userId: 'you',
      username: 'You',
      avatarUrl: '',
      // text: 'Thanks — I\'ll test on web and report any issues.',
      text:
          "I am fine. Please check the document I have attached here. Please update it according to your need.",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
      fileName: "Project_Plan_Final_Review.pdf",
      fileSize: "2.4 MB",
    ),
    ChatMessage(
      id: 'm6',
      userId: 'alice',
      username: 'Alice Johnson',
      avatarUrl: 'https://ui-avatars.com/api/?name=Alice+Johnson',
      // text: 'Thanks — I\'ll test on web and report any issues.',
      text:
          "Yes, I have attached the updated document here. You can check and let me know if need any change",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
      fileName: "Project_Plan_Final_Review.pdf",
      fileSize: "3.7 MB",
    ),
    // ChatMessage(
    //   id: 'm7',
    //   userId: 'alice',
    //   username: 'Alice Johnson',
    //   avatarUrl: 'https://ui-avatars.com/api/?name=Alice+Johnson',
    //   // text: 'Thanks — I\'ll test on web and report any issues.',
    //   text:
    //       "If you want, I can now also add timestamps and username labels above each bubble just like style. \n"
    //       "That way it will look almost identical to  UI.",
    //   time: DateTime.now().subtract(const Duration(minutes: 3)),
    //   fileName: "Project_Plan_Very_Long_File_Name_Version_3_Final_Review.pdf",
    //   fileSize: "2.4 MB",
    // ),
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final msg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'you',
      username: 'You',
      avatarUrl: '',
      text: text,
      time: DateTime.now(),
    );
    setState(() {
      _messages.add(msg);
    });
    _controller.clear();

    // scroll to bottom after a short delay so list updates
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.4,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF8F8F8),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final prev = index > 0 ? _messages[index - 1] : null;
                    final showHeader =
                        prev == null || prev.userId != msg.userId;
                    final isMe = msg.userId == 'you';
                    return MessageBoxContainer(
                      child: MessageBox(
                        username: msg.username,
                        text: msg.text,
                        time: _formatTime(msg.time),
                        avatarUrl: msg.avatarUrl,
                        showHeader: showHeader,
                        isMe: isMe,
                        isFile: msg.isFile,
                        filename: msg.fileName,
                        filesize: msg.fileSize,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Divider
          Container(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
          // Input bar
          SafeArea(child: _buildInputBar()),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F8),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 140),
                      child: Scrollbar(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Attach file',
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file, size: 20),
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ampm = t.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }
}
