import 'package:flutter/services.dart';

import '../models/intern_position.dart';

class ApiService {
  Future<List<InternPosition>> getData() async {
    String data = await rootBundle.loadString('assets/position.json');
    final jsonResult = internPositionResponseFromJson(data);

    return jsonResult.data;
  }
}
