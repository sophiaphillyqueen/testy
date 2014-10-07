# lookup_option -- Looks up a variable-specification option from the command-line
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

# Argument 1: Option to look up
# Argument 2: Default value of option (used as  value if found option isn't '=' qualified)
# Argument 3: <= Destination of value of option (left alone if this function returns 'false').
# Return - 'true' if option was found - 'false' if it was not
sub lookup_option {
  my $lc_argum;
  my $lc_nomos;
  my $lc_valus;
  foreach $lc_argum (@ARGV)
  {
    # First what we do if this is an unqualified option
    if ( $lc_argum eq $_[0] )
    {
      $_[2] = $_[1];
      return ( 2 > 1 );
    }
    
    # Now we do the equalization split ....
    ($lc_nomos,$lc_valus) = split(quotemeta("="),$lc_argum,2);
    
    # So if this is an equal-qualified option .....
    if ( $lc_nomos eq $_[0] )
    {
      $_[2] = $lc_valus;
      return ( 2 > 1 );
    }
  }
  
  # Well --- guess we didn't find it ....
  return ( 1 > 2 );
}

