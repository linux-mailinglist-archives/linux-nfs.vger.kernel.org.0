Return-Path: <linux-nfs+bounces-7651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B029BB794
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35371C20AF2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CACF13A257;
	Mon,  4 Nov 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALJiiug5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE42AD0C
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730221; cv=none; b=fk9l6ld7F4y4G4thdGkdNN2l+mURJmUod8CJF3wKBXAdk0CVIVMAjeQvyKU3mFtjpjg/UdMbOORmFBc8KtmKqJe+AOq6NmZLhWcbPXujtW9sZ6nZ3UgvrM95atTgl69QhKdyKC5KYg4GMRFqCpEng6FmvRD1mj2k7RMzmI79eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730221; c=relaxed/simple;
	bh=tSdy1ajH+FZOICPC5yEaFRnrgVda5G/I9inPDBp5+gA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwwnFMH6ttpWGOlb0HYIWl3kMt3tOyFnhri74d+3g1iFAuS5/z3aH4rYV1AmtR7EgFu9rGuy6ZAhBHgdkOzwhxbvtEHJ3UX4uqllBTBTJRG68D5hpGrkXW8zzgD/gtztYLFG5Wvxqa4vlJX5ftaM2enVKTIJuVFKJnB8a6qADxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALJiiug5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04902C4CECE;
	Mon,  4 Nov 2024 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730220;
	bh=tSdy1ajH+FZOICPC5yEaFRnrgVda5G/I9inPDBp5+gA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ALJiiug51LtTe6bdd1KiVU0C5+1FY+//CA4V/qvDHWE3we4P3ffluQglzGTiGboK7
	 fxXLRd6eodATJIhjR/LmCwc6jdGK8w7l77fJWl5mMZCHD5s6lAC4zBZXFPPbNG9LBu
	 SHXOwj/mi6TY6K4fnFsf8Am3FJbdwW8YTgyoBEn+fJh1X4W5NO8mIad5LqtpZiTgTi
	 LAuxhDK/uiSqty1cLd7y0yDi7PrPuE2na55HvRJokXBmaJAjUTSM1WuoozDYKuS0Is
	 Q1WiwYR8IweU397KLSDWZcrAn0SRuWhl74aQdyjaPtoHpLkkqui9CGybTfDcadtFsA
	 +Kq+K3wko2x2g==
Message-ID: <d0278add82aec4d5b660cf76df6dd3ce061302b4.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: fix nfs4_openowner leak when concurrent
 nfsd4_open occur
From: Jeff Layton <jlayton@kernel.org>
To: Yang Erkun <yangerkun@huaweicloud.com>, chuck.lever@oracle.com, 
	neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Date: Mon, 04 Nov 2024 09:23:39 -0500
