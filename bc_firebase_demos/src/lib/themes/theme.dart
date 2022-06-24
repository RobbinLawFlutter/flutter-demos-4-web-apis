//https://api.flutter.dev/flutter/material/ButtonStyle-class.html

//https://material.io/design/interaction/states.html#usage

//https://material.io/design/material-theming/implementing-your-theme.html#theming

//https://docs.google.com/document/d/1kzIOQN4QYfVsc5lMZgy_A-FWGXBAJBMySGqZqsJytcE/edit#heading=h.pub7jnop54q0

import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: colorScheme,
    //brightness: Brightness.light,
    accentColor: Colors.black,
    //primaryColor: _colorScheme.primary,
    //scaffoldBackgroundColor: themeColor,
    //TextSelectionThemeData.
    cursorColor: colorScheme.onPrimary,
    primaryIconTheme: _buildIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    //primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    //accentTextTheme: _buildTextTheme(base.accentTextTheme),
    iconTheme: _buildIconTheme(base.iconTheme),
    accentIconTheme: _buildIconTheme(base.iconTheme),
    appBarTheme: AppBarTheme(
      color: colorScheme.primary,
      iconTheme: IconThemeData(
        color: colorScheme.onPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: colorScheme.onPrimary,
      ),
      //If textTheme property is null the appbar will use ThemeData.primaryTextTheme.
      textTheme: _buildTextTheme(base.textTheme),
      centerTitle: true,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 25,
        letterSpacing: defaultLetterSpacing,
      ),
      contentTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 25,
        letterSpacing: defaultLetterSpacing,
      ),
    ),
    //inputDecorationTheme applies to TextField Widget.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.primary,
      focusColor: colorScheme.onPrimary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
        ),
      ),
      prefixStyle: TextStyle(
        color: colorScheme.onPrimary,
      ),
      suffixStyle: TextStyle(
        color: colorScheme.onPrimary,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: defaultLetterSpacing,
        color: colorScheme.onPrimary,
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: defaultLetterSpacing,
        color: colorScheme.onPrimary,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    indicatorColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorScheme.background),
          foregroundColor: MaterialStateProperty.all(colorScheme.onPrimary),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: defaultLetterSpacing,
            ),
          )),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          //The buttons background fill color.
          backgroundColor:
              MaterialStateProperty.resolveWith<Color>(getBackgroundColor),
          //The color of the buttons text and icon decendant widgets.
          foregroundColor:
              MaterialStateProperty.resolveWith<Color>(getForegroundColor),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              letterSpacing: defaultLetterSpacing,
            ),
          )),
    ),
  );
}

IconThemeData _buildIconTheme(IconThemeData original) {
  return original.copyWith(color: colorScheme.onPrimary);
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        //Extremely large text.
        headline1: TextStyle(
          color: Colors.green,
        ),
        //Very, very large text.
        headline2: TextStyle(
          color: Colors.green,
        ),
        //Very large text.
        headline3: TextStyle(
          color: Colors.green,
        ),
        //Large text.
        headline4: TextStyle(
          color: Colors.green,
        ),
        //Used for large text in dialogs
        //(e.g., the month and year in the dialog shown by showDatePicker)
        headline5: TextStyle(
          color: Colors.green,
        ),
        //Used for the primary text in app bars and dialogs
        //(e.g., AppBar.title and AlertDialog.title).
        headline6: base.headline6.copyWith(
          color: Colors.purple,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for the primary text in lists (e.g., ListTile.title)
        //and the TextField edited text.
        subtitle1: base.subtitle1.copyWith(
          color: Colors.amber,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //For medium emphasis text that's a little smaller than subtitle1
        subtitle2: base.subtitle2.copyWith(
          color: Colors.cyan,
          fontSize: 15,
        ),
        //Used for emphasizing text that would otherwise be bodyText2.
        bodyText1: base.bodyText1.copyWith(
          color: Colors.blue,
        ),
        //The default text style for material.
        //Color for ListTile.trailing
        bodyText2: base.bodyText2.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for auxiliary text with images.
        //Used for ListTile.subtile
        caption: base.caption.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for text on ElevatedButton, TextButton, and OutlinedButton
        //if no others
        button: base.button.copyWith(
          //Button text color
          color: Colors.white,
          //button text background color, NOT button color.
          //backgroundColor: Colors.red,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        //The displayColor is applied to [headline4], [headline3],
        //[headline2], [headline1], and [caption]
        displayColor: colorScheme.onPrimary,
        //The bodyColor is applied to the remaining text styles.
        bodyColor: colorScheme.onPrimary,
      );
}

Color getBackgroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return colorScheme.primary.withOpacity(0.5);
  }
  return colorScheme.primary;
}

Color getForegroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return colorScheme.onPrimary.withOpacity(0.5);
  }
  return colorScheme.onPrimary;
}

ColorScheme colorScheme = ColorScheme(
  primary: blue200,
  primaryVariant: brown900,
  secondary: pink50,
  secondaryVariant: brown900,
  surface: surfaceWhite,
  background: backgroundWhite,
  error: errorRed,
  onPrimary: brown900,
  onSecondary: brown900,
  onSurface: brown900,
  onBackground: brown900,
  onError: surfaceWhite,
  brightness: Brightness.light,
);

Color blue200 = Colors.cyan.shade200;

const Color pink50 = Color(0xFFFEEAE6);
const Color pink100 = Color(0xFFFEDBD0);
const Color pink300 = Color(0xFFFBB8AC);
const Color pink400 = Color(0xFFEAA4A4);

const Color brown900 = Color(0xFF442B2D);
const Color brown600 = Color(0xFF7D4F52);

const Color errorRed = Color(0xFFC5032B);

const Color surfaceWhite = Color(0xFFFFFBFA);
const Color backgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
