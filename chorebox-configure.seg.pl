# chorebox-configure - The 'chorebox' -configure- script backend.
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


# Find out if the Makefile recipe-script is to be run
# in developer mode (i.e. die fatal error if any feature
# slated for deprecation or otherwise inappropriate is
# used).
{
  my $lc_a;
  my $lc_badval;
  my $lc_was;
  my $lc_specsrc;
  
  $lc_a = "off";
  $lc_specsrc = "x";
  $lc_was = &lookup_option("--devel_main","irp",$lc_a);
  if ( $lc_was ) { $lc_specsrc = "--devel_main"; }
  $lc_was = &lookup_option("--devel_config","irp",$lc_a);
  if ( $lc_was ) { $lc_specsrc = "--devel_config"; }
  
  $developer_mode = ( 1 > 2 );
  if ( $lc_a eq "on" ) { $developer_mode = ( 2 > 1 ); }
  if ( $lc_a eq "irp" ) { $developer_mode = ( 2 > 1 ); }
  $lc_badval = ( !($developer_mode) );
  if ( $lc_a eq "off" ) { $lc_badval = ( 1 > 2 ); }
  
  if ( $lc_badval )
  {
    die "\nInvalid developer-mode status: \"" . $lc_a . "\"\n"
      . "  specified by \"" . $lc_specsrc . "\" option.\n"
    . "\n";
  }
}
if ( $developer_mode )
{
  system("echo","Makefile Recipe-script interpreter running in developer mode.");
}


foreach $argum (@ARGV)
{
  &try_process_argum($argum);
}


# This next function will return -true- if the second argument is
# the beginning-string of the first-argument UNLESS the two be
# identical -- and -false- if the conditions for -true- are not
# met.
#   Not the most *efficient* implementation -- but hopefully a
# *reliable* one.
sub beginningst {
  my $lc_a;
  my $lc_b;
  
  ($lc_a,$lc_b) = @_;
  while ( $lc_a ne "" )
  {
    chop($lc_a);
    if ( $lc_a eq $lc_b ) { return ( 2 > 1 ); }
  }
  return ( 1 > 2 );
}

sub try_process_argum {
  my $lc_pre_equal;
  my $lc_post_equal;
  my $lc_givalue; # If it is a value-equal thing:
  my $lc_dashpred; # Is it predicated with "--"
  my $lc_optnom; # The name of the option
  my $lc_is_dirvaly;
  
  
  # Certain argument-types must be processed before all
  # others to prevent them from getting mixed up with
  # the others.
  $truthiness = ( 1 > 2 );
  
  # The "--devel_" options are options that are there for developers.
  if (!($truthiness)) { $truthiness =  &beginningst($_[0],"--devel_"); }
  
  # May as well allow the "--with_" options.
  if (!($truthiness)) { $truthiness =  &beginningst($_[0],"--with_"); }
  
  if ( $truthiness )
  {
    system("echo","Accepting Option: " . $_[0] . ":");
    return;
  }
  
  # First, we do the basic inventory on basically what kind of
  # argument we are dealing with.
  ($lc_pre_equal,$lc_post_equal) = split(quotemeta("="),$_[0],2);
  $lc_givalue = ( $lc_pre_equal ne $_[0] );
  $lc_dashpred = ( ( length $lc_pre_equal ) > 2.5 );
  if ( $lc_dashpred )
  {
    $lc_dashpred = ( ( substr $lc_pre_equal,0,2 ) eq "--" );
  }
  
  # So now we find the name of this option .....
  $lc_optnom = $lc_pre_equal;
  if ( $lc_dashpred ) { $lc_optnom = substr $lc_pre_equal,2; }
  
  # So is this an argument that names a directory variable?
  $lc_is_dirvaly = ( $lc_givalue && $lc_dashpred );
  # If it is, let us act accordingly.
  if ( $lc_is_dirvaly )
  {
    my $lc2_oldy;
    
    # Let no directory-value be processed twice.
    foreach $lc2_oldy (@dir_vars_specfied)
    {
      if ( $lc2_oldy eq $lc_optnom ) { return; }
    }
    
    # But if it has not previously been processed one by this name,
    # let us do so now.
    @dir_vars_specfied = (@dir_vars_specfied,$lc_optnom);
    $dir_vars_values{$lc_optnom} = $lc_post_equal;
    $dir_vars_real{$lc_optnom} = ( 1 > 2 ); # Fictional until found ....
    return;
  }
  
  # If we made it this far, that is because the argument passed is
  # not a recognized option.
  die "\nCAN NOT YET HANDLE OPTION:\n  " . $_[0] . ":\n\n";
}

