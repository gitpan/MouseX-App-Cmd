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

package Test::MyCmd::Command::frobulate;
use Mouse;

extends qw(MouseX::App::Cmd::Command);

sub command_names {
    return qw(frobulate frob);
}

has foo_bar => (
    traits        => [qw(Getopt)],
    isa           => "Bool",
    is            => "ro",
    cmd_aliases   => "F",
    documentation => "enable foo-bar subsystem",
);

has widget => (
    traits        => [qw(Getopt)],
    isa           => "Str",
    is            => "ro",
    documentation => "set widget name",
);

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die "the widget name is " . $self->widget . " - @$arg\n";
}

1;
