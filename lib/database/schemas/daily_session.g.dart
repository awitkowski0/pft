// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailySessionCollection on Isar {
  IsarCollection<DailySession> get dailySessions => this.collection();
}

const DailySessionSchema = CollectionSchema(
  name: r'DailySession',
  id: 4402697227032325870,
  properties: {
    r'completedExerciseIds': PropertySchema(
      id: 0,
      name: r'completedExerciseIds',
      type: IsarType.stringList,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 2,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isWeatherSkip': PropertySchema(
      id: 3,
      name: r'isWeatherSkip',
      type: IsarType.bool,
    ),
    r'performanceMetrics': PropertySchema(
      id: 4,
      name: r'performanceMetrics',
      type: IsarType.string,
    ),
    r'userNotes': PropertySchema(
      id: 5,
      name: r'userNotes',
      type: IsarType.string,
    )
  },
  estimateSize: _dailySessionEstimateSize,
  serialize: _dailySessionSerialize,
  deserialize: _dailySessionDeserialize,
  deserializeProp: _dailySessionDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dailySessionGetId,
  getLinks: _dailySessionGetLinks,
  attach: _dailySessionAttach,
  version: '3.1.0+1',
);

int _dailySessionEstimateSize(
  DailySession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.completedExerciseIds.length * 3;
  {
    for (var i = 0; i < object.completedExerciseIds.length; i++) {
      final value = object.completedExerciseIds[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.performanceMetrics.length * 3;
  {
    final value = object.userNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dailySessionSerialize(
  DailySession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.completedExerciseIds);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeBool(offsets[2], object.isCompleted);
  writer.writeBool(offsets[3], object.isWeatherSkip);
  writer.writeString(offsets[4], object.performanceMetrics);
  writer.writeString(offsets[5], object.userNotes);
}

DailySession _dailySessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailySession();
  object.completedExerciseIds = reader.readStringList(offsets[0]) ?? [];
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[2]);
  object.isWeatherSkip = reader.readBool(offsets[3]);
  object.performanceMetrics = reader.readString(offsets[4]);
  object.userNotes = reader.readStringOrNull(offsets[5]);
  return object;
}

P _dailySessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailySessionGetId(DailySession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailySessionGetLinks(DailySession object) {
  return [];
}

void _dailySessionAttach(
    IsarCollection<dynamic> col, Id id, DailySession object) {
  object.id = id;
}

extension DailySessionByIndex on IsarCollection<DailySession> {
  Future<DailySession?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailySession? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailySession?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailySession?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(DailySession object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailySession object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailySession> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<DailySession> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailySessionQueryWhereSort
    on QueryBuilder<DailySession, DailySession, QWhere> {
  QueryBuilder<DailySession, DailySession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailySessionQueryWhere
    on QueryBuilder<DailySession, DailySession, QWhereClause> {
  QueryBuilder<DailySession, DailySession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailySessionQueryFilter
    on QueryBuilder<DailySession, DailySession, QFilterCondition> {
  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedExerciseIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'completedExerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'completedExerciseIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedExerciseIds',
        value: '',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'completedExerciseIds',
        value: '',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      completedExerciseIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedExerciseIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      isWeatherSkipEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isWeatherSkip',
        value: value,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'performanceMetrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'performanceMetrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'performanceMetrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'performanceMetrics',
        value: '',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      performanceMetricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'performanceMetrics',
        value: '',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userNotes',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userNotes',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterFilterCondition>
      userNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userNotes',
        value: '',
      ));
    });
  }
}

extension DailySessionQueryObject
    on QueryBuilder<DailySession, DailySession, QFilterCondition> {}

extension DailySessionQueryLinks
    on QueryBuilder<DailySession, DailySession, QFilterCondition> {}

extension DailySessionQuerySortBy
    on QueryBuilder<DailySession, DailySession, QSortBy> {
  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByIsWeatherSkip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeatherSkip', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      sortByIsWeatherSkipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeatherSkip', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      sortByPerformanceMetrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceMetrics', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      sortByPerformanceMetricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceMetrics', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByUserNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> sortByUserNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.desc);
    });
  }
}

extension DailySessionQuerySortThenBy
    on QueryBuilder<DailySession, DailySession, QSortThenBy> {
  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByIsWeatherSkip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeatherSkip', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      thenByIsWeatherSkipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeatherSkip', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      thenByPerformanceMetrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceMetrics', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy>
      thenByPerformanceMetricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceMetrics', Sort.desc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByUserNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.asc);
    });
  }

  QueryBuilder<DailySession, DailySession, QAfterSortBy> thenByUserNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.desc);
    });
  }
}

extension DailySessionQueryWhereDistinct
    on QueryBuilder<DailySession, DailySession, QDistinct> {
  QueryBuilder<DailySession, DailySession, QDistinct>
      distinctByCompletedExerciseIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedExerciseIds');
    });
  }

  QueryBuilder<DailySession, DailySession, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailySession, DailySession, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<DailySession, DailySession, QDistinct>
      distinctByIsWeatherSkip() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isWeatherSkip');
    });
  }

  QueryBuilder<DailySession, DailySession, QDistinct>
      distinctByPerformanceMetrics({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'performanceMetrics',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailySession, DailySession, QDistinct> distinctByUserNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userNotes', caseSensitive: caseSensitive);
    });
  }
}

extension DailySessionQueryProperty
    on QueryBuilder<DailySession, DailySession, QQueryProperty> {
  QueryBuilder<DailySession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailySession, List<String>, QQueryOperations>
      completedExerciseIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedExerciseIds');
    });
  }

  QueryBuilder<DailySession, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailySession, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<DailySession, bool, QQueryOperations> isWeatherSkipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isWeatherSkip');
    });
  }

  QueryBuilder<DailySession, String, QQueryOperations>
      performanceMetricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'performanceMetrics');
    });
  }

  QueryBuilder<DailySession, String?, QQueryOperations> userNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userNotes');
    });
  }
}
