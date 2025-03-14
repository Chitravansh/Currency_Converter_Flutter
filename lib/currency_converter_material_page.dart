// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPage();
}

class _CurrencyConverterMaterialPage
    extends State<CurrencyConverterMaterialPage> {
  double amount = 0;
  double? result = 0;
  String? fromCurrency = "USD";
  String? toCurrency = "INR";
  String errorMessage = "";
  List<String> currencies = [];
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkInternetConnection();

    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        checkInternetConnection();
      } else {
        fetch(); // Fetch currencies when the widget is created
      }
    });
  }

  void checkInternetConnection() async {
    await Future.delayed(Duration(milliseconds: 500));
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('No Internet'),
                content: Text('Please check your internet connection'),
                actions: [
                  TextButton(
                    child: Text("Retry"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      checkInternetConnection();
                    },
                  ),
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
    ;
  }

  void convert() async {
    if (textEditingController.text.isNotEmpty) {
      try {
        amount = double.parse(textEditingController.text);
        result = await convertCurrency("$fromCurrency", "$toCurrency", amount);
        setState(() {});
      } catch (e) {
        setState(() {
          errorMessage =
              "Conversion failed. Please try again."; // Display error message in UI
        });
      }
    }
  }

  void fetch() async {
    try {
      currencies = await fetchCurrencyCodes();
      setState(() {});
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Conversion not Done !"),
              content:
                  Text('Please check your internet connection \n or try again'),
              actions: [
                TextButton(
                  child: Text("Retry"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    checkInternetConnection();
                  },
                ),
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }
  // const CurrencyConverterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 2, 139, 0.959),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 17, 164),
        title: const Text(
          'Currency Converter',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                const Text(
                  "FROM: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DropdownButton<String>(
                    value: fromCurrency,
                    items: currencies.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue;
                      });
                    },
                    dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  "TO: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DropdownButton<String>(
                    value: toCurrency,
                    items: currencies.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        toCurrency = newValue;
                      });
                    },
                    dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  errorText: "",
                  hintStyle: TextStyle(
                    // backgroundColor : Color.fromRGBO(174, 174, 174, 0.275),
                    color: Color.fromARGB(255, 11, 1, 1),
                  ),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Color.fromARGB(255, 7, 7, 7),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
              ),
            ),
            // button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // if (kDebugMode) {
                  //   print('Button Clicked');
                  // }
                  if (toCurrency == fromCurrency) {
                    // Corrected AlertDialog Implementation
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Enter Different Currencies'),
                          content: const Text(
                             " Try Conversion with Different Currencies.\nFrom and To fields can't be same."),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    convert();
                  }
                },
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(15),
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 50),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                  ),
                ),
                child: Text('Convert'),
              ),
            ),
            Text(errorMessage.toString()),
          ],
        ),
      ),
    );
  }
}
