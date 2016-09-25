#!/usr/bin/perl -w
use strict;

use Net::MQTT::Simple;

my $mqtt = Net::MQTT::Simple->new("192.168.0.3");

use IO::Socket;
use Net::DHCP::Packet;
use Net::DHCP::Constants;
#use Net::MAC::Vendor;
print "-------------------------------------------\n" ;

my $socket_in = IO::Socket::INET->new(LocalPort => 67, LocalAddr => "255.255.255.255", Proto    => 'udp') or die $@;

while(1)
{

  my $buf;
  my $Vendor;
  $socket_in->recv($buf,4096);

  my $packet      = new Net::DHCP::Packet($buf);
  my $mac         =  substr($packet->chaddr(),0,12);
  $mac =~ s/([[:xdigit:]]{2})\B/$1:/g;

  my $messagetype = $packet->getOptionValue(DHO_DHCP_MESSAGE_TYPE());

  if ($messagetype eq DHCPDISCOVER())
  {
      print "Discover: $mac\n";
  }
  elsif ($messagetype eq DHCPREQUEST())
  {
      	print "Request: $mac\n";
	if ($mac =~/ac:63/)
	{
	      SendMQTT($mac)
	}
  }

#      $Vendor= Net::MAC::Vendor::lookup( $mac );
#      print "Vendor: $Vendor->[0]\n" ;
  print "-------------------------------------------\n" ;

}

sub SendMQTT
{
     my $mac = shift;
     print "dash/pressed/$mac => on\n";
     $mqtt->publish("dash/pressed/$mac" => "pressed");
}