import 'package:flutter/material.dart';
import 'package:chef_vision_ai/core/theme/chef_vision_theme.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de datos del inventario
    final List<Map<String, dynamic>> items = [
      {"nombre": "Manzana Roja", "caducidad": "2 días", "status": "Próxima a vencer", "color": ChefVisionTheme.sunsetOrange},
      {"nombre": "Pechuga de Pollo", "caducidad": "hoja", "status": "Urgente", "color": Colors.redAccent},
      {"nombre": "Pimiento Verde", "caducidad": "5 días", "status": "Fresco", "color": ChefVisionTheme.electricOlive},
      {"nombre": "Aguacate", "caducidad": "1 día", "status": "Perfecto para hoy", "color": ChefVisionTheme.electricOlive},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventario Inteligente", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: item['color'].withOpacity(0.2),
                child: Icon(Icons.restaurant, color: item['color'], size: 20),
              ),
              title: Text(item['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Caduca en: ${item['caducidad']}", style: TextStyle(color: Colors.white70, fontSize: 13)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item['color'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['status'],
                      style: TextStyle(color: item['color'], fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
