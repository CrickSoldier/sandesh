import 'package:flutter/material.dart';
import 'package:Sandesh/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:Sandesh/services/database.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController mobileNoTextEditingController =
      new TextEditingController();
  TextEditingController bioTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

//  Future<void> addField () async {
//  final fieldRef = Firestore.instance.collection("Groups");
//
//    List<String> member = ["shivam@demo.com", "shivam1@demo.com"];
//    List<String> member1 = ["Anjuly Chib Duggal",
//      "Deepshikha Deka",
//      "Dhir Jhingran",
//      "Latha Krishna Rao",
//      "Malay Ramesh Dave",
//      "Pronab Kumar Sarkar",
//      "Rajeev Kumar",
//      "Rajesh Agarwal",
//      "Satish Balram Agnihotri",
//      "Shrikant Prakash Gathoo",
//      "Sankar Upadhyay",
//      "Shailendra Kumar Joshi"
//    ];
//    List<String> member2 = [
//      "Aditi Chadha Kapoor",
//      "Anil K Agnihotri",
//      "C K Soman",
//      "Dinesh Kumar",
//      "Gurjot Kaur",
//      "Mugdha D Karnik",
//      "Seema Bahuguna",
//      "Seema Paul",
//      "Rajeev Jorapur",
//      "Raju Sharma",
//      "Vinesh K Jairath",
//      "V Vaidyanathan Kishore"
//    ];
//    List<String> member3 = ["Ajay Kumar Lal",
//      "Avdhendra Pratap Singh",
//      "Dinesh Agrawal",
//      "Krishnendu Bose",
//      "Namita Sahoo",
//      "Rajat C Sarmah",
//      "Shyam R Asolekar",
//      "Taranjot K Gadhok"
//    ];
//    List<String> member4 = ["A Ravindra Babu",
//      "Ajai Kumar",
//      "Bharati Bhavsar",
//      "Kirit K Patel",
//      "Milind S Bokil",
//      "Rajiv Bhartari",
//      "Sujatha Byravan",
//      "Usha Raghupathi"
//    ];
//    List<String> member5 = ["Aaradhana Kohli",
//      "Dhananjai Mohan",
//      "Girija P Pande",
//      "Isha Prasad Bhagwat",
//      "Jonnalagadda Raghava Rao",
//      "Krishna Gopal Saxena",
//      "Mahesh K Patil",
//      "Priti Joshi",
//      "Saroj Dash",
//      "Sudha Nair",
//      "Suahsini Ayer Guigan",
//      "Vimal Garg",
//    ];
//    List<String> member6 = ["Anil P Tambay",
//      "A Santhosh Mathew",
//      "Chitra Rajagopal",
//      "Deepti Chirmulay",
//      "Digvijay Singh Khati",
//      "K V Devi Prasad",
//      "Lokendra Thakkar",
//      "Malvika Vohra",
//      "Panna Ram Siyag",
//      "Prasanta K Tripathy",
//      "Purandar Chakravarty",
//      "Raj Kumar Verma",
//      "Ravi Duggal",
//      "Soham A Pandya",
//      "T Chandini"
//    ];
//    List<String> member7 = ["Ajit Kumar Jha",
//      "Anoop Upadhyaya",
//      "Archana Jagdish Godbole",
//      "Brij Mohan S Rathore",
//      "Vinayak K Rao",
//      "Lalbiak M Ngente",
//      "Mamita Bora",
//      "Mona Dhamankar",
//      "Ganesh Pangare",
//      "Pragya D Varma",
//      "Salim Javed",
//      "Tejinder Singh Bhogal",
//      "Veena Ravichandran",
//      "Yedla PADMAVATHI"
//    ];
//    List<String> member8 = ["Aanchal Kapur",
//      "Abey George",
//      "Ajith Venniyoor",
//      "Amba Jamir",
//      "Anuradha Chaturvedi",
//      "Asha Ramachandran",
//      "Ashok Tanurkar",
//      "Burla Padma Shrinavas Rao",
//      "Hemendra B Shinde",
//      "Pranab K Paul",
//      "Richa Pant",
//      "Rustam Vania",
//      "Shanchothung Odyuo",
//      "Sunder Subramanian",
//      "Thomas Chandy"
//    ];
//    List<String> member9 = ["Ajay Narayanan",
//      "B K Kakkade",
//      "Deepak Apte",
//      "Kireet Kumar",
//      "Kirtida Oza",
//      "Mamatha B R Gowda",
//      "Pallava Bagla",
//      "Pankaj Sekshsaria",
//      "Pushkin Phartiyal",
//      "Ramasamy SEENIVASAN",
//      "Ranjana Ganguly",
//      "Saroj Barik",
//      "Shashikant Chopde",
//      "Shruti Sharma"
//    ];
//    List<String> member10 = ["Abhay Vaidya",
//      "Chavakula Naga Seshu Kumar",
//      "Divya Lata",
//      "Gazala Shaikh",
//      "K Malmarugan",
//      "Kapil Mohan",
//      "Kulbhushan Balooni",
//      "Rahul Chandawarkar",
//      "Shikhu Phutoli"
//    ];
//    List<String> member11 = ["Arun K Verma",
//      "Bharati Chaturvedi",
//      "C N Anil",
//      "Chandra Mohan Bodhapati",
//      "Chingmak Kejong",
//      "Girija Godbole",
//      "Jyoti C Sharma",
//      "Manisha Verma",
//      "N Muthu Velayutham",
//      "Nalong Mize",
//      "Parag Ajit Rangnekar",
//      "Sandeep Dash",
//      "Sanjay V Deshmukh",
//      "Suneetha Dasappa Kacker",
//      "Surya Prasad Acharya",
//      "Verghese Theckanath"
//    ];
//    List<String> member12 = ["Aman Singh",
//      "Damandeep Singh",
//      "Glenn Kalavampara",
//      "Dr. Girish C S Negi",
//      "Harleen Kaur",
//      "Madhu Verma",
//      "Monijinir Byapari",
//      "Sudhir K Sinha",
//      "Trupti Jain"
//    ];
//    List<String> member13 = ["Anish Andheria",
//      "Samir Audi",
//      "Niraj Bhatiker",
//      "Snehil Kumar",
//      "Sudip Mitra",
//      "Nila Pandian",
//      "Ruth Aparna Raju",
//      "Bandu Sane",
//      "Bibhudutta Sahoo",
//      "Meeta Srivastava",
//      "Hekali Zhimomi"
//    ];
//    List<String> member14 = ["Alexander Amirtham",
//      "Bharat Patwal",
//      "Jagdish R Desai",
//      "Krishna V Kulkarni",
//      "Seema Awasthi",
//      "Siddarth D’Souza"
//    ];
//    List<String> member15 = ["Divya Kirti Gupta",
//      "Indril Guha",
//      "Mahesh Mahajan",
//      "Niraj Subrat"
//    ];
//    List<String> member16 = ["Ambuj Kishore",
//      "Anna Kalisch",
//      "Ashish Rai",
//      "Bhawana Luthra",
//      "Chittaranjan Hota",
//      "Gajanan Kale",
//      "Gopal Shankar Singh",
//      "Kanika Pal",
//      "Sandeep Mehto",
//      "Vijai Pratap Singh"
//    ];
//    List<String> member17 = ["Abhiyant Suresh Tiwari",
//      "Amor Nath Mondal",
//      "Anand S Jadhav",
//      "Ishaan Agarwal",
//      "Jyotiraj Patra",
//      "Leena Bhiku Verenkar",
//      "Madegowda",
//      "Neha Sinha",
//      "Parabita Basu",
//      "Radhika Kothari",
//      "Raju Sharma",
//      "Ramya K",
//      "Sanjay Jothe",
//      "Seema Mishra",
//      "Somya Bhatt Wadhwan",
//      "Vani Manocha",
//      "Vijay Vardhwan Vasireddy"
//    ];
//    List<String> member18 = ["Debartha Banerjeee",
//      "Dr. Jay Agravat",
//      "Jafer Hisham",
//      "Pushpa Pal",
//      "Manjunath Lakshmikanthan",
//      "Maulik Sisodia",
//      "Sethrichem Sangtam",
//      "Shibanand Rath"
//    ];
//    List<String> member19 = ["Captan Afzal Habib Amdani",
//      "Appala Reddy Yendreddi",
//      "Archana Relan",
//      "Arpit Awasthi",
//      "Dishant P Parasharya",
//      "Jayesh K Jain",
//      "Mona Yadav",
//      "Pankaj K Satija",
//      "Raju Ghimire",
//      "Rinchen Dolma",
//      "Ruchi Varma",
//      "Senthl K Manivasagan",
//      "Shubha Khadke",
//      "Upasana Choudhry",
//      "Vidya Nair",
//      "Waseem Iqbal"
//    ];
//
//    Map<String, dynamic> field = {
//      "profileOrganisation": "",
//      "group": "",
//    };
//
//    Map<String, dynamic> field1 = {
//      "membersName" : member1,
//    };
//    Map<String, dynamic> field2 = {
//      "membersName" : member2,
//    };
//    Map<String, dynamic> field3 = {
//      "membersName" : member3,
//    };
//    Map<String, dynamic> field4 = {
//      "membersName" : member4,
//    };
//    Map<String, dynamic> field5 = {
//      "membersName" : member5,
//    };
//    Map<String, dynamic> field6 = {
//      "membersName" : member6,
//    };
//    Map<String, dynamic> field7 = {
//      "membersName" : member7,
//    };
//    Map<String, dynamic> field8 = {
//      "membersName" : member8,
//    };
//    Map<String, dynamic> field9 = {
//      "membersName" : member9,
//    };
//    Map<String, dynamic> field10 = {
//      "membersName" : member10,
//    };
//    Map<String, dynamic> field11 = {
//      "membersName" : member11,
//    };
//    Map<String, dynamic> field12 = {
//      "membersName" : member12,
//    };
//    Map<String, dynamic> field13 = {
//      "membersName" : member13,
//    };
//    Map<String, dynamic> field14 = {
//      "membersName" : member14,
//    };
//    Map<String, dynamic> field15 = {
//      "membersName" : member15,
//    };
//    Map<String, dynamic> field16 = {
//      "membersName" : member16,
//    };
//    Map<String, dynamic> field17 = {
//      "membersName" : member17,
//    };
//    Map<String, dynamic> field18 = {
//      "membersName" : member18,
//    };
//    Map<String, dynamic> field19 = {
//      "membersName" : member19,
//    };
//
//    fieldRef.document("Cohort-1").updateData(field1);
//    fieldRef.document("Cohort-2").updateData(field2);
//    fieldRef.document("Cohort-3").updateData(field3);
//    fieldRef.document("Cohort-4").updateData(field4);
//    fieldRef.document("Cohort-5").updateData(field5);
//    fieldRef.document("Cohort-6").updateData(field6);
//    fieldRef.document("Cohort-7").updateData(field7);
//    fieldRef.document("Cohort-8").updateData(field8);
//    fieldRef.document("Cohort-9").updateData(field9);
//    fieldRef.document("Cohort-10").updateData(field10);
//    fieldRef.document("Cohort-11").updateData(field11);
//    fieldRef.document("Cohort-12").updateData(field12);
//    fieldRef.document("Cohort-13").updateData(field13);
//    fieldRef.document("Cohort-14").updateData(field14);
//    fieldRef.document("Cohort-15").updateData(field15);
//    fieldRef.document("Cohort-16").updateData(field16);
//    fieldRef.document("Cohort-17").updateData(field17);
//    fieldRef.document("Cohort-18").updateData(field18);
//    fieldRef.document("Cohort-19").updateData(field19);
//
//
//    fieldRef.getDocuments().then((value) =>
//    {
//      for (DocumentSnapshot doc in value.documents) {
//        doc.reference.updateData(field)
//      }
//    });
//
//  }

