import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/artifact_model.dart';
import '../models/weapon_model.dart';
import '../utils/utils.dart';


class ApiService {
  final baseUrl = '$urlBaseGlobal' +"/api";

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/characters'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  // Obtener una lista paginada de personajes con búsqueda
  Future<List<Character>> fetchCharactersPaginated({
    int page = 1,
    int perPage = 10,
    String query = '',
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/characters/paginate?page=$page&per_page=$perPage&search=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> characters = data['data'];
      return characters.map((character) => Character.fromJson(character)).toList();
    } else {
      throw Exception('Error al obtener los personajes: ${response.statusCode}');
    }
  }

  //----------------------------------------------------------------------------

   // Obtener un artefacto específico por ID
  Future<Artifact> fetchArtifactById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/artifacts/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Artifact.fromJson(data);
    } else {
      throw Exception('Error al obtener el artefacto: ${response.statusCode}');
    }
  }

  // Obtener una lista paginada de artefactos
  Future<List<Artifact>> fetchArtifactsPaginated({
    int page = 1,
    int perPage = 10,
    String query = '',
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/artifacts/paginate?page=$page&per_page=$perPage&search=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> artifacts = data['data'];
      return artifacts.map((artifact) => Artifact.fromJson(artifact)).toList();
    } else {
      throw Exception('Error al obtener los artefactos: ${response.statusCode}');
    }
  }


  // Obtener todos los artefactos
  Future<List<Artifact>> fetchArtifacts() async {
    final response = await http.get(Uri.parse('$baseUrl/artifacts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((artifact) => Artifact.fromJson(artifact)).toList();
    } else {
      throw Exception('Error al obtener los artefactos: ${response.statusCode}');
    }
  }


  // Obtener todas las armas
  Future<List<Weapon>> fetchWeapons() async {
    final response = await http.get(Uri.parse('$baseUrl/weapons'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((weapon) => Weapon.fromJson(weapon)).toList();
    } else {
      throw Exception('Error al obtener las armas: ${response.statusCode}');
    }
  }

  //Obtener un arma especifica
  Future<Weapon> fetchWeaponById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/weapons/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weapon.fromJson(data);
    } else {
      throw Exception('Error al obtener el arma: ${response.statusCode}');
    }
  }

  //Obtener armas paginadas
  Future<List<Weapon>> fetchWeaponsPaginated({
    int page = 1,
    int perPage = 10,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/weapons/paginate?page=$page&per_page=$perPage'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> weapons = data['data'];
      return weapons.map((weapon) => Weapon.fromJson(weapon)).toList();
    } else {
      throw Exception('Error al obtener las armas paginadas: ${response.statusCode}');
    }
  }


  
}
