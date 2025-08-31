import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:component_manager/component_manager.dart';

import 'component_detail_screen.dart';

class ComponentListScreen extends StatefulWidget {
  const ComponentListScreen({super.key});

  @override
  State<ComponentListScreen> createState() => _ComponentListScreenState();
}

class _ComponentListScreenState extends State<ComponentListScreen> {
  late Future<List<Component>> _componentsFuture;

  @override
  void initState() {
    super.initState();
    _componentsFuture = _loadComponents();
  }

  Future<List<Component>> _loadComponents() async {
    final yamlString = await rootBundle.loadString('components.yaml');
    return ComponentLibrary.fromYaml(yamlString).components;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Components')),
      body: FutureBuilder<List<Component>>(
        future: _componentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No components found.'));
          } else {
            final components = snapshot.data!;
            return ListView.builder(
              itemCount: components.length,
              itemBuilder: (context, index) {
                final component = components[index];
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
                        final index = components.indexOf(component);
                        components[index] = newComponent;
                      });
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
