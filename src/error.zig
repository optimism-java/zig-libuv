const std = @import("std");
const testing = std.testing;
const c = @import("c.zig");

/// Enum mapping for errors.
pub const Errno = enum(i32) {
    E2BIG = c.UV_E2BIG,
    EACCES = c.UV_EACCES,
    EADDRINUSE = c.UV_EADDRINUSE,
    EADDRNOTAVAIL = c.UV_EADDRNOTAVAIL,
    EAFNOSUPPORT = c.UV_EAFNOSUPPORT,
    EAGAIN = c.UV_EAGAIN,
    EAI_ADDRFAMILY = c.UV_EAI_ADDRFAMILY,
    EAI_AGAIN = c.UV_EAI_AGAIN,
    EAI_BADFLAGS = c.UV_EAI_BADFLAGS,
    EAI_BADHINTS = c.UV_EAI_BADHINTS,
    EAI_CANCELED = c.UV_EAI_CANCELED,
    EAI_FAIL = c.UV_EAI_FAIL,
    EAI_FAMILY = c.UV_EAI_FAMILY,
    EAI_MEMORY = c.UV_EAI_MEMORY,
    EAI_NODATA = c.UV_EAI_NODATA,
    EAI_NONAME = c.UV_EAI_NONAME,
    EAI_OVERFLOW = c.UV_EAI_OVERFLOW,
    EAI_PROTOCOL = c.UV_EAI_PROTOCOL,
    EAI_SERVICE = c.UV_EAI_SERVICE,
    EAI_SOCKTYPE = c.UV_EAI_SOCKTYPE,
    EALREADY = c.UV_EALREADY,
    EBADF = c.UV_EBADF,
    EBUSY = c.UV_EBUSY,
    ECANCELED = c.UV_ECANCELED,
    ECHARSET = c.UV_ECHARSET,
    ECONNABORTED = c.UV_ECONNABORTED,
    ECONNREFUSED = c.UV_ECONNREFUSED,
    ECONNRESET = c.UV_ECONNRESET,
    EDESTADDRREQ = c.UV_EDESTADDRREQ,
    EEXIST = c.UV_EEXIST,
    EFAULT = c.UV_EFAULT,
    EFBIG = c.UV_EFBIG,
    EHOSTUNREACH = c.UV_EHOSTUNREACH,
    EINTR = c.UV_EINTR,
    EINVAL = c.UV_EINVAL,
    EIO = c.UV_EIO,
    EISCONN = c.UV_EISCONN,
    EISDIR = c.UV_EISDIR,
    ELOOP = c.UV_ELOOP,
    EMFILE = c.UV_EMFILE,
    EMSGSIZE = c.UV_EMSGSIZE,
    ENAMETOOLONG = c.UV_ENAMETOOLONG,
    ENETDOWN = c.UV_ENETDOWN,
    ENETUNREACH = c.UV_ENETUNREACH,
    ENFILE = c.UV_ENFILE,
    ENOBUFS = c.UV_ENOBUFS,
    ENODEV = c.UV_ENODEV,
    ENOENT = c.UV_ENOENT,
    ENOMEM = c.UV_ENOMEM,
    ENONET = c.UV_ENONET,
    ENOPROTOOPT = c.UV_ENOPROTOOPT,
    ENOSPC = c.UV_ENOSPC,
    ENOSYS = c.UV_ENOSYS,
    ENOTCONN = c.UV_ENOTCONN,
    ENOTDIR = c.UV_ENOTDIR,
    ENOTEMPTY = c.UV_ENOTEMPTY,
    ENOTSOCK = c.UV_ENOTSOCK,
    ENOTSUP = c.UV_ENOTSUP,
    EPERM = c.UV_EPERM,
    EPIPE = c.UV_EPIPE,
    EPROTO = c.UV_EPROTO,
    EPROTONOSUPPORT = c.UV_EPROTONOSUPPORT,
    EPROTOTYPE = c.UV_EPROTOTYPE,
    ERANGE = c.UV_ERANGE,
    EROFS = c.UV_EROFS,
    ESHUTDOWN = c.UV_ESHUTDOWN,
    ESPIPE = c.UV_ESPIPE,
    ESRCH = c.UV_ESRCH,
    ETIMEDOUT = c.UV_ETIMEDOUT,
    ETXTBSY = c.UV_ETXTBSY,
    EXDEV = c.UV_EXDEV,
    UNKNOWN = c.UV_UNKNOWN,
    EOF = c.UV_EOF,
    ENXIO = c.UV_ENXIO,
    EHOSTDOWN = c.UV_EHOSTDOWN,
    EREMOTEIO = c.UV_EREMOTEIO,
    ENOTTY = c.UV_ENOTTY,
    EFTYPE = c.UV_EFTYPE,
    EILSEQ = c.UV_EILSEQ,
    ESOCKTNOSUPPORT = c.UV_ESOCKTNOSUPPORT,
};

