import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Container newsArticleReadMoreButton(BuildContext context, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromRGBO(56, 182, 255, 1.0);
            }
            return const Color.fromRGBO(56, 182, 255, 1.0);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )),
      child: Text('Read more...', style: Theme.of(context).textTheme.bodyLarge),
    ),
  );
}

class CryptoExchangesReadMoreButton extends StatelessWidget {
  const CryptoExchangesReadMoreButton({
    super.key,
    required this.name,
    required this.url,
  });

  final String? name;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          launchUrl(Uri.parse(url.toString()));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromRGBO(56, 182, 255, 1.0);
              }
              return const Color.fromRGBO(56, 182, 255, 1.0);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            )),
        child: Text('Learn more about $name',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}