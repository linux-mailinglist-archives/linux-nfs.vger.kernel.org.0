Return-Path: <linux-nfs+bounces-3898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E263190B204
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1881F24469
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09019AD4D;
	Mon, 17 Jun 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmSqeQDK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BA198A24
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632024; cv=none; b=LbCqa3siN2Y1Sg9kDbChTelDTfR7wGRuAmVb7rNkVLl/GDlCOSLZkzw3j5CrQPbrZ0nS08EefKl/cnqUTL54yrN7JFtb30dGWvNYIO2sgz11DHhFurnwRZc8prSFVJA71TJX+bUrtSX7VXta8zSij4zC3sbnBqTfhC4XoC3sYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632024; c=relaxed/simple;
	bh=/g0mvC0ih2F82qUJsYGwzQprfIO0YIeHMq1gvK0b4so=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFr40k1HIdHFUSU87ZNCRsjEFUWBV0mqYVvkJmk75xz9BzMOypUsjYgTO8PJ5wMAhSFkaeoidD+yNxgBYaoAGPptJXiIfNaTXtSDbgMBRF1AyMbvRO7k1hg/0M6zI39fo9JznnutDt2QXVc78+w097yy05QglhqADmeK187TKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmSqeQDK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718632021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l/nopnSxo30xBK0GOVsxqA4C/m4rU1TKOkSpfPSYfTQ=;
	b=XmSqeQDKoQfSK4kRR4kmQXz8CjTvix7uz9UUHjDCxLuUgmAm5o047QyerfEYaie1hBst5T
	fK9jx2uR/z0Xtn7u2W/2pKSQPPFv2vWdpBcBMYxWWr+LW8YF1pYZ+BFifPnjRJi5jCArMY
	V4BTqgJ+iUUTKfz2nAMAUpBR4f1zmpQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-17MRlHNgMhqIOS310g9TWA-1; Mon,
 17 Jun 2024 09:46:59 -0400
X-MC-Unique: 17MRlHNgMhqIOS310g9TWA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA7C019560B9
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:46:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CE0B19560AE
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:46:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: knfsd svcauth_gss_ oops on 6.10-rc2
Date: Mon, 17 Jun 2024 09:46:55 -0400
Message-ID: <F5C621C3-EE32-4D4D-8ABE-E2A337651E59@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

My aarch64 system just popped this on a krb5i mount.. I will investigate,=
 but maybe looks familiar:


[ 3195.745724] Unable to handle kernel paging request at virtual address =
0062617472747336
[ 3195.746486] Mem abort info:
[ 3195.746839]   ESR =3D 0x0000000096000004
[ 3195.747142]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 3195.747438]   SET =3D 0, FnV =3D 0
[ 3195.747723]   EA =3D 0, S1PTW =3D 0
[ 3195.748005]   FSC =3D 0x04: level 0 translation fault
[ 3195.748280] Data abort info:
[ 3195.748544]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[ 3195.748803]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[ 3195.749094]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 3195.749349] [0062617472747336] address between user and kernel address=
 ranges
