library ip.foundation;

import 'package:raw/raw.dart';

export 'package:raw/raw.dart'
    show RawEncodable, RawDecodable, RawWriter, RawReader;

abstract class Packet extends RawValue {
  Protocol get protocol;
}

class Protocol {
  final String name;
  final PacketFactory? packetFactory;
  final int? ipProtocolNumber;

  const Protocol(this.name, {this.packetFactory, this.ipProtocolNumber});
}

typedef PacketFactory = Packet Function();
