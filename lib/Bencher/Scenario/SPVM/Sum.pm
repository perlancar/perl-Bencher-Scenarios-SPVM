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
        'SPVM' => {version => '0.0238'},
        'SPVM::Examples' => {}, # to pull SPVM/Examples/Sum.spvm
    },
    participants => [
        { name => 'SPVM', code => sub { SPVM::Examples::Sum::sum(3, 5) } },
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
