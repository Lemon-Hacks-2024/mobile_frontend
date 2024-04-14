import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/functions.dart';

class CityEditTextfield extends StatefulWidget {
  const CityEditTextfield({
    super.key,
    required this.citiesList,
    required this.isIcon,
    required this.saveCityValue,
  });

  final List<String> citiesList;
  final bool isIcon;
  final Function saveCityValue;

  @override
  State<CityEditTextfield> createState() => _CityEditTextfieldState();
}

class _CityEditTextfieldState extends State<CityEditTextfield> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: width * 0.90923,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: darkGrayClr.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: DropdownSearch<String>(
            items: widget.citiesList,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            dropdownButtonProps: const DropdownButtonProps(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            onChanged: (value) {
              widget.saveCityValue(value);
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: textTheme.titleLarge?.copyWith(
                fontSize: 24 / queryData,
                color: darkGrayClr,
              ),
              dropdownSearchDecoration: TextfieldDecoration(
                context: context,
                text: 'Ростов-на-Дону',
                label: 'Город',
                icon: widget.isIcon ? CustomIcons.location : null,
              ).textfieldDecoration(),
            ),
          ),
        ),
        SizedBox(height: width * 0.0402),
      ],
    );
  }
}
