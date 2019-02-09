import 'package:ip/ip.dart';
import 'package:raw/raw.dart';

void printPacketInfo(List<int> bytes) {
  // Decode packet
  final reader = new RawReader.withBytes(bytes);
  final packet = IpPacket.decode(reader);

  // Print some information
  print("Source: ${packet.source}");
  print("Destination: ${packet.destination}");
}