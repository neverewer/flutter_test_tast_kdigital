import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kdigital_test/src/features/main/domain/entities/character.dart';

class CharacterListItemWidget extends StatelessWidget {
  final CharacterEntity character;

  const CharacterListItemWidget({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: character.image,
              width: 180,
              height: 180,
              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Text(
                  'Cannot load image',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${character.name}',
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Species: ${character.species}',
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Status: ${character.status}',
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
