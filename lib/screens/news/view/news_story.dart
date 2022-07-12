import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsStory extends StatefulWidget {
  const NewsStory({
    Key? key,
    required this.source,
    required this.url,
  }) : super(key: key);

  final String source, url;

  @override
  State<NewsStory> createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.source,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: loading ? 0 : 1,
            child: WebView(
              onPageFinished: (url) => setState(() => loading = false),
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          if (loading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
