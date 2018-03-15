#----------------------------------------------------------------------------#
# These are the default ports for the AWS SCCM Security Groups. 
# They are to be used when creating new SCCM VPC's
# Comment out the region variables that you are not using, irelnad or oregon
#----------------------------------------------------------------------------#
#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-babc93c5"
$ireland = "eu-west-1"
$IRE_SGID1 = ""
$ip1 = @{ IpProtocol="tcp"; FromPort="8787"; ToPort="8787"; IpRanges="172.114.234.140/32" }
$ip2 = @{ IpProtocol="tcp"; DPFromPort="8787"; ToPort="8787"; IpRanges="12.226.147.9/32" }
$ip3 = @{ IpProtocol="tcp"; FromPort="8787"; ToPort="8787"; IpRanges="12.226.147.32/28" }
$ip4 = @{ IpProtocol="tcp"; FromPort="17778"; ToPort="17791"; IpRanges="12.226.147.9/32" }
$ip5 = @{ IpProtocol="tcp"; FromPort="17778"; ToPort="17791"; IpRanges="172.114.234.140/32" }
$ip6 = @{ IpProtocol="all"; FromPort="NA"; ToPort="NA"; IpRanges="0.0.0.0/0" }
#--------------------------------------------------------------------------------------------#
# comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#----------------------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $ORE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1, $ip2, $ip3, $ip4, $ip5, $ip6 ) -Region $ireland