#!/usr/bin/perl
#

#
#----------------------------------------

use CGI::Seamstress;

warn 0;

$S = CGI::Seamstress -> 
    new(
	{ Template_Directory 
	      => "/usr/end70/mnt/admin/perl/CGI/Seamstress/templates"
	      }
	);

warn 1;

while (($k,$v) = each %::_Thread) {
    warn " ::_Thread $k->$v ";
}

warn 2;    

## Main Variables ## 

my ($k,$v);

my %Form;

## Database Related Variables ##
## Defining Templates ##


#-----------------------------------------

print $S->header();


warn "A";

### Build a hash ###
@fields = @{$S->{'.parameters'}}; 
@optional_fields = ();
foreach $field (@fields) {
    $Form{$field} = $S->{$field}[0];
}

warn "B";

##############################
# Display Initial Template   # 
##############################
if ($Form{'phase'}) {
    warn "FORM PHASE";
    $S->Display('login.tmpl', \%Form); 
}

warn "C";

##############################
# Validate Form Information  # 
##############################
($status, $err, @err) = $S->Validate_Form(\%Form, @optional_fields); 
if (!$status) {
    foreach $e (@err) {
	$t = "$e\_Error";
	warn "storing error labeled $t";
	$Form{$t} = $S->Message("Invalid", 'bold','0', 'C00000', '0') ;
    }
    $Form{'Message'} = $S->Message($err, 'bold','blink', 'ffffff', '1', 'C00000', 3, 350) ;
    warn "here is the hash we pass to display:";
    while (($k,$v) = each %Form) {
	warn "$k->$v";
    }
    $S->Display('login.tmpl', \%Form); 
}

### Validating email address
($status) = $S->Validate_Email_Syntax($Form{'email'});
if ($status eq -1) {
    $Form{'Message'} = $S->Message("Invalid Email Address", 'bold','blink', 'ffffff', '1', 'C00000', 3, 350) ;
    $Form{'email_Error'} = $S->Message("Invalid", 'bold','0', 'C00000', '0') ;
    $S->Display('login.tmpl', \%Form);
}	

### Validate if password and verify password fields match
warn "password , verify_password: $Form{'password'} , $Form{'verify_password'}";
if ($Form{'password'} ne $Form{'verify_password'}) {
    $Form{'Message'} = $S->Message("Password Mismatched", 'bold','blink', 'ffffff', '1', 'C00000', 3, 350) ;
    $Form{'password_Error'} = $S->Message("Mismatched", 'bold','0', 'C00000', '0') ;
    $Form{'verify_password_Error'} = $S->Message("Mismatched", 'bold','0', 'C00000', '0') ;
    $S->Display('login.tmpl', \%Form);

} 


#######################################
# Obtain form information (function)
#######################################

#######################################
# Validate form information (function) 
#######################################

#############################################
# Insert info into temp database (function)
#############################################

################################################################
### Once complete, insert info into end70 database (functin)   #
################################################################

##########################################
#  Create Merchant account (function)    #
##########################################

#####################################
#   Send email to user (function)   #
#####################################


$S->Display('login-successful.tmpl'); 



1;
