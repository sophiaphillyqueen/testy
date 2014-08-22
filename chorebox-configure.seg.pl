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
&autom("prefix","/usr/local");
&autom("exec_prefix",$valvar{"prefix"});
&autom("bindir",$valvar{"exec_prefix"} . "/bin");
&autom("sbindir",$valvar{"exec_prefix"} . "/sbin");
&autom("libexecdir",$valvar{"exec_prefix"} . "/libexec");

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



