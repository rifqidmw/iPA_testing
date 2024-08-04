import 'package:flutter/material.dart';
import 'package:base_project_mvvm_provider/utils/routes/routes_names.dart';
import 'package:base_project_mvvm_provider/viewModel/home_view_model.dart';
import 'package:base_project_mvvm_provider/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel homeViewModel = HomeViewModel();
  late UserViewModel userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();

    homeViewModel.fetchMoviesListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userViewModel.removeUser().then((value) {
                Navigator.pushReplacementNamed(context, RouteNames.login);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Ink(
                child: const Text("Logout"),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch (value.moviesList.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(
                    value.moviesList.message.toString(),
                  ),
                );
              case Status.completed:
                return ListView.builder(
                    itemCount: value.moviesList.data!.results.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(value
                              .moviesList.data!.results[index].title
                              .toString()),
                          subtitle: Text(value
                              .moviesList.data!.results[index].releaseDate
                              .toString()),
                          leading: Image.network(
                            value.moviesList.data!.results[index].posterPath
                                .toString(),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                value.moviesList.data!.results[index].voteCount
                                    .toString(),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ),
                      );
                    });

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
