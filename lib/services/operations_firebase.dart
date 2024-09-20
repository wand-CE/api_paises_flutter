import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/models/country_model.dart';

class DatabaseOperationsFirebase extends GetConnect {
  final _db = FirebaseFirestore.instance;
  final _dbAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> createNewUserAcoount(
      String emailAddress, String password) async {
    bool isCreated = false;
    String message = "Não foi possível criar usuário";
    try {
      await _dbAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      isCreated = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'A senha é muito fraca';
      } else if (e.code == 'email-already-in-use') {
        message = 'Já existe uma conta com esse e-mail';
      }
    } catch (e) {
      throw Exception('$e');
    }

    return {
      "isCreated": isCreated,
      "message": message,
    };
  }

  Future<Map<String, dynamic>> signInEmailPass(
      String emailAddress, String password) async {
    bool isLogged = false;
    String message = 'Não foi possível logar, tente novamente';
    try {
      await _dbAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      isLogged = !isLogged;
      message = "Seja bem-vindo!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Nenhum usuário com esse e-mail';
      } else if (e.code == 'wrong-password') {
        message = 'Senha ou e-mail incorretos';
      }
    }
    return {
      "isLogged": isLogged,
      "message": message,
    };
  }

  String getCurrentUserId() {
    return _dbAuth.currentUser!.uid;
  }

  Future<List<dynamic>> getFavorites() async {
    List<Object> listCountries = [];
    String idUser = getCurrentUserId();

    try {
      final queryCountries = await _db
          .collection("country")
          .where("idUser", isEqualTo: idUser)
          .get();

      for (var doc in queryCountries.docs) {
        Map<String, dynamic> dictFavorites = doc.data();
        dictFavorites['id'] = doc.id;
        listCountries.add(dictFavorites);
      }
      return listCountries;
    } catch (e) {
      throw Exception('Erro ao obter favoritos: $e');
    }
  }

  Future<void> logOutUser() async {
    await _dbAuth.signOut();
  }

  Future<void> removeFavorite(String idFavorite) async {
    _db.collection("country").doc(idFavorite).delete();
  }

  Future<void> addFavorite(Map<String, dynamic> countryMap) async {
    await _db.collection("country").add(countryMap);
  }

  Future<Map<String, dynamic>> addRemoveFavoriteCountry(String countryName,
      String countryFlag, String countryLatLng, String mapLink) async {
    final countryMap = {
      "idUser": getCurrentUserId(),
      "countryName": countryName,
      "countryFlag": countryFlag,
      "countryLatLng": countryLatLng,
      "countryLinkMap": mapLink,
    };

    final countryExist = await isCountrySaved(countryName);
    final isSaved = countryExist["isSaved"];
    final docId = countryExist["docId"];

    try {
      isSaved ? await removeFavorite(docId) : await addFavorite(countryMap);
      return {
        "message": isSaved
            ? "$countryName removido dos favoritos"
            : "$countryName salvo nos favoritos",
        "isSaved": !isSaved,
      };
    } catch (e) {
      throw Exception("Não foi possível adicionar país");
    }
  }

  Future<Map<String, dynamic>> isCountrySaved(String countryName) async {
    try {
      final queryCountry = await _db
          .collection("country")
          .where("idUser", isEqualTo: getCurrentUserId())
          .where("countryName", isEqualTo: countryName)
          .get();
      bool countrySaved = queryCountry.docs.isNotEmpty;

      return {
        "isSaved": queryCountry.docs.isNotEmpty,
        "docId": countrySaved ? queryCountry.docs.first.id : null,
      };
    } catch (e) {
      throw Exception('Erro ao obter país: $e');
    }
  }
}
