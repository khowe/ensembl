## Bioperl Test Harness Script for Modules
##

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

#-----------------------------------------------------------------------
## perl test harness expects the following output syntax only!
## 1..3
## ok 1  [not ok 1 (if test fails)]
## 2..3
## ok 2  [not ok 2 (if test fails)]
## 3..3
## ok 3  [not ok 3 (if test fails)]
##
## etc. etc. etc. (continue on for each tested function in the .t file)
#-----------------------------------------------------------------------


## We start with some black magic to print on failure.
BEGIN { $| = 1; print "1..7\n"; 
	use vars qw($loaded); }
END {print "not ok 1\n" unless $loaded;}


use Bio::EnsEMBL::DBLoader;
use Bio::SeqIO;

use lib 't';
use EnsTestDB;
$loaded = 1;
print "ok 1\n";    # 1st test passes.
    
my $ens_test = EnsTestDB->new();
my $ens_dna  = EnsTestDB->new();


# Load some data into the db
$ens_test->do_sql_file("t/staticgoldenpath.dump");
$ens_dna ->do_sql_file("t/staticgoldenpath.dump");

print "ok 2\n";    

$ens_test->dnadb($ens_dna->get_DBSQL_Obj);
    
print "ok 3\n";    

# Get an EnsEMBL db object for the test db
my $db = $ens_test->get_DBSQL_Obj;
print "ok 4\n";    

@cloneids =  $db->get_all_Clone_id();
my $clone  = $db->get_Clone($cloneids[0]);

print "ok 5\n";

my @contigs = $clone->get_all_Contigs();
my $contig = $db->get_Contig($contigs[0]->id);
print "ok 6\n";

$seqout = Bio::SeqIO->new( -Format => 'fasta',-file => ">t/DB.fasta" );
$seqout->write_seq($contig);

print "ok 7\n";
    





