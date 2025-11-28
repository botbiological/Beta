// Senior developers use state management (even in StatelessWidgets with providers)
import 'package:provide/model/playlistmodel.dart';

class PlaylistViewModel {
  final List<PlaylistTrack> tracks = List.generate(
    10,
    (index) => PlaylistTrack(
      id: '${index + 1}',
      userId: 'demo_user',
      title: index.isEven ? "No Sleep Tonight" : "Midnight Vibes",
      artist: index.isEven ? "Young Blaze" : "Luna Star",
      producer: index.isEven ? "Khaled" : "DJ Nova",
      imageAsset: "assets/icons/Component 1 (1).png",
      duration: Duration(minutes: 3 + index, seconds: 45),
      playCount: 32400 - (index * 400),
      createdAt: DateTime.now().subtract(Duration(days: index + 1)),
      updatedAt: DateTime.now().subtract(Duration(days: index + 1)),
    ),
  );
}
