package Bencher::Scenario::SPVM::Sum;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use SPVM 'Examples::Sum';

our $scenario = {
    summary => 'Benchmark SPVM (sum two numbers)',
    modules => {
        'SPVM' => {},
        'SPVM::Examples' => {}, # to pull SPVM/Examples/Sum.spvm
    },
    participants => [
        { name => 'SPVM', code => sub { SPVM::Examples::Sum::sum(SPVM::int(3), SPVM::int(5))->value } },
        { name => 'Perl', code => sub { My::Sum::sum(3, 5) } },
    ],
};

package My::Sum;

sub sum { $_[0] + $_[1] }

1;
# ABSTRACT:

=head1 BENCHMARK NOTES

Because SPVM needs to run code at CHECK phase, we need to run with e.g.:

 % PERL5OPT=-MSPVM=Examples::Sum bencher ...

And building this dist also needs similar workaround.
