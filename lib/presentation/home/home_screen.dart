import 'package:flt_task/common/app_images.dart';
import 'package:flt_task/common/app_links.dart';
import 'package:flt_task/providers/home/home_provider.dart';
import 'package:flt_task/presentation/home/widgets/user_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _popupMenuItems = [
    'WEBSITE',
    'LINKEDIN',
    'CONTACT'
  ];

  _launchURL(String value) async {
    String url;
    if (value == 'WEBSITE') {
      url = AppLinks.website;
    } else if (value == 'LINKEDIN') {
      url = AppLinks.linkedIn;
    } else if (value == 'CONTACT') {
      url = AppLinks.contactEmail;
    } else {
      return;
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 36,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        shadowColor: Colors.grey.shade200,
        elevation: 4,
        title: Image.asset(AppImages.logo_small, width: 100),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<String>(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                _launchURL(value);
              },
              offset: const Offset(-10, 40),
              itemBuilder: (BuildContext context) {
                return _popupMenuItems.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.35, 1.0],
            colors: [Colors.white, Color(0xFFB1CCFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              Consumer<HomeProvider>(
                builder: (context, searchProvider, child) {
                  return Visibility(
                    visible: !searchProvider.searchPerformed,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(AppImages.logo_large),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
              TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (String query) {
                  if (query.isNotEmpty) {
                    context.read<HomeProvider>().search(query);
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.only(left: 10),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1.5), // Normal state border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1.5), // Normal state border color
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  if (homeProvider.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (homeProvider.searchPerformed &&
                      homeProvider.searchResults.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 100),
                          Image.asset(AppImages.no_results_found),
                        ],
                      ),
                    );
                  } else if (homeProvider.searchPerformed) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: homeProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          final user = homeProvider.searchResults[index];
                          return Column(
                            children: [
                              UserCard(
                                user: user,
                                onFetchDetails: () {
                                  showUserDetailsDialog(
                                      context, user); // Show the dialog
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
