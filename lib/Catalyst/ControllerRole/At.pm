package Catalyst::ControllerRole::At;

use Moose::Role;

sub _parse_At_attr {
    my ($self, $c, $name, $value) = @_; 

    if (defined($value) && length($value)) {
        if ($value eq '.') {
            $value = '/'.$self->action_namespace($c);
        } elsif (my ($rel, $rest) = $value =~ /^((?:\.{2}\/)+)(.*)$/) {
            my @parts = split '/', $self->action_namespace($c);
            my @levels = split '/', $rel;
    
            $value = '/'.join('/', @parts[0 .. $#parts - @levels], $rest);
        } elsif ($value !~ m/^\//) {
             my $action_ns = $self->action_namespace($c);

            if ($action_ns) {
                $value = '/'.join('/', $action_ns, $value);
            } else {
                $value = '/'.$value; # special case namespace '' (root)
            }
        } 
    } else {
        $value = '/' 
    }
       
    return At => $value;
}

1;