[ 3195.749631] Internal error: Oops: 0000000096000004 [#1] SMP
[ 3195.749927] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs =
netfs nfsd nfs_acl lockd auth_rpcgss grace iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft=
_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_na=
t nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tabl=
es nfnetlink qrtr vsock_loopback vmw_vsock_virtio_transport_common vmw_vs=
ock_vmci_transport vsock sunrpc binfmt_misc pktcdvd snd_hda_codec_generic=
 snd_hda_intel snd_intel_dspcfg snd_hda_codec uvcvideo snd_hda_core vfat =
fat uvc snd_hwdep videobuf2_vmalloc videobuf2_memops snd_seq videobuf2_v4=
l2 snd_seq_device videobuf2_common snd_pcm videodev snd_timer snd mc soun=
dcore joydev vmw_vmci loop zram xfs crct10dif_ce polyval_ce polyval_gener=
ic vmwgfx ghash_ce nvme sha3_ce e1000e sha512_ce nvme_core sha512_arm64 d=
rm_ttm_helper ttm uhci_hcd scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tabl=
es ip_tables dm_multipath fuse
[ 3195.752102] CPU: 5 PID: 6371 Comm: nfsd Not tainted 6.10.0-rc2.nks #21=
5
[ 3195.752386] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.21805430.BA64.2305221830 05/22/2023
[ 3195.752660] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
[ 3195.752934] pc : gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3195.753215] lr : gss_free_in_token_pages+0xec/0x110 [auth_rpcgss]
[ 3195.753487] sp : ffff800084c9bb30
[ 3195.753752] x29: ffff800084c9bb30 x28: 0000000000000000 x27: ffff00000=
0000000
[ 3195.754022] x26: 0000020040000000 x25: 0000000000000000 x24: 000000000=
000027b
[ 3195.754291] x23: 00000000ffffffff x22: 0000000000000001 x21: ffff80008=
4c9bc10
[ 3195.754558] x20: 0000000000000001 x19: 006261747274732e x18: 000000000=
0000014
[ 3195.754827] x17: 00000000ba82f6ae x16: 00000000cb3b9d01 x15: 000000000=
0000520
[ 3195.755088] x14: 0000000000000020 x13: bdd23caaaa61bb15 x12: 2c0e8cd50=
bdcd419
[ 3195.755342] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008=
0391438
[ 3195.755593] x8 : ffff000093e73e20 x7 : 0000000000000000 x6 : 000000000=
00007e0
[ 3195.755836] x5 : 0000000000000000 x4 : 000000000000041a x3 : 000000000=
00048b7
[ 3195.756074] x2 : 0000000000000001 x1 : ffff0001f0204880 x0 : ffff00008=
0aa4d78
[ 3195.756307] Call trace:
[ 3195.756539]  gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3195.756796]  svcauth_gss_proxy_init+0x268/0x3b8 [auth_rpcgss]
[ 3195.757042]  svcauth_gss_proc_init+0x9c/0x130 [auth_rpcgss]
[ 3195.757289]  svcauth_gss_accept+0x318/0x5f0 [auth_rpcgss]
[ 3195.757537]  svc_authenticate+0x98/0xc8 [sunrpc]
[ 3195.757911]  svc_process_common+0x210/0x728 [sunrpc]
[ 3195.758183]  svc_process+0xf4/0x178 [sunrpc]
[ 3195.758450]  svc_recv+0x938/0xc10 [sunrpc]
[ 3195.758716]  nfsd+0xc8/0x1e8 [nfsd]
[ 3195.758985]  kthread+0x104/0x118
[ 3195.759285]  ret_from_fork+0x10/0x20
[ 3195.759549] Code: 52800036 f9001bf7 12800017 d503201f (f9400661)
[ 3195.759863] ---[ end trace 0000000000000000 ]---
[ 3220.798506] Unable to handle kernel paging request at virtual address =
24df231366cfb5d9
[ 3220.799296] Mem abort info:
[ 3220.799734]   ESR =3D 0x0000000096000004
[ 3220.800155]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 3220.800577]   SET =3D 0, FnV =3D 0
[ 3220.800993]   EA =3D 0, S1PTW =3D 0
[ 3220.801406]   FSC =3D 0x04: level 0 translation fault
[ 3220.801788] Data abort info:
[ 3220.802139]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[ 3220.802492]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[ 3220.802843]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 3220.803192] [24df231366cfb5d9] address between user and kernel address=
 ranges
