Return-Path: <linux-nfs+bounces-7929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29879C74E8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB381F2474F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264977E111;
	Wed, 13 Nov 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9o267Nv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053D1C695
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509911; cv=none; b=pO3slXDekco7Fn0JWv3og8Geo34e4eZtFz+g39rWBJrwgM01A52ro/PFht5YuS7b0Sn7e2MUxTTfndiXTeEDacy00PM+RA6z75xVYtWOPH3eGxMdpseKR43wsZluV0BIrcp4t6mmEZokGHO1sbxuv9EirYMAHmd8+7sB0LdG/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509911; c=relaxed/simple;
	bh=KUu/1dKRUS00xs6sbRp+49ZBe8/NY7Z5le+k22qdmcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcPYcWNP8qRFGL0LO8sEv8qMXbQngtH8dtu2oD8vkQuPSDpoIPwp+MYdSyGQVk4R+T1JeTCM4HNpvAI1Xexi4LU/RaHbX9iwsMi/3vZgLgUmBPl141+y4sxS85feh4Rg0sbj3lk5l5N2gGQ7FwgVwQB4JBY6HuG1Cbd9qAggtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9o267Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC41BC4CEC3;
	Wed, 13 Nov 2024 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731509910;
	bh=KUu/1dKRUS00xs6sbRp+49ZBe8/NY7Z5le+k22qdmcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c9o267NvG9tFWlDgFL4HyI/mvfJPH+bfJfYYMjoKrSjJe9NuK12kkayw+2C161r3b
	 DsD3aykixbLU85R4rF9iYrjhMmDdcSgj9v4NFLQuKEdnxYqfOuGQ4gbVbwPfMSDYjm
	 Kp09q57qeJ1XAIw9rKa6FgnzRkaxvSe+5fMXUp+KYHT25goY8MYvOw5FwQwBhNbNtN
	 THvOc4V5OY9HxCcFIdOTNAKppwo8CCHHR8c2NlBO+A4gVdfnBWuia0inI36XeXhauS
	 72ZD0c2Ser6JGu/+qXb2aCzYNvKabv/S0CYoMzxmCrEwh9ye8AKbEUV5XkQzXIdEDG
	 pi6iDavdvHDuA==
Message-ID: <c184b8e3e62595714fbcee993011951616ee3a1a.camel@kernel.org>
Subject: Re: [for-6.13 PATCH 02/19] nfs_common: must not hold RCU while
 calling nfsd_file_put_local
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>, Trond Myklebust
 <trondmy@hammerspace.com>,  Chuck Lever <chuck.lever@oracle.com>, NeilBrown
 <neilb@suse.de>
Date: Wed, 13 Nov 2024 09:58:28 -0500
In-Reply-To: <20241108234002.16392-3-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
	 <20241108234002.16392-3-snitzer@kernel.org>
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

