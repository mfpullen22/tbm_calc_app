// ignore_for_file: sized_box_for_whitespace

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "dart:math";

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _csfWbcCount = TextEditingController();
  var _csfDifferential = "None";
  final TextEditingController _csfGlucose = TextEditingController();
  final TextEditingController _bloodGlucose = TextEditingController();
  var _crag = "Negative";
  var _fever = "No";
  var _hiv = "Negative";
  double? _csfWbcVal;
  double? _csfDiffVal;
  double? _csfGluVal;
  double? _bloodGluVal;
  double? _cragVal;
  double? _feverVal;
  double? _hivVal;
  double? odds;
  double? prob;
  String? interp;
  String? probString;
  Color? textColor;

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      _csfWbcVal = double.parse(_csfWbcCount.text) < 5
          ? 2.5 * (-0.0007810009)
          : double.parse(_csfWbcCount.text) * (-0.0007810009);

      if (_csfDifferential == "Neutrophilic") {
        _csfDiffVal = 1.51411468;
      } else if (_csfDifferential == "Lymphocytic") {
        _csfDiffVal = 1.556377121;
      } else {
        _csfDiffVal = 0;
      }

      _csfGluVal = double.parse(_csfGlucose.text) < 20
          ? 5.5 * (-0.0407057558)
          : double.parse(_csfGlucose.text) * (-0.0407057558);

      _bloodGluVal = double.parse(_bloodGlucose.text) < 11
          ? 5.5 * (0.0060103239)
          : double.parse(_bloodGlucose.text) * (0.0060103239);

      _cragVal = _crag == "Positive" ? (-3.502162269) : 0;

      _feverVal = _fever == "Yes" ? 0.4718978543 : 0;

      _hivVal = _hiv == "Positive" ? 0.1284248176 : 0;

      odds = exp(_csfWbcVal! +
          _csfDiffVal! +
          _csfGluVal! +
          _bloodGluVal! +
          _cragVal! +
          _feverVal! +
          _hivVal! +
          (-0.6318415877));
      //print(_csfWbcVal);
      //print(_csfDiffVal);
      //print(_csfGluVal);
      //print(_bloodGluVal);
      //print(_cragVal);
      //print(_feverVal);
      //print(_hivVal);
      //print(odds);
      prob = (odds! / (1 + odds!)) * 100;
      //print(prob);
      // ignore: prefer_interpolation_to_compose_strings
      probString = prob!.toStringAsFixed(2) + "%";

      if (prob! <= 5) {
        textColor = Colors.blue;
        interp =
            "Very unlikely to be TB meningitis. Consider another diagnosis in your differential.";
      } else if (prob! > 5 && prob! < 40) {
        textColor = Colors.yellow[800];
        interp = "Possible TB meningitis. Consider further diagnostic testing.";
      } else {
        textColor = Colors.red;
        interp = "Very likely TB meningitis. Consider starting treatment.";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text("Result",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black))),
            content: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "TB Meningitis Probability:  ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text(probString!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: textColor)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(interp!),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("Error")),
            content: const Text(
                "Please review the data you entered and ensure you have entered valid numbers in the relevant fields."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fieldWidth = 105.0;
    const double spacing = 10.0;

    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/background_blue.svg",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Center(
          child: FractionallySizedBox(
            heightFactor: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("CSF WBC Count (cells/mm\u00B3):",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: _csfWbcCount,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_csfWbcCount.text.isNotEmpty &&
                          double.parse(_csfWbcCount.text) > 2.5)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("CSF Differential:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.black)),
                                const SizedBox(width: spacing),
                                Container(
                                  width: fieldWidth,
                                  child: DropdownButtonFormField<String>(
                                      value: "None",
                                      items: [
                                        "None",
                                        "Neutrophilic",
                                        "Lymphocytic"
                                      ].map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _csfDifferential = value!;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("CSF Glucose (md/dL):",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: _csfGlucose,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Blood Glucose (md/dL):",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                  ],
                                  controller: _bloodGlucose,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cryptococcal Antigen:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: DropdownButtonFormField<String>(
                                    value: "Negative",
                                    items: [
                                      "Negative",
                                      "Positive",
                                    ].map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _crag = value!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fever \u2265 37.8\u00B0C",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: DropdownButtonFormField<String>(
                                    value: "No",
                                    items: [
                                      "No",
                                      "Yes",
                                    ].map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _fever = value!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("HIV Status:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(width: spacing),
                              Container(
                                width: fieldWidth,
                                child: DropdownButtonFormField<String>(
                                    value: "Negative",
                                    items: [
                                      "Negative",
                                      "Positive",
                                    ].map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _hiv = value!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _calculate();
                          },
                          child: const Text("Calculate"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
