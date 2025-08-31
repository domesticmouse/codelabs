import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:component_manager/component_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Component Editor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ComponentListScreen(),
    );
  }
}

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

class ComponentDetailScreen extends StatefulWidget {
  final Component component;

  const ComponentDetailScreen({super.key, required this.component});

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.component.name)),
      body: ListView.builder(
        itemCount: widget.component.pins.length,
        itemBuilder: (context, index) {
          final pin = widget.component.pins[index];
          return ListTile(
            leading: Text(pin.number.toString()),
            title: Text(pin.name),
            subtitle: Text(pin.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newComponent = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditComponentScreen(component: widget.component),
            ),
          );
          if (newComponent != null) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context, newComponent);
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class EditComponentScreen extends StatefulWidget {
  final Component component;

  const EditComponentScreen({super.key, required this.component});

  @override
  State<EditComponentScreen> createState() => _EditComponentScreenState();
}

class _EditComponentScreenState extends State<EditComponentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.component.name);
    _descriptionController = TextEditingController(
      text: widget.component.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Component')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newComponent = Component(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      type: widget.component.type,
                      pins: widget.component.pins,
                    );
                    Navigator.pop(context, newComponent);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
