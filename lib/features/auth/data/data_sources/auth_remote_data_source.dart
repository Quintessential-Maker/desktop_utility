import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsc_utility/core/constants/api_constants.dart';
import 'package:dsc_utility/core/constants/preferences.dart';
import 'package:dsc_utility/core/network/remote_data_source_base.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRemoteDataSource extends RemoteDataSourceBase {
  Future<Response> requestOtp({
    required String mobile,
    required String os,
    required String version,
  }) async {
    return await post(
      ApiEndpoints.requestOtp,
      queryParams: {
        'S': Preferences.serviceCodeInspection,
        'M': mobile,
        'OS': os,
        'V': '2.15.4.3',//version
      },
    );
  }

  Future<Response> verifyOtp({
    required String mobile,
    required String otp,
    required String os,
    required String version,
  }) async {
    return await post(
      ApiEndpoints.verifyOtp,
      queryParams: {
        'S': Preferences.serviceCodeInspection,
        'O': otp,
        'M': mobile,
        'OS': os,
        'V': '2.15.4.3',//version
      },
    );
  }

  Future<void> setTokenToPreferences(String jwtToken) async {
    try {
      int inspectorid, distrcitid, blockid, VolunteerId, isDebug;
      String jsonStringRoles,
          crudBy,
          inspectorname,
          InspectorGuid,
          UserGUID,
          designation,
          mobilenumber,
          displayname,
          username,
          schoolid,
          schoolname,
          disecode,
          schooltype,
          schooltypeId,
          kitchenType,
          clusterId = '';

      // Decode the JWT Token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);

      crudBy = decodedToken['UserId'];
      displayname = decodedToken['DisplayName'];
      username = decodedToken['Username'];
      inspectorname = decodedToken['Inspector'];
      designation = decodedToken['Designation'];
      distrcitid = decodedToken['DistrcitId'];
      blockid = decodedToken['BlockId'];
      inspectorid = decodedToken['InspectorId'];
      VolunteerId = decodedToken['VolunteerId'];
      schoolid = decodedToken['SchoolId'];
      schoolname = decodedToken['School'];
      disecode = decodedToken['DISECode'];
      schooltype = decodedToken['SchoolType'];
      schooltypeId = decodedToken['SchoolTypeId'];
      kitchenType = decodedToken['KitchenType'];
      mobilenumber = decodedToken['MobileNumber'];
      UserGUID = decodedToken['UserGUID'];
      InspectorGuid = decodedToken['InspectorGUID'];
      isDebug = decodedToken['IsDebug'];
      jsonStringRoles = json.encode(decodedToken['Roles']);

      if(decodedToken['ClusterId']!=null){
        clusterId = decodedToken['ClusterId'];
      }


      await prefs.write(Preferences.AUTHORIZATION_TOKEN, jwtToken);
      await prefs.write(Preferences.IS_LOGGED_IN, true);

      await prefs.write(Preferences.SCHOOLID, schoolid);
      await prefs.write(Preferences.SCHOOLNAME, schoolname);
      await prefs.write(Preferences.DISECODE, disecode);
      await prefs.write(Preferences.SCHOOLTYPE, schooltype);
      await prefs.write(Preferences.SCHOOLTYPEID, schooltypeId);

      await prefs.write(Preferences.KITCHENTYPE, kitchenType);

      await prefs.write(Preferences.CLUSTERID, clusterId);

      await prefs.write(Preferences.CRUDBY, crudBy);
      await prefs.write(Preferences.INSPECTORID, inspectorid);
      await prefs.write(Preferences.VOLUNTEERID, VolunteerId);
      await prefs.write(Preferences.INSPECTORDESIGNATION, designation);
      await prefs.write(Preferences.INSPECTORNAME, inspectorname);
      await prefs.write(Preferences.ISDEBUG, isDebug);
      await prefs.write(Preferences.INSPECTORGUID, InspectorGuid);
      await prefs.write(Preferences.USERGUID, UserGUID);
      await prefs.write(Preferences.DISTRICTID, distrcitid);
      await prefs.write(Preferences.BLOCKID, blockid);
      await prefs.write(Preferences.ROLES, jsonStringRoles);
      await prefs.write(Preferences.MOBILENUMBER, mobilenumber);
      await prefs.write(Preferences.DISPLAYNAME, displayname);
      await prefs.write(Preferences.USERNAME, username);

    }catch (e) {
      print("Error during login: $e");
    }
  }
}

