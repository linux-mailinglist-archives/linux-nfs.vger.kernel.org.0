Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03D9191D3E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCXXH0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:07:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgCXXHZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:07:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42D77AD48;
        Tue, 24 Mar 2020 23:07:23 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yihao Wu <wuyihao@linux.alibaba.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 25 Mar 2020 10:07:14 +1100
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
In-Reply-To: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
Message-ID: <87369x8i8t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24 2020, Yihao Wu wrote:

> cache_purge should hold cache_list_lock as cache_clean does. Otherwise a =
cache
> can be cache_put twice, which leads to a use-after-free bug.
>
> To reproduce, run ltp. It happens rarely.  /opt/ltp/runltp run -f net.nfs
>
> [14454.137661] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14454.138863] BUG: KASAN: use-after-free in cache_purge+0xce/0x160 [sunr=
pc]
> [14454.139822] Read of size 4 at addr ffff8883d484d560 by task nfsd/31993
> [14454.140746]
> [14454.140995] CPU: 1 PID: 31993 Comm: nfsd Kdump: loaded Not tainted 4.1=
9.91-0.229.git.87bac30.al7.x86_64.debug #1
> [14454.141002] Call Trace:
> [14454.141014] =C2=A0dump_stack+0xaf/0xfb[14454.141027] =C2=A0print_addre=
ss_description+0x6a/0x2a0
> [14454.141037] =C2=A0kasan_report+0x166/0x2b0[14454.141057] =C2=A0? cache=
_purge+0xce/0x160 [sunrpc]
> [14454.141079] =C2=A0cache_purge+0xce/0x160 [sunrpc]
> [14454.141099] =C2=A0nfsd_last_thread+0x267/0x270 [nfsd][14454.141109] =
=C2=A0? nfsd_last_thread+0x5/0x270 [nfsd]
> [14454.141130] =C2=A0nfsd_destroy+0xcb/0x180 [nfsd]
> [14454.141140] =C2=A0? nfsd_destroy+0x5/0x180 [nfsd]
> [14454.141153] =C2=A0nfsd+0x1e4/0x2b0 [nfsd]
> [14454.141163] =C2=A0? nfsd+0x5/0x2b0 [nfsd]
> [14454.141173] =C2=A0kthread+0x114/0x150
> [14454.141183] =C2=A0? nfsd_destroy+0x180/0x180 [nfsd]
> [14454.141187] =C2=A0? kthread_park+0xb0/0xb0
> [14454.141197] =C2=A0ret_from_fork+0x3a/0x50
> [14454.141224]
> [14454.141475] Allocated by task 20918:
> [14454.142011] =C2=A0kmem_cache_alloc_trace+0x9f/0x2e0
> [14454.142027] =C2=A0sunrpc_cache_lookup+0xca/0x2f0 [sunrpc]
> [14454.142037] =C2=A0svc_export_parse+0x1e7/0x930 [nfsd]
> [14454.142051] =C2=A0cache_do_downcall+0x5a/0x80 [sunrpc]
> [14454.142064] =C2=A0cache_downcall+0x78/0x180 [sunrpc]
> [14454.142078] =C2=A0cache_write_procfs+0x57/0x80 [sunrpc]
> [14454.142083] =C2=A0proc_reg_write+0x90/0xd0
> [14454.142088] =C2=A0vfs_write+0xc2/0x1c0
> [14454.142092] =C2=A0ksys_write+0x4d/0xd0
> [14454.142098] =C2=A0do_syscall_64+0x60/0x250
> [14454.142103] =C2=A0entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [14454.142106]
> [14454.142344] Freed by task 19165:
> [14454.142804] =C2=A0kfree+0x114/0x300
> [14454.142819] =C2=A0cache_clean+0x2a4/0x2e0 [sunrpc]
> [14454.142833] =C2=A0cache_flush+0x24/0x60 [sunrpc]
> [14454.142845] =C2=A0write_flush.isra.19+0xbe/0x100 [sunrpc]
> [14454.142849] =C2=A0proc_reg_write+0x90/0xd0
> [14454.142853] =C2=A0vfs_write+0xc2/0x1c0
> [14454.142856] =C2=A0ksys_write+0x4d/0xd0
> [14454.142860] =C2=A0do_syscall_64+0x60/0x250
> [14454.142865] =C2=A0entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [14454.142867]
> [14454.143095] The buggy address belongs to the object at ffff8883d484d54=
0 which belongs to the cache kmalloc-256 of size 256
> [14454.144842] The buggy address is located 32 bytes inside of =C2=A0256-=
byte region [ffff8883d484d540, ffff8883d484d640)
> [14454.146463] The buggy address belongs to the page:
> [14454.147155] page:ffffea000f521300 count:1 mapcount:0 mapping:ffff88810=
7c02e00 index:0xffff8883d484da40 compound_map count: 0
> [14454.148712] flags: 0x17fffc00010200(slab|head)
> [14454.149356] raw: 0017fffc00010200 ffffea000f4baf00 0000000200000002 ff=
ff888107c02e00
> [14454.150453] raw: ffff8883d484da40 0000000080190001 00000001ffffffff 00=
00000000000000
> [14454.151557] page dumped because: kasan: bad access detected
> [14454.152364]
> [14454.152606] Memory state around the buggy address:
> [14454.153300] =C2=A0ffff8883d484d400: fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb
> [14454.154319] =C2=A0ffff8883d484d480: fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb
> [14454.155324] >ffff8883d484d500: fc fc fc fc fc fc fc fc fb fb fb fb fb =
fb fb fb
> [14454.156334] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
> [14454.157237] =C2=A0ffff8883d484d580: fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb
> [14454.158262] =C2=A0ffff8883d484d600: fb fb fb fb fb fb fb fb fc fc fc f=
c fc fc fc fc
> [14454.159282] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14454.160224] Disabling lock debugging due to kernel taint
>
> Fixes: 471a930ad7d1(SUNRPC: Drop all entries from cache_detail when cache=
_purge())
> Cc: stable@vger.kernel.org #v4.11+
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>  net/sunrpc/cache.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index bd843a81afa0..3e523eefc47f 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -524,9 +524,11 @@ void cache_purge(struct cache_detail *detail)
>  	struct hlist_node *tmp =3D NULL;
>  	int i =3D 0;
>=20=20
> +	spin_lock(&cache_list_lock);
>  	spin_lock(&detail->hash_lock);
>  	if (!detail->entries) {
>  		spin_unlock(&detail->hash_lock);
> +		spin_unlock(&cache_list_lock);
>  		return;
>  	}
>=20=20
> @@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
>  		}
>  	}
>  	spin_unlock(&detail->hash_lock);
> +	spin_unlock(&cache_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(cache_purge);
>=20=20
> --=20
> 2.20.1.2432.ga663e714

I wonder if this is the best solution.
This code:

		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
			sunrpc_begin_cache_remove_entry(ch, detail);
			spin_unlock(&detail->hash_lock);
			sunrpc_end_cache_remove_entry(ch, detail);
			spin_lock(&detail->hash_lock);
		}

