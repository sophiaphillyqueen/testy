
#include <chorebox.h>


char *chorebox_apend_string ( char **rg_a, char *rg_b )
{
  char *lc_temporar;
  
  lc_temporar = chorebox_join_string(*rg_a,rg_b);
  if ( (*rg_a) != NULL ) { free(*rg_a); }
  *rg_a = lc_temporar;
  
  return lc_temporar;
}


