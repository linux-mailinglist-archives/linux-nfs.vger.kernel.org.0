Return-Path: <linux-nfs+bounces-5427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB3955750
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D455B2172C
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4A1411EB;
	Sat, 17 Aug 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZDATraS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C17DA64;
	Sat, 17 Aug 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723891091; cv=none; b=Ras1Z/o/uZ5v0V1VzbcsKCCVclGrkrVqpExNYdms576xQe8fF1XkAOvtihQ9tuoYN9OyejKrDbd0yS9EwaMHv/yORyi1kfML1MP7pCJg8z40RGbUXCZyiw00zQ0vRAUB6GcLzL7nmlNSl5q6DtDT7C4imjUTP8zbfy4jl3IXIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723891091; c=relaxed/simple;
	bh=rccawyDM+QgLiOWUE5bHjFDYpuTAH3BKcLLRjKOMCvA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1beGhIb3yKfZorEJDhyBFtrsIihYpEocVcIqkpPGcBLHhQWE/c4wYC/5aDf37ofXwaz32OawssDlGnvHRERozFD7JJX4y4cb5TBKdocrp+Lk5H5mS7Rp3Z6cQjCB5grCKM97BI+Mteu2Tgrlvjvgzudd/61LkPaueUsKJkVwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZDATraS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEC0C116B1;
	Sat, 17 Aug 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723891090;
	bh=rccawyDM+QgLiOWUE5bHjFDYpuTAH3BKcLLRjKOMCvA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RZDATraSdVZkP9kYhq/vN/iZQtyNbTqW2BOi0i3UbcnzTlgC1ty1X5JGjM3AavVu4
	 swaLptoBlV8OVIYIh7sEnY+1t0c4SLAS+M9VlRLmLlxDG7Silhdy6LK2Wu7Hk1p9O9
	 JODr5PxY6p9nyz9zz+iSVZ/pfFqCJEnD7wEPjoaCDCAajP0n7s/sDlRGADYJ5JQNT2
	 f/uuCUp6TB0M59bUHmQKh3/z3/nrbuKMODJosRROh32RW0dt5mH6dK/e9uY9/+dQbi
	 bSH0WOHCpEDpUwYxiRUXR7BX5DN+txPGKCHyaBRkxKBQmbSaD+4JoLj6qahy1usQYk
	 /xuRogJU/0Elw==
