# meaning_of - Interprets a complex string definition
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

sub meaning_of {
  my @lc_a;
  my @lc_b;
  
  @lc_a = split(/:/,$_[0],2);
  if ( $lc_a[0] eq "lit" ) { return $lc_a[1]; }
  
  if ( $lc_a[0] eq "var" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $strgvars{$lc_b[0]};
  }
  
  if ( $lc_a[0] eq "par" )
  {
    return &meaning__of_parent($lc_a[1]);
  }
  
  
  # "varqry" does a current-system query command based on a variable with
  # one goto target if the output has content and another if the output
  # is empty.
  # :varqry:<source>:<dest>:<goto-if-empty>:<goto-if-full>:
  
  # "flqry" is just like "dqry", except that it will not cause
  # a fatal-error if the output is empty.
  if ( $lc_a[0] eq "flqry" )
  {
    my $lc2_a;
    my $lc2_b;
    
    $lc2_a = $lc_a[1];
    $lc2_b = `$lc2_a`; chomp($lc2_b);
    return $lc2_b;
  }
  
  if ( $lc_a[0] eq "qry" )
  {
    my $lc2_a;
    my $lc2_b;
    
    $lc2_a = $lc_a[1];
    $lc2_b = `$lc2_a`; chomp($lc2_b);
    if ( $lc2_b eq "" )
    {
      die "\nFATAL ERROR:\n  Empty result for the following query command:\n  %"
        . $lc2_a . "\n\n";
      ;
    }
    return $lc2_b;
  }
  
  # Dynamic query -- for things such as build-time.
  # It's implementation is like the early implementations
  # of "qry" - except that later on, "qry" will be
  # altered to check the query in the target-system
  # query-result file if one is specified - while "dqry"
  # will always continue to just get the output of a
  # shell command.
  if ( $lc_a[0] eq "dqry" )
  {
    my $lc2_a;
    my $lc2_b;
    
    $lc2_a = $lc_a[1];
    $lc2_b = `$lc2_a`; chomp($lc2_b);
    if ( $lc2_b eq "" )
    {
      die "\nFATAL ERROR:\n  Empty result for the following query command:\n  %"
        . $lc2_a . "\n\n";
      ;
    }
    return $lc2_b;
  }
  
  if ( $lc_a[0] eq "info" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $proj_info_s{$lc_b[0]};
  }
  
  if ( $lc_a[0] eq "linfo" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $proj_info_l{$lc_b[0]};
  }
  
  if ( $lc_a[0] eq "shl" )
  {
    my $lc2_a;
    my $lc2_b;
    my $lc2_c;
    
    $lc2_a = &meaning_of($lc_a[1]);
    $lc2_b = "";
    while ( $lc2_a ne "" )
    {
      $lc2_c = chop($lc2_a);
      if ( $lc2_c eq "'" ) { $lc2_c = "'\"'\"'"; }
      $lc2_b = $lc2_c . $lc2_b;
    }
    return $lc2_b;
  }
  
  if ( $lc_a[0] eq "gscp" )
  {
    my $lc2_a;
    my $lc2_b;
    my $lc2_c;
    
    $lc2_a = &meaning_of($lc_a[1]);
    $lc2_b = "";
    while ( $lc2_a ne "" )
    {
      $lc2_c = chop($lc2_a);
      if ( $lc2_c eq "#" ) { $lc2_c = "\\#"; }
      if ( $lc2_c eq "!" ) { $lc2_c = "\\!"; }
      $lc2_b = $lc2_c . $lc2_b;
    }
    return $lc2_b;
  }
  
  die "\nUnknown complex string-type: \""
    . $lc_a[0] . "\" in line " . int($make_indx + 1.2)
    . ":\n  " . $make_lines[$make_indx] . "\n\n"
  ;
}



sub meaning__of_parent {
  my $lc_par_level;
  my $lc_par_vnom;
  my $lc_each_ancestor;
  my @lc_rev_parent;
  my $lc_many_parent;
  
  ($lc_par_level,$lc_par_vnom) = split(/:/,$_[0]);
  
  # Generate reverse parent stack:
  @lc_rev_parent = ();
  foreach $lc_each_ancestor (@over_scripts)
  {
    @lc_rev_parent = ($lc_each_ancestor,@lc_rev_parent);
  }
  # And determine it's size:
  $lc_many_parent = @lc_rev_parent;
  if ( $lc_par_level > ( $lc_many_parent + 0.5 ) )
  {
    die "\n"
      . "Requested ancestor " . $lc_par_level . " where only " . $lc_many_parent
      . "are available.\n"
      . "This mistake is done here: \""
      . $recipe_file . "\" in line " . int($make_indx + 1.2)
      . ":\n  " . $make_lines[$make_indx] . "\n\n"
    ;
  }
  $lc_par_level = int($lc_par_level - 0.8);
  if ( $lc_par_level < 0 ) { $lc_par_level = 0; }
  return &var_from_packing($lc_rev_parent[$lc_par_level],$lc_par_vnom);
}


