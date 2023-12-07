import 'package:flutter/material.dart';

const double defaultpd = 8.0;

Color mapSeverityToColor(String severity) {
  switch (severity) {
    case '0':
      return Color(0xFF97AAB3); // not classified
    case '1':
      return Color(0xFF7499FF); // information
    case '2':
      return Color(0xFFFFC859); // warning
    case '3':
      return Color(0xFFFFA059); // average
    case '4':
      return Color(0xFFE97659); // high
    case '5':
      return Color(0xFFE45959); // disaster
    default:
      return Colors.grey; // Cor padrão caso não haja correspondência
  }
}

String formatDuration(String timestamp) {
  String formattedDuration = '';
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(int.tryParse(timestamp)! * 1000);
  Duration duration = now.difference(dateTime);

  // Se a duração for maior que 1 mês, mostre meses, dias e horas
  if (duration.inDays >= 30) {
    int months = duration.inDays ~/ 30;
    formattedDuration = '${months}m ';
    duration -= Duration(days: months * 30);
  }

  // Se a duração for maior que 1 dia, mostre dias, horas e minutos
  if (duration.inDays >= 1) {
    formattedDuration += '${duration.inDays}d ';
    duration -= Duration(days: duration.inDays);
  }

  // Se a duração for maior que 1 hora, mostre horas e minutos
  if (duration.inHours >= 1) {
    formattedDuration += '${duration.inHours}h ';
    duration -= Duration(hours: duration.inHours);
  }

  // Se a duração for maior que 1 minuto, mostre minutos e segundos
  if (duration.inMinutes >= 1) {
    formattedDuration += '${duration.inMinutes}m ';
    duration -= Duration(minutes: duration.inMinutes);
  }

  // Se a duração for maior que 0 segundos e menor que 1 dia, mostre segundos
  if (duration.inSeconds > 0 && duration.inDays < 1) {
    formattedDuration += '${duration.inSeconds}s';
  }

  return formattedDuration.trim();
}
