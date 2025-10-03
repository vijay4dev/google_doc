import 'package:google_doc/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClients {
  io.Socket? socket;

  static SocketClients? _instance;

  SocketClients.internal() {
    socket = io.io(host, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClients get instance{
    _instance??=SocketClients.internal();
    return _instance!;
  }
}
