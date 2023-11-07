import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'Infinite Screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //scrollController.position.pixels da la posicion actual
      //scrollController.position.maxScrollExtent //lo mas que puede llegar
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        //load next page
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    if (!isMounted) return;
    setState(() {});
    moveScrollToBottom();
  }

  void addFiveImages() {
    final lastId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!isMounted) return;
    final lastId = imagesIds.last;
    isLoading = true;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    isLoading = false;

    setState(() {});
  }

  void moveScrollToBottom() {
    if (scrollController.position.pixels + 150 <=
        scrollController.position.maxScrollExtent) return;
    scrollController.animateTo(scrollController.position.pixels + 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: false,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 280,
                  placeholder: const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(
                      'https://picsum.photos/id/${imagesIds[index]}/420/300'));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isLoading
            ? FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: const CircularProgressIndicator())
            : FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.arrow_back_ios_new_outlined)),
        onPressed: () {
          if (!isLoading) {
            context.pop();
          }
        },
      ),
    );
  }
}
