import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'job.g.dart';
@JsonSerializable()
class Job extends Equatable {
  int id;
  int companyId;
  String title;
  String description;

  Job(
      {@required this.id,
      @required this.companyId,
      @required this.title,
      @required this.description});

  factory Job.fromJson(Map<String,dynamic> json) => _$JobFromJson(json);
  Map<String ,dynamic> toJson () => _$JobToJson(this);

  @override
  List<Object> get props => [id, companyId, title, description];
}