&autom("srcdir",".");
# Okay --- we processed the "srcdir" variable -- but before
# we process any more, we must refer to the proj-info file.
{
  my $lc_cmd;
  my $lc_cont;
  my @lc_lins;
  my $lc_line;
  my $lc_xlin;
  my @lc_segs;
  my $lc_infofile;
  
  $lc_cmd = "cat";
  $lc_infofile = $valvar{"srcdir"} . "/proj-info.txt";
  
  if ( !(-f $lc_infofile) )
  {
    die "\nFATAL ERROR: Can not find file:"
      . "\n  " . $lc_infofile . ":"
      . "\n\n"
    ;
  }
  
  &apnd_shrunk_argument($lc_cmd,$lc_infofile);
  $lc_cont = `$lc_cmd`;
  @lc_lins = split(/\n/,$lc_cont);
  foreach $lc_line (@lc_lins)
  {
    $lc_xlin = "x" . $lc_line;
    @lc_segs = split(/:/,$lc_xlin);
    $proj_info_s{$lc_segs[1]} = $lc_segs[2];
    @lc_segs = split(/:/,$lc_xlin,3);
    $proj_info_l{$lc_segs[1]} = $lc_segs[2];
  }
  
  
  
  if ( $proj_info_l{"name"} eq "" )
  {
    die "\nFATAL ERROR: Missing crucial field in file:"
      . "\n  " . $lc_infofile . ":\n"
      . "We really need the field \"name\""
      . " to specify the symbolic name of the project."
      . "\n\n"
    ;
  }
  
  if ( $proj_info_l{"vrsn"} eq "" )
  {
    die "\nFATAL ERROR: Missing crucial field in file:"
      . "\n  " . $lc_infofile . ":\n"
      . "We really need the field \"vrsn\""
      . " to specify the progressive version-code."
      . "\n(FYI: The progressiver version-code is just numbers separated"
      . " by periods.)"
      . "\n\n"
    ;
  }
  
  if ( $developer_mode )
  {
    my $lc2_a;
    if ( $proj_info_l{"phase"} eq "" )
    {
      die "\nFATAL ERROR: Missing crucial field in file:"
        . "\n  " . $lc_infofile . ":\n"
        . "We really need the field \"phase\""
        . " to specify the phase of this version."
        . "\n\n"
      ;
    }
    
    $lc2_a = ( 1 > 2 );
    if ( $proj_info_s{"phase"} eq "a" ) { $lc2_a = ( 2 > 1 ); }
    if ( $proj_info_s{"phase"} eq "b" ) { $lc2_a = ( 2 > 1 ); }
    if ( $proj_info_s{"phase"} eq "c" ) { $lc2_a = ( 2 > 1 ); }
    if ( $proj_info_s{"phase"} eq "d" ) { $lc2_a = ( 2 > 1 ); }
    if ( $proj_info_s{"phase"} eq "r" ) { $lc2_a = ( 2 > 1 ); }
    
    if ( !($lc2_a) )
    {
      die "\nFATAL ERROR: Invalid project-phase specified: \"" . $proj_info_s{"phase"} . "\""
        . "\n  Here are the valid phases:\n"
        . "    a: Basic development phase for this version:\n"
        . "    b: Most of the work currently is on documentation:\n"
        . "    c: Fixing little glitches - and congealing the form:\n"
        . "    d: Last minute prep for features and documentation before release:\n"
        . "    r: Release version - only for final version with this particular number:\n"
        . "\n"
      ;
    }
  }
  
  if ( $proj_info_l{"year"} eq "" )
  {
    die "\nFATAL ERROR: Missing crucial field in file:"
      . "\n  " . $lc_infofile . ":\n"
      . "We really need the field \"year\""
      . " to specify the copyright year."
      . "\n\n"
    ;
  }
  
  if ( $proj_info_l{"holder"} eq "" )
  {
    die "\nFATAL ERROR: Missing crucial field in file:"
      . "\n  " . $lc_infofile . ":\n"
      . "We really need the field \"holder\""
      . " to specify the copyright holder(s)."
      . "\n\n"
    ;
  }
}



