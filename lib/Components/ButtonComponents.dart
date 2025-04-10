import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonComponents {
  static LinearGradient myGradient = LinearGradient(
    colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static LinearGradient myGradientLTR = LinearGradient(
    colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static Size getScreenSize(context) {
    Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  static Text getMyGradientText(text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        foreground:
            Paint()
              ..shader = const LinearGradient(
                colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 50.0)),
      ),
    );
  }

  static Text getLogoText(
    text, {
    double? fontSize = 40,
    Color? color = const Color.fromARGB(255, 0, 0, 0),
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: GoogleFonts.zenTokyoZoo().fontFamily,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Container getGradientBox({
    required text,
    required double size,
    required double myRadius,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      width: 315,
      decoration: BoxDecoration(
        gradient: myGradient,
        borderRadius: BorderRadius.circular(myRadius),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
      ),
    );
  }

  static TextButton getLogInBorder(text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        width: 315,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF6A84EB)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              foreground:
                  Paint()
                    ..shader = LinearGradient(
                      colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
                    ).createShader(Rect.fromLTWH(0, 0, 200, 40)),
            ),
          ),
        ),
      ),
    );
  }

  static ShaderMask myGradientLogo(icon, {double logoSize = 30}) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return ButtonComponents.myGradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Icon(icon, size: logoSize),
    );
  }

  static LinearGradient acceptButton() {
    return LinearGradient(
      colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  static LinearGradient rejectButton() {
    return LinearGradient(
      colors: [
        Color.fromARGB(255, 255, 144, 142),
        Color.fromARGB(255, 235, 73, 3),
      ], // Updated gradient
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}

LinearGradient myGradient() => LinearGradient(
  colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
