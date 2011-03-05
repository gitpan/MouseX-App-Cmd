#
# This file is part of MouseX-App-Cmd
#
# This software is copyright (c) 2011 by Infinity Interactive.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use utf8;
use strict;
use Modern::Perl;    ## no critic (UselessNoCritic,RequireExplicitPackage)

=encoding utf8

=cut

package Test::MyCmd::Command::bark;
use Mouse;

extends qw(MouseX::App::Cmd::Command);

=head1 NAME

Test::MyCmd::Command::bark - required field is used

=cut

has wow => (
    isa           => "Str",
    is            => "ro",
    required      => 1,
    documentation => "required option field",
);

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die "my dog name barks " . $self->wow . "\n";
}

1;
