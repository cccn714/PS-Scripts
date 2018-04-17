#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-babc93c5"
$ireland = "eu-west-1"
$IRE_SGID1 = "sg-afa2e0d5"
$ip1 = @{ IpProtocol="All"; FromPort="All"; ToPort="All"; IpRanges="10.100.0.0/24" }
$ip2 = @{ IpProtocol="All"; DPFromPort="all"; ToPort="all"; IpRanges="199.187.241.131/32" }
$ip3 = @{ IpProtocol="All"; FromPort="all"; ToPort="all"; IpRanges="199.187.241.155/32" }
$ip4 = @{ IpProtocol="tcp"; FromPort="all"; ToPort="all"; IpRanges="73.106.76.193/32" }
#$ip5 = @{ IpProtocol="tcp"; FromPort="10123"; ToPort="10123"; IpRanges="172.114.234.140/32" }
$ip6 = @{ IpProtocol="tcp"; FromPort="8530"; ToPort="8531"; IpRanges="12.226.147.9/32" }
$ip7 = @{ IpProtocol="tcp"; FromPort="445"; ToPort="445"; IpRanges="12.226.147.32/28" }
$ip8 = @{ IpProtocol="tcp"; FromPort="443"; ToPort="443"; IpRanges="76.80.148.242/32" }
$ip9 = @{ IpProtocol="tcp"; FromPort="137"; ToPort="139"; IpRanges="4.7.97.202/32" }
$ip10 = @{ IpProtocol="tcp"; FromPort="137"; ToPort="139"; IpRanges="12.189.103.34/32" }
$ip11 = @{ IpProtocol="tcp"; FromPort="135"; ToPort="135"; IpRanges="172.0.0.0/8" }
$ip12 = @{ IpProtocol="tcp"; FromPort="67"; ToPort="68"; IpRanges="12.189.103.32/28" }
#--------------------------------------------------------------------------------#
# Comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#--------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $ORE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6, $ip7, $ip8, $ip9, $ip10, $ip11, $ip12 ) -Region $ireland