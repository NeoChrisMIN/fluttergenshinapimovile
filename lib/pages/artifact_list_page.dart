import 'package:flutter/material.dart';
import '../models/artifact_model.dart';
import '../services/api_service.dart';
import 'artifact_detail_page.dart';
import '../utils/utils.dart';

class ArtifactListPage extends StatefulWidget {
  @override
  _ArtifactListPageState createState() => _ArtifactListPageState();
}

final url = '$urlBaseGlobal';

class _ArtifactListPageState extends State<ArtifactListPage> {
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Artifact> artifacts = [];
  String searchQuery = '';
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchArtifacts();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
        _resetAndFetchArtifacts();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _resetAndFetchArtifacts() {
    setState(() {
      artifacts.clear();
      currentPage = 1;
      hasMore = true;
    });
    _fetchArtifacts();
  }

  Future<void> _fetchArtifacts() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newArtifacts = await apiService.fetchArtifactsPaginated(
        query: searchQuery,
        page: currentPage,
        perPage: 10,
      );
      setState(() {
        artifacts.addAll(newArtifacts);
        currentPage++;
        if (newArtifacts.isEmpty) {
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
      _fetchArtifacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artifact List'),
        backgroundColor: Colors.black87,
      ),
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
          // Lista de artefactos
          Expanded(
            child: artifacts.isEmpty && isLoading
                ? const Center(child: CircularProgressIndicator())
                : artifacts.isEmpty
                    ? const Center(child: Text('No artifacts found'))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: artifacts.length + (hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == artifacts.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final artifact = artifacts[index];
                          return Card(
                            color: Colors.grey[800],
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: artifact.imagePath != null
                                    ? Image.network(
                                        url + artifact.imagePath!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                              ),
                              title: Text(
                                artifact.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Max Rarity: ${artifact.maxRarity}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArtifactDetailPage(
                                        artifact: artifact),
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
