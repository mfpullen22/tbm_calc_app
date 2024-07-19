import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/background_blue.svg",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "The Tuberculous Meningitis (TBM) diagnostic prediction model is the first, broadly generalizable clinical multivariable prediction tool for diagnosing TBM. This diagnostic prediction model was trained from data from 15 individual studies across 9 countries (n = 3,671 participants), and contains inputs for values generated from routine procedures such including a blood draw and cerebrospinal fluid (CSF) analysis.",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "This TBM diagnostic prediction model is intended for use only by health care professionals. In the context of suspected TBM, we suggest that the TBM diagnostic prediction model results should be used in conjunction with the experience of the treating clinician to guide immediate decisions about empiric TB treatment and the need for further or repeat testing.",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Click here to visit Flutter',
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL('https://flutter.dev');
                    },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
