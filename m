Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6042CDCB5
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLCRuk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 12:50:40 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:47887 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgLCRuh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 12:50:37 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 3AA7F160E60
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 18:49:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3AA7F160E60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607017794; bh=QDVusK7K/RQtkuu8PAyoynuAQ9maLpWdrw8vjbT1wFI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DinqD6CLXNoiM6yVzFS5cmVQ2CizlLkoWHWqS/KXeYafkYO6ghzJBEopYOiBHTFx3
         4Z/JkGNlGuC00eru/dnx1jxFbeyQoXczhKW9c8g4ZqjDqfbxTz0Eys0phNElt99DXb
         YE0F1dlKnNVnJ2XU+cchryDyXbPqMiQBzml1gpkk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 3591E1A0088;
        Thu,  3 Dec 2020 18:49:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 0C4B41001A7;
        Thu,  3 Dec 2020 18:49:54 +0100 (CET)
Date:   Thu, 3 Dec 2020 18:49:53 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1434840459.2070500.1607017793934.JavaMail.zimbra@desy.de>
In-Reply-To: <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de> <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com> <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de> <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
Subject: Re: Kernel OPS when using xattr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Kernel OPS when using xattr
Thread-Index: Gy/PzTaHdY6Ui5eV5iBg9axQHgH8es3zcbcAgCc3dgv/2OuegJb+zXwK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I can list and read attributes, but still get
stack traces (and getdeviceinfo still broken)


