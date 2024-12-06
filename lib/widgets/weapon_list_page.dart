import 'package:flutter/material.dart';
import '../models/weapon_model.dart';
import '../services/api_service.dart';
import '../pages/weapon_detail_page.dart';
import '../utils/utils.dart';

class WeaponListPage extends StatefulWidget {
  @override
  _WeaponListPageState createState() => _WeaponListPageState();
}

final url = '$urlBaseGlobal';

class _WeaponListPageState extends State<WeaponListPage> {
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Weapon> weapons = [];
  String searchQuery = '';
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchWeapons();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
        _resetAndFetchWeapons();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _resetAndFetchWeapons() {
    setState(() {
      weapons.clear();
      currentPage = 1;
      hasMore = true;
    });
    _fetchWeapons();
  }

  Future<void> _fetchWeapons() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newWeapons = await apiService.fetchWeaponsPaginated(
        page: currentPage,
        perPage: 10,
      );
      setState(() {
        weapons.addAll(newWeapons);
        currentPage++;
        if (newWeapons.isEmpty) {
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
      _fetchWeapons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search by name',
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Lista de armas
            Expanded(
              child: weapons.isEmpty && isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : weapons.isEmpty
                      ? const Center(
                          child: Text(
                            'No weapons found',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: weapons.length + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == weapons.length) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            }
                            final weapon = weapons[index];
                            return Card(
                              color: Colors.grey[800]?.withOpacity(0.8),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: weapon.image != null
                                      ? Image.network(
                                          url + weapon.image!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                ),
                                title: Text(
                                  weapon.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Rarity: ${weapon.rarity}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeaponDetailPage(weapon: weapon),
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
    );
  }
}
