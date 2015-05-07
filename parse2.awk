# parse .csv files. Delimit by commas, ignoring within quotations.
# Remember to write output of this to a new file.
BEGIN {
FS = ","
col[0] = "Show Number"
col[1] = "Air Date"
col[2] = "Round"
col[3] = "Category"
col[4] = "Value"
col[5] = "Question"
col[6] = "Answer"
}
NR >=2 {
 # j is used to keep track of header column since the number of fields will change for each line
 j = 0
 
 # starting JSON outputting
 printf "{";
 
 for( i = 1; i <= NF; i++ )
 {
   # first 3 fields won't have quotes (Show number, Air Date, Round)
   if( i >= 1 && i <= 3 ) 
     printf "\"%s\":\"%s\",", col[j++], $i;
     
   # 4th field (Category) has quotes, don't need to include them
   if( i == 4 )
   {
     #sub(/""/, "\'\"\'\'\"\'", $i)
     printf "\"%s\":%s,", col[j++], $i;
   }
     
   
   # 5th field (Value) has quotes and may have a comma so put them together
   if( i == 5 ){
     if( length($5) == 2 ){
       printf "\"%s\":%s%s,", col[j++], $5, $6;
       i++
       # skip to next field
     }
     else
       printf "\"%s\":%s,", col[j++], $5;
   }
   
   # 6th field (Question) may have commas and is in quotes
   if( i > 5 && i <= NF-1){
     #sub(/""/, "\'\"\'\'\"\'", $i)
     printf "\"%s\":%s,", col[j++], $i
     i++
     # append each field until it reaches last field 
     while( i <= NF-1 ){
       #sub(/""/, "\'\"\'\'\"\'", $i)
       printf "%s,", $i
       i++
     }
   }
   
   #Last field (Answer) in quotes no commas end with closing brace
   if (i == NF)
     printf "\"%s\":%s}\n", col[j++], substr($i, 0, length($i) - 1)  
  }
}