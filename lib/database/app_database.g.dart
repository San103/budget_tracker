// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bankMeta = const VerificationMeta('bank');
  @override
  late final GeneratedColumn<String> bank = GeneratedColumn<String>(
    'bank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDigitMeta = const VerificationMeta(
    'lastDigit',
  );
  @override
  late final GeneratedColumn<int> lastDigit = GeneratedColumn<int>(
    'last_digit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _networkMeta = const VerificationMeta(
    'network',
  );
  @override
  late final GeneratedColumn<String> network = GeneratedColumn<String>(
    'network',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryMonthMeta = const VerificationMeta(
    'expiryMonth',
  );
  @override
  late final GeneratedColumn<int> expiryMonth = GeneratedColumn<int>(
    'expiry_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryYearMeta = const VerificationMeta(
    'expiryYear',
  );
  @override
  late final GeneratedColumn<int> expiryYear = GeneratedColumn<int>(
    'expiry_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statementDayMeta = const VerificationMeta(
    'statementDay',
  );
  @override
  late final GeneratedColumn<int> statementDay = GeneratedColumn<int>(
    'statement_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paletteIndexMeta = const VerificationMeta(
    'paletteIndex',
  );
  @override
  late final GeneratedColumn<int> paletteIndex = GeneratedColumn<int>(
    'palette_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bank,
    name,
    type,
    balance,
    creditLimit,
    lastDigit,
    network,
    expiryMonth,
    expiryYear,
    statementDay,
    dueDay,
    paletteIndex,
    icon,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank')) {
      context.handle(
        _bankMeta,
        bank.isAcceptableOrUnknown(data['bank']!, _bankMeta),
      );
    } else if (isInserting) {
      context.missing(_bankMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    if (data.containsKey('last_digit')) {
      context.handle(
        _lastDigitMeta,
        lastDigit.isAcceptableOrUnknown(data['last_digit']!, _lastDigitMeta),
      );
    }
    if (data.containsKey('network')) {
      context.handle(
        _networkMeta,
        network.isAcceptableOrUnknown(data['network']!, _networkMeta),
      );
    } else if (isInserting) {
      context.missing(_networkMeta);
    }
    if (data.containsKey('expiry_month')) {
      context.handle(
        _expiryMonthMeta,
        expiryMonth.isAcceptableOrUnknown(
          data['expiry_month']!,
          _expiryMonthMeta,
        ),
      );
    }
    if (data.containsKey('expiry_year')) {
      context.handle(
        _expiryYearMeta,
        expiryYear.isAcceptableOrUnknown(data['expiry_year']!, _expiryYearMeta),
      );
    }
    if (data.containsKey('statement_day')) {
      context.handle(
        _statementDayMeta,
        statementDay.isAcceptableOrUnknown(
          data['statement_day']!,
          _statementDayMeta,
        ),
      );
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    }
    if (data.containsKey('palette_index')) {
      context.handle(
        _paletteIndexMeta,
        paletteIndex.isAcceptableOrUnknown(
          data['palette_index']!,
          _paletteIndexMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      ),
      lastDigit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_digit'],
      ),
      network: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}network'],
      )!,
      expiryMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expiry_month'],
      ),
      expiryYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expiry_year'],
      ),
      statementDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}statement_day'],
      ),
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      ),
      paletteIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}palette_index'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String bank;
  final String name;
  final String type;
  final double balance;
  final double? creditLimit;
  final int? lastDigit;
  final String network;
  final int? expiryMonth;
  final int? expiryYear;
  final int? statementDay;
  final int? dueDay;
  final int paletteIndex;
  final String icon;
  final bool isActive;
  const Account({
    required this.id,
    required this.bank,
    required this.name,
    required this.type,
    required this.balance,
    this.creditLimit,
    this.lastDigit,
    required this.network,
    this.expiryMonth,
    this.expiryYear,
    this.statementDay,
    this.dueDay,
    required this.paletteIndex,
    required this.icon,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bank'] = Variable<String>(bank);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || creditLimit != null) {
      map['credit_limit'] = Variable<double>(creditLimit);
    }
    if (!nullToAbsent || lastDigit != null) {
      map['last_digit'] = Variable<int>(lastDigit);
    }
    map['network'] = Variable<String>(network);
    if (!nullToAbsent || expiryMonth != null) {
      map['expiry_month'] = Variable<int>(expiryMonth);
    }
    if (!nullToAbsent || expiryYear != null) {
      map['expiry_year'] = Variable<int>(expiryYear);
    }
    if (!nullToAbsent || statementDay != null) {
      map['statement_day'] = Variable<int>(statementDay);
    }
    if (!nullToAbsent || dueDay != null) {
      map['due_day'] = Variable<int>(dueDay);
    }
    map['palette_index'] = Variable<int>(paletteIndex);
    map['icon'] = Variable<String>(icon);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      bank: Value(bank),
      name: Value(name),
      type: Value(type),
      balance: Value(balance),
      creditLimit: creditLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimit),
      lastDigit: lastDigit == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDigit),
      network: Value(network),
      expiryMonth: expiryMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryMonth),
      expiryYear: expiryYear == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryYear),
      statementDay: statementDay == null && nullToAbsent
          ? const Value.absent()
          : Value(statementDay),
      dueDay: dueDay == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDay),
      paletteIndex: Value(paletteIndex),
      icon: Value(icon),
      isActive: Value(isActive),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      bank: serializer.fromJson<String>(json['bank']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      balance: serializer.fromJson<double>(json['balance']),
      creditLimit: serializer.fromJson<double?>(json['creditLimit']),
      lastDigit: serializer.fromJson<int?>(json['lastDigit']),
      network: serializer.fromJson<String>(json['network']),
      expiryMonth: serializer.fromJson<int?>(json['expiryMonth']),
      expiryYear: serializer.fromJson<int?>(json['expiryYear']),
      statementDay: serializer.fromJson<int?>(json['statementDay']),
      dueDay: serializer.fromJson<int?>(json['dueDay']),
      paletteIndex: serializer.fromJson<int>(json['paletteIndex']),
      icon: serializer.fromJson<String>(json['icon']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bank': serializer.toJson<String>(bank),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'balance': serializer.toJson<double>(balance),
      'creditLimit': serializer.toJson<double?>(creditLimit),
      'lastDigit': serializer.toJson<int?>(lastDigit),
      'network': serializer.toJson<String>(network),
      'expiryMonth': serializer.toJson<int?>(expiryMonth),
      'expiryYear': serializer.toJson<int?>(expiryYear),
      'statementDay': serializer.toJson<int?>(statementDay),
      'dueDay': serializer.toJson<int?>(dueDay),
      'paletteIndex': serializer.toJson<int>(paletteIndex),
      'icon': serializer.toJson<String>(icon),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Account copyWith({
    int? id,
    String? bank,
    String? name,
    String? type,
    double? balance,
    Value<double?> creditLimit = const Value.absent(),
    Value<int?> lastDigit = const Value.absent(),
    String? network,
    Value<int?> expiryMonth = const Value.absent(),
    Value<int?> expiryYear = const Value.absent(),
    Value<int?> statementDay = const Value.absent(),
    Value<int?> dueDay = const Value.absent(),
    int? paletteIndex,
    String? icon,
    bool? isActive,
  }) => Account(
    id: id ?? this.id,
    bank: bank ?? this.bank,
    name: name ?? this.name,
    type: type ?? this.type,
    balance: balance ?? this.balance,
    creditLimit: creditLimit.present ? creditLimit.value : this.creditLimit,
    lastDigit: lastDigit.present ? lastDigit.value : this.lastDigit,
    network: network ?? this.network,
    expiryMonth: expiryMonth.present ? expiryMonth.value : this.expiryMonth,
    expiryYear: expiryYear.present ? expiryYear.value : this.expiryYear,
    statementDay: statementDay.present ? statementDay.value : this.statementDay,
    dueDay: dueDay.present ? dueDay.value : this.dueDay,
    paletteIndex: paletteIndex ?? this.paletteIndex,
    icon: icon ?? this.icon,
    isActive: isActive ?? this.isActive,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      bank: data.bank.present ? data.bank.value : this.bank,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      balance: data.balance.present ? data.balance.value : this.balance,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
      lastDigit: data.lastDigit.present ? data.lastDigit.value : this.lastDigit,
      network: data.network.present ? data.network.value : this.network,
      expiryMonth: data.expiryMonth.present
          ? data.expiryMonth.value
          : this.expiryMonth,
      expiryYear: data.expiryYear.present
          ? data.expiryYear.value
          : this.expiryYear,
      statementDay: data.statementDay.present
          ? data.statementDay.value
          : this.statementDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      paletteIndex: data.paletteIndex.present
          ? data.paletteIndex.value
          : this.paletteIndex,
      icon: data.icon.present ? data.icon.value : this.icon,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('bank: $bank, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balance: $balance, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('lastDigit: $lastDigit, ')
          ..write('network: $network, ')
          ..write('expiryMonth: $expiryMonth, ')
          ..write('expiryYear: $expiryYear, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('paletteIndex: $paletteIndex, ')
          ..write('icon: $icon, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bank,
    name,
    type,
    balance,
    creditLimit,
    lastDigit,
    network,
    expiryMonth,
    expiryYear,
    statementDay,
    dueDay,
    paletteIndex,
    icon,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.bank == this.bank &&
          other.name == this.name &&
          other.type == this.type &&
          other.balance == this.balance &&
          other.creditLimit == this.creditLimit &&
          other.lastDigit == this.lastDigit &&
          other.network == this.network &&
          other.expiryMonth == this.expiryMonth &&
          other.expiryYear == this.expiryYear &&
          other.statementDay == this.statementDay &&
          other.dueDay == this.dueDay &&
          other.paletteIndex == this.paletteIndex &&
          other.icon == this.icon &&
          other.isActive == this.isActive);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String> bank;
  final Value<String> name;
  final Value<String> type;
  final Value<double> balance;
  final Value<double?> creditLimit;
  final Value<int?> lastDigit;
  final Value<String> network;
  final Value<int?> expiryMonth;
  final Value<int?> expiryYear;
  final Value<int?> statementDay;
  final Value<int?> dueDay;
  final Value<int> paletteIndex;
  final Value<String> icon;
  final Value<bool> isActive;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.bank = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.balance = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.lastDigit = const Value.absent(),
    this.network = const Value.absent(),
    this.expiryMonth = const Value.absent(),
    this.expiryYear = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.paletteIndex = const Value.absent(),
    this.icon = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String bank,
    required String name,
    required String type,
    this.balance = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.lastDigit = const Value.absent(),
    required String network,
    this.expiryMonth = const Value.absent(),
    this.expiryYear = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.paletteIndex = const Value.absent(),
    required String icon,
    this.isActive = const Value.absent(),
  }) : bank = Value(bank),
       name = Value(name),
       type = Value(type),
       network = Value(network),
       icon = Value(icon);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? bank,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? balance,
    Expression<double>? creditLimit,
    Expression<int>? lastDigit,
    Expression<String>? network,
    Expression<int>? expiryMonth,
    Expression<int>? expiryYear,
    Expression<int>? statementDay,
    Expression<int>? dueDay,
    Expression<int>? paletteIndex,
    Expression<String>? icon,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bank != null) 'bank': bank,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (balance != null) 'balance': balance,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (lastDigit != null) 'last_digit': lastDigit,
      if (network != null) 'network': network,
      if (expiryMonth != null) 'expiry_month': expiryMonth,
      if (expiryYear != null) 'expiry_year': expiryYear,
      if (statementDay != null) 'statement_day': statementDay,
      if (dueDay != null) 'due_day': dueDay,
      if (paletteIndex != null) 'palette_index': paletteIndex,
      if (icon != null) 'icon': icon,
      if (isActive != null) 'is_active': isActive,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? bank,
    Value<String>? name,
    Value<String>? type,
    Value<double>? balance,
    Value<double?>? creditLimit,
    Value<int?>? lastDigit,
    Value<String>? network,
    Value<int?>? expiryMonth,
    Value<int?>? expiryYear,
    Value<int?>? statementDay,
    Value<int?>? dueDay,
    Value<int>? paletteIndex,
    Value<String>? icon,
    Value<bool>? isActive,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      bank: bank ?? this.bank,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      lastDigit: lastDigit ?? this.lastDigit,
      network: network ?? this.network,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      statementDay: statementDay ?? this.statementDay,
      dueDay: dueDay ?? this.dueDay,
      paletteIndex: paletteIndex ?? this.paletteIndex,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bank.present) {
      map['bank'] = Variable<String>(bank.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (lastDigit.present) {
      map['last_digit'] = Variable<int>(lastDigit.value);
    }
    if (network.present) {
      map['network'] = Variable<String>(network.value);
    }
    if (expiryMonth.present) {
      map['expiry_month'] = Variable<int>(expiryMonth.value);
    }
    if (expiryYear.present) {
      map['expiry_year'] = Variable<int>(expiryYear.value);
    }
    if (statementDay.present) {
      map['statement_day'] = Variable<int>(statementDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (paletteIndex.present) {
      map['palette_index'] = Variable<int>(paletteIndex.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('bank: $bank, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balance: $balance, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('lastDigit: $lastDigit, ')
          ..write('network: $network, ')
          ..write('expiryMonth: $expiryMonth, ')
          ..write('expiryYear: $expiryYear, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('paletteIndex: $paletteIndex, ')
          ..write('icon: $icon, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    type,
    title,
    category,
    amount,
    date,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int accountId;
  final String type;
  final String? title;
  final String category;
  final double amount;
  final DateTime date;
  final DateTime createdAt;
  const Transaction({
    required this.id,
    required this.accountId,
    required this.type,
    this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      type: Value(type),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      category: Value(category),
      amount: Value(amount),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String?>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String?>(title),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith({
    int? id,
    int? accountId,
    String? type,
    Value<String?> title = const Value.absent(),
    String? category,
    double? amount,
    DateTime? date,
    DateTime? createdAt,
  }) => Transaction(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    type: type ?? this.type,
    title: title.present ? title.value : this.title,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    type,
    title,
    category,
    amount,
    date,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.type == this.type &&
          other.title == this.title &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<String> type;
  final Value<String?> title;
  final Value<String> category;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required String type,
    this.title = const Value.absent(),
    required String category,
    required double amount,
    required DateTime date,
    this.createdAt = const Value.absent(),
  }) : accountId = Value(accountId),
       type = Value(type),
       category = Value(category),
       amount = Value(amount),
       date = Value(date);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<String>? type,
    Value<String?>? title,
    Value<String>? category,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [accounts, transactions];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required String bank,
  required String name,
  required String type,
  Value<double> balance,
  Value<double?> creditLimit,
  Value<int?> lastDigit,
  required String network,
  Value<int?> expiryMonth,
  Value<int?> expiryYear,
  Value<int?> statementDay,
  Value<int?> dueDay,
  Value<int> paletteIndex,
  required String icon,
  Value<bool> isActive,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<String> bank,
  Value<String> name,
  Value<String> type,
  Value<double> balance,
  Value<double?> creditLimit,
  Value<int?> lastDigit,
  Value<String> network,
  Value<int?> expiryMonth,
  Value<int?> expiryYear,
  Value<int?> statementDay,
  Value<int?> dueDay,
  Value<int> paletteIndex,
  Value<String> icon,
  Value<bool> isActive,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'accounts__id__transactions__account_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bank => $composableBuilder(
    column: $table.bank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastDigit => $composableBuilder(
    column: $table.lastDigit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiryMonth => $composableBuilder(
    column: $table.expiryMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiryYear => $composableBuilder(
    column: $table.expiryYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paletteIndex => $composableBuilder(
    column: $table.paletteIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bank => $composableBuilder(
    column: $table.bank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastDigit => $composableBuilder(
    column: $table.lastDigit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiryMonth => $composableBuilder(
    column: $table.expiryMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiryYear => $composableBuilder(
    column: $table.expiryYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paletteIndex => $composableBuilder(
    column: $table.paletteIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bank =>
      $composableBuilder(column: $table.bank, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastDigit =>
      $composableBuilder(column: $table.lastDigit, builder: (column) => column);

  GeneratedColumn<String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => column);

  GeneratedColumn<int> get expiryMonth => $composableBuilder(
    column: $table.expiryMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expiryYear => $composableBuilder(
    column: $table.expiryYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<int> get paletteIndex => $composableBuilder(
    column: $table.paletteIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bank = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
                Value<int?> lastDigit = const Value.absent(),
                Value<String> network = const Value.absent(),
                Value<int?> expiryMonth = const Value.absent(),
                Value<int?> expiryYear = const Value.absent(),
                Value<int?> statementDay = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<int> paletteIndex = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                bank: bank,
                name: name,
                type: type,
                balance: balance,
                creditLimit: creditLimit,
                lastDigit: lastDigit,
                network: network,
                expiryMonth: expiryMonth,
                expiryYear: expiryYear,
                statementDay: statementDay,
                dueDay: dueDay,
                paletteIndex: paletteIndex,
                icon: icon,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bank,
                required String name,
                required String type,
                Value<double> balance = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
                Value<int?> lastDigit = const Value.absent(),
                required String network,
                Value<int?> expiryMonth = const Value.absent(),
                Value<int?> expiryYear = const Value.absent(),
                Value<int?> statementDay = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<int> paletteIndex = const Value.absent(),
                required String icon,
                Value<bool> isActive = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                bank: bank,
                name: name,
                type: type,
                balance: balance,
                creditLimit: creditLimit,
                lastDigit: lastDigit,
                network: network,
                expiryMonth: expiryMonth,
                expiryYear: expiryYear,
                statementDay: statementDay,
                dueDay: dueDay,
                paletteIndex: paletteIndex,
                icon: icon,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      Account,
                      $AccountsTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$AccountsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$AccountsTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.accountId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int accountId,
      required String type,
      Value<String?> title,
      required String category,
      required double amount,
      required DateTime date,
      Value<DateTime> createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<String> type,
      Value<String?> title,
      Value<String> category,
      Value<double> amount,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool accountId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                accountId: accountId,
                type: type,
                title: title,
                category: category,
                amount: amount,
                date: date,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required String type,
                Value<String?> title = const Value.absent(),
                required String category,
                required double amount,
                required DateTime date,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                type: type,
                title: title,
                category: category,
                amount: amount,
                date: date,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$TransactionsTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$TransactionsTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool accountId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
