# chorebox-configure - The 'chorebox' -configure- script backend.
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

my @dir_vars_specfied = ();
my %dir_vars_values = {};
my %dir_vars_real = {};
my %valvar = {}; # Value after resolved by &autom
my @lisdirs = (); # List of all directories resolved by &autom
my $argum;

my @make_lines;
my $make_length;
my %proj_info_s;
my %proj_info_l;

foreach $argum (@ARGV)
{
  &try_process_argum($argum);
}

sub try_process_argum {
  my $lc_pre_equal;
  my $lc_post_equal;
  my $lc_givalue; # If it is a value-equal thing:
  my $lc_dashpred; # Is it predicated with "--"
  my $lc_optnom; # The name of the option
  my $lc_is_dirvaly;
  
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
  
  # The kinds of options that this can handle is not yet exhaustive
  # enough for me to warrant terminating the program if it fails
  # to handle one -- but we should at least get the programmer's
  # attention.
  system("echo","\nCAN NOT YET HANDLE OPTION:\n  " . $_[0] . ":\n");
  sleep(2);
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
  $lc_cmd = "cat";
  &apnd_shrunk_argument($lc_cmd,$valvar{"srcdir"} . "/proj-info.txt");
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
}


&autom("prefix","/usr/local");
&autom("exec_prefix",$valvar{"prefix"});
&autom("bindir",$valvar{"exec_prefix"} . "/bin");
&autom("sbindir",$valvar{"exec_prefix"} . "/sbin");
&autom("libexecdir",$valvar{"exec_prefix"} . "/libexec");
&autom("datarootdir",$valvar{"prefix"} . "/share");
&autom("datadir",$valvar{"datadir"});
&autom("sysconfdir",$valvar{"prefix"} . "/etc");
&autom("sharedstatedir",$valvar{"prefix"} . "/com");
&autom("localstatedir",$valvar{"prefix"} . "/var");
&autom("runstatedir",$valvar{"localstatedir"} . "/run");
&autom("includedir",$valvar{"prefix"} . "/include");

# NOTE: Until further notice -chorebox- programs should not actually
# *use* the "oldincludedir" variable. It is only defined here so
# that the program won't bomb of that value is passed to it.
&autom("oldincludedir","/usr/include");

# <-- docdir
&autom("docdir",$valvar{"datarootdir"} . "/doc/" . $proj_info_s{"name"} . "-" . $proj_info_s{"vrsn"});
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
    $lc_a = int($lc_a + 1.2);
  }
}
#&autom("libexecdir",$valvar{"exec_prefix"} . "/libexec");

# DEFINE LATER:
#   docdir


open DST, "| cat > Makefile";
{
  my $lc_vrot;
  foreach $lc_vrot (@lisdirs)
  {
    print DST "\n" . $lc_vrot . " = " . $valvar{$lc_vrot};
  }
}

# Now comes the part where we will load the Makefile recipe
# to active memory:
{
  my $lc_cmd;
  my $lc_cont;
  
  $lc_cmd = "cat";
  &apnd_shrunk_argument($lc_cmd, $valvar{"srcdir"} . "/Makefile.pre");
  $lc_cont = `$lc_cmd`;
  @make_lines = split(/\n/,$lc_cont);
  $make_length = @make_lines;
}

print DST "\n";
close DST;



