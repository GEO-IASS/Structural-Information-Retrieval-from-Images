function val = stackPeek(stack, id)
    try
        val = stack(id);
    catch
        val = NaN;
    end
end