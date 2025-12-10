import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isAnalyzing = false;
  String _loadingText = 'Initializing AI...';

  void _startAnalysis() async {
    if (_promptController.text.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _loadingText = 'Analyzing prompt semantics...';
    });

    // Simulate AI stages
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _loadingText = 'Scanning Spotify library...');
    
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _loadingText = 'Matching audio features...');
    
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _loadingText = 'Curating perfect flow...');

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pushReplacementNamed(
        context, 
        '/playlist_result', 
        arguments: _promptController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New AI Playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _isAnalyzing
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        color: Color(0xFF1DB954),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      _loadingText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please wait while we craft your mix',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Describe the vibe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tell the AI what you want to hear. Be specific about mood, genre, or activity.',
                    style: TextStyle(color: Color(0xFFB3B3B3)),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _promptController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'e.g., "Upbeat synthwave for coding at night" or "Sad acoustic songs for a rainy Sunday"',
                      hintStyle: const TextStyle(color: Color(0xFF535353)),
                      filled: true,
                      fillColor: const Color(0xFF282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Suggested Tags',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTag('Chill'),
                      _buildTag('Workout'),
                      _buildTag('Focus'),
                      _buildTag('Party'),
                      _buildTag('90s Rock'),
                      _buildTag('Lo-Fi'),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startAnalysis,
                      child: const Text('Generate Playlist'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return ActionChip(
      label: Text(label),
      backgroundColor: const Color(0xFF282828),
      labelStyle: const TextStyle(color: Colors.white),
      onPressed: () {
        final text = _promptController.text;
        _promptController.text = text.isEmpty ? label : '$text, $label';
      },
    );
  }
}
