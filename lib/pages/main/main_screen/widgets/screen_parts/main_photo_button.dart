import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/config/router/main_navigation.dart';

import 'package:lemon/core/core.dart';
import 'package:lemon/pages/main/main_screen/function/image_picker.dart';

class MainPhotoButton extends StatefulWidget {
  const MainPhotoButton({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<MainPhotoButton> createState() => _MainPhotoButtonState();
}

class _MainPhotoButtonState extends State<MainPhotoButton> {
  File? photo;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.21538,
          height: width * 0.21538,
          decoration: BoxDecoration(
            border: Border.all(color: mainClr, width: 2),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: width * 0.18461,
          height: width * 0.18461,
          decoration: BoxDecoration(
            color: mainClr,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: width * 0.21538,
          height: width * 0.21538,
          child: MaterialButton(
            onPressed: () async {
              setState(() {
                photo = null;
              });
              XFile a = await widget.controller.takePicture();

              CroppingImage(
                imageTemporary: a.path,
                afterCropEvent: saveAvatar,
              ).cropImage();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width),
            ),
          ),
        ),
      ],
    );
  }

  saveAvatar(CroppedFile croppedImage) => setState(
        () {
          final imageTemporary = File(croppedImage.path);
          photo = imageTemporary;
          GetIt.I<AppRouter>().push(
            PhotoSendingRoute(photoPath: imageTemporary.path),
            // ThanksRoute(),
          );
        },
      );
}
