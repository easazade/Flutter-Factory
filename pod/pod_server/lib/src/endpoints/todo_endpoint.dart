import 'package:pod_server/src/generated/todo.dart';
import 'package:serverpod/serverpod.dart';

class TodoEndpoint extends Endpoint {
  Future<Todo> createTodo(Session session, Todo todo) async {
    await Todo.insert(session, todo);
    session.log('Now there are ${await Todo.count(session)} Todos in our database');
    session.log('all todos = ${await Todo.find(session)}');
    return todo;
  }
}
