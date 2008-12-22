#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::isgd;
use WWW::Shorten 'isgd';

my $short = makeashorterlink(
 'http://search.cpan.org/~bgilmore/'
);

is($short, 'http://is.gd/cZV6');
