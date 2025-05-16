import 'package:flutter/material.dart';

class CruzaScreen extends StatefulWidget {
  final List<Map<String, dynamic>> razas;

  const CruzaScreen({super.key, required this.razas});

  @override
  State<CruzaScreen> createState() => _CruzaScreenState();
}

class _CruzaScreenState extends State<CruzaScreen> {
  Map<String, dynamic>? padre;
  Map<String, dynamic>? madre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cruzar Perritos')),
      body: Column(
        children: [
          Expanded(child: _buildSelector('Selecciona al padre', true)),
          Divider(),
          Expanded(child: _buildSelector('Selecciona a la madre', false)),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: (padre != null && madre != null)
                ? () {
              final cachorro = _cruzarPerros(padre!, madre!);
              _mostrarResultado(context, cachorro);
            }
                : null,
            icon: Icon(Icons.favorite),
            label: Text('Cruzar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSelector(String titulo, bool esPadre) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(titulo,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.razas.length,
            itemBuilder: (context, index) {
              final raza = widget.razas[index];
              final seleccionada = (esPadre && padre == raza) || (!esPadre && madre == raza);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (esPadre) {
                      padre = raza;
                    } else {
                      madre = raza;
                    }
                  });
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: seleccionada ? Colors.green : Colors.grey.shade400,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        raza['Link Imagen'] ?? '',
                        height: 60,
                        errorBuilder: (context, _, __) => Icon(Icons.error),
                      ),
                      SizedBox(height: 8),
                      Text(
                        raza['Raza'] ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _cruzarPerros(Map<String, dynamic> padre, Map<String, dynamic> madre) {
    return {
      'Raza': 'Cachorro de ${padre['Raza']} + ${madre['Raza']}',
      'Link Imagen': padre['Link Imagen'] ?? madre['Link Imagen'],
      'Color': '${padre['Color'] ?? '??'} + ${madre['Color'] ?? '??'}',
      'Tamaño': '${padre['Tamaño'] ?? '??'} / ${madre['Tamaño'] ?? '??'}',
    };
  }

  void _mostrarResultado(BuildContext context, Map<String, dynamic> cachorro) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(cachorro['Raza']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(cachorro['Link Imagen'] ?? '', height: 100),
            SizedBox(height: 10),
            Text("Color: ${cachorro['Color']}"),
            Text("Tamaño: ${cachorro['Tamaño']}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          )
        ],
      ),
    );
  }
}
