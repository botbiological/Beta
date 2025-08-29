// Senior developers create view models for state management
import 'package:provide/model/librarymodel.dart';

class LibraryViewModel {
  final List<LibraryTrack> recentlyPlayed = List.generate(
    10,
    (index) => LibraryTrack(
      title: "No Sleep Tonight",
      artist: "Young Blaze",
      producer: "Khaled",
      imageAsset: "assets/icons/Component 1 (1).png",
      streams: 32400 + index * 100,
      duration: const Duration(minutes: 3, seconds: 45),
    ),
  );

  final List<String> librarySections = [
    "Playlist",
    "My Tracks",
    "Saved Artists",
  ];
}