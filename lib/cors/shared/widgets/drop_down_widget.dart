import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';

class DropdownWidget<T> extends StatelessWidget {
  final bool enabled;
  final List<T> items;
  final String Function(T)? itemAsString;
  final ValueChanged<T?>? onChanged;
  final String? hintText;

  const DropdownWidget({
    Key? key,
    required this.enabled,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: enabled,
      items: items,
      itemAsString: itemAsString,
      onChanged: onChanged,
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        scrollbarProps: ScrollbarProps(
          thumbVisibility: true,
          thumbColor: Styles.orange,
          interactive: true,
        ),
        emptyBuilder: (context, searchEntry) {
          return SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Lista de Pessoa Vazia',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.grey,
                  ),
                ),
              ],
            ),
          );
        },
        //showSearchBox: true,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Styles.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.orange),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.black.withOpacity(0.8)),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.orange),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Styles.black.withOpacity(0.8),
          ),
          contentPadding: const EdgeInsets.only(left: 18, right: 18),
          prefixIcon: Icon(
            Icons.person_add,
            color: Styles.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
