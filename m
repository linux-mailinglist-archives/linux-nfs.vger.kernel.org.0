Return-Path: <linux-nfs+bounces-12906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286DCAF9FCA
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Jul 2025 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1BC3AC64A
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Jul 2025 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202992512D1;
	Sat,  5 Jul 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzjHbzy+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7D24DD07
	for <linux-nfs@vger.kernel.org>; Sat,  5 Jul 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714112; cv=none; b=mpeF9+lg4koxXLSyywpXuNLzJ0lZyfmMv4A3dnd3RvbIWYNfKPnkqT4GL/AdLhxgKwU66afPEEf7akwSeoZ+o5Wfa5SjOidEfo2BMAD0KFLfhGQQhH8w2LBYPe/9Wm1jF33Rm3TAEgGczzoTpJ0Dv/ARO0c4MUWrN1jFQONwY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714112; c=relaxed/simple;
	bh=YNf7HXFlvuNv3Z3FeMjDvtKPMu8ZgWdsWWb0qzCNEaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pv81TOAY/RqHaPHjHws0vnhtOJCIAYsGvRfl40bunLPhv3i8xwOMW8kM9CppCbHN2ZjN+EnSR66ieT6rz7rwNh20PrI3dfh5E+2LAq10C7UWQ6mYJLe/9bzmSodkAioqqEp83IyFqe+Jo5LRIrwULufH4U3+n5+xzTn2bq/+1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzjHbzy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81A7C4CEED;
	Sat,  5 Jul 2025 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714112;
	bh=YNf7HXFlvuNv3Z3FeMjDvtKPMu8ZgWdsWWb0qzCNEaY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dzjHbzy+Nf09QdPZxjk35pr4H1UDxbTt4RerWsfPkqo7wKItPVoFyVgq+bSnTbIaM
	 6KY5iIlF/EygPlD8aP9ZssanYF5AyOt4/8XaLONjb2tX5aQJzrX+qfGRGsrbcEyIFp
	 smdcTjJlHxprek/v56p9MMTWk98mj4FmiLg9xGtS6vGx1XCNYDfX5GFYP7k/ZRhd+y
	 5z/X48pVAY4PEvjbFL6PEBY54Di4+ZF5uQ1aHsqeFXqW+r8S95IYH4yDDhw2HUjhrk
	 avdAVFBFa9AxT84PYy2obtVELKrQdg5ih1wxoJbiXregA3F1F7dD6PnAs5N1CCFlds
	 3+1X0gblIm8Jw==
Message-ID: <b7f95cbb80beb07dac509ab29ffd23411d1e1a03.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: provide locking for v4_end_grace
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Li Lingfeng	
 <lilingfeng3@huawei.com>
Date: Sat, 05 Jul 2025 07:15:10 -0400
In-Reply-To: <20250704072332.3278129-2-neil@brown.name>
References: <20250704072332.3278129-1-neil@brown.name>
	 <20250704072332.3278129-2-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 17:20 +1000, NeilBrown wrote:
