#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Test::More;
use WWW::Contact::Lycos;
use Data::Dumper;

BEGIN {
    unless ( $ENV{TEST_LYCOS} and $ENV{TEST_LYCOS_PASS} ) {
        plan skip_all => 'set $ENV{TEST_LYCOS} and $ENV{TEST_LYCOS_PASS} to test';
    }
    plan tests => 4;
}

my $wc = WWW::Contact::Lycos->new();

my @contacts = $wc->get_contacts('cpan@lycos.com', 'letmein');
my $errstr = $wc->errstr;
is($errstr, 'Wrong Username or Password', 'get error with wrong password');
is(scalar @contacts, 0, 'empty contact list');

{
    @contacts = $wc->get_contacts($ENV{TEST_LYCOS}, $ENV{TEST_LYCOS_PASS});
    $errstr = $wc->errstr;
    is($errstr, undef, 'no error with username or password');
    cmp_ok(scalar @contacts, '>', 0, 'got contact list');
    diag(Dumper(\@contacts));
}
1;
