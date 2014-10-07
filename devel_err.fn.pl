# devel_err_<x> - Fatal-error messages if this is run in developer mode.
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

sub devel_err_aa {
  my $lc_erc;
  my $lc_rg;
  if ( !($developer_mode) ) { return; }
  
  $lc_erc = "\nFATAL ERROR: Improper Coding in Developer Mode:\n";
  $lc_erc .= "Line " . int($make_indx + 1.2) . " in file \"";
  $lc_erc .= $recipe_file . "\":\n";
  $lc_erc .= "  " . $make_lines[$make_indx] . "\n";
  foreach $lc_rg (@_)
  {
    $lc_erc .= "-" . "> " . $lc_rg . "\n";
  }
  $lc_erc .= "\n";
  die $lc_erc;
}