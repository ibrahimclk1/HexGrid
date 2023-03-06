function out1 = tar_pos(eyes,post)


b=[];

for ind = 1:length(eyes)
    data = eyes{ind};
    
    target_bin_loc = data(1:2,post(ind));
    
        if target_bin_loc(1) < 0 & target_bin_loc(2) < 0
            target_bin = 3;
        elseif target_bin_loc(1) < 0 & target_bin_loc(2) > 0
            target_bin = 2;
        elseif target_bin_loc(1) > 0 & target_bin_loc(2) < 0
            target_bin = 4;
        elseif target_bin_loc(1) > 0 & target_bin_loc(2) > 0
            target_bin = 1;
        end
      
      b(1,end+1) = target_bin;
end
out1=b;