//  final fieldRef = Firestore.instance.collection("SecUsers");
//
//  Map<String, dynamic> field = {
//    "token" : "",
//  };
//
//  fieldRef.getDocuments().then((value) =>
//  {
//  for (DocumentSnapshot doc in value.documents) {
//  doc.reference.updateData(field),
//  print("runing................. "),
//  }
//  });

  updateProfile() async {
    QuerySnapshot userInfoSnapshot =
        await databaseMethods.getUserInfo(Constants.myEmail);
    String docId = userInfoSnapshot.documents[0].documentID;
    print("DOCUMENT ID IS $docId");

    if (nameTextEditingController.text != "") {
      await Firestore.instance
          .collection('Users')
          .document(docId)
          .updateData({'name': nameTextEditingController.text});
      Constants.myName = await nameTextEditingController.text;
      await HelperFunctions.saveUserNameSharedPreference(
          nameTextEditingController.text);
    }
    if (mobileNoTextEditingController.text != "") {
      await Firestore.instance
          .collection('Users')
          .document(docId)
          .updateData({'phoneNumber': mobileNoTextEditingController.text});
      Constants.myPhoneNumber = await mobileNoTextEditingController.text;
      await HelperFunctions.saveUserPhoneNoSharedPreference(
          mobileNoTextEditingController.text);
    }
    // if (groupTextEditingController.text != "")
    //   {
    //     await Firestore.instance
    //         .collection('Users').document(docId)
    //         .updateData({'group': groupTextEditingController.text});
    //     Constants.myGroup = await groupTextEditingController.text;
    //     await HelperFunctions.saveUserGroupSharedPreference(groupTextEditingController.text);
    //   }
    if (bioTextEditingController.text != "") {
      await Firestore.instance
          .collection('Users')
          .document(docId)
          .updateData({'profileBio': bioTextEditingController.text});
      Constants.myBio = await bioTextEditingController.text;
      await HelperFunctions.saveUserBioSharedPreference(
          bioTextEditingController.text);
    }

//      await Firestore.instance
//          .collection('Users').document(docId)
//          .updateData({'profileDesignation': designationTextEditingController.text,
//        'profileOrganisation': organisationTextEditingController.text,
//        'group': groupTextEditingController.text,
//        'profileBio': bioTextEditingController.text});

    //addField();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Image.asset(
            "assets/images/sandesh.png",
            height: 40,
          ),
          backgroundColor: Colors.orangeAccent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: new Column(
        children: <Widget>[
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
//                  SizedBox(height: 20),
                  ListTile(
                    //leading: const Icon(Icons.phone),
                    title: new TextFormField(
                      maxLength: 30,
                      controller: nameTextEditingController,
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),

                  ListTile(
                    //leading: const Icon(Icons.phone),
                    title: new TextFormField(
                      maxLength: 30,
                      controller: mobileNoTextEditingController,
                      decoration: new InputDecoration(
                        hintText: "Mobile No.",
                      ),
                    ),
                  ),

//                  SizedBox(height: 10,),
                  ListTile(
                    //leading: const Icon(Icons.description),
                    title: new TextFormField(
                      maxLines: 4,
                      maxLength: 240,
                      controller: bioTextEditingController,
                      decoration: new InputDecoration(
                        hintText: "Bio",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () {
                updateProfile();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.green, Colors.green])),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
