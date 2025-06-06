import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _carouselIndex = 0;
  final List<String> _carouselImages = [
    'assets/images/carousel/okwomi-connect-carousel-1.jpg',
    'assets/images/carousel/okwomi-connect-carousel-2.jpg',
    'assets/images/carousel/okwomi-connect-carousel-3.jpg',
  ];
  PageController? _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController(initialPage: _carouselIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCarouselAutoSwitch();
    });
  }

  void _startCarouselAutoSwitch() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return false;
      setState(() {
        _carouselIndex = (_carouselIndex + 1) % _carouselImages.length;
        _carouselController?.animateToPage(
          _carouselIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
      return mounted;
    });
  }

  @override
  void dispose() {
    _carouselController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF233444)
          : const Color(0xFFFBFBF3),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF37404A)
            : Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        title: Row(
          children: [
            Builder(
              builder: (context) {
                final brightness = Theme.of(context).brightness;
                final logoAsset = brightness == Brightness.dark
                    ? 'assets/images/logo-dark.png'
                    : 'assets/images/logo-light.png';
                return Image.asset(
                  logoAsset,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.groups, size: 32, color: Colors.blue),
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              'OKWOMI CONNECT',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) {
              final isWide = MediaQuery.of(context).size.width > 700;
              if (isWide) {
                return Row(
                  children: [
                    _AppBarMenuLink(title: 'About', onTap: () => Navigator.of(context).pushNamed('/about')),
                    const SizedBox(width: 8),
                    _AppBarMenuLink(title: 'Events', onTap: () => Navigator.of(context).pushNamed('/events')),
                    const SizedBox(width: 8),
                    _AppBarMenuLink(title: 'Contact', onTap: () => Navigator.of(context).pushNamed('/contact')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        onPressed: () => Navigator.of(context).pushNamed('/login'),
                        child: const Text('Login'),
                      ),
                    ),
                    _ThemeModeSwitch(),
                  ],
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                );
              }
            },
          ),
        ],
      ),
      endDrawer: MediaQuery.of(context).size.width > 700 ? null : Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        final brightness = Theme.of(context).brightness;
                        final logoAsset = brightness == Brightness.dark
                            ? 'assets/images/logo-dark.png'
                            : 'assets/images/logo-light.png';
                        return Image.asset(
                          logoAsset,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.groups, size: 32, color: Colors.blue),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Text('OKWOMI CONNECT', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Events'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/events');
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Contact'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/contact');
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/login');
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _ThemeModeSwitch(),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Section with Carousel
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  if (isWide) {
                    return Container(
                      color: Colors.grey[50],
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(context).colorScheme.background.withOpacity(0.95),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome to Okwomi Connect',
                                        style: textTheme.displaySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'A platform for members of the Okwomi Family to stay connected, share news, and participate in family activities.',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton(
                                        onPressed: () => Navigator.of(context).pushNamed('/signin'),
                                        child: const Text('Sign In'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: _buildCarousel(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      color: Colors.grey[50],
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).colorScheme.background.withOpacity(0.95),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to Okwomi Connect',
                                      style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'A platform for members of the Okwomi Family to stay connected, share news, and participate in family activities.',
                                      style: textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(context).pushNamed('/signin'),
                                      child: const Text('Sign In'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildCarousel(context),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              // Upcoming Events
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upcoming Events', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _eventCards(),
                  ],
                ),
              ),
              // Photo Gallery
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Photo Gallery', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _galleryGrid(),
                  ],
                ),
              ),
              // Newsletter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stay Connected', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Sign up for our newsletter to receive the latest updates and announcements.', style: textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email address',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Subscribe'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Footer
              Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.groups, color: Colors.blue, size: 32),
                        const SizedBox(width: 8),
                        Text('OKWOMI CONNECT', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Quick Links
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 24,
                      children: [
                        Text('Quick Links', style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                        _FooterMenuLink(title: 'About', onTap: () => Navigator.of(context).pushNamed('/about')),
                        _FooterMenuLink(title: 'Events', onTap: () => Navigator.of(context).pushNamed('/events')),
                        _FooterMenuLink(title: 'Contact', onTap: () => Navigator.of(context).pushNamed('/contact')),
                        _FooterMenuLink(title: 'Privacy Policy', onTap: () => Navigator.of(context).pushNamed('/privacy')),
                        _FooterMenuLink(title: 'Terms of Service', onTap: () => Navigator.of(context).pushNamed('/terms')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('© 2025 Okwomi Connect. All rights reserved.', style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: _carouselImages.length,
            controller: _carouselController,
            onPageChanged: (index) => setState(() => _carouselIndex = index),
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                _carouselImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_carouselImages.length, (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _carouselIndex == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _carouselIndex == index ? Colors.blue : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventCards() {
    final textTheme = Theme.of(context).textTheme;
    final events = [
      {
        'title': 'Family Reunion',
        'date': 'August 10, 2023',
        'desc': 'An agrannimimletletraium family members',
        'img': _carouselImages[0],
      },
      {
        'title': 'Anniversary Celebration',
        'date': 'September 5, 2023',
        'desc': 'Celebrating an edersweman snairsn fiaug',
        'img': _carouselImages[1],
      },
      {
        'title': 'Holiday Gathering',
        'date': 'December 16, 2023',
        'desc': 'A strang gift a greentrail',
        'img': _carouselImages[2],
      },
    ];
    final isWide = MediaQuery.of(context).size.width > 600;
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events.map((event) => _eventCard(event, textTheme)).toList(),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: events.map((event) => _eventCard(event, textTheme)).toList(),
        ),
      );
    }
  }

  Widget _eventCard(Map<String, String> event, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 240,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(event['img']!, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event['title']!, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(event['date']!, style: textTheme.bodySmall?.copyWith(color: Colors.red)),
                    const SizedBox(height: 8),
                    Text(event['desc']!, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _galleryGrid() {
    final galleryImages = _carouselImages;
    final isWide = MediaQuery.of(context).size.width > 600;
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: galleryImages.map((img) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(img, width: 120, height: 80, fit: BoxFit.cover),
          ),
        )).toList(),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: galleryImages.map((img) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(img, width: 120, height: 80, fit: BoxFit.cover),
            ),
          )).toList(),
        ),
      );
    }
  }
}

class _ThemeModeSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    bool isDark = themeMode == ThemeMode.dark;
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).iconTheme.color?.withOpacity(0.5) ?? Colors.grey;
    return Row(
      children: [
        Icon(
          Icons.light_mode,
          size: 20,
          color: !isDark ? activeColor : inactiveColor,
        ),
        Switch(
          value: isDark,
          onChanged: (value) {
            ref.read(themeModeProvider.notifier).setTheme(
              value ? ThemeMode.dark : ThemeMode.light,
            );
          },
        ),
        Icon(
          Icons.dark_mode,
          size: 20,
          color: isDark ? activeColor : inactiveColor,
        ),
      ],
    );
  }
}

class _AppBarMenuLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _AppBarMenuLink({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _FooterMenuLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _FooterMenuLink({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
} 