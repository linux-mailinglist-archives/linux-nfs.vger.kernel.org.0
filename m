Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA41BBE28
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfIWVxO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 17:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbfIWVxO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 17:53:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97AE585362;
        Mon, 23 Sep 2019 21:53:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-118-85.phx2.redhat.com [10.3.118.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 640F419D70;
        Mon, 23 Sep 2019 21:53:13 +0000 (UTC)
Subject: Re: [nfs-utils PATCH v2] Add printf format checking
To:     Joshua Watt <jpewhacker@gmail.com>, linux-nfs@vger.kernel.org
References: <20190906163351.22944-1-JPEWhacker@gmail.com>
 <20190906202425.15013-1-JPEWhacker@gmail.com>
 <4bafb8fa-4908-c66f-8f4c-6b4b65acdeba@gmail.com>
 <df44dc8e-470d-9ecc-e08b-54431bc66703@RedHat.com>
 <35f0887f-41a7-4410-2124-4cb75d21ca3d@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9c6a4c5e-655f-c2f9-274d-185e89bb1363@RedHat.com>
Date:   Mon, 23 Sep 2019 17:53:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <35f0887f-41a7-4410-2124-4cb75d21ca3d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 23 Sep 2019 21:53:13 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/23/19 10:04 AM, Joshua Watt wrote:
> 
> On 9/20/19 9:05 AM, Steve Dickson wrote:
>>
>> On 9/16/19 2:33 PM, Joshua Watt wrote:
>>> On 9/6/19 3:24 PM, Joshua Watt wrote:
>>>> Adds a configure time check for __attribute__((format)) and then uses it
>>>> to enforce checking the format of several printf-like functions. Several
>>>> invalid uses of format codes that were discovered have now been fixed.
>>>>
>>>> V2: Fix use of "%jd" format code on an argument that wasn't intmax_t
>>> ping?
>>>
>>>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>> Committed... Thanks for the ping!
> 
> I haven't seen this commit land in the git repository git.linux-nfs.org/projects/steved/nfs-utils.git yet. Is there a different one I should be looking at?
It is there now... Sorry about that... The darn day job got in the way... again!! ;-)