On Fri, 2024-11-08 at 18:39 -0500, Mike Snitzer wrote:
> Move holding the RCU from nfs_to_nfsd_file_put_local to
> nfs_to_nfsd_net_put.  It is the call to nfs_to->nfsd_serv_put that
> requires the RCU anyway (the puts for nfsd_file and netns were
> combined to avoid an extra indirect reference but that
> micro-optimization isn't possible now).
>=20
> This fixes xfstests generic/013 and it triggering:
>=20
> "Voluntary context switch within RCU read-side critical section!"
>=20
> [  143.545738] Call Trace:
> [  143.546206]  <TASK>
> [  143.546625]  ? show_regs+0x6d/0x80
> [  143.547267]  ? __warn+0x91/0x140
> [  143.547951]  ? rcu_note_context_switch+0x496/0x5d0
> [  143.548856]  ? report_bug+0x193/0x1a0
> [  143.549557]  ? handle_bug+0x63/0xa0
> [  143.550214]  ? exc_invalid_op+0x1d/0x80
> [  143.550938]  ? asm_exc_invalid_op+0x1f/0x30
> [  143.551736]  ? rcu_note_context_switch+0x496/0x5d0
> [  143.552634]  ? wakeup_preempt+0x62/0x70
> [  143.553358]  __schedule+0xaa/0x1380
> [  143.554025]  ? _raw_spin_unlock_irqrestore+0x12/0x40
> [  143.554958]  ? try_to_wake_up+0x1fe/0x6b0
> [  143.555715]  ? wake_up_process+0x19/0x20
> [  143.556452]  schedule+0x2e/0x120
> [  143.557066]  schedule_preempt_disabled+0x19/0x30
> [  143.557933]  rwsem_down_read_slowpath+0x24d/0x4a0
> [  143.558818]  ? xfs_efi_item_format+0x50/0xc0 [xfs]
> [  143.559894]  down_read+0x4e/0xb0
> [  143.560519]  xlog_cil_commit+0x1b2/0xbc0 [xfs]
> [  143.561460]  ? _raw_spin_unlock+0x12/0x30
> [  143.562212]  ? xfs_inode_item_precommit+0xc7/0x220 [xfs]
> [  143.563309]  ? xfs_trans_run_precommits+0x69/0xd0 [xfs]
> [  143.564394]  __xfs_trans_commit+0xb5/0x330 [xfs]
> [  143.565367]  xfs_trans_roll+0x48/0xc0 [xfs]
> [  143.566262]  xfs_defer_trans_roll+0x57/0x100 [xfs]
> [  143.567278]  xfs_defer_finish_noroll+0x27a/0x490 [xfs]
> [  143.568342]  xfs_defer_finish+0x1a/0x80 [xfs]
> [  143.569267]  xfs_bunmapi_range+0x4d/0xb0 [xfs]
> [  143.570208]  xfs_itruncate_extents_flags+0x13d/0x230 [xfs]
> [  143.571353]  xfs_free_eofblocks+0x12e/0x190 [xfs]
> [  143.572359]  xfs_file_release+0x12d/0x140 [xfs]
> [  143.573324]  __fput+0xe8/0x2d0
> [  143.573922]  __fput_sync+0x1d/0x30
> [  143.574574]  nfsd_filp_close+0x33/0x60 [nfsd]
> [  143.575430]  nfsd_file_free+0x96/0x150 [nfsd]
> [  143.576274]  nfsd_file_put+0xf7/0x1a0 [nfsd]
> [  143.577104]  nfsd_file_put_local+0x18/0x30 [nfsd]
> [  143.578070]  nfs_close_local_fh+0x101/0x110 [nfs_localio]
> [  143.579079]  __put_nfs_open_context+0xc9/0x180 [nfs]
> [  143.580031]  nfs_file_clear_open_context+0x4a/0x60 [nfs]
> [  143.581038]  nfs_file_release+0x3e/0x60 [nfs]
> [  143.581879]  __fput+0xe8/0x2d0
> [  143.582464]  __fput_sync+0x1d/0x30
> [  143.583108]  __x64_sys_close+0x41/0x80
> [  143.583823]  x64_sys_call+0x189a/0x20d0
> [  143.584552]  do_syscall_64+0x64/0x170
> [  143.585240]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  143.586185] RIP: 0033:0x7f3c5153efd7
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/nfslocalio.c |  8 +++-----
>  fs/nfsd/filecache.c        | 14 +++++++-------
>  fs/nfsd/filecache.h        |  2 +-
>  include/linux/nfslocalio.h | 18 +++++++++++++++---
>  4 files changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 09404d142d1a..a74ec08f6c96 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -155,11 +155,9 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid=
,
>  	/* We have an implied reference to net thanks to nfsd_serv_try_get */
>  	localio =3D nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
>  					     cred, nfs_fh, fmode);
> -	if (IS_ERR(localio)) {
> -		rcu_read_lock();
> -		nfs_to->nfsd_serv_put(net);
> -		rcu_read_unlock();
> -	}
> +	if (IS_ERR(localio))
> +		nfs_to_nfsd_net_put(net);
> +
>  	return localio;
>  }
>  EXPORT_SYMBOL_GPL(nfs_open_local_fh);
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index c16671135d17..9a62b4da89bb 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -391,19 +391,19 @@ nfsd_file_put(struct nfsd_file *nf)
>  }
> =20
>  /**
> - * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_s=
erv
> - * @nf: nfsd_file of which to put the references
> + * nfsd_file_put_local - put nfsd_file reference and arm nfsd_serv_put i=
n caller
> + * @nf: nfsd_file of which to put the reference
>   *
> - * First put the reference of the nfsd_file and then put the
> - * reference to the associated nn->nfsd_serv.
> + * First save the associated net to return to caller, then put
> + * the reference of the nfsd_file.
>   */
> -void
> -nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
> +struct net *
> +nfsd_file_put_local(struct nfsd_file *nf)
>  {
>  	struct net *net =3D nf->nf_net;
> =20
>  	nfsd_file_put(nf);
> -	nfsd_serv_put(net);
> +	return net;
>  }
> =20
>  /**
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index cadf3c2689c4..d5db6b34ba30 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -55,7 +55,7 @@ void nfsd_file_cache_shutdown(void);
>  int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
> -void nfsd_file_put_local(struct nfsd_file *nf);
> +struct net *nfsd_file_put_local(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 3982fea79919..9202f4b24343 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -55,7 +55,7 @@ struct nfsd_localio_operations {
>  						const struct cred *,
>  						const struct nfs_fh *,
>  						const fmode_t);
> -	void (*nfsd_file_put_local)(struct nfsd_file *);
> +	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
>  } ____cacheline_aligned;
> =20
> @@ -66,7 +66,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
>  		   struct rpc_clnt *, const struct cred *,
>  		   const struct nfs_fh *, const fmode_t);
> =20
> -static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
> +static inline void nfs_to_nfsd_net_put(struct net *net)
>  {
>  	/*
>  	 * Once reference to nfsd_serv is dropped, NFSD could be
> @@ -74,10 +74,22 @@ static inline void nfs_to_nfsd_file_put_local(struct =
nfsd_file *localio)
>  	 * by always taking RCU.
>  	 */
>  	rcu_read_lock();
> -	nfs_to->nfsd_file_put_local(localio);
> +	nfs_to->nfsd_serv_put(net);
>  	rcu_read_unlock();
>  }
> =20
> +static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
> +{
> +	/*
> +	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
> +	 * "Voluntary context switch within RCU read-side critical section!"
> +	 * by scheduling deep in underlying filesystem (e.g. XFS).
> +	 */
> +	struct net *net =3D nfs_to->nfsd_file_put_local(localio);
> +
> +	nfs_to_nfsd_net_put(net);
> +}
> +
>  #else   /* CONFIG_NFS_LOCALIO */
>  static inline void nfsd_localio_ops_init(void)
>  {

I think this probably needs to go into v6.12 (or very early into v6.13
and backported). It should also probably get:

    Fixes: 65f2a5c36635 ("nfs_common: fix race in NFS calls to nfsd_file_pu=
t_local() and nfsd_serv_put()")

You can also add:

    Reviewed-by: Jeff Layton <jlayton@kernel.org>

