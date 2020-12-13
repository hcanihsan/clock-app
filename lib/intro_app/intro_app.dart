import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:clock_app/digitalClock/home.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class intro_app extends StatelessWidget {
  List<PageViewModel> loadPages() {
    return [
      PageViewModel(
        title: '"Management Your Time"',
        body: "Ayo atur waktumu, jangan sampai banyak waktu yang terbuang.",
        image: Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset('assets/images/introimages1.png')),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(fontFamily: 'KalamBold', fontSize: 27),
          bodyTextStyle: TextStyle(fontFamily: 'KalamRegular', fontSize: 23),
          pageColor: Color.fromRGBO(162, 195, 252, 1.0),
        ),
      ),
      PageViewModel(
        title: '"Use On Your Smartphone"',
        body: "Gunakan aplikasi ini cukup dengan melalui smartphone kamu.",
        image: Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset('assets/images/imagesintro2.png')),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(fontFamily: 'KalamBold', fontSize: 27),
          bodyTextStyle: TextStyle(fontFamily: 'KalamRegular', fontSize: 24),
          pageColor: Color.fromRGBO(149, 237, 155, 1.0),
        ),
      ),
      PageViewModel(
        title: '"Clock With Nature Background App"',
        body:
            "Jam dengan tampilan background gambar alam pada aplikasi agar terlihat lebih fresh ketika digunakan.",
        image: Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset('assets/images/introimages3.png')),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(fontFamily: 'KalamBold', fontSize: 24),
          bodyTextStyle: TextStyle(fontFamily: 'KalamRegular', fontSize: 20),
          pageColor: Color.fromRGBO(230, 208, 148, 1.0),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroductionScreen(
          done: Text(
            'Ayo Mulai',
            style: TextStyle(fontFamily: 'KalamBold', fontSize: 17),
          ),
          onDone: () {
            Navigator.of(context).pushAndRemoveUntil(
                CircularClipRoute(
                    builder: (context) => Home(), expandFrom: context),
                (Route<dynamic> route) => false);
          },
          pages: loadPages(),
          dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Color.fromRGBO(252, 252, 106, 1.0),
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
          ),
        ),
      ),
    );
  }
}
