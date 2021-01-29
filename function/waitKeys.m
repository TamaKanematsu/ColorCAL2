function flag_key = waitKeys(targetKey)
cc=0;

    while(1)
        cc=cc+1;
        disp(cc);
        [  ~, keyCode ] = KbWait([], 3);
        
        if sum(keyCode(targetKey))
            break;
        end

    end
    
    flag_key = keyCode(targetKey);
end
