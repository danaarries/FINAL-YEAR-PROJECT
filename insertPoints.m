function interpolate=insertPoints(x,diff)

  ori=x;
  ori=ori(:);
  interpolate=x;
  interpolate=interpolate(:);
  n=1; 
    for w=1:(length(ori)) 
   
      for f=1:diff 
          
       if w~=length(ori)   
           
        if ori(w)> ori(w+1)
           sub=(ori(w)-ori(w+1))/(diff+1) ;
           insert=ori(w)-(sub*f);
           interpolate=[interpolate(1:n+f-1);insert;interpolate((n+f):end)];
        else 
           add=(ori(w+1)-ori(w))/(diff+1);
           insert=ori(w)+(add*f);
           interpolate=[interpolate(1:n+f-1);insert;interpolate((n+f):end)];
        end 
        
       end
      
      end
     n=n+(diff+1);  
    end
      
end

