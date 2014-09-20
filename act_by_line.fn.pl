# act_by_line -- Main way that a line of the Makefile recipe is interpreted
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

sub act_by_line {
  my @lc_a;
  my $lc_tmcm;
  @lc_a = split(/:/,$_[0],3);
  
  if ( $lc_a[1] eq "" ) { return; }
  if ( $lc_a[1] eq "#" ) { return; }
  if ( $lc_a[1] eq "label" ) { return; }
  
  $lc_tmcm = "-";
  if ( $lc_a[1] eq $lc_tmcm )
  {
    $adendia .= "\n" . $lc_a[2];
    return;
  }
  $lc_tmcm .= ">";
  if ( $lc_a[1] eq $lc_tmcm )
  {
    $adendia .= "\n\t" . $lc_a[2];
    return;
  }
  $lc_tmcm .= ">";
  if ( $lc_a[1] eq $lc_tmcm )
  {
    $adendia .= "\n\t\t" . $lc_a[2];
    return;
  }
  
  if ( $lc_a[1] eq "*" )
  {
    $adendia .= $lc_a[2];
    return;
  }
  
  
  die "\nUnknown Makefile Recipe Command in line " . int($make_indx + 1.2)
    . ":\n  " . $_[0] . "\n\n";
  ;
}

