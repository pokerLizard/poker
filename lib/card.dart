import 'package:flutter/material.dart';

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardValue {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

enum CardColor {
  red,
  black,
}

class PokerCard extends StatelessWidget {
  const PokerCard({Key? key, required this.card}) : super(key: key);

  final String card;

  @override
  Widget build(BuildContext context) {
    final match = RegExp(r'^[0-9]+').firstMatch(card);
    final value = match?.group(0);
    final suit = card.substring(card.length - 1);
    final color =
        cardColor(suit) == CardColor.black ? Colors.black : Colors.red;
    final valueText = Text(
      valueString(cardValue(value)),
      style: TextStyle(color: color, fontSize: 18),
    );
    final suitText = Text(
      suitString(cardSuit(suit)),
      style: TextStyle(color: color, fontSize: 22),
    );
    return Container(
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
            )
          ]),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: valueText,
          ),
          Align(
            alignment: Alignment.center,
            child: suitText,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: valueText,
          ),
        ],
      ),
    );
  }

  String suitString(CardSuit? suit) {
    switch (suit) {
      case CardSuit.clubs:
        return "♣";
      case CardSuit.diamonds:
        return "♦";
      case CardSuit.hearts:
        return "♥";
      case CardSuit.spades:
        return "♠";
      default:
        return "null";
    }
  }

  String valueString(CardValue? value) {
    switch (value) {
      case CardValue.ace:
        return "A";
      case CardValue.two:
        return "2";
      case CardValue.three:
        return "3";
      case CardValue.four:
        return "4";
      case CardValue.five:
        return "5";
      case CardValue.six:
        return "6";
      case CardValue.seven:
        return "7";
      case CardValue.eight:
        return "8";
      case CardValue.nine:
        return "9";
      case CardValue.ten:
        return "10";
      case CardValue.jack:
        return "J";
      case CardValue.queen:
        return "Q";
      case CardValue.king:
        return "K";
      default:
        return "A";
    }
  }

  CardColor cardColor(String? suit) {
    switch (suit) {
      case 'c':
        return CardColor.black;
      case 'd':
        return CardColor.red;
      case 'h':
        return CardColor.red;
      case 's':
        return CardColor.black;
      default:
        return CardColor.black;
    }
  }

  CardSuit cardSuit(String? suit) {
    switch (suit) {
      case 'c':
        return CardSuit.clubs;
      case 'd':
        return CardSuit.diamonds;
      case 'h':
        return CardSuit.hearts;
      case 's':
        return CardSuit.spades;
      default:
        return CardSuit.clubs;
    }
  }

  CardValue cardValue(String? value) {
    switch (value) {
      case '2':
        return CardValue.two;
      case '3':
        return CardValue.three;
      case '4':
        return CardValue.four;
      case '5':
        return CardValue.five;
      case '6':
        return CardValue.six;
      case '7':
        return CardValue.seven;
      case '8':
        return CardValue.eight;
      case '9':
        return CardValue.nine;
      case '10':
        return CardValue.ten;
      case '11':
        return CardValue.jack;
      case '12':
        return CardValue.queen;
      case '13':
        return CardValue.king;
      case '14':
        return CardValue.ace;
      default:
        return CardValue.ace;
    }
  }
}
