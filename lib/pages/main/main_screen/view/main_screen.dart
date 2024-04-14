import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/pages/main/main_screen/main_screen.dart';

@RoutePage()
class MainCameraScreen extends StatefulWidget {
  const MainCameraScreen({super.key});

  @override
  State<MainCameraScreen> createState() => _MainCameraScreenState();
}

class _MainCameraScreenState extends State<MainCameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final double focusHeight = 360;

  List<SliderMenuButton> menuButtons = [
    SliderMenuButton(
      btnText: 'Настройки',
      icon: CustomIcons.settings,
    ),
    SliderMenuButton(
      btnText: 'Помощь и поддержка',
      icon: CustomIcons.support,
    ),
    SliderMenuButton(
      btnText: 'О приложении',
      icon: CustomIcons.information,
    ),
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    if (_initializeControllerFuture == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(menuButtons: menuButtons),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PhotoScannerSection(
              initializeControllerFuture: _initializeControllerFuture,
              controller: _controller,
              focusHeight: focusHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DrawerMenuIcon(scaffoldKey: scaffoldKey),
                        AppIconButton(
                          icon: CustomIcons.question,
                          size: width * 0.10256,
                          onIconPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainPhotoButton(controller: _controller!),
                      SizedBox(height: width * 0.06154),
                      SecondaryPhotoButtons(controller: _controller!)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    _controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);
    _controller?.lockCaptureOrientation(DeviceOrientation.portraitDown);

    _initializeControllerFuture = _controller?.initialize().then(
          (value) => setState(() {}),
        );
  }
}
