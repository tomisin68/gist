import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gist/comments.dart';
import 'package:gist/story_view.dart';
import 'create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreenContent(),
    const Center(child: Text("Search Page", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Notifications", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Profile", style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Hi, Sam", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              // Add video call functionality here
              print("Video icon tapped");
            },
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
              // Add messaging functionality here
              print("Message icon tapped");
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: Colors.purple.shade700,
        height: 60,
        index: _selectedIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostPage()),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final List<Map<String, String>> dummyPosts = [
    {"username": "Alice", "content": "Loving the new Flutter updates! 🚀🔥", "image": "assets/dubai.jpg", "profile": "assets/woman.jpg"},
    {"username": "Bob", "content": "Just had the best coffee ☕️. Check out this café!", "image": "assets/hangout.jpg", "profile": "assets/man.jpg"},
    {"username": "Charlie", "content": "Can't believe how fast this year is going by! 😱", "image": "assets/beach.jpg", "profile": "assets/people.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStoriesSection(context),
        Expanded(
          child: ListView.builder(
            itemCount: dummyPosts.length,
            itemBuilder: (context, index) {
              return _buildPostCard(
                  context,
                  dummyPosts[index]["username"]!,
                  dummyPosts[index]["content"]!,
                  dummyPosts[index]["image"]!,
                  dummyPosts[index]["profile"]!,
                  index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoriesSection(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildStoryBubble(context, index);
        },
      ),
    );
  }

  Widget _buildStoryBubble(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryViewPage(username: 'Example user', imageUrl: 'assets/setup.jpg',)),
              );
            },
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.purple.shade700,
                image: index == 0
                    ? null
                    : const DecorationImage(
                        image: AssetImage("assets/setup.jpg"),
                        fit: BoxFit.cover,
                      ),
              ),
              child: index == 0
                  ? const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 40),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 5),
          Text(index == 0 ? "Your Story" : "User", style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  final List<bool> _isLikedList = [false, false, false];
  final List<bool> _isSavedList = [false, false, false];
  final List<int> _likeCounts = [0, 0, 0];

  void _toggleLike(int index) {
    setState(() {
      _isLikedList[index] = !_isLikedList[index];
      if (_isLikedList[index]) {
        _likeCounts[index]++;
      } else {
        _likeCounts[index]--;
      }
    });
  }

  void _toggleSave(int index) {
    setState(() {
      _isSavedList[index] = !_isSavedList[index];
    });
  }

  Widget _buildPostCard(
      BuildContext context, String username, String content, String image, String profile, int index) {
    bool isLiked = _isLikedList[index];
    bool isSaved = _isSavedList[index];
    int likeCount = _likeCounts[index];
    IconData likeIcon = isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined;
    IconData saveIcon = isSaved ? Icons.bookmark : Icons.bookmark_border;

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profile),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(username, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Text("2h ago", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            Text(content, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image, fit: BoxFit.cover, width: double.infinity, height: 200),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(
                    likeIcon, "Like", () => _toggleLike(index), likeCount),
                IconButton(
                  icon: const Icon(Icons.chat_bubble, color: Colors.white70),
                  tooltip: "Comment",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommentsPage(postId: '',)),
                    );
                  },
                ),
                _buildIconButton(
                  Icons.share,
                  "Share",
                  () {
                    // Add your share functionality here
                  },
                  null,
                ),
                _buildIconButton(saveIcon, "Save", () => _toggleSave(index), null),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, String tooltip, VoidCallback onTap, int? count) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white70),
          tooltip: tooltip,
          onPressed: onTap,
        ),
        if (count != null) Text('$count', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}