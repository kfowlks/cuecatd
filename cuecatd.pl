#!/usr/local/bin/perl

sub CheckDigitISBN($); # Declaration
sub CueCatDecode($$);  # Declaration  
sub BarCodeType($);    # Declaration



# CueCat Decoder & ISBN Check Digit Maker For Perl
# Version 1.0.0  GPL
# All Code Here is free to use but must give credit 
# Written By Kevin Fowlks
# http://www.barcode-search.com
# Aug 29,2000  



# Arg 1 is the Cuecat String and Arg 2 is the type
# e.g.Type Can be the Following  1 - (CuecatID) 2 - (Barcode Type) 3 - (Barcode) 
# Returns String of Barcode Based On Type

sub CueCatDecode($$)
{

    $value=@_[0];
    $s=@_[1];


    # Lets Split our CuCat String into a Array with all the differnt subsections
    @v=split /\./,$value;
   
    $t=0;

    $flip=0; # Got to start off on our first section of code
    

    for ($i=0;$i<length($v[$s]);$i++) 
    {

        if ($flip == 0)
        {

                # Get 2 - Bytes of Data  
        	$c = substr($v[$s],$i,2);

                # Translate our 2-Bytes into a one ByteCode
        	if ($c eq 'C3') { $bcode='0';  }
        	if ($c eq 'CN') { $bcode='1';  }
        	if ($c eq 'Cx') { $bcode='2';  }
        	if ($c eq 'Ch') { $bcode='3';  }
        	if ($c eq 'D3') { $bcode='4';  }
        	if ($c eq 'DN') { $bcode='5';  }
        	if ($c eq 'Dx') { $bcode='6';  }
        	if ($c eq 'Dh') { $bcode='7';  }
        	if ($c eq 'E3') { $bcode='8';  }
        	if ($c eq 'EN') { $bcode='9';  }

        	$flip=1;

        } 
	
         elsif ($flip == 1 ) 
	{
              

         	$c = substr($v[$s],$i+1,1); # Get One Byte of Data


		# Translate our One byte into a OneByte Code

         	if ($c eq 'n') { $bcode='0';  }
         	if ($c eq 'Z') { $bcode='0';  }
         	if ($c eq 'j') { $bcode='1';  }
         	if ($c eq 'Y') { $bcode='1';  }
         	if ($c eq 'f') { $bcode='2';  }
         	if ($c eq 'X') { $bcode='2';  }
         	if ($c eq 'b') { $bcode='3';  }
         	if ($c eq 'W') { $bcode='3';  }
         	if ($c eq 'D') { $bcode='4';  }
         	if ($c eq '3') { $bcode='4';  }
         	if ($c eq 'z') { $bcode='5';  }
         	if ($c eq '2') { $bcode='5';  }
         	if ($c eq 'v') { $bcode='6';  }
         	if ($c eq '1') { $bcode='6';  }
         	if ($c eq 'r') { $bcode='7';  }
         	if ($c eq '0') { $bcode='7';  }
         	if ($c eq 'T') { $bcode='8';  }
         	if ($c eq '7') { $bcode='8';  }
         	if ($c eq 'P') { $bcode='9';  }
         	if ($c eq '6') { $bcode='9';  }

	 	$t++; # Count How Many Times it's been in this loop 

         	if ($t == 2) { $flip=0; $i++; $t=0;} 
      
         }
         
	$dc = $dc . $bcode; # Builds BarCode from bcode
    	$c=""; 		    # Clear Out Readdate
    	$bcode=""; 	    # Store Barcode Translation
    } 




    return $dc;

}

# Creates a ISBN Check Digit from the first 9 digits of an ISBN Number
# Arg-1 takes the first 9 digits of a barcode 
# Returns: Digit 
# Note: If digit is equal to 10 then replace with an X this is standard
sub CheckDigitISBN($)
{
        $value = @_[0];

        for ($i = 0; $i < 9; $i++)
        {
            $sum = (10-$i);
            $sss= $sum *  substr($value,$i,1);
            $ss=$ss+$sss;
            $sum = (11-($ss %  11));

        }
        return $sum;
}



sub BarCodeType($)
{

  if (@_[0] eq "cGf2") {$btype="ISBN";}
  else { $btype="UNKNOWN";}

  return  $btype;

}
