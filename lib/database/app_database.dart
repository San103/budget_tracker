import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Accounts extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get type => text()();

  RealColumn get balance => real().withDefault(const Constant(0))();

  RealColumn get creditLimit => real().nullable()();

  IntColumn get paletteIndex => integer().withDefault(const Constant(0))();

  TextColumn get icon => text()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn get id => text()();

  TextColumn get accountId => text().references(Accounts, #id)();

  TextColumn get type => text()();

  TextColumn get title => text().nullable()();

  TextColumn get category => text()();

  RealColumn get amount => real()();

  DateTimeColumn get date => dateTime()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Accounts, Transactions])
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

  Future<void> addAccount({
    required String id,
    required String name,
    required String type,
    required double balance,
    double? creditLimit,
    required int paletteIndex,
    required String icon,
  }) async {
    await into(accounts).insert(
      AccountsCompanion.insert(
        id: id,
        name: name,
        type: type,
        balance: Value(balance),
        creditLimit: Value(creditLimit),
        paletteIndex: Value(paletteIndex),
        icon: icon,
      ),
    );
  }

  Future<void> addTransaction({
    required String id,
    required String accountId,
    required String type,
    String? title,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    await into(transactions).insert(
      TransactionsCompanion.insert(
        id: id,
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
