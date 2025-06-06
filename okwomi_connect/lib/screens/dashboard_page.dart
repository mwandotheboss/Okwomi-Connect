import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _collapsed = false;

  final List<_DashboardMenuItem> _menuItems = [
    _DashboardMenuItem('All Members', Icons.people),
    _DashboardMenuItem('Contributions', Icons.volunteer_activism),
    _DashboardMenuItem('Profiles', Icons.account_circle),
    _DashboardMenuItem('Publications', Icons.article),
    _DashboardMenuItem('Create Events', Icons.event),
  ];

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const Center(child: Text('All Members List Placeholder'));
      case 1:
        return const Center(child: Text('Contributions Placeholder'));
      case 2:
        return const Center(child: Text('Profiles Placeholder'));
      case 3:
        return const Center(child: Text('Publications Placeholder'));
      case 4:
        return const Center(child: Text('Create Events Placeholder'));
      default:
        return const Center(child: Text('Dashboard'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _collapsed ? 64 : 220,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  IconButton(
                    icon: Icon(_collapsed ? Icons.arrow_right : Icons.arrow_left),
                    onPressed: () => setState(() => _collapsed = !_collapsed),
                    tooltip: _collapsed ? 'Expand' : 'Collapse',
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        final item = _menuItems[index];
                        return ListTile(
                          leading: Icon(item.icon, color: _selectedIndex == index ? Theme.of(context).colorScheme.primary : null),
                          title: _collapsed ? null : Text(item.title),
                          selected: _selectedIndex == index,
                          onTap: () => setState(() => _selectedIndex = index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 64,
                    color: Theme.of(context).colorScheme.background,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _menuItems[_selectedIndex].title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          tooltip: 'Logout',
                          onPressed: () async {
                            await AuthService().signOut();
                            if (mounted) Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardMenuItem {
  final String title;
  final IconData icon;
  const _DashboardMenuItem(this.title, this.icon);
} 