import 'package:flutter/material.dart';
import '../controlador/razas_provider.dart'; // Importa función que carga las razas

class ListaRazas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>( // Espera datos del JSON
      future: cargarRazas(), // Carga la lista de razas
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Muestra loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Muestra error
        }

        final razas = snapshot.data!; // Obtiene la lista de razas
        return ListView.builder( // Lista dinámica
          itemCount: razas.length,
          itemBuilder: (context, index) {
            final raza = razas[index];
            return Card( // Tarjeta por cada raza
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: raza['Link Imagen'] != null && raza['Link Imagen'] != ''
                    ? Image.asset( // Muestra imagen si existe
                  raza['Link Imagen'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error), // Ícono si falla imagen
                )
                    : Icon(Icons.image_not_supported), // Ícono si no hay imagen
                title: Text(raza['Raza'] ?? 'Raza desconocida'), // Nombre raza
                subtitle: Column( // Detalles adicionales
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Talla: ${raza['Talla']}'),
                    Text('Peso: ${raza['Peso']}'),
                    Text('Altura: ${raza['Altura']}'),
                    Text('Origen: ${raza['Origen']}'),
                    Text('Esperanza de vida: ${raza['Esperanza de vida']}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
