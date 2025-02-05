import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  const CommentsPage({super.key, required this.postId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  void addComment(String text) {
    setState(() {
      comments.add({
        "user": "User Name", 
        "text": text,
        "likes": 0,
        "replies": []
      });
    });
    _commentController.clear();
  }

  void likeComment(int index) {
    setState(() {
      comments[index]["likes"] += 1;
    });
  }

  void addReply(int index, String reply) {
    setState(() {
      comments[index]["replies"].add({"user": "User Name", "text": reply});
    });
  }

  void shareComment(String commentText) {
    // Implement sharing functionality
  }

  void saveComment(String commentText) {
    // Implement saving functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Comments"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(comments[index]["user"],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.favorite_border, color: Colors.white70),
                                  onPressed: () => likeComment(index),
                                ),
                                Text("${comments[index]["likes"]}", style: const TextStyle(color: Colors.white)),
                                IconButton(
                                  icon: const Icon(Icons.reply, color: Colors.white70),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Reply to Comment"),
                                        content: TextField(
                                          onSubmitted: (value) {
                                            addReply(index, value);
                                            Navigator.pop(context);
                                          },
                                          decoration: const InputDecoration(hintText: "Type your reply"),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.white70),
                                  onPressed: () => shareComment(comments[index]["text"]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.bookmark_border, color: Colors.white70),
                                  onPressed: () => saveComment(comments[index]["text"]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(comments[index]["text"], style: const TextStyle(color: Colors.white)),
                        if (comments[index]["replies"].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: comments[index]["replies"].map<Widget>((reply) {
                                return Text("${reply["user"]}: ${reply["text"]}",
                                    style: const TextStyle(color: Colors.white70, fontSize: 12));
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey[900], boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 5)]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Write a comment...",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.purple),
                  onPressed: () => addComment(_commentController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
