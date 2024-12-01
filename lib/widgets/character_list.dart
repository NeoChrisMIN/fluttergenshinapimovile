import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';
import '../pages/character_detail_page.dart';
import '../utils/utils.dart';

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

final url = '$urlBaseGlobal';

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
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
      body: Column(
        children: [
          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search by name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Lista de personajes
          Expanded(
            child: characters.isEmpty && isLoading
                ? const Center(child: CircularProgressIndicator())
                : characters.isEmpty
                    ? const Center(child: Text('No characters found'))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: characters.length + (hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == characters.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final character = characters[index];
                          return Card(
                            color: Colors.grey[800],
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
                                      )
                                    : const Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                              ),
                              title: Text(
                                character.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Rarity: ${character.rarity}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CharacterDetailPage(
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
    );
  }
}
