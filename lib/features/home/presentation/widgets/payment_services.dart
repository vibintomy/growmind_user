import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Map<String, dynamic> getRazorpayOptions({
    required String courseId,
    required int coursePrice,
    String? userEmail,
    String? userPhone,
  }) {
    return {
      'key': 'rzp_test_F94zuwkEe8DLrJ',
      'amount': coursePrice * 100,
      'name': 'GrowMind',
      'description': 'Payment for Course #$courseId',
      'prefill': {
        'contact': userPhone ?? '9876543210',
        'email': userEmail ?? 'user@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
  }


  Future<void> processSuccessfulPayment({
    required String courseId,
    required String createdBy,
    required String courseName,
    required int coursePrice,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception(" No authenticated user found.");
    }
    
    String userId = user.uid;
    DateTime now = DateTime.now();

    try {
      await _updateUserData(userId, createdBy, courseId);
           
      await _updateCoursePurchaseCount(courseId);
        
      await _updateTutorStats(createdBy, userId, now); 
      await _updateAdminStats(courseId, courseName, coursePrice);
      
      debugPrint("✅ Payment processed successfully!");
    } catch (e) {
      debugPrint(" Firestore Error: $e");
      throw Exception(" Firestore Error: $e");
    }
  }

  
  Future<void> _updateUserData(String userId, String mentorId, String courseId) async {
    await _firestore.collection('users').doc(userId).set({
      'mentor': FieldValue.arrayUnion([mentorId]),
      'purchasedCourses': FieldValue.arrayUnion([courseId])
    }, SetOptions(merge: true));
  }

  
  Future<void> _updateCoursePurchaseCount(String courseId) async {
    DocumentReference courseRef = _firestore.collection('courses').doc(courseId);
    
    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(courseRef);
        
     
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>?;
          int currentCount = data != null && data.containsKey('purchasesCount') 
              ? data['purchasesCount'] 
              : 0;
          
          transaction.set(courseRef, {'purchasesCount': currentCount + 1},
              SetOptions(merge: true));
        } else {
    
          transaction.set(courseRef, {'purchasesCount': 1},
              SetOptions(merge: true));
        }
      });
    } catch (e) {
      debugPrint(" Error updating course purchase count: $e");
    
      await courseRef.set({'purchasesCount': 1}, SetOptions(merge: true));
    }
  }

 
  Future<void> _updateTutorStats(String tutorId, String userId, DateTime joinTime) async {
    DocumentReference tutorRef = _firestore.collection('tutors').doc(tutorId);
    
    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(tutorRef);
        
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>?;
          List<dynamic> joiners = data != null && data.containsKey('joiners') 
              ? List<dynamic>.from(data['joiners']) 
              : [];
          int totalUsers = data != null && data.containsKey('totalusers') 
              ? data['totalusers'] 
              : 0;
          
         
          if (!joiners.contains(userId)) {
            joiners.add(userId);
          }
          
       
          Map<String, dynamic> joinDateTime = data != null && data.containsKey('joinDateTime') 
              ? Map<String, dynamic>.from(data['joinDateTime']) 
              : {};
          
          joinDateTime[userId] = joinTime.toIso8601String();
          
          transaction.set(
            tutorRef,
            {
              'joiners': joiners,
              'totalusers': totalUsers + 1,
              'joinDateTime': joinDateTime
            },
            SetOptions(merge: true)
          );
        } else {
        
          transaction.set(
            tutorRef,
            {
              'joiners': [userId],
              'totalusers': 1,
              'joinDateTime': {userId: joinTime.toIso8601String()}
            },
            SetOptions(merge: true)
          );
        }
      });
    } catch (e) {
      debugPrint(" Error updating tutor stats: $e");
     
      await tutorRef.set({
        'joiners': [userId],
        'totalusers': 1,
        'joinDateTime': {userId: joinTime.toIso8601String()}
      }, SetOptions(merge: true));
    }
  }

 
  Future<void> _updateAdminStats(String courseId, String courseName, int coursePrice) async {
    DocumentReference adminRef = _firestore.collection('admin').doc('stats');
    
    try {
    
      DocumentSnapshot adminSnapshot = await adminRef.get();
      if (!adminSnapshot.exists) {
        await adminRef.set({'totalRevenue': 0, 'courses': {}});
      }
      
     
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(adminRef);
        
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>?;
          int currentRevenue = data != null && data.containsKey('totalRevenue') 
              ? data['totalRevenue'] 
              : 0;
          
          Map<String, dynamic> courses = data != null && data.containsKey('courses') 
              ? Map<String, dynamic>.from(data['courses']) 
              : {};
          
          if (courses.containsKey(courseId)) {
            final courseData = courses[courseId] as Map<String, dynamic>;
            courses[courseId] = {
              'name': courseName,
              'purchases': (courseData['purchases'] ?? 0) + 1,
              'revenue': (courseData['revenue'] ?? 0) + coursePrice
            };
          } else {
            courses[courseId] = {
              'name': courseName,
              'purchases': 1,
              'revenue': coursePrice
            };
          }
          
          transaction.set(
            adminRef,
            {'totalRevenue': currentRevenue + coursePrice, 'courses': courses},
            SetOptions(merge: true)
          );
        } else {
      
          transaction.set(
            adminRef,
            {
              'totalRevenue': coursePrice, 
              'courses': {
                courseId: {
                  'name': courseName,
                  'purchases': 1,
                  'revenue': coursePrice
                }
              }
            },
            SetOptions(merge: true)
          );
        }
      });
    } catch (e) {
      debugPrint(" Error updating admin stats: $e");
 
      Map<String, dynamic> courseData = {
        courseId: {
          'name': courseName,
          'purchases': 1,
          'revenue': coursePrice
        }
      };
      
      await adminRef.set({
        'totalRevenue': coursePrice,
        'courses': courseData
      }, SetOptions(merge: true));
    }
  }
}