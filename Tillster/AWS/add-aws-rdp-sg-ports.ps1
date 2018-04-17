#----------------------------------------------------------------------------#
# These are the default ports for the AWS SCCM Security Groups. 
# They are to be used when creating new SCCM VPC's
# Comment out the region variables that you are not using, irelnad or oregon
#----------------------------------------------------------------------------#
#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-bd65ddc2"
$ireland = "eu-west-1"
$IRE_SGID1 = ""
$ip1 = @{ IpProtocol="All"; FromPort="ALL"; ToPort="ALL"; IpRanges="10.100.0.0/24" }
$ip2 = @{ IpProtocol="tcp"; DPFromPort="3389"; ToPort="3389"; IpRanges="172.114.234.140/32" }
#--------------------------------------------------------------------------------#
# Comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#--------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $ORE_SGID1 -IpPermission @( $ip1, $ip2 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1, $ip2 ) -Region $ireland