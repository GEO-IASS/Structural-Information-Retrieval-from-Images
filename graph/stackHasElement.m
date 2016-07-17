function id = stackHasElement(stack, ptr, val)
    id = find(stack(1:ptr) == val);
end