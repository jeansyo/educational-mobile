// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
final int resultScore;
final Function resetHandler;

const Result(this.resultScore, this.resetHandler, {Key? key})
	: super(key: key);

//Remark Logic
String get resultPhrase {
	String resultText;
	if (resultScore >= 41) {
	resultText = '¡Eres asombroso!';
	print(resultScore);
	} else if (resultScore >= 31) {
	resultText = 'bastante bueno!';
	print(resultScore);
	} else if (resultScore >= 21) {
	resultText = 'necesitas trabajar un poco!';
	} else if (resultScore >= 1) {
	resultText = 'necesitas trabajar duro!';
	} else {
	resultText = 'Es una baja puntuacion!';
	print(resultScore);
	}
	return resultText;
}

@override
Widget build(BuildContext context) {
	return Center(
	child: Column(
		mainAxisAlignment: MainAxisAlignment.center,
		children: <Widget>[
		Text(
			resultPhrase,
			style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
			textAlign: TextAlign.center,
		), //Text
		Text(
			'Score ' '$resultScore',
			style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
			textAlign: TextAlign.center,
		), //Text
		TextButton(
			onPressed: resetHandler(),
			child: Container(
			color: Colors.green,
			padding: const EdgeInsets.all(14),
			child: const Text(
				'Restart Quiz',
				style: TextStyle(color: Colors.blue),
			),
			),
		),
		// FlatButton is deprecated and should not be used
		// Use TextButton instead

		// FlatButton(
		// child: Text(
		//	 'Restart Quiz!',
		// ), //Text
		// textColor: Colors.blue,
		// onPressed: resetHandler(),
		// ), //FlatButton
		], //<Widget>[]
	), //Column
	); //Center
}
}
