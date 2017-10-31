use utf8;

package Hash::RecursiveIterator;

use base qw(Hash::Iterator);
use strict;
use warnings FATAL => 'deprecated';

sub new {
  my $self = shift;
  $self->SUPER::new(@_);
}

sub hasChildren {
  my $self = shift;
  my $current = $self->peek_value;

  return ref $current;
}

sub getChildren {
  my $self = shift;
  my $subarray = $self->peek_value;

  return Hash::RecursiveIterator->new(%$subarray);
}

1;


__END__

# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Hash::Iterator - Hashtable Iterator.

=head1 SYNOPSIS

  my $iterRecurcive = Hash::RecursiveIterator->new(
    item => {
      item1 => 'value1',
      item2 => 'value2',
      item3 => {
        item1 => 'value1',
      },
    }
  );

  recursive_iterate($iterRecurcive, 1);

  sub recursive_iterate;
  sub recursive_iterate {
    my ( $it, $level) = @_;

    die unless $it->isa('Hash::Iterator');

    while ($it->next) {
      if ($it->hasChildren()) {
        say sprintf("[%s] s => ref(%s)", $level, $it->peek_key(), recursive_iterate( $it->getChildren() , $level*2) ) ;
      }
      else {
         say sprintf("[%s] %s => %s", $level, $it->peek_key(), $it->peek_value());
      }
    }
  }

=head1 DESCRIPTION

 Iterating Recursive Structures

=head1 CONSTRUCTORS

=head2 new

    my $iterator = Hash::RecursiveIterator->new( %hash );

Return a Hash::RecursiveIterator for C<hash>

=head1 METHODS

=over

=back

=head2 hasChildren

    $iterator->next;

Returns true if an iterator can be created/returned for the current entry.

=head2 getChildren

    $iterator->previous;

Note: getChildren() must return a RecursiveIterator or class derived from RecursiveIterator for the current entry.

=head1 AUTHOR

vlad mirkos, E<lt>vladmirkos@sd.apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2017 by vlad mirkos

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

=encoding UTF-8

=cut