class SpotifyTrack {
  final String id;
  final String name;
  final List<SpotifyArtist> artists;
  final SpotifyAlbum album;
  final int durationMs;
  final String uri;
  final String previewUrl;

  SpotifyTrack({
    required this.id,
    required this.name,
    required this.artists,
    required this.album,
    required this.durationMs,
    required this.uri,
    required this.previewUrl,
  });

  factory SpotifyTrack.fromJson(Map<String, dynamic> json) {
    return SpotifyTrack(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Track',
      artists: (json['artists'] as List?)
              ?.map((e) => SpotifyArtist.fromJson(e))
              .toList() ??
          [],
      album: SpotifyAlbum.fromJson(json['album'] ?? {}),
      durationMs: json['duration_ms'] ?? 0,
      uri: json['uri'] ?? '',
      previewUrl: json['preview_url'] ?? '',
    );
  }

  String get artistNames => artists.map((a) => a.name).join(', ');
  String get durationFormatted {
    final duration = Duration(milliseconds: durationMs);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class SpotifyArtist {
  final String id;
  final String name;
  final String uri;

  SpotifyArtist({
    required this.id,
    required this.name,
    required this.uri,
  });

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) {
    return SpotifyArtist(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Artist',
      uri: json['uri'] ?? '',
    );
  }
}

class SpotifyAlbum {
  final String id;
  final String name;
  final List<SpotifyImage> images;
  final String uri;

  SpotifyAlbum({
    required this.id,
    required this.name,
    required this.images,
    required this.uri,
  });

  factory SpotifyAlbum.fromJson(Map<String, dynamic> json) {
    return SpotifyAlbum(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Album',
      images: (json['images'] as List?)
              ?.map((e) => SpotifyImage.fromJson(e))
              .toList() ??
          [],
      uri: json['uri'] ?? '',
    );
  }

  String get coverUrl => images.isNotEmpty ? images.first.url : '';
}

class SpotifyImage {
  final String url;
  final int height;
  final int width;

  SpotifyImage({
    required this.url,
    required this.height,
    required this.width,
  });

  factory SpotifyImage.fromJson(Map<String, dynamic> json) {
    return SpotifyImage(
      url: json['url'] ?? '',
      height: json['height'] ?? 0,
      width: json['width'] ?? 0,
    );
  }
}
