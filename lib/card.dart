import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class PokerCard extends StatelessWidget {
  const PokerCard({Key? key, required this.card}) : super(key: key);

  final String card;

  @override
  Widget build(BuildContext context) {
    final match = RegExp(r'^[0-9]+').firstMatch(card);
    final value = cardValue((match?.group(0))!);
    final suit = cardSuit(card.substring(card.length - 1));
    return PlayingCardView(card: PlayingCard(suit, value));
  }

  Suit cardSuit(String suit) {
    switch (suit) {
      case 'c':
        return Suit.clubs;
      case 'd':
        return Suit.diamonds;
      case 'h':
        return Suit.hearts;
      case 's':
        return Suit.spades;
      default:
        return Suit.joker;
    }
  }

  CardValue cardValue(String value) {
    switch (value) {
      case '1':
        return CardValue.ace;
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
      default:
        return CardValue.joker_1;
    }
  }
}
