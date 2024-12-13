import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';
import '../pages/character_detail_page.dart';
import '../utils/utils.dart';

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

final url = '$urlBaseGlobal' + '/storage';

class _CharacterListState extends State<CharacterList> {
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Character> characters = [];
  String searchQuery = '';
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
        _resetAndFetchCharacters();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _resetAndFetchCharacters() {
    setState(() {
      characters.clear();
      currentPage = 1;
      hasMore = true;
    });
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newCharacters = await apiService.fetchCharactersPaginated(
        query: searchQuery,
        page: currentPage,
        perPage: 10,
      );
      setState(() {
        characters.addAll(newCharacters);
        currentPage++;
        if (newCharacters.isEmpty) {
          hasMore = false;
        }
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectar con la base de datos')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMore) {
      _fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'images/fondo.png',
              fit: BoxFit.cover,
            ),
          ),
          // Contenido
          Column(
            children: [
              // Campo de búsqueda
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6), // Fondo oscuro
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white), // Texto blanco
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white, // Ícono blanco
                      ),
                      hintText: 'Search by name',
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Lista de personajes
              Expanded(
                child: characters.isEmpty && isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black, // Indicador de carga negro
                        ),
                      )
                    : characters.isEmpty
                        ? const Center(
                            child: Text(
                              'No characters found',
                              style: TextStyle(
                                color: Colors.white, // Texto blanco
                                fontSize: 18,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(8),
                            itemCount: characters.length + (hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == characters.length) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color:
                                      Colors.black, // Indicador de carga negro
                                ));
                              }
                              final character = characters[index];
                              return Card(
                                color: Colors.grey[800]
                                    ?.withOpacity(0.8), // Transparencia
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: character.iconBig.isNotEmpty
                                        ? Image.network(
                                            url + character.iconBig,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Usamos la imagen predeterminada en caso de error al cargar desde la red
                                              return Image.asset(
                                                'images/paimonDefault.png',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'images/paimonDefault.png',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  title: Text(
                                    character.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Rarity: ${character.rarity}',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CharacterDetailPage(
                                                character: character),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
