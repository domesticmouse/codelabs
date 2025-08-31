import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:component_manager/component_manager.dart';

import 'component_detail_screen.dart';

class ComponentListScreen extends StatefulWidget {
  final ComponentLibrary? componentLibrary;

  const ComponentListScreen({super.key, this.componentLibrary});

  @override
  State<ComponentListScreen> createState() => _ComponentListScreenState();
}

class _ComponentListScreenState extends State<ComponentListScreen> {
  ComponentLibrary? _componentLibrary;
  List<Component> _filteredComponents = [];
  final _searchController = TextEditingController();
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadComponentLibrary();
    _searchController.addListener(_filterComponents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadComponentLibrary() async {
    if (widget.componentLibrary != null) {
      setState(() {
        _componentLibrary = widget.componentLibrary;
        _filteredComponents = widget.componentLibrary!.components;
      });
      return;
    }

    try {
      final yamlString = await rootBundle.loadString('components.yaml');
      final library = ComponentLibrary.fromYaml(yamlString);
      if (mounted) {
        setState(() {
          _componentLibrary = library;
          _filteredComponents = library.components;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
        });
      }
    }
  }

  void _filterComponents() {
    if (_componentLibrary == null) return;
    final query = _searchController.text;
    setState(() {
      _filteredComponents = _componentLibrary!.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_error != null) {
      body = Center(child: Text('Error: $_error'));
    } else if (_componentLibrary == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_filteredComponents.isEmpty) {
      body = const Center(child: Text('No components found.'));
    } else {
      body = ListView.builder(
        key: const Key('component_list'),
        itemCount: _filteredComponents.length,
        itemBuilder: (context, index) {
          final component = _filteredComponents[index];
          return ListTile(
            title: Text(component.name),
            subtitle: Text(component.description),
            onTap: () async {
              final newComponent = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ComponentDetailScreen(component: component),
                ),
              );
              if (newComponent != null) {
                setState(() {
                  final index = _componentLibrary!.components.indexWhere(
                    (c) => c.name == component.name,
                  );
                  if (index != -1) {
                    _componentLibrary!.components[index] = newComponent;
                  }
                  _filterComponents();
                });
              }
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Components'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search components...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