# Now we also must deal with the jailing.
&autom("jaildir","");
sub wardenize {
  my $lc_rg;
  my $lc_dst;
  my $lc_cn;
  my $lc_dcn;
  my $lc_jail;
  
  $lc_jail = $valvar{"jaildir"};
  foreach $lc_rg (@_)
  {
    my $lc2_lft;
    $lc_cn = $valvar{$lc_rg};
    $lc_dst = "jl_" . $lc_rg;
    $lc_dcn = $lc_cn;
    $lc2_lft = $lc_cn;
    while ( $lc2_lft ne "" )
    {
      if ( $lc2_lft eq "/" ) { $lc_dcn = $lc_jail . $lc_cn; }
      chop($lc2_lft);
    }
    &autom($lc_dst,$lc_dcn);
  }
}


&autom("prefix","/usr/local");
&autom("exec_prefix",$valvar{"prefix"});
&autom("bindir",$valvar{"exec_prefix"} . "/bin");
&autom("sbindir",$valvar{"exec_prefix"} . "/sbin");
&autom("libexecdir",$valvar{"exec_prefix"} . "/libexec");
&autom("datarootdir",$valvar{"prefix"} . "/share");
&autom("datadir",$valvar{"datarootdir"});
&autom("sysconfdir",$valvar{"prefix"} . "/etc");
&autom("sharedstatedir",$valvar{"prefix"} . "/com");
&autom("localstatedir",$valvar{"prefix"} . "/var");
&autom("runstatedir",$valvar{"localstatedir"} . "/run");
&autom("includedir",$valvar{"prefix"} . "/include");

# NOTE: Until further notice -chorebox- programs should only
# *use* the "oldincludedir" variable with GREAT TREPIDATION.
# The -chorebox-in- wrapper sets it to a value of empty
# string - which according to the GNU standards means that
# nothing should be stored here. However, unless you are
# sure of what you are doing, don't install anything here
# *regardless*.
&autom("oldincludedir","/usr/include");

# <-- docdir
# "super_docdir" added to list of directory variables so as to
# provide a means to uniformly point to where *all* program
# documentations go while still allowing individual packages
# to have their directory therewithin.
&autom("super_docdir",$valvar{"datarootdir"} . "/doc");
&autom("docdir",$valvar{"super_docdir"} . "/" . $proj_info_s{"name"} . "-" . $proj_info_s{"vrsn"});
&autom("infodir",$valvar{"datarootdir"} . "/info");
&autom("htmldir",$valvar{"docdir"});
&autom("dvidir",$valvar{"docdir"});
&autom("pdfdir",$valvar{"docdir"});
&autom("psdir",$valvar{"docdir"});
&autom("libdir",$valvar{"exec_prefix"} . "/lib");
&autom("lispdir",$valvar{"datarootdir"} . "/emacs/site-lisp");
&autom("localedir",$valvar{"datarootdir"} . "/locale");
&autom("mandir",$valvar{"datarootdir"} . "/man");
&autom("manext",".1");
{
  my $lc_a;
  $lc_a = 1;
  while ( $lc_a < 8.5 )
  {
    &autom("man" . $lc_a . "dir",$valvar{"mandir"} . "/man" . $lc_a);
    &autom("man" . $lc_a . "ext","." . $lc_a);
    &wardenize("man" . $lc_a . "dir");
    $lc_a = int($lc_a + 1.2);
  }
}
#&autom("libexecdir",$valvar{"exec_prefix"} . "/libexec");



