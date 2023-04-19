import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/models/Todo.dart';
import 'package:todo/services/Api.service.dart';

class MockApiService extends Mock implements ApiService {}

@GenerateMocks([http.Client])
void main() {
  group('fetchTodos', () {
    test('returns a List of Todos if the http call completes successfully',
        () async {
      final apiService = ApiService();

      apiService.client = MockClient((request) async {
        return http.Response(
            '[{"id": "1", "title": "Test Task", "description": "Test Description", "date": "2022-09-14 19:39:00.000", "status": 0}]',
            200);
      });

      final data = await apiService.fetchTodos();

      Todo todo = data[0];

      expect(todo.id, '1');
    });

    test("updates the todo's status", () async {
      final apiService = ApiService();

      apiService.client = MockClient((request) async {
        return http.Response(
            '[{"id": "1", "title": "Test Task", "description": "Test Description", "date": "2022-09-14 19:39:00.000", "status": 0}]',
            200);
      });

      final data = await apiService.fetchTodos();

      Todo todo = data[0];

      expect(todo.status, 0);

      todo.status = 1;

      expect(todo.status, 1);
    });

    test('throws an exception if the http call completes with an error', () {
      final apiService = ApiService();

      apiService.client = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      expect(apiService.fetchTodos(), throwsException);
    });
  });
}
