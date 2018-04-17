#----------------------------------------------------------------------------#
# These are the default ports for the AWS SCCM Security Groups. 
# They are to be used when creating new SCCM VPC's
# Comment out the region variables that you are not using, irelnad or oregon
#----------------------------------------------------------------------------#
#$oregon = "us-west-2"
#$ORE_SGID1 = "sg-de8da2a1"
$ireland = "eu-west-1"
$IRE_SGID1 = ""
$ip1 = @{ IpProtocol="tcp"; FromPort="1194"; ToPort="1194"; IpRanges="0.0.0.0/0" }
#--------------------------------------------------------------------------------#
# Comment out the command region that has the -Region variable 
# that you are not using irelnad or oregon
#--------------------------------------------------------------------------------#
#Grant-EC2SecurityGroupIngress -GroupId $ORE_SGID1 -IpPermission @( $ip1 ) -Region $oregon
Grant-EC2SecurityGroupIngress -GroupId $IRE_SGID1 -IpPermission @( $ip1 ) -Region $ireland