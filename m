Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16542CDAC9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgLCQFd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 11:05:33 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:36251 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbgLCQFd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 11:05:33 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id ED87B160E7A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 17:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de ED87B160E7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607011488; bh=ci5J1s/yhRP/2GjDdGOThG+l7jewgprdfL0HDhP/qF0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=er0TkvMaq7U3xrZ78E5qcF9NGvz8LZJJ30mAeNtFLDR8YbbqZM93VCVQwJsnB2bj7
         eIpyN93QqnV/ige+OFrYS6lyWzSPA7uQQ6KHJZ0xWWSBRCvKfTMP6gY1ymHM/64drI
         T4IA22DMZhMopeCzxcmOZj7OOyx2Ec46cDhyhpsw=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id E6ECC1A0088;
        Thu,  3 Dec 2020 17:04:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id BB2F480067;
        Thu,  3 Dec 2020 17:04:47 +0100 (CET)
Date:   Thu, 3 Dec 2020 17:04:47 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Message-ID: <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
In-Reply-To: <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de> <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
Subject: Re: Kernel OPS when using xattr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Kernel OPS when using xattr
Thread-Index: Gy/PzTaHdY6Ui5eV5iBg9axQHgH8es3zcbcAgCc3dgs=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Trond,

unfortunately the same result. Here the output of gdb, if it helps.

(gdb) list *0x00000000000252be
0x252be is in _shift_data_right_pages (net/sunrpc/xdr.c:344).
339=09=09=09if (*pgto !=3D *pgfrom) {
340=09=09=09=09vfrom =3D kmap_atomic(*pgfrom);
341=09=09=09=09memcpy(vto + pgto_base, vfrom + pgfrom_base, copy);
342=09=09=09=09kunmap_atomic(vfrom);
343=09=09=09} else
344=09=09=09=09memmove(vto + pgto_base, vto + pgfrom_base, copy);
345=09=09=09flush_dcache_page(*pgto);
346=09=09=09kunmap_atomic(vto);
347
348=09=09} while ((len -=3D copy) !=3D 0);
(gdb)


Tigran.


----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "linux-nfs" <linux-nfs=
@vger.kernel.org>
> Cc: "Frank van der Linden" <fllinden@amazon.com>
> Sent: Thursday, 3 December, 2020 16:07:53
> Subject: Re: Kernel OPS when using xattr

