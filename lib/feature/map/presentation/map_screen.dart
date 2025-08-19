import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Map<MarkerId, Marker> _markers = {};
  final Map<String, Place> _places = {};

  // Sample initial location
  final LatLng _center = const LatLng(37.42796133580664, -122.085749655962);

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final List<Place> places = [
      Place(
        id: '1',
        name: 'WorkVibe Downtown',
        latLng: LatLng(37.422, -122.084),
        imageUrl: '1.jpg',
        phone: 'XXXX-XXXX-1234',
        description:
            'A vibrant co-working space in the heart of NYC, perfect for freelancers and startups with a modern, open-plan design.',
      ),

      Place(
        id: '3',
        name: 'Creative Hub',
        latLng: LatLng(37.4419, -122.1430),
        imageUrl: '2.jpg',
        phone: 'XXXX-XXXX-5678',
        description:
            'A cozy space for creatives, offering a relaxed environment with plenty of natural light and collaborative areas.',
      ),

      Place(
        id: '3',
        name: 'The Loft',
        latLng: LatLng(37.4852, -122.2364),
        imageUrl: '3.jpg',
        phone: 'XXXX-XXXX-9012',
        description:
            'A spacious, innovative workspace in Berlin, designed for startups and entrepreneurs with 24/7 access.',
      ),

      Place(
        id: '4',
        name: 'Urban Nest',
        latLng: LatLng(37.4323, -121.8996),
        imageUrl: '1.jpg',
        phone: 'XXXX-XXXX-2345',
        description:
            'A welcoming co-working space with quiet zones and ergonomic seating, perfect for focused work in Toronto.',
      ),
    ];

    for (final place in places) {
      final markerId = MarkerId(place.id);
      final marker = Marker(
        markerId: markerId,
        position: place.latLng,
        infoWindow: InfoWindow(title: place.name),
        onTap: () => _showPlaceDetails(place),
      );

      _markers[markerId] = marker;
      _places[place.id] = place;
    }
  }

  void _showPlaceDetails(Place place) {
    showModalBottomSheet(
      context: context,
      builder: (context) => PlaceDetailsSheet(place: place),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => navigatorKey.currentState!.pop(),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Config.greenClr),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("Map"),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: CameraPosition(target: _center, zoom: 8.0),
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }
}

class Place {
  final String id;
  final String name;
  final LatLng latLng;
  final String imageUrl;
  final String phone;
  final String description;

  Place({
    required this.id,
    required this.name,
    required this.latLng,
    required this.imageUrl,
    required this.phone,
    required this.description,
  });
}

class PlaceDetailsSheet extends StatelessWidget {
  final Place place;

  const PlaceDetailsSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          spaceHeight(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                place.name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Config.greenClr),
                onPressed: ()=>navigatorKey.currentState!.pushNamed("/detail",arguments: place.id),
              
               child: Text("vist"))
            ],
          ),
          spaceHeight(12),

          SizedBox(
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.asset(
                "assets/images/${place.imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          spaceHeight(12),

          Row(
            children: [
              Icon(Icons.phone, size: 20),
              SizedBox(width: 8),
              Text(place.phone),
            ],
          ),
          SizedBox(height: 8),
          Text(place.description),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
