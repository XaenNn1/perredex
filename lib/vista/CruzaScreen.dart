import 'package:flutter/material.dart';

class CruzaScreen extends StatefulWidget {
  final List<Map<String, dynamic>> razas; // Lista de razas recibida como parámetro

  const CruzaScreen({super.key, required this.razas});

  @override
  State<CruzaScreen> createState() => _CruzaScreenState();
}

class _CruzaScreenState extends State<CruzaScreen> {
  Map<String, dynamic>? padre; // Raza seleccionada como padre
  Map<String, dynamic>? madre; // Raza seleccionada como madre

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cruzar Perritos')), // Título de la pantalla
      body: Column(
        children: [
          Expanded(child: _buildSelector('Selecciona al padre', true)), // Selector padre
          Divider(),
          Expanded(child: _buildSelector('Selecciona a la madre', false)), // Selector  madre
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: (padre != null && madre != null)
                ? () => _mostrarResultado(context, padre!['Raza'], madre!['Raza']) // Si ambos están seleccionados, muestra resultado
                : null, // Botón deshabilitado si faltan selecciones
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Título del selector
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Lista horizontal de razas
            itemCount: widget.razas.length,
            itemBuilder: (context, index) {
              final raza = widget.razas[index];
              final seleccionada =
                  (esPadre && padre == raza) || (!esPadre && madre == raza); // Verifica si está seleccionada

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (esPadre) {
                      padre = raza;
                    } else {
                      madre = raza;
                    }
                  }); // Asigna la raza seleccionada
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                      seleccionada ? Colors.green : Colors.grey.shade400, // Nos da un borde verde si está seleccionada
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
                        raza['Link Imagen'] ?? '', // Imagen de la raza
                        height: 60,
                        errorBuilder: (context, _, __) => Icon(Icons.error),
                      ),
                      SizedBox(height: 8),
                      Text(
                        raza['Raza'] ?? '', // Nombre de la raza
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

  void _mostrarResultado(BuildContext context, String razaPadre, String razaMadre) async {
    // Genera rutas posibles de imagen combinada
    String r1 = razaPadre.toLowerCase().replaceAll(' ', '_');
    String r2 = razaMadre.toLowerCase().replaceAll(' ', '_');

    String img1 = 'images/imagenes_perros/${r1}-${r2}.jpeg';
    String img2 = 'images/imagenes_perros/${r2}-${r1}.jpeg';

    String? rutaElegida;

    try {
      await precacheImage(AssetImage(img1), context); // Intenta precargar la primera combinación
      rutaElegida = img1;
    } catch (_) {
      try {
        await precacheImage(AssetImage(img2), context); // Intenta al reves
        rutaElegida = img2;
      } catch (_) {
        rutaElegida = null; // No hay imagen disponible
      }
    }

    // Muestra el resultado en un diálogo
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Cachorro de $razaPadre + $razaMadre'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (rutaElegida != null)
              Image.asset(rutaElegida, height: 100) // Muestra imagen si existe
            else
              Text('Imagen no disponible para esta combinación.'), // Mensaje si no existe
            SizedBox(height: 10),
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
