# NetCDFError, error check and netcdf_c.jl from NetCDF.jl (https://github.com/JuliaGeo/NetCDF.jl)
# Copyright (c) 2012-2013: Fabian Gans, Max-Planck-Institut fuer Biogeochemie, Jena, Germany
# MIT

import Base: showerror

"""
    NetCDFError(code::Cint)

Construct a NetCDFError from the error code.
"""
NetCDFError(code::Cint) = NetCDFError(code, nc_strerror(code))

function Base.showerror(io::IO, err::NetCDFError)
    print(io, "NetCDF error: ")
    printstyled(io, err.msg, color=:red)
    print(io, " (NetCDF error code: $(err.code))")
end

"Check the NetCDF error code, raising an error if nonzero"
function check(code::Cint)
    # zero means success, return
    if code == Cint(0)
        return
        # otherwise throw an error message
    else
        throw(NetCDFError(code))
    end
end
