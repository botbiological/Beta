import 'package:flutter/material.dart';
import 'package:provide/utils/routes/responsive.dart';

class CustomMusicCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final String streams;
  final String? badgeText;

  const CustomMusicCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.streams,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 160, // fixed width card
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.w(3), // reduced margin
        vertical: Responsive.h(1),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Album Cover with Play Button ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  height: Responsive.h(17),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// Play Button
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),

              /// Badge (Top-right corner)
              if (badgeText != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: Responsive.h(1.5)),

          /// --- Title ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// --- Artist ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              "By $artist",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),

          /// --- Streams Info ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              streams,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
