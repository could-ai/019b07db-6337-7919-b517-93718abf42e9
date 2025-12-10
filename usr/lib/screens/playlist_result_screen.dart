import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/spotify_models.dart';
import 'package:couldai_user_app/services/spotify_service.dart';

class PlaylistResultScreen extends StatefulWidget {
  const PlaylistResultScreen({super.key});

  @override
  State<PlaylistResultScreen> createState() => _PlaylistResultScreenState();
}

class _PlaylistResultScreenState extends State<PlaylistResultScreen> {
  late String _prompt;
  List<SpotifyTrack> _songs = [];
  bool _isSaving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _prompt = args['prompt'] as String;
      _songs = args['tracks'] as List<SpotifyTrack>;
    } else {
      _prompt = "Your Vibe";
      _songs = [];
    }
  }

  void _saveToSpotify() async {
    setState(() => _isSaving = true);
    
    try {
      await SpotifyService().savePlaylistToLibrary("CouldAI: $_prompt", _songs);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Playlist saved to your Spotify library!'),
            backgroundColor: Color(0xFF1DB954),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDurationMs = _songs.fold(0, (sum, item) => sum + item.durationMs);
    final totalDurationMin = (totalDurationMs / 1000 / 60).round();

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
                    '${_songs.length} Songs • $totalDurationMin min',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveToSpotify,
                    icon: _isSaving 
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) 
                      : const Icon(Icons.save_alt, size: 18),
                    label: Text(_isSaving ? 'Saving...' : 'Save to Spotify'),
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
                    child: song.album.images.isNotEmpty 
                      ? Image.network(song.album.images.first.url, fit: BoxFit.cover)
                      : const Icon(Icons.music_note, color: Colors.white54),
                  ),
                  title: Text(
                    song.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    song.artistNames,
                    style: const TextStyle(color: Color(0xFFB3B3B3)),
                  ),
                  trailing: Text(
                    song.durationFormatted,
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
