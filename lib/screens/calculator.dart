import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var _csfWbcCount = TextEditingController();
  var _csfDifferential = "None";
  var _csfGlucose = TextEditingController();
  var _bloodGlucose = TextEditingController();
  var _crag = "Negative";
  var _fever = "No";
  var _hiv = "Negative";

  void _calculate() {}

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = 125.0;
    final double spacing = 16.0;

    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/background_blue.svg",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
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
                      SizedBox(width: spacing),
                      Container(
                        width: fieldWidth,
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          controller: _csfWbcCount,
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
                        SizedBox(width: spacing),
                        Container(
                          width: fieldWidth,
                          child: DropdownButtonFormField<String>(
                              value: "None",
                              items: ["None", "Neutrophilic", "Lymphocytic"]
                                  .map((String value) {
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
                      Text("Blood Glucose (md/dL):",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black)),
                      SizedBox(width: spacing),
                      Container(
                        width: fieldWidth,
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          controller: _bloodGlucose,
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
                      SizedBox(width: spacing),
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
                      SizedBox(width: spacing),
                      Container(
                        width: fieldWidth,
                        child: DropdownButton<String>(
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
                      SizedBox(width: spacing),
                      Container(
                        width: fieldWidth,
                        child: DropdownButton<String>(
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
            ],
          ),
        ),
      ],
    );
  }
}
