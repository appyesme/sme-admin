// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../core/constants/kcolors.dart';
import '../../core/router/route_config.dart';
import '../../services/file_service/file_service.dart';
import '../../widgets/button.dart';

abstract final class CropImageX {
  static Future<CroppedFile?> cropImage(PickedFile file, [CropAspectRatio? aspectRatio]) async {
    final context = navigatorKey.currentState!.context;

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path!,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: aspectRatio,
      uiSettings: [
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
        ),
      ],
    );

    if (croppedImage == null) return null;

    return showCroppedimage(context, croppedImage);
  }

  static Future<CroppedFile?> showCroppedimage(BuildContext context, CroppedFile image) async {
    return await showDialog<CroppedFile?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(color: KColors.black)),
                  child: Image.network(
                    image.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Divider(color: KColors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppButton(
                      onTap: () => GoRouter.of(context).pop(null),
                      elevation: 0,
                      text: 'Cancel',
                      borderRadius: 0,
                      backgroundColor: KColors.grey1,
                      textColor: KColors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      onTap: () => GoRouter.of(context).pop(image),
                      elevation: 0,
                      text: 'Done',
                      borderRadius: 0,
                      backgroundColor: KColors.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      },
    );
  }
}
