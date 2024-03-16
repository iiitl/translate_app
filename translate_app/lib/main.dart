import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/models/language.dart';
import 'package:translate_app/services/service.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:get/get.dart';
// import 'package:translate_app/theme/theme.dart';
import 'package:translate_app/theme/theme.dart';
import 'package:translate_app/theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LanguageTranslator(),
      theme: Provider.of<ThemeProvider>(context).themeData,
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
  title: const Text("Translator"),
  centerTitle: true,
  elevation: 0,
  backgroundColor: Theme.of(context).colorScheme.secondary,
  actions: [
    IconButton(
      icon: Icon(Icons.lightbulb), 
      onPressed: () {
        Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
      },
    ),


    
  ],
)
,
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
                  hintText: 'Entere the text',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255), 
                      
                      width: 12.0, 
                    ),
                  ),
                ),
                style: TextStyle(
                    
                        color: Theme.of(context).colorScheme.tertiary, ),
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
                    border:
                        Border.all(color: Theme.of(context).colorScheme.tertiary,)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: DropdownButton(
                    value: lang,
                    items: list.map<DropdownMenuItem<String>>((Language value) {
                      return DropdownMenuItem<String>(
                        value: value.lang,
                        child: Text(
                          value.language,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        lang = value!;
                      });
                      print(lang);
                    },
                    underline: Container(), 
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
                      Theme.of(context).colorScheme.secondary,
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: isVisible
                      ? const Text(
                          "Convert",
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
                    const Text(
                      "Result",
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
