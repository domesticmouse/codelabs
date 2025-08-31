import 'package:flutter/material.dart';
import 'package:component_manager/component_manager.dart';

import 'edit_component_screen.dart';

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
