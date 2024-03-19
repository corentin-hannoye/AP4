import 'package:intl/intl.dart';

String formatPrice(double price) {
  return NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '€'
    )
    .format(price);
}
