--@abstract loadClass

function ClassLoader.getAnnotations(code)
    local annotations = { }
    for annotation in code:gmatch("%-%-@[^\n]*") do
        FastArray.insert(annotations, annotation:sub(4))
    end
    return annotations
end

function ClassLoader.getPackageName(package, del)
    if not del then del = "." end
    for i = #package, 0, -1 do
        if i == 0 or package:sub(i, i) == del then
            return package:sub(i + 1)
        end
    end
end