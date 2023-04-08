import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                size: 45,
                color: Colors.white.withOpacity(.6),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Something went wrong!",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We so sorry about the error. Please try again later.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyFavoriteList extends StatelessWidget {
  const EmptyFavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite,
              size: 45,
              color: Colors.white.withOpacity(.6),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your Favorite List is Empty",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Add Your Favorite Movies And Tv Shows For Easy Access...",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyWatchList extends StatelessWidget {
  const EmptyWatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_add,
              size: 45,
              color: Colors.white.withOpacity(.6),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your WatchList is Empty",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Add Shows And Movies To Watchlist Keep Track Of What You Want To Watch...",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.list,
              size: 45,
              color: Colors.white.withOpacity(.6),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your List Is Empty. Please Add a List Using The Add List Button.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: const EdgeInsets.all(26),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 45,
                color: Colors.white.withOpacity(.6),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "404 not found",
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We didn't found anything related with your query, please search with little accurate word.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
