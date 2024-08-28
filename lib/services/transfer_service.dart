import 'package:dart_bank/models/account.dart';

void transferService(Account origin, Account destination, double value) {
  if (origin == destination){
    throw Exception("Not allowed transfer to some account");}
  if (value<1){
    throw Exception("Not allowed transfer below one");}
  if (origin.getBalance() < value){
    throw Exception("You don't have enough balance");
  }
  origin.removeBalance(value);
  destination.addBalance(value);
}
