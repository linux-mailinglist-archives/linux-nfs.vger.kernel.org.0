Return-Path: <linux-nfs+bounces-6389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF8975A6E
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 20:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8CB21DE5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D418C344;
	Wed, 11 Sep 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcb8Ykt0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CF187543
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079623; cv=none; b=UxUyBVdcSBLLaYgGegSTZmHLF4AJjdUAjeB3K0Ct5JmKEqUPz4EC9zuEp5L1TvHEsgoAbjwsQanR1syoVxL7FLfKT6rjyGM2TO4wzSbIgc0QclP2eIqAmR2NhnSMARBUhrvu6zLOlaMZ5OCRjGOskWpl2UUyeVlXsJTQw7vxyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079623; c=relaxed/simple;
	bh=/TiO5UVZJuCy+Df9ubgT6X3TSWQ//RfDkvV17AVgOyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atD7+n641LQlcNgKfMySlSpR4RtzZpS2KnuAGXZ+FBwmW7VVjnvj0XH7j2LHU0u2qpLy3OILuYy7hSrWIEyTJiGBOCrI2T9vm5bS1nYZABMY8IcMYjVNqLxFwEVAvM1X9UlwF7NhWN81RmkNk3uUgDjd4TY/Vrp4ofhwT4zHTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcb8Ykt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA4DC4CEC0;
	Wed, 11 Sep 2024 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726079623;
	bh=/TiO5UVZJuCy+Df9ubgT6X3TSWQ//RfDkvV17AVgOyU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kcb8Ykt0Fp8nmZcyWidsGpSHuzyzKys2DAhO0FVvp9okBJ4NcC8Heth+hlTGefqfq
	 RKHJcIfuSXPf9JMd59GiljHUdVPTVIDkmhunvmJYNH8EO83Jsw3W2vbTPFL5uwaKMj
	 CePtQzyBdxSXvDBvmsLnRQMTsWhuNBs6cV8TK8o+KLNih3zPBuo4tMVhCip4LIESjo
	 JWuHg4d+oRqOkOv9Gr8VwTl8r+ke4PmbGCNrwrvOQolMt6IDWVKhDPKSXxgUhLxKY0
	 A316TmhGgwgwT7JchCIsPKLWkuP3fVAX+KJuJzXZq0YshrAr3wcdssU6zKtaFnRvyI
	 V25rmiTf6HFQQ==
Message-ID: <7b34c3f94c93d4171289892131dcfed7e157d18e.camel@kernel.org>
Subject: Re: [PATCH 2/2] sunrpc: allow svc threads to fail initialisation
 cleanly
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 11 Sep 2024 14:33:41 -0400
In-Reply-To: <20240729212217.30747-3-neilb@suse.de>
References: <20240729212217.30747-1-neilb@suse.de>
	 <20240729212217.30747-3-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-30 at 07:19 +1000, NeilBrown wrote:
