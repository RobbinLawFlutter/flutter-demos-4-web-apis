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
    //primaryColor: _colorScheme.primary,
    //scaffoldBackgroundColor: themeColor,
    //TextSelectionThemeData.
    primaryIconTheme: _buildIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    iconTheme: _buildIconTheme(base.iconTheme),
    appBarTheme: _buildAppBarTheme(base.appBarTheme),
    dialogTheme: _buildDialogTheme(base.dialogTheme),
    //inputDecorationTheme applies to TextField Widget.
    inputDecorationTheme: _buildInputDecorationTheme(base.inputDecorationTheme),
    textSelectionTheme: _textSelectionThemeData(),
    //indicatorColor: Colors.black,
    textButtonTheme: _buildTextButtonThemeData(base.textButtonTheme),
    elevatedButtonTheme:
        _buildElevatedButtonThemeData(base.elevatedButtonTheme),
  );
}

AppBarTheme _buildAppBarTheme(AppBarTheme base) {
  return base.copyWith(
    color: _colorScheme.primary,
    iconTheme: _buildIconTheme(base.iconTheme),
    actionsIconTheme: _buildIconTheme(base.iconTheme),
    centerTitle: true,
  );
}

TextButtonThemeData _buildTextButtonThemeData(TextButtonThemeData base) {
  return TextButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_colorScheme.background),
        foregroundColor: MaterialStateProperty.all(_colorScheme.onPrimary),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: defaultLetterSpacing,
          ),
        )),
  );
}

ElevatedButtonThemeData _buildElevatedButtonThemeData(
    ElevatedButtonThemeData? base) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
        //The buttons background fill color.
        backgroundColor:
            MaterialStateProperty.resolveWith<Color>(_getBackgroundColor),
        //The color of the buttons text and icon descendant widgets.
        foregroundColor:
            MaterialStateProperty.resolveWith<Color>(_getForegroundColor),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            letterSpacing: defaultLetterSpacing,
          ),
        )),
  );
}

DialogTheme _buildDialogTheme(DialogTheme base) {
  return base.copyWith(
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
  );
}

InputDecorationTheme _buildInputDecorationTheme(InputDecorationTheme base) {
  return base.copyWith(
    filled: true,
    fillColor: _colorScheme.primary,
    focusColor: _colorScheme.onPrimary,
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    //floatingLabelBehavior: FloatingLabelBehavior.auto,
    //constraints: BoxConstraints(maxWidth: 150),
    // borders
    enabledBorder: _buildBorderStyle(_colorScheme.primary),
    errorBorder: _buildBorderStyle(_colorScheme.error),
    focusedErrorBorder: _buildBorderStyle(_colorScheme.error),
    focusedBorder: _buildBorderStyle(_colorScheme.primary),
    disabledBorder: _buildBorderStyle(Colors.black26),
    // text
    suffixStyle: _buildTextStyle(_colorScheme.onPrimary),
    counterStyle: _buildTextStyle(_colorScheme.onPrimary, size: 12.0),
    floatingLabelStyle: _buildTextStyle(_colorScheme.onPrimary),
    errorStyle: _buildTextStyle(_colorScheme.error),
    hintStyle: _buildTextStyle(_colorScheme.onPrimary),
    helperStyle: _buildTextStyle(_colorScheme.onPrimary),
    labelStyle: _buildTextStyle(_colorScheme.onPrimary),
    prefixStyle: _buildTextStyle(_colorScheme.onPrimary),
    iconColor: _colorScheme.onPrimary,
  );
}

OutlineInputBorder _buildBorderStyle(Color color, {double width = 2.0}) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
  );
}

IconThemeData _buildIconTheme(IconThemeData? base) {
  return base!.copyWith(color: _colorScheme.onPrimary);
}

TextStyle _buildTextStyle(Color color,
    {double size = 16.0, FontWeight weight = FontWeight.w500}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}

TextSelectionThemeData _textSelectionThemeData() {
  return TextSelectionThemeData(
    cursorColor: _colorScheme.onPrimary,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        //Extremely large text.
        headline1: const TextStyle(
            //color: Colors.green,
            ),
        //Very, very large text.
        headline2: const TextStyle(
            //color: Colors.green,
            ),
        //Very large text.
        headline3: const TextStyle(
            //color: Colors.green,
            ),
        //Large text.
        headline4: const TextStyle(
            //color: Colors.green,
            ),
        //Used for large text in dialogs
        //(e.g., the month and year in the dialog shown by showDatePicker)
        headline5: const TextStyle(
            //color: Colors.green,
            ),
        //Used for the primary text in app bars and dialogs
        //(e.g., AppBar.title and AlertDialog.title).
        headline6: base.headline6!.copyWith(
          //color: Colors.purple,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for the primary text in lists (e.g., ListTile.title)
        //and the TextField edited text.
        subtitle1: base.subtitle1!.copyWith(
          //color: Colors.amber,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: defaultLetterSpacing,
        ),
        //For medium emphasis text that's a little smaller than subtitle1
        subtitle2: base.subtitle2!.copyWith(
          //color: Colors.cyan,
          fontSize: 15,
        ),
        //Used for emphasizing text that would otherwise be bodyText2.
        bodyText1: base.bodyText1!.copyWith(
            //color: Colors.blue,
            ),
        //The default text style for material.
        //Color for ListTile.trailing
        bodyText2: base.bodyText2!.copyWith(
          //color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for auxiliary text with images.
        //Used for ListTile.subtile
        caption: base.caption!.copyWith(
          //color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: defaultLetterSpacing,
        ),
        //Used for text on ElevatedButton, TextButton, and OutlinedButton
        //if no others
        button: base.button!.copyWith(
          //Button text color
          //color: Colors.white,
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

Color _getBackgroundColor(Set<MaterialState> states) {
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

Color _getForegroundColor(Set<MaterialState> states) {
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

const ColorScheme _colorScheme = ColorScheme(
  //primary: blue200,
  primary: pink100,
  onPrimary: brown900,
  secondary: pink50,
  onSecondary: brown900,
  surface: surfaceWhite,
  onSurface: brown900,
  background: backgroundWhite,
  onBackground: brown900,
  error: errorRed,
  onError: surfaceWhite,
  brightness: Brightness.light,
);

const Color blue200 = Color(0xFF80DEEA);

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
