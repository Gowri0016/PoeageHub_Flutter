import 'dart:convert';
import 'package:http/http.dart' as http;

class PincodeApiResult {
  final String? city;
  final String? state;
  final String? district;
  final bool found;

  PincodeApiResult({this.city, this.state, this.district, this.found = false});

  factory PincodeApiResult.fromApi(Map<String, dynamic> json) {
    final postOffices = json['PostOffice'] as List?;
    if (postOffices != null && postOffices.isNotEmpty) {
      final office = postOffices[0];
      return PincodeApiResult(
        city: office['Block'] ?? office['District'],
        state: office['State'],
        district: office['District'],
        found: true,
      );
    }
    return PincodeApiResult(found: false);
  }
}

class PincodeApiHelper {
  static Future<PincodeApiResult?> fetchDetails(String pincode) async {
    final url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      if (data.isNotEmpty && data[0]['Status'] == 'Success') {
        return PincodeApiResult.fromApi(data[0]);
      }
    }
    return null;
  }
}