> If an svc thread needs to perform some initialisation that might fail,
> it has no good way to handle the failure.
>=20
> Before the thread can exit it must call svc_exit_thread(), but that
> requires the service mutex to be held.  The thread cannot simply take
> the mutex as that could deadlock if there is a concurrent attempt to
> shut down all threads (which is unlikely, but not impossible).
>=20
> nfsd currently call svc_exit_thread() unprotected in the unlikely event
> that unshare_fs_struct() fails.
>=20
> We can clean this up by introducing svc_thread_init_status() by which an
> svc thread can report whether initialisation has succeeded.  If it has,
> it continues normally into the action loop.  If it has not,
> svc_thread_init_status() immediately aborts the thread.
> svc_start_kthread() waits for either of these to happen, and calls
> svc_exit_thread() (under the mutex) if the thread aborted.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/lockd/svc.c             |  2 ++
>  fs/nfs/callback.c          |  2 ++
>  fs/nfsd/nfssvc.c           |  9 +++------
>  include/linux/sunrpc/svc.h | 28 ++++++++++++++++++++++++++++
>  net/sunrpc/svc.c           | 11 +++++++++++
>  5 files changed, 46 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 71713309967d..4ec22c2f2ea3 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -124,6 +124,8 @@ lockd(void *vrqstp)
>  	struct net *net =3D &init_net;
>  	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
> =20
> +	svc_thread_init_status(rqstp, 0);
> +
>  	/* try_to_freeze() is called from svc_recv() */
>  	set_freezable();
> =20
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 8adfcd4c8c1a..6cf92498a5ac 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -76,6 +76,8 @@ nfs4_callback_svc(void *vrqstp)
>  {
>  	struct svc_rqst *rqstp =3D vrqstp;
> =20
> +	svc_thread_init_status(rqstp, 0);
> +
>  	set_freezable();
> =20
>  	while (!svc_thread_should_stop(rqstp))
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index fca340b3ee91..1cef09a3c78e 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -875,11 +875,9 @@ nfsd(void *vrqstp)
> =20
>  	/* At this point, the thread shares current->fs
>  	 * with the init process. We need to create files with the
> -	 * umask as defined by the client instead of init's umask. */
> -	if (unshare_fs_struct() < 0) {
> -		printk("Unable to start nfsd thread: out of memory\n");
> -		goto out;
> -	}
> +	 * umask as defined by the client instead of init's umask.
> +	 */
> +	svc_thread_init_status(rqstp, unshare_fs_struct());
> =20
>  	current->fs->umask =3D 0;
> =20
> @@ -901,7 +899,6 @@ nfsd(void *vrqstp)
> =20
>  	atomic_dec(&nfsd_th_cnt);
> =20
> -out:
>  	/* Release the thread */
>  	svc_exit_thread(rqstp);
>  	return 0;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 99e9345d829e..437672bcaa22 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -21,6 +21,7 @@
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/pagevec.h>
> +#include <linux/kthread.h>
> =20
>  /*
>   *
> @@ -232,6 +233,11 @@ struct svc_rqst {
>  	struct net		*rq_bc_net;	/* pointer to backchannel's
>  						 * net namespace
>  						 */
> +
> +	int			rq_err;		/* Thread sets this to inidicate
> +						 * initialisation success.
> +						 */
> +
>  	unsigned long	bc_to_initval;
>  	unsigned int	bc_to_retries;
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> @@ -305,6 +311,28 @@ static inline bool svc_thread_should_stop(struct svc=
_rqst *rqstp)
>  	return test_bit(RQ_VICTIM, &rqstp->rq_flags);
>  }
> =20
> +/**
> + * svc_thread_init_status - report whether thread has initialised succes=
sfully
> + * @rqstp: the thread in question
> + * @err: errno code
> + *
> + * After performing any initialisation that could fail, and before start=
ing
> + * normal work, each sunrpc svc_thread must call svc_thread_init_status(=
)
> + * with an appropriate error, or zero.
> + *
> + * If zero is passed, the thread is ready and must continue until
> + * svc_thread_should_stop() returns true.  If a non-zero error is passed
> + * the call will not return - the thread will exit.
> + */
> +static inline void svc_thread_init_status(struct svc_rqst *rqstp, int er=
r)
> +{
> +	/* store_release ensures svc_start_kthreads() sees the error */
> +	smp_store_release(&rqstp->rq_err, err);
> +	wake_up_var(&rqstp->rq_err);
> +	if (err)
> +		kthread_exit(1);
> +}
> +
>  struct svc_deferred_req {
>  	u32			prot;	/* protocol (UDP or TCP) */
>  	struct svc_xprt		*xprt;
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ae31ffea7a14..1e80fa67d8b7 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -706,6 +706,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_=
pool *pool, int node)
>  	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
>  		goto out_enomem;
> =20
> +	rqstp->rq_err =3D -EAGAIN; /* No error yet */
> +
>  	serv->sv_nrthreads +=3D 1;
>  	pool->sp_nrthreads +=3D 1;
> =20
> @@ -792,6 +794,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
>  	struct svc_pool *chosen_pool;
>  	unsigned int state =3D serv->sv_nrthreads-1;
>  	int node;
> +	int err;
> =20
>  	do {
>  		nrservs--;
> @@ -814,6 +817,14 @@ svc_start_kthreads(struct svc_serv *serv, struct svc=
_pool *pool, int nrservs)
> =20
>  		svc_sock_update_bufs(serv);
>  		wake_up_process(task);
> +
> +		/* load_acquire ensures we get value stored in svc_thread_init_status(=
) */
> +		wait_var_event(&rqstp->rq_err, smp_load_acquire(&rqstp->rq_err) !=3D -=
EAGAIN);
> +		err =3D rqstp->rq_err;
> +		if (err) {
> +			svc_exit_thread(rqstp);
> +			return err;
> +		}
>  	} while (nrservs > 0);
> =20
>  	return 0;


I hit a hang today on the client while running the nfs-interop test
under kdevops. The client is stuck in mount syscall, while trying to
set up the backchannel:

