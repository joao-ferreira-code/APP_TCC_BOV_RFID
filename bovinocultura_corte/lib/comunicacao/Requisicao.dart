
import 'dart:convert';

import 'package:bovinocultura_corte/comunicacao/Resposta.dart';
import 'package:http/http.dart' as http;

class Requisicao {

  static String txTokenJWT = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqb2FvLmZlcnJlaXJhOTg5OUBob3RtYWlsLmNvbSIsImV4cCI6OTIyMzM3MjAzNjg1NDc3NSwiaWF0IjoxNjcxNDYwMTA2fQ.xRmlY0RvBsqR4XnXL6ReLRcMuP7h4l7bL1tshQAfuwJV9P1PxY_HOJ-gyymVc7IAsnYMv33IWzaO6XZ04ltjnw";

//============================================================================//

  static post(String url, dynamic? body, {bool? isImage}) async {

    print("POST > Request URL:  >> ${url} <-> ${ body !=null ? 'Request Body:   >> ${body}':''}\n");

    Map<String, String> header = createHeader();

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body
    );
    var dataMap = jsonDecode(response.body);

  //------------------------------------------------------------------------//
    print("POST > Response Status:  >> ${response.statusCode}   <->   Response Body:   >> ${response.body}\n");

    return new Resposta.fromJson(dataMap);
  }

//============================================================================//

  static get(String url, {dynamic? body, bool? isImage}) async {

    print("GET > Request URL:  >> ${url} <-> ${ body !=null ? 'Request Body:   >> ${body}':''}\n");

    //------------------------------------------------------------------------//

    Map<String, String> header = createHeader();

    var response = await http.get(
        Uri.parse(url),
        headers: header
    );
    var dataMap = jsonDecode(response.body);

    //------------------------------------------------------------------------//

    print("GET > Response Status:  >> ${response.statusCode}   <->   Response Body:   >> ${response.body}\n");

    return new Resposta.fromJson(dataMap);
  }

//============================================================================//

  static Map<String, String> createHeader(){
    Map<String, String> header = {"Authorization": "Bearer ${txTokenJWT}"};

    MapEntry<String, String> entryContentType =  MapEntry<String, String>
      ("content-type", "application/json; charset=utf-8 ");

    List<MapEntry<String, String>> listEntrys = [];
    listEntrys.add(entryContentType);
    header.addEntries(listEntrys);
    return header;
  }

//============================================================================//

}