Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07349AC99
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 07:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359114AbiAYGrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 01:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358307AbiAYGo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 01:44:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C029C06C58B;
        Mon, 24 Jan 2022 21:05:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjZY004ysz4xNm;
        Tue, 25 Jan 2022 16:05:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643087108;
        bh=VnzwZkaUPBG6gyiFlcuKqba/xwt8hpq+mXdI1zWxHQA=;
        h=Date:From:To:Cc:Subject:From;
        b=kxbwOGLYYNH0vo+x/IahWwMZ8ZlXiMBHd8K9EidBdUAsS5DAfRam26dCB7B7Q9Zn9
         9D5+vVcC7sHDTjCwVe3tCDJcX+gSHJm5Mevfynu6+W+1EwTL826GNCCS/y5vIm9Umn
         2QH9lfLFsw+7YwgsB8eyYtwtSjEZZs/NIt51layKX7uc0ZR9Gkpr8WiWs3tyaCWtlM
         ijYfOwocg/tSBLo35sGLGxxWlwYH2bN/Tcljo2ba3IS9IN7W0+AWEvFoPT/DCKY+1I
         NEfmQeWomo8QIMALbRqoeMUT87jIjC5lAh5x90J9StxeF/Y+q76W7C4gwpJQFbD4mf
         QmKIzXeeb88kw==
