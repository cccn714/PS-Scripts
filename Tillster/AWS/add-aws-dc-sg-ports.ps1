#----------------------------------------------------------------------------#
# These are the default ports for the AWS SCCM Security Groups. 
# They are to be used when creating new SCCM VPC's
# Comment out the region variables that you are not using, irelnad or oregon
#----------------------------------------------------------------------------#
#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-a6e6a1da"
$ireland = "eu-west-1"
$IRE_SGID1 = ""
$ip1 = @{ IpProtocol="udp"; FromPort="445"; ToPort="445"; IpRanges="172.0.0.0/8" }
$ip2 = @{ IpProtocol="tcp"; DPFromPort="1512"; ToPort="1512"; IpRanges="172.0.0.0/8" }
$ip3 = @{ IpProtocol="udp"; FromPort="49152"; ToPort="65535"; IpRanges="172.0.0.0/8" }
$ip4 = @{ IpProtocol="udp"; FromPort="464"; ToPort="464"; IpRanges="172.0.0.0/8" }
$ip5 = @{ IpProtocol="tcp"; FromPort="464"; ToPort="464"; IpRanges="172.0.0.0/8" }
$ip6 = @{ IpProtocol="udp"; FromPort="135"; ToPort="135"; IpRanges="172.0.0.0/8" }
$ip7 = @{ IpProtocol="tcp"; FromPort="49152"; ToPort="65535"; IpRanges="172.0.0.0/8" }
$ip8 = @{ IpProtocol="tcp"; FromPort="42"; ToPort="42"; IpRanges="172.0.0.0/8" }
$ip9 = @{ IpProtocol="udp"; FromPort="389"; ToPort="389"; IpRanges="172.0.0.0/8" }
$ip10 = @{ IpProtocol="udp"; FromPort="53"; ToPort="53"; IpRanges="172.0.0.0/8" }
$ip11 = @{ IpProtocol="tcp"; FromPort="389"; ToPort="389"; IpRanges="172.0.0.0/8" }
$ip12 = @{ IpProtocol="udp"; FromPort="123"; ToPort="53"; IpRanges="172.0.0.0/8" }
$ip13 = @{ IpProtocol="tcp"; FromPort="445"; ToPort="389"; IpRanges="172.0.0.0/8" }
$ip14 = @{ IpProtocol="All"; FromPort="N/A"; ToPort="N/A"; IpRanges="172.0.0.0/8" }
$ip15 = @{ IpProtocol="tcp"; FromPort="3268"; ToPort="3269"; IpRanges="172.0.0.0/8" }
$ip16 = @{ IpProtocol="tcp"; FromPort="88"; ToPort="88"; IpRanges="172.0.0.0/8" }
$ip17 = @{ IpProtocol="tcp"; FromPort="137"; ToPort="139"; IpRanges="172.0.0.0/8" }
$ip18 = @{ IpProtocol="udp"; FromPort="137"; ToPort="138"; IpRanges="172.0.0.0/8" }
$ip19 = @{ IpProtocol="udp"; FromPort="42"; ToPort="42"; IpRanges="172.0.0.0/8" }
$ip20 = @{ IpProtocol="tcp"; FromPort="135"; ToPort="135"; IpRanges="172.0.0.0/8" }
$ip21 = @{ IpProtocol="tcp"; FromPort="636"; ToPort="636"; IpRanges="172.0.0.0/8" }
$ip22 = @{ IpProtocol="tcp"; FromPort="53"; ToPort="53"; IpRanges="172.0.0.0/8" }
$ip23 = @{ IpProtocol="udp"; FromPort="1512"; ToPort="1512"; IpRanges="172.0.0.0/8" }
$ip24 = @{ IpProtocol="udp"; FromPort="88"; ToPort="88"; IpRanges="172.0.0.0/8" }
#--------------------------------------------------------------------------------#
# Comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#--------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12, $ip13, $ip14, $ip15, $ip16, $ip17, $ip18, $ip19, $ip20, $ip21, $ip22, $ip23, $ip24 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12, $ip13, $ip14, $ip15, $ip16, $ip17, $ip18, $ip19, $ip20, $ip21, $ip22, $ip23, $ip24 ) -Region $ireland
