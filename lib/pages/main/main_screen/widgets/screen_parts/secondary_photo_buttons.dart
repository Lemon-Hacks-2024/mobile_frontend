import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/pages/main/main_screen/function/image_picker.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app_icon_button.dart';

class SecondaryPhotoButtons extends StatefulWidget {
  const SecondaryPhotoButtons({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<SecondaryPhotoButtons> createState() => _SecondaryPhotoButtonsState();
}

class _SecondaryPhotoButtonsState extends State<SecondaryPhotoButtons> {
  bool isTorchActive = false;
  File? photo;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIconButton(
          icon: CustomIcons.gallery,
          size: width * 0.07692,
          onIconPressed: () {
            PickingImage(
              source: ImageSource.gallery,
              afterCropEvent: saveAvatar,
            ).pickImage();
          },
        ),
        SizedBox(width: width * 0.1),
        AppIconButton(
          icon: CustomIcons.thunder,
          size: width * 0.07692,
          onIconPressed: flashLightButtonEvemt,
        ),
      ],
    );
  }

  void flashLightButtonEvemt() {
    setState(() => isTorchActive = !isTorchActive);
    try {
      isTorchActive
          ? widget.controller.setFlashMode(FlashMode.torch)
          : widget.controller.setFlashMode(FlashMode.off);
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  saveAvatar(CroppedFile croppedImage) => setState(
        () {
          final imageTemporary = File(croppedImage.path);
          photo = imageTemporary;
          GetIt.I<AppRouter>().push(
            PhotoSendingRoute(photoPath: imageTemporary.path),
          );
        },
      );
}
