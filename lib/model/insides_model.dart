// Senior developers create data models for better structure
class InsidesModel {
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final int streams;
  final Duration duration;

  const InsidesModel({
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.streams,
    required this.duration,
  });
}
