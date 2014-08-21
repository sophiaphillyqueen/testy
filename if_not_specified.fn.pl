# if_not_specified - Specifies a <chorebox-in> *default*
# Copyright (C) 2014  Sophia Elizabeth Shapira

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# ########################


sub if_not_specified {
  my $lc_each_one;
  my $lc_been_found;
  my $lc_pre_equal;
  my $lc_junk;
  my $lc_optnom;
  
  # By default, we assume that the option does
  # not previously exist.
  $lc_been_found = ( 1 > 2 );
  
  # But then we check to see if it *does* previously
  # exist.
  foreach $lc_each_one (@legacy_options)
  {
    ($lc_pre_equal) = split(quotemeta("="),$lc_each_one);
    $lc_pre_equal = "xx" . $lc_pre_equal;
    ($lc_junk,$lc_optnom) = split(quotemeta("--"),$lc_pre_equal,2);
    if ( $lc_optnom eq $_[0] ) { $lc_been_found = ( 2 > 1 ); }
  }
  
  # Let us do nothing more if it previously exists.
  if ( $lc_been_found ) { return; }
  
  # This is where we add the option if it does not previously exist.
  @myown_options = (@myown_options, "--" . $_[0] . "=" . $_[1]);
}



