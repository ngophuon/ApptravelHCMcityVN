import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map_sc1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAP ',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: content(),
    );
  }
  Widget content() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(10.777202, 106.695413), // Thay đổi tọa độ thành TPHCM
        initialZoom: 16,
        interactionOptions:
            const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(markers: [
          Marker(
            point: LatLng(10.777202, 106.695413), // tọa độ dinh độc lập
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,

            child:Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ), ),
        ])
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );




