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

package Test::MyCmd::Command::stock;
use Mouse;

extends qw(MouseX::App::Cmd::Command);

=head1 NAME

Test::MyCmd::Command::stock - nothing here is overridden

=cut

# This package exists to test all the default command plugin behaviors.

1;
