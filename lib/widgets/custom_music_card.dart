import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Responsive.init(context);
    return Padding(
      padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
      child: Container(
        padding: Responsive.padding(left: 1, right: 1, bottom: 1, top: 1),
        width: Responsive.w(40), // fixed width card
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.w(0), // reduced margin
          vertical: Responsive.h(0),
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
                  child: Image.asset(
                    imageUrl,
                    height: Responsive.h(17),
                    width: double.infinity,
                    fit: BoxFit.fill,
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
                        style: GoogleFonts.onest(
                          fontSize: Responsive.textScaleFactor * 10,
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
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: Responsive.textScaleFactor * 14,
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
                style: GoogleFonts.onest(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: Responsive.textScaleFactor * 12,
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
                style: GoogleFonts.onest(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: Responsive.textScaleFactor * 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
