import 'package:dart_bank/models/account.dart';
import 'package:dart_bank/models/premium_account.dart';
import 'package:dart_bank/models/simple_account.dart';
import 'package:dart_bank/services/transfer_service.dart';
import 'package:test/test.dart';

void main() {
  group('transferService', () {
    late Account account1;
    late Account account2;

    setUp(() {
      account1 = SimpleAccount('Diego', 1001, 1000.0);
      account2 = PremiumAccount(
        'Arthur',
        1002,
        500.0,
        cashBack: 10.0,
      );
    });

    test('should transfer money from one simple account to premium account',
        () {
      transferService(account1, account2, 200.0);

      expect(account1.getBalance(), 800.0);
      expect(account2.getBalance(), 700.0);
    });
    test('should throw exception when trying to transfer to the same account', () {
      expect(
        () => transferService(account1, account1, 200.0),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Not allowed transfer to some account'))),
      );
    });

    test('should throw exception when trying to transfer below one', () {
      expect(
        () => transferService(account1, account2, 0.5),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Not allowed transfer below one'))),
      );
    });

    test('should throw exception when trying to transfer more than the balance', () {
      expect(
        () => transferService(account1, account2, 1200.0),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains("You don't have enough balance"))),
      );
    });
  });
}
