function flag_key = waitKeys(targetKey)
    while(1)
        [  ~, keyCode ] = KbWait(0, 3);
        if sum(keyCode(targetKey))
            break;
        end

    end
    
    flag_key = keyCode(targetKey);
end
