import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystery_app/screens/welcome_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confuso',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/vector/background.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Center(
              child: Transform.scale(
                scale: 0.9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 410,
                      height: 850,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(70)),
                      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 35),
                      child: MaterialApp(
                        home: WelcomeScreen(),
                        theme: ThemeData(
                          textTheme: GoogleFonts.patrickHandTextTheme(
                            ThemeData().textTheme.copyWith(bodyMedium: TextStyle(fontSize: 20.0)),
                          ),
                          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                          scaffoldBackgroundColor: Colors.transparent,
                          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
                          pageTransitionsTheme: PageTransitionsTheme(
                            builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
                              TargetPlatform.values,
                              value: (dynamic _) => const ZoomPageTransitionsBuilder(), //applying old animation
                            ),
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(child: SvgPicture.asset('assets/vector/phone_frame.svg', height: 852)),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => launchUrlString('https://github.com/adrian-antoci/Confuso-App'),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/vector/github.svg', color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String text;
  final void Function() onTap;
  final bool outlined;

  const PrimaryButton({super.key, required this.text, required this.onTap, this.outlined = false});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHover = false;
        });
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            overlayColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: widget.outlined ? Colors.white : Colors.black,
            side: widget.outlined ? BorderSide(color: Colors.black, width: 3) : null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_isHover ? 100 : 8.0)),
          ),
          onPressed: () => widget.onTap(),
          child: Text(
            widget.text,
            style: TextStyle(color: widget.outlined ? Colors.black : Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.logoOnly = false});

  final bool logoOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Text("¿!", style: TextStyle(fontSize: 100, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
        if (!logoOnly)
          Text("Confuso", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
      ],
    );
  }
}

extension BuildExt on BuildContext {
  void push({required Widget screen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }
}
