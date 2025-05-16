import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic heroTag;
  final Map<String, dynamic> raza;

  const DetailsScreen({super.key, required this.heroTag, required this.raza});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _flechaAtras(),
          _nombrePerromon(),
          _pokefondo(),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    _datoRow("Raza", widget.raza['Raza'] ?? ''),
                    _datoRow("Altura", widget.raza['Altura'] ?? ''),
                    _datoRow("Peso", widget.raza['Peso'] ?? ''),
                    _datoRow("Esperanza de vida", widget.raza['Esperanza de vida'] ?? ''),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: (height * 0.2),
            child: Hero(
              tag: widget.heroTag,
              child: Image.asset(
                widget.raza['Link Imagen'] ?? '',
                height: 200,
                width: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datoRow(String titulo, String valor) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: width * 0.3,
            child: Text(
              titulo,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            child: Text(
              valor,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flechaAtras() {
    return Positioned(
      top: 25,
      left: 5,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, size: 35),
      ),
    );
  }

  Widget _nombrePerromon() {
    return Positioned(
      top: 90,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Text(
            widget.raza['Raza'] ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _pokefondo() {
    var height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.18,
      right: -30,
      child: Image.asset(
        'images/pokeball.png',
        height: 200,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}


