import '../constants/team_details.dart';

getTeamColor(teamId) {
  switch (teamId) {
    case 13:
      return teamDetails[0]['color'];

    case 17:
      return teamDetails[1]['color'];

    case 3:
      return teamDetails[2]['color'];

    case 14:
      return teamDetails[3]['color'];

    case 18:
      return teamDetails[4]['color'];

    case 2:
      return teamDetails[5]['color'];

    case 5:
      return teamDetails[6]['color'];

    case 1:
      return teamDetails[7]['color'];

    case 7:
      return teamDetails[8]['color'];

    case 12:
      return teamDetails[9]['color'];

    default:
      return '0xFF000000';
  }
}
