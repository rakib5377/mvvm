import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final logOut = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          MaterialButton(
            onPressed: () {
              logOut.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Text("Log Out"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) {
          final viewModel = HomeViewViewModel();
          viewModel.fetchMovieList();
          return viewModel;
        },
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, child) {
            switch (value.movieList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Text(value.movieList.message.toString());
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.movieList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    var movieList = value.movieList.data!.movies![index];
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                movieList.posterurl ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network('https://cdn-icons-png.freepik.com/256/1466/1466623.png?semt=ais_hybrid'); // Your fallback asset
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator());
                                },
                              )
                              ,
                            ),

                            title: Text(movieList.title.toString()),
                            subtitle: Text(movieList.year.toString()),
                          ),
                        ],
                      ),
                    );
                  },
                );
              default:
                return CircularProgressIndicator();
            }
            return Container();
          },
        ),
      ),
    );
  }

  getIt() {}
}
