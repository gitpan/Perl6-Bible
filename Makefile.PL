use inc::Module::Install;

name('Perl6-Bible');
author('Brian Ingerson <ingy@cpan.org>');
abstract('The Gospel according to Cabal');
license('perl');
version_from('lib/Perl6/Bible.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();
install_script('p6bible');

&WriteAll();
