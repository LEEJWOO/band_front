//dependencies
import 'package:band_front/pages/activity_detail.dart';
import 'package:band_front/pages/club_manage.dart';
import 'package:band_front/pages/club_regist.dart';
import 'package:band_front/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// pages
import '../pages/club_edit.dart';
import '../pages/login.dart';
import '../pages/club_list.dart';
import '../pages/club_detail.dart';
import '../pages/profile.dart';
import '../pages/club_members.dart';

class RouterPath {
  static const String myClubList = "/myClubList";
  static const String myProfilePage = '/myClubList/myProfile';
  static const String myProfileEdit = '/myClubList/myProfile/myProfileEdit';

  static const String clubDetailPage = '/myClubList/clubDetail';
  static const String members = '/myClubList/clubDetail/members';

  static const String manage = '/myClubList/clubDetail/manage';

  static const String clubEdit = '/myClubList/clubDetail/manage/edit';

  static const String activityDetail = '/myClubList/clubDetail/activityDetail';

  static const String clubRegist = '/myClubList/clubRegist';

  static const String userProfile = "/userProfile";
}

// context.go(
//   '/myClubList/clubDetail',
//   extra: {'clubId': '$index'},
// );

final GoRouter route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignView(),
      routes: [
        GoRoute(
          path: 'myClubList',
          builder: (context, state) => const ClubListView(),
          routes: [
            GoRoute(
              path: 'clubDetail',
              builder: (context, state) {
                final Map<String, dynamic>? argument =
                    state.extra as Map<String, dynamic>?;
                var clubId = argument?['clubId'];
                var role = argument?['role'];
                return ClubDetailView(clubId: clubId, role: role);
              },
              routes: [
                GoRoute(
                  path: "manage",
                  builder: (context, state) => ClubManage(),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) => ClubEditView(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'members',
                  builder: (context, state) {
                    final Map<String, dynamic>? argument =
                        state.extra as Map<String, dynamic>?;
                    var data = argument?['clubId'];
                    return ClubMemberListView(clubId: data);
                  },
                ),
                GoRoute(
                  path: 'activityDetail',
                  builder: (context, state) {
                    final Map<String, dynamic>? argument =
                        state.extra as Map<String, dynamic>?;
                    int actId = argument?['actId'];
                    int clubId = argument?['actId'];
                    return ActivityDetailView(actId: actId, clubId: clubId);
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'myProfile',
              builder: (context, state) => const MyProfileView(),
              routes: [
                GoRoute(
                  path: 'myProfileEdit',
                  builder: (context, state) => const MyProfileEditView(),
                ),
              ],
            ),
            GoRoute(
              path: 'clubRegist',
              builder: (context, state) {
                return ClubRegist();
              },
            ),
          ],
        ),
        //need to push
        GoRoute(
          path: "userProfile",
          builder: (context, state) {
            final Map<String, dynamic>? argument =
                state.extra as Map<String, dynamic>?;
            var data = argument?['username'];
            return UserProfileView(username: data);
          },
        ),
      ],
    ),
  ],
);

class ErrorPage extends StatelessWidget {
  final String err;
  const ErrorPage({super.key, required this.err});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(err)),
    );
  }
}