[  111.887664] ------------[ cut here ]------------
[  111.887696] WARNING: CPU: 4 PID: 1313 at net/sunrpc/clnt.c:2478 call_dec=
ode+0x1a1/0x1f0 [sunrpc]
[  111.887697] Modules linked in: nfs_layout_flexfiles rpcsec_gss_krb5 auth=
_rpcgss nfsv4(E) dns_resolver nfs(E) lockd grace nfs_ssc fscache nf_conntra=
ck_netbios_ns nf_conntrack_broadcast nft_ct nf_tables ebtable_nat ebtable_b=
route ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_n=
at nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable=
_raw iptable_security ip_set nfnetlink ebtable_filter ebtables ip6table_fil=
ter ip6_tables sunrpc(E) snd_hda_codec_idt snd_hda_codec_generic ledtrig_au=
dio nouveau i915 iwldvm mac80211 btrfs intel_rapl_msr snd_hda_codec_hdmi in=
tel_rapl_common snd_hda_intel x86_pkg_temp_thermal uvcvideo snd_intel_dspcf=
g libarc4 snd_hda_codec coretemp kvm_intel videobuf2_vmalloc iwlwifi snd_hd=
a_core videobuf2_memops videobuf2_v4l2 snd_hwdep snd_seq blake2b_generic vi=
deobuf2_common kvm at24 iTCO_wdt xor snd_seq_device videodev regmap_i2c dcd=
bas zstd_decompress ppdev iTCO_vendor_support wmi_bmof mxm_wmi snd_pcm cfg8=
0211 dell_smm_hwmon ttm
[  111.887754]  zstd_compress i2c_algo_bit e1000e mc irqbypass snd_timer me=
i_me drm_kms_helper snd raid6_pq pcspkr i2c_i801 joydev ptp lpc_ich rfkill =
i2c_smbus mei soundcore pps_core mfd_core wmi parport_pc parport video dell=
_smo8800 drm sdhci_pci crct10dif_pclmul cqhci crc32_pclmul crc32c_intel sdh=
ci ghash_clmulni_intel mmc_core firewire_ohci serio_raw firewire_core crc_i=
tu_t fuse
[  111.887785] CPU: 4 PID: 1313 Comm: attr Tainted: G            E     5.10=
.0-rc6+ #60
[  111.887787] Hardware name: Dell Inc. Latitude E6520/0J4TFW, BIOS A06 07/=
11/2011
[  111.887803] RIP: 0010:call_decode+0x1a1/0x1f0 [sunrpc]
[  111.887805] Code: df 02 00 0f b7 85 dc 00 00 00 e9 cc fe ff ff 48 c7 45 =
20 90 d5 da a0 48 89 e6 48 89 ef e8 17 8c 01 00 89 45 04 e9 ed fe ff ff <0f=
> 0b e9 3d ff ff ff 65 8b 05 e1 5f 27 5f 89 c0 48 0f a3 05 87 09
[  111.887807] RSP: 0018:ffffc9000171b9f0 EFLAGS: 00010286
[  111.887809] RAX: 00000000fffffff0 RBX: ffff888103f11200 RCX: 00000000000=
00010
[  111.887810] RDX: 00000000fffffff0 RSI: 0000000000000048 RDI: ffff888103f=
11250
[  111.887811] RBP: ffff888101435500 R08: ffff888103f11330 R09: ffff888235b=
2c550
[  111.887812] R10: 0000000000000362 R11: 0000000000000327 R12: ffff888103f=
11250
[  111.887813] R13: ffff888101435530 R14: 0000000000000000 R15: ffff888101e=
76e18
[  111.887815] FS:  00007f4d48875740(0000) GS:ffff888235b00000(0000) knlGS:=
0000000000000000
[  111.887817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.887818] CR2: 00007f4d48a48000 CR3: 000000011c72e002 CR4: 00000000000=
606e0
[  111.887819] Call Trace:
[  111.887829]  ? out_of_line_wait_on_bit+0x92/0xb0
[  111.887844]  ? rpc_decode_header+0x4e0/0x4e0 [sunrpc]
[  111.887863]  __rpc_execute+0x71/0x420 [sunrpc]
[  111.887885]  ? xprt_iter_default_rewind+0x10/0x10 [sunrpc]
[  111.887907]  ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
[  111.887922]  rpc_run_task+0x14c/0x180 [sunrpc]
[  111.887940]  nfs4_do_call_sync+0x6e/0xb0 [nfsv4]
[  111.887961]  _nfs42_proc_getxattr+0xb7/0x170 [nfsv4]
[  111.887984]  ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
[  111.888005]  nfs42_proc_getxattr+0x86/0xb0 [nfsv4]
[  111.888018]  nfs4_xattr_get_nfs4_user+0xc9/0xe0 [nfsv4]
[  111.888023]  vfs_getxattr+0x161/0x1a0
[  111.888026]  getxattr+0x14f/0x230
[  111.888028]  ? filename_lookup+0x123/0x1b0
[  111.888031]  ? _cond_resched+0x16/0x40
[  111.888034]  ? kmem_cache_alloc+0x3c4/0x4b0
[  111.888036]  ? getname_flags.part.0+0x45/0x1a0
[  111.888039]  path_getxattr+0x62/0xb0
[  111.888043]  do_syscall_64+0x33/0x40
[  111.888046]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  111.888048] RIP: 0033:0x7f4d4897762e
[  111.888050] Code: 48 8b 0d 4d 48 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 c0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 48 0c 00 f7 d8 64 89 01 48
[  111.888052] RSP: 002b:00007fff01750768 EFLAGS: 00000202 ORIG_RAX: 000000=
00000000c0
[  111.888054] RAX: ffffffffffffffda RBX: 00007fff017508d0 RCX: 00007f4d489=
7762e
[  111.888055] RDX: 0000000000000000 RSI: 00007fff017508d0 RDI: 00007fff017=
6243a
[  111.888056] RBP: 0000000000000000 R08: 00007fff017507b0 R09: 00000000000=
00000
[  111.888057] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00001
[  111.888058] R13: 00007fff017507b0 R14: 00007fff0176243a R15: 00000000000=
00000
[  111.888060] ---[ end trace fdd032a781f2160d ]---
[  111.889050] ------------[ cut here ]------------


Tigran.

