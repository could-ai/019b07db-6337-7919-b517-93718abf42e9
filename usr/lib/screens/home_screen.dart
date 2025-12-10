import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Evening'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureCard(
              context,
              title: 'AI Vibe Analysis',
              description: 'Generate a playlist based on your current mood or activity.',
              icon: Icons.auto_awesome,
              color: Colors.purpleAccent,
              onTap: () => Navigator.pushNamed(context, '/analyze'),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              context,
              title: 'Sonic Match',
              description: 'Find songs that sound like your favorites using AI.',
              icon: Icons.graphic_eq,
              color: Colors.blueAccent,
              onTap: () => Navigator.pushNamed(context, '/analyze'),
            ),
            const SizedBox(height: 32),
            Text(
              'Recent AI Mixes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildRecentMixList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF282828),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB3B3B3),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentMixList() {
    final mixes = [
      {'title': 'Late Night Drive', 'date': '2 hours ago', 'color': Colors.indigo},
      {'title': 'Workout Energy', 'date': 'Yesterday', 'color': Colors.orange},
      {'title': 'Rainy Jazz', 'date': '2 days ago', 'color': Colors.blueGrey},
    ];

    return Column(
      children: mixes.map((mix) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF181818),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (mix['color'] as Color).withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.music_note, color: Colors.white70),
            ),
            title: Text(
              mix['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Generated ${mix['date']}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF1DB954)),
          ),
        );
      }).toList(),
    );
  }
}
