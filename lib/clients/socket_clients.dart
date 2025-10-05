import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_doc/utils/constants.dart';

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      'transports': ['websocket'], // skip long-polling issues
      'autoConnect': false,
      'reconnection': true,
      'reconnectionDelay': 500,
      'reconnectionAttempts': 10,
      'timeout': 10000,
      'path': '/socket.io',        // explicit
    });

    socket!.onConnect((_) => print("✅ Connected to server"));
    // Do NOT auto connect here. Keep it controlled from repo.
  }

  static SocketClient get instance => _instance ??= SocketClient._internal();
}