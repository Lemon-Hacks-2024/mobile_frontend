import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemon/core/core.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PickingImage {
  PickingImage({
    required this.source,
    required this.afterCropEvent,
  });

  final ImageSource source;
  final Function afterCropEvent;

  final ImagePicker picker = ImagePicker();

  Future pickImage() async {
    try {
      final image = await picker.pickImage(
        source: source,
      );

      if (image == null) return;
      CroppingImage(
        imageTemporary: image.path,
        afterCropEvent: afterCropEvent,
      ).cropImage();
    } on PlatformException catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}

class CroppingImage {
  CroppingImage({
    required this.imageTemporary,
    required this.afterCropEvent,
  });

  final String imageTemporary;
  final Function afterCropEvent;

  void cropImage() async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageTemporary,
      maxWidth: 560,
      maxHeight: 320,
      compressQuality: 50,
      cropStyle: CropStyle.rectangle,
      aspectRatio: const CropAspectRatio(ratioX: 560, ratioY: 320),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Обрезать фото',
          statusBarColor: mainClr,
          toolbarColor: mainClr,
          toolbarWidgetColor: whiteClr,
          backgroundColor: mainClr,
          activeControlsWidgetColor: mainClr,
          dimmedLayerColor: mainClr.withOpacity(0.5),
          cropFrameColor: whiteClr,
          cropGridColor: whiteClr,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          doneButtonTitle: 'Подтвердить',
          cancelButtonTitle: 'Отменить',
          showCancelConfirmationDialog: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    if (croppedImage != null) {
      afterCropEvent(croppedImage);
    }
  }
}
