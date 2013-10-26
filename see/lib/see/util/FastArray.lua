--@native table

function FastArray.insert(...)
    table.insert(...)
end

function FastArray.remove(array, index)
    table.remove(array, index)
end

function FastArray.sort(array, comp)
    table.sort(array, comp)
end