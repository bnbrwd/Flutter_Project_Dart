// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkService {
  
  // final baseUrl = 'http://localhost:3000/todos'; //not work for android simulator. work for ios simulator
  // final baseUrl = 'http://192.168.0.104:3000/todos';
  final baseUrl = 'http://10.0.2.2:3000/todos';
  //192.168.0.104.
  Future<List<dynamic>> fetchTodos() async{

    try{
     final response = await http.get(Uri.parse(baseUrl));
     print('res=---${response.body}'); //json string
    return jsonDecode(response.body) as List; //decode json string into json.
    }catch(e){
      print('error---$e');
      return [];
    }
    
  }

 Future<bool> pathTodo(Map<String, String> patchObj, int id) async{
   try{
    await http.patch(Uri.parse(baseUrl + '$id'), body: patchObj);
    return true;
   }catch(e){
     return false;
   }
 }

  Future<Map> addTodo(Map<String, String> todoObj) async{
    try{
   final response = await http.post(Uri.parse(baseUrl), body: todoObj);
   return jsonDecode(response.body);
    
   }catch(e){
     return {};
   }
  }

 Future<bool> deleteTodo(int id) async{
   try{
    await http.delete(Uri.parse(baseUrl + '/$id'));
    return true;
   }catch(e){
     return false;
   }
 }



}