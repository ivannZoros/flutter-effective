// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $DrinksTable extends Drinks with TableInfo<$DrinksTable, DrinkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, slug, imagePath, price, quantity, page];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drinks';
  @override
  VerificationContext validateIntegrity(Insertable<DrinkData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrinkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrinkData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
    );
  }

  @override
  $DrinksTable createAlias(String alias) {
    return $DrinksTable(attachedDatabase, alias);
  }
}

class DrinkData extends DataClass implements Insertable<DrinkData> {
  final int id;
  final String name;
  final String slug;
  final String imagePath;
  final double price;
  final int? quantity;
  final int? page;
  const DrinkData(
      {required this.id,
      required this.name,
      required this.slug,
      required this.imagePath,
      required this.price,
      this.quantity,
      this.page});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['image_path'] = Variable<String>(imagePath);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    return map;
  }

  DrinksCompanion toCompanion(bool nullToAbsent) {
    return DrinksCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      imagePath: Value(imagePath),
      price: Value(price),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
    );
  }

  factory DrinkData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrinkData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      price: serializer.fromJson<double>(json['price']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      page: serializer.fromJson<int?>(json['page']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'imagePath': serializer.toJson<String>(imagePath),
      'price': serializer.toJson<double>(price),
      'quantity': serializer.toJson<int?>(quantity),
      'page': serializer.toJson<int?>(page),
    };
  }

  DrinkData copyWith(
          {int? id,
          String? name,
          String? slug,
          String? imagePath,
          double? price,
          Value<int?> quantity = const Value.absent(),
          Value<int?> page = const Value.absent()}) =>
      DrinkData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        imagePath: imagePath ?? this.imagePath,
        price: price ?? this.price,
        quantity: quantity.present ? quantity.value : this.quantity,
        page: page.present ? page.value : this.page,
      );
  DrinkData copyWithCompanion(DrinksCompanion data) {
    return DrinkData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      price: data.price.present ? data.price.value : this.price,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      page: data.page.present ? data.page.value : this.page,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrinkData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('imagePath: $imagePath, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, slug, imagePath, price, quantity, page);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrinkData &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.imagePath == this.imagePath &&
          other.price == this.price &&
          other.quantity == this.quantity &&
          other.page == this.page);
}

class DrinksCompanion extends UpdateCompanion<DrinkData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String> imagePath;
  final Value<double> price;
  final Value<int?> quantity;
  final Value<int?> page;
  const DrinksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.price = const Value.absent(),
    this.quantity = const Value.absent(),
    this.page = const Value.absent(),
  });
  DrinksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    required String imagePath,
    required double price,
    this.quantity = const Value.absent(),
    this.page = const Value.absent(),
  })  : name = Value(name),
        slug = Value(slug),
        imagePath = Value(imagePath),
        price = Value(price);
  static Insertable<DrinkData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? imagePath,
    Expression<double>? price,
    Expression<int>? quantity,
    Expression<int>? page,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (imagePath != null) 'image_path': imagePath,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (page != null) 'page': page,
    });
  }

  DrinksCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? slug,
      Value<String>? imagePath,
      Value<double>? price,
      Value<int?>? quantity,
      Value<int?>? page}) {
    return DrinksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      page: page ?? this.page,
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
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('imagePath: $imagePath, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $DrinksTable drinks = $DrinksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [drinks];
}

typedef $$DrinksTableCreateCompanionBuilder = DrinksCompanion Function({
  Value<int> id,
  required String name,
  required String slug,
  required String imagePath,
  required double price,
  Value<int?> quantity,
  Value<int?> page,
});
typedef $$DrinksTableUpdateCompanionBuilder = DrinksCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> slug,
  Value<String> imagePath,
  Value<double> price,
  Value<int?> quantity,
  Value<int?> page,
});

class $$DrinksTableFilterComposer extends Composer<_$AppDb, $DrinksTable> {
  $$DrinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnFilters(column));
}

class $$DrinksTableOrderingComposer extends Composer<_$AppDb, $DrinksTable> {
  $$DrinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnOrderings(column));
}

class $$DrinksTableAnnotationComposer extends Composer<_$AppDb, $DrinksTable> {
  $$DrinksTableAnnotationComposer({
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

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);
}

class $$DrinksTableTableManager extends RootTableManager<
    _$AppDb,
    $DrinksTable,
    DrinkData,
    $$DrinksTableFilterComposer,
    $$DrinksTableOrderingComposer,
    $$DrinksTableAnnotationComposer,
    $$DrinksTableCreateCompanionBuilder,
    $$DrinksTableUpdateCompanionBuilder,
    (DrinkData, BaseReferences<_$AppDb, $DrinksTable, DrinkData>),
    DrinkData,
    PrefetchHooks Function()> {
  $$DrinksTableTableManager(_$AppDb db, $DrinksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<int?> quantity = const Value.absent(),
            Value<int?> page = const Value.absent(),
          }) =>
              DrinksCompanion(
            id: id,
            name: name,
            slug: slug,
            imagePath: imagePath,
            price: price,
            quantity: quantity,
            page: page,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String slug,
            required String imagePath,
            required double price,
            Value<int?> quantity = const Value.absent(),
            Value<int?> page = const Value.absent(),
          }) =>
              DrinksCompanion.insert(
            id: id,
            name: name,
            slug: slug,
            imagePath: imagePath,
            price: price,
            quantity: quantity,
            page: page,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DrinksTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $DrinksTable,
    DrinkData,
    $$DrinksTableFilterComposer,
    $$DrinksTableOrderingComposer,
    $$DrinksTableAnnotationComposer,
    $$DrinksTableCreateCompanionBuilder,
    $$DrinksTableUpdateCompanionBuilder,
    (DrinkData, BaseReferences<_$AppDb, $DrinksTable, DrinkData>),
    DrinkData,
    PrefetchHooks Function()>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$DrinksTableTableManager get drinks =>
      $$DrinksTableTableManager(_db, _db.drinks);
}
