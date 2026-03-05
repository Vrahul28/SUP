import 'dart:io';
import 'package:acp/facilitybookingpage/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../Provider/Company/Company_Provider.dart';
import '../../Provider/Staff/Staff_Provider.dart';
import '../../appDashboard/dashboard/gridlayout2.dart';
import '../../blacklist/addblacklist/addblacklistmodel.dart';
import '../../company/addcompany/addcompanymodel.dart';
import '../../company/addcompany/additionaldetailscompany.dart';
import '../../facilitybookingpage/facilitybooking.dart';
import 'addstaffmodel.dart';

List<Addcompanymodel> allCompany= [];
List<Additionalcompanydata> additionalCompanyData= [];
List<Addstaffmodel> allStaff= [];
List<AddBackListModel> blacklisted= [];
List<Service> allEvents= [];
String total= '';
TextEditingController totalBlackList= TextEditingController();

class DBHelper{
  static Database? _database;
  static final DBHelper db = DBHelper._();

  DBHelper._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Adddetails1.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE STAFF('
              'staffId INTEGER PRIMARY KEY,'
              'firstName TEXT,'
              'lastName TEXT,'
              'nricNumber TEXT,'
              'corporateEmail TEXT,'
              'staffPhone TEXT,'
              'staffJobPosition TEXT,'
              'tower TEXT,'
              'company TEXT,'
              'unitNO TEXT,'
              'cardNO TEXT,'
              'activationDate TEXT,'
              'profileImage TEXT,'
              'qrcode TEXT,'
              'enableFR TEXT,'
              'total_staff_count INTEGER'

              ')');

          await db.execute('CREATE TABLE TANADMINSTAFF('
              'staffId INTEGER PRIMARY KEY,'
              'firstName TEXT,'
              'lastName TEXT,'
              'nricNumber TEXT,'
              'corporateEmail TEXT,'
              'staffPhone TEXT,'
              'staffJobPosition TEXT,'
              'tower TEXT,'
              'company TEXT,'
              'unitNO TEXT,'
              'cardNO TEXT,'
              'activationDate TEXT,'
              'profileImage TEXT,'
              'qrcode TEXT,'
              'enableFR TEXT,'
              'total_tanstaff_count INTEGER'

              ')');

          await db.execute('CREATE TABLE COMPANY('
              'companyId INTEGER PRIMARY KEY,'
              'companyName TEXT,'
              'displayName TEXT,'
              'UAG TEXT,'
              'contactName TEXT,'
              'contactNO TEXT,'
              'tower TEXT,'
              'unitNO TEXT,'
              'total_company_count INTEGER'
              ')');

          await db.execute('CREATE TABLE ADDCOMPANYDATA('
              'id INTEGER PRIMARY KEY,'
              'companyId INTEGER,'
              'tower TEXT,'
              'floor TEXT,'
              'unitNO TEXT,'
              'area TEXT,'
              'occupancy TEXT,'
              'staffNO TEXT'
              ')');

          await db.execute('CREATE TABLE BLACKLISTED('
              'visitorBlackListId INTEGER PRIMARY KEY,'
              'visitorName TEXT,'
              'documentNumber TEXT,'
              'blackListDate TEXT'

              ')');

