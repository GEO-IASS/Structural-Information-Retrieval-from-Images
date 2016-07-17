function [nstack, nptr, val] = stackPop(stack, ptr)
    nstack = stack;
    if ptr == 0
        nptr = 0;
        val = NaN;
    else
        val = stack(ptr);
        nptr = ptr - 1;
    end
end