Looks wrong.
Dropping a lock while walking a list if only safe if you hold a
reference to the place-holder - 'tmp' in this case.  but we don't.
As this is trying to remove everything in the list it would be safer to
do something like

 while (!hlist_empty(head)) {
 	ch =3D hlist_entry(head->first, struct cache_head, h);
	sunrpc_begin_cache_remove_entry(ch, detail);
	spin_unlock(&detail->hash_lock);
	sunrpc_end_cache_remove_entry(ch, detail);
	spin_lock(&detail->hash_lock);
 }

I'm guessing that would fix the problem in a more focused.
But I'm not 100% sure because there is no analysis given of the cause.
What line is
  cache_purge+0xce/0x160
./scripts/faddr2line can tell you.
I suspect it is the hlist_for_each_entry_safe() line.

Can you test the change I suggest and see if it helps?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl56kqMACgkQOeye3VZi
gbnmSg/+I9dkp/1NVaF72s7lhT++FHxtNJuQgA8N03mFoHoDN43W/KeLxsmwDH1R
bgFBki6nKSRIrIVXY15fv2HtC8ThReWTnCBviQJnZp5qFFJNZwyC3HW0gKzVJ2Lg
cqNxy/ReuOH+zLOwXCXJiQMr4axEB7cwvwovzWhJZ85s4PiWr+v1x2v4ZX2vq0h3
1FXTbLAwoXOjms0pii9kH/+GKk8P4SYWsDh2fnsC0WTYZoaktQZhOzD2OR7iRVgS
KLPwlMKxRxarIzFFPn8sJqFbemBNl3aAWbLaqQSnjLneZLFLbE7r8MxZIHZFkFSO
jPLmI9cvL3ggV0hhWl0O7biRjh4FIyCyUsLNyz/KkXYbeKIfrqhZRJ6gKttwnb2t
d2V7ktN06a3eOG6q45k3UUxA6p5ZPCy1h9m82cX1kwWpX3RqMEF2t55gkrLRMxQJ
qda7NVIezkraRK1pFtQqVrRTm3bmPuDEvI0opVT0uu+Olc/zclR4D85h1UdfN5VY
tdwb83g8Z+ePtDJ2r7E71znxTavpRYzQ7oSXa+dGzFFDdpciJt9UuBD8DtTR2rqN
txLXJ3LRe3vRzJuD4/PKBTiVpnUzRq9ao0BZ/LGsQczvquDC+mOO7bOdbAKzYsib
C69RrW3Z5LNp/xaCNwjfeuFI6yMi2UysCaKrngiOeB2oQv7r1qU=
=kZp0
-----END PGP SIGNATURE-----
--=-=-=--