> Hi Tigran,
>=20
> On Thu, 2020-12-03 at 09:20 +0100, Mkrtchyan, Tigran wrote:
>>=20
>> Dear NFS folk,
>>=20
>> this is I got while accessing xattrs over NFS with 5.10.0-rc6 kernel
>> from Trond's testing tree (8102e956f22e710eecb3913cdd236282213812cf).
>> The 5.9 kernel works as expected.
>>=20
>> Tigran.
>>=20
>> [ 2803.765467] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
>> Registering...
>> [59837.811426] general protection fault, probably for non-canonical
>> address 0x5088000000ffc: 0000 [#1] SMP PTI
>> [59837.811433] CPU: 3 PID: 3858 Comm: attr Not tainted 5.10.0-rc6+
>> #60
>> [59837.811435] Hardware name: Dell Inc. Latitude E6520/0J4TFW, BIOS
>> A06 07/11/2011
>> [59837.811442] RIP: 0010:__memmove+0xe2/0x1a0
>> [59837.811445] Code: 1f 84 00 00 00 00 00 90 48 83 fa 20 72 50 48 81
>> fa a8 02 00 00 72 05 40 38 fe 74 bc 48 01 d6 48 01 d7 48 83 ea 20 48
>> 83 ea 20 <4c> 8b 5e f8 4c 8b 56 f0 4c 8b 4e e8 4c 8b 46 e0 48 8d 76
>> e0 4c 89
>> [59837.811447] RSP: 0018:ffffc90002b4f870 EFLAGS: 00010202
>> [59837.811451] RAX: 0005088000000004 RBX: 0000000000000000 RCX:
>> 000000000000fffc
>> [59837.811453] RDX: 0000000000000fbc RSI: 0005088000000ffc RDI:
>> 0005088000001000
>> [59837.811455] RBP: ffff88810be80000 R08: 0005088000000ffc R09:
>> ffff888235aec550
>> [59837.811457] R10: 0000000000000356 R11: 000000000000016c R12:
>> 0000000000000004
>> [59837.811459] R13: 000000000000fffc R14: ffff88810be80000 R15:
>> ffffc90002b4fc58
>> [59837.811462] FS:=C2=A0 00007fd9303ff740(0000) GS:ffff888235ac0000(0000=
)
>> knlGS:0000000000000000
>> [59837.811465] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [59837.811467] CR2: 00007fd9305d2000 CR3: 000000011fc10005 CR4:
>> 00000000000606e0
>> [59837.811469] Call Trace:
>> [59837.811505]=C2=A0 _shift_data_right_pages+0x11e/0x150 [sunrpc]
>> [59837.811531]=C2=A0 xdr_shrink_bufhead+0x151/0x170 [sunrpc]
>> [59837.811555]=C2=A0 xdr_realign_pages+0x4c/0xa0 [sunrpc]
>> [59837.811578]=C2=A0 xdr_align_pages+0x49/0x120 [sunrpc]
>> [59837.811601]=C2=A0 xdr_read_pages+0x23/0xb0 [sunrpc]
>> [59837.811626]=C2=A0 nfs4_xdr_dec_getxattr+0xfa/0x120 [nfsv4]
>> [59837.811643]=C2=A0 call_decode+0x199/0x1f0 [sunrpc]
>> [59837.811659]=C2=A0 ? rpc_decode_header+0x4e0/0x4e0 [sunrpc]
>> [59837.811678]=C2=A0 __rpc_execute+0x71/0x420 [sunrpc]
>> [59837.811700]=C2=A0 ? xprt_iter_default_rewind+0x10/0x10 [sunrpc]
>> [59837.811721]=C2=A0 ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
>> [59837.811737]=C2=A0 rpc_run_task+0x14c/0x180 [sunrpc]
>> [59837.811756]=C2=A0 nfs4_do_call_sync+0x6e/0xb0 [nfsv4]
>> [59837.811785]=C2=A0 _nfs42_proc_getxattr+0xb7/0x170 [nfsv4]
>> [59837.811809]=C2=A0 ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
>> [59837.811830]=C2=A0 nfs42_proc_getxattr+0x86/0xb0 [nfsv4]
>> [59837.811844]=C2=A0 nfs4_xattr_get_nfs4_user+0xc9/0xe0 [nfsv4]
>> [59837.811849]=C2=A0 vfs_getxattr+0x161/0x1a0
>> [59837.811852]=C2=A0 getxattr+0x14f/0x230
>> [59837.811856]=C2=A0 ? filename_lookup+0x123/0x1b0
>> [59837.811861]=C2=A0 ? _cond_resched+0x16/0x40
>> [59837.811864]=C2=A0 ? kmem_cache_alloc+0x3c4/0x4b0
>> [59837.811866]=C2=A0 ? getname_flags.part.0+0x45/0x1a0
>> [59837.811869]=C2=A0 path_getxattr+0x62/0xb0
>> [59837.811873]=C2=A0 do_syscall_64+0x33/0x40
>> [59837.811876]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [59837.811879] RIP: 0033:0x7fd93050162e
>> [59837.811883] Code: 48 8b 0d 4d 48 0c 00 f7 d8 64 89 01 48 83 c8 ff
>> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 c0 00 00
>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 48 0c 00 f7 d8 64
>> 89 01 48
>> [59837.811884] RSP: 002b:00007ffe178ad1c8 EFLAGS: 00000202 ORIG_RAX:
>> 00000000000000c0
>> [59837.811887] RAX: ffffffffffffffda RBX: 00007ffe178ad330 RCX:
>> 00007fd93050162e
>> [59837.811889] RDX: 0000000000000000 RSI: 00007ffe178ad330 RDI:
>> 00007ffe178bf525
>> [59837.811890] RBP: 0000000000000000 R08: 00007ffe178ad210 R09:
>> 0000000000000000
>> [59837.811892] R10: 0000000000000000 R11: 0000000000000202 R12:
>> 0000000000000001
>> [59837.811894] R13: 00007ffe178ad210 R14: 00007ffe178bf525 R15:
>> 0000000000000000
>> [59837.811896] Modules linked in: nfs_layout_flexfiles
>> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
>> nfs_ssc fscache nf_conntrack_netbios_ns nf_conntrack_broadcast nft_ct
>> nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
>> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
>> iptable_security ip_set nfnetlink ebtable_filter ebtables
>> ip6table_filter ip6_tables sunrpc snd_hda_codec_idt
>> snd_hda_codec_generic ledtrig_audio nouveau i915 iwldvm mac80211
>> btrfs snd_hda_codec_hdmi snd_hda_intel snd_intel_ds
>=20
> Does this fix it?
>=20
> 8<---------------------------------------------
> From 013ee77c43a4dcd468becaf2f234624433cc6fb2 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Thu, 3 Dec 2020 09:16:15 -0500
> Subject: [PATCH] SUNRPC: xs_alloc_sparse_pages() should set buf-
>>page_len
>=20
> If the page buffer allocated in xs_alloc_sparse_pages() ends up being
> shorter than the predicted buf->page_len, then we should truncate the
> latter so that later calls to xdr_read_pages() doesn't get confused and
> trigger an Oops.
>=20
> Reported-by: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/xprtsock.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c93ff70da3f9..32054176786e 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -327,21 +327,28 @@ static void xs_free_peer_addresses(struct
> rpc_xprt *xprt)
> static size_t
> xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
> {
> -=09size_t i,n;
> +=09size_t i,n, len;
>=20
> -=09if (!want || !(buf->flags & XDRBUF_SPARSE_PAGES))
> +=09if (!(buf->flags & XDRBUF_SPARSE_PAGES))
> =09=09return want;
> =09n =3D (buf->page_base + want + PAGE_SIZE - 1) >> PAGE_SHIFT;
> =09for (i =3D 0; i < n; i++) {
> =09=09if (buf->pages[i])
> =09=09=09continue;
> =09=09buf->bvec[i].bv_page =3D buf->pages[i] =3D
> alloc_page(gfp);
> -=09=09if (!buf->pages[i]) {
> -=09=09=09i *=3D PAGE_SIZE;
> -=09=09=09return i > buf->page_base ? i - buf->page_base
> : 0;
> -=09=09}
> +=09=09if (!buf->pages[i])
> +=09=09=09break;
> +=09}
> +=09len =3D i << PAGE_SHIFT;
> +=09if (len > buf->page_base)
> +=09=09len -=3D buf->page_base;
> +=09else
> +=09=09len =3D 0;
> +=09if (buf->page_len > len) {
> +=09=09buf->buflen -=3D buf->page_len - len;
> +=09=09buf->page_len =3D len;
> =09}
> -=09return want;
> +=09return want <=3D len ? want : len;
> }
>=20
> static ssize_t
> --
> 2.28.0
>=20
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
