// libchorebox - A high-level C programming library for -chorebox-
// chorebox_getcwd.c - Source-code for this function:
// Copyright (C) 2014  Sophia Elizabeth Shapira
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// ########################

#include <chorebox.h>
#include <stdio.h>
#include <unistd.h>

void chorebox_getcwd ( char **rg_a )
{
  size_t lc_numbo_chars; // Needed buf-size in chars:
  size_t lc_numbo_bytes; // Needed buf-size in bytes:
  char *lc_tempo_buf;
  char *lc_successo;
  
  // First we find the maximum possible buffer size we might
  // need (one var to hold that in characters - the other in
  // bytes - just in case the two are different).
  lc_numbo_chars = pathconf(".", _PC_PATH_MAX);
  lc_numbo_bytes = lc_numbo_chars * sizeof(char);
  
  // Now we allocate this buffer --- with confidence.
  lc_tempo_buf = chorebox_mlc(lc_numbo_bytes);
  
  // We now fill the temporary buffer with the present working
  // directory. If (low in behold) the operation fails, it is
  // the job of this function to see to the admission of failure
  // and subsequent termination of this program.
  lc_successo = getcwd(lc_tempo_buf,lc_numbo_chars);
  if ( lc_successo == NULL )
  {
    fprintf(stderr,"\n%s: FATAL ERROR:\n  Unable to Find Present Working Directory:\n\n",chorebox_argv[0]);
    fflush(stderr);
    exit(3);
  }
  
  // And now we *copy* the string from the temporary buffer to
  // a returnable copy -- the one pointed to by the argument.
  *rg_a = chorebox_join_string(lc_tempo_buf,NULL);
  
  // Free the temporary copy.
  free(lc_tempo_buf);
}

