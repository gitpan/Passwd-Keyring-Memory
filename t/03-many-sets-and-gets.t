#!perl -T

use strict;
use warnings;
use Test::Simple tests => 11;

use Passwd::Keyring::Memory;

my $SOME_REALM = 'my@@realm';
my $OTHER_REALM = 'other realm';

my $ring = Passwd::Keyring::Memory->new(app=>"Passwd::Keyring::Memory", group=>"Unit tests");

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

$ring->set_password("Paul", "secret-Paul", $SOME_REALM);
$ring->set_password("Gregory", "secret-Greg", $SOME_REALM);#
$ring->set_password("Paul", "secret-Paul2", $OTHER_REALM);
$ring->set_password("Duke", "secret-Duke", $SOME_REALM);

ok( 1, "set_password works" );

ok( $ring->get_password("Paul", $SOME_REALM) eq 'secret-Paul', "get works");

ok( $ring->get_password("Gregory", $SOME_REALM) eq 'secret-Greg', "get works");

ok( $ring->get_password("Paul", $OTHER_REALM) eq 'secret-Paul2', "get works");

ok( $ring->get_password("Duke", $SOME_REALM) eq 'secret-Duke', "get works");

ok( $ring->clear_password("Paul", $SOME_REALM) eq 1, "clear_password removed 1");

ok( ! defined($ring->get_password("Paul", $SOME_REALM)), "get works");

ok( $ring->get_password("Gregory", $SOME_REALM) eq 'secret-Greg', "get works");

ok( $ring->get_password("Paul", $OTHER_REALM) eq 'secret-Paul2', "get works");

ok( $ring->get_password("Duke", $SOME_REALM) eq 'secret-Duke', "get works");


# Note: cleanup is performed by test 04, we test passing data to
#       separate program.
