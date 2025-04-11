import 'package:idiot_community_club_app/Page/Club_Page/0_ClubHome.dart';
import 'package:idiot_community_club_app/Page/Club_Page/1_CreateClub.dart';
import 'package:idiot_community_club_app/Page/Club_Page/2_MyClubForm.dart';
import 'package:idiot_community_club_app/Page/Club_Page/3_MyCreatedClub.dart';
import 'package:idiot_community_club_app/Page/Club_Page/4_JoiedClubs.dart';
import 'package:idiot_community_club_app/Page/Club_Page/5_ClubRequest.dart';
import 'package:idiot_community_club_app/Page/Club_Page/ClubMain.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/0_CreatorStartPage.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/1.1_ComReg.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/1_CreatorLogin.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/2_CreatorHome.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/2_CreatorMain.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/3_CommunityHome.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/4_CreatorProfile.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/5_CommunityMember.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/6_CommunityClub.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/7_ClubCreateReview.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/8_CommunityMemberList.dart';
import 'package:idiot_community_club_app/Page/Joined_Club_Page/0_ViewAnnouncement.dart';
import 'package:idiot_community_club_app/Page/Joined_Club_Page/1_JoinedCLubDetail.dart';
import 'package:idiot_community_club_app/Page/Joined_Club_Page/2_JoinedClubMembers.dart';
import 'package:idiot_community_club_app/Page/Main_Page/LuanchPage.dart';
import 'package:idiot_community_club_app/Page/Main_Page/StartPage.dart';
import 'package:idiot_community_club_app/Page/Member_Page/0_MemberStartPage.dart';
import 'package:idiot_community_club_app/Page/Member_Page/1.1_MemberRegister.dart';
import 'package:idiot_community_club_app/Page/Member_Page/1_MemberLogin.dart';
import 'package:idiot_community_club_app/Page/Member_Page/2_CommunityMemberHome.dart';
import 'package:idiot_community_club_app/Page/Member_Page/3_CommunityMemberRequest.dart';
import 'package:idiot_community_club_app/Page/Member_Page/4_MyCommunity.dart';
import 'package:idiot_community_club_app/Page/Member_Page/5_MemberProfile.dart';
import 'package:idiot_community_club_app/Page/Member_Page/MemberMain.dart';
import 'package:idiot_community_club_app/Page/My_Club_page/clubAnnouncement.dart';
import 'package:idiot_community_club_app/Page/My_Club_page/clubDetail.dart';
import 'package:idiot_community_club_app/Page/My_Club_page/clubMember.dart';
import 'package:idiot_community_club_app/Page/My_Club_page/clubMemberRequest.dart';

class IdiotRoutes {
  static var routes = {
    "/": (context) => LuanchPage(),
    "/startPage": (context) => StartPage(),

    //Creator Routes
    "/creatorStartPage": (context) => CreatorStartPage(),
    "/creatorLogin": (context) => CreatorLogin(),
    "/creatorMain": (context) => CreatorMainScreen(),
    "/communityHomeCreate": (context) => CommunityHomeCreate(),
    "/home": (context) => CommunityHome(),
    // "/profile": (context) => CreatorProfile(creatorId: widget.creatorId),
    "/member": (context) => CommunityMember(),
    "/club": (context) => CommunityClub(),
    "/clubCreateReview": (context) => ClubCreateReview(),
    "/communityMemberList": (context) => CommunityMemberList(),
    "/comReg": (context) => ComReg(),

    //MemberRoutes
    "/memberStartPage": (context) => MemberStartPage(),
    "/memberLogin": (context) => MemberLogin(),
    "/memReg": (context) => MemberRegister(),
    // "/": (context) => CommunityMemberHome(),
    "/communityMemberHome": (context) => MemberMainScreen(),
    "/comReqForm": (context) => CommunityMemberRequest(),
    "/myCommunity": (context) => MyCommunity(),
    "/memberProfile": (context) => MemberProfile(),

    //ClubRoutes
    "/clubHome": (context) => ClubMainScreen(),
    "/myClub": (context) => MyClub(),
    "/myClubForm": (context) => MyClubForm(),
    "/myCreatedClub": (context) => MyCreatedClub(),
    "/joiedClub": (context) => JoinedClub(),
    "/clubRequest": (context) => ClubRequest(),

    //Joined Club Routes
    "/viewAnnouncement": (context) => ViewAnnouncement(),
    "/joinedClubDetail": (context) => JoinedClubDetail(),
    "/joinedClubMembers": (context) => JoinedClubMembers(),

    //MyClubRoutes
    "/myClubAnouncement": (context) => MyClubAnnouncemnt(),
    "/myClubMember": (context) => MyClubMember(),
    "/myClubDetail": (context) => MyClubDetail(),
    "/myClubMemberRequest": (context) => ClubMemberRequest(),
  };
}
