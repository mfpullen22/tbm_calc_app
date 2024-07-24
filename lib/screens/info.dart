import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/background_blue.svg",
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            "Peer-reviewed data supporting the model and calculations used in this app can be found ",
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'HERE',
                        style: GoogleFonts.robotoCondensed(
                            color: const Color.fromARGB(255, 78, 239, 225),
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL(
                                'https://www.ajtmh.org/view/journals/tpmd/aop/article-10.4269-ajtmh.23-0789/article-10.4269-ajtmh.23-0789.xml');
                          },
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "The Tuberculous Meningitis (TBM) diagnostic prediction model is the first, broadly generalizable clinical multivariable prediction tool for diagnosing TBM. This diagnostic prediction model was trained from data from 15 individual studies across 9 countries (n = 3,671 participants), and contains inputs for values generated from routine procedures such including a blood draw and cerebrospinal fluid (CSF) analysis.",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "This TBM diagnostic prediction model is intended for use only by health care professionals. In the context of suspected TBM, we suggest that the TBM diagnostic prediction model results should be used in conjunction with the experience of the treating clinician to guide immediate decisions about empiric TB treatment and the need for further or repeat testing.",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "App created by ",
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Matthew F. Pullen MD',
                        style: GoogleFonts.robotoCondensed(
                            color: const Color.fromARGB(255, 78, 239, 225),
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL('https://www.mfpullenmd.com');
                          },
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
