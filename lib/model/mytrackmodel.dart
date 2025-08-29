
// Senior developers often create view models for better separation of concerns
class MyTrack {
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final Duration duration;

  const MyTrack({
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.duration,
  });
}