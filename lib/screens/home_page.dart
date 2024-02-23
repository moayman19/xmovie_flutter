import 'package:flutter/material.dart';
import 'package:movie_app/components/movies_list_view.dart';
import 'package:movie_app/screens/info_page.dart';
import 'package:movie_app/services/networking.dart';
import 'package:movie_app/utilities/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List popularMoviesData = [];
  List topRatedMoviesData = [];
  final Networking _networking = Networking();

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  int page = 1;
  int totalPages =500;

  @override
  void initState() {
    super.initState();
    updateUi();
    _scrollController.addListener(addMoreData);
    _scrollController2.addListener(addMoreData);
  }

  void addMoreData() async{
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent&&page<totalPages) {
      page++;
      final data = await _networking.getMoviesData(kSortByPopular, page);
      setState(() {
        popularMoviesData.addAll(data);
      });

    }
    if (_scrollController2.position.pixels ==
        _scrollController2.position.maxScrollExtent&&page<totalPages) {
      page++;
      final data = await _networking.getMoviesData(kSortByTopRated, page);
      setState(() {
        topRatedMoviesData.addAll(data);
      });
    }

  }

  Future<void> updateUi() async {
    final popularData = await _networking.getMoviesData(kSortByPopular, page);
    final topRatedData = await _networking.getMoviesData(kSortByTopRated, page);
    setState(() {
      popularMoviesData = popularData;
      topRatedMoviesData = topRatedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          'Xmovies',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        )),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // image: DecorationImage(image: AssetImage('images/background.jpg'))
              ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextField(
                        onSubmitted: (value) async {
                          var data =
                              await Networking().getSearchMovieData(value.replaceAll(" ", "+"));
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: InfoPage(
                                        title: data[0]['title'] ?? '',
                                        overview: data[0]['overview'] ?? '',
                                        backdropPath: data[0]['backdrop_path'],
                                        voteAverage:
                                            data[0]['vote_average'] ?? 0),
                                  )));
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Popular',
                    style: kMoviesTextStyle,
                  ),
                  MoviesListView(
                    moviesList: popularMoviesData,
                    controller: _scrollController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'TopRated',
                    style: kMoviesTextStyle,
                  ),
                  MoviesListView(
                    moviesList: topRatedMoviesData,
                    controller: _scrollController2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }
}

