--@import see.io.FileOutputStream
--@import see.io.FileInputStream
--@import see.io.Path
--@import see.io.Files

function Test.main()
    local path = Path.new("/fostest")

    if not Files.exists(path) then
        System.print("File does not exist!")
        return
    end

    local fos = FileOutputStream.new(path)
    fos:write(133)
    fos:close()

    local fis = FileInputStream.new(path)
    System.print(fis:read())
    fis:close()
end