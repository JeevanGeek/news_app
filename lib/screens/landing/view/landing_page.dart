import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/sharedprefs.dart';
import 'package:news_app/models/country_model.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Header('Choose your location'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: Country.countries.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () async {
            await Storage.setCountry(Country.countries[index].name);
            await Storage.setCountryCode(Country.countries[index].code);
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
    );
  }
}
