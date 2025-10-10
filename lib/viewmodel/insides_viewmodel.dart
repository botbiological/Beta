// Senior developers create view models for state management
import 'package:provide/model/insides_model.dart';

class InsidesViewmodel {
  final List<InsidesModel> recentlyPlayed = List.generate(
    10,
    (index) => InsidesModel(
      title: "No Sleep Tonight",
      artist: "Young Blaze",
      producer: "Khaled",
      imageAsset: "assets/icons/Component 1 (1).png",
      streams: 32400 + index * 100,
      duration: const Duration(minutes: 3, seconds: 45),
    ),
  );

  final List<String> librarySections = [
    "Total Streams",
    "Total Likes",
    "Follower Growth",
  ];
}
