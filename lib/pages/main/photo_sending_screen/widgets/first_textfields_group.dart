import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/data/main/models/price_tag_result_model.dart';
import 'package:lemon/functions.dart';
import 'package:lemon/widget.dart';

class FirstTextfieldsGroup extends StatefulWidget {
  const FirstTextfieldsGroup({
    super.key,
    required this.priceController,
    required this.nameController,
    required this.result,
  });

  final TextEditingController priceController;
  final TextEditingController nameController;
  final PriceTagResultModel result;

  @override
  State<FirstTextfieldsGroup> createState() => _FirstTextfieldsGroupState();
}

class _FirstTextfieldsGroupState extends State<FirstTextfieldsGroup> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        widget.priceController.text = widget.result.productPrice.toString();
        widget.nameController.text = widget.result.productName;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Column(
          children: [
            Container(
              width: width * 0.90923,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: blackClr.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextFormField(
                controller: widget.priceController,
                keyboardType: TextInputType.number,
                style: textTheme.titleLarge?.copyWith(
                  color: darkGrayClr,
                  fontSize: 24 / queryData,
                  fontFamily: fontLato,
                ),
                decoration: TextfieldDecoration(
                  context: context,
                  text: widget.result.productPrice.toString(),
                  label: 'Цена',
                  suffixIcon: SizedBox(
                    height: width * 0.1,
                    child: ASText(
                      text: '₽',
                      color: darkGrayClr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ).textfieldDecoration(),
              ),
            ),
            SizedBox(height: width * 0.04179),
          ],
        ),
        AppTextfield(
          controller: widget.nameController,
          text: widget.result.productName,
          label: 'Название',
          isPass: true,
        ),
      ],
    );
  }
}
