
foreach $searchdir (@srcpath)
{
  my $lc_a;
  $lc_a = $searchdir . "/" . $ARGV[0];
  if ( -f $lc_a )
  {
    exec("echo",$lc_a);
    exit(0);
  }
}