          await db.execute('CREATE TABLE SERVICE('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, '
              'name TEXT, '
              'phonenumber TEXT, '
              'emailaddress TEXT, '
              'vehiclenumber TEXT, '
              'date STRING, '
              'startTime STRING, endTime STRING, '
              'payment STRING, '
              'color INTEGER,'
              'isCompleted INTEGER'
              ')');


        });
  }



  // Insert staff on database
  createStaff(Addstaffmodel newstaff) async {
    final Database db = await initDB();
    final res = await db.insert(
        'STAFF', newstaff.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
   debugPrint(newstaff.profileImage);

    return res;
  }

  // Insert Tan staff on database
  createTanStaff(Addstaffmodel newstaff) async {
    final Database db = await initDB();
    final res = await db.insert(
        'TANADMINSTAFF', newstaff.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    debugPrint(newstaff.profileImage);

    return res;
  }

  // Insert company on database
  createCompany(Addcompanymodel newcompany) async {
    final Database db = await initDB();
    final res = await db.insert(
        'COMPANY', newcompany.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    debugPrint(newcompany.companyName);

    return res;
  }

  // Insert Addcompany on database
  createaddCompany(Additionalcompanydata newdata) async {
    final Database db = await initDB();
    final res = await db.insert(
        'ADDCOMPANYDATA', newdata.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    debugPrint(newdata.tower);

    return res;
  }

  // Insert blacklist on database

  createBlacklist(AddBackListModel newblacklist) async {
    blacklisted.clear();
    final Database db = await initDB();
    final res = await db.insert(
        'BLACKLISTED', newblacklist.toJson()
    );
    print(newblacklist.blackListDate);

    return res;
  }

  // Insert event

  createService(Service service) async {
    final Database db = await initDB();
    final res = await db.insert(
        'SERVICE',service.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print(service.startTime);
    return res;
  }

  // Delete all staff
  Future<int?> deleteStaff(Addstaffmodel updatedStaff) async {
    final db = await database;
    final res = await db?.delete(
      'STAFF',
      where: 'staffId = ?',
      whereArgs: [updatedStaff.staffId],
    );

    return res;
  }

  // Delete Tan staff
  Future<int?> deleteTanStaff(Addstaffmodel updatedStaff) async {
    final db = await database;
    final res = await db?.delete(
      'TANADMINSTAFF',
      where: 'staffId = ?',
      whereArgs: [updatedStaff.staffId],
    );

    return res;
  }

  // Delete all company
  Future<int?> deleteCompany(Addcompanymodel updatedcompany) async {
    final db = await database;
    final res = await db?.delete(
      'COMPANY',
      where: 'companyId = ?',
      whereArgs: [updatedcompany.companyId],
    );

    return res;
  }

  // Delete alldata  company
  Future<int?> deleteAddCompany(Additionalcompanydata updateData) async {
    final db = await database;
    final res = await db?.delete(
      'ADDCOMPANYDATA',
      where: 'id = ?',
      whereArgs: [updateData.id],
    );

    return res;
  }

  // Delete all black
  Future<int?> deleteBlacklist(AddBackListModel updatedBlack) async {
    final db = await database;
    final res = await db?.delete(
      'BLACKLISTED',
      where: 'visitorBlackListId = ?',
      whereArgs: [updatedBlack.visitorBlackListId],
    );

    return res;
  }


  // Delete all Events

  Future<int?> deleteTask(Service service) async {
    final db = await database;
    final res = await db?.delete(
      'SERVICE',
      where: 'id = ?',
      whereArgs: [service.id],
    );

    return res;
  }

  // Read staff Data
  Future<List<Addstaffmodel>> getAllStaff(String query, String query2, BuildContext context) async {
    final staff= context.read<StaffProvider>();

    final db = await database;
    var result = await db!.query('STAFF');
    allStaff.clear();

    for(var item in result){
      allStaff.add(Addstaffmodel.fromJson(item));
    }


    total= allStaff.length.toString();

    if(query.isNotEmpty){
      allStaff =   allStaff
          .where((code) =>
      code.company?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
      staff.totalStaff.text= allStaff.length.toString();
    }

    if(query2.isNotEmpty){
      allStaff =   allStaff
          .where((code) =>
      code.firstName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
      staff.totalStaff.text= allStaff.length.toString();
    }

    await db.rawUpdate('''UPDATE STAFF
    SET total_staff_count = ?''', [allStaff.length]);


    return allStaff;
  }

  // Read Tan staff Data
  Future<List<Addstaffmodel>> getTanStaff(String query) async {
    final db = await database;
    var result = await db!.query('TANADMINSTAFF');
    allStaff.clear();
    for(var item in result){
      allStaff.add(Addstaffmodel.fromJson(item));
    }
    total= allStaff.length.toString();
    totalgrid.text= allStaff.length.toString();

      if(query.isNotEmpty){
        allStaff =   allStaff
            .where((code) =>
        code.firstName?.toLowerCase().contains(query.toLowerCase()) ??
            false)
            .toList();
        total= allStaff.length.toString();
      }



    return allStaff;
  }

  // Read company Data

  Future<List<Addcompanymodel>> getAllCompany(String query, String query2, String query3, BuildContext context) async {
    final company= context.read<CompanyProvider>();

    final db = await database;
    var result = await db!.query('COMPANY');
    allCompany.clear();
    for(var item in result){
      allCompany.add(Addcompanymodel.fromJson(item));
      print(item);
    }

    if(query.isNotEmpty){
      allCompany =   allCompany
          .where((code) =>
      code.tower?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    }

    if(query2.isNotEmpty){
      allCompany =   allCompany
          .where((code) =>
      code.companyName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();

    }

    if(query3.isNotEmpty){
      allCompany =   allCompany
          .where((code) =>
      code.unitNO?.toLowerCase().contains(query3.toLowerCase()) ??
          false)
          .toList();
    }

    company.allResult.text= allCompany.length.toString();

    return allCompany;
  }

  // Read Additional company Data

  Future<List<Additionalcompanydata>> getAddCompanyData() async {
    final db = await database;
    var result = await db!.query(
        'ADDCOMPANYDATA',
      // where: 'companyId = ?',
      // whereArgs: [id],
    );
    additionalCompanyData.clear();

    for(var item in result){
      additionalCompanyData.add(Additionalcompanydata.fromJson(item));
    }

    // allresult.text= additionalcompanydata.length.toString();

    return additionalCompanyData;
  }


  Future<List<Additionalcompanydata>> getaddCompanydata1(String id) async {
    final db = await database;
    var result = await db!.query(
      'ADDCOMPANYDATA',
      where: 'companyId = ?',
      whereArgs: [id],
    );
    additionalCompanyData.clear();
    for(var item in result){
      additionalCompanyData.add(Additionalcompanydata.fromJson(item));
      print("item of list: $item");
    }
    // allresult.text= additionalcompanydata.length.toString();

    return additionalCompanyData;
  }

  Future<List<Additionalcompanydata>> getaddCompanydata2(String query, String query2) async {
    final db = await database;
    var result = await db!.rawQuery('''
    SELECT * FROM ADDCOMPANYDATA WHERE id IN (SELECT MIN(id) FROM ADDCOMPANYDATA GROUP BY companyId)''');
    additionalCompanyData.clear();
    for(var item in result){
      additionalCompanyData.add(Additionalcompanydata.fromJson(item));
      print(item);
    }

    if(query.isNotEmpty){
      additionalCompanyData = additionalCompanyData
          .where((code) =>
      code.tower?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    }

    if(query2.isNotEmpty){
      additionalCompanyData =additionalCompanyData
          .where((code) =>
      code.unitNO?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
    }


    return additionalCompanyData;
  }

  // Read blacklist Data

  Future<List<AddBackListModel>> getAllBlackList(String query, String query2) async {

    final db = await database;
    final result = await db!.query('BLACKLISTED');
    blacklisted.clear();
    for(var item in result){
      blacklisted.add(AddBackListModel.fromJson(item));
    }
    if(query.isEmpty){
      blacklisted =   blacklisted
          .where((code) =>
      code.documentNumber?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
      // total= allstaff.length.toString();
    }

    if(query2.isEmpty){
      blacklisted = blacklisted
          .where((code) =>
      code.visitorName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
      // total= allstaff.length.toString();
    }
    totalBlackList.text = blacklisted.length.toString();

    return  blacklisted;
  }

  //  Read Event

  Future<List<Service>> getAllEvents() async {

    final db = await database;
    final result = await db!.query('SERVICE', where: 'date = ?', whereArgs: [selectedDate.text]);
    // if(selecteddate.text.isEmpty){
    //   result = await db!.query('SERVICE');
    // }else{
    //
    // }
    allEvents.clear();
    for(var item in result){
      allEvents.add(Service.fromJson(item));
    }

    return  allEvents;
  }

  // Update company in the database
  Future<int?> updateCompany(Addcompanymodel updatedCompany) async {
    final db = await database;
    final res1 = await db?.update(
      'COMPANY',
      updatedCompany.toJson(),
      where: 'companyId = ?',
      whereArgs: [updatedCompany.companyId],
    );
    print("update company: $res1");


    return res1;
  }

  // Update Additional company data in the database

  Future<int?> updateaddCompanydata(Additionalcompanydata updatedCompany) async {
    final db = await database;
    final res1 = await db?.update(
      'ADDCOMPANYDATA',
      updatedCompany.toJson(),
      where: 'id = ?',
      whereArgs: [updatedCompany.id],
    );
    print("update company2: $res1");


    return res1;
  }

  // Update staff in the database
  Future<int?> updateStaff(Addstaffmodel updatedStaff) async {

    final db = await database;
    final res = await db?.update(
      'STAFF',
      updatedStaff.toJson(),
      where: 'staffId = ?',
      whereArgs: [updatedStaff.staffId],
    );


    return res;
  }

  // Update Tan staff in the database
  Future<int?> updateTanStaff(Addstaffmodel updatedStaff) async {

    final db = await database;
    final res = await db?.update(
      'TANADMINSTAFF',
      updatedStaff.toJson(),
      where: 'staffId = ?',
      whereArgs: [updatedStaff.staffId],
    );


    return res;
  }

  // Update Blacklist in the database

  Future<int?> updateBlacklist(AddBackListModel updatelist) async {

    final db = await database;
    final res2 = await db?.update(
      'BLACKLISTED',
      updatelist.toJson(),
      where: 'visitorBlackListId = ?',
      whereArgs: [updatelist.visitorBlackListId],
    );

    return res2;
  }

  //  check email is exist or not

  Future<bool?> isEmailExists(String email) async {
    final db = await database;
    List<Map<String, Object?>>? result = await db?.query(
      'STAFF',
      where: 'corporateEmail = ?',
      whereArgs: [email],
    );
    return result?.isNotEmpty;
  }

  // Check booking exist or not

  Future<bool> checkExistingBooking(String date, String startTime, String endTime,String title) async {
    if (_database != null) {
      final count = Sqflite.firstIntValue(await _database!.rawQuery(
          'SELECT COUNT(*) FROM SERVICE WHERE date = ? AND title = ? AND((startTime <= ? AND endTime >= ?) OR (startTime <= ? AND endTime >= ?))',
          [date,title, startTime, startTime, endTime, endTime]));
      return count! > 0;
    } else {
      throw Exception('Database not initialized.');
    }
  }


  // To get total items in each table:

  Future<int> count() async {
    final db = await database;
    List<Map<String, Object?>>? result = await db?.query('STAFF');
    return result?.length ?? 0;
  }

  Future<int> count2() async {
    final db = await database;
    List<Map<String, Object?>>? result = await db?.query('COMPANY');
    return result?.length ?? 0;
  }

  Future<int> count3() async {
    final db = await database;
    List<Map<String, Object?>>? result = await db?.query('TANADMINSTAFF');
    return result?.length ?? 0;
  }




}