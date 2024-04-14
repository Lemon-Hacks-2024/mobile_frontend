part of 'photo_sending_bloc.dart';

class PhotoSendingEvent {}

class LoadPhotoSending extends PhotoSendingEvent {
  LoadPhotoSending({
    this.completer,
  });

  final Completer? completer;
}
