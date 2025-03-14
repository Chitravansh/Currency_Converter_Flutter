import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = "4laq4p1k8mgn3q99v3a84g3dib23cbib8m0mo89rrs0o93is3hqp8b";

Future<double> convertCurrency(String base, String to, double amount) async {
  try {
    String url =
        "https://anyapi.io/api/v1/exchange/convert?amount=$amount&apiKey=$apiKey&base=$base&to=$to";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final converted = jsonResponse['converted'];

      // print(converted);
      return converted;
    } else {
      throw Exception('Failed to fetch conversion data.');
    }
  } catch (e) {
    return 0.0;
  }
}

Future<List<String>> fetchCurrencyCodes() async {
  try {
    String url = "https://anyapi.io/api/v1/exchange/rates?apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));

    // final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final fetch = jsonDecode(response.body);
      return (fetch['rates'].keys.toList());
    } else{
      throw Exception('Failed to fetch currency codes.');
    }
  } catch (e) {
    return [];
  }

  // Decode JSON
  //  return jsonMap['rates'].keys.toList();// Extract and return currency codes
}

// void main() async {
//   // final List<String> currencyCodes =
//   // await
//   fetchCurrencyCodes(); // Example: Convert 100 USD to INR
//   // print( currencyCodes);
// }
