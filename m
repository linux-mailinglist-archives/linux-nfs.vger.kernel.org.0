Return-Path: <linux-nfs+bounces-4065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC9690EB45
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EF41C21876
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88614262C;
	Wed, 19 Jun 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAD8Gv6A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63D1422A2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800788; cv=none; b=MK9tLfBSUyuySKc3CxmxOvcv3Bv/fzalLppZN/+chdLm8soNaDUvgtrhzgtMIDxhiZl25PZ/GFLbGdOZzpjM+EjGij0x1uzQmL4Ye7bFlDbZSOeOd9vhTDVsCVr1/Nlle57CdX8OYLxgv0gTl8HmIV/1pjjZErEu/LtRQdvB56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800788; c=relaxed/simple;
	bh=MUvv7rPIxB3ThTSTeq+bYVweifzbGkSNtF/fstA1M1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eay2LEXUSRIEteQq/plUvJrvtS1J3E+36sDvoxOSyUFuj3PlB0nzqqbgdL3UExy6ruqdwkQEDW6TTDGX79xqJTtSLEjg4hYlMMnb1A9uTNg2CYJGctCHZ8IlyGmw9iXfyeNB3rnfGuhNAz7/MdsOumofmkb+dFI1c99/k8IvZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAD8Gv6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D78C2BBFC;
	Wed, 19 Jun 2024 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718800788;
	bh=MUvv7rPIxB3ThTSTeq+bYVweifzbGkSNtF/fstA1M1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BAD8Gv6A4w/lYNwzTpPpHtHYPQk3W60fFRVKudK/ztUsHaWGT9W44DGg0ijLVwWqL
	 0i8/DpszKU7fUoNDgYxhZWget5luA/8a+Smmh8JwD/MyCAxKkKHOLyWioX36f4Tb7t
	 tHQy/l9y7PpPMb1HaFtBfu8G8wkOr3CfHAyNCYNzhM+xfGPIYfL2d13vtL7+LGqOwt
	 7y96eQWxfNPNMiWT9Z5Bb42bsCCyE0HA3+FXod2FLTyXqDSFbCbDVmDCkOYNpGMV2T
	 HcDiTgW4z1KG032h2o+jvDXQ2m11galhNhSZozWRlE/Na/v7lNImmXtidDp+JA0Xjs
	 nz3MPlAkdU1ow==
Message-ID: <808b8e465430e66b5b3c3bf048a3a165ba41231b.camel@kernel.org>
Subject: Re: [PATCH v5 16/19] nfsd: use SRCU to dereference nn->nfsd_serv
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Wed, 19 Jun 2024 08:39:46 -0400
In-Reply-To: <20240618201949.81977-17-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
	 <20240618201949.81977-17-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 16:19 -0400, Mike Snitzer wrote:
> Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
> the nfsd code to prevent nfsd_destroy_serv from destroying
> nn->nfsd_serv until all nfsd code is done with it (particularly the
> localio code that doesn't run in the context of nfsd's svc threads,
> nor does it take the nfsd_mutex).
>=20
> Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
> familiar well-worn pattern for how implement.
>=20
> Suggested-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/filecache.c | 13 ++++++++---
>  fs/nfsd/netns.h     | 12 ++++++++--
>  fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
>  fs/nfsd/nfsctl.c    |  7 ++++--
>  fs/nfsd/nfssvc.c    | 55 ++++++++++++++++++++++++++++++++++++---------
>  5 files changed, 87 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 99631fa56662..474b3a3af3fb 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
>  		struct nfsd_file *nf =3D list_first_entry(dispose,
>  						struct nfsd_file, nf_lru);
>  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +		int srcu_idx;
> +		struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
>  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> =20
>  		spin_lock(&l->lock);
>  		list_move_tail(&nf->nf_lru, &l->freeme);
>  		spin_unlock(&l->lock);
> -		svc_wake_up(nn->nfsd_serv);
> +		svc_wake_up(serv);
> +		nfsd_serv_put(nn, srcu_idx);
>  	}
>  }
> =20
> @@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
>  		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
>  			list_move(l->freeme.next, &dispose);
>  		spin_unlock(&l->lock);
> -		if (!list_empty(&l->freeme))
> +		if (!list_empty(&l->freeme)) {
> +			int srcu_idx;
> +			struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
>  			/* Wake up another thread to share the work
>  			 * *before* doing any actual disposing.
>  			 */
> -			svc_wake_up(nn->nfsd_serv);
> +			svc_wake_up(serv);
> +			nfsd_serv_put(nn, srcu_idx);
> +		}
>  		nfsd_file_dispose_list(&dispose);
>  	}
>  }
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 0c5a1d97e4ac..0eebcc03bcd3 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -139,8 +139,12 @@ struct nfsd_net {
>  	u32 clverifier_counter;
> =20
>  	struct svc_info nfsd_info;
> -#define nfsd_serv nfsd_info.serv
> -
> +	/*
> +	 * The current 'nfsd_serv' at nfsd_info.serv
> +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> +	 */
> +	void __rcu *nfsd_serv;

I don't understand why you need a void pointer here. This should only
ever hold a pointer to the serv or NULL. It seems like this work just
as well:=20

	struct svc_serv __rcu *nfsd_serv;



> +	struct srcu_struct nfsd_serv_srcu;
> =20
>  	/*
>  	 * clientid and stateid data for construction of net unique COPY
> @@ -225,6 +229,10 @@ struct nfsd_net {
>  extern bool nfsd_support_version(int vers);
>  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> =20
> +extern struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx=
);
> +extern void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx);
> +extern void nfsd_serv_sync(struct nfsd_net *nn);
> +
>  extern unsigned int nfsd_net_id;
> =20
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..8876810e569d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1919,6 +1919,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
>  	u32 num =3D ca->maxreqs;
>  	unsigned long avail, total_avail;
>  	unsigned int scale_factor;
> +	int srcu_idx;
> +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> =20
>  	spin_lock(&nfsd_drc_lock);
>  	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> @@ -1940,7 +1942,7 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
>  	 * Give the client one slot even if that would require
>  	 * over-allocation--it is better than failure.
>  	 */
> -	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> +	scale_factor =3D max_t(unsigned int, 8, serv->sv_nrthreads);
> =20
>  	avail =3D clamp_t(unsigned long, avail, slotsize,
>  			total_avail/scale_factor);
> @@ -1949,6 +1951,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
>  	nfsd_drc_mem_used +=3D num * slotsize;
>  	spin_unlock(&nfsd_drc_lock);
> =20
> +	nfsd_serv_put(nn, srcu_idx);
> +
>  	return num;
>  }
> =20
> @@ -3702,12 +3706,16 @@ nfsd4_replay_create_session(struct nfsd4_create_s=
ession *cr_ses,
> =20
>  static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, st=
ruct nfsd_net *nn)
>  {
> -	u32 maxrpc =3D nn->nfsd_serv->sv_max_mesg;
> +	int srcu_idx;
> +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> +	u32 maxrpc =3D serv->sv_max_mesg;
> +	__be32 status =3D nfs_ok;
> =20
> -	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ)
> -		return nfserr_toosmall;
> -	if (ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ)
> -		return nfserr_toosmall;
> +	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ ||
> +	    ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ) {
> +		status =3D nfserr_toosmall;
> +		goto out;
> +	}
>  	ca->headerpadsz =3D 0;
>  	ca->maxreq_sz =3D min_t(u32, ca->maxreq_sz, maxrpc);
>  	ca->maxresp_sz =3D min_t(u32, ca->maxresp_sz, maxrpc);
> @@ -3726,8 +3734,9 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
>  	 * accounting is soft and provides no guarantees either way.
>  	 */
>  	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> -
> -	return nfs_ok;
> +out:
> +	nfsd_serv_put(nn, srcu_idx);
> +	return status;
>  }
> =20
>  /*
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1bddbbf7418e..2d4c29c25c6a 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1569,10 +1569,12 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
>  {
>  	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
>  	int i, ret, rqstp_index =3D 0;
> +	int srcu_idx;
> +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> =20
>  	rcu_read_lock();
> =20
> -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < serv->sv_nrpools; i++) {
>  		struct svc_rqst *rqstp;
> =20
>  		if (i < cb->args[0]) /* already consumed */
> @@ -1580,7 +1582,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> =20
>  		rqstp_index =3D 0;
>  		list_for_each_entry_rcu(rqstp,
> -				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				&serv->sv_pools[i].sp_all_threads,
>  				rq_all) {
>  			struct nfsd_genl_rqstp genl_rqstp;
>  			unsigned int status_counter;
> @@ -1645,6 +1647,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
>  	ret =3D skb->len;
>  out:
>  	rcu_read_unlock();
> +	nfsd_serv_put(nn, srcu_idx);
> =20
>  	return ret;
>  }
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index bfc58001dd9a..f84530f95eb8 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -300,6 +300,26 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minor=
version, enum vers_op change
>  	return 0;
>  }
> =20
> +struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx)
> +	__acquires(nn->nfsd_serv_srcu)
> +{
> +	*srcu_idx =3D srcu_read_lock(&nn->nfsd_serv_srcu);
> +
> +	return srcu_dereference(nn->nfsd_serv, &nn->nfsd_serv_srcu);
> +}
> +
> +void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx)
> +	__releases(nn->nfsd_serv_srcu)
> +{
> +	srcu_read_unlock(&nn->nfsd_serv_srcu, srcu_idx);
> +}
> +
> +void nfsd_serv_sync(struct nfsd_net *nn)
> +{
> +	synchronize_srcu(&nn->nfsd_serv_srcu);
> +	synchronize_rcu_expedited();
> +}
> +
>  /*
>   * Maximum number of nfsd processes
>   */
> @@ -507,6 +527,7 @@ static void nfsd_shutdown_net(struct net *net)
>  		lockd_down(net);
>  		nn->lockd_up =3D false;
>  	}
> +	cleanup_srcu_struct(&nn->nfsd_serv_srcu);
>  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
>  	list_del_rcu(&nn->nfsd_uuid.list);
>  #endif
> @@ -514,6 +535,7 @@ static void nfsd_shutdown_net(struct net *net)
>  	nfsd_shutdown_generic();
>  }
> =20
> +// FIXME: eliminate nfsd_notifier_lock
>  static DEFINE_SPINLOCK(nfsd_notifier_lock);
>  static int nfsd_inetaddr_event(struct notifier_block *this, unsigned lon=
g event,
>  	void *ptr)
> @@ -523,20 +545,22 @@ static int nfsd_inetaddr_event(struct notifier_bloc=
k *this, unsigned long event,
>  	struct net *net =3D dev_net(dev);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct sockaddr_in sin;
> +	int srcu_idx;
> +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> =20
> -	if (event !=3D NETDEV_DOWN || !nn->nfsd_serv)
> +	if (event !=3D NETDEV_DOWN || !serv)
>  		goto out;
> =20
>  	spin_lock(&nfsd_notifier_lock);
> -	if (nn->nfsd_serv) {
> +	if (serv) {
>  		dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
>  		sin.sin_family =3D AF_INET;
>  		sin.sin_addr.s_addr =3D ifa->ifa_local;
> -		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin);
> +		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin);
>  	}
>  	spin_unlock(&nfsd_notifier_lock);
> -
>  out:
> +	nfsd_serv_put(nn, srcu_idx);
>  	return NOTIFY_DONE;
>  }
> =20
> @@ -553,22 +577,24 @@ static int nfsd_inet6addr_event(struct notifier_blo=
ck *this,
>  	struct net *net =3D dev_net(dev);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct sockaddr_in6 sin6;
> +	int srcu_idx;
> +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> =20
> -	if (event !=3D NETDEV_DOWN || !nn->nfsd_serv)
> +	if (event !=3D NETDEV_DOWN || !serv)
>  		goto out;
> =20
>  	spin_lock(&nfsd_notifier_lock);
> -	if (nn->nfsd_serv) {
> +	if (serv) {
>  		dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
>  		sin6.sin6_family =3D AF_INET6;
>  		sin6.sin6_addr =3D ifa->addr;
>  		if (ipv6_addr_type(&sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
>  			sin6.sin6_scope_id =3D ifa->idev->dev->ifindex;
> -		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin6);
> +		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin6);
>  	}
>  	spin_unlock(&nfsd_notifier_lock);
> -
>  out:
> +	nfsd_serv_put(nn, srcu_idx);
>  	return NOTIFY_DONE;
>  }
> =20
> @@ -589,9 +615,12 @@ void nfsd_destroy_serv(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;
> =20
> +	lockdep_assert_held(&nfsd_mutex);
> +
>  	spin_lock(&nfsd_notifier_lock);
> -	nn->nfsd_serv =3D NULL;
> +	rcu_assign_pointer(nn->nfsd_serv, NULL);
>  	spin_unlock(&nfsd_notifier_lock);
> +	nfsd_serv_sync(nn);
> =20
>  	/* check if the notifier still has clients */
>  	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> @@ -711,6 +740,10 @@ int nfsd_create_serv(struct net *net)
>  	if (nn->nfsd_serv)
>  		return 0;
> =20
> +	error =3D init_srcu_struct(&nn->nfsd_serv_srcu);
> +	if (error)
> +		return error;
> +
>  	if (nfsd_max_blksize =3D=3D 0)
>  		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> @@ -727,8 +760,10 @@ int nfsd_create_serv(struct net *net)
>  	}
>  	spin_lock(&nfsd_notifier_lock);
>  	nn->nfsd_info.mutex =3D &nfsd_mutex;
> -	nn->nfsd_serv =3D serv;
> +	nn->nfsd_info.serv =3D serv;
> +	rcu_assign_pointer(nn->nfsd_serv, nn->nfsd_info.serv);
>  	spin_unlock(&nfsd_notifier_lock);
> +	nfsd_serv_sync(nn);

I get why you're doing the synchronize on destroy, but why on the
create? You're not tearing anything down here, so I don't see the need
to ensure synchronization.

> =20
>  	set_max_drc();
>  	/* check if the notifier is already set */

--=20
Jeff Layton <jlayton@kernel.org>

