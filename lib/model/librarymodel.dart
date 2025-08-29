// Senior developers create data models for better structure
class LibraryTrack {
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final int streams;
  final Duration duration;

  const LibraryTrack({
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.streams,
    required this.duration,
  });
}
