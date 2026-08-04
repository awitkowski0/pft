// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserStateCollection on Isar {
  IsarCollection<UserState> get userStates => this.collection();
}

const UserStateSchema = CollectionSchema(
  name: r'UserState',
  id: -3052082333501167064,
  properties: {
    r'aiGeneratedPlan': PropertySchema(
      id: 0,
      name: r'aiGeneratedPlan',
      type: IsarType.string,
    ),
    r'currentProgressIndex': PropertySchema(
      id: 1,
      name: r'currentProgressIndex',
      type: IsarType.long,
    ),
    r'currentStreak': PropertySchema(
      id: 2,
      name: r'currentStreak',
      type: IsarType.long,
    ),
    r'fitnessLevel': PropertySchema(
      id: 3,
      name: r'fitnessLevel',
      type: IsarType.string,
    ),
    r'goals': PropertySchema(
      id: 4,
      name: r'goals',
      type: IsarType.string,
    ),
    r'historicalAILogs': PropertySchema(
      id: 5,
      name: r'historicalAILogs',
      type: IsarType.stringList,
    ),
    r'lastActiveDate': PropertySchema(
      id: 6,
      name: r'lastActiveDate',
      type: IsarType.dateTime,
    ),
    r'lastBriefingDate': PropertySchema(
      id: 7,
      name: r'lastBriefingDate',
      type: IsarType.dateTime,
    ),
    r'lastBriefingText': PropertySchema(
      id: 8,
      name: r'lastBriefingText',
      type: IsarType.string,
    ),
    r'limitations': PropertySchema(
      id: 9,
      name: r'limitations',
      type: IsarType.string,
    ),
    r'userAge': PropertySchema(
      id: 10,
      name: r'userAge',
      type: IsarType.long,
    ),
    r'userHeight': PropertySchema(
      id: 11,
      name: r'userHeight',
      type: IsarType.double,
    ),
    r'userName': PropertySchema(
      id: 12,
      name: r'userName',
      type: IsarType.string,
    ),
    r'userWeight': PropertySchema(
      id: 13,
      name: r'userWeight',
      type: IsarType.double,
    )
  },
  estimateSize: _userStateEstimateSize,
  serialize: _userStateSerialize,
  deserialize: _userStateDeserialize,
  deserializeProp: _userStateDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userStateGetId,
  getLinks: _userStateGetLinks,
  attach: _userStateAttach,
  version: '3.1.0+1',
);

