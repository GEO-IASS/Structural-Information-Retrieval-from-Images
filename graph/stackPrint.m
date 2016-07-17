function stackPrint(stack, ptr)
    for k = 1:ptr
        fprintf('%d, ', stack(k));
    end
    fprintf('\n');
end