import 'dart:math';

import 'package:flutter/material.dart';

enum SentimentClassification { Positive, Neutral, Negative }

class SentimentText {
  String text;
  num confidence;
  SentimentClassification classification;
  SentimentText(this.text, this.confidence, this.classification);
}

class SentimentColoringExample extends StatelessWidget {
  final List<SentimentText> texts;

  SentimentColoringExample() : texts = List<SentimentText>() {
    var sentence =
        'Machine learning (ML) is the scientific study of algorithms and statistical models that computer systems use in order to perform a specific task effectively without using explicit instructions, relying on patterns and inference instead. It is seen as a subset of artificial intelligence. Machine learning algorithms build a mathematical model based on sample data, known as "training data", in order to make predictions or decisions without being explicitly programmed to perform the task.[1][2]:2 Machine learning algorithms are used in a wide variety of applications, such as email filtering, and computer vision, where it is infeasible to develop an algorithm of specific instructions for performing the task. Machine learning is closely related to computational statistics, which focuses on making predictions using computers. The study of mathematical optimization delivers methods, theory and application domains to the field of machine learning. Data mining is a field of study within machine learning, and focuses on exploratory data analysis through unsupervised learning.[3][4] In its application across business problems, machine learning is also referred to as predictive analytics.';
    var words = splitByStopChars(sentence);
    Random r = Random();
    for (var i = 0; i < words.length; i++) {
      SentimentClassification classification;
      var confidence = r.nextDouble();
      if (confidence <= 1.0 / 3) {
        classification = SentimentClassification.Negative;
      } else if ((confidence >= 1.0 / 3) && (confidence <= 2.0 / 3)) {
        classification = SentimentClassification.Neutral;
      } else {
        classification = SentimentClassification.Positive;
      }
      texts.add(SentimentText(words[i], confidence, classification));
    }
  }

  List<String> splitByStopChars(String sentence) {
    List<String> stopChars = ['.', ',', ' ', '"', "(", ")", "[", "]"];
    List<String> words = [];
    var word = StringBuffer();
    sentence.runes.forEach((int rune) {
      String c = String.fromCharCode(rune);
      if (stopChars.contains(c)) {
        if (word.toString().isNotEmpty) {
          words.add(word.toString());
        }
        words.add(c);
        word.clear();
      } else {
        word.writeCharCode(rune);
      }
    });
    return words;
  }

  int selectColorValue(num value) {
    var rounded = (value * 1000).round();
    var rem = rounded % 100;
    if (rem > 40) {
      rounded = rounded - rem + 100;
    } else {
      rounded = rounded - rem;
    }

    if (rounded == 0) {
      rounded = 50;
    } else if (rounded == 1000) {
      rounded = 900;
    }
    return rounded;
  }

  Color selectColor(SentimentText sentiment) {
    MaterialColor color;
    switch (sentiment.classification) {
      case SentimentClassification.Negative:
        color = Colors.red;
        break;
      case SentimentClassification.Neutral:
        color = Colors.grey;
        break;
      case SentimentClassification.Positive:
        color = Colors.green;
        break;
      default:
    }
    return color[selectColorValue(sentiment.confidence)];
  }

  @override
  Widget build(BuildContext context) {
    var spans = texts
        .map(
          (x) => TextSpan(
            text: x.text + " ",
            style: TextStyle(backgroundColor: selectColor(x)),
          ),
        )
        .toList();
    return Scaffold(
      body: Container(
        child: Center(
          child: RichText(
            text: TextSpan(
              children: spans,
            ),
          ),
        ),
      ),
    );
  }
}
