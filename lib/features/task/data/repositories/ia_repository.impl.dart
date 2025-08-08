import '../../domain/repositories/ia.repository.dart';
import '../datasources/remote/ia_remote.datasource.dart';

class IARepositoryImpl implements IARepository {
  final IADataSource remoteDataSource;

  IARepositoryImpl(this.remoteDataSource);

  @override
  Future<String> generateDescription(String task) {
    return remoteDataSource.generateDescription(task);
  }
}
