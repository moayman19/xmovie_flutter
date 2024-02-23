import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InfoPage extends StatelessWidget {
  final String title;
  final String overview;
  final String backdropPath;
  final double voteAverage;

  const InfoPage({super.key,
      required this.title,
      required this.overview,
      required this.backdropPath,
      required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/original$backdropPath',
            fit: BoxFit.cover,
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          RatingBarIndicator(
            unratedColor: Colors.white38,
            rating: voteAverage/2,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              overview,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
