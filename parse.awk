# parse .csv files. Delimit by commas, ignoring within quotations.
# Remember to write output of this to a new file.
BEGIN {
FS = "\",\"|,\"|,"
col[0] = "Show Number"
col[1] = "Air Date"
col[2] = "Round"
col[3] = "Category"
col[4] = "Value"
col[5] = "Question"
col[6] = "Answer"
}
NR >=2 {
	printf "{"
	j = 0;
	for( i = 1; i <= NF; i++ )
	{
    # For when the categories have "" around the element
	  if( i > 3 && i < 6 )
		  printf "\\\"%s\\\":\\\"%s\\\",", col[j], $i;
    # For the Question category
    else if(i == 6 && NF > 7)
      printf "\\\"%s\\\":\"\\%s,", col[j], $i;
    # Last category: Answer
	  else if( i >= (NF-1) )
		  printf "\\\"%s\\\":\\\"%s\\\"", col[j], substr($i, 0, length($i) - 2); # Remove " at end of element
	  else	
		  printf "\\\"%s\\\":\\\"%s\\\",", col[j], $i;
	  # Concatentates fields with commas within quotes depending on number of fields
	  while ( NF > 7 && i >= 6 && i < NF-1 )
	  {
	     # prints each field one after another
	     i++;
       if(i == (NF-1) ) # Last field to concatenate
         printf "%s\\\",", $i
       else # All the fields in between first and last of comma separated question.
	       printf "%s,", $i
	  } 
	  #printf "\\\"%s\\\":\\\"%s\\\",", col[j], $i;
	  j++;
	  #printf "%s | ", $i
	}
	printf "}\n"
}
