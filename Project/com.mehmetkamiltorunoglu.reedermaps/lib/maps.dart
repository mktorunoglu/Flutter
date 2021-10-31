import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Özelleştirilmiş değişkenler ve fonksiyonlar tanımlanmıştır.

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double currentZoom = 13; // Başlangıç ve anlık zoom değeri.
  double distance =
      0.0001; // Anlık konum ile hedef nokta (reeder) arasındaki Latitude ve Longitude değerlerinin farkı, eşik değeri. Reeder konumunun haritadaki bölgesinden aldığım konumları örnekleme ile bir eşik değer bulmaya çalıştım. Bu değer, anlık konum ve hedef arasındaki mesafe olarak düşünülebilir.

  bool _isRouteActive =
      false; // Rota açıldığında veya kapatıldığında belirli durumları tetikler.
  bool _getPolyline =
      false; // Rotanın oluşturulup oluşturulmayacağını kontrol eder.

  final LatLng _initialLatLng =
      const LatLng(41.2699189, 36.3318964); // Başlangıç (kamera) konumu
  LatLng reederLatLng =
      const LatLng(41.233114500764216, 36.43003147639794); // reeder konumu

  MapType _mapType = MapType.normal;
  BitmapDescriptor reederLocationIcon = BitmapDescriptor.defaultMarker;
  final Location _locationTracker = Location();
  Marker _myLocationMarker = const Marker(markerId: MarkerId("null"));
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints = PolylinePoints();

  late GoogleMapController _controller;
  late StreamSubscription<LocationData> _locationSubscription;

  Set<Marker> _createMarker() {
    return <Marker>{
      _myLocationMarker, // Anlık konumda gösterilen Marker
      Marker(
          // reeder konumunda gösterilen Marker
          markerId: const MarkerId("reederMarker"),
          position: reederLatLng,
          icon: reederLocationIcon,
          infoWindow: const InfoWindow(
            title: "Reeder Samsun Operasyon Merkezi",
          ),
          onTap: () {
            // reeder Markerına tıklandığında reeder ile ilgili iletişim bilgilerini içeren bir pencere gösterilir. Bu pencereden anlık konum ile reeder arasında bir rota oluşturulabilir.
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return ListView(
                    padding: const EdgeInsets.all(30),
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.blue),
                                        ),
                                        imageUrl: // İnternetten çekilen reeder kapak resminin bağlantısı
                                            "https://raw.githubusercontent.com/mktorunoglu/_sharedSources/main/reederMaps/reeder_cover.jpg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: FloatingActionButton(
                                  child: const Icon(Icons.navigation),
                                  onPressed: () {
                                    setState(() {
                                      _getPolyline = true;
                                    }); // Rota oluşturulması için değer güncellenir.
                                    Navigator.pop(context);
                                    getCurrentLocation(); // Anlık konum alınarak rota oluşturulur.
                                  },
                                  backgroundColor: Colors.green,
                                  tooltip: "Rota oluştur",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Reeder Samsun Operasyon Merkezi",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                    "Kerimbey, Organize Sanayi Cd., 55330 Tekkeköy/Samsun"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.public,
                                    color: Colors.blue,
                                  ),
                                ),
                                Flexible(
                                  child: Text("reeder.com.tr"),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                              ),
                              Flexible(
                                child: Text("08508117333"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                });
          }),
    };
  }

  Set<Circle> _createCircle() {
    return <Circle>{
      Circle(
        circleId: const CircleId(
            "reederCircle"), // reeder Markerının çevresindeki daire
        radius: 40,
        center: reederLatLng,
        strokeColor: Colors.blue.shade100,
        fillColor: Colors.blue.shade100,
      ),
    };
  }

  Future<void> _createMarkerImageFromAsset() async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context);

    BitmapDescriptor.fromAssetImage(imageConfiguration,
            'assets/images/reeder_location_icon.png') // assets/images klasöründeki reeder Marker resmi harita üzerinde gösterilmek üzere bitmape dönüştürülüp ilgili değişkene atanır.
        .then((bitmap) {
      setState(() {
        reederLocationIcon = bitmap;
      });
    });
  }

  void getCurrentLocation() async {
    // Haritada anlık konumu gösterir. Konum sürekli güncellenir.
    setState(() {
      _isRouteActive = true;
    });

    try {
      var location = await _locationTracker.getLocation();
      updateMyLocation(location);

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLatLng) {
        // Anlık konuma göre kamera açısı sürekli güncellenir.
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(newLatLng.latitude!, newLatLng.longitude!),
                zoom:
                    currentZoom, // Kullanıcının belirlediği zoom değerinde kalır.
              ),
            ),
          );
          updateMyLocation(newLatLng);
          if (_getPolyline) {
            // Rota oluşturulacaksa çalışır.
            setPolylines(newLatLng.latitude, newLatLng.longitude);
          }
          checkRoute(
              newLatLng.latitude!,
              newLatLng
                  .longitude!); // Güncellenen anlık konumlarda hedefe varılıp varılmadığını kontrol eder.
        }
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrint("İzin reddedildi.");
      }
    }
  }

  void checkRoute(double latitude, double longitude) {
    // Eşik değeri belirlemek ve takip etmek için kullandığım yazdırma metotları
    print("anlık konum ve reeder arasındaki latitude farkı = " +
        diff(latitude, reederLatLng.latitude).toString());
    print("anlık konum ve reeder arasındaki longitude farkı = " +
        diff(longitude, reederLatLng.longitude).toString());

    if (diff(latitude, reederLatLng.latitude) < distance &&
        diff(longitude, reederLatLng.longitude) < distance) {
      // Anlık konum ve hedef arasındaki fark, örnekleme ile belirlediğim eşik değerden düşük olduğunda hedefin menziline girildiğini varsaydım.
      SnackBar snackBar = SnackBar(
        content: const Text(
            "reeder'a Hoşgeldiniz!"), // Anlık konum, hedefin menziline girdiğinde SnackBar bildirimi gösterilir.
        duration: const Duration(minutes: 5),
        action: SnackBarAction(
          label: "Kapat",
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      stopRoute();
      print("reeder'a Hoşgeldiniz!");
    }
  }

  void stopRoute() {
    // Rotanın durdurulması gereken yerlerde çağırılır.
    if (_isRouteActive) {
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      setState(() {
        _getPolyline = false; // Tekrar rotanın oluşturulmasını engeller.

        if (_polylines.isNotEmpty) {
          _polylines.clear(); // Rotayı siler.
        }
        _isRouteActive = false;
      });
    }
  }

  double diff(double a, double b) {
    // Anlık konum ve hedef arasındaki farkı aldığım metot
    if (a < b) {
      return (b - a);
    }
    return (a - b);
  }

  void updateMyLocation(LocationData newLatLng) {
    LatLng latLng = LatLng(newLatLng.latitude!, newLatLng.longitude!);
    _controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, currentZoom));

    setState(() {
      _myLocationMarker = Marker(
        // Anlık konumda gösterilen Markerın oluşturulması
        markerId: const MarkerId("myLocation"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: const InfoWindow(
          title: "Şu anda buradasın",
        ),
      );
    });
  }

  void _onGeoChanged(CameraPosition position) {
    setState(() {
      currentZoom = position
          .zoom; // Kullanıcı zoom ayarını değiştirdiğinde o zoom ayarında rotanın gösterilmesini sağlar.
    });
  }

  void setPolylines(_originLatitude, _originLongitude) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAQI_4zR3Ta_cxOqJL0GLeMdhQcQzmA5F8", // Directions APIsinden anlık konum ve hedef arasındaki rotanın verileri çekilir.
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(reederLatLng.latitude, reederLatLng.longitude),
    );

    setState(() {
      if (polylineCoordinates.isNotEmpty) {
        polylineCoordinates
            .clear(); // Gidilen yerlerin rotada tekrar görünmemesi için yeni veriler çekilmeden önce eski veriler silinir.
      }
    });

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(
            point.latitude,
            point
                .longitude)); // Directions APIsinden çekilen veriler ilgili listeye eklenir.
      }

      setState(() {
        if (_polylines.isNotEmpty) {
          _polylines
              .clear(); // Gidilen yerlerin rotada tekrar görünmemesi için yeni veriler çekilmeden önce eski veriler silinir.
        }

        _polylines.add(
          // Listedeki rota verileri haritada gösterilmek üzere Polyline olarak eklenir.
          Polyline(
            polylineId: const PolylineId("polyline"),
            color: Colors.blue,
            points: polylineCoordinates,
            width: 4,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: _mapType,
            initialCameraPosition: CameraPosition(
              target: _initialLatLng, // Başlangıç konumu
              zoom: currentZoom,
            ),
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
              await _createMarkerImageFromAsset();
            },
            markers: _createMarker(),
            circles: _createCircle(),
            polylines: _polylines,
            onCameraMove: _onGeoChanged,
          ),
          const Positioned(
            top: 40,
            right: 20,
            child: SizedBox(
              height: 20,
              child: Image(
                image: AssetImage('assets/images/reeder_logo.png'),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                stopRoute();
                _controller.animateCamera(CameraUpdate.newLatLngZoom(
                    reederLatLng,
                    18)); // Tıklandığında haritada reeder konumunu gösterir.
              },
              child: const SizedBox(
                height: 30,
                child: Image(
                  image: AssetImage('assets/images/reeder_icon.png'),
                ),
              ),
              backgroundColor: Colors.black,
              tooltip: "reeder konumunu göster",
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: FloatingActionButton(
              onPressed:
                  _isRouteActive // Tıklandığında anlık konumu gösterir, tekrar tıklandığında konum göstermeyi durdurur.
                      ? () {
                          stopRoute();
                        }
                      : () {
                          getCurrentLocation();
                        },
              child: Icon(
                _isRouteActive ? Icons.pause : Icons.my_location,
                color: Colors.grey.shade700,
              ),
              backgroundColor: Colors.white,
              tooltip: _isRouteActive ? "Konumu durdur" : "Konumumu göster",
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.map_rounded,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  if (_mapType == MapType.normal) {
                    // Tıklandığında harita görünümünü değiştirir.
                    _mapType = MapType.terrain;
                  } else {
                    _mapType = MapType.normal;
                  }
                });
              },
              tooltip: "Harita görünümünü değiştir",
            ),
          ),
        ],
      ),
    );
  }
}
