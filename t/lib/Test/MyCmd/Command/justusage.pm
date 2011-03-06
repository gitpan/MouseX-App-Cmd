#
# This file is part of MouseX-App-Cmd
#
# This software is copyright (c) 2011 by Infinity Interactive.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.006;
use strict;
use warnings;

package Test::MyCmd::Command::justusage;
use Mouse;

extends qw(MouseX::App::Cmd::Command);

=head1 NAME

Test::MyCmd::Command::justusage - it just dies its own usage, no matter what

=cut

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die $self->usage->text;
}

1;
