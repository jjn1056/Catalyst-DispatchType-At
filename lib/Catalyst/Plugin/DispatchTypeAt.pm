package Catalyst::Plugin::DispatchTypeAt;

use Moose::Role;

around setup_dispatcher => sub {
  my $orig = shift;
  my $c = shift;
  $c->$orig(@_);
  push @{ $c->dispatcher->preload_dispatch_types }, '+Catalyst::DispatchType::At';
  return $c->$orig(@_);;
};


1;