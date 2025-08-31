import 'package:flutter/material.dart';
import 'package:component_manager/component_manager.dart';

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
