import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/screens/info_page.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({super.key, required this.moviesList,required this.controller});

  final List moviesList;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    if (moviesList.isEmpty) {
      return const SpinKitFadingCircle(
        size: 20,
        color: Colors.white,
      );
    } else {
      return Expanded(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          controller: controller,
          itemCount: moviesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var selectedList = moviesList[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                              child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: InfoPage(
                                title: selectedList['title'] ?? '',
                                overview: selectedList['overview'] ?? '',
                                backdropPath: selectedList['backdrop_path'],
                                voteAverage: selectedList['vote_average'] ?? 0),
                          )));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original${selectedList['poster_path']}',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}