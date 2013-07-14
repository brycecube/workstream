def is_file_safe( file, extension=nil )
  rval = true
  if extension
    rval = file.end_with?( ".#{extension}" )
  end
  
  if rval
    rval = /^[A-Za-z0-9][A-Za-z0-9 ._-]+$/.match( file )
  end
  
  return rval
end

