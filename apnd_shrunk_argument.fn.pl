# apnd_shrunk_argument.fn.pl - Functions to encode arguments to
#   a shell command in such a way that once the shell processes them,
#   they will revert to their original state rather than something
#   weird.
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


# This function appends all the arguments other than the first
# one onto the end of the shell-command string that is the first
# argument - encoding all of the newly-appended arguments in a
# manner that is the reverse of the shell-parsing.
sub apnd_shrunk_argument {
  my @lc_buffet;
  my $lc_command;
  my $lc_arg_a;
  my $lc_arg_b;
  
  @lc_buffet = @_;
  if ( !(&goodarray(@lc_buffet)) ) { return; }
  $lc_command = shift(@lc_buffet);
  
  while ( &goodarray(@lc_buffet) )
  {
    if ( $lc_command ne "" ) { $lc_command .= " "; }
    $lc_arg_a = shift(@lc_buffet);
    $lc_arg_b = &shrinkwrap_argument($lc_arg_a);
    $lc_command .= $lc_arg_b;
  }
  $_[0] = $lc_command;
}

# The following function takes one string and encodes it in such
# a way that when the shell gets through processing it, it will
# return to be just the way it was before this function encoded
# it to begin with. This is useful so as to *effectively* pass an
# argument to a string-form shell command while not subjecting
# it to the shell parsing.
sub shrinkwrap_argument {
  my $lc_src;
  my $lc_dst;
  my $lc_ret;
  my $lc_mod; # 0 = single-quotes ----- 10 = double-quotes
  my $lc_chr;
  
  $lc_src = $_[0];
  $lc_dst = "\'";
  $lc_mod = 0;
  
  while ( $lc_src ne "" )
  {
    $lc_chr = chop($lc_src);
    
    if ( $lc_chr eq "\'" )
    {
      if ( $lc_mod < 5 )
      {
        $lc_dst .= "\'\"";
        $lc_mod = 10;
      }
    }
    
    if ( $lc_chr ne "\'" )
    {
      if ( $lc_mod > 5 )
      {
        $lc_dst .= "\"\'";
        $lc_mod = 0;
      }
    }
    
    $lc_dst .= $lc_chr;
  }
  
  if ( $lc_mod > 5 ) { $lc_dst .= "\""; }
  else { $lc_dst .= "\'"; }
  
  
  # Of course, the string we have been creating so far
  # is the *reverse* of the one that we now will return.
  $lc_ret = scalar reverse $lc_dst;
  return $lc_ret;
}



