#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::isgd;
use WWW::Shorten 'isgd';

my $short = makeashorterlink('http://www.cpan.org');
is($short, 'http://is.gd/dvaDe');

