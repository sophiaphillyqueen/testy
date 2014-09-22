# action__varfromopt -- What "chorebox-configure" does for "varfromopt" directive.
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


sub action__varfromopt {
  my $lc_vardst;
  my $lc_qrsorc;
  my $lc_eacharg;
  my $lc_argnom;
  my $lc_argval;
  my $lc_dfolt;
  
  ($lc_vardst,$lc_qrsorc,$lc_dfolt) = split(/:/,$_[0],3);
  foreach $lc_eacharg (@ARGV)
  {
    ($lc_argnom,$lc_argval) = split(quotemeta("="),$lc_eacharg);
    if ( $lc_argnom eq $lc_eacharg )
    {
      $lc_argval = $lc_dfolt;
    }
    if ( $lc_argnom eq $lc_qrsorc )
    {
      $strgvars{$lc_vardst} = $lc_argval;
      system("echo","  Thought variable: " . $lc_vardst . ": = " . $lc_argval . ":");
      return;
    }
  }
  
}

