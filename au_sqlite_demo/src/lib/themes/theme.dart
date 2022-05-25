//https://api.flutter.dev/flutter/material/ButtonStyle-class.html

//https://material.io/design/interaction/states.html#usage

//https://material.io/design/material-theming/implementing-your-theme.html#theming

//https://docs.google.com/document/d/1kzIOQN4QYfVsc5lMZgy_A-FWGXBAJBMySGqZqsJytcE/edit#heading=h.pub7jnop54q0

import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _colorScheme,
    //brightness: Brightness.light,
    accentColor: Colors.black,
    //primaryColor: _colorScheme.primary,
    //scaffoldBackgroundColor: themeColor,
    cursorColor: _colorScheme.onPrimary,
    primaryIconTheme: _buildIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    //primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    //accentTextTheme: _buildTextTheme(base.accentTextTheme),
    iconTheme: _buildIconTheme(base.iconTheme),
    appBarTheme: AppBarTheme(
      color: _colorScheme.primary,
      iconTheme: IconThemeData(
        color: _colorScheme.onPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: _colorScheme.onPrimary,
      ),
      //If textTheme property is null the appbar will use ThemeData.primaryTextTheme.
      textTheme: _buildTextTheme(base.textTheme),
      centerTitle: true,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: _colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 25,
        letterSpacing: defaultLetterSpacing,
      ),
      contentTextStyle: TextStyle(
        color: _colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 25,
        letterSpacing: defaultLetterSpacing,
      ),
    ),
    //inputDecorationTheme applies to TextField Widget.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _colorScheme.primary,
      labelStyle: TextStyle(),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25,
        letterSpacing: defaultLetterSpacing,
        color: _colorScheme.onPrimary,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    indicatorColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_colorScheme.background),
          foregroundColor: MaterialStateProperty.all(_colorScheme.onPrimary),
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
  return original.copyWith(color: brown900);
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
        headline6: base.headline6!.copyWith(
          color: Colors.purple,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for the primary text in lists (e.g., ListTile.title)
        //and the TextField edited text.
        subtitle1: base.subtitle1!.copyWith(
          color: Colors.amber,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //For medium emphasis text that's a little smaller than subtitle1
        subtitle2: base.subtitle2!.copyWith(
          color: Colors.cyan,
          fontSize: 15,
        ),
        //Used for emphasizing text that would otherwise be bodyText2.
        bodyText1: base.bodyText1!.copyWith(
          color: Colors.blue,
        ),
        //The default text style for material.
        //Color for ListTile.trailing
        bodyText2: base.bodyText2!.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for auxiliary text with images.
        //Used for ListTile.subtile
        caption: base.caption!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for text on ElevatedButton, TextButton, and OutlinedButton
        //if no others
        button: base.button!.copyWith(
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
        displayColor: _colorScheme.onPrimary,
        //The bodyColor is applied to the remaining text styles.
        bodyColor: _colorScheme.onPrimary,
      );
}

Color getBackgroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return _colorScheme.primary.withOpacity(0.5);
  }
  return _colorScheme.primary;
}

Color getForegroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return _colorScheme.onPrimary.withOpacity(0.5);
  }
  return _colorScheme.onPrimary;
}

ColorScheme _colorScheme = ColorScheme(
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
