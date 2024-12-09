import 'package:flutter/material.dart';
import '../models/weapon_model.dart';
import '../utils/utils.dart';

final url = '$urlBaseGlobal' + '/storage';

class WeaponDetailPage extends StatelessWidget {
  final Weapon weapon;

  WeaponDetailPage({required this.weapon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Color de los íconos en el AppBar
        ),
        backgroundColor: Colors.black87, // Fondo negro translúcido
        elevation: 0,
        title: Text(
          weapon.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Fondo global
          Positioned.fill(
            child: Image.asset(
              'images/fondo.png', // Imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Imagen del arma
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.5), // Fondo oscuro translúcido
                    borderRadius:
                        BorderRadius.circular(8.0), // Bordes redondeados
                    image: weapon.image != null
                        ? DecorationImage(
                            image: NetworkImage(url + weapon.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: weapon.image == null
                      ? const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.white54,
                        )
                      : null,
                ),
              ),
              // Título "Details"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.black.withOpacity(0.8),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.zero, // Sin margen externo
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 3),
                    child: Text(
                      "Details",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // Detalles del arma
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.8), // Fondo oscuro translúcido
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0), // Bordes redondeados completos
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDetailText('Type', weapon.type),
                          buildDetailText(
                              'Base Attack', weapon.baseAttack.toString()),
                          buildDetailText('Sub Stat', weapon.subStat),
                          if (weapon.passiveName != null)
                            buildMultilineDetailText(
                                'Passive Name', weapon.passiveName!),
                          if (weapon.passiveDesc != null)
                            buildMultilineDetailText(
                                'Passive Description', weapon.passiveDesc!),
                          buildDetailText('Location', weapon.location),
                          buildDetailText(
                              'Ascension Material', weapon.ascensionMaterial),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2), // Fondo gris translúcido
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMultilineDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity, // Ocupa todo el ancho disponible
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2), // Fondo gris translúcido
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.justify, // Alineación justificada
            ),
          ],
        ),
      ),
    );
  }
}
