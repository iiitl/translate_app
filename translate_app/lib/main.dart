import 'package:flutter/material.dart';
import 'package:translate_app/models/language.dart';
import 'package:translate_app/services/service.dart';
import 'package:flutter/services.dart';

// import 'package:translate_app/screens/splash_screen.dart';
// import 'package:get/get.dart';

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
      home: SplashScreen(),
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
        title: const Text("Translator",
        style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Alata-Regular',
                fontSize: 25,
              ),
        ),
     
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(11, 41, 235, 0.976),

        ),
      body: SingleChildScrollView(
        child: Container(
      
          margin: const EdgeInsets.symmetric(horizontal: 15),
          
          child: Column(
                
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [Text(
              //     "Row HELLO", 
              //     style: TextStyle(
              //   color: const Color.fromARGB(255, 0, 0, 0),
              //   fontFamily: 'UbuntuMono-Regular',
              //   fontSize: 32,
              // ),
              //   )],),
              
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              TextField(
                                decoration: InputDecoration(
                    hintText: 'Enter the text',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3))),
                controller: _input,
                onChanged: (value) {
                  _input.text = value;
                  print(_input.text);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border:
                        Border.all(color: const Color.fromARGB(136, 60, 60, 60))),
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
                height: 25,
              ),
              SizedBox(
                width: 180,
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
                        Color.fromRGBO(11, 41, 235, 0.976)),
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
                height: 0,
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









class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LanguageTranslator()), // Navigate to LanguageTranslator screen
      );
    });
  }

  
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient( 
            colors: [
              Color.fromARGB(255, 252, 253, 254),
              Color.fromARGB(255, 0, 0, 0),
              // Colors.red,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[ 
            Icon(
              Icons.book,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to Translate app',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
