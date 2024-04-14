import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/data/main/api/photo_sending_api.dart';

import 'package:lemon/pages/main/photo_sending_screen/bloc/photo_sending_bloc.dart';
import 'package:lemon/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

import 'view.dart';

@RoutePage()
class PhotoSendingScreen extends StatefulWidget {
  const PhotoSendingScreen({
    super.key,
    required this.photoPath,
  });

  final String photoPath;

  @override
  State<PhotoSendingScreen> createState() => _PhotoSendingScreenState();
}

class _PhotoSendingScreenState extends State<PhotoSendingScreen> {
  late PhotoSendingBloc _photoBloc;
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  double focusHeight = 360;

  bool isPhotoAccess = false, isFieldsFills = false;

  String cityValue = '';

  @override
  void initState() {
    _photoBloc = PhotoSendingBloc(
      PhotoSendingApi(),
      widget.photoPath,
    );
    _photoBloc.add(LoadPhotoSending());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundClr,
        body: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: BlocBuilder<PhotoSendingBloc, PhotoSendingState>(
              bloc: _photoBloc,
              builder: (context, state) {
                if (state is PhotoSendingLoaded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: width * 0.2),
                    child: Column(
                      children: [
                        Container(
                          width: focusHeight,
                          height: focusHeight / 1.75,
                          decoration: BoxDecoration(
                            border: Border.all(color: darkGrayClr, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              widget.photoPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.2),
                        FirstTextfieldsGroup(
                          priceController: priceController,
                          nameController: nameController,
                          result: state.priceTagData.result,
                        ),
                        AnimatedOpacity(
                          opacity: isPhotoAccess ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInCubic,
                          child: CityEditTextfield(
                            citiesList: ['Донецк'],
                            saveCityValue: saveCity,
                            isIcon: false,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isFieldsFills ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInCubic,
                          child: SizedBox(
                            height: width * 0.06,
                            child: ASText(
                              text: 'Необходимо заполнить все поля',
                              color: errorColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.06),
                        AnimatedOpacity(
                          opacity: isPhotoAccess ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInCubic,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: width * 0.5,
                                height: width * 0.13,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFF5515F),
                                      Color(0xFFA1051D)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(
                                height: width * 0.06,
                                child: ASText(
                                  text: 'Отправить',
                                  color: whiteClr,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.5,
                                height: width * 0.13,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty &&
                                        priceController.text.isNotEmpty &&
                                        cityValue.isNotEmpty &&
                                        isPhotoAccess) {
                                      setState(() => isFieldsFills = false);
                                      GetIt.I<AppRouter>().push(
                                        ThanksRoute(isSuccess: false),
                                      );
                                    } else {
                                      setState(() => isFieldsFills = true);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.1),
                        AnimatedOpacity(
                          opacity: isPhotoAccess ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInCubic,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PhotoSendingButton(
                                isLike: false,
                                onPressed: () {
                                  GetIt.I<AppRouter>().push(
                                    const MainCameraRoute(),
                                  );
                                },
                              ),
                              PhotoSendingButton(
                                isLike: true,
                                onPressed: () {
                                  setState(() => isPhotoAccess = true);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is PhotoSendingLoadingFailure) {
                  return SizedBox();
                }
                return ShimmerPhotoSendingPreloader(
                  isPhotoAccess: isPhotoAccess,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  saveCity(String value) {
    setState(() => cityValue = value);
  }
}

class ShimmerPhotoSendingPreloader extends StatelessWidget {
  const ShimmerPhotoSendingPreloader({
    super.key,
    required this.isPhotoAccess,
  });

  final bool isPhotoAccess;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double focusHeight = 360;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.2),
      child: Shimmer.fromColors(
        baseColor: Color(0xFFf9f9f9),
        highlightColor: lightGrayClr,
        child: Column(
          children: [
            Container(
              width: focusHeight,
              height: focusHeight / 1.75,
              decoration: BoxDecoration(
                color: whiteClr,
                border: Border.all(color: darkGrayClr, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: width * 0.2),
            Container(
              width: width * 0.90923,
              height: width * 0.2,
              decoration: BoxDecoration(
                color: whiteClr,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: width * 0.04179),
            Container(
              width: width * 0.90923,
              height: width * 0.2,
              decoration: BoxDecoration(
                color: whiteClr,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: width * 0.06),
            SizedBox(height: width * 0.1),
            AnimatedOpacity(
              opacity: isPhotoAccess ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInCubic,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.21795,
                    height: width * 0.21795,
                    decoration: BoxDecoration(
                      color: whiteClr,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    width: width * 0.21795,
                    height: width * 0.21795,
                    decoration: BoxDecoration(
                      color: whiteClr,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
