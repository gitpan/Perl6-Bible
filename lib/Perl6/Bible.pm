package Perl6::Bible;
use Spiffy -Base;

our $VERSION = '0.11';

sub process {
    my ($args, @values) = $self->get_opts(@_);
    $self->usage, return
      unless $self->validate_args($args);
    $self->help, return
      if $args->{-h} || 
         $args->{'--help'};
    $self->version, return 
      if $args->{-v} || 
         $args->{'--version'};
    $self->contents, return 
      if $args->{-c} || 
         $args->{'--contents'};
    $self->perldoc(@values);
}

sub get_opts {
    my ($args, @values) = ({});
    for (@_) {
        $args->{$_}++, next if /^\-/;
        push @values, $_;
    }
    return ($args, @values);
}

sub validate_args {
    my $args = shift;
    for (keys %$args) {
        return unless /^(-h|--help|-v|--version|-c|--contents)$/;
    }
    return 1;
}

sub perldoc {
    my $document = "Perl6::Bible";
    $document .= '::' . uc(shift)
      if @_;
    my $command = "perldoc $document";
    $command .= " 2> /dev/null"
      unless $^O eq 'MSWin32';
    system $command;
}

sub usage {
    print <<_;
Usage: p6bible [options] [document-id]
Try `p6bible --help` for more information.
_
}

sub help {
    print <<_;
Usage: p6bible [options] [document-id]
View the Perl 6 Canon.

Possible values for document-id are: 
  A01 - A33  (Perl 6 Apocalypses)
  E01 - E33  (Perl 6 Exegeses)
  S01 - S33  (Perl 6 Synopses)

Valid options:
  -h,  --help       Print this help screen
  -v,  --version    Print the publish date of this Perl6::Bible version
  -c,  --contents   Show the current table of contents
_
}

sub version {
    print <<_;
This is the Perl 6 Canon as of April 2nd, 2005 AD
(bundled in Perl6-Bible-$VERSION)
_
}

use Spiffy -XXX;
sub contents {
    my $module = __PACKAGE__;
    $module =~ s/::/\//g;
    $module .= '.pm';
    my $path = $INC{$module};
    open MOD, $path
      or die "Can't open $path for input";
    my $text = do {local $/; <MOD>};
    close MOD;
    $text =~ s/^.*=head1 CONTENTS(.*?)=head1.*$/$1/s
      or die "Can't find contents\n";
    $text =~ s/^\s*?\n//mg;
    print $text;
}

__DATA__

=head1 NAME

Perl6::Bible - The Gospel according to Cabal

=head1 SYNOPSIS

    > p6bible s05

=head1 DESCRIPTION

This Perl module distribution contains all the latest Perl 6
documentation and a utility called C<p6bible> for viewing it.

=head1 CONTENTS

  A01       S01  The Ugly, the Bad, and the Good
  A02  E02  S02  Bits and Pieces
  A03  E03  S03  Operators
  A04  E04  S04  Syntax
  A05  E05  S05  Pattern Matching
  A06  E06  S06  Subroutines
       E07       Formats
            S09  Data Structures
            S10  Packages
            S11  Modules
            S12  Objects
            S13  Overloading
            S29  Functions

=head1 SCRIBE

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

This Copyright applies only to the C<Perl6::Bible> Perl software
distribution, not the documents bundled within.

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
