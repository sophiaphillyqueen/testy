# action__qry_l - "qry-l" directive - var query for local system
# Copyright (C) 2014  Sophia Elizabeth Shapira
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# ########################


sub action__qry_l {
  my $lc_sourcevar;
  my $lc_destvar;
  my $lc_no_goto;
  my $lc_yes_goto;
  my $lc_src_value;
  my $lc_dst_value;
  
  ($lc_sourcevar,$lc_destvar,$lc_no_goto,$lc_yes_goto) = split(/:/,$_[0]);
  $lc_src_value = $strgvars{$lc_sourcevar};
  $lc_dst_value = `$lc_src_value`; chomp($lc_dst_value);
  $strgvars{$lc_destvar} = $lc_dst_value;
  
  if ( $lc_dst_value eq "" )
  {
    &then_goto_label($lc_no_goto);
    return;
  }
  &then_goto_label($lc_yes_goto);
}


