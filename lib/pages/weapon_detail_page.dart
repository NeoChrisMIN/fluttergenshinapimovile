import 'package:flutter/material.dart';
import '../models/weapon_model.dart';
import '../utils/utils.dart';

final url = '$urlBaseGlobal';

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
        backgroundColor: Colors.black87,
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
              // Imagen circular del arma
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 80, // Tamaño de la imagen circular
                  backgroundColor: Colors.grey[300], // Fondo del círculo
                  backgroundImage: weapon.image != null
                      ? NetworkImage(url + weapon.image!)
                      : null,
                  child: weapon.image == null
                      ? const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              // Tarjeta con detalles
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.85), // Fondo claro con transparencia
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDetailText('Type', weapon.type),
                            buildDetailText(
                                'Base Attack', weapon.baseAttack.toString()),
                            buildDetailText('Sub Stat', weapon.subStat),
                            if (weapon.passiveName != null)
                              buildDetailText('Passive Name', weapon.passiveName!),
                            if (weapon.passiveDesc != null)
                              buildDetailText(
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
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
