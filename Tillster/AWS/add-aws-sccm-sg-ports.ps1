#----------------------------------------------------------------------------#
# These are the default ports for the AWS SCCM Security Groups. 
# They are to be used when creating new SCCM VPC's
# Comment out the region variables that you are not using, irelnad or oregon
#----------------------------------------------------------------------------#
#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-5305542f"
$ireland = "eu-west-1"
$IRE_SGID1 = ""
$ip1 = @{ IpProtocol="udp"; FromPort="445"; ToPort="445"; IpRanges="172.0.0.0/8" }
$ip2 = @{ IpProtocol="tcp"; DPFromPort="80"; ToPort="80"; IpRanges="172.0.0.0/8" }
$ip3 = @{ IpProtocol="udp"; FromPort="135"; ToPort="135"; IpRanges="172.0.0.0/8" }
$ip4 = @{ IpProtocol="tcp"; FromPort="49152"; ToPort="65535"; IpRanges="172.0.0.0/8" }
$ip5 = @{ IpProtocol="tcp"; FromPort="10123"; ToPort="10123"; IpRanges="172.0.0.0/8" }
$ip6 = @{ IpProtocol="tcp"; FromPort="8530"; ToPort="8531"; IpRanges="172.0.0.0/8" }
$ip7 = @{ IpProtocol="tcp"; FromPort="445"; ToPort="445"; IpRanges="172.0.0.0/8" }
$ip8 = @{ IpProtocol="tcp"; FromPort="443"; ToPort="443"; IpRanges="172.0.0.0/8" }
$ip9 = @{ IpProtocol="tcp"; FromPort="137"; ToPort="139"; IpRanges="172.0.0.0/8" }
$ip10 = @{ IpProtocol="udp"; FromPort="137"; ToPort="139"; IpRanges="172.0.0.0/8" }
$ip11 = @{ IpProtocol="tcp"; FromPort="135"; ToPort="135"; IpRanges="172.0.0.0/8" }
$ip12 = @{ IpProtocol="udp"; FromPort="67"; ToPort="68"; IpRanges="172.0.0.0/8" }
#-----------------------------------------------------------------------------------------#
# Comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#------------------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $ORE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12 ) -Region $ireland