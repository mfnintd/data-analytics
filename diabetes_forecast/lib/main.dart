import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

const intercept = -4.21656006;
const coef = [3.44013390e-02, 2.74025093e-02, -2.45721480e-02, 2.50828523e-02, -2.37663255e-04, 6.50349263e-03, 4.76993906e-01, 1.70598430e-02];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final pregnancies = TextEditingController();
  final glucose = TextEditingController();
  final bloodPressure = TextEditingController();
  final skinThickness = TextEditingController();
  final insulin = TextEditingController();
  final bmi = TextEditingController();
  final diabetesPedigreeFunction = TextEditingController();
  final age = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  double? result;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
            key: _formKey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Enter your infomation!"),
                        TextFormField(
                          controller: pregnancies,
                          decoration: const InputDecoration(
                            label: Text("Number of times pregnant"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: glucose,
                          decoration: const InputDecoration(
                            label: Text("Glucose"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: bloodPressure,
                          decoration: const InputDecoration(
                            label: Text("Diastolic blood pressure"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: skinThickness,
                          decoration: const InputDecoration(
                            label: Text("Triceps skin fold thickness"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: insulin,
                          decoration: const InputDecoration(
                            label: Text("2-Hour serum insulin"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: bmi,
                          decoration: const InputDecoration(
                            label: Text("BMI"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: diabetesPedigreeFunction,
                          decoration: const InputDecoration(
                            label: Text("Diabetes pedigree function"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: age,
                          decoration: const InputDecoration(
                            label: Text("Age "),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                final tmp = [
                                  pregnancies.text,
                                  glucose.text,
                                  bloodPressure.text,
                                  skinThickness.text,
                                  insulin.text,
                                  bmi.text,
                                  diabetesPedigreeFunction.text,
                                  age.text,
                                ];
                                final x = List.generate(tmp.length, (e) => double.parse(tmp[e]));
                                result = predictProbability(x);
                              });
                            }
                          },
                          child: const Text("Evaluate"),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dự đoán"),
                      if (result != null) Text("Khả năng mắc bệnh tiểu đường: ${(result! * 100).toStringAsFixed(2)}%"),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

double sigmoid(double logit) {
  return 1 / (1 + exp(-logit));
}

double predictProbability(List<double> X) {
  if (coef.length != X.length) {
    throw ArgumentError('Số lượng hệ số hồi quy phải bằng số lượng biến đầu vào.');
  }

  // Tính logit(p)
  double logitP = intercept;
  for (int i = 0; i < coef.length; i++) {
    logitP += coef[i] * X[i];
  }

  // Tính xác suất (p) bằng hàm sigmoid
  return sigmoid(logitP);
}
