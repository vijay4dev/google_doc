import 'package:google_doc/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      // try letting socket.io negotiate the best transport:
      // 'transports': ['websocket', 'polling'],
      'autoConnect': false,
      'reconnection': true,
    });

    socket!.onConnect((_) {
      print("✅ Connected to server");
    });

    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