----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "Frank van der Linden" <fllinden@amazon.com>, "linux-nfs" <linux-nfs@=
vger.kernel.org>
> Sent: Thursday, 3 December, 2020 18:13:26
> Subject: Re: Kernel OPS when using xattr

> On Thu, 2020-12-03 at 17:04 +0100, Mkrtchyan, Tigran wrote:
>>=20
>>=20
>> Hi Trond,
>>=20
>> unfortunately the same result. Here the output of gdb, if it helps.
>>=20
>> (gdb) list *0x00000000000252be
>> 0x252be is in _shift_data_right_pages (net/sunrpc/xdr.c:344).
>> 339=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (*pgto !=3D *pg=
from) {
>> 340=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vfrom =3D kmap_atomic(*pgfrom);
>> 341=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(vto + pgto_base, vfrom +
>> pgfrom_base, copy);
>> 342=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_atomic(vfrom);
>> 343=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else
>> 344=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memmove(vto + pgto_base, vto +
>> pgfrom_base, copy);
>> 345=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flush_dcache_page(=
*pgto);
>> 346=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_atomic(vto)=
;
>> 347
>> 348=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0} while ((len -=3D copy) !=3D 0);
>> (gdb)
>>=20
>=20
> You probably need this one in addition to the first patch.
> 8<----------------------------------------------------
> From fec77469f373fbccb292c2d522f2ebee3b9011a8 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Thu, 3 Dec 2020 12:04:51 -0500
> Subject: [PATCH] NFSv4.2: Fix up the get/listxattr calls to
> rpc_prepare_reply_pages()
>=20
> Ensure that both getxattr and listxattr page array are correctly
> aligned, and that getxattr correctly accounts for the page padding
> word.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/nfs42xdr.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 8432bd6b95f0..103978ff76c9 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -191,7 +191,7 @@
>=20
> #define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
> =09=09=09=09 nfs4_xattr_name_maxsz)
> -#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + 1)
> +#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 +
> pagepad_maxsz)
> #define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
> =09=09=09=09 1 + nfs4_xattr_name_maxsz + 1)
> #define decode_setxattr_maxsz   (op_decode_hdr_maxsz +
> decode_change_info_maxsz)
> @@ -1476,17 +1476,18 @@ static void nfs4_xdr_enc_getxattr(struct
> rpc_rqst *req, struct xdr_stream *xdr,
> =09struct compound_hdr hdr =3D {
> =09=09.minorversion =3D nfs4_xdr_minorversion(&args-
>>seq_args),
> =09};
> +=09uint32_t replen;
> =09size_t plen;
>=20
> =09encode_compound_hdr(xdr, req, &hdr);
> =09encode_sequence(xdr, &args->seq_args, &hdr);
> =09encode_putfh(xdr, args->fh, &hdr);
> +=09replen =3D hdr.replen + op_decode_hdr_maxsz + 1;
> =09encode_getxattr(xdr, args->xattr_name, &hdr);
>=20
> =09plen =3D args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
>=20
> -=09rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> -=09    hdr.replen);
> +=09rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> replen);
> =09req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
>=20
> =09encode_nops(&hdr);
> @@ -1520,14 +1521,15 @@ static void nfs4_xdr_enc_listxattrs(struct
> rpc_rqst *req,
> =09struct compound_hdr hdr =3D {
> =09=09.minorversion =3D nfs4_xdr_minorversion(&args-
>>seq_args),
> =09};
> +=09uint32_t replen;
>=20
> =09encode_compound_hdr(xdr, req, &hdr);
> =09encode_sequence(xdr, &args->seq_args, &hdr);
> =09encode_putfh(xdr, args->fh, &hdr);
> +=09replen =3D hdr.replen + op_decode_hdr_maxsz + 2 + 1;
> =09encode_listxattrs(xdr, args, &hdr);
>=20
> -=09rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
>>count,
> -=09    hdr.replen);
> +=09rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
>>count, replen);
>=20
> =09encode_nops(&hdr);
> }
> --
> 2.28.0
>=20
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
