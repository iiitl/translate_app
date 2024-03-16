import 'package:flutter/material.dart';
import 'package:translate_app/models/language.dart';
import 'package:translate_app/services/service.dart';
// import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

List<Language> list = [
  Language(lang: 'es', language: "Spanish"),
  Language(lang: 'fr', language: "France"),
  Language(lang: 'de', language: "German"),
  Language(lang: "it", language: "Italian"),
  Language(lang: "nl", language: "Dutch"),
  Language(lang: "pt", language: "Portuguese"),
  Language(lang: "ru", language: "Russia"),
  Language(lang: "ja", language: "Japanese"),
  Language(lang: "zh-cn", language: "Chinese-Simplified"),
  Language(lang: "zh-tw", language: "Chinese-Traditional"),
  Language(lang: "ko", language: "Korean"),
  Language(lang: "ar", language: "Arabic"),
  Language(lang: "hi", language: "Hindi")
];

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      home: LanguageTranslator(),
    );
  }
}

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  final _input = TextEditingController();

  String lang = list.first.lang;

  String result = "";

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.apTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 44, 37, 230),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.boxTitle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                controller: _input,
                onChanged: (value) {
                  _input.text = value;
                  print(_input.text);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: const Color.fromARGB(136, 60, 60, 60))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: lang,
                    items: list.map<DropdownMenuItem<String>>((Language value) {
                      return DropdownMenuItem<String>(
                        value: value.lang,
                        child: Text(value.language),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        lang = value!;
                      });
                      print(lang);
                    },
                    underline: Container(), //remove underline
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      isVisible = false;
                    });
                    FocusScope.of(context).unfocus();
                    var result1 =
                        await Service().translateText(_input.text, lang);
                    setState(() {
                      result = result1;
                      isVisible = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 44, 37, 230)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: isVisible
                      ? Text(
                          AppLocalizations.of(context)!.convertBtn,
                          style: TextStyle(fontSize: 20),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: result.isNotEmpty,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.result,
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
