import 'dart:async';

import 'package:appedvies/src/models/evaluacion.dart';
import 'package:appedvies/src/models/pregunta.dart';
import 'package:appedvies/src/models/route_argument.dart';
import 'package:appedvies/src/repositorios/evaluacion_repository.dart' as reva;
import 'package:appedvies/src/utils.dart';
import 'package:flutter/material.dart';
class EvaluacionPage extends StatefulWidget {

  RouteArgument? routeArgument;
  String? _heroTag;

   EvaluacionPage({Key? key,this.routeArgument}) : super(key: key){
    _heroTag = '1';
  } 

  @override
  State<EvaluacionPage> createState() => _EvaluacionPageState();
}

class _EvaluacionPageState extends State<EvaluacionPage> {
  late Evaluacion evaluacion; 
  List<Pregunta> lpreguntas= [];
  List<Map<String,dynamic>> respuestas=[];
  Map<String,dynamic> respreg={

  };
  bool cargando=false;
  final pageController =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  final _questions = const [
    {
      'questionText': 'Q1. Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': -2},
        {'text': 'Adobe', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2. What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'score': -2},
        {'text': 'IOS Development Kit', 'score': -2},
        {'text': 'Web Development Kit', 'score': -2},
        {
          'text':
              'SDK to build beautiful IOS, Android, Web & Desktop Native Apps',
          'score': 10
        },
      ],
    },
    {
      'questionText': ' Q3. Which programing language is used by Flutter',
      'answers': [
        {'text': 'Ruby', 'score': -2},
        {'text': 'Dart', 'score': 10},
        {'text': 'C++', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Who created Dart programing language?',
      'answers': [
        {'text': 'Lars Bak and Kasper Lund', 'score': 10},
        {'text': 'Brendan Eich', 'score': -2},
        {'text': 'Bjarne Stroustrup', 'score': -2},
        {'text': 'Jeremy Ashkenas', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q5. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];


  var _questionIndex = 0;
  var _totalScore = 0;

  @override
  void initState() {
    super.initState();
      this.evaluacion = widget.routeArgument!.param[0] as Evaluacion;
      this.obtienePreguntas(this.evaluacion.id??0);
  }

  void _resetQuiz()  {
     Future.delayed(Duration(milliseconds: 500),(){
        setState(() {
        _questionIndex = 0;
        _totalScore = 0;
    });
    });
          
  }

  void _answerQuestion(int score) {
    
      _totalScore += score;
   Future.delayed(Duration(milliseconds: 500),(){
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
   });
      
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Evaluacion ${evaluacion.id}"),
          backgroundColor: Theme.of(context).primaryColor ,
        ),
        // body: Padding(
        //   padding: const EdgeInsets.all(30.0),
        //   child: _questionIndex < _questions.length
        //       ? Quiz(
        //           answerQuestion: _answerQuestion,
        //           questionIndex: _questionIndex,
        //           questions: _questions,
        //         ) //Quiz
        //       : Result(_totalScore, _resetQuiz),
        // ), //Padding
        body:  cargando
        ?Center(child: CircularProgressIndicator(),)
        :Container(
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            allowImplicitScrolling: true,
            physics: NeverScrollableScrollPhysics(),
            pageSnapping: false,
            controller: this.pageController,
            itemCount: this.lpreguntas.length,
            itemBuilder:(BuildContext context,index){
                    //return Text(this._questions.elementAt(index)['questionText'].toString());
                    return _pregunta(lpreguntas.elementAt(index));
                  } ),
        ),
      );
  }
  Widget _pregunta(Pregunta pregunta){
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(children: <Widget>[
        Text(pregunta.question??"",
		      style: const TextStyle(fontSize: 28),
		      textAlign: TextAlign.center,
	),
  _respuestas(pregunta)
      ]),
    );
  }

  Widget _respuestas(Pregunta preguntaa)
  {
    //List<Map<String,dynamic>> respuestass = preguntaa['answers'] ;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: MediaQuery.of(context).size.height*0.6,
      child: ListView(
        children: <Widget>[
          ElevatedButton(
		onPressed: (){
     // _questionIndex = index;
      //_totalScore = _totalScore + int.parse(respuestass.elementAt(index)['score']);
      respuestas.add({
         "id": preguntaa.id,
        "response": preguntaa.firstanswer??""
      });
      
      if(_questionIndex<lpreguntas.length-1)
        {_questionIndex++;
        pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
        }
      else{
        mostrarAlerta(context);
      }
    }, //selectHandler(),
		style: ButtonStyle(
			textStyle:
				MaterialStateProperty.all(const TextStyle(color: Colors.white)),
			backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 150, 243, 1.0))),
		child: Text(preguntaa.firstanswer??""),
	),

  ElevatedButton(
		onPressed: (){
     // _questionIndex = index;
      //_totalScore = _totalScore + int.parse(respuestass.elementAt(index)['score']);
      respuestas.add({
         "id": preguntaa.id,
        "response": preguntaa.secondanswer??""
      });
      if(_questionIndex<lpreguntas.length-1)
        {_questionIndex++;
        pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
        }
      else{
        mostrarAlerta(context);
      }
      //pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    }, //selectHandler(),
		style: ButtonStyle(
			textStyle:
				MaterialStateProperty.all(const TextStyle(color: Colors.white)),
			backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 150, 243, 1.0))),
		child: Text(preguntaa.secondanswer??""),
	),

  ElevatedButton(
		onPressed: (){
     // _questionIndex = index;
      //_totalScore = _totalScore + int.parse(respuestass.elementAt(index)['score']);
       respuestas.add({
         "id": preguntaa.id,
        "response": preguntaa.thirdanswer??""
      });
    
      if(_questionIndex<lpreguntas.length-1)
        {_questionIndex++;
        pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
        }
      else{
        mostrarAlerta(context); 
      }
     // pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    }, //selectHandler(),
		style: ButtonStyle(
			textStyle:
				MaterialStateProperty.all(const TextStyle(color: Colors.white)),
			backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 150, 243, 1.0))),
		child: Text(preguntaa.thirdanswer??""),
	),

        ],
      ),
  //     child: ListView.builder(
  //       itemCount: respuestass.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ElevatedButton(
	// 	onPressed: (){
  //     _questionIndex = index;
  //     _totalScore = _totalScore + int.parse(respuestass.elementAt(index)['score']);
  //     pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  //   }, //selectHandler(),
	// 	style: ButtonStyle(
	// 		textStyle:
	// 			MaterialStateProperty.all(const TextStyle(color: Colors.white)),
	// 		backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 150, 243, 1.0))),
	// 	child: Text(respuestass[index]['text']),
	// ) ;
  //       },
  //     ),
    );
  }

  
  obtienePreguntas (int idEva) async {

    this.cargando=true;
    setState(() {
      
    });
//obtiene preguntas  por evaluacion
  Map<String,dynamic> resp = await  reva.obtenerPreguntasXEvaluacion(idEva) ;
  this.lpreguntas= Preguntas.fromJsonList(resp['result']).items ;
  print (resp);
  this.cargando=false;
    setState(() {
      
    });
}

  registraEvaluacion (BuildContext context) async {

    this.cargando=true;
    setState(() {
      
    });
//obtiene preguntas  por evaluacion
  Map<String,dynamic> resp = await  reva.registroEvaluacion(respuestas, this.evaluacion.id??0);
  //this.lpreguntas= Preguntas.fromJsonList(resp['result']).items ;
  mostrarSnackbar2(context, 'nota ${resp['score']??'0' }/100',Theme.of(context).primaryColorDark, Colors.white, 5000);
 this.respreg= resp;
  print (resp);
  this.cargando=false;
    setState(() {
      
    });
}



void mostrarAlerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
          print (respuestas);
        return AlertDialog(
          title: Text('Evaluación Completada'),
          content: Text('¿Desea enviar su evaluación?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: ()async {
                  await this.registraEvaluacion(context);
                  print(Navigator.of(context).canPop());
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                   Navigator.of(context).pop();
                },
                child: Text('Aceptar')),
            TextButton(
                onPressed: () {
                  print(Navigator.of(context).canPop());
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'))    
          ],
        );
      });
}

}