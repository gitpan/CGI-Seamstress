use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    'VERSION_FROM' => 'Seamstress.pm',
    'NAME'      => 'CGI::Seamstress',
    'PREREQ_PM' => { 'CGI' }	      
	      );



