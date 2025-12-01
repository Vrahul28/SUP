import 'dart:io';
import 'package:acp/facilitybookingpage/service.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../appDashboard/dashboard/gridlayout2.dart';
import '../../blacklist/addblacklist/addblacklistmodel.dart';
import '../../blacklist/blacklist.dart';
import '../../company/addcompany/addcompanymodel.dart';
import '../../company/addcompany/additionaldetailscompany.dart';
import '../../company/companyscreen.dart';
import '../../facilitybookingpage/facilitybooking.dart';
import '../staffscreen.dart';
import 'addstaffmodel.dart';

List<Addcompanymodel> allcompany= [];
List<Additionalcompanydata> additionalcompanydata= [];
List<Addstaffmodel> allstaff= [];
List<Addbacklistmodel> blacklisted= [];
List<Service> allevents= [];
String total= '';

class DBhelper{
  static Database? _database;
  static final DBhelper db = DBhelper._();

  DBhelper._();

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
   print(newstaff.profileImage);

    return res;
  }

  // Insert Tan staff on database
  createTanStaff(Addstaffmodel newstaff) async {
    final Database db = await initDB();
    final res = await db.insert(
        'TANADMINSTAFF', newstaff.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print(newstaff.profileImage);

    return res;
  }

  // Insert company on database
  createCompany(Addcompanymodel newcompany) async {
    final Database db = await initDB();
    final res = await db.insert(
        'COMPANY', newcompany.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print(newcompany.companyName);

    return res;
  }

  // Insert Addcompany on database
  createaddCompany(Additionalcompanydata newdata) async {
    final Database db = await initDB();
    final res = await db.insert(
        'ADDCOMPANYDATA', newdata.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print(newdata.tower);

    return res;
  }

  // Insert blacklist on database

  createBlacklist(Addbacklistmodel newblacklist) async {
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
  Future<int?> deleteaddCompany(Additionalcompanydata updatedata) async {
    final db = await database;
    final res = await db?.delete(
      'ADDCOMPANYDATA',
      where: 'id = ?',
      whereArgs: [updatedata.id],
    );

    return res;
  }

  // Delete all black
  Future<int?> deleteBlacklist(Addbacklistmodel updatedblack) async {
    final db = await database;
    final res = await db?.delete(
      'BLACKLISTED',
      where: 'visitorBlackListId = ?',
      whereArgs: [updatedblack.visitorBlackListId],
    );

    return res;
  }


  // Delete all Events

  Future<int?> deletetask(Service service) async {
    final db = await database;
    final res = await db?.delete(
      'SERVICE',
      where: 'id = ?',
      whereArgs: [service.id],
    );

    return res;
  }

  // Read staff Data
  Future<List<Addstaffmodel>> getAllstaff(String query, String query2) async {
    final db = await database;
    var result = await db!.query('STAFF');
    allstaff.clear();

    for(var item in result){
      allstaff.add(Addstaffmodel.fromJson(item));
    }


    total= allstaff.length.toString();

    if(query!=null){
      allstaff =   allstaff
          .where((code) =>
      code.company?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
      totalstaff.text= allstaff.length.toString();
    }

    if(query2!=null){
      allstaff =   allstaff
          .where((code) =>
      code.firstName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
      totalstaff.text= allstaff.length.toString();
    }

    await db.rawUpdate('''UPDATE STAFF
    SET total_staff_count = ?''', [allstaff.length]);


    return allstaff;
  }

  // Read Tan staff Data
  Future<List<Addstaffmodel>> getTanstaff(String query) async {
    final db = await database;
    var result = await db!.query('TANADMINSTAFF');
    allstaff.clear();
    for(var item in result){
      allstaff.add(Addstaffmodel.fromJson(item));
    }
    total= allstaff.length.toString();
    totalgrid.text= allstaff.length.toString();

      if(query!=null){
        allstaff =   allstaff
            .where((code) =>
        code.firstName?.toLowerCase().contains(query.toLowerCase()) ??
            false)
            .toList();
        total= allstaff.length.toString();
      }



    return allstaff;
  }

  // Read company Data

  Future<List<Addcompanymodel>> getAllCompany(String query, String query2, String query3) async {
    final db = await database;
    var result = await db!.query('COMPANY');
    allcompany.clear();
    for(var item in result){
      allcompany.add(Addcompanymodel.fromJson(item));
      print(item);
    }

    if(query!=null){
      allcompany =   allcompany
          .where((code) =>
      code.tower?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    }

    if(query2!=null){
      allcompany =   allcompany
          .where((code) =>
      code.companyName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();

    }

    if(query3!=null){
      allcompany =   allcompany
          .where((code) =>
      code.unitNO?.toLowerCase().contains(query3.toLowerCase()) ??
          false)
          .toList();
    }



    allresult.text= allcompany.length.toString();

    return allcompany;
  }

  // Read Additional company Data

  Future<List<Additionalcompanydata>> getaddCompanydata() async {
    final db = await database;
    var result = await db!.query(
        'ADDCOMPANYDATA',
      // where: 'companyId = ?',
      // whereArgs: [id],
    );
    additionalcompanydata.clear();
    for(var item in result){
      additionalcompanydata.add(Additionalcompanydata.fromJson(item));
    }

    // allresult.text= additionalcompanydata.length.toString();

    return additionalcompanydata;
  }


  Future<List<Additionalcompanydata>> getaddCompanydata1(String id) async {
    final db = await database;
    var result = await db!.query(
      'ADDCOMPANYDATA',
      where: 'companyId = ?',
      whereArgs: [id],
    );
    additionalcompanydata.clear();
    for(var item in result){
      additionalcompanydata.add(Additionalcompanydata.fromJson(item));
      print("item of list: $item");
    }
    // allresult.text= additionalcompanydata.length.toString();

    return additionalcompanydata;
  }

  Future<List<Additionalcompanydata>> getaddCompanydata2(String query, String query2) async {
    final db = await database;
    var result = await db!.rawQuery('''
    SELECT * FROM ADDCOMPANYDATA WHERE id IN (SELECT MIN(id) FROM ADDCOMPANYDATA GROUP BY companyId)''');
    additionalcompanydata.clear();
    for(var item in result){
      additionalcompanydata.add(Additionalcompanydata.fromJson(item));
      print(item);
    }

    if(query.isNotEmpty){
      additionalcompanydata = additionalcompanydata
          .where((code) =>
      code.tower?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    }

    if(query2.isNotEmpty){
      additionalcompanydata = additionalcompanydata
          .where((code) =>
      code.unitNO?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
    }


    return additionalcompanydata;
  }

  // Read blacklist Data

  Future<List<Addbacklistmodel>> getAllblacklist(String query, String query2) async {

    final db = await database;
    final result = await db!.query('BLACKLISTED');
    blacklisted.clear();
    for(var item in result){
      blacklisted.add(Addbacklistmodel.fromJson(item));
    }
    if(query!=null){
      blacklisted =   blacklisted
          .where((code) =>
      code.documentNumber?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
      // total= allstaff.length.toString();
    }

    if(query2!=null){
      blacklisted =    blacklisted
          .where((code) =>
      code.visitorName?.toLowerCase().contains(query2.toLowerCase()) ??
          false)
          .toList();
      // total= allstaff.length.toString();
    }
    totalblacklist.text =blacklisted.length.toString();

    return  blacklisted;
  }

  //  Read Event

  Future<List<Service>> getAllevnts() async {

    final db = await database;
    final result = await db!.query('SERVICE', where: 'date = ?', whereArgs: [selecteddate.text]);
    // if(selecteddate.text.isEmpty){
    //   result = await db!.query('SERVICE');
    // }else{
    //
    // }
    allevents.clear();
    for(var item in result){
      allevents.add(Service.fromJson(item));
    }

    return  allevents;
  }

  // Update company in the database
  Future<int?> updateCompany(Addcompanymodel updatedcompany) async {
    final db = await database;
    final res1 = await db?.update(
      'COMPANY',
      updatedcompany.toJson(),
      where: 'companyId = ?',
      whereArgs: [updatedcompany.companyId],
    );
    print("update company: $res1");


    return res1;
  }

  // Update Additional company data in the database

  Future<int?> updateaddCompanydata(Additionalcompanydata updatedcompany) async {
    final db = await database;
    final res1 = await db?.update(
      'ADDCOMPANYDATA',
      updatedcompany.toJson(),
      where: 'id = ?',
      whereArgs: [updatedcompany.id],
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

  Future<int?> updateBlacklist(Addbacklistmodel updatelist) async {

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