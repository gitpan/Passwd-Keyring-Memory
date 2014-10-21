#!perl -T

use strict;
use warnings;
use Test::Simple tests => 4;

use Passwd::Keyring::Memory;

my $APP = "Passwd::Memory::Keyring unit test 08 ";
$APP .= "X" x (256 - length($APP));
my $GROUP = "Passwd::Memory::Keyring unit tests ";
$GROUP .= "X" x (256 - length($GROUP));

my $USER = "A" x 256;
my $PWD =  "B" x 256;
my $DOMAIN = 'C' x 256;

my $ring = Passwd::Keyring::Memory->new(
    app=>$APP, group=>$GROUP);

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works with long params' );

$ring->set_password($USER, $PWD, $DOMAIN);

ok( 1, "set_password with long params works" );

ok( $ring->get_password($USER, $DOMAIN) eq $PWD, "get_password with long params works");

ok( $ring->clear_password($USER, $DOMAIN) eq 1, "clear_password with long params works");

