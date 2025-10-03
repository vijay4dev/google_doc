import 'package:google_doc/clients/socket_clients.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepo {
  final _socketclient = SocketClients.instance.socket!;

  Socket get socketclient => _socketclient;

  void joinRoom(String documentId) {
    _socketclient.emit('join', documentId);
  }

}