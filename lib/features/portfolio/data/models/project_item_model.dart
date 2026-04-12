import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';

class ProjectItemModel extends ProjectItem {
  const ProjectItemModel({
    required super.title,
    required super.description,
    required super.isPlanned,
  });
}
