class VpnStatusModel {
  VpnStatusModel(
      {this.duration, this.lastPacketReceive, this.byteIn, this.byteOut});

  String? duration;
  String? lastPacketReceive;
  String? byteIn;
  String? byteOut;

  factory VpnStatusModel.fromJson(Map<String, dynamic> json) => VpnStatusModel(
        duration: json['duration'],
        lastPacketReceive: json['last_packet_receive'],
        byteIn: json['byte_in'],
        byteOut: json['byte_out'],
      );

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'last_packet_receive': lastPacketReceive,
        'byte_in': byteIn,
        'byte_out': byteOut
      };
}
