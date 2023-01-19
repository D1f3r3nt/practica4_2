import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/providers.dart';

/// Widget para el navegador inferior
class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
        onTap: (value) => provider.indexMenu = value,
        elevation: 0,
        currentIndex: provider.indexMenu,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}
