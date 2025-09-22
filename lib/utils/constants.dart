import 'package:flutter_dotenv/flutter_dotenv.dart';

final String IP = dotenv.env['API_BASE_URL'] ?? "http://localhost:5000";

final String host  =  "http://${IP}:5000/";