Date:   Tue, 25 Jan 2022 16:05:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: linux-next: runtime warning in next-20220125
Message-ID: <20220125160505.068dbb52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VaGFByGqpnPxdhPTqS7TR2I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/VaGFByGqpnPxdhPTqS7TR2I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My qemu boot test of a powerpc pseries_le_defconfig kernel produces the
following trace:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 trace_event_raw_i=
nit+0x194/0x730
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1 #2
NIP:  c0000000002bdbb4 LR: c0000000002bdcb0 CTR: c0000000002bdb70
REGS: c00000000278ba10 TRAP: 0700   Not tainted  (5.17.0-rc1)
MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000282  XER: 20000000
CFAR: c0000000002bdb38 IRQMASK: 1=20
GPR00: c0000000002bdc98 c00000000278bcb0 c00000000278d300 0000000000000000=
=20
GPR04: 000000000000002c 0000000000000005 000000000000023f c0000000002bdb3c=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: c0000000002bda20 c000000002960000 0000000000000000 0000000000000000=
=20
GPR16: 0000000002bf00d0 000000007e68ebc8 ffffffffffffffff 000508b58019388f=
=20
GPR20: 0000000000000001 c000000000faf800 0000000000000005 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000003 0000000000000000 0000000000000000=
=20
GPR28: c0000000026fefc0 c0000000026f8050 0000000000000251 c0000000026f82a1=
=20
NIP [c0000000002bdbb4] trace_event_raw_init+0x194/0x730
LR [c0000000002bdcb0] trace_event_raw_init+0x290/0x730
Call Trace:
[c00000000278bcb0] [c0000000002bdc98] trace_event_raw_init+0x278/0x730 (unr=
eliable)
[c00000000278bda0] [c0000000002badb8] event_init+0x68/0xf0
[c00000000278be10] [c000000002033990] trace_event_init+0xc8/0x334
[c00000000278beb0] [c000000002033004] trace_init+0x18/0x2c
[c00000000278bed0] [c0000000020042e0] start_kernel+0x590/0x8cc
[c00000000278bf90] [c00000000000d19c] start_here_common+0x1c/0x600
Instruction dump:
41800438 60000000 60420000 3bde0001 7fdf07b4 7ffdfa14 891f0000 710a00ff=20
4082ff5c 2c390000 38600000 41820320 <0fe00000> f9c10060 f9e10068 fa010070=20
---[ end trace 0000000000000000 ]---
event svc_xprt_accept has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s protocol=3D%s servic=
e=3D%s", __get_sockaddr(server), __get_sockaddr(client), __print_flags(REC-=
>flags, "|", { (1UL << 0), "XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL <=
< 2), "XPT_CLOSE"}, { (1UL << 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, {=
 (1UL << 6), "XPT_DEAD"}, { (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_=
DEFERRED"}, { (1UL << 9), "XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1U=
L << 11), "XPT_CACHE_AUTH"}, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "X=
PT_KILL_TEMP"}, { (1UL << 14), "XPT_CONG_CTRL"}), __get_str(protocol), __ge=
t_str(service)
event svc_xprt_free has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s", __get_sockaddr(ser=
ver), __get_sockaddr(client), __print_flags(REC->flags, "|", { (1UL << 0), =
"XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_CLOSE"}, { (1UL =
<< 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6), "XPT_DEAD"}, {=
 (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"}, { (1UL << 9), "=
XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "XPT_CACHE_AUTH"}=
, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEMP"}, { (1UL << 1=
4), "XPT_CONG_CTRL"})
event svc_xprt_detach has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s", __get_sockaddr(ser=
ver), __get_sockaddr(client), __print_flags(REC->flags, "|", { (1UL << 0), =
"XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_CLOSE"}, { (1UL =
<< 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6), "XPT_DEAD"}, {=
 (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"}, { (1UL << 9), "=
XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "XPT_CACHE_AUTH"}=
, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEMP"}, { (1UL << 1=
4), "XPT_CONG_CTRL"})
event svc_xprt_close has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s", __get_sockaddr(ser=
ver), __get_sockaddr(client), __print_flags(REC->flags, "|", { (1UL << 0), =
"XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_CLOSE"}, { (1UL =
<< 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6), "XPT_DEAD"}, {=
 (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"}, { (1UL << 9), "=
XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "XPT_CACHE_AUTH"}=
, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEMP"}, { (1UL << 1=
4), "XPT_CONG_CTRL"})
event svc_xprt_no_write_space has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s", __get_sockaddr(ser=
ver), __get_sockaddr(client), __print_flags(REC->flags, "|", { (1UL << 0), =
"XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_CLOSE"}, { (1UL =
<< 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6), "XPT_DEAD"}, {=
 (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"}, { (1UL << 9), "=
XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "XPT_CACHE_AUTH"}=
, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEMP"}, { (1UL << 1=
4), "XPT_CONG_CTRL"})
event svc_xprt_dequeue has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s wakeup-us=3D%lu", __=
get_sockaddr(server), __get_sockaddr(client), __print_flags(REC->flags, "|"=
, { (1UL << 0), "XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_=
CLOSE"}, { (1UL << 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6)=
, "XPT_DEAD"}, { (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"},=
 { (1UL << 9), "XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "=
XPT_CACHE_AUTH"}, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEM=
P"}, { (1UL << 14), "XPT_CONG_CTRL"}), REC->wakeup
event svc_xprt_enqueue has unsafe dereference of argument 1
print_fmt: "server=3D%pISpc client=3D%pISpc flags=3D%s pid=3D%d", __get_soc=
kaddr(server), __get_sockaddr(client), __print_flags(REC->flags, "|", { (1U=
L << 0), "XPT_BUSY"}, { (1UL << 1), "XPT_CONN"}, { (1UL << 2), "XPT_CLOSE"}=
, { (1UL << 3), "XPT_DATA"}, { (1UL << 4), "XPT_TEMP"}, { (1UL << 6), "XPT_=
DEAD"}, { (1UL << 7), "XPT_CHNGBUF"}, { (1UL << 8), "XPT_DEFERRED"}, { (1UL=
 << 9), "XPT_OLD"}, { (1UL << 10), "XPT_LISTENER"}, { (1UL << 11), "XPT_CAC=
HE_AUTH"}, { (1UL << 12), "XPT_LOCAL"}, { (1UL << 13), "XPT_KILL_TEMP"}, { =
(1UL << 14), "XPT_CONG_CTRL"}), REC->pid
event svc_xprt_create_err has unsafe dereference of argument 1
print_fmt: "addr=3D%pISpc program=3D%s protocol=3D%s error=3D%ld", __get_so=
ckaddr(addr), __get_str(program), __get_str(protocol), REC->error
event svc_stats_latency has unsafe dereference of argument 2
print_fmt: "xid=3D0x%08x server=3D%pISpc client=3D%pISpc proc=3D%s execute-=
us=3D%lu", REC->xid, __get_sockaddr(server), __get_sockaddr(client), __get_=
str(procedure), REC->execute
event svc_send has unsafe dereference of argument 2
print_fmt: "xid=3D0x%08x server=3D%pISpc client=3D%pISpc status=3D%d flags=
=3D%s", REC->xid, __get_sockaddr(server), __get_sockaddr(client), REC->stat=
us, __print_flags(REC->flags, "|", { ((((1UL))) << ((0))), "SECURE" }, { ((=
((1UL))) << ((1))), "LOCAL" }, { ((((1UL))) << ((2))), "USEDEFERRAL" }, { (=
(((1UL))) << ((3))), "DROPME" }, { ((((1UL))) << ((4))), "SPLICE_OK" }, { (=
(((1UL))) << ((5))), "VICTIM" }, { ((((1UL))) << ((6))), "BUSY" }, { ((((1U=
L))) << ((7))), "DATA" })
event svc_drop has unsafe dereference of argument 2
print_fmt: "xid=3D0x%08x server=3D%pISpc client=3D%pISpc flags=3D%s", REC->=
xid, __get_sockaddr(server), __get_sockaddr(client), __print_flags(REC->fla=
gs, "|", { ((((1UL))) << ((0))), "SECURE" }, { ((((1UL))) << ((1))), "LOCAL=
" }, { ((((1UL))) << ((2))), "USEDEFERRAL" }, { ((((1UL))) << ((3))), "DROP=
ME" }, { ((((1UL))) << ((4))), "SPLICE_OK" }, { ((((1UL))) << ((5))), "VICT=
IM" }, { ((((1UL))) << ((6))), "BUSY" }, { ((((1UL))) << ((7))), "DATA" })
event svc_defer has unsafe dereference of argument 2
print_fmt: "xid=3D0x%08x server=3D%pISpc client=3D%pISpc flags=3D%s", REC->=
xid, __get_sockaddr(server), __get_sockaddr(client), __print_flags(REC->fla=
gs, "|", { ((((1UL))) << ((0))), "SECURE" }, { ((((1UL))) << ((1))), "LOCAL=
" }, { ((((1UL))) << ((2))), "USEDEFERRAL" }, { ((((1UL))) << ((3))), "DROP=
ME" }, { ((((1UL))) << ((4))), "SPLICE_OK" }, { ((((1UL))) << ((5))), "VICT=
IM" }, { ((((1UL))) << ((6))), "BUSY" }, { ((((1UL))) << ((7))), "DATA" })
event svc_authenticate has unsafe dereference of argument 2
print_fmt: "xid=3D0x%08x server=3D%pISpc client=3D%pISpc auth_res=3D%s auth=
_stat=3D%s", REC->xid, __get_sockaddr(server), __get_sockaddr(client), __pr=
int_symbolic(REC->svc_status, { 1, "SVC_GARBAGE" }, { 2, "SVC_SYSERR" }, { =
3, "SVC_VALID" }, { 4, "SVC_NEGATIVE" }, { 5, "SVC_OK" }, { 6, "SVC_DROP" }=
, { 7, "SVC_CLOSE" }, { 8, "SVC_DENIED" }, { 9, "SVC_PENDING" }, { 10, "SVC=
_COMPLETE" }), __print_symbolic(REC->auth_stat, { RPC_AUTH_OK, "AUTH_OK" },=
 { RPC_AUTH_BADCRED, "BADCRED" }, { RPC_AUTH_REJECTEDCRED, "REJECTEDCRED" }=
, { RPC_AUTH_BADVERF, "BADVERF" }, { RPC_AUTH_REJECTEDVERF, "REJECTEDVERF" =
}, { RPC_AUTH_TOOWEAK, "TOOWEAK" }, { RPCSEC_GSS_CREDPROBLEM, "GSS_CREDPROB=
LEM" }, { RPCSEC_GSS_CTXPROBLEM, "GSS_CTXPROBLEM" })

I have no idea what has caused this :-(  Maybe commit

  5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid")

--=20
Cheers,
Stephen Rothwell

--Sig_/VaGFByGqpnPxdhPTqS7TR2I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvhQEACgkQAVBC80lX
0Gy5zggAksZUJe8bw1ZWViHZU8wORBk4j2FkykU1/33nMLlMVw0QPRo3jEAtQjmx
3zNAWerulXOj+7culael0z2n2Jql5WfL6Rh1naE02FWcKs40+YpeZoRDplL9hh/j
6vepOv0eRXMr5SRsS5qxv4ABkrnPtD9AUKvHoNelG2v56chNwRBxXpM+ShQxwaMs
0PFj34CVD9grBHPd5bc2cDs9yERplgegAMMx0ED/ddY+9vHXsPC33ljJGTvaoKhq
0VI7PsOBVGNChpFblVplx9xmgNlLaZi2GkezJWdsPrID4HnLcM6bA7FC9PnUbpfk
RzEe8pg/XwCtOkp3F4oQtLIhE8YYBQ==
=izeq
-----END PGP SIGNATURE-----

--Sig_/VaGFByGqpnPxdhPTqS7TR2I--
