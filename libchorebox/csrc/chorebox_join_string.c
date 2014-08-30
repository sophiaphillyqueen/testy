
#include <chorebox.h>
#include <string.h>

char *chorebox_join_string ( char *rg_a, char *rg_b )
{
  size_t lc_neosiz;
  char *lc_neobuf;
  char *lc_neoptr;
  char *lc_oleptr;
  
  // Remember NULL is returned if and *only* if both source
  // strings are NULL.
  if ( ( rg_a == NULL ) && ( rg_b == NULL ) ) { return NULL; }
  
  // Find the size of the destiny buffer:
  lc_neosiz = 1; // Add 1 for terminal character:
  if ( rg_a != NULL ) { lc_neosiz += strlen(rg_a); }
  if ( rg_b != NULL ) { lc_neosiz += strlen(rg_b); }
  lc_neosiz *= (sizeof(char)); // No hasty assumptions on size of char
  
  // Let's create the buffer
  lc_neobuf = chorebox_mlc(lc_neosiz);
  lc_neoptr = lc_neobuf;
  
  // Copy first string:
  if ( rg_a != NULL )
  {
    lc_oleptr = rg_a;
    while ( *lc_oleptr != '\0' )
    {
      *lc_neoptr = *lc_oleptr;
      lc_neoptr++;
      lc_oleptr++;
    }
  }
  
  // Copy second string:
  if ( rg_b != NULL )
  {
    lc_oleptr = rg_b;
    while ( *lc_oleptr != '\0' )
    {
      *lc_neoptr = *lc_oleptr;
      lc_neoptr++;
      lc_oleptr++;
    }
  }
  
  // Terminate and return.
  *lc_neoptr = '\0';
  return(lc_neobuf);
}


