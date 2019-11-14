class Alert {
  final String id;
  final String alertType;
  final double latitude;
  final double longitude;
  final String address;
  final String message;
  final String userIdentification;
  final String imageLink;
  final String videoLink;
  final String created;
  final String alertStatus;

  Alert(this.id, this.alertType, this.latitude, this.longitude, this.address, this.message, this.userIdentification, this.imageLink, this.videoLink, this.created, this.alertStatus);

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(json['id'], json['alertType'], json['latitude'], json['longitude'], json['address'],
        json['message'], json['userIdentification'], json['imageLink'], json['videoLink'], json['created'], json['alertStatus']);
  }
}