int _userStateEstimateSize(
  UserState object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aiGeneratedPlan.length * 3;
  bytesCount += 3 + object.fitnessLevel.length * 3;
  bytesCount += 3 + object.goals.length * 3;
  bytesCount += 3 + object.historicalAILogs.length * 3;
  {
    for (var i = 0; i < object.historicalAILogs.length; i++) {
      final value = object.historicalAILogs[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.lastBriefingText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.limitations.length * 3;
  bytesCount += 3 + object.userName.length * 3;
  return bytesCount;
}

void _userStateSerialize(
  UserState object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiGeneratedPlan);
  writer.writeLong(offsets[1], object.currentProgressIndex);
  writer.writeLong(offsets[2], object.currentStreak);
  writer.writeString(offsets[3], object.fitnessLevel);
  writer.writeString(offsets[4], object.goals);
  writer.writeStringList(offsets[5], object.historicalAILogs);
  writer.writeDateTime(offsets[6], object.lastActiveDate);
  writer.writeDateTime(offsets[7], object.lastBriefingDate);
  writer.writeString(offsets[8], object.lastBriefingText);
  writer.writeString(offsets[9], object.limitations);
  writer.writeLong(offsets[10], object.userAge);
  writer.writeDouble(offsets[11], object.userHeight);
  writer.writeString(offsets[12], object.userName);
  writer.writeDouble(offsets[13], object.userWeight);
}

UserState _userStateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserState();
  object.aiGeneratedPlan = reader.readString(offsets[0]);
  object.currentProgressIndex = reader.readLong(offsets[1]);
  object.currentStreak = reader.readLong(offsets[2]);
  object.fitnessLevel = reader.readString(offsets[3]);
  object.goals = reader.readString(offsets[4]);
  object.historicalAILogs = reader.readStringList(offsets[5]) ?? [];
  object.id = id;
  object.lastActiveDate = reader.readDateTime(offsets[6]);
  object.lastBriefingDate = reader.readDateTimeOrNull(offsets[7]);
  object.lastBriefingText = reader.readStringOrNull(offsets[8]);
  object.limitations = reader.readString(offsets[9]);
  object.userAge = reader.readLong(offsets[10]);
  object.userHeight = reader.readDouble(offsets[11]);
  object.userName = reader.readString(offsets[12]);
  object.userWeight = reader.readDouble(offsets[13]);
  return object;
}

P _userStateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userStateGetId(UserState object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userStateGetLinks(UserState object) {
  return [];
}

void _userStateAttach(IsarCollection<dynamic> col, Id id, UserState object) {
  object.id = id;
}

extension UserStateQueryWhereSort
    on QueryBuilder<UserState, UserState, QWhere> {
  QueryBuilder<UserState, UserState, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserStateQueryWhere
    on QueryBuilder<UserState, UserState, QWhereClause> {
  QueryBuilder<UserState, UserState, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserState, UserState, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterWhereClause> idBetween(
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
}

extension UserStateQueryFilter
    on QueryBuilder<UserState, UserState, QFilterCondition> {
  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiGeneratedPlan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiGeneratedPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiGeneratedPlan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiGeneratedPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      aiGeneratedPlanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiGeneratedPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentProgressIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentProgressIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentProgressIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentProgressIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentProgressIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentProgressIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentProgressIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentProgressIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      currentStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> fitnessLevelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> fitnessLevelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fitnessLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> fitnessLevelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fitnessLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fitnessLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      fitnessLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fitnessLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goals',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goals',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> goalsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goals',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'historicalAILogs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historicalAILogs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historicalAILogs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historicalAILogs',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historicalAILogs',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      historicalAILogsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'historicalAILogs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserState, UserState, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserState, UserState, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastActiveDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastActiveDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastActiveDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastActiveDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastActiveDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastBriefingDate',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastBriefingDate',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastBriefingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastBriefingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastBriefingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastBriefingDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastBriefingText',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastBriefingText',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastBriefingText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastBriefingText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastBriefingText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastBriefingText',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      lastBriefingTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastBriefingText',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      limitationsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'limitations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      limitationsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'limitations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> limitationsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'limitations',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      limitationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitations',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      limitationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'limitations',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userAgeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userAge',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userAgeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userAge',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userAgeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userAge',
        value: value,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userAgeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userHeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      userHeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userHeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userHeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userWeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition>
      userWeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userWeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserState, UserState, QAfterFilterCondition> userWeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension UserStateQueryObject
    on QueryBuilder<UserState, UserState, QFilterCondition> {}

extension UserStateQueryLinks
    on QueryBuilder<UserState, UserState, QFilterCondition> {}

extension UserStateQuerySortBy on QueryBuilder<UserState, UserState, QSortBy> {
  QueryBuilder<UserState, UserState, QAfterSortBy> sortByAiGeneratedPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiGeneratedPlan', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByAiGeneratedPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiGeneratedPlan', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      sortByCurrentProgressIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgressIndex', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      sortByCurrentProgressIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgressIndex', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByFitnessLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByFitnessLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLastBriefingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingDate', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      sortByLastBriefingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingDate', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLastBriefingText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingText', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      sortByLastBriefingTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingText', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLimitations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitations', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByLimitationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitations', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userAge', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userAge', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userHeight', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userHeight', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userWeight', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> sortByUserWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userWeight', Sort.desc);
    });
  }
}

extension UserStateQuerySortThenBy
    on QueryBuilder<UserState, UserState, QSortThenBy> {
  QueryBuilder<UserState, UserState, QAfterSortBy> thenByAiGeneratedPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiGeneratedPlan', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByAiGeneratedPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiGeneratedPlan', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      thenByCurrentProgressIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgressIndex', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      thenByCurrentProgressIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgressIndex', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByFitnessLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByFitnessLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLastBriefingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingDate', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      thenByLastBriefingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingDate', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLastBriefingText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingText', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy>
      thenByLastBriefingTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBriefingText', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLimitations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitations', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByLimitationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitations', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userAge', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userAge', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userHeight', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userHeight', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userWeight', Sort.asc);
    });
  }

  QueryBuilder<UserState, UserState, QAfterSortBy> thenByUserWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userWeight', Sort.desc);
    });
  }
}

extension UserStateQueryWhereDistinct
    on QueryBuilder<UserState, UserState, QDistinct> {
  QueryBuilder<UserState, UserState, QDistinct> distinctByAiGeneratedPlan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiGeneratedPlan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct>
      distinctByCurrentProgressIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentProgressIndex');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreak');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByFitnessLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fitnessLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByGoals(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goals', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByHistoricalAILogs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historicalAILogs');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastActiveDate');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByLastBriefingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastBriefingDate');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByLastBriefingText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastBriefingText',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByLimitations(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'limitations', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByUserAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userAge');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByUserHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userHeight');
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByUserName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserState, UserState, QDistinct> distinctByUserWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userWeight');
    });
  }
}

extension UserStateQueryProperty
    on QueryBuilder<UserState, UserState, QQueryProperty> {
  QueryBuilder<UserState, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserState, String, QQueryOperations> aiGeneratedPlanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiGeneratedPlan');
    });
  }

  QueryBuilder<UserState, int, QQueryOperations>
      currentProgressIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentProgressIndex');
    });
  }

  QueryBuilder<UserState, int, QQueryOperations> currentStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreak');
    });
  }

  QueryBuilder<UserState, String, QQueryOperations> fitnessLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fitnessLevel');
    });
  }

  QueryBuilder<UserState, String, QQueryOperations> goalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goals');
    });
  }

  QueryBuilder<UserState, List<String>, QQueryOperations>
      historicalAILogsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historicalAILogs');
    });
  }

  QueryBuilder<UserState, DateTime, QQueryOperations> lastActiveDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastActiveDate');
    });
  }

  QueryBuilder<UserState, DateTime?, QQueryOperations>
      lastBriefingDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastBriefingDate');
    });
  }

  QueryBuilder<UserState, String?, QQueryOperations>
      lastBriefingTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastBriefingText');
    });
  }

  QueryBuilder<UserState, String, QQueryOperations> limitationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'limitations');
    });
  }

  QueryBuilder<UserState, int, QQueryOperations> userAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userAge');
    });
  }

  QueryBuilder<UserState, double, QQueryOperations> userHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userHeight');
    });
  }

  QueryBuilder<UserState, String, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }

  QueryBuilder<UserState, double, QQueryOperations> userWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userWeight');
    });
  }
}
