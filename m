Return-Path: <linux-nfs+bounces-10522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632AA56649
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB793B20A3
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A82153E8;
	Fri,  7 Mar 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0SJn+/N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156022153D4;
	Fri,  7 Mar 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345684; cv=none; b=XvoMWxok4/pATkbHVuXJu0ihEpTP0Uq8z6xJ1ezXgpL8o6WbA4pJ3bPH7fiTl5iEj9bjj9zJ6Pte62mqm04uSG8xmNsUTFxyh++37GM4NNr5sJuqKYrRdKcb9WPerc9UMN0VmAwkXO9QTI9GK8tmGXtYa1msTSMtimitFRrCrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345684; c=relaxed/simple;
	bh=hD8wrDk1lC23SkGKQcGIY74EdB41ZVYCnwxC+30BTko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzPZMDT3VVkuSByFX42HHpkH/hgDLZknecrP0C3fBmKcI06nGjSx4codXoCY65QUqCm9bmIpNUI9augAuc04ruh2O/CIxtg2AlImmveVdaMR3KvfgLMp9PNc7Uy/ruXcz45iOExOv5etvKq5AQW0WmHmF1lqTrY2qEljiNNdEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0SJn+/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAC4C4CED1;
	Fri,  7 Mar 2025 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741345683;
	bh=hD8wrDk1lC23SkGKQcGIY74EdB41ZVYCnwxC+30BTko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F0SJn+/NQUK959FxNePOOIVlTiMqC/hL40hkRSwZrSDazQlnNUcez4SfcDcfdnpPu
	 gbH3bknJy2W+5SWNkVMlAmbu6AUJiul2KTs7gyEMA8FYjxA4XZ4ujMyzAbCKDK/1c1
	 K/Zvl8pONao+KBzvGJIr4ifMqV9YTBWc55VFp56CYP8i3FVKxGKBGL3QdoGdpt+7Np
	 onyyPu05rQvcuw2Cy6onGAqAj9oMRP0HM51xFmmpHPIhubi3dHkE5dtKSsHVwRx5rD
	 WID2qGxEsTh9x1JTQ2PGg3D89B4iKzgzbo2pKuTkOqJ+IgTgRthtc3OrzxsbBlPjaJ
	 1A6KVD98BKJcQ==
Message-ID: <397a94ea94169b54c58f9442b810090e960d5691.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSD: fix race between nfsd registration and
 exports_proc
From: Jeff Layton <jlayton@kernel.org>
To: Maninder Singh <maninder1.s@samsung.com>, chuck.lever@oracle.com, 
	neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	lorenzo@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chungki0201.woo@samsung.com, Shubham Rana <s9.rana@samsung.com>
Date: Fri, 07 Mar 2025 06:08:01 -0500
In-Reply-To: <20250306092007.1419237-2-maninder1.s@samsung.com>
References: <20250306092007.1419237-1-maninder1.s@samsung.com>
		<CGME20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f@epcas5p4.samsung.com>
	 <20250306092007.1419237-2-maninder1.s@samsung.com>
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

