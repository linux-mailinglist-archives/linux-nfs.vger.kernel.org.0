Return-Path: <linux-nfs+bounces-11377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19535AA57E3
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 00:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2091BA7A6C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2E21D583;
	Wed, 30 Apr 2025 22:12:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1D20E01F
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051141; cv=none; b=Z7n14aiUIXh9IefIwZDpNB1CsDFyNxhrxzH0ZJ0JUO4RgqkKhTmfLej5NeCuizx0jDpiOGUzmyuITqXmqxg/xglSl36HmMxWx4nGGO/eOqKyORSpCIzvQrK37EAhD4yhkhUMvICcYfmKNY+f8ywKEJFRtn8dll3uCdQnWFgbdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051141; c=relaxed/simple;
	bh=5zsZ8gi/5Zpu8dpfrBqtMEp+KX1SbKU8suLWiQDBvOg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h1Co91N9wiA91hIlINiKxOfj7MxH18t/g8U7CaqdxAnKXwh9iDASx1bzfUSyys2Y3wsOn4I1yauOzyMEx24KZttTodzuIrz4GZyZyLy566LCnf68ikamZuNVyL9HsRBH2ks+1tGcPcxLPSODRQVFrPL0eumVffp8Up1xTgf/9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uAFf4-006L6l-KE;
	Wed, 30 Apr 2025 22:12:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] nfs_localio: protect race between nfs_uuid_put() and
 nfs_close_local_fh()
In-reply-to: <aBJfC0geyEDZyGYg@kernel.org>
References: <>, <aBJfC0geyEDZyGYg@kernel.org>
Date: Thu, 01 May 2025 08:12:13 +1000
Message-id: <174605113394.500591.17060352670298500048@noble.neil.brown.name>

On Thu, 01 May 2025, Mike Snitzer wrote:
> Hi Neil,
>=20
> With this change a simple write to a file (using pNFS flexfiles)
> triggers this patch's nfs_close_local_fh WARN_ON:
>=20
> [  261.589009] ------------[ cut here ]------------
> [  261.589016] WARNING: CPU: 2 PID: 7220 at fs/nfs_common/nfslocalio.c:344 =
nfs_close_local_fh+0x1dd/0x1f0 [nfs_localio]
> [  261.589045] Modules linked in: tls nfsv3 nfs_layout_flexfiles rpcsec_gss=
_krb5 nfsv4 dns_resolver nfsidmap nfsd auth_rpcgss nfs_acl nft_nat nft_ct nft=
_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_masq nft_chain_nat nf_nat nf_=
conntrack nf_defrag_ipv6 nf_defrag_ipv4 veth bridge stp llc nfs lockd grace n=
fs_localio sunrpc netfs nf_tables nfnetlink overlay rfkill vsock_loopback vmw=
_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vfat fat intel_=
rapl_msr intel_rapl_common kvm_intel kvm nd_pmem dax_pmem nd_e820 pktcdvd lib=
nvdimm irqbypass ppdev crct10dif_pclmul crc32_pclmul vmw_balloon i2c_piix4 gh=
ash_clmulni_intel vmw_vmci pcspkr joydev i2c_smbus rapl parport_pc parport xf=
s sr_mod sd_mod cdrom sg ata_generic ata_piix mptspi crc32c_intel libata scsi=
_transport_spi serio_raw mptscsih vmxnet3 mptbase dm_mod fuse [last unloaded:=
 sunrpc]
> [  261.589403] CPU: 2 UID: 0 PID: 7220 Comm: dd Kdump: loaded Tainted: G   =
     W         -------  ---  6.12.24.0.hs.62.snitm+ #15
