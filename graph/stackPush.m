function [nstack, nptr] = stackPush(stack, ptr, val)
    nstack = stack;
    nptr = ptr + 1;
    nstack(nptr) = val;
end

