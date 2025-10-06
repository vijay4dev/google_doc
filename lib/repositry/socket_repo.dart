import 'package:google_doc/clients/socket_clients.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepo {
  final Socket _socket = SocketClient.instance.socket!;
  String? _currentDocId;

  SocketRepo() {
    _socket.on('connect', (_) {
      print('✅ client connected: ${_socket.id}');
      if (_currentDocId != null) _emitJoin(_currentDocId!);
    });

    _socket.on('disconnect', (reason) {
      print('⚠️ client disconnected: $reason');
    });

    _socket.on('connect_error', (err) {
      print('❌ connect_error: $err');
    });
  }

  void joinRoom(String documentId) {
    _currentDocId = documentId;
    if (_socket.connected) {
      _emitJoin(documentId);
    } else {
      _socket.connect();
    }
  }

  void _emitJoin(String documentId) {
    print("📤 Emitting startdoc for: $documentId");
    _socket.emitWithAck('startdoc', documentId, ack: (data) {
      print('🟢 join ack: $data');
    });
  }

  void typing(Map<String, dynamic> data){
    _socket.emit("typing", data);
  }

  void changelistner(Function(Map<String,dynamic>) func){
    _socket.on('changes' , (data) => func(data));
  }
}