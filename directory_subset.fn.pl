# directory_subset - PERL function checks if second argument specifies
#     a directory that resides within the first.
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

sub directory_subset {
  my $lc_elder;
  my $lc_younger;
  my $lc_chr;
  
  ($lc_elder,$lc_younger) = @_;
  if ( $lc_elder eq $lc_younger ) { return ( 2 > 1 ); }
  if ( $lc_elder eq "/" ) { return ( 2 > 1 ); }
  
  while ( $lc_younger ne "" )
  {
    $lc_chr = chop($lc_younger);
    if ( $lc_chr eq "/" )
    {
      if ( $lc_elder eq $lc_younger ) { return ( 2 > 1 ); }
    }
  }
  return ( 1 > 2 );
}

