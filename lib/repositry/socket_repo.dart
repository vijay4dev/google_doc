import 'package:google_doc/clients/socket_clients.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepo {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String documentId) {
     print("📤 Emitting join with documentId: $documentId");
    _socketClient.emit('join', documentId);
  }
}