import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lemon/core/core.dart';

import 'background_clipped_blur.dart';

class PhotoScannerSection extends StatelessWidget {
  const PhotoScannerSection({
    super.key,
    required Future<void>? initializeControllerFuture,
    required CameraController? controller,
    required this.focusHeight,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller;

  final Future<void>? _initializeControllerFuture;
  final CameraController? _controller;
  final double focusHeight;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        ClipPath(
          clipper: BackgroundClippedBlur(focusHeight: focusHeight),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: darkGrayClr.withOpacity(0.4),
              ),
            ),
          ),
        ),
        Container(
          width: focusHeight,
          height: focusHeight / 1.75,
          decoration: BoxDecoration(
            border: Border.all(color: whiteClr, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          width: width * 0.07692,
          height: width * 0.00513,
          color: whiteClr,
        ),
        Container(
          width: width * 0.00513,
          height: width * 0.07692,
          color: whiteClr,
        ),
      ],
    );
  }
}
