import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/kcolors.dart';

class CircleCachedAvatar extends StatelessWidget {
  final String? image;
  final double scale;
  final double? errorIconSize;
  final IconData? errorIcon;
  const CircleCachedAvatar({
    super.key,
    required this.image,
    required this.scale,
    this.errorIconSize,
    this.errorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: image ?? '',
        fit: BoxFit.cover,
        height: scale,
        width: scale,
        maxHeightDiskCache: 200,
        maxWidthDiskCache: 200,
        placeholder: (context, url) => CircleAvatar(
          backgroundColor: KColors.white54,
          child: Icon(
            errorIcon ?? CupertinoIcons.person_solid,
            size: errorIconSize,
            color: Colors.black26,
          ),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: const Color(0x34FFFFFF),
          child: Icon(
            errorIcon ?? CupertinoIcons.person_solid,
            size: errorIconSize,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
