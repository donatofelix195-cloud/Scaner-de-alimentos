import 'package:flutter/material.dart';
import 'package:chef_vision_ai/core/theme/chef_vision_theme.dart';
import 'package:chef_vision_ai/presentation/screens/inventory_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Visor de Cámara (Placeholder)
          Container(
            color: Colors.black,
            child: const Center(
              child: Icon(
                Icons.camera_alt_outlined, 
                color: ChefVisionTheme.electricOlive, 
                size: 64,
              ),
            ),
          ),
          
          // 2. Etiquetas Dinámicas (Superposición de IA)
          Positioned(
            top: 150,
            left: 50,
            child: _IngredientLabel(name: "Manzana Roja", conf: "98%"),
          ),
          
          Positioned(
            top: 300,
            right: 40,
            child: _IngredientLabel(name: "Pimiento Verde", conf: "92%"),
          ),
          
          // 3. Panel de Macros Superior (Resumen rápido)
          const Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: _TopMacroBar(),
          ),

          // 4. Panel de Control Inferior (Uso con una sola mano)
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomControlPanel(),
          ),
        ],
      ),
    );
  }
}

class _IngredientLabel extends StatelessWidget {
  final String name;
  final String conf;
  
  const _IngredientLabel({required this.name, required this.conf});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ChefVisionTheme.electricOlive.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
        ],
      ),
      child: Text(
        "$name • $conf",
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

class _TopMacroBar extends StatelessWidget {
  const _TopMacroBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChefVisionTheme.electricOlive.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MacroStat(label: "Kcal", value: "1,420", color: ChefVisionTheme.sunsetOrange),
          _MacroStat(label: "Prot", value: "85g", color: ChefVisionTheme.electricOlive),
          _MacroStat(label: "Carb", value: "110g", color: Colors.blueAccent),
          _MacroStat(label: "Grasa", value: "45g", color: Colors.purpleAccent),
        ],
      ),
    );
  }
}

class _MacroStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  
  const _MacroStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _BottomControlPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: const BoxDecoration(
        color: ChefVisionTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ChefVision AI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ChefVisionTheme.electricOlive)),
                  Text("Reconocimiento Activo", style: TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.settings, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.inventory_2_outlined, 
                label: "Inventario", 
                color: Colors.white24,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InventoryScreen()),
                  );
                },
              ),
              _ActionButton(
                icon: Icons.restaurant_menu, 
                label: "Generar Receta", 
                color: ChefVisionTheme.electricOlive, 
                primary: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("ChefVision: Creando receta 100% offline..."),
                      backgroundColor: ChefVisionTheme.electricOlive,
                    ),
                  );
                },
              ),
              _ActionButton(
                icon: Icons.mic_none, 
                label: "Voz", 
                color: Colors.white24,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("ChefVision: Escuchando '¿Cuánta proteína tiene?'")),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool primary;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon, 
    required this.label, 
    required this.color, 
    this.primary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: primary ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)] : null,
            ),
            child: Icon(icon, color: primary ? Colors.black : Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
}
