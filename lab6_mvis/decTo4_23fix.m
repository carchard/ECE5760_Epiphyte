function bin = decTo4_23fix(dec)
    i = floor(abs(dec));
    d = abs(dec) - i;
    neg = (dec<0);
    
    for j = 24:27
        if i>=1
            i = i/2;
            if (i ~= round(i))
                bin(j) = 1;
            else 
                bin(j) = 0;
            end
        else
            bin(j) = 0;
        end
    end
    
    for i = 23:-1:1
        d = d*2;
        if (d >= 1)
            bin(i) = 1;
            d = d-1;
        else 
            bin(i) = 0;
        end
    end
    
    if(neg)
        for i = 1:length(bin)
            if bin(i)
                bin(i) = 0;
            else 
                bin(i) = 1;
            end
        end
        
        carry = 1;
        idx   = 1;
        
        while (carry == 1)
            if (bin(idx) == 1)
                bin(idx) = 0;
                carry = 1;
                idx = idx + 1;
            else
                bin(idx) = 1;
                carry = 0;
                idx = idx + 1;
            end
        end
    end
    
    for i = 7:-1:1
        if i == 7
           fprintf('27''b%i%i%i_',bin(27),bin(26),bin(25)); 
        elseif i==1
            fprintf('%i%i%i%i;\n',bin(4*i),bin(4*i-1),bin(4*i-2),bin(4*i-3));
        else
           fprintf('%i%i%i%i_',bin(4*i),bin(4*i-1),bin(4*i-2),bin(4*i-3));
        end  
    end