> [  261.589414] Tainted: [W]=3DWARN
> [  261.589417] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop Reference Platform, BIOS 6.00 12/12/2018
> [  261.589423] RIP: 0010:nfs_close_local_fh+0x1dd/0x1f0 [nfs_localio]
> [  261.589440] Code: e2 ba 02 00 00 00 48 89 ee 4c 89 e7 e8 9c 9f cb e1 48 =
8b 43 20 48 85 c0 75 e2 48 89 ee 4c 89 e7 e8 28 a7 cb e1 e9 6f ff ff ff <0f> =
0b e8 bc 36 d0 e1 e9 63 ff ff ff e8 02 86 8a e2 66 90 90 90 90
> [  261.589447] RSP: 0018:ffffb0fac4d5bc98 EFLAGS: 00010282
> [  261.589455] RAX: 0000000000000000 RBX: ffff94354d5f0270 RCX: 00000000000=
00002
> [  261.589461] RDX: ffff943544085040 RSI: ffff9435455559e8 RDI: ffff9435440=
85040
> [  261.589466] RBP: ffff943544199e80 R08: 58132c4e3594ffff R09: fffffffae10=
a4a38
> [  261.589472] R10: 0000000000000001 R11: 000000000000000f R12: ffff94354ba=
ae380
> [  261.589477] R13: ffff94354baae3c0 R14: ffff943546916d08 R15: ffff9435469=
16cf0
> [  261.589499] FS:  00007fd6724ff580(0000) GS:ffff943773b00000(0000) knlGS:=
0000000000000000
> [  261.589512] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  261.589518] CR2: 00007fdade5900a8 CR3: 000000010f3a8002 CR4: 00000000001=
726f0
> [  261.589539] Call Trace:
> [  261.589545]  <TASK>
> [  261.589556]  ff_layout_free_mirror+0x78/0xc0 [nfs_layout_flexfiles]
> [  261.589575]  ff_layout_free_layoutreturn+0x64/0x110 [nfs_layout_flexfile=
s]
> [  261.589594]  pnfs_roc_release+0x7e/0x140 [nfsv4]
> [  261.589830]  nfs4_free_closedata+0x6c/0x80 [nfsv4]
> [  261.590013]  rpc_free_task+0x36/0x60 [sunrpc]
> [  261.590209]  nfs4_do_close+0x269/0x330 [nfsv4]
> [  261.590398]  __put_nfs_open_context+0xcb/0x150 [nfs]
> [  261.590546]  nfs_file_release+0x39/0x60 [nfs]
> [  261.590700]  __fput+0xdc/0x2a0
> [  261.590713]  __x64_sys_close+0x3e/0x70
> [  261.590723]  do_syscall_64+0x7b/0x160
> [  261.590736]  ? clear_bhb_loop+0x45/0xa0
> [  261.590744]  ? clear_bhb_loop+0x45/0xa0
> [  261.590769]  ? clear_bhb_loop+0x45/0xa0
> [  261.590777]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  261.590789] RIP: 0033:0x7fd671f2ebf8
> [  261.590796] Code: 01 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 =
f3 0f 1e fa 48 8d 05 65 6b 2a 00 8b 00 85 c0 75 17 b8 03 00 00 00 0f 05 <48> =
3d 00 f0 ff ff 77 40 c3 0f 1f 80 00 00 00 00 53 89 fb 48 83 ec
> [  261.590803] RSP: 002b:00007ffd9826ea88 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000003
> [  261.590812] RAX: ffffffffffffffda RBX: 0000558223012120 RCX: 00007fd671f=
2ebf8
> [  261.590819] RDX: 0000000000100000 RSI: 0000000000000000 RDI: 00000000000=
00001
> [  261.590826] RBP: 0000000000000001 R08: 00000000ffffffff R09: 00000000000=
00000
> [  261.590834] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
00001
> [  261.590843] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fd6723=
2d000
> [  261.590858]  </TASK>
> [  261.590864] ---[ end trace 0000000000000000 ]---
>=20
> After this last patch is applied, in nfs_close_local_fh() you have:
>=20
>         /* tell nfs_uuid_put() to wait for us */
>         RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
>         spin_unlock(&nfs_uuid->lock);
>         rcu_read_unlock();
>=20
>         ro_nf =3D xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
>         rw_nf =3D xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
>         nfs_to_nfsd_file_put_local(ro_nf);
>         nfs_to_nfsd_file_put_local(rw_nf);
>=20
>         rcu_read_lock();
>         if (WARN_ON(rcu_access_pointer(nfl->nfs_uuid) !=3D nfs_uuid)) {
>                 rcu_read_unlock();
>                 return;
>         }
>         /* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
>          * that we are done.
>          */
>         spin_lock(&nfs_uuid->lock);
>         list_del_init(&nfl->list);
>         wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
>         spin_unlock(&nfs_uuid->lock);
>         rcu_read_unlock();
> }
>=20
> this is bogus right?:
>=20
> RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> ...
> if (WARN_ON(rcu_access_pointer(nfl->nfs_uuid) !=3D nfs_uuid))
>=20
> not sure what you were trying to do, maybe stale debugging? [but you didn't=
 test so... ;) ]

Hi Mike,
 thanks for highlighting that.  Yes, clearly bogus.
This code went through several iterations until I felt it was the right
shape.
I added that WARN_ON at one point because I had dropped rcu_read_lock
and reclaimed it, and that was (I thought) all that was protecting
nfs_uuid.  But that is certainly not needed now, even if it was earlier
in the development.

Thanks,
NeilBrown

