Return-Path: <linux-nfs+bounces-10205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27851A3DCEB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC5188E4EA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F561F754A;
	Thu, 20 Feb 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Y0lgL5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B311F1531;
	Thu, 20 Feb 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062034; cv=none; b=ceUG88IbGpI5Dx/+3LDkJ6ZbRhZGhAaGSJ5h3C5jbSlbQMliELpR9gZufT7r5vUsytzNkp9Df8rRYo81ooYFIchROfJP4xqzmNBCFqLE1tk9FGjDtZiAIeKCciEjysM16vEA7SChs8gW+sPwahgv7HTdUNWYx4e8iNUrmLFs+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062034; c=relaxed/simple;
	bh=/4KE/ck10vk1DW5+BF5YoVyFnrf4TJKXUYIizChjpQ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oC8AbRVdCpAC+5XUbSvxvU+l4tSSAgT/4isLy8pzsqQEKeGnKczo17iyMpjNh7sSYfEaHH71zQlyuVLg17yN5j7RjwVjZrUN9cmpWPNFUzrioJSQ+hmACSnbxlIzsfg+D57CbDrV9GyOOJR/m4E6tLBl+4ogxK7eubmdKXAcYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Y0lgL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF56C4CED1;
	Thu, 20 Feb 2025 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740062033;
	bh=/4KE/ck10vk1DW5+BF5YoVyFnrf4TJKXUYIizChjpQ0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=K5Y0lgL5LXnzGrJlJ18LpBfgOGC+b0z0KvjNE7KQmRANg9SRwvG6x8tbZgG9tARQ9
	 /I4Jiv0LRdHpqH1bXjxRDZohRXr6dEWYZuM9zLj01D7bXVsEJLf2ePY/rBErHFndjc
	 f5FTZd/WxjAdAvoXqptGM2jGs9euFFInrLx9ovbtAaqlZajBu34mtKayhbF2qsD0PZ
	 ro2gYn3297IFMeHdsBjQbsgi3g7IQEROYpgEvEcxxHFQPvPs5QXzPSEQlRwLM1tckk
	 SlPhthBK+qWPHqvWPyw8V/sMj2D3ntkNM1iJ47zeBOJ6NQbDbtGOpy8q859d9safDb
	 t/5P49ZBWDP0w==
Message-ID: <d16ef1b07a46ed47741582f4f167239c1e7457c7.camel@kernel.org>
Subject: Re: nfsd 6.14-rc1 __fh_verify NULL ptr deref
From: Jeff Layton <jlayton@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list	
 <selinux@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, 	chuck.lever@oracle.com, Paul Moore
 <paul@paul-moore.com>, Ondrej Mosnacek	 <omosnace@redhat.com>
Date: Thu, 20 Feb 2025 09:33:51 -0500
In-Reply-To: <CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
References: 
	<CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 09:27 -0500, Stephen Smalley wrote:
> This was on selinux/dev so I will retry with nfsd-next too but I don't
> believe we have any nfs-related changes in the selinux tree. Config
> attached.
>=20
> Reproducer:
> (enable SELinux)
> git clone https://github.com/selinuxproject/selinux-testsuite
> install dependencies as per README.md
> sudo ./tools/nfs.sh
>=20
> [   55.726787] NFSD: all clients done reclaiming, ending NFSv4 grace
> period (net f0000
> 000)
> [   55.754588] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [   55.754608] #PF: supervisor read access in kernel mode
> [   55.754617] #PF: error_code(0x0000) - not-present page
> [   55.754625] PGD 0 P4D 0
> [   55.754633] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   55.754642] CPU: 4 UID: 0 PID: 2720 Comm: make Not tainted 6.14.0-rc1+=
 #254

Thanks for the bug report.

I think this should now be fixed with d9d6b74e4be98 that went into
-rc3:

[1]: https://lore.kernel.org/linux-nfs/20250128165806.15153-1-okorniev@redh=
at.com/

