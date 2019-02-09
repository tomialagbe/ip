import 'package:ip/foundation.dart';
import 'package:ip/ip.dart';
import 'package:raw/raw.dart';

const Protocol icmp = Protocol("icmp", packetFactory: _newImpPacket);

Packet _newImpPacket() => IcmpPacket();

class IcmpPacket extends Packet {
  static const int typeEchoReply = 0;
  static const int typeDestinationUnreachable = 3;
  static const int typeSourceQuench = 4;
  static const int typeRedirectMessage = 5;
  static const int typeEchoRequest = 8;
  static const int typeRouterAdvertisement = 9;
  static const int typeRouterSolicitation = 10;
  static const int typeEchoTimeExceeded = 11;
  static const int typeParameterProblem = 12;

  @override
  Protocol get protocol => icmp;

  int type = 0;
  int code = 0;
  int restOfHeader = 0;
  SelfEncoder payload = RawData.empty;

  @override
  void decodeSelf(RawReader reader) {
    type = reader.readUint8();
    code = reader.readUint8();
    reader.readUint16(); // Ignore checksum
    restOfHeader = reader.readUint32();
    payload = RawData.decode(reader, reader.availableLengthInBytes);
  }

  @override
  void encodeSelf(RawWriter writer) {
    final start = writer.length;
    writer.writeUint8(type);
    writer.writeUint8(code);
    writer.writeUint16(0);
    writer.writeUint32(restOfHeader);
    payload.encodeSelf(writer);
    final checksum = Ip4Packet.calculateChecksum(
        writer.bufferAsByteData, start, writer.length);
    writer.bufferAsByteData.setUint16(start + 2, checksum);
  }
}
