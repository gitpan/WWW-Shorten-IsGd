#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::isgd;
use WWW::Shorten 'isgd';

my $long = makealongerlink(
 'http://is.gd/cZV6'
);

is($long, 'http://search.cpan.org/~bgilmore/');
