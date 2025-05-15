import 'package:flutter/material.dart';
import 'razas_provider.dart';

class ListaRazas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: cargarRazas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final razas = snapshot.data!;
        return ListView.builder(
          itemCount: razas.length,
          itemBuilder: (context, index) {
            final raza = razas[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: raza['Link Imagen'] != null && raza['Link Imagen'] != ''
                    ? Image.asset(
                  raza['Link Imagen'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                )
                    : Icon(Icons.image_not_supported),
                title: Text(raza['Raza'] ?? 'Raza desconocida'),
                subtitle: Column(
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
