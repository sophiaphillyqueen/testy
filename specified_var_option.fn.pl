
sub specified_var_option {
  my $lc_prequal;
  my $lc_existes;
  my $lc_footprint;
  
  $lc_prequal = "--" . $_[0];
  foreach $lc_existes (@legacy_options)
  {
    ($lc_footprint) = split(quotemeta("="),$lc_existes);
    if ( $lc_footprint eq $lc_prequal ) { return ( 2 > 1 ); }
  }
  return ( 1 > 2 );
}