In-Reply-To: <20241104121843.1589284-1-yangerkun@huaweicloud.com>
References: <20241104121843.1589284-1-yangerkun@huaweicloud.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 20:18 +0800, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
>=20
> The action force umount(umount -f) will attempt to kill all rpc_task even
> umount operation may ultimately fail if some files remain open.
> Consequently, if an action attempts to open a file, it can potentially
> send two rpc_task to nfs server.
>=20
>                    NFS CLIENT
> thread1                             thread2
> open("file")
> ...
> nfs4_do_open
>  _nfs4_do_open
>   _nfs4_open_and_get_state
>    _nfs4_proc_open
>     nfs4_run_open_task
>      /* rpc_task1 */
>      rpc_run_task
>      rpc_wait_for_completion_task
>=20
>                                     umount -f
>                                     nfs_umount_begin
>                                      rpc_killall_tasks
>                                       rpc_signal_task
>      rpc_task1 been wakeup
>      and return -512
>  _nfs4_do_open // while loop
>     ...
>     nfs4_run_open_task
>      /* rpc_task2 */
>      rpc_run_task
>      rpc_wait_for_completion_task
>=20
> While processing an open request, nfsd will first attempt to find or
> allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
> marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
> two rpc_task can attempt to open the same file simultaneously from the
> client to server, and because two instances of nfsd can run
> concurrently, this situation can lead to lots of memory leak.
> Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
> triggered.
>=20
>                     NFS SERVER
> nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads
>=20
> nfsd4_open
>  nfsd4_process_open1
>   find_or_alloc_open_stateowner
>    // alloc oo1, stateid1
>                        nfsd4_open
>                         nfsd4_process_open1
>                         find_or_alloc_open_stateowner
>                         // find oo1, without NFS4_OO_CONFIRMED
>                          release_openowner
>                           unhash_openowner_locked
>                           list_del_init(&oo->oo_perclient)
>                           // cannot find this oo
>                           // from client, LEAK!!!
>                          alloc_stateowner // alloc oo2
>=20
>  nfsd4_process_open2
>   init_open_stateid
>   // associate oo1
>   // with stateid1, stateid1 LEAK!!!
>   nfs4_get_vfs_file
>   // alloc nfsd_file1 and nfsd_file_mark1
>   // all LEAK!!!
>=20
>                          nfsd4_process_open2
>                          ...
>=20
>                                     write_threads
>                                      ...
>                                      nfsd_destroy_serv
>                                       nfsd_shutdown_net
>                                        nfs4_state_shutdown_net
>                                         nfs4_state_destroy_net
>                                          destroy_client
>                                           __destroy_client
>                                           // won't find oo1!!!
>                                      nfsd_shutdown_generic
>                                       nfsd_file_cache_shutdown
>                                        kmem_cache_destroy
>                                        for nfsd_file_slab
>                                        and nfsd_file_mark_slab
>                                        // bark since nfsd_file1
>                                        // and nfsd_file_mark1
>                                        // still alive
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
> __kmem_cache_shutdown()
> -----------------------------------------------------------------------
>=20
> Slab 0xffd4000004438a80 objects=3D34 used=3D1 fp=3D0xff11000110e2ad28
> flags=3D0x17ffffc0000240(workingset|head|node=3D0|zone=3D2|lastcpupid=3D0=
x1fffff)
> CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x53/0x70
>  slab_err+0xb0/0xf0
>  __kmem_cache_shutdown+0x15c/0x310
>  kmem_cache_destroy+0x66/0x160
>  nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>  nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>  nfsd_svc+0x125/0x1e0 [nfsd]
>  write_threads+0x16a/0x2a0 [nfsd]
>  nfsctl_transaction_write+0x74/0xa0 [nfsd]
>  vfs_write+0x1ae/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Disabling lock debugging due to kernel taint
> Object 0xff11000110e2ac38 @offset=3D3128
> Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=3D1635 cpu=3D3
> pid=3D800
>  nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
>  nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
>  nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
>  nfsd4_process_open2+0x713/0x1070 [nfsd]
>  nfsd4_open+0x74b/0x8b0 [nfsd]
>  nfsd4_proc_compound+0x70b/0xc20 [nfsd]
>  nfsd_dispatch+0x1b4/0x3a0 [nfsd]
>  svc_process_common+0x5b8/0xc50 [sunrpc]
>  svc_process+0x2ab/0x3b0 [sunrpc]
>  svc_handle_xprt+0x681/0xa20 [sunrpc]
>  nfsd+0x183/0x220 [nfsd]
>  kthread+0x199/0x1e0
>  ret_from_fork+0x31/0x60
>  ret_from_fork_asm+0x1a/0x30
>=20
> Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
> break nfsd4_open process to fix this problem.
>=20
> Cc: stable@vger.kernel.org # 2.6
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> v1->v2: fix mistake in nfs4_openowner_unhashed
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 551d2958ec29..bc175bafc4d7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1660,6 +1660,12 @@ static void release_open_stateid(struct nfs4_ol_st=
ateid *stp)
>  	free_ol_stateid_reaplist(&reaplist);
>  }
> =20
> +static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
> +{

Can we add a lockdep_assert_held() for the cl_lock here?

> +	return list_empty(&oo->oo_owner.so_strhash) &&
> +		list_empty(&oo->oo_perclient);
> +}
> +
>  static void unhash_openowner_locked(struct nfs4_openowner *oo)
>  {
>  	struct nfs4_client *clp =3D oo->oo_owner.so_client;
> @@ -4975,6 +4981,12 @@ init_open_stateid(struct nfs4_file *fp, struct nfs=
d4_open *open)
>  	spin_lock(&oo->oo_owner.so_client->cl_lock);
>  	spin_lock(&fp->fi_lock);
> =20
> +	if (nfs4_openowner_unhashed(oo)) {
> +		mutex_unlock(&stp->st_mutex);
> +		stp =3D NULL;
> +		goto out_unlock;
> +	}
> +
>  	retstp =3D nfsd4_find_existing_open(fp, open);
>  	if (retstp)
>  		goto out_unlock;
> @@ -6127,6 +6139,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct=
 svc_fh *current_fh, struct nf
> =20
>  	if (!stp) {
>  		stp =3D init_open_stateid(fp, open);
> +		if (!stp) {
> +			status =3D nfserr_jukebox;
> +			goto out;
> +		}
> +
>  		if (!open->op_stp)
>  			new_stp =3D true;
>  	}

Nice analysis!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

