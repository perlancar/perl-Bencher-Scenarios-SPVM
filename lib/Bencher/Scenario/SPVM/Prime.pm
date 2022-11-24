package Bencher::Scenario::SPVM::Prime;

use 5.010001;
use strict;
use warnings;

use SPVM 'Examples::Prime';

# AUTHORITY
# DATE
# DIST
# VERSION

our $scenario = {
    summary => 'Benchmark SPVM (check if number is prime)',
    modules => {
        'SPVM' => {version => '0.9662'},
        'SPVM::Examples' => {version=>'0.002'}, # to pull dependency
    },
    participants => [
        { name => 'Inline::C', code => sub { My::Prime::InlineC::is_prime(1_000_003) } },
        { name => 'Perl',      code => sub { My::Prime::Perl->is_prime(1_000_003) } },
        { name => 'SPVM',      code => sub { SPVM::Examples::Prime->is_prime(1_000_003) } },
    ],
};

package
    My::Prime::Perl;

sub is_prime {
    my $self = shift;
    my $num = shift;

    my $limit = $num - 1; # naive algorithm
    for my $i (2 .. $limit) {
        return 0 if $num % $i == 0;
    }
    1;
}

package
    My::Prime::InlineC;

use Inline C => <<'_';
int is_prime(int num) {
  int limit = num - 1; /* a naive algorithm */
  int i;
  for (i=2; i<=limit; i++) {
    if (num % i == 0) return 0;
  }
  return 1;
}
_

1;
# ABSTRACT:

=head1 BENCHMARK NOTES

Currently SPVM only offers ~2x speed-up in this case, and still an order of
magnitude slower than C code.

My general impression on SPVM (Nov 2022, v0.9662): the parser is currently still
buggy (e.g. insignificant whitespace causing syntax error). 2x+ speed-up and
native compilation are nice features. If the language proves to be convenient
enough for Perl programmers, it might become a useful addition to their toolbox.
