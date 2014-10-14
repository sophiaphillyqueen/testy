# pack_ab.fn.pl -- Utilities for storing an active recipe-script run in perlref type AB.
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
#
# WARNING:
#   The PERL implementation of 'chorebox-configure' will use JSON
#   for this purpose -- but it still (at this point) is not yet
#   guaranteed that the C implementation in the future will do
#   the same.
#     For this reason, it is advised that no files that are saved
#   to disk in this format be tracked by the version-control
#   software, but instead, registered in the ".gitignore" or
#   the equivalent for your version-control program of choice.
#
# ########################
#
# ########################

use JSON;


# This function backs up the current world process for
# restoration later.
sub pack_ab_backup {
  my %lc_hsh = {};
  my $lc_ref;
  my $lc_rtn;
  
  # For starters, the world-logic information must
  # be passed.
  $lc_hsh{"child-world"} = $child_world;
  if ( $child_world > 5 )
  {
    $lc_hsh{"parent-world"} = json_decode($parent_world);
    $lc_hsh{"current-world-name"} = $current_world_name;
  }
  $lc_hsh{"world-matrices"} = \%world_matrices;
  
  # Now the basics regarding the line-numbers of the file.
  $lc_hsh{"recipe-lines"} = \@make_lines;
  $lc_hsh{"recipe-location"} = $make_indx;
  $lc_hsh{"recipe-labels"} = \%make_label;
  $lc_hsh{"recipe-filename"} = $recipe_file;
  
  # Oh - knowing where you are in the program must include
  # knowing the loop information.
  $lc_hsh{"loop-stack"} = \@frochstack;
  $lc_hsh{"loop-start"} = $frochstart;
  $lc_hsh{"loop-list"} = \@frochlist;
  $lc_hsh{"loop-variable"} = $frochvari;
  $lc_hsh{"loop-source"} = $frochfont;
  
  # And the variables (both strings and arrays) must be
  # passed as well - and the logic stack too.
  $lc_hsh{"string-variables"} = \%strgvars;
  $lc_hsh{"array-variables"} = \%strarays;
  $lc_hsh{"data-stack"} = \@litstack;
  
  #$lc_hsh{"xxxxx"} = $xxxxx;
  #$lc_hsh{"xxxxx"} = $xxxxx;
  #$lc_hsh{"xxxxx"} = $xxxxx;
    
  $lc_ref = \%lc_hsh;
  $lc_rtn = encode_json $lc_ref;
  return $lc_rtn;
}

# This function restores a world process previously backed
# up by &pack_ab_backup.
sub pack_ab_restore {
  my $lc_a;
  my $lc_tmp;
  
  $lc_a = decode_json $_[0];
  
  # For starters, the world-logic information must
  # be passed.
  $child_world = $lc_a->{"child-world"};
  if ( $child_world > 5 )
  {
    $parent_world = json_encode($lc_a->{"parent-world"});
    $current_world_name = $lc_a->{"current-world-name"};
  } else {
    $parent_world = "";
    $current_world_name = "";
  }
  $lc_tmp = $lc_a->{"world-matrices"};
  %world_matrices = %$lc_tmp;
 
  # Now the basics regarding the line-numbers of the file.
  $lc_tmp = $lc_a->{"recipe-lines"};
  @make_lines = @$lc_tmp;
  $make_length = @make_lines;
  $make_indx = $lc_a->{"recipe-location"};
  $lc_tmp = $lc_a->{"recipe-labels"};
  %make_label = %$lc_tmp;
  $recipe_file = $lc_a->{"recipe-filename"};
  
  # Oh - knowing where you are in the program must include
  # knowing the loop information.
  $lc_tmp = $lc_a->{"loop-stack"};
  @frochstack = @$lc_tmp;
  $frochstart = $lc_a->{"loop-start"};
  $lc_tmp = $lc_a->{"loop-list"};
  @frochlist = @$lc_tmp;
  $frochvari = $lc_a->{"loop-variable"};
  $frochfont = $lc_a->{"loop-source"};
  
  # And the variables (both strings and arrays) must be
  # passed as well - and the logic stack too.
  $lc_tmp = $lc_a->{"string-variables"};
  %strgvars = @$lc_tmp;
  $lc_tmp = $lc_a->{"array-variables"};
  %strarays = @$lc_tmp;
  $lc_tmp = $lc_a->{"data-stack"};
  @litstack = @$lc_tmp;
  
  #$xxxxx = $lc_a->{"xxxxx"};
  #$xxxxx = $lc_a->{"xxxxx"};
}