[ 1693.653257] INFO: task mount.nfs:13243 blocked for more than 120 seconds=
.
[ 1693.655827]       Not tainted 6.11.0-rc7-gffcadb41b696 #166
[ 1693.657858] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1693.661442] task:mount.nfs       state:D stack:0     pid:13243 tgid:1324=
3 ppid:13242  flags:0x00004002
[ 1693.664648] Call Trace:
[ 1693.665639]  <TASK>
[ 1693.666482]  __schedule+0xc04/0x2750
[ 1693.668021]  ? __pfx___schedule+0x10/0x10
[ 1693.669562]  ? _raw_spin_lock_irqsave+0x98/0xf0
[ 1693.671213]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 1693.673109]  ? try_to_wake_up+0x141/0x1210
[ 1693.674763]  ? __pfx_try_to_wake_up+0x10/0x10
[ 1693.676612]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[ 1693.678429]  schedule+0x73/0x2f0
[ 1693.679662]  svc_set_num_threads+0xbc8/0xf80 [sunrpc]
[ 1693.682007]  ? __pfx_svc_set_num_threads+0x10/0x10 [sunrpc]
[ 1693.684163]  ? __pfx_var_wake_function+0x10/0x10
[ 1693.685849]  ? __svc_create+0x6c0/0x980 [sunrpc]
[ 1693.687777]  nfs_callback_up+0x314/0xae0 [nfsv4]
[ 1693.689630]  nfs4_init_client+0x203/0x400 [nfsv4]
[ 1693.691468]  ? __pfx_nfs4_init_client+0x10/0x10 [nfsv4]
[ 1693.693502]  ? _raw_spin_lock_irqsave+0x98/0xf0
[ 1693.695141]  nfs4_set_client+0x2f4/0x520 [nfsv4]
[ 1693.696967]  ? __pfx_nfs4_set_client+0x10/0x10 [nfsv4]
[ 1693.699230]  nfs4_create_server+0x5f2/0xef0 [nfsv4]
[ 1693.701357]  ? _raw_spin_lock+0x85/0xe0
[ 1693.702758]  ? __pfx__raw_spin_lock+0x10/0x10
[ 1693.704344]  ? nfs_get_tree+0x61f/0x16a0 [nfs]
[ 1693.706160]  ? __pfx_nfs4_create_server+0x10/0x10 [nfsv4]
[ 1693.707376]  ? __module_get+0x26/0xc0
[ 1693.708061]  nfs4_try_get_tree+0xcd/0x250 [nfsv4]
[ 1693.708893]  vfs_get_tree+0x83/0x2d0
[ 1693.709534]  path_mount+0x88d/0x19a0
[ 1693.710100]  ? __pfx_path_mount+0x10/0x10
[ 1693.710718]  ? user_path_at+0xa4/0xe0
[ 1693.711303]  ? kmem_cache_free+0x143/0x3e0
[ 1693.711936]  __x64_sys_mount+0x1fb/0x270
[ 1693.712606]  ? __pfx___x64_sys_mount+0x10/0x10
[ 1693.713315]  do_syscall_64+0x4b/0x110
[ 1693.713889]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1693.714660] RIP: 0033:0x7f05050418fe
[ 1693.715233] RSP: 002b:00007fff4e0f5728 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[ 1693.716417] RAX: ffffffffffffffda RBX: 00007fff4e0f5900 RCX: 00007f05050=
418fe
[ 1693.717492] RDX: 00005559cea3ea70 RSI: 00005559cea3fe60 RDI: 00005559cea=
40140
[ 1693.718558] RBP: 00007fff4e0f5760 R08: 00005559cea41e60 R09: 00007f05051=
0cb20
[ 1693.719620] R10: 0000000000000000 R11: 0000000000000246 R12: 00005559cea=
41e60
[ 1693.720735] R13: 00007fff4e0f5900 R14: 00005559cea41df0 R15: 00000000000=
00004


Looking at faddr2line:

$ ./scripts/faddr2line --list net/sunrpc/sunrpc.ko svc_set_num_threads+0xbc=
8/0xf80
svc_set_num_threads+0xbc8/0xf80:

svc_start_kthreads at /home/jlayton/git/kdevops/linux/net/sunrpc/svc.c:822 =
(discriminator 17)
 817=20
 818                    svc_sock_update_bufs(serv);
 819                    wake_up_process(task);
 820=20
 821                    /* load_acquire ensures we get value stored in svc_=
thread_init_status() */
>822<                   wait_var_event(&rqstp->rq_err, smp_load_acquire(&rq=
stp->rq_err) !=3D -EAGAIN);
 823                    err =3D rqstp->rq_err;
 824                    if (err) {
 825                            svc_exit_thread(rqstp);
 826                            return err;
 827                    }

(inlined by) svc_set_num_threads at /home/jlayton/git/kdevops/linux/net/sun=
rpc/svc.c:877 (discriminator 17)
 872                    nrservs -=3D serv->sv_nrthreads;
 873            else
 874                    nrservs -=3D pool->sp_nrthreads;
 875=20
 876            if (nrservs > 0)
>877<                   return svc_start_kthreads(serv, pool, nrservs);
 878            if (nrservs < 0)
 879                    return svc_stop_kthreads(serv, pool, nrservs);
 880            return 0;
 881    }
 882    EXPORT_SYMBOL_GPL(svc_set_num_threads);

It looks like the callback thread started up properly and is past the svc_t=
hread_init_status call.

$ sudo cat /proc/13246/stack
[<0>] svc_recv+0xcef/0x2020 [sunrpc]
[<0>] nfs4_callback_svc+0xb0/0x140 [nfsv4]
[<0>] kthread+0x29b/0x360
[<0>] ret_from_fork+0x30/0x70
[<0>] ret_from_fork_asm+0x1a/0x30

...so the status should have been updated properly. Barrier problem?
--=20
Jeff Layton <jlayton@kernel.org>

