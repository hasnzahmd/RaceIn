import '../constants/team_details.dart';

getTeamColor(teamId) {
  for (var detail in teamDetails) {
    if (detail['id'] == teamId) {
      return detail['color'];
    }
  }
  return '0xFF000000';
}
