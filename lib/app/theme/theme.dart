import 'package:flightly/app/theme/colors.dart';
import 'package:flightly/app/theme/font.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      fontFamily: AppFonts.fontFamily,
      inputDecorationTheme: inputField,
      textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      appBarTheme: appBar,
      elevatedButtonTheme: elevatedButton,
      bottomNavigationBarTheme: navBar,
      checkboxTheme: const CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(Colors.white),
        fillColor: WidgetStatePropertyAll(AppColors.primary),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        indent: 5,
        endIndent: 5,
        color: BlackColor.light,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: const IconThemeData(color: BlackColor.light),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      chipTheme: const ChipThemeData(
        labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  static final inputField = InputDecorationTheme(
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: BlackColor.light),
    ),
    // contentPadding: ,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  static final textButtonStyle = TextButton.styleFrom(
    elevation: 0,
    // padding: AppPaddings.smallXY,
    // textStyle: AppFonts.body2.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final elevatedButton = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      // textStyle: MaterialStateProperty.all(AppFonts.body1),
      // padding: MaterialStateProperty.all(AppPaddings.smallXY),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled) //
              ? Colors.black54
              : AppColors.white;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled) //
              ? Colors.black12
              : AppColors.primary;
        },
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  static const navBar = BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: BlackColor.light,
  );

  static const appBar = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );
}
