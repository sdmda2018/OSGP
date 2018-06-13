function location = MatchM(num)
 for n=1:1:8
                   st=sprintf('standard%d.png',n-1);
                   refer = imread(st);
                   delta = num - refer;
                   similar(n)  = sum(delta(:));  
 end
               
                   %similar
                   [similarity,loc]= min(similar);
                   location = loc -1;  