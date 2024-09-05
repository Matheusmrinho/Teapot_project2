import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:pullebyte/theme/colors.dart';
import '../../firebase_options.dart';

class Mapa extends StatefulWidget {
  final String stadiumName;
  final Map<String, dynamic>? data;
  const Mapa({super.key, required this.stadiumName, this.data});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  bool isLoading = true;
  double? stadiumLatitude;
  double? stadiumLongitude;

  String getEscudoImageUrl(String id) {
    return 'https://pullebyte.onrender.com/get_escudo_image/$id';
  }

  @override
  void initState() {
    super.initState();
    _fetchGeoMapData(widget.stadiumName);
  }

  Future<void> _fetchGeoMapData(String stadiumName) async {
    final geoToken = DefaultFirebaseOptions.DistanceMatrixKey;
    final String url =
        'https://api.distancematrix.ai/maps/api/geocode/json?key=$geoToken&address=$stadiumName stadium';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      stadiumLatitude =
          data['result'][0]['geometry']['location']['lat'].toDouble();
      stadiumLongitude =
          data['result'][0]['geometry']['location']['lng'].toDouble();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stadiumName),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                MapboxMap(
                  accessToken: DefaultFirebaseOptions.MapboxKey,
                  styleString: 'mapbox://styles/mapbox/streets-v12',
                  initialCameraPosition: const CameraPosition(
                    // target: mapbox.LatLng(stadiumLatitude!, stadiumLongitude!),
                    target:
                        mapbox.LatLng(-8.016627050700443, -34.94370171043786),
                    zoom: 16.58,
                    tilt: 60,
                  ),
                  onMapCreated: (MapboxMapController controller) {
                    controller.animateCamera(
                      CameraUpdate.newLatLng(
                          mapbox.LatLng(stadiumLatitude!, stadiumLongitude!)),
                    );
                    controller.addSymbol(SymbolOptions(
                      geometry:
                          mapbox.LatLng(stadiumLatitude!, stadiumLongitude!),
                      iconImage: 'stadium',
                      iconSize: 1.5,
                    ));
                  },
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.2,
                  maxChildSize: 1.0,
                  snap: true,
                  snapSizes: const [0.2, 1.0],
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: customColorScheme.secondary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 50,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: customColorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: getEscudoImageUrl(
                                            widget.data!['ImgMand']),
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons
                                                .image_not_supported_outlined),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          "${widget.data!['EquipeMand']}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: customColorScheme.onPrimary,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (widget.data!["Situacao"] !=
                                          "Em andamento") ...[
                                        Text(
                                          "${widget.data!["Hora"]}\n${widget.data!["Dt"].split("/")[0]}/${widget.data!["Dt"].split("/")[1]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: customColorScheme.onPrimary,
                                          ),
                                        ),
                                      ] else ...[
                                        Text(
                                          "${widget.data!['GolsMand']} - ${widget.data!['GolsAdv']}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: customColorScheme.onPrimary,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          "${widget.data!['EquipeAdv']}",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: customColorScheme.onPrimary,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      CachedNetworkImage(
                                        imageUrl: getEscudoImageUrl(
                                            widget.data!['ImgAdv']),
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons
                                                .image_not_supported_outlined),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 5),
                                ...widget.data!["golsEqM"]
                                    .map<Widget>((golsEqM) => Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 8),
                                          margin: const EdgeInsets.only(
                                              bottom:
                                                  8), // Espaçamento entre os itens
                                          child: Text(
                                            "${golsEqM['jogador']} - ${golsEqM['min']}'",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  customColorScheme.onPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                ...widget.data!["golsEqA"]
                                    .map<Widget>((golsEqA) => Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 8),
                                          margin: const EdgeInsets.only(
                                              bottom:
                                                  8), // Espaçamento entre os itens
                                          child: Text(
                                            "${golsEqA['jogador']} - ${golsEqA['min']}'",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  customColorScheme.onPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
