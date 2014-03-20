--@import see.rt.ClassLoader
--@import see.rt.DefaultClassLoader
--@import see.net.HTTP
--@import see.net.URL

--@native loadstring

--@extends see.rt.DefaultClassLoader

function HTTPClassLoader:loadClass(url, name)
	local response = HTTP.sync(url)
	if response.responseCode ~= 200 then
		return nil, "HTTP Response: " .. response.responseCode
	end

	local code = response.body:lstr()
	local def, err = loadstring(code, name)
	if not def then
		return nil, "Could not load class!"
	end

	return self:super(DefaultClassLoader).loadClass(def, ClassLoader.getAnnotations(code), name)
end