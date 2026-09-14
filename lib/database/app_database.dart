import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get bank => text()();

  TextColumn get name => text()(); //cardholder name

  TextColumn get type => text()(); //debit/ credit

  RealColumn get balance => real().withDefault(const Constant(0))();

  RealColumn get creditLimit => real().nullable()();

  IntColumn get lastDigit => integer().nullable()();

  TextColumn get network => text()();

  IntColumn get expiryMonth => integer().nullable()();

  IntColumn get expiryYear => integer().nullable()();

  IntColumn get statementDay => integer().nullable()();

  IntColumn get dueDay => integer().nullable()();

  IntColumn get paletteIndex =>
      integer().withDefault(const Constant(0))(); //card color

  TextColumn get icon => text()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId => integer().references(Accounts, #id)();

  TextColumn get type => text()();

  TextColumn get title => text().nullable()();

  TextColumn get category => text()();

  RealColumn get amount => real()();

  DateTimeColumn get date => dateTime()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Accounts, Transactions])
// dart run build_runner build --delete-conflicting-outputs
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'budget_tracker');
  }

  Future<List<Account>> getAllAccounts() {
    return select(accounts).get();
  }

  Future<List<Transaction>> getAllTransactions() {
    return select(transactions).get();
  }

  Future<double> getTotalIncome() async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.amount.sum()])
      ..where(transactions.type.equals('income'));

    final result = await query.getSingle();
    return result.read(transactions.amount.sum()) ?? 0;
  }

  Future<double> getTotalExpenses() async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.amount.sum()])
      ..where(transactions.type.equals('expense'));

    final result = await query.getSingle();
    return result.read(transactions.amount.sum()) ?? 0;
  }

  Future<int> deleteAccount(int id) async {
    final hasTransactions = await (select(
      transactions,
    )..where((t) => t.accountId.equals(id))).get();

    if (hasTransactions.isNotEmpty) {
      throw Exception('Cannot delete account because it has transactions.');
    }

    return (delete(accounts)..where((a) => a.id.equals(id))).go();
  }

  Future<int> deleteTransaction(int id) {
    return (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  Future<void> addAccount({
    required String bank,
    required String name,
    required String type,
    required double balance,
    double? creditLimit,
    required int lastDigit,
    required String network,
    required int expiryMonth,
    required int expiryYear,
    int? statementDay,
    int? dueDay,
    required int paletteIndex,
    required String icon,
  }) async {
    await into(accounts).insert(
      AccountsCompanion.insert(
        bank: bank,
        name: name,
        type: type,
        balance: Value(balance),
        creditLimit: Value(creditLimit),
        lastDigit: Value(lastDigit),
        network: network,
        expiryMonth: Value(expiryMonth),
        expiryYear: Value(expiryYear),
        statementDay: Value(statementDay),
        dueDay: Value(dueDay),
        paletteIndex: Value(paletteIndex),
        icon: icon,
      ),
    );
  }

  Future<void> addTransaction({
    required int accountId,
    required String type,
    String? title,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    await into(transactions).insert(
      TransactionsCompanion.insert(
        accountId: accountId,
        type: type,
        title: Value(title),
        category: category,
        amount: amount,
        date: date,
      ),
    );
  }
}