steved.
> 
> Thanks
> 
>>
>> steved.
>>>> ---
>>>>    aclocal/ax_gcc_func_attribute.m4 | 238 +++++++++++++++++++++++++++++++
>>>>    configure.ac                     |   1 +
>>>>    support/include/xcommon.h        |  18 ++-
>>>>    support/include/xlog.h           |  20 ++-
>>>>    support/nfs/svc_create.c         |   2 +-
>>>>    support/nsm/rpc.c                |   2 +-
>>>>    utils/exportfs/exportfs.c        |   3 +
>>>>    utils/mountd/cache.c             |   3 +-
>>>>    utils/mountd/mountd.c            |   4 +-
>>>>    utils/nfsdcld/nfsdcld.c          |   2 +-
>>>>    utils/nfsdcld/sqlite.c           |   2 +-
>>>>    utils/nfsidmap/nfsidmap.c        |   8 +-
>>>>    utils/statd/rmtcall.c            |   2 +-
>>>>    utils/statd/statd.c              |   2 +-
>>>>    utils/statd/svc_run.c            |   5 +-
>>>>    15 files changed, 287 insertions(+), 25 deletions(-)
>>>>    create mode 100644 aclocal/ax_gcc_func_attribute.m4
>>>>
>>>> diff --git a/aclocal/ax_gcc_func_attribute.m4 b/aclocal/ax_gcc_func_attribute.m4
>>>> new file mode 100644
>>>> index 00000000..098c9aad
>>>> --- /dev/null
>>>> +++ b/aclocal/ax_gcc_func_attribute.m4
>>>> @@ -0,0 +1,238 @@
>>>> +# ===========================================================================
>>>> +#  https://www.gnu.org/software/autoconf-archive/ax_gcc_func_attribute.html
>>>> +# ===========================================================================
>>>> +#
>>>> +# SYNOPSIS
>>>> +#
>>>> +#   AX_GCC_FUNC_ATTRIBUTE(ATTRIBUTE)
>>>> +#
>>>> +# DESCRIPTION
>>>> +#
>>>> +#   This macro checks if the compiler supports one of GCC's function
>>>> +#   attributes; many other compilers also provide function attributes with
>>>> +#   the same syntax. Compiler warnings are used to detect supported
>>>> +#   attributes as unsupported ones are ignored by default so quieting
>>>> +#   warnings when using this macro will yield false positives.
>>>> +#
>>>> +#   The ATTRIBUTE parameter holds the name of the attribute to be checked.
>>>> +#
>>>> +#   If ATTRIBUTE is supported define HAVE_FUNC_ATTRIBUTE_<ATTRIBUTE>.
>>>> +#
>>>> +#   The macro caches its result in the ax_cv_have_func_attribute_<attribute>
>>>> +#   variable.
>>>> +#
>>>> +#   The macro currently supports the following function attributes:
>>>> +#
>>>> +#    alias
>>>> +#    aligned
>>>> +#    alloc_size
>>>> +#    always_inline
>>>> +#    artificial
>>>> +#    cold
>>>> +#    const
>>>> +#    constructor
>>>> +#    constructor_priority for constructor attribute with priority
>>>> +#    deprecated
>>>> +#    destructor
>>>> +#    dllexport
>>>> +#    dllimport
>>>> +#    error
>>>> +#    externally_visible
>>>> +#    fallthrough
>>>> +#    flatten
>>>> +#    format
>>>> +#    format_arg
>>>> +#    gnu_inline
>>>> +#    hot
>>>> +#    ifunc
>>>> +#    leaf
>>>> +#    malloc
>>>> +#    noclone
>>>> +#    noinline
>>>> +#    nonnull
>>>> +#    noreturn
>>>> +#    nothrow
>>>> +#    optimize
>>>> +#    pure
>>>> +#    sentinel
>>>> +#    sentinel_position
>>>> +#    unused
>>>> +#    used
>>>> +#    visibility
>>>> +#    warning
>>>> +#    warn_unused_result
>>>> +#    weak
>>>> +#    weakref
>>>> +#
>>>> +#   Unsupported function attributes will be tested with a prototype
>>>> +#   returning an int and not accepting any arguments and the result of the
>>>> +#   check might be wrong or meaningless so use with care.
>>>> +#
>>>> +# LICENSE
>>>> +#
>>>> +#   Copyright (c) 2013 Gabriele Svelto <gabriele.svelto@gmail.com>
>>>> +#
>>>> +#   Copying and distribution of this file, with or without modification, are
>>>> +#   permitted in any medium without royalty provided the copyright notice
>>>> +#   and this notice are preserved.  This file is offered as-is, without any
>>>> +#   warranty.
>>>> +
>>>> +#serial 9
>>>> +
>>>> +AC_DEFUN([AX_GCC_FUNC_ATTRIBUTE], [
>>>> +    AS_VAR_PUSHDEF([ac_var], [ax_cv_have_func_attribute_$1])
>>>> +
>>>> +    AC_CACHE_CHECK([for __attribute__(($1))], [ac_var], [
>>>> +        AC_LINK_IFELSE([AC_LANG_PROGRAM([
>>>> +            m4_case([$1],
>>>> +                [alias], [
>>>> +                    int foo( void ) { return 0; }
>>>> +                    int bar( void ) __attribute__(($1("foo")));
>>>> +                ],
>>>> +                [aligned], [
>>>> +                    int foo( void ) __attribute__(($1(32)));
>>>> +                ],
>>>> +                [alloc_size], [
>>>> +                    void *foo(int a) __attribute__(($1(1)));
>>>> +                ],
>>>> +                [always_inline], [
>>>> +                    inline __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [artificial], [
>>>> +                    inline __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [cold], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [const], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [constructor_priority], [
>>>> +                    int foo( void ) __attribute__((__constructor__(65535/2)));
>>>> +                ],
>>>> +                [constructor], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [deprecated], [
>>>> +                    int foo( void ) __attribute__(($1("")));
>>>> +                ],
>>>> +                [destructor], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [dllexport], [
>>>> +                    __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [dllimport], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [error], [
>>>> +                    int foo( void ) __attribute__(($1("")));
>>>> +                ],
>>>> +                [externally_visible], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [fallthrough], [
>>>> +                    int foo( void ) {switch (0) { case 1: __attribute__(($1)); case 2: break ; }};
>>>> +                ],
>>>> +                [flatten], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [format], [
>>>> +                    int foo(const char *p, ...) __attribute__(($1(printf, 1, 2)));
>>>> +                ],
>>>> +                [format_arg], [
>>>> +                    char *foo(const char *p) __attribute__(($1(1)));
>>>> +                ],
>>>> +                [gnu_inline], [
>>>> +                    inline __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [hot], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [ifunc], [
>>>> +                    int my_foo( void ) { return 0; }
>>>> +                    static int (*resolve_foo(void))(void) { return my_foo; }
>>>> +                    int foo( void ) __attribute__(($1("resolve_foo")));
>>>> +                ],
>>>> +                [leaf], [
>>>> +                    __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [malloc], [
>>>> +                    void *foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [noclone], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [noinline], [
>>>> +                    __attribute__(($1)) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [nonnull], [
>>>> +                    int foo(char *p) __attribute__(($1(1)));
>>>> +                ],
>>>> +                [noreturn], [
>>>> +                    void foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [nothrow], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [optimize], [
>>>> +                    __attribute__(($1(3))) int foo( void ) { return 0; }
>>>> +                ],
>>>> +                [pure], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [sentinel], [
>>>> +                    int foo(void *p, ...) __attribute__(($1));
>>>> +                ],
>>>> +                [sentinel_position], [
>>>> +                    int foo(void *p, ...) __attribute__(($1(1)));
>>>> +                ],
>>>> +                [returns_nonnull], [
>>>> +                    void *foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [unused], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [used], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [visibility], [
>>>> +                    int foo_def( void ) __attribute__(($1("default")));
>>>> +                    int foo_hid( void ) __attribute__(($1("hidden")));
>>>> +                    int foo_int( void ) __attribute__(($1("internal")));
>>>> +                    int foo_pro( void ) __attribute__(($1("protected")));
>>>> +                ],
>>>> +                [warning], [
>>>> +                    int foo( void ) __attribute__(($1("")));
>>>> +                ],
>>>> +                [warn_unused_result], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [weak], [
>>>> +                    int foo( void ) __attribute__(($1));
>>>> +                ],
>>>> +                [weakref], [
>>>> +                    static int foo( void ) { return 0; }
>>>> +                    static int bar( void ) __attribute__(($1("foo")));
>>>> +                ],
>>>> +                [
>>>> +                 m4_warn([syntax], [Unsupported attribute $1, the test may fail])
>>>> +                 int foo( void ) __attribute__(($1));
>>>> +                ]
>>>> +            )], [])
>>>> +            ],
>>>> +            dnl GCC doesn't exit with an error if an unknown attribute is
>>>> +            dnl provided but only outputs a warning, so accept the attribute
>>>> +            dnl only if no warning were issued.
>>>> +            [AS_IF([test -s conftest.err],
>>>> +                [AS_VAR_SET([ac_var], [no])],
>>>> +                [AS_VAR_SET([ac_var], [yes])])],
>>>> +            [AS_VAR_SET([ac_var], [no])])
>>>> +    ])
>>>> +
>>>> +    AS_IF([test yes = AS_VAR_GET([ac_var])],
>>>> +        [AC_DEFINE_UNQUOTED(AS_TR_CPP(HAVE_FUNC_ATTRIBUTE_$1), 1,
>>>> +            [Define to 1 if the system has the `$1' function attribute])], [])
>>>> +
>>>> +    AS_VAR_POPDEF([ac_var])
>>>> +])
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 37096944..639199a9 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -619,6 +619,7 @@ CHECK_CCSUPPORT([-Werror=format-overflow=2], [flg1])
>>>>    CHECK_CCSUPPORT([-Werror=int-conversion], [flg2])
>>>>    CHECK_CCSUPPORT([-Werror=incompatible-pointer-types], [flg3])
>>>>    CHECK_CCSUPPORT([-Werror=misleading-indentation], [flg4])
>>>> +AX_GCC_FUNC_ATTRIBUTE([format])
>>>>      AC_SUBST([AM_CFLAGS], ["$my_am_cflags $flg1 $flg2 $flg3 $flg4"])
>>>>    diff --git a/support/include/xcommon.h b/support/include/xcommon.h
>>>> index 23c9a135..30b0403b 100644
>>>> --- a/support/include/xcommon.h
>>>> +++ b/support/include/xcommon.h
>>>> @@ -9,6 +9,10 @@
>>>>    #ifndef _XMALLOC_H
>>>>    #define _MALLOC_H
>>>>    +#ifdef HAVE_CONFIG_H
>>>> +#include <config.h>
>>>> +#endif
>>>> +
>>>>    #include <sys/types.h>
>>>>    #include <fcntl.h>
>>>>    #include <limits.h>
>>>> @@ -25,9 +29,15 @@
>>>>      #define streq(s, t)    (strcmp ((s), (t)) == 0)
>>>>    -/* Functions in sundries.c that are used in mount.c and umount.c  */
>>>> +#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
>>>> +#define X_FORMAT(_x) __attribute__((__format__ _x))
>>>> +#else
>>>> +#define X_FORMAT(_x)
>>>> +#endif
>>>> +
>>>> +/* Functions in sundries.c that are used in mount.c and umount.c  */
>>>>    char *canonicalize (const char *path);
>>>> -void nfs_error (const char *fmt, ...);
>>>> +void nfs_error (const char *fmt, ...) X_FORMAT((printf, 1, 2));
>>>>    void *xmalloc (size_t size);
>>>>    void *xrealloc(void *p, size_t size);
>>>>    void xfree(void *);
>>>> @@ -36,9 +46,9 @@ char *xstrndup (const char *s, int n);
>>>>    char *xstrconcat2 (const char *, const char *);
>>>>    char *xstrconcat3 (const char *, const char *, const char *);
>>>>    char *xstrconcat4 (const char *, const char *, const char *, const char *);
>>>> -void die (int errcode, const char *fmt, ...);
>>>> +void die (int errcode, const char *fmt, ...) X_FORMAT((printf, 2, 3));
>>>>    -extern void die(int err, const char *fmt, ...);
>>>> +extern void die(int err, const char *fmt, ...) X_FORMAT((printf, 2, 3));
>>>>    extern void (*at_die)(void);
>>>>      /* exit status - bits below are ORed */
>>>> diff --git a/support/include/xlog.h b/support/include/xlog.h
>>>> index a11463ed..32ff5a1b 100644
>>>> --- a/support/include/xlog.h
>>>> +++ b/support/include/xlog.h
>>>> @@ -7,6 +7,10 @@
>>>>    #ifndef XLOG_H
>>>>    #define XLOG_H
>>>>    +#ifdef HAVE_CONFIG_H
>>>> +#include <config.h>
>>>> +#endif
>>>> +
>>>>    #include <stdarg.h>
>>>>      /* These are logged always. L_FATAL also does exit(1) */
>>>> @@ -35,6 +39,12 @@ struct xlog_debugfac {
>>>>        int        df_fac;
>>>>    };
>>>>    +#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
>>>> +#define XLOG_FORMAT(_x) __attribute__((__format__ _x))
>>>> +#else
>>>> +#define XLOG_FORMAT(_x)
>>>> +#endif
>>>> +
>>>>    extern int export_errno;
>>>>    void            xlog_open(char *progname);
>>>>    void            xlog_stderr(int on);
>>>> @@ -43,10 +53,10 @@ void            xlog_config(int fac, int on);
>>>>    void            xlog_sconfig(char *, int on);
>>>>    void            xlog_from_conffile(char *);
>>>>    int            xlog_enabled(int fac);
>>>> -void            xlog(int fac, const char *fmt, ...);
>>>> -void            xlog_warn(const char *fmt, ...);
>>>> -void            xlog_err(const char *fmt, ...);
>>>> -void            xlog_errno(int err, const char *fmt, ...);
>>>> -void            xlog_backend(int fac, const char *fmt, va_list args);
>>>> +void            xlog(int fac, const char *fmt, ...) XLOG_FORMAT((printf, 2, 3));
>>>> +void            xlog_warn(const char *fmt, ...) XLOG_FORMAT((printf, 1, 2));
>>>> +void            xlog_err(const char *fmt, ...) XLOG_FORMAT((printf, 1, 2));
>>>> +void            xlog_errno(int err, const char *fmt, ...) XLOG_FORMAT((printf, 2, 3));
>>>> +void            xlog_backend(int fac, const char *fmt, va_list args) XLOG_FORMAT((printf, 2, 0));
>>>>      #endif /* XLOG_H */
>>>> diff --git a/support/nfs/svc_create.c b/support/nfs/svc_create.c
>>>> index 4e14430d..976c2d29 100644
>>>> --- a/support/nfs/svc_create.c
>>>> +++ b/support/nfs/svc_create.c
>>>> @@ -184,7 +184,7 @@ svc_create_sock(const struct sockaddr *sap, socklen_t salen,
>>>>            type = SOCK_STREAM;
>>>>            break;
>>>>        default:
>>>> -        xlog(D_GENERAL, "%s: Unrecognized bind address semantics: %u",
>>>> +        xlog(D_GENERAL, "%s: Unrecognized bind address semantics: %lu",
>>>>                __func__, nconf->nc_semantics);
>>>>            return -1;
>>>>        }
>>>> diff --git a/support/nsm/rpc.c b/support/nsm/rpc.c
>>>> index ae49006c..08b4746f 100644
>>>> --- a/support/nsm/rpc.c
>>>> +++ b/support/nsm/rpc.c
>>>> @@ -182,7 +182,7 @@ nsm_xmit_getport(const int sock, const struct sockaddr_in *sin,
>>>>        uint32_t xid;
>>>>        XDR xdr;
>>>>    -    xlog(D_CALL, "Sending PMAP_GETPORT for %u, %u, udp", program, version);
>>>> +    xlog(D_CALL, "Sending PMAP_GETPORT for %lu, %lu, udp", program, version);
>>>>          nsm_init_xdrmem(msgbuf, NSM_MAXMSGSIZE, &xdr);
>>>>        xid = nsm_init_rpc_header(PMAPPROG, PMAPVERS,
>>>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>>>> index 5cca4175..a04a7898 100644
>>>> --- a/utils/exportfs/exportfs.c
>>>> +++ b/utils/exportfs/exportfs.c
>>>> @@ -651,6 +651,9 @@ out:
>>>>        return result;
>>>>    }
>>>>    +#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
>>>> +__attribute__((format (printf, 2, 3)))
>>>> +#endif
>>>>    static char
>>>>    dumpopt(char c, char *fmt, ...)
>>>>    {
>>>> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
>>>> index e25a4337..3861f84a 100644
>>>> --- a/utils/mountd/cache.c
>>>> +++ b/utils/mountd/cache.c
>>>> @@ -987,8 +987,7 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
>>>>                } else if (found_type == i && found->m_warned == 0) {
>>>>                    xlog(L_WARNING, "%s exported to both %s and %s, "
>>>>                         "arbitrarily choosing options from first",
>>>> -                     path, found->m_client->m_hostname, exp->m_client->m_hostname,
>>>> -                     dom);
>>>> +                     path, found->m_client->m_hostname, exp->m_client->m_hostname);
>>>>                    found->m_warned = 1;
>>>>                }
>>>>            }
>>>> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
>>>> index 33571ecb..66366434 100644
>>>> --- a/utils/mountd/mountd.c
>>>> +++ b/utils/mountd/mountd.c
>>>> @@ -210,10 +210,10 @@ killer (int sig)
>>>>    }
>>>>      static void
>>>> -sig_hup (int sig)
>>>> +sig_hup (int UNUSED(sig))
>>>>    {
>>>>        /* don't exit on SIGHUP */
>>>> -    xlog (L_NOTICE, "Received SIGHUP... Ignoring.\n", sig);
>>>> +    xlog (L_NOTICE, "Received SIGHUP... Ignoring.\n");
>>>>        return;
>>>>    }
>>>>    diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
>>>> index cbf71fc6..7e894e49 100644
>>>> --- a/utils/nfsdcld/nfsdcld.c
>>>> +++ b/utils/nfsdcld/nfsdcld.c
>>>> @@ -212,7 +212,7 @@ cld_inotify_cb(int UNUSED(fd), short which, void *data)
>>>>        default:
>>>>            /* anything else is fatal */
>>>>            xlog(L_FATAL, "%s: unable to open new pipe (%d). Aborting.",
>>>> -            ret, __func__);
>>>> +            __func__, ret);
>>>>            exit(ret);
>>>>        }
>>>>    diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
>>>> index fa81df87..afa63499 100644
>>>> --- a/utils/nfsdcld/sqlite.c
>>>> +++ b/utils/nfsdcld/sqlite.c
>>>> @@ -473,7 +473,7 @@ sqlite_fix_table_name(const char *name)
>>>>        }
>>>>        ret = sqlite3_exec(dbh, (const char *)buf, NULL, NULL, &err);
>>>>        if (ret != SQLITE_OK) {
>>>> -        xlog(L_ERROR, "Unable to fix table for epoch %d: %s",
>>>> +        xlog(L_ERROR, "Unable to fix table for epoch %"PRIu64": %s",
>>>>                 val, err);
>>>>            goto out;
>>>>        }
>>>> diff --git a/utils/nfsidmap/nfsidmap.c b/utils/nfsidmap/nfsidmap.c
>>>> index fc00da7a..cf7f65e9 100644
>>>> --- a/utils/nfsidmap/nfsidmap.c
>>>> +++ b/utils/nfsidmap/nfsidmap.c
>>>> @@ -18,7 +18,7 @@
>>>>    #include "xcommon.h"
>>>>      int verbose = 0;
>>>> -char *usage = "Usage: %s [-vh] [-c || [-u|-g|-r key] || -d || -l || [-t timeout] key desc]";
>>>> +#define USAGE "Usage: %s [-vh] [-c || [-u|-g|-r key] || -d || -l || [-t timeout] key desc]"
>>>>      #define MAX_ID_LEN   11
>>>>    #define IDMAP_NAMESZ 128
>>>> @@ -403,7 +403,7 @@ int main(int argc, char **argv)
>>>>                break;
>>>>            case 'h':
>>>>            default:
>>>> -            xlog_warn(usage, progname);
>>>> +            xlog_warn(USAGE, progname);
>>>>                exit(opt == 'h' ? 0 : 1);
>>>>            }
>>>>        }
>>>> @@ -435,7 +435,7 @@ int main(int argc, char **argv)
>>>>        xlog_stderr(verbose);
>>>>        if ((argc - optind) != 2) {
>>>>            xlog_warn("Bad arg count. Check /etc/request-key.conf");
>>>> -        xlog_warn(usage, progname);
>>>> +        xlog_warn(USAGE, progname);
>>>>            return EXIT_FAILURE;
>>>>        }
>>>>    @@ -453,7 +453,7 @@ int main(int argc, char **argv)
>>>>            return EXIT_FAILURE;
>>>>        }
>>>>        if (verbose) {
>>>> -        xlog_warn("key: 0x%lx type: %s value: %s timeout %ld",
>>>> +        xlog_warn("key: 0x%x type: %s value: %s timeout %d",
>>>>                key, type, value, timeout);
>>>>        }
>>>>    diff --git a/utils/statd/rmtcall.c b/utils/statd/rmtcall.c
>>>> index c4f6364f..5b261480 100644
>>>> --- a/utils/statd/rmtcall.c
>>>> +++ b/utils/statd/rmtcall.c
>>>> @@ -247,7 +247,7 @@ process_reply(FD_SET_TYPE *rfds)
>>>>            xlog_warn("%s: service %d not registered on localhost",
>>>>                __func__, NL_MY_PROG(lp));
>>>>        } else {
>>>> -        xlog(D_GENERAL, "%s: Callback to %s (for %d) succeeded",
>>>> +        xlog(D_GENERAL, "%s: Callback to %s (for %s) succeeded",
>>>>                __func__, NL_MY_NAME(lp), NL_MON_NAME(lp));
>>>>        }
>>>>        nlist_free(&notify, lp);
>>>> diff --git a/utils/statd/statd.c b/utils/statd/statd.c
>>>> index 14673800..8eef2ff2 100644
>>>> --- a/utils/statd/statd.c
>>>> +++ b/utils/statd/statd.c
>>>> @@ -136,7 +136,7 @@ static void log_modes(void)
>>>>        strcat(buf, "TI-RPC ");
>>>>    #endif
>>>>    -    xlog_warn(buf);
>>>> +    xlog_warn("%s", buf);
>>>>    }
>>>>      /*
>>>> diff --git a/utils/statd/svc_run.c b/utils/statd/svc_run.c
>>>> index d1dbd74a..e343c768 100644
>>>> --- a/utils/statd/svc_run.c
>>>> +++ b/utils/statd/svc_run.c
>>>> @@ -53,6 +53,7 @@
>>>>      #include <errno.h>
>>>>    #include <time.h>
>>>> +#include <inttypes.h>
>>>>    #include "statd.h"
>>>>    #include "notlist.h"
>>>>    @@ -104,8 +105,8 @@ my_svc_run(int sockfd)
>>>>                  tv.tv_sec  = NL_WHEN(notify) - now;
>>>>                tv.tv_usec = 0;
>>>> -            xlog(D_GENERAL, "Waiting for reply... (timeo %d)",
>>>> -                            tv.tv_sec);
>>>> +            xlog(D_GENERAL, "Waiting for reply... (timeo %jd)",
>>>> +                            (intmax_t)tv.tv_sec);
>>>>                selret = select(FD_SETSIZE, &readfds,
>>>>                    (void *) 0, (void *) 0, &tv);
>>>>            } else {
