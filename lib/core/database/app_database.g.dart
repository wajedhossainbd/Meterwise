// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(AppConstants.defaultCurrencyCode),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    notes,
    currencyCode,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Property> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final int id;
  final String name;
  final String? address;
  final String? notes;

  /// ISO-4217 currency code (e.g. BDT, USD). Defaults to the app default.
  final String currencyCode;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Property({
    required this.id,
    required this.name,
    this.address,
    this.notes,
    required this.currencyCode,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      currencyCode: Value(currencyCode),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Property.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Property copyWith({
    int? id,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? currencyCode,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Property(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    currencyCode: currencyCode ?? this.currencyCode,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    address,
    notes,
    currencyCode,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.currencyCode == this.currencyCode &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<String> currencyCode;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PropertiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Property> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<String>? currencyCode,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PropertiesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? notes,
    Value<String>? currencyCode,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PropertiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      currencyCode: currencyCode ?? this.currencyCode,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ElectricityProvidersTable extends ElectricityProviders
    with TableInfo<$ElectricityProvidersTable, ElectricityProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElectricityProvidersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatPercentMeta = const VerificationMeta(
    'vatPercent',
  );
  @override
  late final GeneratedColumn<double> vatPercent = GeneratedColumn<double>(
    'vat_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rebatePercentMeta = const VerificationMeta(
    'rebatePercent',
  );
  @override
  late final GeneratedColumn<double> rebatePercent = GeneratedColumn<double>(
    'rebate_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _meterRentMeta = const VerificationMeta(
    'meterRent',
  );
  @override
  late final GeneratedColumn<double> meterRent = GeneratedColumn<double>(
    'meter_rent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _demandChargePerKwMeta = const VerificationMeta(
    'demandChargePerKw',
  );
  @override
  late final GeneratedColumn<double> demandChargePerKw =
      GeneratedColumn<double>(
        'demand_charge_per_kw',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    vatPercent,
    rebatePercent,
    meterRent,
    demandChargePerKw,
    currencyCode,
    isDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electricity_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ElectricityProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('vat_percent')) {
      context.handle(
        _vatPercentMeta,
        vatPercent.isAcceptableOrUnknown(data['vat_percent']!, _vatPercentMeta),
      );
    }
    if (data.containsKey('rebate_percent')) {
      context.handle(
        _rebatePercentMeta,
        rebatePercent.isAcceptableOrUnknown(
          data['rebate_percent']!,
          _rebatePercentMeta,
        ),
      );
    }
    if (data.containsKey('meter_rent')) {
      context.handle(
        _meterRentMeta,
        meterRent.isAcceptableOrUnknown(data['meter_rent']!, _meterRentMeta),
      );
    }
    if (data.containsKey('demand_charge_per_kw')) {
      context.handle(
        _demandChargePerKwMeta,
        demandChargePerKw.isAcceptableOrUnknown(
          data['demand_charge_per_kw']!,
          _demandChargePerKwMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElectricityProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElectricityProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      vatPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_percent'],
      )!,
      rebatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rebate_percent'],
      )!,
      meterRent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_rent'],
      )!,
      demandChargePerKw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}demand_charge_per_kw'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ElectricityProvidersTable createAlias(String alias) {
    return $ElectricityProvidersTable(attachedDatabase, alias);
  }
}

class ElectricityProvider extends DataClass
    implements Insertable<ElectricityProvider> {
  final int id;
  final String name;

  /// VAT applied on the energy cost, as a percentage (e.g. 5.0 == 5%).
  final double vatPercent;

  /// Prompt-payment rebate, as a percentage of energy cost.
  final double rebatePercent;

  /// Fixed monthly meter rent (absolute currency amount).
  final double meterRent;

  /// Demand charge per kW of sanctioned load (absolute amount per kW).
  final double demandChargePerKw;
  final String? currencyCode;

  /// Marks the provider seeded as the app default (DPDC LT-A).
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ElectricityProvider({
    required this.id,
    required this.name,
    required this.vatPercent,
    required this.rebatePercent,
    required this.meterRent,
    required this.demandChargePerKw,
    this.currencyCode,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['vat_percent'] = Variable<double>(vatPercent);
    map['rebate_percent'] = Variable<double>(rebatePercent);
    map['meter_rent'] = Variable<double>(meterRent);
    map['demand_charge_per_kw'] = Variable<double>(demandChargePerKw);
    if (!nullToAbsent || currencyCode != null) {
      map['currency_code'] = Variable<String>(currencyCode);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ElectricityProvidersCompanion toCompanion(bool nullToAbsent) {
    return ElectricityProvidersCompanion(
      id: Value(id),
      name: Value(name),
      vatPercent: Value(vatPercent),
      rebatePercent: Value(rebatePercent),
      meterRent: Value(meterRent),
      demandChargePerKw: Value(demandChargePerKw),
      currencyCode: currencyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyCode),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ElectricityProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElectricityProvider(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      vatPercent: serializer.fromJson<double>(json['vatPercent']),
      rebatePercent: serializer.fromJson<double>(json['rebatePercent']),
      meterRent: serializer.fromJson<double>(json['meterRent']),
      demandChargePerKw: serializer.fromJson<double>(json['demandChargePerKw']),
      currencyCode: serializer.fromJson<String?>(json['currencyCode']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'vatPercent': serializer.toJson<double>(vatPercent),
      'rebatePercent': serializer.toJson<double>(rebatePercent),
      'meterRent': serializer.toJson<double>(meterRent),
      'demandChargePerKw': serializer.toJson<double>(demandChargePerKw),
      'currencyCode': serializer.toJson<String?>(currencyCode),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ElectricityProvider copyWith({
    int? id,
    String? name,
    double? vatPercent,
    double? rebatePercent,
    double? meterRent,
    double? demandChargePerKw,
    Value<String?> currencyCode = const Value.absent(),
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ElectricityProvider(
    id: id ?? this.id,
    name: name ?? this.name,
    vatPercent: vatPercent ?? this.vatPercent,
    rebatePercent: rebatePercent ?? this.rebatePercent,
    meterRent: meterRent ?? this.meterRent,
    demandChargePerKw: demandChargePerKw ?? this.demandChargePerKw,
    currencyCode: currencyCode.present ? currencyCode.value : this.currencyCode,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ElectricityProvider copyWithCompanion(ElectricityProvidersCompanion data) {
    return ElectricityProvider(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      vatPercent: data.vatPercent.present
          ? data.vatPercent.value
          : this.vatPercent,
      rebatePercent: data.rebatePercent.present
          ? data.rebatePercent.value
          : this.rebatePercent,
      meterRent: data.meterRent.present ? data.meterRent.value : this.meterRent,
      demandChargePerKw: data.demandChargePerKw.present
          ? data.demandChargePerKw.value
          : this.demandChargePerKw,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityProvider(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vatPercent: $vatPercent, ')
          ..write('rebatePercent: $rebatePercent, ')
          ..write('meterRent: $meterRent, ')
          ..write('demandChargePerKw: $demandChargePerKw, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    vatPercent,
    rebatePercent,
    meterRent,
    demandChargePerKw,
    currencyCode,
    isDefault,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElectricityProvider &&
          other.id == this.id &&
          other.name == this.name &&
          other.vatPercent == this.vatPercent &&
          other.rebatePercent == this.rebatePercent &&
          other.meterRent == this.meterRent &&
          other.demandChargePerKw == this.demandChargePerKw &&
          other.currencyCode == this.currencyCode &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ElectricityProvidersCompanion
    extends UpdateCompanion<ElectricityProvider> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> vatPercent;
  final Value<double> rebatePercent;
  final Value<double> meterRent;
  final Value<double> demandChargePerKw;
  final Value<String?> currencyCode;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ElectricityProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.vatPercent = const Value.absent(),
    this.rebatePercent = const Value.absent(),
    this.meterRent = const Value.absent(),
    this.demandChargePerKw = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ElectricityProvidersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.vatPercent = const Value.absent(),
    this.rebatePercent = const Value.absent(),
    this.meterRent = const Value.absent(),
    this.demandChargePerKw = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ElectricityProvider> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? vatPercent,
    Expression<double>? rebatePercent,
    Expression<double>? meterRent,
    Expression<double>? demandChargePerKw,
    Expression<String>? currencyCode,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (vatPercent != null) 'vat_percent': vatPercent,
      if (rebatePercent != null) 'rebate_percent': rebatePercent,
      if (meterRent != null) 'meter_rent': meterRent,
      if (demandChargePerKw != null) 'demand_charge_per_kw': demandChargePerKw,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ElectricityProvidersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? vatPercent,
    Value<double>? rebatePercent,
    Value<double>? meterRent,
    Value<double>? demandChargePerKw,
    Value<String?>? currencyCode,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ElectricityProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      vatPercent: vatPercent ?? this.vatPercent,
      rebatePercent: rebatePercent ?? this.rebatePercent,
      meterRent: meterRent ?? this.meterRent,
      demandChargePerKw: demandChargePerKw ?? this.demandChargePerKw,
      currencyCode: currencyCode ?? this.currencyCode,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (vatPercent.present) {
      map['vat_percent'] = Variable<double>(vatPercent.value);
    }
    if (rebatePercent.present) {
      map['rebate_percent'] = Variable<double>(rebatePercent.value);
    }
    if (meterRent.present) {
      map['meter_rent'] = Variable<double>(meterRent.value);
    }
    if (demandChargePerKw.present) {
      map['demand_charge_per_kw'] = Variable<double>(demandChargePerKw.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vatPercent: $vatPercent, ')
          ..write('rebatePercent: $rebatePercent, ')
          ..write('meterRent: $meterRent, ')
          ..write('demandChargePerKw: $demandChargePerKw, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TariffSlabsTable extends TariffSlabs
    with TableInfo<$TariffSlabsTable, TariffSlab> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TariffSlabsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES electricity_providers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromUnitMeta = const VerificationMeta(
    'fromUnit',
  );
  @override
  late final GeneratedColumn<int> fromUnit = GeneratedColumn<int>(
    'from_unit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toUnitMeta = const VerificationMeta('toUnit');
  @override
  late final GeneratedColumn<int> toUnit = GeneratedColumn<int>(
    'to_unit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    fromUnit,
    toUnit,
    rate,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tariff_slabs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TariffSlab> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('from_unit')) {
      context.handle(
        _fromUnitMeta,
        fromUnit.isAcceptableOrUnknown(data['from_unit']!, _fromUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_fromUnitMeta);
    }
    if (data.containsKey('to_unit')) {
      context.handle(
        _toUnitMeta,
        toUnit.isAcceptableOrUnknown(data['to_unit']!, _toUnitMeta),
      );
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TariffSlab map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TariffSlab(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      fromUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_unit'],
      )!,
      toUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_unit'],
      ),
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $TariffSlabsTable createAlias(String alias) {
    return $TariffSlabsTable(attachedDatabase, alias);
  }
}

class TariffSlab extends DataClass implements Insertable<TariffSlab> {
  final int id;
  final int providerId;

  /// Inclusive lower bound of the slab in kWh (units).
  final int fromUnit;

  /// Inclusive upper bound in kWh, or `null` for the final open-ended slab.
  final int? toUnit;

  /// Per-unit price within this slab.
  final double rate;

  /// Display / evaluation order (ascending).
  final int sortOrder;
  const TariffSlab({
    required this.id,
    required this.providerId,
    required this.fromUnit,
    this.toUnit,
    required this.rate,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['provider_id'] = Variable<int>(providerId);
    map['from_unit'] = Variable<int>(fromUnit);
    if (!nullToAbsent || toUnit != null) {
      map['to_unit'] = Variable<int>(toUnit);
    }
    map['rate'] = Variable<double>(rate);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  TariffSlabsCompanion toCompanion(bool nullToAbsent) {
    return TariffSlabsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      fromUnit: Value(fromUnit),
      toUnit: toUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(toUnit),
      rate: Value(rate),
      sortOrder: Value(sortOrder),
    );
  }

  factory TariffSlab.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TariffSlab(
      id: serializer.fromJson<int>(json['id']),
      providerId: serializer.fromJson<int>(json['providerId']),
      fromUnit: serializer.fromJson<int>(json['fromUnit']),
      toUnit: serializer.fromJson<int?>(json['toUnit']),
      rate: serializer.fromJson<double>(json['rate']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'providerId': serializer.toJson<int>(providerId),
      'fromUnit': serializer.toJson<int>(fromUnit),
      'toUnit': serializer.toJson<int?>(toUnit),
      'rate': serializer.toJson<double>(rate),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  TariffSlab copyWith({
    int? id,
    int? providerId,
    int? fromUnit,
    Value<int?> toUnit = const Value.absent(),
    double? rate,
    int? sortOrder,
  }) => TariffSlab(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    fromUnit: fromUnit ?? this.fromUnit,
    toUnit: toUnit.present ? toUnit.value : this.toUnit,
    rate: rate ?? this.rate,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  TariffSlab copyWithCompanion(TariffSlabsCompanion data) {
    return TariffSlab(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      fromUnit: data.fromUnit.present ? data.fromUnit.value : this.fromUnit,
      toUnit: data.toUnit.present ? data.toUnit.value : this.toUnit,
      rate: data.rate.present ? data.rate.value : this.rate,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TariffSlab(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('fromUnit: $fromUnit, ')
          ..write('toUnit: $toUnit, ')
          ..write('rate: $rate, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, providerId, fromUnit, toUnit, rate, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TariffSlab &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.fromUnit == this.fromUnit &&
          other.toUnit == this.toUnit &&
          other.rate == this.rate &&
          other.sortOrder == this.sortOrder);
}

class TariffSlabsCompanion extends UpdateCompanion<TariffSlab> {
  final Value<int> id;
  final Value<int> providerId;
  final Value<int> fromUnit;
  final Value<int?> toUnit;
  final Value<double> rate;
  final Value<int> sortOrder;
  const TariffSlabsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.fromUnit = const Value.absent(),
    this.toUnit = const Value.absent(),
    this.rate = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  TariffSlabsCompanion.insert({
    this.id = const Value.absent(),
    required int providerId,
    required int fromUnit,
    this.toUnit = const Value.absent(),
    required double rate,
    this.sortOrder = const Value.absent(),
  }) : providerId = Value(providerId),
       fromUnit = Value(fromUnit),
       rate = Value(rate);
  static Insertable<TariffSlab> custom({
    Expression<int>? id,
    Expression<int>? providerId,
    Expression<int>? fromUnit,
    Expression<int>? toUnit,
    Expression<double>? rate,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (fromUnit != null) 'from_unit': fromUnit,
      if (toUnit != null) 'to_unit': toUnit,
      if (rate != null) 'rate': rate,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  TariffSlabsCompanion copyWith({
    Value<int>? id,
    Value<int>? providerId,
    Value<int>? fromUnit,
    Value<int?>? toUnit,
    Value<double>? rate,
    Value<int>? sortOrder,
  }) {
    return TariffSlabsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      rate: rate ?? this.rate,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (fromUnit.present) {
      map['from_unit'] = Variable<int>(fromUnit.value);
    }
    if (toUnit.present) {
      map['to_unit'] = Variable<int>(toUnit.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TariffSlabsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('fromUnit: $fromUnit, ')
          ..write('toUnit: $toUnit, ')
          ..write('rate: $rate, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $MainMetersTable extends MainMeters
    with TableInfo<$MainMetersTable, MainMeter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MainMetersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<int> propertyId = GeneratedColumn<int>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES electricity_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meterNumberMeta = const VerificationMeta(
    'meterNumber',
  );
  @override
  late final GeneratedColumn<String> meterNumber = GeneratedColumn<String>(
    'meter_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sanctionedLoadMeta = const VerificationMeta(
    'sanctionedLoad',
  );
  @override
  late final GeneratedColumn<double> sanctionedLoad = GeneratedColumn<double>(
    'sanctioned_load',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    providerId,
    name,
    meterNumber,
    sanctionedLoad,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'main_meters';
  @override
  VerificationContext validateIntegrity(
    Insertable<MainMeter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('meter_number')) {
      context.handle(
        _meterNumberMeta,
        meterNumber.isAcceptableOrUnknown(
          data['meter_number']!,
          _meterNumberMeta,
        ),
      );
    }
    if (data.containsKey('sanctioned_load')) {
      context.handle(
        _sanctionedLoadMeta,
        sanctionedLoad.isAcceptableOrUnknown(
          data['sanctioned_load']!,
          _sanctionedLoadMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MainMeter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MainMeter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}property_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      meterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_number'],
      ),
      sanctionedLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sanctioned_load'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MainMetersTable createAlias(String alias) {
    return $MainMetersTable(attachedDatabase, alias);
  }
}

class MainMeter extends DataClass implements Insertable<MainMeter> {
  final int id;
  final int propertyId;
  final int providerId;
  final String name;
  final String? meterNumber;

  /// Sanctioned load in kW; used for the demand-charge calculation.
  final double? sanctionedLoad;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MainMeter({
    required this.id,
    required this.propertyId,
    required this.providerId,
    required this.name,
    this.meterNumber,
    this.sanctionedLoad,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['property_id'] = Variable<int>(propertyId);
    map['provider_id'] = Variable<int>(providerId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || meterNumber != null) {
      map['meter_number'] = Variable<String>(meterNumber);
    }
    if (!nullToAbsent || sanctionedLoad != null) {
      map['sanctioned_load'] = Variable<double>(sanctionedLoad);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MainMetersCompanion toCompanion(bool nullToAbsent) {
    return MainMetersCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      providerId: Value(providerId),
      name: Value(name),
      meterNumber: meterNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(meterNumber),
      sanctionedLoad: sanctionedLoad == null && nullToAbsent
          ? const Value.absent()
          : Value(sanctionedLoad),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MainMeter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MainMeter(
      id: serializer.fromJson<int>(json['id']),
      propertyId: serializer.fromJson<int>(json['propertyId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      name: serializer.fromJson<String>(json['name']),
      meterNumber: serializer.fromJson<String?>(json['meterNumber']),
      sanctionedLoad: serializer.fromJson<double?>(json['sanctionedLoad']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'propertyId': serializer.toJson<int>(propertyId),
      'providerId': serializer.toJson<int>(providerId),
      'name': serializer.toJson<String>(name),
      'meterNumber': serializer.toJson<String?>(meterNumber),
      'sanctionedLoad': serializer.toJson<double?>(sanctionedLoad),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MainMeter copyWith({
    int? id,
    int? propertyId,
    int? providerId,
    String? name,
    Value<String?> meterNumber = const Value.absent(),
    Value<double?> sanctionedLoad = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MainMeter(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    providerId: providerId ?? this.providerId,
    name: name ?? this.name,
    meterNumber: meterNumber.present ? meterNumber.value : this.meterNumber,
    sanctionedLoad: sanctionedLoad.present
        ? sanctionedLoad.value
        : this.sanctionedLoad,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MainMeter copyWithCompanion(MainMetersCompanion data) {
    return MainMeter(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      name: data.name.present ? data.name.value : this.name,
      meterNumber: data.meterNumber.present
          ? data.meterNumber.value
          : this.meterNumber,
      sanctionedLoad: data.sanctionedLoad.present
          ? data.sanctionedLoad.value
          : this.sanctionedLoad,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MainMeter(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('providerId: $providerId, ')
          ..write('name: $name, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('sanctionedLoad: $sanctionedLoad, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    providerId,
    name,
    meterNumber,
    sanctionedLoad,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainMeter &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.providerId == this.providerId &&
          other.name == this.name &&
          other.meterNumber == this.meterNumber &&
          other.sanctionedLoad == this.sanctionedLoad &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MainMetersCompanion extends UpdateCompanion<MainMeter> {
  final Value<int> id;
  final Value<int> propertyId;
  final Value<int> providerId;
  final Value<String> name;
  final Value<String?> meterNumber;
  final Value<double?> sanctionedLoad;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MainMetersCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.name = const Value.absent(),
    this.meterNumber = const Value.absent(),
    this.sanctionedLoad = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MainMetersCompanion.insert({
    this.id = const Value.absent(),
    required int propertyId,
    required int providerId,
    required String name,
    this.meterNumber = const Value.absent(),
    this.sanctionedLoad = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : propertyId = Value(propertyId),
       providerId = Value(providerId),
       name = Value(name);
  static Insertable<MainMeter> custom({
    Expression<int>? id,
    Expression<int>? propertyId,
    Expression<int>? providerId,
    Expression<String>? name,
    Expression<String>? meterNumber,
    Expression<double>? sanctionedLoad,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (providerId != null) 'provider_id': providerId,
      if (name != null) 'name': name,
      if (meterNumber != null) 'meter_number': meterNumber,
      if (sanctionedLoad != null) 'sanctioned_load': sanctionedLoad,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MainMetersCompanion copyWith({
    Value<int>? id,
    Value<int>? propertyId,
    Value<int>? providerId,
    Value<String>? name,
    Value<String?>? meterNumber,
    Value<double?>? sanctionedLoad,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MainMetersCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      providerId: providerId ?? this.providerId,
      name: name ?? this.name,
      meterNumber: meterNumber ?? this.meterNumber,
      sanctionedLoad: sanctionedLoad ?? this.sanctionedLoad,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<int>(propertyId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (meterNumber.present) {
      map['meter_number'] = Variable<String>(meterNumber.value);
    }
    if (sanctionedLoad.present) {
      map['sanctioned_load'] = Variable<double>(sanctionedLoad.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MainMetersCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('providerId: $providerId, ')
          ..write('name: $name, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('sanctionedLoad: $sanctionedLoad, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TenantsTable extends Tenants with TableInfo<$TenantsTable, Tenant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mainMeterIdMeta = const VerificationMeta(
    'mainMeterId',
  );
  @override
  late final GeneratedColumn<int> mainMeterId = GeneratedColumn<int>(
    'main_meter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES main_meters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apartmentMeta = const VerificationMeta(
    'apartment',
  );
  @override
  late final GeneratedColumn<String> apartment = GeneratedColumn<String>(
    'apartment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meterNumberMeta = const VerificationMeta(
    'meterNumber',
  );
  @override
  late final GeneratedColumn<String> meterNumber = GeneratedColumn<String>(
    'meter_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _billingModeMeta = const VerificationMeta(
    'billingMode',
  );
  @override
  late final GeneratedColumn<String> billingMode = GeneratedColumn<String>(
    'billing_mode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('shared'),
  );
  static const VerificationMeta _fixedRateMeta = const VerificationMeta(
    'fixedRate',
  );
  @override
  late final GeneratedColumn<double> fixedRate = GeneratedColumn<double>(
    'fixed_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mainMeterId,
    name,
    phone,
    email,
    apartment,
    meterNumber,
    status,
    billingMode,
    fixedRate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenants';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tenant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_meter_id')) {
      context.handle(
        _mainMeterIdMeta,
        mainMeterId.isAcceptableOrUnknown(
          data['main_meter_id']!,
          _mainMeterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainMeterIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('apartment')) {
      context.handle(
        _apartmentMeta,
        apartment.isAcceptableOrUnknown(data['apartment']!, _apartmentMeta),
      );
    }
    if (data.containsKey('meter_number')) {
      context.handle(
        _meterNumberMeta,
        meterNumber.isAcceptableOrUnknown(
          data['meter_number']!,
          _meterNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('billing_mode')) {
      context.handle(
        _billingModeMeta,
        billingMode.isAcceptableOrUnknown(
          data['billing_mode']!,
          _billingModeMeta,
        ),
      );
    }
    if (data.containsKey('fixed_rate')) {
      context.handle(
        _fixedRateMeta,
        fixedRate.isAcceptableOrUnknown(data['fixed_rate']!, _fixedRateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tenant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tenant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mainMeterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}main_meter_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      apartment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apartment'],
      ),
      meterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      billingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_mode'],
      )!,
      fixedRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fixed_rate'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TenantsTable createAlias(String alias) {
    return $TenantsTable(attachedDatabase, alias);
  }
}

class Tenant extends DataClass implements Insertable<Tenant> {
  final int id;
  final int mainMeterId;
  final String name;
  final String? phone;
  final String? email;
  final String? apartment;
  final String? meterNumber;
  final String status;

  /// Billing contract: 'shared' (slab-sharing, default) or 'fixed' (flat
  /// per-unit price stored in [fixedRate]).
  final String billingMode;

  /// Negotiated flat price per unit; only meaningful when [billingMode] is
  /// 'fixed'.
  final double? fixedRate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Tenant({
    required this.id,
    required this.mainMeterId,
    required this.name,
    this.phone,
    this.email,
    this.apartment,
    this.meterNumber,
    required this.status,
    required this.billingMode,
    this.fixedRate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['main_meter_id'] = Variable<int>(mainMeterId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || apartment != null) {
      map['apartment'] = Variable<String>(apartment);
    }
    if (!nullToAbsent || meterNumber != null) {
      map['meter_number'] = Variable<String>(meterNumber);
    }
    map['status'] = Variable<String>(status);
    map['billing_mode'] = Variable<String>(billingMode);
    if (!nullToAbsent || fixedRate != null) {
      map['fixed_rate'] = Variable<double>(fixedRate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenantsCompanion toCompanion(bool nullToAbsent) {
    return TenantsCompanion(
      id: Value(id),
      mainMeterId: Value(mainMeterId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      apartment: apartment == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment),
      meterNumber: meterNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(meterNumber),
      status: Value(status),
      billingMode: Value(billingMode),
      fixedRate: fixedRate == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedRate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Tenant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tenant(
      id: serializer.fromJson<int>(json['id']),
      mainMeterId: serializer.fromJson<int>(json['mainMeterId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      apartment: serializer.fromJson<String?>(json['apartment']),
      meterNumber: serializer.fromJson<String?>(json['meterNumber']),
      status: serializer.fromJson<String>(json['status']),
      billingMode: serializer.fromJson<String>(json['billingMode']),
      fixedRate: serializer.fromJson<double?>(json['fixedRate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainMeterId': serializer.toJson<int>(mainMeterId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'apartment': serializer.toJson<String?>(apartment),
      'meterNumber': serializer.toJson<String?>(meterNumber),
      'status': serializer.toJson<String>(status),
      'billingMode': serializer.toJson<String>(billingMode),
      'fixedRate': serializer.toJson<double?>(fixedRate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Tenant copyWith({
    int? id,
    int? mainMeterId,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> apartment = const Value.absent(),
    Value<String?> meterNumber = const Value.absent(),
    String? status,
    String? billingMode,
    Value<double?> fixedRate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Tenant(
    id: id ?? this.id,
    mainMeterId: mainMeterId ?? this.mainMeterId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    apartment: apartment.present ? apartment.value : this.apartment,
    meterNumber: meterNumber.present ? meterNumber.value : this.meterNumber,
    status: status ?? this.status,
    billingMode: billingMode ?? this.billingMode,
    fixedRate: fixedRate.present ? fixedRate.value : this.fixedRate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Tenant copyWithCompanion(TenantsCompanion data) {
    return Tenant(
      id: data.id.present ? data.id.value : this.id,
      mainMeterId: data.mainMeterId.present
          ? data.mainMeterId.value
          : this.mainMeterId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      apartment: data.apartment.present ? data.apartment.value : this.apartment,
      meterNumber: data.meterNumber.present
          ? data.meterNumber.value
          : this.meterNumber,
      status: data.status.present ? data.status.value : this.status,
      billingMode: data.billingMode.present
          ? data.billingMode.value
          : this.billingMode,
      fixedRate: data.fixedRate.present ? data.fixedRate.value : this.fixedRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tenant(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('apartment: $apartment, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('status: $status, ')
          ..write('billingMode: $billingMode, ')
          ..write('fixedRate: $fixedRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainMeterId,
    name,
    phone,
    email,
    apartment,
    meterNumber,
    status,
    billingMode,
    fixedRate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tenant &&
          other.id == this.id &&
          other.mainMeterId == this.mainMeterId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.apartment == this.apartment &&
          other.meterNumber == this.meterNumber &&
          other.status == this.status &&
          other.billingMode == this.billingMode &&
          other.fixedRate == this.fixedRate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TenantsCompanion extends UpdateCompanion<Tenant> {
  final Value<int> id;
  final Value<int> mainMeterId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> apartment;
  final Value<String?> meterNumber;
  final Value<String> status;
  final Value<String> billingMode;
  final Value<double?> fixedRate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TenantsCompanion({
    this.id = const Value.absent(),
    this.mainMeterId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.apartment = const Value.absent(),
    this.meterNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.billingMode = const Value.absent(),
    this.fixedRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TenantsCompanion.insert({
    this.id = const Value.absent(),
    required int mainMeterId,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.apartment = const Value.absent(),
    this.meterNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.billingMode = const Value.absent(),
    this.fixedRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : mainMeterId = Value(mainMeterId),
       name = Value(name);
  static Insertable<Tenant> custom({
    Expression<int>? id,
    Expression<int>? mainMeterId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? apartment,
    Expression<String>? meterNumber,
    Expression<String>? status,
    Expression<String>? billingMode,
    Expression<double>? fixedRate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainMeterId != null) 'main_meter_id': mainMeterId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (apartment != null) 'apartment': apartment,
      if (meterNumber != null) 'meter_number': meterNumber,
      if (status != null) 'status': status,
      if (billingMode != null) 'billing_mode': billingMode,
      if (fixedRate != null) 'fixed_rate': fixedRate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TenantsCompanion copyWith({
    Value<int>? id,
    Value<int>? mainMeterId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? apartment,
    Value<String?>? meterNumber,
    Value<String>? status,
    Value<String>? billingMode,
    Value<double?>? fixedRate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TenantsCompanion(
      id: id ?? this.id,
      mainMeterId: mainMeterId ?? this.mainMeterId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      apartment: apartment ?? this.apartment,
      meterNumber: meterNumber ?? this.meterNumber,
      status: status ?? this.status,
      billingMode: billingMode ?? this.billingMode,
      fixedRate: fixedRate ?? this.fixedRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainMeterId.present) {
      map['main_meter_id'] = Variable<int>(mainMeterId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (apartment.present) {
      map['apartment'] = Variable<String>(apartment.value);
    }
    if (meterNumber.present) {
      map['meter_number'] = Variable<String>(meterNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (billingMode.present) {
      map['billing_mode'] = Variable<String>(billingMode.value);
    }
    if (fixedRate.present) {
      map['fixed_rate'] = Variable<double>(fixedRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantsCompanion(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('apartment: $apartment, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('status: $status, ')
          ..write('billingMode: $billingMode, ')
          ..write('fixedRate: $fixedRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MeterReadingsTable extends MeterReadings
    with TableInfo<$MeterReadingsTable, MeterReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeterReadingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mainMeterIdMeta = const VerificationMeta(
    'mainMeterId',
  );
  @override
  late final GeneratedColumn<int> mainMeterId = GeneratedColumn<int>(
    'main_meter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES main_meters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenants (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _readingDateMeta = const VerificationMeta(
    'readingDate',
  );
  @override
  late final GeneratedColumn<DateTime> readingDate = GeneratedColumn<DateTime>(
    'reading_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readingValueMeta = const VerificationMeta(
    'readingValue',
  );
  @override
  late final GeneratedColumn<double> readingValue = GeneratedColumn<double>(
    'reading_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    mainMeterId,
    tenantId,
    readingDate,
    readingValue,
    notes,
    photoPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meter_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeterReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_meter_id')) {
      context.handle(
        _mainMeterIdMeta,
        mainMeterId.isAcceptableOrUnknown(
          data['main_meter_id']!,
          _mainMeterIdMeta,
        ),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('reading_date')) {
      context.handle(
        _readingDateMeta,
        readingDate.isAcceptableOrUnknown(
          data['reading_date']!,
          _readingDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingDateMeta);
    }
    if (data.containsKey('reading_value')) {
      context.handle(
        _readingValueMeta,
        readingValue.isAcceptableOrUnknown(
          data['reading_value']!,
          _readingValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingValueMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
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
  MeterReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeterReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mainMeterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}main_meter_id'],
      ),
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      ),
      readingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reading_date'],
      )!,
      readingValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_value'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MeterReadingsTable createAlias(String alias) {
    return $MeterReadingsTable(attachedDatabase, alias);
  }
}

class MeterReading extends DataClass implements Insertable<MeterReading> {
  final int id;
  final int? mainMeterId;
  final int? tenantId;
  final DateTime readingDate;

  /// Cumulative meter value at [readingDate].
  final double readingValue;
  final String? notes;

  /// Local file path to an attached meter photo (optional).
  final String? photoPath;
  final DateTime createdAt;
  const MeterReading({
    required this.id,
    this.mainMeterId,
    this.tenantId,
    required this.readingDate,
    required this.readingValue,
    this.notes,
    this.photoPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || mainMeterId != null) {
      map['main_meter_id'] = Variable<int>(mainMeterId);
    }
    if (!nullToAbsent || tenantId != null) {
      map['tenant_id'] = Variable<int>(tenantId);
    }
    map['reading_date'] = Variable<DateTime>(readingDate);
    map['reading_value'] = Variable<double>(readingValue);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MeterReadingsCompanion toCompanion(bool nullToAbsent) {
    return MeterReadingsCompanion(
      id: Value(id),
      mainMeterId: mainMeterId == null && nullToAbsent
          ? const Value.absent()
          : Value(mainMeterId),
      tenantId: tenantId == null && nullToAbsent
          ? const Value.absent()
          : Value(tenantId),
      readingDate: Value(readingDate),
      readingValue: Value(readingValue),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory MeterReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeterReading(
      id: serializer.fromJson<int>(json['id']),
      mainMeterId: serializer.fromJson<int?>(json['mainMeterId']),
      tenantId: serializer.fromJson<int?>(json['tenantId']),
      readingDate: serializer.fromJson<DateTime>(json['readingDate']),
      readingValue: serializer.fromJson<double>(json['readingValue']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainMeterId': serializer.toJson<int?>(mainMeterId),
      'tenantId': serializer.toJson<int?>(tenantId),
      'readingDate': serializer.toJson<DateTime>(readingDate),
      'readingValue': serializer.toJson<double>(readingValue),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MeterReading copyWith({
    int? id,
    Value<int?> mainMeterId = const Value.absent(),
    Value<int?> tenantId = const Value.absent(),
    DateTime? readingDate,
    double? readingValue,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
  }) => MeterReading(
    id: id ?? this.id,
    mainMeterId: mainMeterId.present ? mainMeterId.value : this.mainMeterId,
    tenantId: tenantId.present ? tenantId.value : this.tenantId,
    readingDate: readingDate ?? this.readingDate,
    readingValue: readingValue ?? this.readingValue,
    notes: notes.present ? notes.value : this.notes,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
  );
  MeterReading copyWithCompanion(MeterReadingsCompanion data) {
    return MeterReading(
      id: data.id.present ? data.id.value : this.id,
      mainMeterId: data.mainMeterId.present
          ? data.mainMeterId.value
          : this.mainMeterId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      readingDate: data.readingDate.present
          ? data.readingDate.value
          : this.readingDate,
      readingValue: data.readingValue.present
          ? data.readingValue.value
          : this.readingValue,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeterReading(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('tenantId: $tenantId, ')
          ..write('readingDate: $readingDate, ')
          ..write('readingValue: $readingValue, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainMeterId,
    tenantId,
    readingDate,
    readingValue,
    notes,
    photoPath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeterReading &&
          other.id == this.id &&
          other.mainMeterId == this.mainMeterId &&
          other.tenantId == this.tenantId &&
          other.readingDate == this.readingDate &&
          other.readingValue == this.readingValue &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class MeterReadingsCompanion extends UpdateCompanion<MeterReading> {
  final Value<int> id;
  final Value<int?> mainMeterId;
  final Value<int?> tenantId;
  final Value<DateTime> readingDate;
  final Value<double> readingValue;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  const MeterReadingsCompanion({
    this.id = const Value.absent(),
    this.mainMeterId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.readingDate = const Value.absent(),
    this.readingValue = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MeterReadingsCompanion.insert({
    this.id = const Value.absent(),
    this.mainMeterId = const Value.absent(),
    this.tenantId = const Value.absent(),
    required DateTime readingDate,
    required double readingValue,
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : readingDate = Value(readingDate),
       readingValue = Value(readingValue);
  static Insertable<MeterReading> custom({
    Expression<int>? id,
    Expression<int>? mainMeterId,
    Expression<int>? tenantId,
    Expression<DateTime>? readingDate,
    Expression<double>? readingValue,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainMeterId != null) 'main_meter_id': mainMeterId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (readingDate != null) 'reading_date': readingDate,
      if (readingValue != null) 'reading_value': readingValue,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MeterReadingsCompanion copyWith({
    Value<int>? id,
    Value<int?>? mainMeterId,
    Value<int?>? tenantId,
    Value<DateTime>? readingDate,
    Value<double>? readingValue,
    Value<String?>? notes,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
  }) {
    return MeterReadingsCompanion(
      id: id ?? this.id,
      mainMeterId: mainMeterId ?? this.mainMeterId,
      tenantId: tenantId ?? this.tenantId,
      readingDate: readingDate ?? this.readingDate,
      readingValue: readingValue ?? this.readingValue,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainMeterId.present) {
      map['main_meter_id'] = Variable<int>(mainMeterId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (readingDate.present) {
      map['reading_date'] = Variable<DateTime>(readingDate.value);
    }
    if (readingValue.present) {
      map['reading_value'] = Variable<double>(readingValue.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeterReadingsCompanion(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('tenantId: $tenantId, ')
          ..write('readingDate: $readingDate, ')
          ..write('readingValue: $readingValue, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RechargesTable extends Recharges
    with TableInfo<$RechargesTable, Recharge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RechargesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mainMeterIdMeta = const VerificationMeta(
    'mainMeterId',
  );
  @override
  late final GeneratedColumn<int> mainMeterId = GeneratedColumn<int>(
    'main_meter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES main_meters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _rechargeDateMeta = const VerificationMeta(
    'rechargeDate',
  );
  @override
  late final GeneratedColumn<DateTime> rechargeDate = GeneratedColumn<DateTime>(
    'recharge_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _energyCostMeta = const VerificationMeta(
    'energyCost',
  );
  @override
  late final GeneratedColumn<double> energyCost = GeneratedColumn<double>(
    'energy_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _demandChargeMeta = const VerificationMeta(
    'demandCharge',
  );
  @override
  late final GeneratedColumn<double> demandCharge = GeneratedColumn<double>(
    'demand_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _meterRentMeta = const VerificationMeta(
    'meterRent',
  );
  @override
  late final GeneratedColumn<double> meterRent = GeneratedColumn<double>(
    'meter_rent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vatMeta = const VerificationMeta('vat');
  @override
  late final GeneratedColumn<double> vat = GeneratedColumn<double>(
    'vat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rebateMeta = const VerificationMeta('rebate');
  @override
  late final GeneratedColumn<double> rebate = GeneratedColumn<double>(
    'rebate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _agentFeeMeta = const VerificationMeta(
    'agentFee',
  );
  @override
  late final GeneratedColumn<double> agentFee = GeneratedColumn<double>(
    'agent_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _otherExpensesMeta = const VerificationMeta(
    'otherExpenses',
  );
  @override
  late final GeneratedColumn<double> otherExpenses = GeneratedColumn<double>(
    'other_expenses',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidByMeta = const VerificationMeta('paidBy');
  @override
  late final GeneratedColumn<String> paidBy = GeneratedColumn<String>(
    'paid_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tokenNumberMeta = const VerificationMeta(
    'tokenNumber',
  );
  @override
  late final GeneratedColumn<String> tokenNumber = GeneratedColumn<String>(
    'token_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptPathMeta = const VerificationMeta(
    'receiptPath',
  );
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
    'receipt_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mainMeterId,
    rechargeDate,
    amount,
    energyCost,
    demandCharge,
    meterRent,
    vat,
    rebate,
    agentFee,
    otherExpenses,
    paidBy,
    tokenNumber,
    notes,
    receiptPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recharges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recharge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_meter_id')) {
      context.handle(
        _mainMeterIdMeta,
        mainMeterId.isAcceptableOrUnknown(
          data['main_meter_id']!,
          _mainMeterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainMeterIdMeta);
    }
    if (data.containsKey('recharge_date')) {
      context.handle(
        _rechargeDateMeta,
        rechargeDate.isAcceptableOrUnknown(
          data['recharge_date']!,
          _rechargeDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rechargeDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('energy_cost')) {
      context.handle(
        _energyCostMeta,
        energyCost.isAcceptableOrUnknown(data['energy_cost']!, _energyCostMeta),
      );
    }
    if (data.containsKey('demand_charge')) {
      context.handle(
        _demandChargeMeta,
        demandCharge.isAcceptableOrUnknown(
          data['demand_charge']!,
          _demandChargeMeta,
        ),
      );
    }
    if (data.containsKey('meter_rent')) {
      context.handle(
        _meterRentMeta,
        meterRent.isAcceptableOrUnknown(data['meter_rent']!, _meterRentMeta),
      );
    }
    if (data.containsKey('vat')) {
      context.handle(
        _vatMeta,
        vat.isAcceptableOrUnknown(data['vat']!, _vatMeta),
      );
    }
    if (data.containsKey('rebate')) {
      context.handle(
        _rebateMeta,
        rebate.isAcceptableOrUnknown(data['rebate']!, _rebateMeta),
      );
    }
    if (data.containsKey('agent_fee')) {
      context.handle(
        _agentFeeMeta,
        agentFee.isAcceptableOrUnknown(data['agent_fee']!, _agentFeeMeta),
      );
    }
    if (data.containsKey('other_expenses')) {
      context.handle(
        _otherExpensesMeta,
        otherExpenses.isAcceptableOrUnknown(
          data['other_expenses']!,
          _otherExpensesMeta,
        ),
      );
    }
    if (data.containsKey('paid_by')) {
      context.handle(
        _paidByMeta,
        paidBy.isAcceptableOrUnknown(data['paid_by']!, _paidByMeta),
      );
    }
    if (data.containsKey('token_number')) {
      context.handle(
        _tokenNumberMeta,
        tokenNumber.isAcceptableOrUnknown(
          data['token_number']!,
          _tokenNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
        _receiptPathMeta,
        receiptPath.isAcceptableOrUnknown(
          data['receipt_path']!,
          _receiptPathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recharge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recharge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mainMeterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}main_meter_id'],
      )!,
      rechargeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recharge_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      energyCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}energy_cost'],
      )!,
      demandCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}demand_charge'],
      )!,
      meterRent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_rent'],
      )!,
      vat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat'],
      )!,
      rebate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rebate'],
      )!,
      agentFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}agent_fee'],
      )!,
      otherExpenses: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_expenses'],
      )!,
      paidBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_by'],
      ),
      tokenNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token_number'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      receiptPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RechargesTable createAlias(String alias) {
    return $RechargesTable(attachedDatabase, alias);
  }
}

class Recharge extends DataClass implements Insertable<Recharge> {
  final int id;
  final int mainMeterId;
  final DateTime rechargeDate;

  /// Total amount paid for this recharge (what actually left the wallet).
  final double amount;
  final double energyCost;
  final double demandCharge;
  final double meterRent;
  final double vat;
  final double rebate;
  final double agentFee;
  final double otherExpenses;

  /// Free-text name of the person who paid (for per-payer reconciliation).
  final String? paidBy;
  final String? tokenNumber;
  final String? notes;

  /// Local file path to an attached receipt image (optional).
  final String? receiptPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Recharge({
    required this.id,
    required this.mainMeterId,
    required this.rechargeDate,
    required this.amount,
    required this.energyCost,
    required this.demandCharge,
    required this.meterRent,
    required this.vat,
    required this.rebate,
    required this.agentFee,
    required this.otherExpenses,
    this.paidBy,
    this.tokenNumber,
    this.notes,
    this.receiptPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['main_meter_id'] = Variable<int>(mainMeterId);
    map['recharge_date'] = Variable<DateTime>(rechargeDate);
    map['amount'] = Variable<double>(amount);
    map['energy_cost'] = Variable<double>(energyCost);
    map['demand_charge'] = Variable<double>(demandCharge);
    map['meter_rent'] = Variable<double>(meterRent);
    map['vat'] = Variable<double>(vat);
    map['rebate'] = Variable<double>(rebate);
    map['agent_fee'] = Variable<double>(agentFee);
    map['other_expenses'] = Variable<double>(otherExpenses);
    if (!nullToAbsent || paidBy != null) {
      map['paid_by'] = Variable<String>(paidBy);
    }
    if (!nullToAbsent || tokenNumber != null) {
      map['token_number'] = Variable<String>(tokenNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RechargesCompanion toCompanion(bool nullToAbsent) {
    return RechargesCompanion(
      id: Value(id),
      mainMeterId: Value(mainMeterId),
      rechargeDate: Value(rechargeDate),
      amount: Value(amount),
      energyCost: Value(energyCost),
      demandCharge: Value(demandCharge),
      meterRent: Value(meterRent),
      vat: Value(vat),
      rebate: Value(rebate),
      agentFee: Value(agentFee),
      otherExpenses: Value(otherExpenses),
      paidBy: paidBy == null && nullToAbsent
          ? const Value.absent()
          : Value(paidBy),
      tokenNumber: tokenNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenNumber),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Recharge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recharge(
      id: serializer.fromJson<int>(json['id']),
      mainMeterId: serializer.fromJson<int>(json['mainMeterId']),
      rechargeDate: serializer.fromJson<DateTime>(json['rechargeDate']),
      amount: serializer.fromJson<double>(json['amount']),
      energyCost: serializer.fromJson<double>(json['energyCost']),
      demandCharge: serializer.fromJson<double>(json['demandCharge']),
      meterRent: serializer.fromJson<double>(json['meterRent']),
      vat: serializer.fromJson<double>(json['vat']),
      rebate: serializer.fromJson<double>(json['rebate']),
      agentFee: serializer.fromJson<double>(json['agentFee']),
      otherExpenses: serializer.fromJson<double>(json['otherExpenses']),
      paidBy: serializer.fromJson<String?>(json['paidBy']),
      tokenNumber: serializer.fromJson<String?>(json['tokenNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainMeterId': serializer.toJson<int>(mainMeterId),
      'rechargeDate': serializer.toJson<DateTime>(rechargeDate),
      'amount': serializer.toJson<double>(amount),
      'energyCost': serializer.toJson<double>(energyCost),
      'demandCharge': serializer.toJson<double>(demandCharge),
      'meterRent': serializer.toJson<double>(meterRent),
      'vat': serializer.toJson<double>(vat),
      'rebate': serializer.toJson<double>(rebate),
      'agentFee': serializer.toJson<double>(agentFee),
      'otherExpenses': serializer.toJson<double>(otherExpenses),
      'paidBy': serializer.toJson<String?>(paidBy),
      'tokenNumber': serializer.toJson<String?>(tokenNumber),
      'notes': serializer.toJson<String?>(notes),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Recharge copyWith({
    int? id,
    int? mainMeterId,
    DateTime? rechargeDate,
    double? amount,
    double? energyCost,
    double? demandCharge,
    double? meterRent,
    double? vat,
    double? rebate,
    double? agentFee,
    double? otherExpenses,
    Value<String?> paidBy = const Value.absent(),
    Value<String?> tokenNumber = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> receiptPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Recharge(
    id: id ?? this.id,
    mainMeterId: mainMeterId ?? this.mainMeterId,
    rechargeDate: rechargeDate ?? this.rechargeDate,
    amount: amount ?? this.amount,
    energyCost: energyCost ?? this.energyCost,
    demandCharge: demandCharge ?? this.demandCharge,
    meterRent: meterRent ?? this.meterRent,
    vat: vat ?? this.vat,
    rebate: rebate ?? this.rebate,
    agentFee: agentFee ?? this.agentFee,
    otherExpenses: otherExpenses ?? this.otherExpenses,
    paidBy: paidBy.present ? paidBy.value : this.paidBy,
    tokenNumber: tokenNumber.present ? tokenNumber.value : this.tokenNumber,
    notes: notes.present ? notes.value : this.notes,
    receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Recharge copyWithCompanion(RechargesCompanion data) {
    return Recharge(
      id: data.id.present ? data.id.value : this.id,
      mainMeterId: data.mainMeterId.present
          ? data.mainMeterId.value
          : this.mainMeterId,
      rechargeDate: data.rechargeDate.present
          ? data.rechargeDate.value
          : this.rechargeDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      energyCost: data.energyCost.present
          ? data.energyCost.value
          : this.energyCost,
      demandCharge: data.demandCharge.present
          ? data.demandCharge.value
          : this.demandCharge,
      meterRent: data.meterRent.present ? data.meterRent.value : this.meterRent,
      vat: data.vat.present ? data.vat.value : this.vat,
      rebate: data.rebate.present ? data.rebate.value : this.rebate,
      agentFee: data.agentFee.present ? data.agentFee.value : this.agentFee,
      otherExpenses: data.otherExpenses.present
          ? data.otherExpenses.value
          : this.otherExpenses,
      paidBy: data.paidBy.present ? data.paidBy.value : this.paidBy,
      tokenNumber: data.tokenNumber.present
          ? data.tokenNumber.value
          : this.tokenNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      receiptPath: data.receiptPath.present
          ? data.receiptPath.value
          : this.receiptPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recharge(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('rechargeDate: $rechargeDate, ')
          ..write('amount: $amount, ')
          ..write('energyCost: $energyCost, ')
          ..write('demandCharge: $demandCharge, ')
          ..write('meterRent: $meterRent, ')
          ..write('vat: $vat, ')
          ..write('rebate: $rebate, ')
          ..write('agentFee: $agentFee, ')
          ..write('otherExpenses: $otherExpenses, ')
          ..write('paidBy: $paidBy, ')
          ..write('tokenNumber: $tokenNumber, ')
          ..write('notes: $notes, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainMeterId,
    rechargeDate,
    amount,
    energyCost,
    demandCharge,
    meterRent,
    vat,
    rebate,
    agentFee,
    otherExpenses,
    paidBy,
    tokenNumber,
    notes,
    receiptPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recharge &&
          other.id == this.id &&
          other.mainMeterId == this.mainMeterId &&
          other.rechargeDate == this.rechargeDate &&
          other.amount == this.amount &&
          other.energyCost == this.energyCost &&
          other.demandCharge == this.demandCharge &&
          other.meterRent == this.meterRent &&
          other.vat == this.vat &&
          other.rebate == this.rebate &&
          other.agentFee == this.agentFee &&
          other.otherExpenses == this.otherExpenses &&
          other.paidBy == this.paidBy &&
          other.tokenNumber == this.tokenNumber &&
          other.notes == this.notes &&
          other.receiptPath == this.receiptPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RechargesCompanion extends UpdateCompanion<Recharge> {
  final Value<int> id;
  final Value<int> mainMeterId;
  final Value<DateTime> rechargeDate;
  final Value<double> amount;
  final Value<double> energyCost;
  final Value<double> demandCharge;
  final Value<double> meterRent;
  final Value<double> vat;
  final Value<double> rebate;
  final Value<double> agentFee;
  final Value<double> otherExpenses;
  final Value<String?> paidBy;
  final Value<String?> tokenNumber;
  final Value<String?> notes;
  final Value<String?> receiptPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RechargesCompanion({
    this.id = const Value.absent(),
    this.mainMeterId = const Value.absent(),
    this.rechargeDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.energyCost = const Value.absent(),
    this.demandCharge = const Value.absent(),
    this.meterRent = const Value.absent(),
    this.vat = const Value.absent(),
    this.rebate = const Value.absent(),
    this.agentFee = const Value.absent(),
    this.otherExpenses = const Value.absent(),
    this.paidBy = const Value.absent(),
    this.tokenNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RechargesCompanion.insert({
    this.id = const Value.absent(),
    required int mainMeterId,
    required DateTime rechargeDate,
    required double amount,
    this.energyCost = const Value.absent(),
    this.demandCharge = const Value.absent(),
    this.meterRent = const Value.absent(),
    this.vat = const Value.absent(),
    this.rebate = const Value.absent(),
    this.agentFee = const Value.absent(),
    this.otherExpenses = const Value.absent(),
    this.paidBy = const Value.absent(),
    this.tokenNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : mainMeterId = Value(mainMeterId),
       rechargeDate = Value(rechargeDate),
       amount = Value(amount);
  static Insertable<Recharge> custom({
    Expression<int>? id,
    Expression<int>? mainMeterId,
    Expression<DateTime>? rechargeDate,
    Expression<double>? amount,
    Expression<double>? energyCost,
    Expression<double>? demandCharge,
    Expression<double>? meterRent,
    Expression<double>? vat,
    Expression<double>? rebate,
    Expression<double>? agentFee,
    Expression<double>? otherExpenses,
    Expression<String>? paidBy,
    Expression<String>? tokenNumber,
    Expression<String>? notes,
    Expression<String>? receiptPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainMeterId != null) 'main_meter_id': mainMeterId,
      if (rechargeDate != null) 'recharge_date': rechargeDate,
      if (amount != null) 'amount': amount,
      if (energyCost != null) 'energy_cost': energyCost,
      if (demandCharge != null) 'demand_charge': demandCharge,
      if (meterRent != null) 'meter_rent': meterRent,
      if (vat != null) 'vat': vat,
      if (rebate != null) 'rebate': rebate,
      if (agentFee != null) 'agent_fee': agentFee,
      if (otherExpenses != null) 'other_expenses': otherExpenses,
      if (paidBy != null) 'paid_by': paidBy,
      if (tokenNumber != null) 'token_number': tokenNumber,
      if (notes != null) 'notes': notes,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RechargesCompanion copyWith({
    Value<int>? id,
    Value<int>? mainMeterId,
    Value<DateTime>? rechargeDate,
    Value<double>? amount,
    Value<double>? energyCost,
    Value<double>? demandCharge,
    Value<double>? meterRent,
    Value<double>? vat,
    Value<double>? rebate,
    Value<double>? agentFee,
    Value<double>? otherExpenses,
    Value<String?>? paidBy,
    Value<String?>? tokenNumber,
    Value<String?>? notes,
    Value<String?>? receiptPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RechargesCompanion(
      id: id ?? this.id,
      mainMeterId: mainMeterId ?? this.mainMeterId,
      rechargeDate: rechargeDate ?? this.rechargeDate,
      amount: amount ?? this.amount,
      energyCost: energyCost ?? this.energyCost,
      demandCharge: demandCharge ?? this.demandCharge,
      meterRent: meterRent ?? this.meterRent,
      vat: vat ?? this.vat,
      rebate: rebate ?? this.rebate,
      agentFee: agentFee ?? this.agentFee,
      otherExpenses: otherExpenses ?? this.otherExpenses,
      paidBy: paidBy ?? this.paidBy,
      tokenNumber: tokenNumber ?? this.tokenNumber,
      notes: notes ?? this.notes,
      receiptPath: receiptPath ?? this.receiptPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainMeterId.present) {
      map['main_meter_id'] = Variable<int>(mainMeterId.value);
    }
    if (rechargeDate.present) {
      map['recharge_date'] = Variable<DateTime>(rechargeDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (energyCost.present) {
      map['energy_cost'] = Variable<double>(energyCost.value);
    }
    if (demandCharge.present) {
      map['demand_charge'] = Variable<double>(demandCharge.value);
    }
    if (meterRent.present) {
      map['meter_rent'] = Variable<double>(meterRent.value);
    }
    if (vat.present) {
      map['vat'] = Variable<double>(vat.value);
    }
    if (rebate.present) {
      map['rebate'] = Variable<double>(rebate.value);
    }
    if (agentFee.present) {
      map['agent_fee'] = Variable<double>(agentFee.value);
    }
    if (otherExpenses.present) {
      map['other_expenses'] = Variable<double>(otherExpenses.value);
    }
    if (paidBy.present) {
      map['paid_by'] = Variable<String>(paidBy.value);
    }
    if (tokenNumber.present) {
      map['token_number'] = Variable<String>(tokenNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RechargesCompanion(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('rechargeDate: $rechargeDate, ')
          ..write('amount: $amount, ')
          ..write('energyCost: $energyCost, ')
          ..write('demandCharge: $demandCharge, ')
          ..write('meterRent: $meterRent, ')
          ..write('vat: $vat, ')
          ..write('rebate: $rebate, ')
          ..write('agentFee: $agentFee, ')
          ..write('otherExpenses: $otherExpenses, ')
          ..write('paidBy: $paidBy, ')
          ..write('tokenNumber: $tokenNumber, ')
          ..write('notes: $notes, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _multiTenantMeta = const VerificationMeta(
    'multiTenant',
  );
  @override
  late final GeneratedColumn<bool> multiTenant = GeneratedColumn<bool>(
    'multi_tenant',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("multi_tenant" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _fixedRateMeta = const VerificationMeta(
    'fixedRate',
  );
  @override
  late final GeneratedColumn<bool> fixedRate = GeneratedColumn<bool>(
    'fixed_rate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("fixed_rate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fixedUnitPriceMeta = const VerificationMeta(
    'fixedUnitPrice',
  );
  @override
  late final GeneratedColumn<double> fixedUnitPrice = GeneratedColumn<double>(
    'fixed_unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _fixedChargeDistributionMeta =
      const VerificationMeta('fixedChargeDistribution');
  @override
  late final GeneratedColumn<String> fixedChargeDistribution =
      GeneratedColumn<String>(
        'fixed_charge_distribution',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('equal'),
      );
  static const VerificationMeta _billingCalcModeMeta = const VerificationMeta(
    'billingCalcMode',
  );
  @override
  late final GeneratedColumn<String> billingCalcMode = GeneratedColumn<String>(
    'billing_calc_mode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sharedSlab'),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _invoiceLanguageMeta = const VerificationMeta(
    'invoiceLanguage',
  );
  @override
  late final GeneratedColumn<String> invoiceLanguage = GeneratedColumn<String>(
    'invoice_language',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('auto'),
  );
  static const VerificationMeta _appRoleMeta = const VerificationMeta(
    'appRole',
  );
  @override
  late final GeneratedColumn<String> appRole = GeneratedColumn<String>(
    'app_role',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('landlord'),
  );
  static const VerificationMeta _meterCodeMeta = const VerificationMeta(
    'meterCode',
  );
  @override
  late final GeneratedColumn<String> meterCode = GeneratedColumn<String>(
    'meter_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _joinedMeterCodeMeta = const VerificationMeta(
    'joinedMeterCode',
  );
  @override
  late final GeneratedColumn<String> joinedMeterCode = GeneratedColumn<String>(
    'joined_meter_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tenantNameMeta = const VerificationMeta(
    'tenantName',
  );
  @override
  late final GeneratedColumn<String> tenantName = GeneratedColumn<String>(
    'tenant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tenantApprovedMeta = const VerificationMeta(
    'tenantApproved',
  );
  @override
  late final GeneratedColumn<bool> tenantApproved = GeneratedColumn<bool>(
    'tenant_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tenant_approved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onboardedMeta = const VerificationMeta(
    'onboarded',
  );
  @override
  late final GeneratedColumn<bool> onboarded = GeneratedColumn<bool>(
    'onboarded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    multiTenant,
    fixedRate,
    fixedUnitPrice,
    fixedChargeDistribution,
    billingCalcMode,
    languageCode,
    themeMode,
    invoiceLanguage,
    appRole,
    meterCode,
    joinedMeterCode,
    tenantName,
    tenantApproved,
    onboarded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('multi_tenant')) {
      context.handle(
        _multiTenantMeta,
        multiTenant.isAcceptableOrUnknown(
          data['multi_tenant']!,
          _multiTenantMeta,
        ),
      );
    }
    if (data.containsKey('fixed_rate')) {
      context.handle(
        _fixedRateMeta,
        fixedRate.isAcceptableOrUnknown(data['fixed_rate']!, _fixedRateMeta),
      );
    }
    if (data.containsKey('fixed_unit_price')) {
      context.handle(
        _fixedUnitPriceMeta,
        fixedUnitPrice.isAcceptableOrUnknown(
          data['fixed_unit_price']!,
          _fixedUnitPriceMeta,
        ),
      );
    }
    if (data.containsKey('fixed_charge_distribution')) {
      context.handle(
        _fixedChargeDistributionMeta,
        fixedChargeDistribution.isAcceptableOrUnknown(
          data['fixed_charge_distribution']!,
          _fixedChargeDistributionMeta,
        ),
      );
    }
    if (data.containsKey('billing_calc_mode')) {
      context.handle(
        _billingCalcModeMeta,
        billingCalcMode.isAcceptableOrUnknown(
          data['billing_calc_mode']!,
          _billingCalcModeMeta,
        ),
      );
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('invoice_language')) {
      context.handle(
        _invoiceLanguageMeta,
        invoiceLanguage.isAcceptableOrUnknown(
          data['invoice_language']!,
          _invoiceLanguageMeta,
        ),
      );
    }
    if (data.containsKey('app_role')) {
      context.handle(
        _appRoleMeta,
        appRole.isAcceptableOrUnknown(data['app_role']!, _appRoleMeta),
      );
    }
    if (data.containsKey('meter_code')) {
      context.handle(
        _meterCodeMeta,
        meterCode.isAcceptableOrUnknown(data['meter_code']!, _meterCodeMeta),
      );
    }
    if (data.containsKey('joined_meter_code')) {
      context.handle(
        _joinedMeterCodeMeta,
        joinedMeterCode.isAcceptableOrUnknown(
          data['joined_meter_code']!,
          _joinedMeterCodeMeta,
        ),
      );
    }
    if (data.containsKey('tenant_name')) {
      context.handle(
        _tenantNameMeta,
        tenantName.isAcceptableOrUnknown(data['tenant_name']!, _tenantNameMeta),
      );
    }
    if (data.containsKey('tenant_approved')) {
      context.handle(
        _tenantApprovedMeta,
        tenantApproved.isAcceptableOrUnknown(
          data['tenant_approved']!,
          _tenantApprovedMeta,
        ),
      );
    }
    if (data.containsKey('onboarded')) {
      context.handle(
        _onboardedMeta,
        onboarded.isAcceptableOrUnknown(data['onboarded']!, _onboardedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      multiTenant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}multi_tenant'],
      )!,
      fixedRate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}fixed_rate'],
      )!,
      fixedUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fixed_unit_price'],
      )!,
      fixedChargeDistribution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fixed_charge_distribution'],
      )!,
      billingCalcMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_calc_mode'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      invoiceLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_language'],
      )!,
      appRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_role'],
      )!,
      meterCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_code'],
      ),
      joinedMeterCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}joined_meter_code'],
      ),
      tenantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_name'],
      ),
      tenantApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tenant_approved'],
      )!,
      onboarded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarded'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  /// Always 1 — there is exactly one settings row.
  final int id;

  /// Multi-tenant building (true) vs single personal meter (false).
  final bool multiTenant;

  /// Billing method: usage-based slab tariff (false) vs flat per-unit rate
  /// (true). See [fixedUnitPrice].
  final bool fixedRate;

  /// Flat price per unit used when [fixedRate] is true.
  ///
  /// v2: superseded by per-tenant billing modes (Tenants.billingMode /
  /// Tenants.fixedRate); kept for migration.
  final double fixedUnitPrice;

  /// How fixed charges (demand, rent, fees) are split among shared tenants:
  /// 'equal' (default) or 'usage'.
  final String fixedChargeDistribution;

  /// Property-level billing calculation mode: 'sharedSlab' (default,
  /// landlord mode) | 'reconciled' | 'fixedRate'. Snapshotted on finalize.
  final String billingCalcMode;

  /// UI / invoice language code ('en' or 'bn').
  final String languageCode;

  /// Selected theme mode: 'system' | 'light' | 'dark'.
  ///
  /// Persisted so a choice made in Settings survives a restart (v9).
  final String themeMode;

  /// Invoice rendering language: 'auto' (follow app language) | 'en' | 'bn'.
  /// Lets a device with a broken HTML→PDF converter stay on the reliable
  /// English vector renderer without changing the app language (v10).
  final String invoiceLanguage;

  /// Who is using this install: 'landlord' (manages the meter) or 'tenant'
  /// (joined a meter with a code). Tenant mode is a scoped view of shared data.
  final String appRole;

  /// Short code generated by the landlord and shared via QR with tenants.
  final String? meterCode;

  /// The code a tenant joined with (null until joined).
  final String? joinedMeterCode;

  /// Which roster entry this tenant chose as their identity.
  final String? tenantName;

  /// Landlord's approval of a join request (v11).
  final bool tenantApproved;

  /// Marks that the first-run setup wizard has been completed.
  final bool onboarded;
  const AppSetting({
    required this.id,
    required this.multiTenant,
    required this.fixedRate,
    required this.fixedUnitPrice,
    required this.fixedChargeDistribution,
    required this.billingCalcMode,
    required this.languageCode,
    required this.themeMode,
    required this.invoiceLanguage,
    required this.appRole,
    this.meterCode,
    this.joinedMeterCode,
    this.tenantName,
    required this.tenantApproved,
    required this.onboarded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['multi_tenant'] = Variable<bool>(multiTenant);
    map['fixed_rate'] = Variable<bool>(fixedRate);
    map['fixed_unit_price'] = Variable<double>(fixedUnitPrice);
    map['fixed_charge_distribution'] = Variable<String>(
      fixedChargeDistribution,
    );
    map['billing_calc_mode'] = Variable<String>(billingCalcMode);
    map['language_code'] = Variable<String>(languageCode);
    map['theme_mode'] = Variable<String>(themeMode);
    map['invoice_language'] = Variable<String>(invoiceLanguage);
    map['app_role'] = Variable<String>(appRole);
    if (!nullToAbsent || meterCode != null) {
      map['meter_code'] = Variable<String>(meterCode);
    }
    if (!nullToAbsent || joinedMeterCode != null) {
      map['joined_meter_code'] = Variable<String>(joinedMeterCode);
    }
    if (!nullToAbsent || tenantName != null) {
      map['tenant_name'] = Variable<String>(tenantName);
    }
    map['tenant_approved'] = Variable<bool>(tenantApproved);
    map['onboarded'] = Variable<bool>(onboarded);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      multiTenant: Value(multiTenant),
      fixedRate: Value(fixedRate),
      fixedUnitPrice: Value(fixedUnitPrice),
      fixedChargeDistribution: Value(fixedChargeDistribution),
      billingCalcMode: Value(billingCalcMode),
      languageCode: Value(languageCode),
      themeMode: Value(themeMode),
      invoiceLanguage: Value(invoiceLanguage),
      appRole: Value(appRole),
      meterCode: meterCode == null && nullToAbsent
          ? const Value.absent()
          : Value(meterCode),
      joinedMeterCode: joinedMeterCode == null && nullToAbsent
          ? const Value.absent()
          : Value(joinedMeterCode),
      tenantName: tenantName == null && nullToAbsent
          ? const Value.absent()
          : Value(tenantName),
      tenantApproved: Value(tenantApproved),
      onboarded: Value(onboarded),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      multiTenant: serializer.fromJson<bool>(json['multiTenant']),
      fixedRate: serializer.fromJson<bool>(json['fixedRate']),
      fixedUnitPrice: serializer.fromJson<double>(json['fixedUnitPrice']),
      fixedChargeDistribution: serializer.fromJson<String>(
        json['fixedChargeDistribution'],
      ),
      billingCalcMode: serializer.fromJson<String>(json['billingCalcMode']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      invoiceLanguage: serializer.fromJson<String>(json['invoiceLanguage']),
      appRole: serializer.fromJson<String>(json['appRole']),
      meterCode: serializer.fromJson<String?>(json['meterCode']),
      joinedMeterCode: serializer.fromJson<String?>(json['joinedMeterCode']),
      tenantName: serializer.fromJson<String?>(json['tenantName']),
      tenantApproved: serializer.fromJson<bool>(json['tenantApproved']),
      onboarded: serializer.fromJson<bool>(json['onboarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'multiTenant': serializer.toJson<bool>(multiTenant),
      'fixedRate': serializer.toJson<bool>(fixedRate),
      'fixedUnitPrice': serializer.toJson<double>(fixedUnitPrice),
      'fixedChargeDistribution': serializer.toJson<String>(
        fixedChargeDistribution,
      ),
      'billingCalcMode': serializer.toJson<String>(billingCalcMode),
      'languageCode': serializer.toJson<String>(languageCode),
      'themeMode': serializer.toJson<String>(themeMode),
      'invoiceLanguage': serializer.toJson<String>(invoiceLanguage),
      'appRole': serializer.toJson<String>(appRole),
      'meterCode': serializer.toJson<String?>(meterCode),
      'joinedMeterCode': serializer.toJson<String?>(joinedMeterCode),
      'tenantName': serializer.toJson<String?>(tenantName),
      'tenantApproved': serializer.toJson<bool>(tenantApproved),
      'onboarded': serializer.toJson<bool>(onboarded),
    };
  }

  AppSetting copyWith({
    int? id,
    bool? multiTenant,
    bool? fixedRate,
    double? fixedUnitPrice,
    String? fixedChargeDistribution,
    String? billingCalcMode,
    String? languageCode,
    String? themeMode,
    String? invoiceLanguage,
    String? appRole,
    Value<String?> meterCode = const Value.absent(),
    Value<String?> joinedMeterCode = const Value.absent(),
    Value<String?> tenantName = const Value.absent(),
    bool? tenantApproved,
    bool? onboarded,
  }) => AppSetting(
    id: id ?? this.id,
    multiTenant: multiTenant ?? this.multiTenant,
    fixedRate: fixedRate ?? this.fixedRate,
    fixedUnitPrice: fixedUnitPrice ?? this.fixedUnitPrice,
    fixedChargeDistribution:
        fixedChargeDistribution ?? this.fixedChargeDistribution,
    billingCalcMode: billingCalcMode ?? this.billingCalcMode,
    languageCode: languageCode ?? this.languageCode,
    themeMode: themeMode ?? this.themeMode,
    invoiceLanguage: invoiceLanguage ?? this.invoiceLanguage,
    appRole: appRole ?? this.appRole,
    meterCode: meterCode.present ? meterCode.value : this.meterCode,
    joinedMeterCode: joinedMeterCode.present
        ? joinedMeterCode.value
        : this.joinedMeterCode,
    tenantName: tenantName.present ? tenantName.value : this.tenantName,
    tenantApproved: tenantApproved ?? this.tenantApproved,
    onboarded: onboarded ?? this.onboarded,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      multiTenant: data.multiTenant.present
          ? data.multiTenant.value
          : this.multiTenant,
      fixedRate: data.fixedRate.present ? data.fixedRate.value : this.fixedRate,
      fixedUnitPrice: data.fixedUnitPrice.present
          ? data.fixedUnitPrice.value
          : this.fixedUnitPrice,
      fixedChargeDistribution: data.fixedChargeDistribution.present
          ? data.fixedChargeDistribution.value
          : this.fixedChargeDistribution,
      billingCalcMode: data.billingCalcMode.present
          ? data.billingCalcMode.value
          : this.billingCalcMode,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      invoiceLanguage: data.invoiceLanguage.present
          ? data.invoiceLanguage.value
          : this.invoiceLanguage,
      appRole: data.appRole.present ? data.appRole.value : this.appRole,
      meterCode: data.meterCode.present ? data.meterCode.value : this.meterCode,
      joinedMeterCode: data.joinedMeterCode.present
          ? data.joinedMeterCode.value
          : this.joinedMeterCode,
      tenantName: data.tenantName.present
          ? data.tenantName.value
          : this.tenantName,
      tenantApproved: data.tenantApproved.present
          ? data.tenantApproved.value
          : this.tenantApproved,
      onboarded: data.onboarded.present ? data.onboarded.value : this.onboarded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('multiTenant: $multiTenant, ')
          ..write('fixedRate: $fixedRate, ')
          ..write('fixedUnitPrice: $fixedUnitPrice, ')
          ..write('fixedChargeDistribution: $fixedChargeDistribution, ')
          ..write('billingCalcMode: $billingCalcMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('invoiceLanguage: $invoiceLanguage, ')
          ..write('appRole: $appRole, ')
          ..write('meterCode: $meterCode, ')
          ..write('joinedMeterCode: $joinedMeterCode, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantApproved: $tenantApproved, ')
          ..write('onboarded: $onboarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    multiTenant,
    fixedRate,
    fixedUnitPrice,
    fixedChargeDistribution,
    billingCalcMode,
    languageCode,
    themeMode,
    invoiceLanguage,
    appRole,
    meterCode,
    joinedMeterCode,
    tenantName,
    tenantApproved,
    onboarded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.multiTenant == this.multiTenant &&
          other.fixedRate == this.fixedRate &&
          other.fixedUnitPrice == this.fixedUnitPrice &&
          other.fixedChargeDistribution == this.fixedChargeDistribution &&
          other.billingCalcMode == this.billingCalcMode &&
          other.languageCode == this.languageCode &&
          other.themeMode == this.themeMode &&
          other.invoiceLanguage == this.invoiceLanguage &&
          other.appRole == this.appRole &&
          other.meterCode == this.meterCode &&
          other.joinedMeterCode == this.joinedMeterCode &&
          other.tenantName == this.tenantName &&
          other.tenantApproved == this.tenantApproved &&
          other.onboarded == this.onboarded);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> multiTenant;
  final Value<bool> fixedRate;
  final Value<double> fixedUnitPrice;
  final Value<String> fixedChargeDistribution;
  final Value<String> billingCalcMode;
  final Value<String> languageCode;
  final Value<String> themeMode;
  final Value<String> invoiceLanguage;
  final Value<String> appRole;
  final Value<String?> meterCode;
  final Value<String?> joinedMeterCode;
  final Value<String?> tenantName;
  final Value<bool> tenantApproved;
  final Value<bool> onboarded;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.multiTenant = const Value.absent(),
    this.fixedRate = const Value.absent(),
    this.fixedUnitPrice = const Value.absent(),
    this.fixedChargeDistribution = const Value.absent(),
    this.billingCalcMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.invoiceLanguage = const Value.absent(),
    this.appRole = const Value.absent(),
    this.meterCode = const Value.absent(),
    this.joinedMeterCode = const Value.absent(),
    this.tenantName = const Value.absent(),
    this.tenantApproved = const Value.absent(),
    this.onboarded = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.multiTenant = const Value.absent(),
    this.fixedRate = const Value.absent(),
    this.fixedUnitPrice = const Value.absent(),
    this.fixedChargeDistribution = const Value.absent(),
    this.billingCalcMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.invoiceLanguage = const Value.absent(),
    this.appRole = const Value.absent(),
    this.meterCode = const Value.absent(),
    this.joinedMeterCode = const Value.absent(),
    this.tenantName = const Value.absent(),
    this.tenantApproved = const Value.absent(),
    this.onboarded = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? multiTenant,
    Expression<bool>? fixedRate,
    Expression<double>? fixedUnitPrice,
    Expression<String>? fixedChargeDistribution,
    Expression<String>? billingCalcMode,
    Expression<String>? languageCode,
    Expression<String>? themeMode,
    Expression<String>? invoiceLanguage,
    Expression<String>? appRole,
    Expression<String>? meterCode,
    Expression<String>? joinedMeterCode,
    Expression<String>? tenantName,
    Expression<bool>? tenantApproved,
    Expression<bool>? onboarded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (multiTenant != null) 'multi_tenant': multiTenant,
      if (fixedRate != null) 'fixed_rate': fixedRate,
      if (fixedUnitPrice != null) 'fixed_unit_price': fixedUnitPrice,
      if (fixedChargeDistribution != null)
        'fixed_charge_distribution': fixedChargeDistribution,
      if (billingCalcMode != null) 'billing_calc_mode': billingCalcMode,
      if (languageCode != null) 'language_code': languageCode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (invoiceLanguage != null) 'invoice_language': invoiceLanguage,
      if (appRole != null) 'app_role': appRole,
      if (meterCode != null) 'meter_code': meterCode,
      if (joinedMeterCode != null) 'joined_meter_code': joinedMeterCode,
      if (tenantName != null) 'tenant_name': tenantName,
      if (tenantApproved != null) 'tenant_approved': tenantApproved,
      if (onboarded != null) 'onboarded': onboarded,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? multiTenant,
    Value<bool>? fixedRate,
    Value<double>? fixedUnitPrice,
    Value<String>? fixedChargeDistribution,
    Value<String>? billingCalcMode,
    Value<String>? languageCode,
    Value<String>? themeMode,
    Value<String>? invoiceLanguage,
    Value<String>? appRole,
    Value<String?>? meterCode,
    Value<String?>? joinedMeterCode,
    Value<String?>? tenantName,
    Value<bool>? tenantApproved,
    Value<bool>? onboarded,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      multiTenant: multiTenant ?? this.multiTenant,
      fixedRate: fixedRate ?? this.fixedRate,
      fixedUnitPrice: fixedUnitPrice ?? this.fixedUnitPrice,
      fixedChargeDistribution:
          fixedChargeDistribution ?? this.fixedChargeDistribution,
      billingCalcMode: billingCalcMode ?? this.billingCalcMode,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      invoiceLanguage: invoiceLanguage ?? this.invoiceLanguage,
      appRole: appRole ?? this.appRole,
      meterCode: meterCode ?? this.meterCode,
      joinedMeterCode: joinedMeterCode ?? this.joinedMeterCode,
      tenantName: tenantName ?? this.tenantName,
      tenantApproved: tenantApproved ?? this.tenantApproved,
      onboarded: onboarded ?? this.onboarded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (multiTenant.present) {
      map['multi_tenant'] = Variable<bool>(multiTenant.value);
    }
    if (fixedRate.present) {
      map['fixed_rate'] = Variable<bool>(fixedRate.value);
    }
    if (fixedUnitPrice.present) {
      map['fixed_unit_price'] = Variable<double>(fixedUnitPrice.value);
    }
    if (fixedChargeDistribution.present) {
      map['fixed_charge_distribution'] = Variable<String>(
        fixedChargeDistribution.value,
      );
    }
    if (billingCalcMode.present) {
      map['billing_calc_mode'] = Variable<String>(billingCalcMode.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (invoiceLanguage.present) {
      map['invoice_language'] = Variable<String>(invoiceLanguage.value);
    }
    if (appRole.present) {
      map['app_role'] = Variable<String>(appRole.value);
    }
    if (meterCode.present) {
      map['meter_code'] = Variable<String>(meterCode.value);
    }
    if (joinedMeterCode.present) {
      map['joined_meter_code'] = Variable<String>(joinedMeterCode.value);
    }
    if (tenantName.present) {
      map['tenant_name'] = Variable<String>(tenantName.value);
    }
    if (tenantApproved.present) {
      map['tenant_approved'] = Variable<bool>(tenantApproved.value);
    }
    if (onboarded.present) {
      map['onboarded'] = Variable<bool>(onboarded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('multiTenant: $multiTenant, ')
          ..write('fixedRate: $fixedRate, ')
          ..write('fixedUnitPrice: $fixedUnitPrice, ')
          ..write('fixedChargeDistribution: $fixedChargeDistribution, ')
          ..write('billingCalcMode: $billingCalcMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('invoiceLanguage: $invoiceLanguage, ')
          ..write('appRole: $appRole, ')
          ..write('meterCode: $meterCode, ')
          ..write('joinedMeterCode: $joinedMeterCode, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantApproved: $tenantApproved, ')
          ..write('onboarded: $onboarded')
          ..write(')'))
        .toString();
  }
}

class $BillPaymentsTable extends BillPayments
    with TableInfo<$BillPaymentsTable, BillPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillPaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 7,
      maxTextLength: 7,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tenantId, monthKey, paidAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
    );
  }

  @override
  $BillPaymentsTable createAlias(String alias) {
    return $BillPaymentsTable(attachedDatabase, alias);
  }
}

class BillPayment extends DataClass implements Insertable<BillPayment> {
  final int id;
  final int tenantId;

  /// 'yyyy-MM' key of the billed month.
  final String monthKey;
  final DateTime paidAt;
  const BillPayment({
    required this.id,
    required this.tenantId,
    required this.monthKey,
    required this.paidAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['month_key'] = Variable<String>(monthKey);
    map['paid_at'] = Variable<DateTime>(paidAt);
    return map;
  }

  BillPaymentsCompanion toCompanion(bool nullToAbsent) {
    return BillPaymentsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      monthKey: Value(monthKey),
      paidAt: Value(paidAt),
    );
  }

  factory BillPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillPayment(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'monthKey': serializer.toJson<String>(monthKey),
      'paidAt': serializer.toJson<DateTime>(paidAt),
    };
  }

  BillPayment copyWith({
    int? id,
    int? tenantId,
    String? monthKey,
    DateTime? paidAt,
  }) => BillPayment(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    monthKey: monthKey ?? this.monthKey,
    paidAt: paidAt ?? this.paidAt,
  );
  BillPayment copyWithCompanion(BillPaymentsCompanion data) {
    return BillPayment(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillPayment(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('monthKey: $monthKey, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, monthKey, paidAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillPayment &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.monthKey == this.monthKey &&
          other.paidAt == this.paidAt);
}

class BillPaymentsCompanion extends UpdateCompanion<BillPayment> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> monthKey;
  final Value<DateTime> paidAt;
  const BillPaymentsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  BillPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int tenantId,
    required String monthKey,
    this.paidAt = const Value.absent(),
  }) : tenantId = Value(tenantId),
       monthKey = Value(monthKey);
  static Insertable<BillPayment> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? monthKey,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (monthKey != null) 'month_key': monthKey,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  BillPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? monthKey,
    Value<DateTime>? paidAt,
  }) {
    return BillPaymentsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      monthKey: monthKey ?? this.monthKey,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('monthKey: $monthKey, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

class $TariffVersionsTable extends TariffVersions
    with TableInfo<$TariffVersionsTable, TariffVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TariffVersionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _tariffJsonMeta = const VerificationMeta(
    'tariffJson',
  );
  @override
  late final GeneratedColumn<String> tariffJson = GeneratedColumn<String>(
    'tariff_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    label,
    effectiveFrom,
    tariffJson,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tariff_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TariffVersion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('tariff_json')) {
      context.handle(
        _tariffJsonMeta,
        tariffJson.isAcceptableOrUnknown(data['tariff_json']!, _tariffJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_tariffJsonMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
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
  TariffVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TariffVersion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
      tariffJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tariff_json'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TariffVersionsTable createAlias(String alias) {
    return $TariffVersionsTable(attachedDatabase, alias);
  }
}

class TariffVersion extends DataClass implements Insertable<TariffVersion> {
  final int id;

  /// Human label, e.g. "Version 1".
  final String label;

  /// The date from which this version applies.
  final DateTime effectiveFrom;

  /// Serialized [Tariff] (slabs, demand charge, meter rent, VAT, rebate).
  final String tariffJson;

  /// Archived versions are hidden from tariff resolution but kept for history.
  final bool archived;
  final DateTime createdAt;
  const TariffVersion({
    required this.id,
    required this.label,
    required this.effectiveFrom,
    required this.tariffJson,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    map['tariff_json'] = Variable<String>(tariffJson);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TariffVersionsCompanion toCompanion(bool nullToAbsent) {
    return TariffVersionsCompanion(
      id: Value(id),
      label: Value(label),
      effectiveFrom: Value(effectiveFrom),
      tariffJson: Value(tariffJson),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory TariffVersion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TariffVersion(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      tariffJson: serializer.fromJson<String>(json['tariffJson']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'tariffJson': serializer.toJson<String>(tariffJson),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TariffVersion copyWith({
    int? id,
    String? label,
    DateTime? effectiveFrom,
    String? tariffJson,
    bool? archived,
    DateTime? createdAt,
  }) => TariffVersion(
    id: id ?? this.id,
    label: label ?? this.label,
    effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    tariffJson: tariffJson ?? this.tariffJson,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  TariffVersion copyWithCompanion(TariffVersionsCompanion data) {
    return TariffVersion(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      tariffJson: data.tariffJson.present
          ? data.tariffJson.value
          : this.tariffJson,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TariffVersion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('tariffJson: $tariffJson, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, label, effectiveFrom, tariffJson, archived, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TariffVersion &&
          other.id == this.id &&
          other.label == this.label &&
          other.effectiveFrom == this.effectiveFrom &&
          other.tariffJson == this.tariffJson &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class TariffVersionsCompanion extends UpdateCompanion<TariffVersion> {
  final Value<int> id;
  final Value<String> label;
  final Value<DateTime> effectiveFrom;
  final Value<String> tariffJson;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  const TariffVersionsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.tariffJson = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TariffVersionsCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required DateTime effectiveFrom,
    required String tariffJson,
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : label = Value(label),
       effectiveFrom = Value(effectiveFrom),
       tariffJson = Value(tariffJson);
  static Insertable<TariffVersion> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<DateTime>? effectiveFrom,
    Expression<String>? tariffJson,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (tariffJson != null) 'tariff_json': tariffJson,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TariffVersionsCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<DateTime>? effectiveFrom,
    Value<String>? tariffJson,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
  }) {
    return TariffVersionsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      tariffJson: tariffJson ?? this.tariffJson,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (tariffJson.present) {
      map['tariff_json'] = Variable<String>(tariffJson.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TariffVersionsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('tariffJson: $tariffJson, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BillingPeriodsTable extends BillingPeriods
    with TableInfo<$BillingPeriodsTable, BillingPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingPeriodsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<int> propertyId = GeneratedColumn<int>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _finalizedAtMeta = const VerificationMeta(
    'finalizedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finalizedAt = GeneratedColumn<DateTime>(
    'finalized_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalizedByMeta = const VerificationMeta(
    'finalizedBy',
  );
  @override
  late final GeneratedColumn<String> finalizedBy = GeneratedColumn<String>(
    'finalized_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tariffVersionIdMeta = const VerificationMeta(
    'tariffVersionId',
  );
  @override
  late final GeneratedColumn<int> tariffVersionId = GeneratedColumn<int>(
    'tariff_version_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingMethodSnapshotMeta =
      const VerificationMeta('billingMethodSnapshot');
  @override
  late final GeneratedColumn<String> billingMethodSnapshot =
      GeneratedColumn<String>(
        'billing_method_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currencySnapshotMeta = const VerificationMeta(
    'currencySnapshot',
  );
  @override
  late final GeneratedColumn<String> currencySnapshot = GeneratedColumn<String>(
    'currency_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calculationSnapshotMeta =
      const VerificationMeta('calculationSnapshot');
  @override
  late final GeneratedColumn<String> calculationSnapshot =
      GeneratedColumn<String>(
        'calculation_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    year,
    month,
    status,
    finalizedAt,
    finalizedBy,
    tariffVersionId,
    billingMethodSnapshot,
    currencySnapshot,
    calculationSnapshot,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('finalized_at')) {
      context.handle(
        _finalizedAtMeta,
        finalizedAt.isAcceptableOrUnknown(
          data['finalized_at']!,
          _finalizedAtMeta,
        ),
      );
    }
    if (data.containsKey('finalized_by')) {
      context.handle(
        _finalizedByMeta,
        finalizedBy.isAcceptableOrUnknown(
          data['finalized_by']!,
          _finalizedByMeta,
        ),
      );
    }
    if (data.containsKey('tariff_version_id')) {
      context.handle(
        _tariffVersionIdMeta,
        tariffVersionId.isAcceptableOrUnknown(
          data['tariff_version_id']!,
          _tariffVersionIdMeta,
        ),
      );
    }
    if (data.containsKey('billing_method_snapshot')) {
      context.handle(
        _billingMethodSnapshotMeta,
        billingMethodSnapshot.isAcceptableOrUnknown(
          data['billing_method_snapshot']!,
          _billingMethodSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('currency_snapshot')) {
      context.handle(
        _currencySnapshotMeta,
        currencySnapshot.isAcceptableOrUnknown(
          data['currency_snapshot']!,
          _currencySnapshotMeta,
        ),
      );
    }
    if (data.containsKey('calculation_snapshot')) {
      context.handle(
        _calculationSnapshotMeta,
        calculationSnapshot.isAcceptableOrUnknown(
          data['calculation_snapshot']!,
          _calculationSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {propertyId, year, month},
  ];
  @override
  BillingPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}property_id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      finalizedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finalized_at'],
      ),
      finalizedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}finalized_by'],
      ),
      tariffVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tariff_version_id'],
      ),
      billingMethodSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_method_snapshot'],
      ),
      currencySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_snapshot'],
      ),
      calculationSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculation_snapshot'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BillingPeriodsTable createAlias(String alias) {
    return $BillingPeriodsTable(attachedDatabase, alias);
  }
}

class BillingPeriod extends DataClass implements Insertable<BillingPeriod> {
  final int id;
  final int propertyId;
  final int year;

  /// 1–12.
  final int month;

  /// 'draft' or 'finalized'.
  final String status;
  final DateTime? finalizedAt;
  final String? finalizedBy;

  /// The tariff version used at finalization.
  final int? tariffVersionId;

  /// 'usageBased' or 'fixedRate' at finalization.
  final String? billingMethodSnapshot;
  final String? currencySnapshot;

  /// Serialized [MonthlyBill] computed at finalization (the immutable bill).
  final String? calculationSnapshot;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillingPeriod({
    required this.id,
    required this.propertyId,
    required this.year,
    required this.month,
    required this.status,
    this.finalizedAt,
    this.finalizedBy,
    this.tariffVersionId,
    this.billingMethodSnapshot,
    this.currencySnapshot,
    this.calculationSnapshot,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['property_id'] = Variable<int>(propertyId);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || finalizedAt != null) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt);
    }
    if (!nullToAbsent || finalizedBy != null) {
      map['finalized_by'] = Variable<String>(finalizedBy);
    }
    if (!nullToAbsent || tariffVersionId != null) {
      map['tariff_version_id'] = Variable<int>(tariffVersionId);
    }
    if (!nullToAbsent || billingMethodSnapshot != null) {
      map['billing_method_snapshot'] = Variable<String>(billingMethodSnapshot);
    }
    if (!nullToAbsent || currencySnapshot != null) {
      map['currency_snapshot'] = Variable<String>(currencySnapshot);
    }
    if (!nullToAbsent || calculationSnapshot != null) {
      map['calculation_snapshot'] = Variable<String>(calculationSnapshot);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillingPeriodsCompanion toCompanion(bool nullToAbsent) {
    return BillingPeriodsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      year: Value(year),
      month: Value(month),
      status: Value(status),
      finalizedAt: finalizedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedAt),
      finalizedBy: finalizedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedBy),
      tariffVersionId: tariffVersionId == null && nullToAbsent
          ? const Value.absent()
          : Value(tariffVersionId),
      billingMethodSnapshot: billingMethodSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(billingMethodSnapshot),
      currencySnapshot: currencySnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(currencySnapshot),
      calculationSnapshot: calculationSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(calculationSnapshot),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillingPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingPeriod(
      id: serializer.fromJson<int>(json['id']),
      propertyId: serializer.fromJson<int>(json['propertyId']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      status: serializer.fromJson<String>(json['status']),
      finalizedAt: serializer.fromJson<DateTime?>(json['finalizedAt']),
      finalizedBy: serializer.fromJson<String?>(json['finalizedBy']),
      tariffVersionId: serializer.fromJson<int?>(json['tariffVersionId']),
      billingMethodSnapshot: serializer.fromJson<String?>(
        json['billingMethodSnapshot'],
      ),
      currencySnapshot: serializer.fromJson<String?>(json['currencySnapshot']),
      calculationSnapshot: serializer.fromJson<String?>(
        json['calculationSnapshot'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'propertyId': serializer.toJson<int>(propertyId),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'status': serializer.toJson<String>(status),
      'finalizedAt': serializer.toJson<DateTime?>(finalizedAt),
      'finalizedBy': serializer.toJson<String?>(finalizedBy),
      'tariffVersionId': serializer.toJson<int?>(tariffVersionId),
      'billingMethodSnapshot': serializer.toJson<String?>(
        billingMethodSnapshot,
      ),
      'currencySnapshot': serializer.toJson<String?>(currencySnapshot),
      'calculationSnapshot': serializer.toJson<String?>(calculationSnapshot),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillingPeriod copyWith({
    int? id,
    int? propertyId,
    int? year,
    int? month,
    String? status,
    Value<DateTime?> finalizedAt = const Value.absent(),
    Value<String?> finalizedBy = const Value.absent(),
    Value<int?> tariffVersionId = const Value.absent(),
    Value<String?> billingMethodSnapshot = const Value.absent(),
    Value<String?> currencySnapshot = const Value.absent(),
    Value<String?> calculationSnapshot = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillingPeriod(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    year: year ?? this.year,
    month: month ?? this.month,
    status: status ?? this.status,
    finalizedAt: finalizedAt.present ? finalizedAt.value : this.finalizedAt,
    finalizedBy: finalizedBy.present ? finalizedBy.value : this.finalizedBy,
    tariffVersionId: tariffVersionId.present
        ? tariffVersionId.value
        : this.tariffVersionId,
    billingMethodSnapshot: billingMethodSnapshot.present
        ? billingMethodSnapshot.value
        : this.billingMethodSnapshot,
    currencySnapshot: currencySnapshot.present
        ? currencySnapshot.value
        : this.currencySnapshot,
    calculationSnapshot: calculationSnapshot.present
        ? calculationSnapshot.value
        : this.calculationSnapshot,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillingPeriod copyWithCompanion(BillingPeriodsCompanion data) {
    return BillingPeriod(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      status: data.status.present ? data.status.value : this.status,
      finalizedAt: data.finalizedAt.present
          ? data.finalizedAt.value
          : this.finalizedAt,
      finalizedBy: data.finalizedBy.present
          ? data.finalizedBy.value
          : this.finalizedBy,
      tariffVersionId: data.tariffVersionId.present
          ? data.tariffVersionId.value
          : this.tariffVersionId,
      billingMethodSnapshot: data.billingMethodSnapshot.present
          ? data.billingMethodSnapshot.value
          : this.billingMethodSnapshot,
      currencySnapshot: data.currencySnapshot.present
          ? data.currencySnapshot.value
          : this.currencySnapshot,
      calculationSnapshot: data.calculationSnapshot.present
          ? data.calculationSnapshot.value
          : this.calculationSnapshot,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingPeriod(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('status: $status, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('finalizedBy: $finalizedBy, ')
          ..write('tariffVersionId: $tariffVersionId, ')
          ..write('billingMethodSnapshot: $billingMethodSnapshot, ')
          ..write('currencySnapshot: $currencySnapshot, ')
          ..write('calculationSnapshot: $calculationSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    year,
    month,
    status,
    finalizedAt,
    finalizedBy,
    tariffVersionId,
    billingMethodSnapshot,
    currencySnapshot,
    calculationSnapshot,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingPeriod &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.year == this.year &&
          other.month == this.month &&
          other.status == this.status &&
          other.finalizedAt == this.finalizedAt &&
          other.finalizedBy == this.finalizedBy &&
          other.tariffVersionId == this.tariffVersionId &&
          other.billingMethodSnapshot == this.billingMethodSnapshot &&
          other.currencySnapshot == this.currencySnapshot &&
          other.calculationSnapshot == this.calculationSnapshot &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillingPeriodsCompanion extends UpdateCompanion<BillingPeriod> {
  final Value<int> id;
  final Value<int> propertyId;
  final Value<int> year;
  final Value<int> month;
  final Value<String> status;
  final Value<DateTime?> finalizedAt;
  final Value<String?> finalizedBy;
  final Value<int?> tariffVersionId;
  final Value<String?> billingMethodSnapshot;
  final Value<String?> currencySnapshot;
  final Value<String?> calculationSnapshot;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BillingPeriodsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.status = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.finalizedBy = const Value.absent(),
    this.tariffVersionId = const Value.absent(),
    this.billingMethodSnapshot = const Value.absent(),
    this.currencySnapshot = const Value.absent(),
    this.calculationSnapshot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BillingPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required int propertyId,
    required int year,
    required int month,
    this.status = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.finalizedBy = const Value.absent(),
    this.tariffVersionId = const Value.absent(),
    this.billingMethodSnapshot = const Value.absent(),
    this.currencySnapshot = const Value.absent(),
    this.calculationSnapshot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : propertyId = Value(propertyId),
       year = Value(year),
       month = Value(month);
  static Insertable<BillingPeriod> custom({
    Expression<int>? id,
    Expression<int>? propertyId,
    Expression<int>? year,
    Expression<int>? month,
    Expression<String>? status,
    Expression<DateTime>? finalizedAt,
    Expression<String>? finalizedBy,
    Expression<int>? tariffVersionId,
    Expression<String>? billingMethodSnapshot,
    Expression<String>? currencySnapshot,
    Expression<String>? calculationSnapshot,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (status != null) 'status': status,
      if (finalizedAt != null) 'finalized_at': finalizedAt,
      if (finalizedBy != null) 'finalized_by': finalizedBy,
      if (tariffVersionId != null) 'tariff_version_id': tariffVersionId,
      if (billingMethodSnapshot != null)
        'billing_method_snapshot': billingMethodSnapshot,
      if (currencySnapshot != null) 'currency_snapshot': currencySnapshot,
      if (calculationSnapshot != null)
        'calculation_snapshot': calculationSnapshot,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BillingPeriodsCompanion copyWith({
    Value<int>? id,
    Value<int>? propertyId,
    Value<int>? year,
    Value<int>? month,
    Value<String>? status,
    Value<DateTime?>? finalizedAt,
    Value<String?>? finalizedBy,
    Value<int?>? tariffVersionId,
    Value<String?>? billingMethodSnapshot,
    Value<String?>? currencySnapshot,
    Value<String?>? calculationSnapshot,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BillingPeriodsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      year: year ?? this.year,
      month: month ?? this.month,
      status: status ?? this.status,
      finalizedAt: finalizedAt ?? this.finalizedAt,
      finalizedBy: finalizedBy ?? this.finalizedBy,
      tariffVersionId: tariffVersionId ?? this.tariffVersionId,
      billingMethodSnapshot:
          billingMethodSnapshot ?? this.billingMethodSnapshot,
      currencySnapshot: currencySnapshot ?? this.currencySnapshot,
      calculationSnapshot: calculationSnapshot ?? this.calculationSnapshot,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<int>(propertyId.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (finalizedAt.present) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt.value);
    }
    if (finalizedBy.present) {
      map['finalized_by'] = Variable<String>(finalizedBy.value);
    }
    if (tariffVersionId.present) {
      map['tariff_version_id'] = Variable<int>(tariffVersionId.value);
    }
    if (billingMethodSnapshot.present) {
      map['billing_method_snapshot'] = Variable<String>(
        billingMethodSnapshot.value,
      );
    }
    if (currencySnapshot.present) {
      map['currency_snapshot'] = Variable<String>(currencySnapshot.value);
    }
    if (calculationSnapshot.present) {
      map['calculation_snapshot'] = Variable<String>(calculationSnapshot.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('status: $status, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('finalizedBy: $finalizedBy, ')
          ..write('tariffVersionId: $tariffVersionId, ')
          ..write('billingMethodSnapshot: $billingMethodSnapshot, ')
          ..write('currencySnapshot: $currencySnapshot, ')
          ..write('calculationSnapshot: $calculationSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SettlementsTable extends Settlements
    with TableInfo<$SettlementsTable, Settlement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettlementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mainMeterIdMeta = const VerificationMeta(
    'mainMeterId',
  );
  @override
  late final GeneratedColumn<int> mainMeterId = GeneratedColumn<int>(
    'main_meter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES main_meters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _settlementDateMeta = const VerificationMeta(
    'settlementDate',
  );
  @override
  late final GeneratedColumn<DateTime> settlementDate =
      GeneratedColumn<DateTime>(
        'settlement_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fromTenantIdMeta = const VerificationMeta(
    'fromTenantId',
  );
  @override
  late final GeneratedColumn<int> fromTenantId = GeneratedColumn<int>(
    'from_tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenants (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _toTenantIdMeta = const VerificationMeta(
    'toTenantId',
  );
  @override
  late final GeneratedColumn<int> toTenantId = GeneratedColumn<int>(
    'to_tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenants (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    mainMeterId,
    settlementDate,
    fromTenantId,
    toTenantId,
    amount,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settlements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Settlement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_meter_id')) {
      context.handle(
        _mainMeterIdMeta,
        mainMeterId.isAcceptableOrUnknown(
          data['main_meter_id']!,
          _mainMeterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainMeterIdMeta);
    }
    if (data.containsKey('settlement_date')) {
      context.handle(
        _settlementDateMeta,
        settlementDate.isAcceptableOrUnknown(
          data['settlement_date']!,
          _settlementDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settlementDateMeta);
    }
    if (data.containsKey('from_tenant_id')) {
      context.handle(
        _fromTenantIdMeta,
        fromTenantId.isAcceptableOrUnknown(
          data['from_tenant_id']!,
          _fromTenantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromTenantIdMeta);
    }
    if (data.containsKey('to_tenant_id')) {
      context.handle(
        _toTenantIdMeta,
        toTenantId.isAcceptableOrUnknown(
          data['to_tenant_id']!,
          _toTenantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toTenantIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
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
  Settlement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Settlement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mainMeterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}main_meter_id'],
      )!,
      settlementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}settlement_date'],
      )!,
      fromTenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_tenant_id'],
      )!,
      toTenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_tenant_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SettlementsTable createAlias(String alias) {
    return $SettlementsTable(attachedDatabase, alias);
  }
}

class Settlement extends DataClass implements Insertable<Settlement> {
  final int id;
  final int mainMeterId;
  final DateTime settlementDate;

  /// Tenant paying (was in due).
  final int fromTenantId;

  /// Tenant receiving (was in credit).
  final int toTenantId;
  final double amount;
  final String? notes;
  final DateTime createdAt;
  const Settlement({
    required this.id,
    required this.mainMeterId,
    required this.settlementDate,
    required this.fromTenantId,
    required this.toTenantId,
    required this.amount,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['main_meter_id'] = Variable<int>(mainMeterId);
    map['settlement_date'] = Variable<DateTime>(settlementDate);
    map['from_tenant_id'] = Variable<int>(fromTenantId);
    map['to_tenant_id'] = Variable<int>(toTenantId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SettlementsCompanion toCompanion(bool nullToAbsent) {
    return SettlementsCompanion(
      id: Value(id),
      mainMeterId: Value(mainMeterId),
      settlementDate: Value(settlementDate),
      fromTenantId: Value(fromTenantId),
      toTenantId: Value(toTenantId),
      amount: Value(amount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Settlement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Settlement(
      id: serializer.fromJson<int>(json['id']),
      mainMeterId: serializer.fromJson<int>(json['mainMeterId']),
      settlementDate: serializer.fromJson<DateTime>(json['settlementDate']),
      fromTenantId: serializer.fromJson<int>(json['fromTenantId']),
      toTenantId: serializer.fromJson<int>(json['toTenantId']),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainMeterId': serializer.toJson<int>(mainMeterId),
      'settlementDate': serializer.toJson<DateTime>(settlementDate),
      'fromTenantId': serializer.toJson<int>(fromTenantId),
      'toTenantId': serializer.toJson<int>(toTenantId),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Settlement copyWith({
    int? id,
    int? mainMeterId,
    DateTime? settlementDate,
    int? fromTenantId,
    int? toTenantId,
    double? amount,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Settlement(
    id: id ?? this.id,
    mainMeterId: mainMeterId ?? this.mainMeterId,
    settlementDate: settlementDate ?? this.settlementDate,
    fromTenantId: fromTenantId ?? this.fromTenantId,
    toTenantId: toTenantId ?? this.toTenantId,
    amount: amount ?? this.amount,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Settlement copyWithCompanion(SettlementsCompanion data) {
    return Settlement(
      id: data.id.present ? data.id.value : this.id,
      mainMeterId: data.mainMeterId.present
          ? data.mainMeterId.value
          : this.mainMeterId,
      settlementDate: data.settlementDate.present
          ? data.settlementDate.value
          : this.settlementDate,
      fromTenantId: data.fromTenantId.present
          ? data.fromTenantId.value
          : this.fromTenantId,
      toTenantId: data.toTenantId.present
          ? data.toTenantId.value
          : this.toTenantId,
      amount: data.amount.present ? data.amount.value : this.amount,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Settlement(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('settlementDate: $settlementDate, ')
          ..write('fromTenantId: $fromTenantId, ')
          ..write('toTenantId: $toTenantId, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainMeterId,
    settlementDate,
    fromTenantId,
    toTenantId,
    amount,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Settlement &&
          other.id == this.id &&
          other.mainMeterId == this.mainMeterId &&
          other.settlementDate == this.settlementDate &&
          other.fromTenantId == this.fromTenantId &&
          other.toTenantId == this.toTenantId &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SettlementsCompanion extends UpdateCompanion<Settlement> {
  final Value<int> id;
  final Value<int> mainMeterId;
  final Value<DateTime> settlementDate;
  final Value<int> fromTenantId;
  final Value<int> toTenantId;
  final Value<double> amount;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const SettlementsCompanion({
    this.id = const Value.absent(),
    this.mainMeterId = const Value.absent(),
    this.settlementDate = const Value.absent(),
    this.fromTenantId = const Value.absent(),
    this.toTenantId = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SettlementsCompanion.insert({
    this.id = const Value.absent(),
    required int mainMeterId,
    required DateTime settlementDate,
    required int fromTenantId,
    required int toTenantId,
    required double amount,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : mainMeterId = Value(mainMeterId),
       settlementDate = Value(settlementDate),
       fromTenantId = Value(fromTenantId),
       toTenantId = Value(toTenantId),
       amount = Value(amount);
  static Insertable<Settlement> custom({
    Expression<int>? id,
    Expression<int>? mainMeterId,
    Expression<DateTime>? settlementDate,
    Expression<int>? fromTenantId,
    Expression<int>? toTenantId,
    Expression<double>? amount,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainMeterId != null) 'main_meter_id': mainMeterId,
      if (settlementDate != null) 'settlement_date': settlementDate,
      if (fromTenantId != null) 'from_tenant_id': fromTenantId,
      if (toTenantId != null) 'to_tenant_id': toTenantId,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SettlementsCompanion copyWith({
    Value<int>? id,
    Value<int>? mainMeterId,
    Value<DateTime>? settlementDate,
    Value<int>? fromTenantId,
    Value<int>? toTenantId,
    Value<double>? amount,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return SettlementsCompanion(
      id: id ?? this.id,
      mainMeterId: mainMeterId ?? this.mainMeterId,
      settlementDate: settlementDate ?? this.settlementDate,
      fromTenantId: fromTenantId ?? this.fromTenantId,
      toTenantId: toTenantId ?? this.toTenantId,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainMeterId.present) {
      map['main_meter_id'] = Variable<int>(mainMeterId.value);
    }
    if (settlementDate.present) {
      map['settlement_date'] = Variable<DateTime>(settlementDate.value);
    }
    if (fromTenantId.present) {
      map['from_tenant_id'] = Variable<int>(fromTenantId.value);
    }
    if (toTenantId.present) {
      map['to_tenant_id'] = Variable<int>(toTenantId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettlementsCompanion(')
          ..write('id: $id, ')
          ..write('mainMeterId: $mainMeterId, ')
          ..write('settlementDate: $settlementDate, ')
          ..write('fromTenantId: $fromTenantId, ')
          ..write('toTenantId: $toTenantId, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $ElectricityProvidersTable electricityProviders =
      $ElectricityProvidersTable(this);
  late final $TariffSlabsTable tariffSlabs = $TariffSlabsTable(this);
  late final $MainMetersTable mainMeters = $MainMetersTable(this);
  late final $TenantsTable tenants = $TenantsTable(this);
  late final $MeterReadingsTable meterReadings = $MeterReadingsTable(this);
  late final $RechargesTable recharges = $RechargesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $BillPaymentsTable billPayments = $BillPaymentsTable(this);
  late final $TariffVersionsTable tariffVersions = $TariffVersionsTable(this);
  late final $BillingPeriodsTable billingPeriods = $BillingPeriodsTable(this);
  late final $SettlementsTable settlements = $SettlementsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    properties,
    electricityProviders,
    tariffSlabs,
    mainMeters,
    tenants,
    meterReadings,
    recharges,
    appSettings,
    billPayments,
    tariffVersions,
    billingPeriods,
    settlements,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'electricity_providers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tariff_slabs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'properties',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('main_meters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'main_meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tenants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'main_meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meter_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tenants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meter_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'main_meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recharges', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'properties',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('billing_periods', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'main_meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('settlements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tenants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('settlements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tenants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('settlements', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PropertiesTableCreateCompanionBuilder =
    PropertiesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> address,
      Value<String?> notes,
      Value<String> currencyCode,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PropertiesTableUpdateCompanionBuilder =
    PropertiesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> address,
      Value<String?> notes,
      Value<String> currencyCode,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MainMetersTable, List<MainMeter>>
  _mainMetersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mainMeters,
    aliasName: 'properties__id__main_meters__property_id',
  );

  $$MainMetersTableProcessedTableManager get mainMetersRefs {
    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mainMetersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillingPeriodsTable, List<BillingPeriod>>
  _billingPeriodsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billingPeriods,
    aliasName: 'properties__id__billing_periods__property_id',
  );

  $$BillingPeriodsTableProcessedTableManager get billingPeriodsRefs {
    final manager = $$BillingPeriodsTableTableManager(
      $_db,
      $_db.billingPeriods,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billingPeriodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mainMetersRefs(
    Expression<bool> Function($$MainMetersTableFilterComposer f) f,
  ) {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> billingPeriodsRefs(
    Expression<bool> Function($$BillingPeriodsTableFilterComposer f) f,
  ) {
    final $$BillingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billingPeriods,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.billingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> mainMetersRefs<T extends Object>(
    Expression<T> Function($$MainMetersTableAnnotationComposer a) f,
  ) {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> billingPeriodsRefs<T extends Object>(
    Expression<T> Function($$BillingPeriodsTableAnnotationComposer a) f,
  ) {
    final $$BillingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billingPeriods,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.billingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PropertiesTable,
          Property,
          $$PropertiesTableFilterComposer,
          $$PropertiesTableOrderingComposer,
          $$PropertiesTableAnnotationComposer,
          $$PropertiesTableCreateCompanionBuilder,
          $$PropertiesTableUpdateCompanionBuilder,
          (Property, $$PropertiesTableReferences),
          Property,
          PrefetchHooks Function({bool mainMetersRefs, bool billingPeriodsRefs})
        > {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PropertiesCompanion(
                id: id,
                name: name,
                address: address,
                notes: notes,
                currencyCode: currencyCode,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PropertiesCompanion.insert(
                id: id,
                name: name,
                address: address,
                notes: notes,
                currencyCode: currencyCode,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PropertiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mainMetersRefs = false, billingPeriodsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mainMetersRefs) db.mainMeters,
                    if (billingPeriodsRefs) db.billingPeriods,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mainMetersRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          MainMeter
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._mainMetersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).mainMetersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billingPeriodsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          BillingPeriod
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._billingPeriodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).billingPeriodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PropertiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PropertiesTable,
      Property,
      $$PropertiesTableFilterComposer,
      $$PropertiesTableOrderingComposer,
      $$PropertiesTableAnnotationComposer,
      $$PropertiesTableCreateCompanionBuilder,
      $$PropertiesTableUpdateCompanionBuilder,
      (Property, $$PropertiesTableReferences),
      Property,
      PrefetchHooks Function({bool mainMetersRefs, bool billingPeriodsRefs})
    >;
typedef $$ElectricityProvidersTableCreateCompanionBuilder =
    ElectricityProvidersCompanion Function({
      Value<int> id,
      required String name,
      Value<double> vatPercent,
      Value<double> rebatePercent,
      Value<double> meterRent,
      Value<double> demandChargePerKw,
      Value<String?> currencyCode,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ElectricityProvidersTableUpdateCompanionBuilder =
    ElectricityProvidersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> vatPercent,
      Value<double> rebatePercent,
      Value<double> meterRent,
      Value<double> demandChargePerKw,
      Value<String?> currencyCode,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ElectricityProvidersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ElectricityProvidersTable,
          ElectricityProvider
        > {
  $$ElectricityProvidersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TariffSlabsTable, List<TariffSlab>>
  _tariffSlabsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tariffSlabs,
    aliasName: 'electricity_providers__id__tariff_slabs__provider_id',
  );

  $$TariffSlabsTableProcessedTableManager get tariffSlabsRefs {
    final manager = $$TariffSlabsTableTableManager(
      $_db,
      $_db.tariffSlabs,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tariffSlabsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MainMetersTable, List<MainMeter>>
  _mainMetersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mainMeters,
    aliasName: 'electricity_providers__id__main_meters__provider_id',
  );

  $$MainMetersTableProcessedTableManager get mainMetersRefs {
    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mainMetersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ElectricityProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $ElectricityProvidersTable> {
  $$ElectricityProvidersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatPercent => $composableBuilder(
    column: $table.vatPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rebatePercent => $composableBuilder(
    column: $table.rebatePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterRent => $composableBuilder(
    column: $table.meterRent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get demandChargePerKw => $composableBuilder(
    column: $table.demandChargePerKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tariffSlabsRefs(
    Expression<bool> Function($$TariffSlabsTableFilterComposer f) f,
  ) {
    final $$TariffSlabsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tariffSlabs,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TariffSlabsTableFilterComposer(
            $db: $db,
            $table: $db.tariffSlabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mainMetersRefs(
    Expression<bool> Function($$MainMetersTableFilterComposer f) f,
  ) {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElectricityProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $ElectricityProvidersTable> {
  $$ElectricityProvidersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatPercent => $composableBuilder(
    column: $table.vatPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rebatePercent => $composableBuilder(
    column: $table.rebatePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterRent => $composableBuilder(
    column: $table.meterRent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get demandChargePerKw => $composableBuilder(
    column: $table.demandChargePerKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ElectricityProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElectricityProvidersTable> {
  $$ElectricityProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get vatPercent => $composableBuilder(
    column: $table.vatPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rebatePercent => $composableBuilder(
    column: $table.rebatePercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get meterRent =>
      $composableBuilder(column: $table.meterRent, builder: (column) => column);

  GeneratedColumn<double> get demandChargePerKw => $composableBuilder(
    column: $table.demandChargePerKw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> tariffSlabsRefs<T extends Object>(
    Expression<T> Function($$TariffSlabsTableAnnotationComposer a) f,
  ) {
    final $$TariffSlabsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tariffSlabs,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TariffSlabsTableAnnotationComposer(
            $db: $db,
            $table: $db.tariffSlabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mainMetersRefs<T extends Object>(
    Expression<T> Function($$MainMetersTableAnnotationComposer a) f,
  ) {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElectricityProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElectricityProvidersTable,
          ElectricityProvider,
          $$ElectricityProvidersTableFilterComposer,
          $$ElectricityProvidersTableOrderingComposer,
          $$ElectricityProvidersTableAnnotationComposer,
          $$ElectricityProvidersTableCreateCompanionBuilder,
          $$ElectricityProvidersTableUpdateCompanionBuilder,
          (ElectricityProvider, $$ElectricityProvidersTableReferences),
          ElectricityProvider,
          PrefetchHooks Function({bool tariffSlabsRefs, bool mainMetersRefs})
        > {
  $$ElectricityProvidersTableTableManager(
    _$AppDatabase db,
    $ElectricityProvidersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElectricityProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElectricityProvidersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ElectricityProvidersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> vatPercent = const Value.absent(),
                Value<double> rebatePercent = const Value.absent(),
                Value<double> meterRent = const Value.absent(),
                Value<double> demandChargePerKw = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ElectricityProvidersCompanion(
                id: id,
                name: name,
                vatPercent: vatPercent,
                rebatePercent: rebatePercent,
                meterRent: meterRent,
                demandChargePerKw: demandChargePerKw,
                currencyCode: currencyCode,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<double> vatPercent = const Value.absent(),
                Value<double> rebatePercent = const Value.absent(),
                Value<double> meterRent = const Value.absent(),
                Value<double> demandChargePerKw = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ElectricityProvidersCompanion.insert(
                id: id,
                name: name,
                vatPercent: vatPercent,
                rebatePercent: rebatePercent,
                meterRent: meterRent,
                demandChargePerKw: demandChargePerKw,
                currencyCode: currencyCode,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ElectricityProvidersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tariffSlabsRefs = false, mainMetersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tariffSlabsRefs) db.tariffSlabs,
                    if (mainMetersRefs) db.mainMeters,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tariffSlabsRefs)
                        await $_getPrefetchedData<
                          ElectricityProvider,
                          $ElectricityProvidersTable,
                          TariffSlab
                        >(
                          currentTable: table,
                          referencedTable: $$ElectricityProvidersTableReferences
                              ._tariffSlabsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElectricityProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).tariffSlabsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mainMetersRefs)
                        await $_getPrefetchedData<
                          ElectricityProvider,
                          $ElectricityProvidersTable,
                          MainMeter
                        >(
                          currentTable: table,
                          referencedTable: $$ElectricityProvidersTableReferences
                              ._mainMetersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElectricityProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).mainMetersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ElectricityProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElectricityProvidersTable,
      ElectricityProvider,
      $$ElectricityProvidersTableFilterComposer,
      $$ElectricityProvidersTableOrderingComposer,
      $$ElectricityProvidersTableAnnotationComposer,
      $$ElectricityProvidersTableCreateCompanionBuilder,
      $$ElectricityProvidersTableUpdateCompanionBuilder,
      (ElectricityProvider, $$ElectricityProvidersTableReferences),
      ElectricityProvider,
      PrefetchHooks Function({bool tariffSlabsRefs, bool mainMetersRefs})
    >;
typedef $$TariffSlabsTableCreateCompanionBuilder =
    TariffSlabsCompanion Function({
      Value<int> id,
      required int providerId,
      required int fromUnit,
      Value<int?> toUnit,
      required double rate,
      Value<int> sortOrder,
    });
typedef $$TariffSlabsTableUpdateCompanionBuilder =
    TariffSlabsCompanion Function({
      Value<int> id,
      Value<int> providerId,
      Value<int> fromUnit,
      Value<int?> toUnit,
      Value<double> rate,
      Value<int> sortOrder,
    });

final class $$TariffSlabsTableReferences
    extends BaseReferences<_$AppDatabase, $TariffSlabsTable, TariffSlab> {
  $$TariffSlabsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElectricityProvidersTable _providerIdTable(_$AppDatabase db) => db
      .electricityProviders
      .createAlias('tariff_slabs__provider_id__electricity_providers__id');

  $$ElectricityProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$ElectricityProvidersTableTableManager(
      $_db,
      $_db.electricityProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TariffSlabsTableFilterComposer
    extends Composer<_$AppDatabase, $TariffSlabsTable> {
  $$TariffSlabsTableFilterComposer({
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

  ColumnFilters<int> get fromUnit => $composableBuilder(
    column: $table.fromUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toUnit => $composableBuilder(
    column: $table.toUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ElectricityProvidersTableFilterComposer get providerId {
    final $$ElectricityProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.electricityProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElectricityProvidersTableFilterComposer(
            $db: $db,
            $table: $db.electricityProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TariffSlabsTableOrderingComposer
    extends Composer<_$AppDatabase, $TariffSlabsTable> {
  $$TariffSlabsTableOrderingComposer({
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

  ColumnOrderings<int> get fromUnit => $composableBuilder(
    column: $table.fromUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toUnit => $composableBuilder(
    column: $table.toUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElectricityProvidersTableOrderingComposer get providerId {
    final $$ElectricityProvidersTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.electricityProviders,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ElectricityProvidersTableOrderingComposer(
                $db: $db,
                $table: $db.electricityProviders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TariffSlabsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TariffSlabsTable> {
  $$TariffSlabsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fromUnit =>
      $composableBuilder(column: $table.fromUnit, builder: (column) => column);

  GeneratedColumn<int> get toUnit =>
      $composableBuilder(column: $table.toUnit, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ElectricityProvidersTableAnnotationComposer get providerId {
    final $$ElectricityProvidersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.electricityProviders,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ElectricityProvidersTableAnnotationComposer(
                $db: $db,
                $table: $db.electricityProviders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TariffSlabsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TariffSlabsTable,
          TariffSlab,
          $$TariffSlabsTableFilterComposer,
          $$TariffSlabsTableOrderingComposer,
          $$TariffSlabsTableAnnotationComposer,
          $$TariffSlabsTableCreateCompanionBuilder,
          $$TariffSlabsTableUpdateCompanionBuilder,
          (TariffSlab, $$TariffSlabsTableReferences),
          TariffSlab,
          PrefetchHooks Function({bool providerId})
        > {
  $$TariffSlabsTableTableManager(_$AppDatabase db, $TariffSlabsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TariffSlabsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TariffSlabsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TariffSlabsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<int> fromUnit = const Value.absent(),
                Value<int?> toUnit = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => TariffSlabsCompanion(
                id: id,
                providerId: providerId,
                fromUnit: fromUnit,
                toUnit: toUnit,
                rate: rate,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int providerId,
                required int fromUnit,
                Value<int?> toUnit = const Value.absent(),
                required double rate,
                Value<int> sortOrder = const Value.absent(),
              }) => TariffSlabsCompanion.insert(
                id: id,
                providerId: providerId,
                fromUnit: fromUnit,
                toUnit: toUnit,
                rate: rate,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TariffSlabsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
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
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable: $$TariffSlabsTableReferences
                                    ._providerIdTable(db),
                                referencedColumn: $$TariffSlabsTableReferences
                                    ._providerIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$TariffSlabsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TariffSlabsTable,
      TariffSlab,
      $$TariffSlabsTableFilterComposer,
      $$TariffSlabsTableOrderingComposer,
      $$TariffSlabsTableAnnotationComposer,
      $$TariffSlabsTableCreateCompanionBuilder,
      $$TariffSlabsTableUpdateCompanionBuilder,
      (TariffSlab, $$TariffSlabsTableReferences),
      TariffSlab,
      PrefetchHooks Function({bool providerId})
    >;
typedef $$MainMetersTableCreateCompanionBuilder =
    MainMetersCompanion Function({
      Value<int> id,
      required int propertyId,
      required int providerId,
      required String name,
      Value<String?> meterNumber,
      Value<double?> sanctionedLoad,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MainMetersTableUpdateCompanionBuilder =
    MainMetersCompanion Function({
      Value<int> id,
      Value<int> propertyId,
      Value<int> providerId,
      Value<String> name,
      Value<String?> meterNumber,
      Value<double?> sanctionedLoad,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$MainMetersTableReferences
    extends BaseReferences<_$AppDatabase, $MainMetersTable, MainMeter> {
  $$MainMetersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('main_meters__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<int>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ElectricityProvidersTable _providerIdTable(_$AppDatabase db) => db
      .electricityProviders
      .createAlias('main_meters__provider_id__electricity_providers__id');

  $$ElectricityProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$ElectricityProvidersTableTableManager(
      $_db,
      $_db.electricityProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TenantsTable, List<Tenant>> _tenantsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tenants,
    aliasName: 'main_meters__id__tenants__main_meter_id',
  );

  $$TenantsTableProcessedTableManager get tenantsRefs {
    final manager = $$TenantsTableTableManager(
      $_db,
      $_db.tenants,
    ).filter((f) => f.mainMeterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tenantsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeterReadingsTable, List<MeterReading>>
  _meterReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meterReadings,
    aliasName: 'main_meters__id__meter_readings__main_meter_id',
  );

  $$MeterReadingsTableProcessedTableManager get meterReadingsRefs {
    final manager = $$MeterReadingsTableTableManager(
      $_db,
      $_db.meterReadings,
    ).filter((f) => f.mainMeterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_meterReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RechargesTable, List<Recharge>>
  _rechargesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recharges,
    aliasName: 'main_meters__id__recharges__main_meter_id',
  );

  $$RechargesTableProcessedTableManager get rechargesRefs {
    final manager = $$RechargesTableTableManager(
      $_db,
      $_db.recharges,
    ).filter((f) => f.mainMeterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rechargesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SettlementsTable, List<Settlement>>
  _settlementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.settlements,
    aliasName: 'main_meters__id__settlements__main_meter_id',
  );

  $$SettlementsTableProcessedTableManager get settlementsRefs {
    final manager = $$SettlementsTableTableManager(
      $_db,
      $_db.settlements,
    ).filter((f) => f.mainMeterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_settlementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MainMetersTableFilterComposer
    extends Composer<_$AppDatabase, $MainMetersTable> {
  $$MainMetersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sanctionedLoad => $composableBuilder(
    column: $table.sanctionedLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElectricityProvidersTableFilterComposer get providerId {
    final $$ElectricityProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.electricityProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElectricityProvidersTableFilterComposer(
            $db: $db,
            $table: $db.electricityProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tenantsRefs(
    Expression<bool> Function($$TenantsTableFilterComposer f) f,
  ) {
    final $$TenantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableFilterComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> meterReadingsRefs(
    Expression<bool> Function($$MeterReadingsTableFilterComposer f) f,
  ) {
    final $$MeterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meterReadings,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.meterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rechargesRefs(
    Expression<bool> Function($$RechargesTableFilterComposer f) f,
  ) {
    final $$RechargesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recharges,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RechargesTableFilterComposer(
            $db: $db,
            $table: $db.recharges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> settlementsRefs(
    Expression<bool> Function($$SettlementsTableFilterComposer f) f,
  ) {
    final $$SettlementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.settlements,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettlementsTableFilterComposer(
            $db: $db,
            $table: $db.settlements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MainMetersTableOrderingComposer
    extends Composer<_$AppDatabase, $MainMetersTable> {
  $$MainMetersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sanctionedLoad => $composableBuilder(
    column: $table.sanctionedLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElectricityProvidersTableOrderingComposer get providerId {
    final $$ElectricityProvidersTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.electricityProviders,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ElectricityProvidersTableOrderingComposer(
                $db: $db,
                $table: $db.electricityProviders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MainMetersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MainMetersTable> {
  $$MainMetersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sanctionedLoad => $composableBuilder(
    column: $table.sanctionedLoad,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElectricityProvidersTableAnnotationComposer get providerId {
    final $$ElectricityProvidersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.electricityProviders,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ElectricityProvidersTableAnnotationComposer(
                $db: $db,
                $table: $db.electricityProviders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> tenantsRefs<T extends Object>(
    Expression<T> Function($$TenantsTableAnnotationComposer a) f,
  ) {
    final $$TenantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableAnnotationComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> meterReadingsRefs<T extends Object>(
    Expression<T> Function($$MeterReadingsTableAnnotationComposer a) f,
  ) {
    final $$MeterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meterReadings,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> rechargesRefs<T extends Object>(
    Expression<T> Function($$RechargesTableAnnotationComposer a) f,
  ) {
    final $$RechargesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recharges,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RechargesTableAnnotationComposer(
            $db: $db,
            $table: $db.recharges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> settlementsRefs<T extends Object>(
    Expression<T> Function($$SettlementsTableAnnotationComposer a) f,
  ) {
    final $$SettlementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.settlements,
      getReferencedColumn: (t) => t.mainMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettlementsTableAnnotationComposer(
            $db: $db,
            $table: $db.settlements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MainMetersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MainMetersTable,
          MainMeter,
          $$MainMetersTableFilterComposer,
          $$MainMetersTableOrderingComposer,
          $$MainMetersTableAnnotationComposer,
          $$MainMetersTableCreateCompanionBuilder,
          $$MainMetersTableUpdateCompanionBuilder,
          (MainMeter, $$MainMetersTableReferences),
          MainMeter,
          PrefetchHooks Function({
            bool propertyId,
            bool providerId,
            bool tenantsRefs,
            bool meterReadingsRefs,
            bool rechargesRefs,
            bool settlementsRefs,
          })
        > {
  $$MainMetersTableTableManager(_$AppDatabase db, $MainMetersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MainMetersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MainMetersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MainMetersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> propertyId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> meterNumber = const Value.absent(),
                Value<double?> sanctionedLoad = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MainMetersCompanion(
                id: id,
                propertyId: propertyId,
                providerId: providerId,
                name: name,
                meterNumber: meterNumber,
                sanctionedLoad: sanctionedLoad,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int propertyId,
                required int providerId,
                required String name,
                Value<String?> meterNumber = const Value.absent(),
                Value<double?> sanctionedLoad = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MainMetersCompanion.insert(
                id: id,
                propertyId: propertyId,
                providerId: providerId,
                name: name,
                meterNumber: meterNumber,
                sanctionedLoad: sanctionedLoad,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MainMetersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                propertyId = false,
                providerId = false,
                tenantsRefs = false,
                meterReadingsRefs = false,
                rechargesRefs = false,
                settlementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tenantsRefs) db.tenants,
                    if (meterReadingsRefs) db.meterReadings,
                    if (rechargesRefs) db.recharges,
                    if (settlementsRefs) db.settlements,
                  ],
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
                        if (propertyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.propertyId,
                                    referencedTable: $$MainMetersTableReferences
                                        ._propertyIdTable(db),
                                    referencedColumn:
                                        $$MainMetersTableReferences
                                            ._propertyIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (providerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.providerId,
                                    referencedTable: $$MainMetersTableReferences
                                        ._providerIdTable(db),
                                    referencedColumn:
                                        $$MainMetersTableReferences
                                            ._providerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tenantsRefs)
                        await $_getPrefetchedData<
                          MainMeter,
                          $MainMetersTable,
                          Tenant
                        >(
                          currentTable: table,
                          referencedTable: $$MainMetersTableReferences
                              ._tenantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MainMetersTableReferences(
                                db,
                                table,
                                p0,
                              ).tenantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainMeterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (meterReadingsRefs)
                        await $_getPrefetchedData<
                          MainMeter,
                          $MainMetersTable,
                          MeterReading
                        >(
                          currentTable: table,
                          referencedTable: $$MainMetersTableReferences
                              ._meterReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MainMetersTableReferences(
                                db,
                                table,
                                p0,
                              ).meterReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainMeterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (rechargesRefs)
                        await $_getPrefetchedData<
                          MainMeter,
                          $MainMetersTable,
                          Recharge
                        >(
                          currentTable: table,
                          referencedTable: $$MainMetersTableReferences
                              ._rechargesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MainMetersTableReferences(
                                db,
                                table,
                                p0,
                              ).rechargesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainMeterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (settlementsRefs)
                        await $_getPrefetchedData<
                          MainMeter,
                          $MainMetersTable,
                          Settlement
                        >(
                          currentTable: table,
                          referencedTable: $$MainMetersTableReferences
                              ._settlementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MainMetersTableReferences(
                                db,
                                table,
                                p0,
                              ).settlementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainMeterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MainMetersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MainMetersTable,
      MainMeter,
      $$MainMetersTableFilterComposer,
      $$MainMetersTableOrderingComposer,
      $$MainMetersTableAnnotationComposer,
      $$MainMetersTableCreateCompanionBuilder,
      $$MainMetersTableUpdateCompanionBuilder,
      (MainMeter, $$MainMetersTableReferences),
      MainMeter,
      PrefetchHooks Function({
        bool propertyId,
        bool providerId,
        bool tenantsRefs,
        bool meterReadingsRefs,
        bool rechargesRefs,
        bool settlementsRefs,
      })
    >;
typedef $$TenantsTableCreateCompanionBuilder =
    TenantsCompanion Function({
      Value<int> id,
      required int mainMeterId,
      required String name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> apartment,
      Value<String?> meterNumber,
      Value<String> status,
      Value<String> billingMode,
      Value<double?> fixedRate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TenantsTableUpdateCompanionBuilder =
    TenantsCompanion Function({
      Value<int> id,
      Value<int> mainMeterId,
      Value<String> name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> apartment,
      Value<String?> meterNumber,
      Value<String> status,
      Value<String> billingMode,
      Value<double?> fixedRate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TenantsTableReferences
    extends BaseReferences<_$AppDatabase, $TenantsTable, Tenant> {
  $$TenantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MainMetersTable _mainMeterIdTable(_$AppDatabase db) =>
      db.mainMeters.createAlias('tenants__main_meter_id__main_meters__id');

  $$MainMetersTableProcessedTableManager get mainMeterId {
    final $_column = $_itemColumn<int>('main_meter_id')!;

    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainMeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MeterReadingsTable, List<MeterReading>>
  _meterReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meterReadings,
    aliasName: 'tenants__id__meter_readings__tenant_id',
  );

  $$MeterReadingsTableProcessedTableManager get meterReadingsRefs {
    final manager = $$MeterReadingsTableTableManager(
      $_db,
      $_db.meterReadings,
    ).filter((f) => f.tenantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_meterReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TenantsTableFilterComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apartment => $composableBuilder(
    column: $table.apartment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fixedRate => $composableBuilder(
    column: $table.fixedRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MainMetersTableFilterComposer get mainMeterId {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> meterReadingsRefs(
    Expression<bool> Function($$MeterReadingsTableFilterComposer f) f,
  ) {
    final $$MeterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meterReadings,
      getReferencedColumn: (t) => t.tenantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.meterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenantsTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apartment => $composableBuilder(
    column: $table.apartment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fixedRate => $composableBuilder(
    column: $table.fixedRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MainMetersTableOrderingComposer get mainMeterId {
    final $$MainMetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableOrderingComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TenantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get apartment =>
      $composableBuilder(column: $table.apartment, builder: (column) => column);

  GeneratedColumn<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fixedRate =>
      $composableBuilder(column: $table.fixedRate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MainMetersTableAnnotationComposer get mainMeterId {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> meterReadingsRefs<T extends Object>(
    Expression<T> Function($$MeterReadingsTableAnnotationComposer a) f,
  ) {
    final $$MeterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meterReadings,
      getReferencedColumn: (t) => t.tenantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantsTable,
          Tenant,
          $$TenantsTableFilterComposer,
          $$TenantsTableOrderingComposer,
          $$TenantsTableAnnotationComposer,
          $$TenantsTableCreateCompanionBuilder,
          $$TenantsTableUpdateCompanionBuilder,
          (Tenant, $$TenantsTableReferences),
          Tenant,
          PrefetchHooks Function({bool mainMeterId, bool meterReadingsRefs})
        > {
  $$TenantsTableTableManager(_$AppDatabase db, $TenantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mainMeterId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> apartment = const Value.absent(),
                Value<String?> meterNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> billingMode = const Value.absent(),
                Value<double?> fixedRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TenantsCompanion(
                id: id,
                mainMeterId: mainMeterId,
                name: name,
                phone: phone,
                email: email,
                apartment: apartment,
                meterNumber: meterNumber,
                status: status,
                billingMode: billingMode,
                fixedRate: fixedRate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mainMeterId,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> apartment = const Value.absent(),
                Value<String?> meterNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> billingMode = const Value.absent(),
                Value<double?> fixedRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TenantsCompanion.insert(
                id: id,
                mainMeterId: mainMeterId,
                name: name,
                phone: phone,
                email: email,
                apartment: apartment,
                meterNumber: meterNumber,
                status: status,
                billingMode: billingMode,
                fixedRate: fixedRate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TenantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mainMeterId = false, meterReadingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (meterReadingsRefs) db.meterReadings,
                  ],
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
                        if (mainMeterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mainMeterId,
                                    referencedTable: $$TenantsTableReferences
                                        ._mainMeterIdTable(db),
                                    referencedColumn: $$TenantsTableReferences
                                        ._mainMeterIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (meterReadingsRefs)
                        await $_getPrefetchedData<
                          Tenant,
                          $TenantsTable,
                          MeterReading
                        >(
                          currentTable: table,
                          referencedTable: $$TenantsTableReferences
                              ._meterReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenantsTableReferences(
                                db,
                                table,
                                p0,
                              ).meterReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TenantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantsTable,
      Tenant,
      $$TenantsTableFilterComposer,
      $$TenantsTableOrderingComposer,
      $$TenantsTableAnnotationComposer,
      $$TenantsTableCreateCompanionBuilder,
      $$TenantsTableUpdateCompanionBuilder,
      (Tenant, $$TenantsTableReferences),
      Tenant,
      PrefetchHooks Function({bool mainMeterId, bool meterReadingsRefs})
    >;
typedef $$MeterReadingsTableCreateCompanionBuilder =
    MeterReadingsCompanion Function({
      Value<int> id,
      Value<int?> mainMeterId,
      Value<int?> tenantId,
      required DateTime readingDate,
      required double readingValue,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
    });
typedef $$MeterReadingsTableUpdateCompanionBuilder =
    MeterReadingsCompanion Function({
      Value<int> id,
      Value<int?> mainMeterId,
      Value<int?> tenantId,
      Value<DateTime> readingDate,
      Value<double> readingValue,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
    });

final class $$MeterReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $MeterReadingsTable, MeterReading> {
  $$MeterReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MainMetersTable _mainMeterIdTable(_$AppDatabase db) => db.mainMeters
      .createAlias('meter_readings__main_meter_id__main_meters__id');

  $$MainMetersTableProcessedTableManager? get mainMeterId {
    final $_column = $_itemColumn<int>('main_meter_id');
    if ($_column == null) return null;
    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainMeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantsTable _tenantIdTable(_$AppDatabase db) =>
      db.tenants.createAlias('meter_readings__tenant_id__tenants__id');

  $$TenantsTableProcessedTableManager? get tenantId {
    final $_column = $_itemColumn<int>('tenant_id');
    if ($_column == null) return null;
    final manager = $$TenantsTableTableManager(
      $_db,
      $_db.tenants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeterReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $MeterReadingsTable> {
  $$MeterReadingsTableFilterComposer({
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

  ColumnFilters<DateTime> get readingDate => $composableBuilder(
    column: $table.readingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get readingValue => $composableBuilder(
    column: $table.readingValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MainMetersTableFilterComposer get mainMeterId {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableFilterComposer get tenantId {
    final $$TenantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableFilterComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeterReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeterReadingsTable> {
  $$MeterReadingsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get readingDate => $composableBuilder(
    column: $table.readingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get readingValue => $composableBuilder(
    column: $table.readingValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MainMetersTableOrderingComposer get mainMeterId {
    final $$MainMetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableOrderingComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableOrderingComposer get tenantId {
    final $$TenantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableOrderingComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeterReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeterReadingsTable> {
  $$MeterReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get readingDate => $composableBuilder(
    column: $table.readingDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get readingValue => $composableBuilder(
    column: $table.readingValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MainMetersTableAnnotationComposer get mainMeterId {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableAnnotationComposer get tenantId {
    final $$TenantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableAnnotationComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeterReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeterReadingsTable,
          MeterReading,
          $$MeterReadingsTableFilterComposer,
          $$MeterReadingsTableOrderingComposer,
          $$MeterReadingsTableAnnotationComposer,
          $$MeterReadingsTableCreateCompanionBuilder,
          $$MeterReadingsTableUpdateCompanionBuilder,
          (MeterReading, $$MeterReadingsTableReferences),
          MeterReading,
          PrefetchHooks Function({bool mainMeterId, bool tenantId})
        > {
  $$MeterReadingsTableTableManager(_$AppDatabase db, $MeterReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeterReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeterReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeterReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> mainMeterId = const Value.absent(),
                Value<int?> tenantId = const Value.absent(),
                Value<DateTime> readingDate = const Value.absent(),
                Value<double> readingValue = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MeterReadingsCompanion(
                id: id,
                mainMeterId: mainMeterId,
                tenantId: tenantId,
                readingDate: readingDate,
                readingValue: readingValue,
                notes: notes,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> mainMeterId = const Value.absent(),
                Value<int?> tenantId = const Value.absent(),
                required DateTime readingDate,
                required double readingValue,
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MeterReadingsCompanion.insert(
                id: id,
                mainMeterId: mainMeterId,
                tenantId: tenantId,
                readingDate: readingDate,
                readingValue: readingValue,
                notes: notes,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeterReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mainMeterId = false, tenantId = false}) {
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
                    if (mainMeterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mainMeterId,
                                referencedTable: $$MeterReadingsTableReferences
                                    ._mainMeterIdTable(db),
                                referencedColumn: $$MeterReadingsTableReferences
                                    ._mainMeterIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tenantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tenantId,
                                referencedTable: $$MeterReadingsTableReferences
                                    ._tenantIdTable(db),
                                referencedColumn: $$MeterReadingsTableReferences
                                    ._tenantIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$MeterReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeterReadingsTable,
      MeterReading,
      $$MeterReadingsTableFilterComposer,
      $$MeterReadingsTableOrderingComposer,
      $$MeterReadingsTableAnnotationComposer,
      $$MeterReadingsTableCreateCompanionBuilder,
      $$MeterReadingsTableUpdateCompanionBuilder,
      (MeterReading, $$MeterReadingsTableReferences),
      MeterReading,
      PrefetchHooks Function({bool mainMeterId, bool tenantId})
    >;
typedef $$RechargesTableCreateCompanionBuilder =
    RechargesCompanion Function({
      Value<int> id,
      required int mainMeterId,
      required DateTime rechargeDate,
      required double amount,
      Value<double> energyCost,
      Value<double> demandCharge,
      Value<double> meterRent,
      Value<double> vat,
      Value<double> rebate,
      Value<double> agentFee,
      Value<double> otherExpenses,
      Value<String?> paidBy,
      Value<String?> tokenNumber,
      Value<String?> notes,
      Value<String?> receiptPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RechargesTableUpdateCompanionBuilder =
    RechargesCompanion Function({
      Value<int> id,
      Value<int> mainMeterId,
      Value<DateTime> rechargeDate,
      Value<double> amount,
      Value<double> energyCost,
      Value<double> demandCharge,
      Value<double> meterRent,
      Value<double> vat,
      Value<double> rebate,
      Value<double> agentFee,
      Value<double> otherExpenses,
      Value<String?> paidBy,
      Value<String?> tokenNumber,
      Value<String?> notes,
      Value<String?> receiptPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RechargesTableReferences
    extends BaseReferences<_$AppDatabase, $RechargesTable, Recharge> {
  $$RechargesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MainMetersTable _mainMeterIdTable(_$AppDatabase db) =>
      db.mainMeters.createAlias('recharges__main_meter_id__main_meters__id');

  $$MainMetersTableProcessedTableManager get mainMeterId {
    final $_column = $_itemColumn<int>('main_meter_id')!;

    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainMeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RechargesTableFilterComposer
    extends Composer<_$AppDatabase, $RechargesTable> {
  $$RechargesTableFilterComposer({
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

  ColumnFilters<DateTime> get rechargeDate => $composableBuilder(
    column: $table.rechargeDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get energyCost => $composableBuilder(
    column: $table.energyCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get demandCharge => $composableBuilder(
    column: $table.demandCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterRent => $composableBuilder(
    column: $table.meterRent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vat => $composableBuilder(
    column: $table.vat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rebate => $composableBuilder(
    column: $table.rebate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get agentFee => $composableBuilder(
    column: $table.agentFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherExpenses => $composableBuilder(
    column: $table.otherExpenses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidBy => $composableBuilder(
    column: $table.paidBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MainMetersTableFilterComposer get mainMeterId {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RechargesTableOrderingComposer
    extends Composer<_$AppDatabase, $RechargesTable> {
  $$RechargesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get rechargeDate => $composableBuilder(
    column: $table.rechargeDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get energyCost => $composableBuilder(
    column: $table.energyCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get demandCharge => $composableBuilder(
    column: $table.demandCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterRent => $composableBuilder(
    column: $table.meterRent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vat => $composableBuilder(
    column: $table.vat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rebate => $composableBuilder(
    column: $table.rebate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get agentFee => $composableBuilder(
    column: $table.agentFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherExpenses => $composableBuilder(
    column: $table.otherExpenses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidBy => $composableBuilder(
    column: $table.paidBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MainMetersTableOrderingComposer get mainMeterId {
    final $$MainMetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableOrderingComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RechargesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RechargesTable> {
  $$RechargesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get rechargeDate => $composableBuilder(
    column: $table.rechargeDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get energyCost => $composableBuilder(
    column: $table.energyCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get demandCharge => $composableBuilder(
    column: $table.demandCharge,
    builder: (column) => column,
  );

  GeneratedColumn<double> get meterRent =>
      $composableBuilder(column: $table.meterRent, builder: (column) => column);

  GeneratedColumn<double> get vat =>
      $composableBuilder(column: $table.vat, builder: (column) => column);

  GeneratedColumn<double> get rebate =>
      $composableBuilder(column: $table.rebate, builder: (column) => column);

  GeneratedColumn<double> get agentFee =>
      $composableBuilder(column: $table.agentFee, builder: (column) => column);

  GeneratedColumn<double> get otherExpenses => $composableBuilder(
    column: $table.otherExpenses,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paidBy =>
      $composableBuilder(column: $table.paidBy, builder: (column) => column);

  GeneratedColumn<String> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MainMetersTableAnnotationComposer get mainMeterId {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RechargesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RechargesTable,
          Recharge,
          $$RechargesTableFilterComposer,
          $$RechargesTableOrderingComposer,
          $$RechargesTableAnnotationComposer,
          $$RechargesTableCreateCompanionBuilder,
          $$RechargesTableUpdateCompanionBuilder,
          (Recharge, $$RechargesTableReferences),
          Recharge,
          PrefetchHooks Function({bool mainMeterId})
        > {
  $$RechargesTableTableManager(_$AppDatabase db, $RechargesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RechargesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RechargesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RechargesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mainMeterId = const Value.absent(),
                Value<DateTime> rechargeDate = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> energyCost = const Value.absent(),
                Value<double> demandCharge = const Value.absent(),
                Value<double> meterRent = const Value.absent(),
                Value<double> vat = const Value.absent(),
                Value<double> rebate = const Value.absent(),
                Value<double> agentFee = const Value.absent(),
                Value<double> otherExpenses = const Value.absent(),
                Value<String?> paidBy = const Value.absent(),
                Value<String?> tokenNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RechargesCompanion(
                id: id,
                mainMeterId: mainMeterId,
                rechargeDate: rechargeDate,
                amount: amount,
                energyCost: energyCost,
                demandCharge: demandCharge,
                meterRent: meterRent,
                vat: vat,
                rebate: rebate,
                agentFee: agentFee,
                otherExpenses: otherExpenses,
                paidBy: paidBy,
                tokenNumber: tokenNumber,
                notes: notes,
                receiptPath: receiptPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mainMeterId,
                required DateTime rechargeDate,
                required double amount,
                Value<double> energyCost = const Value.absent(),
                Value<double> demandCharge = const Value.absent(),
                Value<double> meterRent = const Value.absent(),
                Value<double> vat = const Value.absent(),
                Value<double> rebate = const Value.absent(),
                Value<double> agentFee = const Value.absent(),
                Value<double> otherExpenses = const Value.absent(),
                Value<String?> paidBy = const Value.absent(),
                Value<String?> tokenNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RechargesCompanion.insert(
                id: id,
                mainMeterId: mainMeterId,
                rechargeDate: rechargeDate,
                amount: amount,
                energyCost: energyCost,
                demandCharge: demandCharge,
                meterRent: meterRent,
                vat: vat,
                rebate: rebate,
                agentFee: agentFee,
                otherExpenses: otherExpenses,
                paidBy: paidBy,
                tokenNumber: tokenNumber,
                notes: notes,
                receiptPath: receiptPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RechargesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mainMeterId = false}) {
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
                    if (mainMeterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mainMeterId,
                                referencedTable: $$RechargesTableReferences
                                    ._mainMeterIdTable(db),
                                referencedColumn: $$RechargesTableReferences
                                    ._mainMeterIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$RechargesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RechargesTable,
      Recharge,
      $$RechargesTableFilterComposer,
      $$RechargesTableOrderingComposer,
      $$RechargesTableAnnotationComposer,
      $$RechargesTableCreateCompanionBuilder,
      $$RechargesTableUpdateCompanionBuilder,
      (Recharge, $$RechargesTableReferences),
      Recharge,
      PrefetchHooks Function({bool mainMeterId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> multiTenant,
      Value<bool> fixedRate,
      Value<double> fixedUnitPrice,
      Value<String> fixedChargeDistribution,
      Value<String> billingCalcMode,
      Value<String> languageCode,
      Value<String> themeMode,
      Value<String> invoiceLanguage,
      Value<String> appRole,
      Value<String?> meterCode,
      Value<String?> joinedMeterCode,
      Value<String?> tenantName,
      Value<bool> tenantApproved,
      Value<bool> onboarded,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> multiTenant,
      Value<bool> fixedRate,
      Value<double> fixedUnitPrice,
      Value<String> fixedChargeDistribution,
      Value<String> billingCalcMode,
      Value<String> languageCode,
      Value<String> themeMode,
      Value<String> invoiceLanguage,
      Value<String> appRole,
      Value<String?> meterCode,
      Value<String?> joinedMeterCode,
      Value<String?> tenantName,
      Value<bool> tenantApproved,
      Value<bool> onboarded,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<bool> get multiTenant => $composableBuilder(
    column: $table.multiTenant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fixedRate => $composableBuilder(
    column: $table.fixedRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fixedUnitPrice => $composableBuilder(
    column: $table.fixedUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fixedChargeDistribution => $composableBuilder(
    column: $table.fixedChargeDistribution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCalcMode => $composableBuilder(
    column: $table.billingCalcMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceLanguage => $composableBuilder(
    column: $table.invoiceLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appRole => $composableBuilder(
    column: $table.appRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterCode => $composableBuilder(
    column: $table.meterCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get joinedMeterCode => $composableBuilder(
    column: $table.joinedMeterCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tenantApproved => $composableBuilder(
    column: $table.tenantApproved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<bool> get multiTenant => $composableBuilder(
    column: $table.multiTenant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fixedRate => $composableBuilder(
    column: $table.fixedRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fixedUnitPrice => $composableBuilder(
    column: $table.fixedUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fixedChargeDistribution => $composableBuilder(
    column: $table.fixedChargeDistribution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCalcMode => $composableBuilder(
    column: $table.billingCalcMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceLanguage => $composableBuilder(
    column: $table.invoiceLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appRole => $composableBuilder(
    column: $table.appRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterCode => $composableBuilder(
    column: $table.meterCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get joinedMeterCode => $composableBuilder(
    column: $table.joinedMeterCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tenantApproved => $composableBuilder(
    column: $table.tenantApproved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get multiTenant => $composableBuilder(
    column: $table.multiTenant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get fixedRate =>
      $composableBuilder(column: $table.fixedRate, builder: (column) => column);

  GeneratedColumn<double> get fixedUnitPrice => $composableBuilder(
    column: $table.fixedUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fixedChargeDistribution => $composableBuilder(
    column: $table.fixedChargeDistribution,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingCalcMode => $composableBuilder(
    column: $table.billingCalcMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get invoiceLanguage => $composableBuilder(
    column: $table.invoiceLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appRole =>
      $composableBuilder(column: $table.appRole, builder: (column) => column);

  GeneratedColumn<String> get meterCode =>
      $composableBuilder(column: $table.meterCode, builder: (column) => column);

  GeneratedColumn<String> get joinedMeterCode => $composableBuilder(
    column: $table.joinedMeterCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tenantName => $composableBuilder(
    column: $table.tenantName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get tenantApproved => $composableBuilder(
    column: $table.tenantApproved,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboarded =>
      $composableBuilder(column: $table.onboarded, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> multiTenant = const Value.absent(),
                Value<bool> fixedRate = const Value.absent(),
                Value<double> fixedUnitPrice = const Value.absent(),
                Value<String> fixedChargeDistribution = const Value.absent(),
                Value<String> billingCalcMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> invoiceLanguage = const Value.absent(),
                Value<String> appRole = const Value.absent(),
                Value<String?> meterCode = const Value.absent(),
                Value<String?> joinedMeterCode = const Value.absent(),
                Value<String?> tenantName = const Value.absent(),
                Value<bool> tenantApproved = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                multiTenant: multiTenant,
                fixedRate: fixedRate,
                fixedUnitPrice: fixedUnitPrice,
                fixedChargeDistribution: fixedChargeDistribution,
                billingCalcMode: billingCalcMode,
                languageCode: languageCode,
                themeMode: themeMode,
                invoiceLanguage: invoiceLanguage,
                appRole: appRole,
                meterCode: meterCode,
                joinedMeterCode: joinedMeterCode,
                tenantName: tenantName,
                tenantApproved: tenantApproved,
                onboarded: onboarded,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> multiTenant = const Value.absent(),
                Value<bool> fixedRate = const Value.absent(),
                Value<double> fixedUnitPrice = const Value.absent(),
                Value<String> fixedChargeDistribution = const Value.absent(),
                Value<String> billingCalcMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> invoiceLanguage = const Value.absent(),
                Value<String> appRole = const Value.absent(),
                Value<String?> meterCode = const Value.absent(),
                Value<String?> joinedMeterCode = const Value.absent(),
                Value<String?> tenantName = const Value.absent(),
                Value<bool> tenantApproved = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                multiTenant: multiTenant,
                fixedRate: fixedRate,
                fixedUnitPrice: fixedUnitPrice,
                fixedChargeDistribution: fixedChargeDistribution,
                billingCalcMode: billingCalcMode,
                languageCode: languageCode,
                themeMode: themeMode,
                invoiceLanguage: invoiceLanguage,
                appRole: appRole,
                meterCode: meterCode,
                joinedMeterCode: joinedMeterCode,
                tenantName: tenantName,
                tenantApproved: tenantApproved,
                onboarded: onboarded,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$BillPaymentsTableCreateCompanionBuilder =
    BillPaymentsCompanion Function({
      Value<int> id,
      required int tenantId,
      required String monthKey,
      Value<DateTime> paidAt,
    });
typedef $$BillPaymentsTableUpdateCompanionBuilder =
    BillPaymentsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> monthKey,
      Value<DateTime> paidAt,
    });

class $$BillPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);
}

class $$BillPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillPaymentsTable,
          BillPayment,
          $$BillPaymentsTableFilterComposer,
          $$BillPaymentsTableOrderingComposer,
          $$BillPaymentsTableAnnotationComposer,
          $$BillPaymentsTableCreateCompanionBuilder,
          $$BillPaymentsTableUpdateCompanionBuilder,
          (
            BillPayment,
            BaseReferences<_$AppDatabase, $BillPaymentsTable, BillPayment>,
          ),
          BillPayment,
          PrefetchHooks Function()
        > {
  $$BillPaymentsTableTableManager(_$AppDatabase db, $BillPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
              }) => BillPaymentsCompanion(
                id: id,
                tenantId: tenantId,
                monthKey: monthKey,
                paidAt: paidAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tenantId,
                required String monthKey,
                Value<DateTime> paidAt = const Value.absent(),
              }) => BillPaymentsCompanion.insert(
                id: id,
                tenantId: tenantId,
                monthKey: monthKey,
                paidAt: paidAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillPaymentsTable,
      BillPayment,
      $$BillPaymentsTableFilterComposer,
      $$BillPaymentsTableOrderingComposer,
      $$BillPaymentsTableAnnotationComposer,
      $$BillPaymentsTableCreateCompanionBuilder,
      $$BillPaymentsTableUpdateCompanionBuilder,
      (
        BillPayment,
        BaseReferences<_$AppDatabase, $BillPaymentsTable, BillPayment>,
      ),
      BillPayment,
      PrefetchHooks Function()
    >;
typedef $$TariffVersionsTableCreateCompanionBuilder =
    TariffVersionsCompanion Function({
      Value<int> id,
      required String label,
      required DateTime effectiveFrom,
      required String tariffJson,
      Value<bool> archived,
      Value<DateTime> createdAt,
    });
typedef $$TariffVersionsTableUpdateCompanionBuilder =
    TariffVersionsCompanion Function({
      Value<int> id,
      Value<String> label,
      Value<DateTime> effectiveFrom,
      Value<String> tariffJson,
      Value<bool> archived,
      Value<DateTime> createdAt,
    });

class $$TariffVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $TariffVersionsTable> {
  $$TariffVersionsTableFilterComposer({
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

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tariffJson => $composableBuilder(
    column: $table.tariffJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TariffVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TariffVersionsTable> {
  $$TariffVersionsTableOrderingComposer({
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

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tariffJson => $composableBuilder(
    column: $table.tariffJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TariffVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TariffVersionsTable> {
  $$TariffVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tariffJson => $composableBuilder(
    column: $table.tariffJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TariffVersionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TariffVersionsTable,
          TariffVersion,
          $$TariffVersionsTableFilterComposer,
          $$TariffVersionsTableOrderingComposer,
          $$TariffVersionsTableAnnotationComposer,
          $$TariffVersionsTableCreateCompanionBuilder,
          $$TariffVersionsTableUpdateCompanionBuilder,
          (
            TariffVersion,
            BaseReferences<_$AppDatabase, $TariffVersionsTable, TariffVersion>,
          ),
          TariffVersion,
          PrefetchHooks Function()
        > {
  $$TariffVersionsTableTableManager(
    _$AppDatabase db,
    $TariffVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TariffVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TariffVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TariffVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
                Value<String> tariffJson = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TariffVersionsCompanion(
                id: id,
                label: label,
                effectiveFrom: effectiveFrom,
                tariffJson: tariffJson,
                archived: archived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                required DateTime effectiveFrom,
                required String tariffJson,
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TariffVersionsCompanion.insert(
                id: id,
                label: label,
                effectiveFrom: effectiveFrom,
                tariffJson: tariffJson,
                archived: archived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TariffVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TariffVersionsTable,
      TariffVersion,
      $$TariffVersionsTableFilterComposer,
      $$TariffVersionsTableOrderingComposer,
      $$TariffVersionsTableAnnotationComposer,
      $$TariffVersionsTableCreateCompanionBuilder,
      $$TariffVersionsTableUpdateCompanionBuilder,
      (
        TariffVersion,
        BaseReferences<_$AppDatabase, $TariffVersionsTable, TariffVersion>,
      ),
      TariffVersion,
      PrefetchHooks Function()
    >;
typedef $$BillingPeriodsTableCreateCompanionBuilder =
    BillingPeriodsCompanion Function({
      Value<int> id,
      required int propertyId,
      required int year,
      required int month,
      Value<String> status,
      Value<DateTime?> finalizedAt,
      Value<String?> finalizedBy,
      Value<int?> tariffVersionId,
      Value<String?> billingMethodSnapshot,
      Value<String?> currencySnapshot,
      Value<String?> calculationSnapshot,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BillingPeriodsTableUpdateCompanionBuilder =
    BillingPeriodsCompanion Function({
      Value<int> id,
      Value<int> propertyId,
      Value<int> year,
      Value<int> month,
      Value<String> status,
      Value<DateTime?> finalizedAt,
      Value<String?> finalizedBy,
      Value<int?> tariffVersionId,
      Value<String?> billingMethodSnapshot,
      Value<String?> currencySnapshot,
      Value<String?> calculationSnapshot,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BillingPeriodsTableReferences
    extends BaseReferences<_$AppDatabase, $BillingPeriodsTable, BillingPeriod> {
  $$BillingPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('billing_periods__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<int>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BillingPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $BillingPeriodsTable> {
  $$BillingPeriodsTableFilterComposer({
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

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finalizedBy => $composableBuilder(
    column: $table.finalizedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tariffVersionId => $composableBuilder(
    column: $table.tariffVersionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingMethodSnapshot => $composableBuilder(
    column: $table.billingMethodSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySnapshot => $composableBuilder(
    column: $table.currencySnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculationSnapshot => $composableBuilder(
    column: $table.calculationSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillingPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillingPeriodsTable> {
  $$BillingPeriodsTableOrderingComposer({
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

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finalizedBy => $composableBuilder(
    column: $table.finalizedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tariffVersionId => $composableBuilder(
    column: $table.tariffVersionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingMethodSnapshot => $composableBuilder(
    column: $table.billingMethodSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySnapshot => $composableBuilder(
    column: $table.currencySnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculationSnapshot => $composableBuilder(
    column: $table.calculationSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillingPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillingPeriodsTable> {
  $$BillingPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get finalizedBy => $composableBuilder(
    column: $table.finalizedBy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tariffVersionId => $composableBuilder(
    column: $table.tariffVersionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingMethodSnapshot => $composableBuilder(
    column: $table.billingMethodSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySnapshot => $composableBuilder(
    column: $table.currencySnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get calculationSnapshot => $composableBuilder(
    column: $table.calculationSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillingPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillingPeriodsTable,
          BillingPeriod,
          $$BillingPeriodsTableFilterComposer,
          $$BillingPeriodsTableOrderingComposer,
          $$BillingPeriodsTableAnnotationComposer,
          $$BillingPeriodsTableCreateCompanionBuilder,
          $$BillingPeriodsTableUpdateCompanionBuilder,
          (BillingPeriod, $$BillingPeriodsTableReferences),
          BillingPeriod,
          PrefetchHooks Function({bool propertyId})
        > {
  $$BillingPeriodsTableTableManager(
    _$AppDatabase db,
    $BillingPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillingPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> propertyId = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<String?> finalizedBy = const Value.absent(),
                Value<int?> tariffVersionId = const Value.absent(),
                Value<String?> billingMethodSnapshot = const Value.absent(),
                Value<String?> currencySnapshot = const Value.absent(),
                Value<String?> calculationSnapshot = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BillingPeriodsCompanion(
                id: id,
                propertyId: propertyId,
                year: year,
                month: month,
                status: status,
                finalizedAt: finalizedAt,
                finalizedBy: finalizedBy,
                tariffVersionId: tariffVersionId,
                billingMethodSnapshot: billingMethodSnapshot,
                currencySnapshot: currencySnapshot,
                calculationSnapshot: calculationSnapshot,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int propertyId,
                required int year,
                required int month,
                Value<String> status = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<String?> finalizedBy = const Value.absent(),
                Value<int?> tariffVersionId = const Value.absent(),
                Value<String?> billingMethodSnapshot = const Value.absent(),
                Value<String?> currencySnapshot = const Value.absent(),
                Value<String?> calculationSnapshot = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BillingPeriodsCompanion.insert(
                id: id,
                propertyId: propertyId,
                year: year,
                month: month,
                status: status,
                finalizedAt: finalizedAt,
                finalizedBy: finalizedBy,
                tariffVersionId: tariffVersionId,
                billingMethodSnapshot: billingMethodSnapshot,
                currencySnapshot: currencySnapshot,
                calculationSnapshot: calculationSnapshot,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BillingPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({propertyId = false}) {
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
                    if (propertyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.propertyId,
                                referencedTable: $$BillingPeriodsTableReferences
                                    ._propertyIdTable(db),
                                referencedColumn:
                                    $$BillingPeriodsTableReferences
                                        ._propertyIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$BillingPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillingPeriodsTable,
      BillingPeriod,
      $$BillingPeriodsTableFilterComposer,
      $$BillingPeriodsTableOrderingComposer,
      $$BillingPeriodsTableAnnotationComposer,
      $$BillingPeriodsTableCreateCompanionBuilder,
      $$BillingPeriodsTableUpdateCompanionBuilder,
      (BillingPeriod, $$BillingPeriodsTableReferences),
      BillingPeriod,
      PrefetchHooks Function({bool propertyId})
    >;
typedef $$SettlementsTableCreateCompanionBuilder =
    SettlementsCompanion Function({
      Value<int> id,
      required int mainMeterId,
      required DateTime settlementDate,
      required int fromTenantId,
      required int toTenantId,
      required double amount,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$SettlementsTableUpdateCompanionBuilder =
    SettlementsCompanion Function({
      Value<int> id,
      Value<int> mainMeterId,
      Value<DateTime> settlementDate,
      Value<int> fromTenantId,
      Value<int> toTenantId,
      Value<double> amount,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$SettlementsTableReferences
    extends BaseReferences<_$AppDatabase, $SettlementsTable, Settlement> {
  $$SettlementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MainMetersTable _mainMeterIdTable(_$AppDatabase db) =>
      db.mainMeters.createAlias('settlements__main_meter_id__main_meters__id');

  $$MainMetersTableProcessedTableManager get mainMeterId {
    final $_column = $_itemColumn<int>('main_meter_id')!;

    final manager = $$MainMetersTableTableManager(
      $_db,
      $_db.mainMeters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainMeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantsTable _fromTenantIdTable(_$AppDatabase db) =>
      db.tenants.createAlias('settlements__from_tenant_id__tenants__id');

  $$TenantsTableProcessedTableManager get fromTenantId {
    final $_column = $_itemColumn<int>('from_tenant_id')!;

    final manager = $$TenantsTableTableManager(
      $_db,
      $_db.tenants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromTenantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantsTable _toTenantIdTable(_$AppDatabase db) =>
      db.tenants.createAlias('settlements__to_tenant_id__tenants__id');

  $$TenantsTableProcessedTableManager get toTenantId {
    final $_column = $_itemColumn<int>('to_tenant_id')!;

    final manager = $$TenantsTableTableManager(
      $_db,
      $_db.tenants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toTenantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SettlementsTableFilterComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableFilterComposer({
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

  ColumnFilters<DateTime> get settlementDate => $composableBuilder(
    column: $table.settlementDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MainMetersTableFilterComposer get mainMeterId {
    final $$MainMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableFilterComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableFilterComposer get fromTenantId {
    final $$TenantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableFilterComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableFilterComposer get toTenantId {
    final $$TenantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableFilterComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettlementsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get settlementDate => $composableBuilder(
    column: $table.settlementDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MainMetersTableOrderingComposer get mainMeterId {
    final $$MainMetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableOrderingComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableOrderingComposer get fromTenantId {
    final $$TenantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableOrderingComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableOrderingComposer get toTenantId {
    final $$TenantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableOrderingComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettlementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get settlementDate => $composableBuilder(
    column: $table.settlementDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MainMetersTableAnnotationComposer get mainMeterId {
    final $$MainMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainMeterId,
      referencedTable: $db.mainMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MainMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.mainMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableAnnotationComposer get fromTenantId {
    final $$TenantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableAnnotationComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantsTableAnnotationComposer get toTenantId {
    final $$TenantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toTenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableAnnotationComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettlementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettlementsTable,
          Settlement,
          $$SettlementsTableFilterComposer,
          $$SettlementsTableOrderingComposer,
          $$SettlementsTableAnnotationComposer,
          $$SettlementsTableCreateCompanionBuilder,
          $$SettlementsTableUpdateCompanionBuilder,
          (Settlement, $$SettlementsTableReferences),
          Settlement,
          PrefetchHooks Function({
            bool mainMeterId,
            bool fromTenantId,
            bool toTenantId,
          })
        > {
  $$SettlementsTableTableManager(_$AppDatabase db, $SettlementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettlementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettlementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettlementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mainMeterId = const Value.absent(),
                Value<DateTime> settlementDate = const Value.absent(),
                Value<int> fromTenantId = const Value.absent(),
                Value<int> toTenantId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SettlementsCompanion(
                id: id,
                mainMeterId: mainMeterId,
                settlementDate: settlementDate,
                fromTenantId: fromTenantId,
                toTenantId: toTenantId,
                amount: amount,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mainMeterId,
                required DateTime settlementDate,
                required int fromTenantId,
                required int toTenantId,
                required double amount,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SettlementsCompanion.insert(
                id: id,
                mainMeterId: mainMeterId,
                settlementDate: settlementDate,
                fromTenantId: fromTenantId,
                toTenantId: toTenantId,
                amount: amount,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SettlementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mainMeterId = false,
                fromTenantId = false,
                toTenantId = false,
              }) {
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
                        if (mainMeterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mainMeterId,
                                    referencedTable:
                                        $$SettlementsTableReferences
                                            ._mainMeterIdTable(db),
                                    referencedColumn:
                                        $$SettlementsTableReferences
                                            ._mainMeterIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (fromTenantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromTenantId,
                                    referencedTable:
                                        $$SettlementsTableReferences
                                            ._fromTenantIdTable(db),
                                    referencedColumn:
                                        $$SettlementsTableReferences
                                            ._fromTenantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (toTenantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toTenantId,
                                    referencedTable:
                                        $$SettlementsTableReferences
                                            ._toTenantIdTable(db),
                                    referencedColumn:
                                        $$SettlementsTableReferences
                                            ._toTenantIdTable(db)
                                            .id,
                                  )
                                  as T;
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

typedef $$SettlementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettlementsTable,
      Settlement,
      $$SettlementsTableFilterComposer,
      $$SettlementsTableOrderingComposer,
      $$SettlementsTableAnnotationComposer,
      $$SettlementsTableCreateCompanionBuilder,
      $$SettlementsTableUpdateCompanionBuilder,
      (Settlement, $$SettlementsTableReferences),
      Settlement,
      PrefetchHooks Function({
        bool mainMeterId,
        bool fromTenantId,
        bool toTenantId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
  $$ElectricityProvidersTableTableManager get electricityProviders =>
      $$ElectricityProvidersTableTableManager(_db, _db.electricityProviders);
  $$TariffSlabsTableTableManager get tariffSlabs =>
      $$TariffSlabsTableTableManager(_db, _db.tariffSlabs);
  $$MainMetersTableTableManager get mainMeters =>
      $$MainMetersTableTableManager(_db, _db.mainMeters);
  $$TenantsTableTableManager get tenants =>
      $$TenantsTableTableManager(_db, _db.tenants);
  $$MeterReadingsTableTableManager get meterReadings =>
      $$MeterReadingsTableTableManager(_db, _db.meterReadings);
  $$RechargesTableTableManager get recharges =>
      $$RechargesTableTableManager(_db, _db.recharges);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$BillPaymentsTableTableManager get billPayments =>
      $$BillPaymentsTableTableManager(_db, _db.billPayments);
  $$TariffVersionsTableTableManager get tariffVersions =>
      $$TariffVersionsTableTableManager(_db, _db.tariffVersions);
  $$BillingPeriodsTableTableManager get billingPeriods =>
      $$BillingPeriodsTableTableManager(_db, _db.billingPeriods);
  $$SettlementsTableTableManager get settlements =>
      $$SettlementsTableTableManager(_db, _db.settlements);
}
