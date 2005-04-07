package Perl6::Bible;
use Spiffy -Base;
use File::Spec;

our $VERSION = '0.13';

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

sub get_raw {
    my $id = shift
      or die "Missing argument for get_raw";
    my $document = uc($id);
    $document .= '.pod';
    $document = File::Spec->catfile("Perl6", "Bible", $document);
    my $document_path = '';
    for my $path (@INC) {
        my $file_path = File::Spec->catfile($path, $document);
        next unless -e $file_path;
        $document_path = $file_path;
        last;
    }
    die "No documentation for $id"
      unless $document_path;
    open DOC, $document_path;
    my $text = do {local $/, <DOC>};
    close DOC;
    return $text;
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
This is the Perl 6 Canon as of April 3rd, 2005 AD
(bundled in Perl6-Bible-$VERSION)
_
}

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
    $text =~ s/\A\s*\n//;
    $text =~ s/\s*\z/\n/;
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

=head2 Apocalypses

The document codes C<A01 - A33> refer to the Perl 6 Apocalypses.

Larry Wall started the Apocalypse series as a systematic way of
answering the RFCs (Request For Comments) that started the design
process for Perl 6.  Each Apocalypse corresponds to a chapter in the
book _Programming Perl_, 3rd edition, and addresses the features
relating to that chapter in the book that are likely to change.

Larry addresses each relevant RFC, and gives reasons why he accepted
or rejected various pieces of it.  But each Apocalypse also goes
beyond a simple "yes" and "no" response to attack the roots of the
problems identified in the RFCs.

=head2 Exegeses

The document codes C<E01 - E33> refer to the Perl 6 Exegeses.

Damian Conway's Exegeses are extensions of each Apocalypse.  Each
Exegesis is built around a practical code example that applies and
explains the new ideas.

=head2 Synopses

The document codes C<S01 - S33> refer to the Perl 6 Synopses.

The Synopsis documents are to be taken as the formal specification for
Perl 6 implementations, while still being reference documentation for
Perl 6, like _Programming Perl_ is for Perl 5.

Note that while these documents are considered "formal specifications",
they are still being subjected to the rigours of cross-examination
through implementation.

In other words, they may change slightly or radically. But the
expectation is that they are "very close" to the final shape of Perl 6.

=head1 CONTENTS

This is the list of documents that are currently available; a number in
the column indicates the document is currently available.

  A01       S01  The Ugly, the Bad, and the Good
  A02  E02  S02  Bits and Pieces
  A03  E03  S03  Operators
  A04  E04  S04  Syntax
  A05  E05  S05  Pattern Matching
  A06  E06  S06  Subroutines
       E07       Formats
                 References
            S09  Data Structures
            S10  Packages
            S11  Modules
            S12  Objects
            S13  Overloading
                 Tied Variables
                 Unicode
                 Interprocess Communication
                 Threads
                 Compiling
                 The Command-Line Interface
                 The Perl Debugger
                 Internals and Externals
                 CPAN
                 Security
                 Common Practices
                 Portable Perl
                 Plain Old Documentation
                 Special Names
            S29  Functions
                 The Standard Perl Library
                 Pragmatic Modules
                 Standard Modules
                 Diagnostic Modules

=head1 METHODS

Perl6::Bible provides a class method to get the raw text of a document:

    my $text = Perl6::Bible->get_raw('s01');

=head1 SCRIBES

* Brian Ingerson <ingy@cpan.org>

* Sam Vilain <samv@cpan.org>

=head1 COPYRIGHT

This Copyright applies only to the C<Perl6::Bible> Perl software
distribution, not the documents bundled within.

A couple of paragraphs from _Perl 6 Essentials_ were used for the
overview.

Copyright (c) 2005. Brian Ingerson, Sam Vilain. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
