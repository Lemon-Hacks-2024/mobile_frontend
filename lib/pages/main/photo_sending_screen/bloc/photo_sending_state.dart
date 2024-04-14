part of 'photo_sending_bloc.dart';

sealed class PhotoSendingState {}

final class PhotoSendingInitial extends PhotoSendingState {}

class PhotoSendingLoading extends PhotoSendingState {}

class PhotoSendingLoaded extends PhotoSendingState {
  PhotoSendingLoaded({
    required this.priceTagData,
  });

  final PriceTagModel priceTagData;
}

class PhotoSendingLoadingFailure extends PhotoSendingState {
  PhotoSendingLoadingFailure({
    required this.exception,
  });
  final Object? exception;
}