[ 3220.803549] Internal error: Oops: 0000000096000004 [#2] SMP
[ 3220.803894] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs =
netfs nfsd nfs_acl lockd auth_rpcgss grace iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft=
_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_na=
t nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tabl=
es nfnetlink qrtr vsock_loopback vmw_vsock_virtio_transport_common vmw_vs=
ock_vmci_transport vsock sunrpc binfmt_misc pktcdvd snd_hda_codec_generic=
 snd_hda_intel snd_intel_dspcfg snd_hda_codec uvcvideo snd_hda_core vfat =
fat uvc snd_hwdep videobuf2_vmalloc videobuf2_memops snd_seq videobuf2_v4=
l2 snd_seq_device videobuf2_common snd_pcm videodev snd_timer snd mc soun=
dcore joydev vmw_vmci loop zram xfs crct10dif_ce polyval_ce polyval_gener=
ic vmwgfx ghash_ce nvme sha3_ce e1000e sha512_ce nvme_core sha512_arm64 d=
rm_ttm_helper ttm uhci_hcd scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tabl=
es ip_tables dm_multipath fuse
[ 3220.806468] CPU: 0 PID: 6369 Comm: nfsd Tainted: G      D            6=
=2E10.0-rc2.nks #215
[ 3220.806826] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.21805430.BA64.2305221830 05/22/2023
[ 3220.807183] pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
[ 3220.807538] pc : gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3220.807921] lr : gss_free_in_token_pages+0xec/0x110 [auth_rpcgss]
[ 3220.808281] sp : ffff800084c13b30
[ 3220.808640] x29: ffff800084c13b30 x28: 0000000000000000 x27: ffff00000=
0000000
[ 3220.809290] x26: 0000020040000000 x25: 0000000000000000 x24: 000000000=
000027b
[ 3220.809648] x23: 00000000ffffffff x22: 0000000000000001 x21: ffff80008=
4c13c10
[ 3220.809985] x20: 0000000000000001 x19: 24df231366cfb5d1 x18: 000000001=
46f10b2
[ 3220.810303] x17: 00000000e1f53a5a x16: 00000000a3bc5bc2 x15: 000000000=
0000fa0
[ 3220.810621] x14: 0000000000000020 x13: a5cb3f9d346e026c x12: 8fc07574b=
cd5681c
[ 3220.810935] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008=
0391438
[ 3220.811252] x8 : ffff0000844d3ee0 x7 : 0000000000000000 x6 : 000000000=
00007e0
[ 3220.811572] x5 : 0000000000000000 x4 : 000000000000041a x3 : 000000000=
00048b7
[ 3220.811887] x2 : 0000000000000001 x1 : ffff000083930000 x0 : ffff00008=
2c71f68
[ 3220.812201] Call trace:
[ 3220.812511]  gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3220.812841]  svcauth_gss_proxy_init+0x268/0x3b8 [auth_rpcgss]
[ 3220.813161]  svcauth_gss_proc_init+0x9c/0x130 [auth_rpcgss]
[ 3220.813477]  svcauth_gss_accept+0x318/0x5f0 [auth_rpcgss]
[ 3220.813793]  svc_authenticate+0x98/0xc8 [sunrpc]
[ 3220.814152]  svc_process_common+0x210/0x728 [sunrpc]
[ 3220.814497]  svc_process+0xf4/0x178 [sunrpc]
[ 3220.814841]  svc_recv+0x938/0xc10 [sunrpc]
[ 3220.815186]  nfsd+0xc8/0x1e8 [nfsd]
[ 3220.815534]  kthread+0x104/0x118
[ 3220.815856]  ret_from_fork+0x10/0x20
[ 3220.816170] Code: 52800036 f9001bf7 12800017 d503201f (f9400661)
[ 3220.816482] ---[ end trace 0000000000000000 ]---
[ 3245.824129] Unable to handle kernel paging request at virtual address =
00003234323a3039
[ 3245.824892] Mem abort info:
[ 3245.825181]   ESR =3D 0x0000000096000004
[ 3245.825426]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 3245.825661]   SET =3D 0, FnV =3D 0
[ 3245.825891]   EA =3D 0, S1PTW =3D 0
[ 3245.826124]   FSC =3D 0x04: level 0 translation fault
[ 3245.826352] Data abort info:
[ 3245.826589]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[ 3245.826837]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[ 3245.827079]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 3245.827319] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000104e4200=
0
[ 3245.827559] [00003234323a3039] pgd=3D0000000000000000, p4d=3D000000000=
0000000
[ 3245.827820] Internal error: Oops: 0000000096000004 [#3] SMP
[ 3245.828047] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs =
netfs nfsd nfs_acl lockd auth_rpcgss grace iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft=
_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_na=
t nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tabl=
es nfnetlink qrtr vsock_loopback vmw_vsock_virtio_transport_common vmw_vs=
ock_vmci_transport vsock sunrpc binfmt_misc pktcdvd snd_hda_codec_generic=
 snd_hda_intel snd_intel_dspcfg snd_hda_codec uvcvideo snd_hda_core vfat =
fat uvc snd_hwdep videobuf2_vmalloc videobuf2_memops snd_seq videobuf2_v4=
l2 snd_seq_device videobuf2_common snd_pcm videodev snd_timer snd mc soun=
dcore joydev vmw_vmci loop zram xfs crct10dif_ce polyval_ce polyval_gener=
ic vmwgfx ghash_ce nvme sha3_ce e1000e sha512_ce nvme_core sha512_arm64 d=
rm_ttm_helper ttm uhci_hcd scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tabl=
es ip_tables dm_multipath fuse
[ 3245.829755] CPU: 5 PID: 6370 Comm: nfsd Tainted: G      D            6=
=2E10.0-rc2.nks #215
[ 3245.829992] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.21805430.BA64.2305221830 05/22/2023
[ 3245.830232] pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
[ 3245.830491] pc : gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3245.830774] lr : gss_free_in_token_pages+0xec/0x110 [auth_rpcgss]
[ 3245.831047] sp : ffff800084c3bb30
[ 3245.831313] x29: ffff800084c3bb30 x28: 0000000000000000 x27: ffff00000=
0000000
[ 3245.831585] x26: 0000020040000000 x25: 0000000000000000 x24: 000000000=
000027b
[ 3245.831854] x23: 00000000ffffffff x22: 0000000000000001 x21: ffff80008=
4c3bc10
[ 3245.832123] x20: 0000000000000002 x19: ec003234323a3031 x18: 000000003=
5a65de1
[ 3245.832390] x17: 0000000003270d8c x16: 0000000076f9e432 x15: 000000000=
00003b0
[ 3245.832658] x14: 0000000000000020 x13: 62a87bd2714c8702 x12: ced9443ce=
e68f00d
[ 3245.832926] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008=
0391438
[ 3245.833196] x8 : ffff000093e73ee0 x7 : 0000000000000000 x6 : 000000000=
00007e0
[ 3245.833465] x5 : 0000000000000000 x4 : 000000000000041a x3 : 000000000=
00048b7
[ 3245.833731] x2 : 0000000000000001 x1 : ffff0001f0200000 x0 : ffff00008=
0aa42a8
[ 3245.834001] Call trace:
[ 3245.834280]  gss_free_in_token_pages+0x40/0x110 [auth_rpcgss]
[ 3245.834584]  svcauth_gss_proxy_init+0x268/0x3b8 [auth_rpcgss]
[ 3245.834906]  svcauth_gss_proc_init+0x9c/0x130 [auth_rpcgss]
[ 3245.835214]  svcauth_gss_accept+0x318/0x5f0 [auth_rpcgss]
[ 3245.835574]  svc_authenticate+0x98/0xc8 [sunrpc]
[ 3245.835931]  svc_process_common+0x210/0x728 [sunrpc]
[ 3245.836271]  svc_process+0xf4/0x178 [sunrpc]
[ 3245.836606]  svc_recv+0x938/0xc10 [sunrpc]
[ 3245.836944]  nfsd+0xc8/0x1e8 [nfsd]
[ 3245.837286]  kthread+0x104/0x118
[ 3245.837618]  ret_from_fork+0x10/0x20
[ 3245.837919] Code: 52800036 f9001bf7 12800017 d503201f (f9400661)
[ 3245.838219] ---[ end trace 0000000000000000 ]---
[ 3245.839059] Unable to handle kernel write to read-only memory at virtu=
al address ffff000099527000
[ 3245.839421] Mem abort info:
[ 3245.839765]   ESR =3D 0x000000009600004f
[ 3245.840107]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 3245.840459]   SET =3D 0, FnV =3D 0
[ 3245.840813]   EA =3D 0, S1PTW =3D 0
[ 3245.841164]   FSC =3D 0x0f: level 3 permission fault
[ 3245.841517] Data abort info:
[ 3245.841862]   ISV =3D 0, ISS =3D 0x0000004f, ISS2 =3D 0x00000000
[ 3245.842207]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[ 3245.842614]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 3245.843022] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000026a64=
f000
[ 3245.843432] [ffff000099527000] pgd=3D180000027fdff003, p4d=3D180000027=
fdff003, pud=3D180000027f9fc003, pmd=3D180000027f931003, pte=3D0060000119=
527787
[ 3245.843849] Internal error: Oops: 000000009600004f [#4] SMP
[ 3245.844266] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs =
netfs nfsd nfs_acl lockd auth_rpcgss grace iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft=
_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_na=
t nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tabl=
es nfnetlink qrtr vsock_loopback vmw_vsock_virtio_transport_common vmw_vs=
ock_vmci_transport vsock sunrpc binfmt_misc pktcdvd snd_hda_codec_generic=
 snd_hda_intel snd_intel_dspcfg snd_hda_codec uvcvideo snd_hda_core vfat =
fat uvc snd_hwdep videobuf2_vmalloc videobuf2_memops snd_seq videobuf2_v4=
l2 snd_seq_device videobuf2_common snd_pcm videodev snd_timer snd mc soun=
dcore joydev vmw_vmci loop zram xfs crct10dif_ce polyval_ce polyval_gener=
ic vmwgfx ghash_ce nvme sha3_ce e1000e sha512_ce nvme_core sha512_arm64 d=
rm_ttm_helper ttm uhci_hcd scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tabl=
es ip_tables dm_multipath fuse
[ 3245.847251] CPU: 5 PID: 6890 Comm: kworker/5:2 Tainted: G      D      =
      6.10.0-rc2.nks #215
[ 3245.847671] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.21805430.BA64.2305221830 05/22/2023
[ 3245.848096] Workqueue: events drm_fb_helper_damage_work
[ 3245.848583] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
[ 3245.849014] pc : clear_page+0x18/0x58
[ 3245.849504] lr : post_alloc_hook+0xb0/0x160
[ 3245.849955] sp : ffff8000849fb500
[ 3245.850380] x29: ffff8000849fb500 x28: fffffdffc26549c0 x27: 000000000=
0000000
[ 3245.850824] x26: ffff0001fed00780 x25: 0000000000000001 x24: ffff00000=
0000000
[ 3245.851256] x23: 0000000000000000 x22: 0000000000000dc0 x21: 000000000=
2654a00
[ 3245.851687] x20: fffffdffc26549c0 x19: 0000000002654a00 x18: 000000000=
0000006
[ 3245.852117] x17: 6132346161303830 x16: 0000000000000020 x15: 000000000=
0000000
[ 3245.852548] x14: 0000000000000000 x13: ffff0001effcacc0 x12: 000000000=
0000000
[ 3245.852979] x11: 0000000000013e66 x10: ffff0001fec4a9e0 x9 : ffff80008=
0392878
[ 3245.853413] x8 : 0000000000000030 x7 : 0000000000000000 x6 : 000000000=
0000001
[ 3245.853844] x5 : 0000000000180000 x4 : ffff800082a4cc18 x3 : 000000000=
0000002
[ 3245.854243] x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff00009=
9527000
[ 3245.854608] Call trace:
[ 3245.854972]  clear_page+0x18/0x58
[ 3245.855344]  get_page_from_freelist+0x338/0x1630
[ 3245.855709]  __alloc_pages_noprof+0xd0/0xee0
[ 3245.856071]  alloc_pages_mpol_noprof+0xe4/0x220
[ 3245.856450]  alloc_pages_noprof+0x50/0xd8
[ 3245.856811]  vmw_validation_mem_alloc+0x74/0xf8 [vmwgfx]
[ 3245.857242]  vmw_validation_add_resource+0xf0/0x2a8 [vmwgfx]
[ 3245.857622]  vmw_du_helper_plane_update+0x2a0/0x320 [vmwgfx]
[ 3245.858006]  vmw_stdu_plane_update_surface+0xe4/0x118 [vmwgfx]
[ 3245.858386]  vmw_stdu_primary_plane_atomic_update+0x130/0x1a8 [vmwgfx]=

[ 3245.858766]  drm_atomic_helper_commit_planes+0xf0/0x2e8
[ 3245.859130]  drm_atomic_helper_commit_tail+0x5c/0xb0
[ 3245.859486]  vmw_atomic_commit_tail+0x2c/0xa0 [vmwgfx]
[ 3245.859856]  commit_tail+0xac/0x1a0
[ 3245.860210]  drm_atomic_helper_commit+0x184/0x1a8
[ 3245.860567]  drm_atomic_commit+0xa8/0xd0
[ 3245.860939]  drm_atomic_helper_dirtyfb+0x188/0x280
[ 3245.861295]  drm_fbdev_generic_helper_fb_dirty+0x1d0/0x310
[ 3245.861653]  drm_fb_helper_damage_work+0x80/0x168
[ 3245.862008]  process_one_work+0x19c/0x460
[ 3245.862361]  worker_thread+0x284/0x3a0
[ 3245.862712]  kthread+0x104/0x118
[ 3245.863060]  ret_from_fork+0x10/0x20
[ 3245.863399] Code: 37200121 12000c21 d2800082 9ac12041 (d50b7420)
[ 3245.863734] ---[ end trace 0000000000000000 ]---


