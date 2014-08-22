# autom.fn.pl - Functions for setting up final-values of directory vars
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


sub autom {
  my $lc_each;
  
  # This directory-variable will henceforth be on the list of
  # those resolved by &autom - no matter how this function
  # ends.
  @lisdirs = (@lisdirs,$_[0]);
  
  # See if an over-ride to the default was specified ---
  # and honor it if so.
  foreach $lc_each (@dir_vars_specfied)
  {
    if ( $lc_each eq $_[0] )
    {
      $valvar{$_[0]} = $dir_vars_values{$_[0]};
      $dir_vars_real{$_[0]} = ( 2 > 1 );
      system("echo","Dir var: " . $_[0] . ":\n     set to: " . $valvar{$_[0]} . ":");
      return;
    }
  }
  
  $dir_vars_real{$_[0]} = ( 2 > 1 );
  $valvar{$_[0]} = $_[1];
  system("echo","Dir var: " . $_[0] . ":\n default to: " . $valvar{$_[0]} . ":");
}

