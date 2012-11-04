package Passwd::Keyring::Memory;

use 5.006;
use strict;
use warnings;

=head1 NAME

Passwd::Keyring::Memory - fallback keyring for environments
where no better keyring is available.

=head1 VERSION

Version 0.21

=cut

our $VERSION = '0.21';

=head1 SYNOPSIS

    use Passwd::Keyring::Memory;

    my $keyring = Passwd::Keyring::Memory->new();

    $keyring->set_password("John", "verysecret", "my-pseudodomain");

    my $password = $keyring->get_password("John", "my-pseudodomain");

    $keyring->clear_password("John", "my-pseudodomain");

=head1 SUBROUTINES/METHODS

=head2 new

Initializes the processing.

=cut

sub new {
    my $self = {};
    $self->{_passwords} = {}; # user → domain → password
    bless $self;
    return $self;
}

=head2 set_password(username, password, domain)

Sets (stores) password identified by given domain for given user 

=cut

sub set_password {
    my ($self, $user_name, $user_password, $domain) = @_;
    $self->{_passwords}->{$user_name}->{$domain} = $user_password;
}

=head2 get_password($user_name, $domain)

Reads previously stored password for given user in given app.
If such password can not be found, returns undef.

=cut

sub get_password {
    my ($self, $user_name, $domain) = @_;
    my $pwd = $self->{_passwords}->{$user_name}->{$domain};
    unless(defined($pwd)) {
        #die "No password stored for $user_name in $domain\n";
        return undef;
    }
    return $pwd;
}

=head2 clear_password($user_name, $domain)

Removes given password (if present)

=cut

sub clear_password {
    my ($self, $user_name, $domain) = @_;
    delete $self->{_passwords}->{$user_name}->{$domain};
}

=head1 AUTHOR

Marcin Kasperski, C<< <Marcin.Kasperski at mekk.waw.pl> >>

=head1 BUGS

Please report any bugs or feature requests to 
issue tracker at L<https://bitbucket.org/Mekk/perl-keyring-memory>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Passwd::Keyring::Memory

You can also look for information at:

    L<https://bitbucket.org/Mekk/perl-keyring-memory>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Marcin Kasperski.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut


1; # End of Passwd::Keyring::Memory
