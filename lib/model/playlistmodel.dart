// Senior developers create data models
class PlaylistTrack {
  final String id;
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final Duration duration;
  final int playCount;

  const PlaylistTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.duration,
    required this.playCount,
  });
}