> Writing to v4_end_grace can race with server shutdown and result in
> memory being accessed after it was freed - reclaim_str_hashtbl in
> particular.
>=20
> We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
> held while client_tracking_op->init() is called and that can wait for
> an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
> deadlock.
>=20
> nfsd4_end_grace() is also called by the landromat work queue and this
> doesn't require locking as server shutdown will stop the work and wait
> for it before freeing anything that nfsd4_end_grace() might access.
>=20
> However, we must be sure that writing to v4_end_grace doesn't restart
> the work item after shutdown has already waited for it.  For this we add
> a new flag protected with a spin_lock, and nn->client_lock is suitable.
> It is set only while it is safe to make client tracking calls, and
> v4_end_grace only schedules work while the flag is set and with the
> spin_lock held.
>=20
> So this patch adds an nfsd_net field "client_tracking_active" which is
> set as described.  Another field "grace_end_forced", is set when
> v4_end_grace is written.  After this is set, and providing
> client_tracking_active is set, the laundromat is scheduled.
> This "grace_end_forced" field bypasses other checks for whether the
> grace period has finished.
>=20
> This resolves a race which can result in use-after-free.
>=20
> Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/linux-nfs/20250513074305.3362209-1-liling=
feng3@huawei.com
> Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")
> Cc: stable@vger.kernel.org
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/netns.h     |  2 ++
>  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfsctl.c    |  6 +++---
>  fs/nfsd/state.h     |  2 +-
>  4 files changed, 49 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 3e2d0fde80a7..fe8338735e7c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -66,6 +66,8 @@ struct nfsd_net {
> =20
>  	struct lock_manager nfsd4_manager;
>  	bool grace_ended;
> +	bool grace_end_forced;
> +	bool client_tracking_active;

ISTM that the client_tracking_active bool is set and cleared similarly
to the nn->client_tracking_ops pointer itself. It _might_ be possible
to eliminate this bool and just use that pointer instead, though they
are not exactly cleared at the same time.

>  	time64_t boot_time;
> =20
>  	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86f..124fe4f669aa 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -84,7 +84,7 @@ static u64 current_sessionid =3D 1;
>  /* forward declarations */
>  static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner =
*lowner);
>  static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +static void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cp=
ntf_state *cps);
>  static void nfsd4_file_hash_remove(struct nfs4_file *fi);
>  static void deleg_reaper(struct nfsd_net *nn);
> @@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	return nfs_ok;
>  }
> =20
> -void
> +static void
>  nfsd4_end_grace(struct nfsd_net *nn)
>  {
>  	/* do nothing if grace period already ended */
> @@ -6491,6 +6491,36 @@ nfsd4_end_grace(struct nfsd_net *nn)
>  	 */
>  }
> =20
> +/**
> + * nfsd4_force_end_grace - forcibly end the grace period
> + * @nn: nfsd_net in which the grace period must end.
> + *
> + *
> + * An nfsv4 grace period can be terminated early if it is known that
> + * no more client could reclaim state.  Sometimes user-space can provide
> + * that information - which will potentially be provided asychnronously
> + * w.r.t. server startup or shutdown.
> + *
> + * nfsd4_force_end_grace() causing the grace period to end and takes
> + * care to ensure races with server start/stop are not problematic.
> + *
> + * Return value:  %false if the NFS server was not active and
> + *      %true if the server was, or may have been, active.
> + */
> +bool
> +nfsd4_force_end_grace(struct nfsd_net *nn)
> +{
> +	if (!nn->client_tracking_ops)
> +		return false;
> +	spin_lock(&nn->client_lock);
> +	if (nn->client_tracking_active) {
> +		nn->grace_end_forced =3D true;
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	}
> +	spin_unlock(&nn->client_lock);
> +	return true;
> +}
> +
>  /*
>   * If we've waited a lease period but there are still clients trying to
>   * reclaim, wait a little longer to give them a chance to finish.
> @@ -6500,6 +6530,8 @@ static bool clients_still_reclaiming(struct nfsd_ne=
t *nn)
>  	time64_t double_grace_period_end =3D nn->boot_time +
>  					   2 * nn->nfsd4_lease;
> =20
> +	if (nn->grace_end_forced)
> +		return false;
>  	if (nn->track_reclaim_completes &&
>  			atomic_read(&nn->nr_reclaim_complete) =3D=3D
>  			nn->reclaim_str_hashtbl_size)
> @@ -8807,6 +8839,8 @@ static int nfs4_state_create_net(struct net *net)
>  	nn->unconf_name_tree =3D RB_ROOT;
>  	nn->boot_time =3D ktime_get_real_seconds();
>  	nn->grace_ended =3D false;
> +	nn->grace_end_forced =3D false;
> +	nn->client_tracking_active =3D false;
>  	nn->nfsd4_manager.block_opens =3D true;
>  	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>  	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8887,6 +8921,10 @@ nfs4_state_start_net(struct net *net)
>  		return ret;
>  	locks_start_grace(net, &nn->nfsd4_manager);
>  	nfsd4_client_tracking_init(net);
> +	/* safe for laundromat to run now */
> +	spin_lock(&nn->client_lock);
> +	nn->client_tracking_active =3D true;
> +	spin_unlock(&nn->client_lock);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size =3D=3D =
0)
>  		goto skip_grace;
>  	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -8935,6 +8973,9 @@ nfs4_state_shutdown_net(struct net *net)
> =20
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
> +	spin_lock(&nn->client_lock);
> +	nn->client_tracking_active =3D false;
> +	spin_unlock(&nn->client_lock);
>  	cancel_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..658f3f86a59f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1082,10 +1082,10 @@ static ssize_t write_v4_end_grace(struct file *fi=
le, char *buf, size_t size)
>  		case 'Y':
>  		case 'y':
>  		case '1':
> -			if (!nn->nfsd_serv)
> -				return -EBUSY;
>  			trace_nfsd_end_grace(netns(file));
> -			nfsd4_end_grace(nn);
> +			if (!nfsd4_force_end_grace(nn))
> +				return -EBUSY;
> +
>  			break;
>  		default:
>  			return -EINVAL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1995bca158b8..05eabc69de40 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *ne=
t, struct super_block *sb)
>  #endif
> =20
>  /* grace period management */
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +bool nfsd4_force_end_grace(struct nfsd_net *nn);
> =20
>  /* nfs4recover operations */
>  extern int nfsd4_client_tracking_init(struct net *net);

The patch itself and the new bool are fine though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

