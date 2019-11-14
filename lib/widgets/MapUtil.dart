import 'dart:html' as html;

class MapUtil {
  static openMap(double latitude, double longitude) {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    html.window.open(googleUrl, '_blank');
  }
}