import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/news/view/news_details.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.data}) : super(key: key);

  final List<Article> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (index % 5 == 0) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).push(
                PageRouteBuilder(
                  fullscreenDialog: true,
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondary) => NewsDetails(
                    data: data[index],
                  ),
                  transitionsBuilder: (context, animation, secondary, child) =>
                      FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: data[index].url,
                        child: CachedNetworkImage(
                          imageUrl: data[index].urlToImage,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].source.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data[index].title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${DateTime.now().difference(DateTime.parse(data[index].publishedAt)).inHours} hours ago',
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).push(
                PageRouteBuilder(
                  fullscreenDialog: true,
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondary) => NewsDetails(
                    data: data[index],
                  ),
                  transitionsBuilder: (context, animation, secondary, child) =>
                      FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: data[index].url,
                          child: CachedNetworkImage(
                            imageUrl: data[index].urlToImage,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image,
                              size: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].source.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data[index].title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                color: kPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${DateTime.now().difference(DateTime.parse(data[index].publishedAt)).inHours} hours ago',
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
