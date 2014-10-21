#!perl -T

use strict;
use warnings;
#use Test::Simple tests => 13;
use Test::More skip_all => 'Passwd::Keyring::Memory is volatile';

use Passwd::Keyring::Memory;

my $PSEUDO_DOMAIN = 'my@@domain';
my $OTHER_DOMAIN = 'other domain';

my $ring = Passwd::Keyring::Memory->new(app=>"Passwd::Keyring::Memory", group=>"Unit tests");

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

ok( ! defined($ring->get_password("Paul", $PSEUDO_DOMAIN)), "get works");

ok( $ring->get_password("Gregory", $PSEUDO_DOMAIN) eq 'secret-Greg', "get works");

ok( $ring->get_password("Paul", $OTHER_DOMAIN) eq 'secret-Paul2', "get works");

ok( $ring->get_password("Duke", $PSEUDO_DOMAIN) eq 'secret-Duke', "get works");

ok( $ring->clear_password("Gregory", $PSEUDO_DOMAIN) eq 1, "clear clears");

ok( ! defined($ring->get_password("Gregory", $PSEUDO_DOMAIN)), "clear cleared");

ok( $ring->get_password("Paul", $OTHER_DOMAIN) eq 'secret-Paul2', "get works");

ok( $ring->get_password("Duke", $PSEUDO_DOMAIN) eq 'secret-Duke', "get works");

ok( $ring->clear_password("Paul", $OTHER_DOMAIN) eq 1, "clear clears");

ok( $ring->clear_password("Duke", $PSEUDO_DOMAIN) eq 1, "clear clears");

ok( ! defined($ring->get_password("Paul", $PSEUDO_DOMAIN)), "clear cleared");
ok( ! defined($ring->get_password("Duke", $PSEUDO_DOMAIN)), "clear cleared");



