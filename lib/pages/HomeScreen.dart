import 'package:flutter/material.dart';
import 'package:perredex/pages/DetailsScreen.dart';
import 'package:perredex/pages/CruzaScreen.dart'; // Asegúrate de crear este archivo
import '../razas_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> razas = [];

  @override
  void initState() {
    super.initState();
    cargarRazas().then((data) {
      setState(() {
        razas = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (razas.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CruzaScreen(razas: razas)),
            );
          }
        },
        backgroundColor: Colors.green,
        tooltip: 'Cruzar perritos',
        child: Icon(Icons.favorite),
      ),
      body: Stack(
        children: [
          _fondo(),
          _titulo(),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: razas.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.4),
                      itemCount: razas.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final raza = razas[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: InkWell(
                            child: SafeArea(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25)),
                                  color: Colors.greenAccent,
                                ),
                                child: Stack(
                                  children: [
                                    _imagenpokeinterna(),
                                    _imagenperro(raza),
                                    _nombrePerromon(raza),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsScreen(
                                    heroTag: raza['Raza'],
                                    raza: raza,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondo() {
    return Positioned(
        top: -50,
        right: -50,
        child:
        Image.asset('images/pokeball.png', fit: BoxFit.fitWidth, width: 200));
  }

  Widget _titulo() {
    return Positioned(
      top: 100,
      left: 20,
      child: Text(
        'Perredex',
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _imagenpokeinterna() {
    return Positioned(
      bottom: -9,
      right: -10,
      child: Image.asset(
        'images/pokeball.png',
        height: 150,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _imagenperro(Map<String, dynamic> raza) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Hero(
        tag: raza['Raza'],
        child: Image.asset(
          raza['Link Imagen'] ?? '',
          height: 72,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _nombrePerromon(Map<String, dynamic> raza) {
    return Positioned(
      top: 15,
      left: 10,
      child: Text(
        raza['Raza'] ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}


