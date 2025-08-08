import '../repositories/ia.repository.dart';

class GenerateDescriptionUseCase {
  final IARepository repository;

  GenerateDescriptionUseCase(this.repository);

  Future<String> call(String task) async {
    return await repository.generateDescription(task);
  }
}