/// Errors that libuv can produce.
///
/// http://docs.libuv.org/en/v1.x/errors.html
pub const Error = blk: {
    // We produce these from the Errno enum so that we can easily
    // keep it synced.
    const info = @typeInfo(Errno).@"enum";
    var errors: [info.fields.len]std.builtin.Type.Error = undefined;
    for (info.fields, 0..) |field, i| {
        errors[i] = .{ .name = field.name };
    }

    break :blk @Type(.{ .error_set = &errors });
};

/// Convert the result of a libuv API call to an error (or no error).
pub fn convertError(r: i32) !void {
    if (r >= 0) return;

    return switch (@as(Errno, @enumFromInt(r))) {
        .E2BIG => Error.E2BIG,
        .EACCES => Error.EACCES,
        .EADDRINUSE => Error.EADDRINUSE,
        .EADDRNOTAVAIL => Error.EADDRNOTAVAIL,
        .EAFNOSUPPORT => Error.EAFNOSUPPORT,
        .EAGAIN => Error.EAGAIN,
        .EAI_ADDRFAMILY => Error.EAI_ADDRFAMILY,
        .EAI_AGAIN => Error.EAI_AGAIN,
        .EAI_BADFLAGS => Error.EAI_BADFLAGS,
        .EAI_BADHINTS => Error.EAI_BADHINTS,
        .EAI_CANCELED => Error.EAI_CANCELED,
        .EAI_FAIL => Error.EAI_FAIL,
        .EAI_FAMILY => Error.EAI_FAMILY,
        .EAI_MEMORY => Error.EAI_MEMORY,
        .EAI_NODATA => Error.EAI_NODATA,
        .EAI_NONAME => Error.EAI_NONAME,
        .EAI_OVERFLOW => Error.EAI_OVERFLOW,
        .EAI_PROTOCOL => Error.EAI_PROTOCOL,
        .EAI_SERVICE => Error.EAI_SERVICE,
        .EAI_SOCKTYPE => Error.EAI_SOCKTYPE,
        .EALREADY => Error.EALREADY,
        .EBADF => Error.EBADF,
        .EBUSY => Error.EBUSY,
        .ECANCELED => Error.ECANCELED,
        .ECHARSET => Error.ECHARSET,
        .ECONNABORTED => Error.ECONNABORTED,
        .ECONNREFUSED => Error.ECONNREFUSED,
        .ECONNRESET => Error.ECONNRESET,
        .EDESTADDRREQ => Error.EDESTADDRREQ,
        .EEXIST => Error.EEXIST,
        .EFAULT => Error.EFAULT,
        .EFBIG => Error.EFBIG,
        .EHOSTUNREACH => Error.EHOSTUNREACH,
        .EINTR => Error.EINTR,
        .EINVAL => Error.EINVAL,
        .EIO => Error.EIO,
        .EISCONN => Error.EISCONN,
        .EISDIR => Error.EISDIR,
        .ELOOP => Error.ELOOP,
        .EMFILE => Error.EMFILE,
        .EMSGSIZE => Error.EMSGSIZE,
        .ENAMETOOLONG => Error.ENAMETOOLONG,
        .ENETDOWN => Error.ENETDOWN,
        .ENETUNREACH => Error.ENETUNREACH,
        .ENFILE => Error.ENFILE,
        .ENOBUFS => Error.ENOBUFS,
        .ENODEV => Error.ENODEV,
        .ENOENT => Error.ENOENT,
        .ENOMEM => Error.ENOMEM,
        .ENONET => Error.ENONET,
        .ENOPROTOOPT => Error.ENOPROTOOPT,
        .ENOSPC => Error.ENOSPC,
        .ENOSYS => Error.ENOSYS,
        .ENOTCONN => Error.ENOTCONN,
        .ENOTDIR => Error.ENOTDIR,
        .ENOTEMPTY => Error.ENOTEMPTY,
        .ENOTSOCK => Error.ENOTSOCK,
        .ENOTSUP => Error.ENOTSUP,
        .EPERM => Error.EPERM,
        .EPIPE => Error.EPIPE,
        .EPROTO => Error.EPROTO,
        .EPROTONOSUPPORT => Error.EPROTONOSUPPORT,
        .EPROTOTYPE => Error.EPROTOTYPE,
        .ERANGE => Error.ERANGE,
        .EROFS => Error.EROFS,
        .ESHUTDOWN => Error.ESHUTDOWN,
        .ESPIPE => Error.ESPIPE,
        .ESRCH => Error.ESRCH,
        .ETIMEDOUT => Error.ETIMEDOUT,
        .ETXTBSY => Error.ETXTBSY,
        .EXDEV => Error.EXDEV,
        .UNKNOWN => Error.UNKNOWN,
        .EOF => Error.EOF,
        .ENXIO => Error.ENXIO,
        .EHOSTDOWN => Error.EHOSTDOWN,
        .EREMOTEIO => Error.EREMOTEIO,
        .ENOTTY => Error.ENOTTY,
        .EFTYPE => Error.EFTYPE,
        .EILSEQ => Error.EILSEQ,
        .ESOCKTNOSUPPORT => Error.ESOCKTNOSUPPORT,
    };
}
test {
    // This is mostly just forcing our error type and function to be
    // codegenned and run once to ensure we have all the types.
    try testing.expectError(Error.EFTYPE, convertError(c.UV_EFTYPE));
}
