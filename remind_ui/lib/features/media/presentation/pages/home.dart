import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/presentation/widgets/card.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../authentication/presentation/bloc/auth_state.dart';
import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';
import '../bloc/media_state.dart';
import '../widgets/search_dropdown_widget.dart';

class Home extends StatefulWidget {
  final String from;
  const Home({super.key, required this.from});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _date = DateFormat('MMMM d, yyyy').format(DateTime.now());
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = ''; // To store filter selection
  String searchQuery = ''; // To store search input

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
    context.read<MediaBloc>().add(GetMediaByRemindEvent(query));
  }

  void _onFilterSelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    context.read<MediaBloc>().add(GetMediaByCategoryEvent(category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: PopupMenuButton<String>(
              icon: const Icon(Icons.person,
                  color: Color.fromARGB(255, 52, 48, 70), size: 40),
              onSelected: (value) {
                if (value == 'Log Out') {
                  context.read<AuthBloc>().add(LogOutEvent());
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'Log Out', child: Text('Log Out'))
              ],
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_date,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 52, 48, 70), fontSize: 12)),
                Row(children: [
                  const Text('Hello, ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 52, 48, 70),
                          fontSize: 15)),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is GetMeSuccessState) {
                        return Text(state.user.name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 8, 3, 91),
                                fontSize: 15));
                      } else {
                        return const Text('User');
                      }
                    },
                  ),
                ]),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final category = await showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 56, 0, 0),
                    items: [
                      for (var category in [
                        'All',
                        'Family',
                        'Friends',
                        'School',
                        'Stranger',
                        'Home',
                        'Transport',
                        'Work',
                        'Other'
                      ])
                        PopupMenuItem(value: category, child: Text(category))
                    ],
                  );
                  if (category != null) {
                    _onFilterSelected(category);
                  }
                },
                child: const Text('Filter By'),
              ),
              IconButton(
                icon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 52, 48, 70)),
                onPressed: () {
                  SearchDropdown.showSearchDropdown(
                    context,
                    _searchController,
                  );
                },
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert,
                    color: Color.fromARGB(255, 52, 48, 70)),
                onSelected: (value) => Navigator.pushNamed(context, '/add'),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: 'Add data', child: Text('Add data'))
                ],
              ),
            ],
          ),
          body: widget.from != 'signup'
              ? Column(
                  children: [
                    const SizedBox(height: 30),
                    BlocBuilder<MediaBloc, MediaState>(
                      builder: (context, state) {
                        if (state is InitialState) {
                          return const Center(child: Text('No Media'));
                        } else if (state is LoadedAllMediaState ||
                            state is LoadedAllMediaByCategoryState ||
                            state is LoadedAllMediaByRemindState) {
                          // Filter and search results
                          List<MediaEntity> mediaList;
                          if (state is LoadedAllMediaState) {
                            mediaList = state.mediaList;
                          } else if (state is LoadedAllMediaByCategoryState) {
                            mediaList = state.mediaList;
                          } else if (state is LoadedAllMediaByRemindState) {
                            mediaList = state.mediaList;
                          } else {
                            mediaList = [];
                          }
                          if (mediaList.isEmpty) {
                            return const Center(
                                child: Text('No Media is Available'));
                          }
                          mediaList.sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt));

                          return Expanded(
                            child: ListView.builder(
                              itemCount: mediaList.length,
                              itemBuilder: (context, index) {
                                final media = mediaList[index];
                                if (media.imageUrl != null) {
                                  return cardMedia.displaywithImage(
                                    context,
                                    media.id,
                                    media.imageUrl,
                                    media.text,
                                    media.link,
                                    media.category,
                                    media.remindBy,
                                    media.createdAt,
                                  );
                                } else {
                                  return cardMedia.displaywithoutImage(
                                    context,
                                    media.id,
                                    media.text,
                                    media.link,
                                    media.category,
                                    media.remindBy,
                                    media.createdAt,
                                  );
                                }
                              },
                            ),
                          );
                        } else if (state is ErrorState) {
                          return const Center(
                              child: Column(
                            children: [
                              Text('No content'),
                            ],
                          ));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                )
              : const Center(
                  child: Text("No Media avaliable"),
                ),
        );
      },
    );
  }
}