On Thu, 2025-03-06 at 14:50 +0530, Maninder Singh wrote:
> As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
> and cleanup by remove_proc_entry() at last of exit_nfsd.
>=20
> Which causes kernel OOPs if there is race between below 2 operations:
> (i) exportfs -r
> (ii) mount -t nfsd none /proc/fs/nfsd
>=20
> for 5.4 kernel ARM64:
>=20
> CPU 1:
> el1_irq+0xbc/0x180
> arch_counter_get_cntvct+0x14/0x18
> running_clock+0xc/0x18
> preempt_count_add+0x88/0x110
> prep_new_page+0xb0/0x220
> get_page_from_freelist+0x2d8/0x1778
> __alloc_pages_nodemask+0x15c/0xef0
> __vmalloc_node_range+0x28c/0x478
> __vmalloc_node_flags_caller+0x8c/0xb0
> kvmalloc_node+0x88/0xe0
> nfsd_init_net+0x6c/0x108 [nfsd]
> ops_init+0x44/0x170
> register_pernet_operations+0x114/0x270
> register_pernet_subsys+0x34/0x50
> init_nfsd+0xa8/0x718 [nfsd]
> do_one_initcall+0x54/0x2e0
>=20
> CPU 2 :
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000010
>=20
> PC is at : exports_net_open+0x50/0x68 [nfsd]
>=20
> Call trace:
> exports_net_open+0x50/0x68 [nfsd]
> exports_proc_open+0x2c/0x38 [nfsd]
> proc_reg_open+0xb8/0x198
> do_dentry_open+0x1c4/0x418
> vfs_open+0x38/0x48
> path_openat+0x28c/0xf18
> do_filp_open+0x70/0xe8
> do_sys_open+0x154/0x248
>=20
> Sometimes it crashes at exports_net_open() and sometimes cache_seq_next_r=
cu().
>=20
> and same is happening on latest 6.14 kernel as well:
>=20
> [    0.000000] Linux version 6.14.0-rc5-next-20250304-dirty
> ...
> [  285.455918] Unable to handle kernel paging request at virtual address =
00001f4800001f48
> ...
> [  285.464902] pc : cache_seq_next_rcu+0x78/0xa4
> ...
> [  285.469695] Call trace:
> [  285.470083]  cache_seq_next_rcu+0x78/0xa4 (P)
> [  285.470488]  seq_read+0xe0/0x11c
> [  285.470675]  proc_reg_read+0x9c/0xf0
> [  285.470874]  vfs_read+0xc4/0x2fc
> [  285.471057]  ksys_read+0x6c/0xf4
> [  285.471231]  __arm64_sys_read+0x1c/0x28
> [  285.471428]  invoke_syscall+0x44/0x100
> [  285.471633]  el0_svc_common.constprop.0+0x40/0xe0
> [  285.471870]  do_el0_svc_compat+0x1c/0x34
> [  285.472073]  el0_svc_compat+0x2c/0x80
> [  285.472265]  el0t_32_sync_handler+0x90/0x140
> [  285.472473]  el0t_32_sync+0x19c/0x1a0
> [  285.472887] Code: f9400885 93407c23 937d7c27 11000421 (f86378a3)
> [  285.473422] ---[ end trace 0000000000000000 ]---
>=20
> It reproduced simply with below script:
> while [ 1 ]
> do
> /exportfs -r
> done &
>=20
> while [ 1 ]
> do
> insmod /nfsd.ko
> mount -t nfsd none /proc/fs/nfsd
> umount /proc/fs/nfsd
> rmmod nfsd
> done &
>=20
> So exporting interfaces to user space shall be done at last and
> cleanup at first place.
>=20
> With change there is no Kernel OOPs.
>=20
> Co-developed-by: Shubham Rana <s9.rana@samsung.com>
> Signed-off-by: Shubham Rana <s9.rana@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  fs/nfsd/nfsctl.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d773481bcf10..f9763ced743d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2291,12 +2291,9 @@ static int __init init_nfsd(void)
>  	if (retval)
>  		goto out_free_pnfs;
>  	nfsd_lockd_init();	/* lockd->nfsd callbacks */
> -	retval =3D create_proc_exports_entry();
> -	if (retval)
> -		goto out_free_lockd;
>  	retval =3D register_pernet_subsys(&nfsd_net_ops);
>  	if (retval < 0)
> -		goto out_free_exports;
> +		goto out_free_lockd;
>  	retval =3D register_cld_notifier();
>  	if (retval)
>  		goto out_free_subsys;
> @@ -2307,12 +2304,17 @@ static int __init init_nfsd(void)
>  	if (retval)
>  		goto out_free_nfsd4;
>  	retval =3D genl_register_family(&nfsd_nl_family);
> +	if (retval)
> +		goto out_free_filesystem;
> +	retval =3D create_proc_exports_entry();
>  	if (retval)
>  		goto out_free_all;
>  	nfsd_localio_ops_init();
> =20
>  	return 0;
>  out_free_all:
> +	genl_unregister_family(&nfsd_nl_family);
> +out_free_filesystem:
>  	unregister_filesystem(&nfsd_fs_type);
>  out_free_nfsd4:
>  	nfsd4_destroy_laundry_wq();
> @@ -2320,9 +2322,6 @@ static int __init init_nfsd(void)
>  	unregister_cld_notifier();
>  out_free_subsys:
>  	unregister_pernet_subsys(&nfsd_net_ops);
> -out_free_exports:
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
>  out_free_lockd:
>  	nfsd_lockd_shutdown();
>  	nfsd_drc_slab_free();
> @@ -2335,14 +2334,14 @@ static int __init init_nfsd(void)
> =20
>  static void __exit exit_nfsd(void)
>  {
> +	remove_proc_entry("fs/nfs/exports", NULL);
> +	remove_proc_entry("fs/nfs", NULL);
>  	genl_unregister_family(&nfsd_nl_family);
>  	unregister_filesystem(&nfsd_fs_type);
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
>  	unregister_pernet_subsys(&nfsd_net_ops);
>  	nfsd_drc_slab_free();
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
>  	nfsd_lockd_shutdown();
>  	nfsd4_free_slabs();
>  	nfsd4_exit_pnfs();

Reviewed-by: Jeff Layton <jlayton@kernel.org>

