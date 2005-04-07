use strict;
use lib 'lib', 'blib/lib';
use Test::More tests => 1;
use Perl6::Bible;

open S, 'lib/Perl6/Bible/S01.pod';
my $text = do { local $/; <S> };

is(Perl6::Bible->get_raw('s01'), $text);