Message-ID: <889d83d6854ccab407b15a552595a4181ee9a48b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: map the EBADMSG to nfserr_io to avoid warning
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>, chuck.lever@oracle.com, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng3@huawei.com
Date: Sat, 17 Aug 2024 06:38:08 -0400
In-Reply-To: <20240817062713.1819908-1-lilingfeng@huaweicloud.com>
References: <20240817062713.1819908-1-lilingfeng@huaweicloud.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-17 at 14:27 +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>=20
> Ext4 will throw -EBADMSG through ext4_readdir when a checksum error
> occurs, resulting in the following WARNING.
>=20
> Fix it by mapping EBADMSG to nfserr_io.
>=20
> nfsd_buffered_readdir
>  iterate_dir // -EBADMSG -74
>   ext4_readdir // .iterate_shared
>    ext4_dx_readdir
>     ext4_htree_fill_tree
>      htree_dirblock_to_tree
>       ext4_read_dirblock
>        __ext4_read_dirblock
>         ext4_dirblock_csum_verify
>          warn_no_space_for_csum
>           __warn_no_space_for_csum
>         return ERR_PTR(-EFSBADCRC) // -EBADMSG -74
>  nfserrno // WARNING
>=20
> [  161.115610] ------------[ cut here ]------------
> [  161.116465] nfsd: non-standard errno: -74
> [  161.117315] WARNING: CPU: 1 PID: 780 at fs/nfsd/nfsproc.c:878 nfserrno=
+0x9d/0xd0
> [  161.118596] Modules linked in:
> [  161.119243] CPU: 1 PID: 780 Comm: nfsd Not tainted 5.10.0-00014-g79679=
361fd5d #138
> [  161.120684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qe
> mu.org 04/01/2014
> [  161.123601] RIP: 0010:nfserrno+0x9d/0xd0
> [  161.124676] Code: 0f 87 da 30 dd 00 83 e3 01 b8 00 00 00 05 75 d7 44 8=
9 ee 48 c7 c7 c0 57 24 98 89 44 24 04 c6
>  05 ce 2b 61 03 01 e8 99 20 d8 00 <0f> 0b 8b 44 24 04 eb b5 4c 89 e6 48 c=
7 c7 a0 6d a4 99 e8 cc 15 33
> [  161.127797] RSP: 0018:ffffc90000e2f9c0 EFLAGS: 00010286
> [  161.128794] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000000
> [  161.130089] RDX: 1ffff1103ee16f6d RSI: 0000000000000008 RDI: fffff5200=
01c5f2a
> [  161.131379] RBP: 0000000000000022 R08: 0000000000000001 R09: ffff8881f=
70c1827
> [  161.132664] R10: ffffed103ee18304 R11: 0000000000000001 R12: 000000000=
0000021
> [  161.133949] R13: 00000000ffffffb6 R14: ffff8881317c0000 R15: ffffc9000=
0e2fbd8
> [  161.135244] FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlG=
S:0000000000000000
> [  161.136695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  161.137761] CR2: 00007fcaad70b348 CR3: 0000000144256006 CR4: 000000000=
0770ee0
> [  161.139041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  161.140291] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  161.141519] PKRU: 55555554
> [  161.142076] Call Trace:
> [  161.142575]  ? __warn+0x9b/0x140
> [  161.143229]  ? nfserrno+0x9d/0xd0
> [  161.143872]  ? report_bug+0x125/0x150
> [  161.144595]  ? handle_bug+0x41/0x90
> [  161.145284]  ? exc_invalid_op+0x14/0x70
> [  161.146009]  ? asm_exc_invalid_op+0x12/0x20
> [  161.146816]  ? nfserrno+0x9d/0xd0
> [  161.147487]  nfsd_buffered_readdir+0x28b/0x2b0
> [  161.148333]  ? nfsd4_encode_dirent_fattr+0x380/0x380
> [  161.149258]  ? nfsd_buffered_filldir+0xf0/0xf0
> [  161.150093]  ? wait_for_concurrent_writes+0x170/0x170
> [  161.151004]  ? generic_file_llseek_size+0x48/0x160
> [  161.151895]  nfsd_readdir+0x132/0x190
> [  161.152606]  ? nfsd4_encode_dirent_fattr+0x380/0x380
> [  161.153516]  ? nfsd_unlink+0x380/0x380
> [  161.154256]  ? override_creds+0x45/0x60
> [  161.155006]  nfsd4_encode_readdir+0x21a/0x3d0
> [  161.155850]  ? nfsd4_encode_readlink+0x210/0x210
> [  161.156731]  ? write_bytes_to_xdr_buf+0x97/0xe0
> [  161.157598]  ? __write_bytes_to_xdr_buf+0xd0/0xd0
> [  161.158494]  ? lock_downgrade+0x90/0x90
> [  161.159232]  ? nfs4svc_decode_voidarg+0x10/0x10
> [  161.160092]  nfsd4_encode_operation+0x15a/0x440
> [  161.160959]  nfsd4_proc_compound+0x718/0xe90
> [  161.161818]  nfsd_dispatch+0x18e/0x2c0
> [  161.162586]  svc_process_common+0x786/0xc50
> [  161.163403]  ? nfsd_svc+0x380/0x380
> [  161.164137]  ? svc_printk+0x160/0x160
> [  161.164846]  ? svc_xprt_do_enqueue.part.0+0x365/0x380
> [  161.165808]  ? nfsd_svc+0x380/0x380
> [  161.166523]  ? rcu_is_watching+0x23/0x40
> [  161.167309]  svc_process+0x1a5/0x200
> [  161.168019]  nfsd+0x1f5/0x380
> [  161.168663]  ? nfsd_shutdown_threads+0x260/0x260
> [  161.169554]  kthread+0x1c4/0x210
> [  161.170224]  ? kthread_insert_work_sanity_check+0x80/0x80
> [  161.171246]  ret_from_fork+0x1f/0x30
>=20
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfsd/vfs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29b1f3613800..911e5e0a17af 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -100,6 +100,7 @@ nfserrno (int errno)
>  		{ nfserr_io, -EUCLEAN },
>  		{ nfserr_perm, -ENOKEY },
>  		{ nfserr_no_grace, -ENOGRACE},
> +		{ nfserr_io, -EBADMSG },
>  	};
>  	int	i;
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

