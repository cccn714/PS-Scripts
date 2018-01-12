$ip1 = @{ IpProtocol="tcp"; FromPort="80"; ToPort="80"; IpRanges="172.0.0.0/6" }
$ip2 = @{ IpProtocol="udp"; FromPort="67"; ToPort="69"; IpRanges="172.0.0.0/6" }
$ip3 = @{ IpProtocol="tcp"; FromPort="443"; ToPort="443"; IpRanges="172.0.0.0/6" }
$ip4 = @{ IpProtocol="tcp"; FromPort="445"; ToPort="445"; IpRanges="172.0.0.0/6" }
$ip5 = @{ IpProtocol="tcp"; FromPort="4011"; ToPort="4011"; IpRanges="172.0.0.0/6" }
$ip6 = @{ IpProtocol="tcp"; FromPort="10123"; ToPort="10123"; IpRanges="172.0.0.0/6" }
$SGID1 = "sg-ef91ac94"
Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6 ) -Region $ireland


