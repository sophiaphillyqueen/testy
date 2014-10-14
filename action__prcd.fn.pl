# action__prcd.fn.pl - Implementation of "prcd" directive.
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
# The "prcd" directive invokes a sub-script -- but by a new
# paradigm, rather than the old deprecated "run" paradigm.
# ########################

sub action__prcd {
  my @lc_rgsgs;
  my $lc_scriptname;
  my $lc_spacename;
  my $lc_spaceref;
  my $lc_old_regime;
  
  # Before we do anything else, we make sure we know our
  # arguments and have (within this function at least)
  # a snapshot of the parent process.
  @lc_rgsgs = split(quotemeta(":" . ":"),$_[0]);
  $lc_scriptname = &meaning_of($lc_rgsgs[0]);
  $lc_spacename = &meaning_of($lc_rgsgs[1]);
  $lc_spaceref = $world_matrices{$lc_spacename};
  $lc_old_regime = &pack_ab_backup;
  
  # Make sure the space-reference we are dealing with is
  # a copy not the original. (Use JSON to achieve this.)
  if ( ref($lc_spaceref) eq "HASH" ) {
    my $lc2_a;
    $lc2_a = encode_json($lc_spaceref);
    $lc_spaceref = decode_json($lc2_a);
  }
  
  # Now we set up the new world-info:
  $child_world = 10;
  $parent_world = $lc_old_regime;
  $current_world_name = $lc_spacename;
  %world_matrices = {};
  
  # And we load the new recipe file.
  &load_script_file($lc_scriptname);
  
  # And we clear the looping information:
  @frochstack = ();
  $frochstart = 0;
  @frochlist = ();
  $frochvari = "";
  $frochfont = "";
  
  # And now it is time to set up the variables.
  %strgvars = {};
  %strarays = {};
  @litstack = ();
  if ( ref($lc_spaceref) eq "HASH" )
  {
    my $lc2_a;
    
    $lc2_a = $lc_spaceref->{"strings"};
    if ( ref($lc2_a) eq "HASH" )
    {
      %strgvars = %$lc2_a;
    }
    
    $lc2_a = $lc_spaceref->{"arrays"};
    if ( ref($lc2_a) eq "HASH" )
    {
      %strarays = %$lc2_a;
    }
    
    $lc2_a = $lc_spaceref->{"stack"};
    if ( ref($lc2_a) eq "ARRAY" )
    {
      @litstack = @$lc2_a;
    }
  }
}

sub from_a__prcd {
  my %lc_hsh;
  my $lc_refa;
  my $lc_jase;
  my $lc_aname;
  my $lc_parent_world;
  
  if ( $child_world < 5 ) { return; }
  
  # First we get together a JSON account of the
  # variable-space.
  %lc_hsh = {};
  $lc_hsh{"strings"} = \%strgvars;
  $lc_hsh{"arrays"} = \%strarays;
  $lc_hsh{"stack"} = \@litstack;
  $lc_refa = \%lc_hsh;
  $lc_jase = encode_json($lc_refa);
  
  # Before we leave this world, we must know
  # it's name.
  $lc_aname = $current_world_name;
  
  # Now we return to the parent world.
  $lc_parent_world = $parent_world;
  &pack_ab_restore($lc_parent_world);
  
  # And we save the world we just left to the world matrix.
  $world_matrices{$lc_aname} = decode_json($lc_jase);
}

sub blank_world {
  my $lc_a;
  
  $lc_a = decode_json("{" .
    "\"strings\":{},\"arrays\":{},\"stack\":[]" .
  "}");
  
  return $lc_a;
}

sub action__wrlvr {
  my @lc_arg;
  my $lc_worldnom;
  my $lc_varnom;
  my $lc_varcon;
  
  @lc_arg = split(/:/,$_[0],3);
  $lc_worldnom = $lc_arg[0];
  $lc_varnom = $lc_arg[1];
  $lc_varcon = &meaning_of($lc_arg[2]);
  if ( ref($world_matrices{$lc_worldnom}) ne "HASH" )
  {
    $world_matrices{$lc_worldnom} = &blank_world;
  }
  $world_matrices{$lc_worldnom}->{"strings"}->{$lc_varnom} = $lc_varcon;
  
}

