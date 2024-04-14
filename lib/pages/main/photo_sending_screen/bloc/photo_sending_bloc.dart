import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/data/main/api/photo_sending_api.dart';
import 'package:lemon/data/main/models/price_tag_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'photo_sending_event.dart';
part 'photo_sending_state.dart';

class PhotoSendingBloc extends Bloc<PhotoSendingEvent, PhotoSendingState> {
  PhotoSendingBloc(this.photoSendingApi, this.photoPath)
      : super(PhotoSendingInitial()) {
    on<LoadPhotoSending>((event, emit) async {
      try {
        if (state is! PhotoSendingLoaded) {
          emit(PhotoSendingLoading());
        }
        final priceTagInfo =
            await photoSendingApi.photoSendingApiPost(photoPath);
        emit(PhotoSendingLoaded(priceTagData: priceTagInfo));
      } catch (e, st) {
        emit(PhotoSendingLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }

  final PhotoSendingApi photoSendingApi;
  final String photoPath;
}
