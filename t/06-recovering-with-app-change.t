#!perl -T

use strict;
use warnings;
use Test::More tests => 16;

use Passwd::Keyring::Memory;

my $USER = "Herakliusz";
my $DOMAIN = "test domain";
my $PWD = "arcytajne haslo";
my $PWD2 = "inny sekret";

my $APP1 = "Passwd::Keyring::Unit tests (1)";
my $APP2 = "Passwd::Keyring::Unit tests (2)";
my $GROUP1 = "Passwd::Keyring::Unit tests - group 1";
my $GROUP2 = "Passwd::Keyring::Unit tests - group 2";
my $GROUP3 = "Passwd::Keyring::Unit tests - group 3";

my @cleanups;

{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP1, group=>$GROUP1);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

    ok( ! defined($ring->get_password($USER, $DOMAIN)), "initially unset");

    $ring->set_password($USER, $PWD, $DOMAIN);
    ok(1, "set password");

    ok( $ring->get_password($USER, $DOMAIN) eq $PWD, "normal get works");

    push @cleanups, sub {
        ok( $ring->clear_password($USER, $DOMAIN) eq 1, "clearing first (grp 1)");
    };
}


# Another object with the same app and group

{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP1, group=>$GROUP1);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory', 'second new() works' );

    ok( $ring->get_password($USER, $DOMAIN) eq $PWD, "get from another ring with the same data works");
}

# Only app changes
{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP2, group=>$GROUP1);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory', 'third new() works' );

    ok( $ring->get_password($USER, $DOMAIN) eq $PWD, "get from another ring with changed app but same group works");
}

# Only group changes
my $sec_ring;
{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP1, group=>$GROUP2);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory', 'third new() works' );

    ok( ! defined($ring->get_password($USER, $DOMAIN)), "changing group forces another password");

    # To test whether original won't be spoiled
    $ring->set_password($USER, $PWD2, $DOMAIN);

    push @cleanups, sub {
        ok( $ring->clear_password($USER, $DOMAIN) eq 1, "clearing second (grp 2)");
    };
}

# App and group change
{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP2, group=>$GROUP3);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory', 'third new() works' );

    ok( ! defined($ring->get_password($USER, $DOMAIN)), "changing group and app forces another password");

}

# Re-reading original to check whether it was properly kept
{
    my $ring = Passwd::Keyring::Memory->new(app=>$APP1, group=>$GROUP1);

    ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory', 'second new() works' );

    ok( $ring->get_password($USER, $DOMAIN) eq $PWD, "get original after changes in other group works");
}

# Cleanup
foreach my $cleanup (@cleanups) {
    $cleanup->();
}