See=20
> [   55.754669] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> [   55.754755] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> c2 0f b6 d2 48 89 ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48
> fc ff ff <48> 8b 45 28 48 8b 50 30 83 e2 10 74 2c f0 48 0f ba 68 30 11
> 72 23
> [   55.754781] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> [   55.754791] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 000000000=
0000000
> [   55.754802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590=
e38e400
> [   55.754812] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 000000000=
0000000
> [   55.754823] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 000000000=
0000000
> [   55.754833] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 000000000=
0008000
> [   55.754844] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> knlGS:0000000000000000
> [   55.754856] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.754865] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 000000000=
07706f0
> [   55.754897] PKRU: 55555554
> [   55.754904] Call Trace:
> [   55.754913]  <TASK>
> [   55.754920]  ? __die_body.cold+0x19/0x27
> [   55.754933]  ? page_fault_oops+0x15c/0x2f0
> [   55.754944]  ? exc_page_fault+0x7e/0x1a0
> [   55.754955]  ? asm_exc_page_fault+0x26/0x30
> [   55.754966]  ? __fh_verify+0x473/0x7b0 [nfsd]
> [   55.755023]  ? __fh_verify+0x468/0x7b0 [nfsd]
> [   55.755069]  fh_verify_local+0x27/0x30 [nfsd]
> [   55.755116]  nfsd_file_do_acquire+0x59b/0xc50 [nfsd]
> [   55.755167]  ? get_page_from_freelist+0x17d7/0x1bd0
> [   55.755180]  nfsd_file_acquire_local+0x4e/0x90 [nfsd]
> [   55.755229]  nfsd_open_local_fh+0x121/0x190 [nfsd]
> [   55.755285]  nfs_open_local_fh+0x96/0x120 [nfs_localio]
> [   55.755590]  nfs_local_open_fh+0xb1/0x200 [nfs]
> [   55.755908]  nfs_generic_pg_pgios+0x96/0x110 [nfs]
> [   55.756190]  nfs_pageio_doio+0x3b/0x80 [nfs]
> [   55.756450]  nfs_pageio_complete+0x7d/0x130 [nfs]
> [   55.756727]  nfs_pageio_complete_read+0x12/0x60 [nfs]
> [   55.757000]  nfs_readahead+0x244/0x2a0 [nfs]
> [   55.757255]  read_pages+0x71/0x1f0
> [   55.757488]  ? __folio_batch_add_and_move+0xbe/0x100
> [   55.757712]  page_cache_ra_order+0x272/0x390
> [   55.757934]  filemap_get_pages+0x140/0x730
> [   55.758176]  filemap_read+0x106/0x460
> [   55.758397]  nfs_file_read+0x93/0xc0 [nfs]
> [   55.758638]  vfs_read+0x29f/0x370
> [   55.758855]  ksys_read+0x6c/0xe0
> [   55.759083]  do_syscall_64+0x82/0x160
> [   55.759334]  ? set_ptes.isra.0+0x41/0x90
> [   55.759567]  ? do_anonymous_page+0xfc/0x940
> [   55.759799]  ? ___pte_offset_map+0x1b/0x180
> [   55.760028]  ? __handle_mm_fault+0xb6c/0xfc0
> [   55.760287]  ? __count_memcg_events+0xc0/0x180
> [   55.760526]  ? count_memcg_events.constprop.0+0x1a/0x30
> [   55.760751]  ? handle_mm_fault+0x21b/0x330
> [   55.760972]  ? do_user_addr_fault+0x55a/0x7b0
> [   55.761188]  ? clear_bhb_loop+0x25/0x80
> [   55.761426]  ? clear_bhb_loop+0x25/0x80
> [   55.761619]  ? clear_bhb_loop+0x25/0x80
> [   55.761806]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   55.761993] RIP: 0033:0x7f2eb9d05991
> [   55.762188] Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff
> ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31
> c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> 83 ec
> [   55.762615] RSP: 002b:00007ffd23dd62b8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [   55.762826] RAX: ffffffffffffffda RBX: 000055939883d6d0 RCX: 00007f2eb=
9d05991
> [   55.763034] RDX: 0000000000002000 RSI: 000055939883da40 RDI: 000000000=
0000003
> [   55.763241] RBP: 00007ffd23dd62f0 R08: 0000000000000000 R09: 000000000=
0000001
> [   55.763452] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f2eb=
9e05fd0
> [   55.763671] R13: 00007f2eb9e05e80 R14: 0000000000000000 R15: 000055939=
883d6d0
> [   55.763880]  </TASK>
> [   55.764085] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace
> nfs_localio vfat fat jfs nls_ucs2_utils nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> iptable_security ip_set rfkill nf_tables ip6table_filter ip6_tables
> iptable_filter ip_tables qrtr binfmt_misc intel_rapl_msr
> intel_rapl_common intel_uncore_frequency_common isst_if_mbox_msr
> isst_if_common skx_edac_common nfit libnvdimm rapl vmw_balloon pktcdvd
> pcspkr vmxnet3 i2c_piix4 i2c_smbus joydev auth_rpcgss sunrpc loop
> dm_multipath nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram
> vmw_vmci lz4hc_compress lz4_compress xfs vmwgfx polyval_clmulni
> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
> sha1_ssse3 vmw_pvscsi
> [   55.764153]  ata_generic drm_ttm_helper pata_acpi ttm serio_raw
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser fuse
> [   55.766222] CR2: 0000000000000028
> [   55.766500] ---[ end trace 0000000000000000 ]---
> [   55.766813] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> [   55.767165] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> c2 0f b6 d2 48 89
>  ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48 fc ff ff <48> 8b
> 45 28 48 8b 50 30
>  83 e2 10 74 2c f0 48 0f ba 68 30 11 72 23
> [   55.767785] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> [   55.768119] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 000000000=
0000000
> [   55.768434] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590=
e38e400
> [   55.768751] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 000000000=
0000000
> [   55.769089] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 000000000=
0000000
> [   55.769408] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 000000000=
0008000
> [   55.769726] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> knlGS:00000000000
> 00000
> [   55.770069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.770393] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 000000000=
07706f0
> [   55.770756] PKRU: 55555554
> [   55.771111] note: make[2720] exited with irqs disabled
> [   55.771477] ------------[ cut here ]------------

--=20
Jeff Layton <jlayton@kernel.org>

