import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Messages"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Dummy conversations
        itemBuilder: (context, index) {
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const Positioned(
                  bottom: 2,
                  right: 2,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.green, // Online indicator
                  ),
                ),
              ],
            ),
            title: Text("User $index", style: const TextStyle(color: Colors.white)),
            subtitle: const Text("Last message preview...", style: TextStyle(color: Colors.white70)),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("10:45 PM", style: TextStyle(color: Colors.white54, fontSize: 12)),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.purple,
                  child: Text("2", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen(username: "User $index")),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String username;
  const ChatScreen({super.key, required this.username});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [
    {"text": "Hey!", "isMe": false, "read": true},
    {"text": "How are you?", "isMe": true, "read": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(icon: const Icon(Icons.call, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg["isMe"] ? Colors.purple : Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg["text"], style: const TextStyle(color: Colors.white)),
                        if (msg["isMe"]) ...[
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: msg["read"] ? Colors.blue : Colors.white, size: 16),
                              if (msg["read"]) const Icon(Icons.check, color: Colors.blue, size: 16),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[900],
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.emoji_emotions, color: Colors.white70), onPressed: () {}),
                const Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.mic, color: Colors.white70), onPressed: () {}),
                IconButton(icon: const Icon(Icons.send, color: Colors.purple), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
