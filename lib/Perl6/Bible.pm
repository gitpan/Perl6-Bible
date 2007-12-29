package Perl6::Bible;
use 5.000;
use File::Spec;

$Perl6::Bible::VERSION = '0.33';

sub new {
    my $class = shift;
    bless({@_}, $class);
}

sub process {
    my $self = shift;
    print <<_;
This was the Perl 6 Canon up to December 2007.
Please install Perl6::Doc to have even more Perl 6 Documentation.
_
}


__DATA__

=head1 NAME

Perl6::Bible - Perl 6 Design Documentations [STALLED]

SYNOPSIS
        please use Perl6::Doc instead

COPYRIGHT
    This Copyright applies only to the C<Perl6::Bible> Perl software
    distribution, not the documents bundled within.

    A couple of paragraphs from _Perl 6 Essentials_ were used for the
    overview. Most docs are from the official Perl development site. 

    http://dev.perl.org/perl6/

    All draft Synopses were taken out of the Pugs SVN repository.

    Copyright (c) 2007. Ingy Döt Net. All rights reserved.

    This program is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.

    See http://www.perl.com/perl/misc/Artistic.html

=cut
