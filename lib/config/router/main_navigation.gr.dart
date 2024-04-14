// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'main_navigation.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    EntranceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EntranceScreen(),
      );
    },
    MailRegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MailRegistrationScreen(),
      );
    },
    MainCameraRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainCameraScreen(),
      );
    },
    PhoneRegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<PhoneRegistrationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PhoneRegistrationScreen(
          key: args.key,
          regInfo: args.regInfo,
        ),
      );
    },
    PhotoSendingRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoSendingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PhotoSendingScreen(
          key: args.key,
          photoPath: args.photoPath,
        ),
      );
    },
    ThanksRoute.name: (routeData) {
      final args = routeData.argsAs<ThanksRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ThanksScreen(
          key: args.key,
          isSuccess: args.isSuccess,
        ),
      );
    },
    VerificationCodeRoute.name: (routeData) {
      final args = routeData.argsAs<VerificationCodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VerificationCodeScreen(
          key: args.key,
          regInfo: args.regInfo,
          isPhone: args.isPhone,
        ),
      );
    },
  };
}

/// generated route for
/// [EntranceScreen]
class EntranceRoute extends PageRouteInfo<void> {
  const EntranceRoute({List<PageRouteInfo>? children})
      : super(
          EntranceRoute.name,
          initialChildren: children,
        );

  static const String name = 'EntranceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MailRegistrationScreen]
class MailRegistrationRoute extends PageRouteInfo<void> {
  const MailRegistrationRoute({List<PageRouteInfo>? children})
      : super(
          MailRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MailRegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainCameraScreen]
class MainCameraRoute extends PageRouteInfo<void> {
  const MainCameraRoute({List<PageRouteInfo>? children})
      : super(
          MainCameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainCameraRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PhoneRegistrationScreen]
class PhoneRegistrationRoute extends PageRouteInfo<PhoneRegistrationRouteArgs> {
  PhoneRegistrationRoute({
    Key? key,
    required RegistrationInformation regInfo,
    List<PageRouteInfo>? children,
  }) : super(
          PhoneRegistrationRoute.name,
          args: PhoneRegistrationRouteArgs(
            key: key,
            regInfo: regInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static const PageInfo<PhoneRegistrationRouteArgs> page =
      PageInfo<PhoneRegistrationRouteArgs>(name);
}

class PhoneRegistrationRouteArgs {
  const PhoneRegistrationRouteArgs({
    this.key,
    required this.regInfo,
  });

  final Key? key;

  final RegistrationInformation regInfo;

  @override
  String toString() {
    return 'PhoneRegistrationRouteArgs{key: $key, regInfo: $regInfo}';
  }
}

/// generated route for
/// [PhotoSendingScreen]
class PhotoSendingRoute extends PageRouteInfo<PhotoSendingRouteArgs> {
  PhotoSendingRoute({
    Key? key,
    required String photoPath,
    List<PageRouteInfo>? children,
  }) : super(
          PhotoSendingRoute.name,
          args: PhotoSendingRouteArgs(
            key: key,
            photoPath: photoPath,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotoSendingRoute';

  static const PageInfo<PhotoSendingRouteArgs> page =
      PageInfo<PhotoSendingRouteArgs>(name);
}

class PhotoSendingRouteArgs {
  const PhotoSendingRouteArgs({
    this.key,
    required this.photoPath,
  });

  final Key? key;

  final String photoPath;

  @override
  String toString() {
    return 'PhotoSendingRouteArgs{key: $key, photoPath: $photoPath}';
  }
}

/// generated route for
/// [ThanksScreen]
class ThanksRoute extends PageRouteInfo<ThanksRouteArgs> {
  ThanksRoute({
    Key? key,
    required bool isSuccess,
    List<PageRouteInfo>? children,
  }) : super(
          ThanksRoute.name,
          args: ThanksRouteArgs(
            key: key,
            isSuccess: isSuccess,
          ),
          initialChildren: children,
        );

  static const String name = 'ThanksRoute';

  static const PageInfo<ThanksRouteArgs> page = PageInfo<ThanksRouteArgs>(name);
}

class ThanksRouteArgs {
  const ThanksRouteArgs({
    this.key,
    required this.isSuccess,
  });

  final Key? key;

  final bool isSuccess;

  @override
  String toString() {
    return 'ThanksRouteArgs{key: $key, isSuccess: $isSuccess}';
  }
}

/// generated route for
/// [VerificationCodeScreen]
class VerificationCodeRoute extends PageRouteInfo<VerificationCodeRouteArgs> {
  VerificationCodeRoute({
    Key? key,
    required RegistrationInformation regInfo,
    required bool isPhone,
    List<PageRouteInfo>? children,
  }) : super(
          VerificationCodeRoute.name,
          args: VerificationCodeRouteArgs(
            key: key,
            regInfo: regInfo,
            isPhone: isPhone,
          ),
          initialChildren: children,
        );

  static const String name = 'VerificationCodeRoute';

  static const PageInfo<VerificationCodeRouteArgs> page =
      PageInfo<VerificationCodeRouteArgs>(name);
}

class VerificationCodeRouteArgs {
  const VerificationCodeRouteArgs({
    this.key,
    required this.regInfo,
    required this.isPhone,
  });

  final Key? key;

  final RegistrationInformation regInfo;

  final bool isPhone;

  @override
  String toString() {
    return 'VerificationCodeRouteArgs{key: $key, regInfo: $regInfo,  isPhone: $isPhone}';
  }
}
