$ip1 = @{ IpProtocol="tcp"; FromPort="53"; ToPort="53"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip2 = @{ IpProtocol="tcp"; FromPort="80"; ToPort="80"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip3 = @{ IpProtocol="tcp"; FromPort="389"; ToPort="389"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip4 = @{ IpProtocol="tcp"; FromPort="135"; ToPort="139"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip5 = @{ IpProtocol="tcp"; FromPort="443"; ToPort="445"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip6 = @{ IpProtocol="tcp"; FromPort="464"; ToPort="464"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip7 = @{ IpProtocol="tcp"; FromPort="636"; ToPort="636"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip8 = @{ IpProtocol="tcp"; FromPort="5985"; ToPort="5985"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip9 = @{ IpProtocol="tcp"; FromPort="9389"; ToPort="9389"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip10 = @{ IpProtocol="tcp"; FromPort="3268"; ToPort="3269"; IpRanges="172.0.0.0/6"; Description="client-connection" }
$ip11 = @{ IpProtocol="tcp"; FromPort="49152"; ToPort="65535"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip12 = @{ IpProtocol="udp"; FromPort="53"; ToPort="53"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip13 = @{ IpProtocol="udp"; FromPort="67"; ToPort="67"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip14 = @{ IpProtocol="udp"; FromPort="88"; ToPort="88"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip15 = @{ IpProtocol="udp"; FromPort="123"; ToPort="123"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip16 = @{ IpProtocol="udp"; FromPort="135"; ToPort="138"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip17 = @{ IpProtocol="udp"; FromPort="389"; ToPort="389"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip18 = @{ IpProtocol="udp"; FromPort="445"; ToPort="445"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip19 = @{ IpProtocol="udp"; FromPort="464"; ToPort="464"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip20 = @{ IpProtocol="udp"; FromPort="2535"; ToPort="2535"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$ip21 = @{ IpProtocol="udp"; FromPort="49152"; ToPort="65535"; IpRanges="172.0.0.0/6"; Description="client-connection"  }
$SGID1 = "sg-a6e6a1da"
$SGID2 = "x"
$R1 = "us-west-2"
$R2 = "eu-west-1"
Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5 ) -Region $R1
Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip6, $ip7, $ip8, $ip9, $ip10 ) -Region $R1
Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip11, $ip12, $ip13, $ip14, $ip15 ) -Region $R1
Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip16, $ip17, $ip18, $ip19, $ip20, $ip21 ) -Region $R1


