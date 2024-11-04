import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:remind_ui/features/media/presentation/widgets/card.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../authentication/presentation/bloc/auth_state.dart';
import '../bloc/media_bloc.dart';
import '../bloc/media_state.dart';
import '../widgets/search_dropdown_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _date = DateFormat('MMMM d, yyyy').format(DateTime.now());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Handle any specific logic when the state changes, if needed
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 242, 189, 172),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 52, 48, 70),
                    size: 40,
                  ),
                  onSelected: (value) {
                    if (value == 'Log Out') {
                      context.read<AuthBloc>().add(LogOutEvent());
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Log Out',
                        child: Text('Log Out'),
                      ),
                    ];
                  },
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      _date,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 52, 48, 70),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        'Hello, ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 48, 70),
                            fontSize: 15),
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is GetMeSuccessState) {
                            return Text(
                              state.user.name,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 8, 3, 91),
                                fontSize: 15,
                              ),
                            );
                          } else {
                            return const Text('User');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Show the filter menu programmatically
                    showMenu<String>(
                      context: context,
                      position: const RelativeRect.fromLTRB(100, 56, 0, 0),
                      items: [
                        const PopupMenuItem(
                            value: 'Family', child: Text('Family')),
                        const PopupMenuItem(
                            value: 'Friends', child: Text('Friends')),
                        const PopupMenuItem(
                            value: 'School', child: Text('School')),
                        const PopupMenuItem(
                            value: 'Stranger', child: Text('Stranger')),
                        const PopupMenuItem(value: 'Home', child: Text('Home')),
                        const PopupMenuItem(
                            value: 'Transport', child: Text('Transport')),
                        const PopupMenuItem(value: 'Work', child: Text('Work')),
                        const PopupMenuItem(
                            value: 'Other', child: Text('Other')),
                      ],
                    );
                  },
                  child: const Text('Filter By'),
                ),
                IconButton(
                  icon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 52, 48, 70)),
                  onPressed: () {
                    // Show the search input field in a dropdown
                    SearchDropdown.showSearchDropdown(
                        context, _searchController);
                    print(_searchController);
                  },
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 52, 48, 70),
                  ),
                  onSelected: (value) {
                    Navigator.pushNamed(context, '/add');
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Add data',
                        child: Text('Add data'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: BlocBuilder<MediaBloc, MediaState>(
                      builder: (context, state) {
                    if (state is InitialState) {
                      return const Center(child: Text('No product'));
                    } else if (state is LoadedAllMediaState) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.mediaList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: cardMedia.displaywithImage(
                                  state.mediaList[index].imageUrl ?? '',
                                  state.mediaList[index].text ?? '',
                                  state.mediaList[index].link ?? '',
                                  state.mediaList[index].category,
                                  state.mediaList[index].remindBy ?? '',
                                  state.mediaList[index].createdAt),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         Detail(product: state.productList[index]),
                                //   ),
                                // );
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is ErrorState) {
                      return const Center(
                        child: Text('The products can not be loaded'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                ),
              ],
            ));
      },
    );
  }
}
