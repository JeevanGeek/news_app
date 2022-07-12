import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/sharedprefs.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/country_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/category/category.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/screens/search/search.dart';
import 'package:news_app/widgets/news_list.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc()..add(const GetTopNews()),
        ),
        BlocProvider(
          create: (context) => SourcesBloc()..add(const GetSources()),
        ),
      ],
      child: const NewsView(),
    );
  }
}

class NewsView extends StatelessWidget {
  const NewsView({
    Key? key,
  }) : super(key: key);

  static List<Source> selectedSources = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
          icon: const Icon(Icons.search),
        ),
        title: const Text(
          'News App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async => await showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const Text(
                      'Choose your location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: Country.countries.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () async {
                          await Storage.setCountry(
                              Country.countries[index].name);
                          await Storage.setCountryCode(
                              Country.countries[index].code);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewsPage(),
                            ),
                            (route) => false,
                          );
                        },
                        title: Text(
                          Country.countries[index].name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: kSecondaryColor,
                ),
                Text(
                  Storage.getCountry(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: kSecondaryColor,
                  ),
                )
              ],
            ),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: Category.categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            category: Category.categories[index].name,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: Category.categories[index].image,
                              placeholder: (_, __) => Center(
                                child: Container(color: Colors.black54),
                              ),
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black54,
                            ),
                            child: Center(
                              child: Text(
                                Category.categories[index].name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoaded) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Top Headlines',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        NewsList(data: state.news.articles),
                      ],
                    );
                  } else if (state is NewsEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.file_copy,
                          size: 50,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No result found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else if (state is NewsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.signal_wifi_connected_no_internet_4,
                          size: 50,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Something went wrong',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () => BlocProvider.of<NewsBloc>(context)
                              .add(const GetTopNews()),
                          child: const Text(
                            'Try again',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SourcesBloc, SourcesState>(
        builder: (context, state) {
          if (state is SourcesLoaded) {
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_context) => state.sources.sources.isEmpty
                      ? SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              'No sources found in ${Storage.getCountry()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : MultiSelectBottomSheet<Source>(
                          title: const Text(
                            'Filter by sources',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          items: state.sources.sources
                              .map((e) => MultiSelectItem(e, e.name))
                              .toList(),
                          initialValue: selectedSources,
                          onConfirm: (values) {
                            var source = "";
                            selectedSources = values;
                            for (var element in values) {
                              source += '${element.id},';
                            }
                            selectedSources.isEmpty
                                ? BlocProvider.of<NewsBloc>(context)
                                    .add(const GetTopNews())
                                : BlocProvider.of<NewsBloc>(context)
                                    .add(GetSourceNews(source));
                          },
                        ),
                );
              },
              child: const Icon(Icons.filter_alt_outlined),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
