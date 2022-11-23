package My::Inline;

use strict;
use warnings;

use Exporter qw(import);
use Inline C => <<'_';
int is_prime(int num) {
  int limit = num - 1; /* a naive algorithm */
  int i;
  for (i=2; i<=limit; i++) {
    if (num % i == 0) return 1;
  }
  return 0;
}
_

# AUTHORITY
# DATE
# DIST
# VERSION

our @EXPORT_OK = ('is_prime');

1;
# ABSTRACT: Example Inline code
