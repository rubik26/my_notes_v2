import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/presentation/bloc/theme_mode_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const Divider(),
          BlocBuilder<ThemeModeBloc, bool>(
            builder: (context, state) {
              return ListTile(
                title: const Text('Theme Mode'),
                subtitle: const Text('Light / Dark'),
                trailing: Switch(
                  value: state,
                  onChanged: (value) {
                    context.read<ThemeModeBloc>().add(ToggleThemeMode());
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
