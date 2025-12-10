import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/song_model.dart';

class PlaylistResultScreen extends StatefulWidget {
  const PlaylistResultScreen({super.key});

  @override
  State<PlaylistResultScreen> createState() => _PlaylistResultScreenState();
}

class _PlaylistResultScreenState extends State<PlaylistResultScreen> {
  late String _prompt;
  final List<Song> _songs = [
    Song(title: "Midnight City", artist: "M83", duration: "4:03", imageUrl: "assets/album1.jpg"),
    Song(title: "Starboy", artist: "The Weeknd", duration: "3:50", imageUrl: "assets/album2.jpg"),
    Song(title: "Nightcall", artist: "Kavinsky", duration: "4:18", imageUrl: "assets/album3.jpg"),
    Song(title: "Instant Crush", artist: "Daft Punk", duration: "5:37", imageUrl: "assets/album4.jpg"),
    Song(title: "Resonance", artist: "Home", duration: "3:32", imageUrl: "assets/album5.jpg"),
    Song(title: "Blinding Lights", artist: "The Weeknd", duration: "3:20", imageUrl: "assets/album2.jpg"),
    Song(title: "Tech Noir", artist: "Gunship", duration: "4:57", imageUrl: "assets/album6.jpg"),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _prompt = args is String ? args : "Your Vibe";
  }

  void _saveToSpotify() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Playlist saved to your Spotify library!'),
        backgroundColor: Color(0xFF1DB954),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF121212),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _prompt.length > 20 ? '${_prompt.substring(0, 20)}...' : _prompt,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple.shade900,
                      const Color(0xFF121212),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_songs.length} Songs • 45 min',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  ElevatedButton.icon(
                    onPressed: _saveToSpotify,
                    icon: const Icon(Icons.save_alt, size: 18),
                    label: const Text('Save to Spotify'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = _songs[index];
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[800],
                    child: const Icon(Icons.music_note, color: Colors.white54),
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(color: Color(0xFFB3B3B3)),
                  ),
                  trailing: Text(
                    song.duration,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    // Play preview logic would go here
                  },
                );
              },
              childCount: _songs.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