# Now the following directory-variables are *not* present in the
# GNU standards - but nonetheless -chorebox- finds them to be
# important.
&autom("farm_bindir",$valvar{"bindir"});
&autom("farm_sbindir",$valvar{"sbindir"});


&wardenize("prefix","exec_prefix","bindir","sbindir","libexecdir");
&wardenize("datarootdir","datadir","sysconfdir","sharedstatedir");
&wardenize("localstatedir","runstatedir","includedir","oldincludedir");
&wardenize("super_docdir","docdir","infodir","htmldir");
&wardenize("dvidir","pdfdir","psdir","libdir");
&wardenize("lispdir","localedir","mandir","farm_bindir");
&wardenize("farm_sbindir");





# Now --- before we take another step we *need* to assure that
# there are no *fictional* directory variables lingering around.
{
  my $lc_a;
  
  foreach $lc_a (@dir_vars_specfied)
  {
    if ( !($dir_vars_real{$lc_a}) )
    {
      die "\nUnfortunately, it appears as though \"" . $lc_a
        . "\" is a fictional directory variable."
        . "\nTherefore, we can not continue.\n\n";
      ;
    }
  }
}





open DST, "| cat > Makefile.tmp";




&load_script_file ( $valvar{"srcdir"} . "/Makefile.pre" );

sub load_script_file {
  my $lc_cmd;
  my $lc_cont;
  my @lc_a;
  my @lc_b;
  
  # Now comes the part where we will load the Makefile recipe
  # to active memory:
  {
    
    $lc_cmd = "cat";
    $recipe_file = $_[0];
    &apnd_shrunk_argument($lc_cmd, $recipe_file);
    $lc_cont = `$lc_cmd`;
    @make_lines = split(/\n/,$lc_cont);
    $make_length = @make_lines;
  }
  
  # And we look for the list of place-labels:
  # Also - all the carry-over comments are to be displayed at this
  # point as well. That is, comment-lines that begin with ":#:".
  # This is done at the same time as the goto labels so that the copyright
  # notice can appear at the *beginning* of the Makefile rather than
  # *after* the Makefile variables are laid out. Comments that are meant
  # to be interspersed throughout the Makefile should be displayed as
  # ordinary Makefile text who's lines begin with the "#". And comments
  # that are only needed in the recipe file should begin with two
  # consecutive colons at the beginning of the line.
  $make_indx = 0;
  %make_label = {};
  while ( $make_indx < ( $make_length - 0.2 ) )
  {
    @lc_a = split(/:/,$make_lines[$make_indx],3);
    @lc_b = split(/:/,$lc_a[2]);
    if ( $lc_a[1] eq "label" )
    {
      system("echo","Label marked: " . $lc_b[0] . ": " . $make_indx . ":");
      $make_label{$lc_b[0]} = $make_indx;
    }
    if ( $lc_a[1] eq "#" )
    {
      print DST "#" . $lc_a[2] . "\n";
    }
    $make_indx = int($make_indx + 1.2);
  }
  
  @used_scrips = ();
  $make_indx = 0;
  
}





# Now we output all the variables we need:
{
  my $lc_vrot;
  foreach $lc_vrot (@lisdirs)
  {
    print DST "\n" . $lc_vrot . " = " . $valvar{$lc_vrot};
  }
}
print DST "\n";


# And we now do the main looping through the recipe ....
while ( $make_indx < ( $make_length - 0.5 ) )
{
  $adendia = "";
  &act_by_line($make_lines[$make_indx]);
  if ( $adendia ne "" )
  {
    print DST $adendia;
  }
  
  
  # The following litany is added to assure that
  # called scripts end by returning to the parent
  # one, rather than ending the config. However,
  # it was commented out when the threat to
  # deprecate the "run" directive was followed
  # through.
  #if ( $make_indx > ( $make_length - 1.5 ) ) { &return_to_higher_script; }
  
  if ( $make_indx > ( $make_length - 1.5 ) )
  {
    &from_a__prcd;
  }
  
  $make_indx = int($make_indx + 1.2);
}



print DST "\n";
close DST;
system("mv","Makefile.tmp","Makefile");



