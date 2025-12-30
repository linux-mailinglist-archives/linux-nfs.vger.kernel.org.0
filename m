Return-Path: <linux-nfs+bounces-17358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F0CEAD99
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 341563023566
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CB28725A;
	Tue, 30 Dec 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="G5MIUer2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0EWGAVk3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB7242D9D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136537; cv=none; b=sZdlEyQvy8aKIytzKsQ7P3OGhvdoGaFahhqdULhwHQWA17scnBKIXBjo3PiQFX+1AMoP5bzIP61LiHbRRx7oP2RYDk1ktfOJ3OEXNRfKOP7Y6Z2AYrZuXG9kLLaw1mZx9hMFIml194F8uUOc8aObr4hWBUIPU8ullCZ7dVcWfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136537; c=relaxed/simple;
	bh=h8IupEO4pAmwZkcYsLFlyibK21M2WHK1f4vh1thmB3Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oYVRgBDuPyE8m0uGKx6n3cDAOTJ8t6d/QjTy7s4VrgZo8GA6qxNMXFTQAPY7rCMjFm2zf0BqGrTD9KZi+YnCgE/tEvBkotkzQ2X8aCBiCYzuhHtBil0bsHlhHHYXfinzsj/4Bsm3dxEmgtWggzdrQZhorGqWNQrK7gvqNPN+nRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=G5MIUer2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0EWGAVk3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30F4D7A0115;
	Tue, 30 Dec 2025 18:15:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 18:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767136533; x=1767222933; bh=WFn+naLgHhGHFRF9Ak4JDXdBX6ytpBzEyTq
	HpZDvZic=; b=G5MIUer2i4CvnFibrctU2zSvOqr5EI4LGaL5G9Ri2Pufg+sXLCD
	atTna8LuPG5TJrxh84bHTJfaxLrS1u3iY9umtOp/+u+hYHSqCVxaYL4cA90mxoye
	nRxrcf38+NC9LruxrEf/MB7TwAElOLd9Zs6NfndCzJkeOuDcdOqnLau1Xxb17uCz
	BVtSS0TPxTR/wFEKHj4bxU5goTh2UOYHz753N28l5LrSpOU6xPa91a8SkpLFdPnV
	NGQ+vNc90Q+xogkmzQsswLPY6LnEtpu0gzAouUei0q1DZNSkXCd3u1ZDFr5Hnmvr
	iGOEETq5ZvibixofXvjxeSuLJwzkb/ngEFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767136533; x=
	1767222933; bh=WFn+naLgHhGHFRF9Ak4JDXdBX6ytpBzEyTqHpZDvZic=; b=0
	EWGAVk3nUdGFd1EizDyXcEbAUwMKIOttNwGpHu+Mm+CbriqnFLwa+pIIAvZYxcka
	EXcbPU386CdCYbgbFxzcZpcDhR5ylR4O9wv9s8eCBqMkzWzdK9YuZCWfFUrFdzqX
	N4BBZVXE0RJoIlUo2ZayWnIGkPvGrNY8f9+aiYlDF0qFOpG3STthW8g7/3QDf3M3
	bZW+F8jxTS9fkiC4S2KONM6Lc9de3aiUs5Dz46KQLI6vyHoEnqVmKLbN6aHnJ2KZ
	yChy6mRANOd6JN2UBO+cOvka9PUP7L1MxhUHH9fyagfUL1JhoSZcre7s7SXnUl3R
	eWh0AgLrVPTV0rB6hhdLA==
X-ME-Sender: <xms:FF1UaXd94V9ZGNLHSFbmHLJLASSahJvW8OXKAkvpzRdcteLzqHWSnQ>
    <xme:FF1UafdZPUSRcCYdIDfS9JETnjY6F3Qml0WUTm9_4snjgyKT27DUjH1fMvzEi8MFW
    DNPX9qU8ppulLaYQlGXtgn_ms6AoObYF-hap1_8FXxCdIxIogk>
X-ME-Received: <xmr:FF1UaSwU6zl20RQZnz7WimoGvww3ZG2CF5eQ7LCqrznuZe8QWv3rHo-4pImVTzSXS9XQU4GzuEDnBTeqbnXiR8aHKzs71QbILHtETft2EE4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FF1Uae-MdizRLTjhtJZgOLSSkERWz6pGmIWLcjDycXTbcU5iba-5AA>
    <xmx:FF1UaSiQIecLwDreI0MgdZQGR6HMglSzlq073HKpQWr5ep-lD_ceHA>
    <xmx:FF1UadGw-3caSc8jTSonBjwkSAwuv3M2hsHpV5xADlX9N_SLWHwBGA>
    <xmx:FF1UaZ9qjOl1gLL71jsm8yLatXs-wA3CfZXakIfXKIs2W2d4pDFaEQ>
    <xmx:FV1UaXI66xqh74_C_WqAUyr0PKBCLc8oS7uuy98LGXx3ZARPrAPmY9Sr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 18:15:30 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/5] nfsd: cancel async COPY operations when admin
 revokes filesystem state
In-reply-to: <20251230141838.2547848-2-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>,
 <20251230141838.2547848-2-cel@kernel.org>
Date: Wed, 31 Dec 2025 10:15:26 +1100
Message-id: <176713652656.16766.17959324318084171169@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Async COPY operations hold copy stateids that represent NFSv4 state.
> Thus, when the NFS server administrator revokes all NFSv4 state for
> a filesystem via the unlock_fs interface, ongoing async COPY
> operations referencing that filesystem must also be canceled.
>=20
> Each cancelled copy triggers a CB_OFFLOAD callback carrying the
> NFS4ERR_ADMIN_REVOKED status to notify the client that the server
> terminated the operation.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

This all looks sensible.  Mentioning in commit message that
drop_client() was being renamed to nfsd4_put_client() might have saved
me one pass through the patch, but it quickly became obvious that was
happening.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>  fs/nfsd/nfs4proc.c  | 124 ++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4state.c |  20 ++++---
>  fs/nfsd/nfsctl.c    |   1 +
>  fs/nfsd/state.h     |   2 +
>  fs/nfsd/xdr4.h      |   1 +
>  5 files changed, 130 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2b805fc51262..e7ec87b6c331 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1427,14 +1427,26 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
>  	kfree(copy);
>  }
> =20
> +static void release_copy_files(struct nfsd4_copy *copy);
> +
>  static void nfsd4_stop_copy(struct nfsd4_copy *copy)
>  {
>  	trace_nfsd_copy_async_cancel(copy);
>  	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
>  		kthread_stop(copy->copy_task);
> -		copy->nfserr =3D nfs_ok;
> +		if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
> +			copy->nfserr =3D nfs_ok;
>  		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>  	}
> +
> +	/*
> +	 * The copy was removed from async_copies before this function
> +	 * was called, so the reaper cannot clean it up. Release files
> +	 * here regardless of who won the STOPPED race. If the thread
> +	 * set STOPPED, it has finished using the files. If STOPPED
> +	 * was set here, kthread_stop() waited for the thread to exit.
> +	 */
> +	release_copy_files(copy);
>  	nfs4_put_copy(copy);
>  }
> =20
> @@ -1462,6 +1474,72 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
>  	while ((copy =3D nfsd4_unhash_copy(clp)) !=3D NULL)
>  		nfsd4_stop_copy(copy);
>  }
> +
> +static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
> +			     const struct super_block *sb)
> +{
> +	if (copy->nf_src &&
> +	    file_inode(copy->nf_src->nf_file)->i_sb =3D=3D sb)
> +		return true;
> +	if (copy->nf_dst &&
> +	    file_inode(copy->nf_dst->nf_file)->i_sb =3D=3D sb)
> +		return true;
> +	return false;
> +}
> +
> +/**
> + * nfsd4_cancel_copy_by_sb - cancel async copy operations on @sb
> + * @net: net namespace containing the copy operations
> + * @sb: targeted superblock
> + */
> +void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfsd4_copy *copy, *tmp;
> +	struct nfs4_client *clp;
> +	unsigned int idhashval;
> +	LIST_HEAD(to_cancel);
> +
> +	spin_lock(&nn->client_lock);
> +	for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
> +		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
> +
> +		list_for_each_entry(clp, head, cl_idhash) {
> +			spin_lock(&clp->async_lock);
> +			list_for_each_entry_safe(copy, tmp,
> +						 &clp->async_copies, copies) {
> +				if (nfsd4_copy_on_sb(copy, sb)) {
> +					refcount_inc(&copy->refcount);
> +					/*
> +					 * Hold a reference on the client while
> +					 * nfsd4_stop_copy() runs. Unlike
> +					 * nfsd4_unhash_copy(), cp_clp is not
> +					 * NULLed here because nfsd4_send_cb_offload()
> +					 * needs a valid client to send CB_OFFLOAD.
> +					 * That function takes its own reference to
> +					 * survive callback flight.
> +					 */
> +					kref_get(&clp->cl_nfsdfs.cl_ref);
> +					copy->nfserr =3D nfserr_admin_revoked;
> +					set_bit(NFSD4_COPY_F_CB_ERROR,
> +						&copy->cp_flags);
> +					list_move(&copy->copies, &to_cancel);
> +				}
> +			}
> +			spin_unlock(&clp->async_lock);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +
> +	list_for_each_entry_safe(copy, tmp, &to_cancel, copies) {
> +		struct nfs4_client *clp =3D copy->cp_clp;
> +
> +		list_del_init(&copy->copies);
> +		nfsd4_stop_copy(copy);
> +		nfsd4_put_client(clp);
> +	}
> +}
> +
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> =20
>  extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> @@ -1751,6 +1829,7 @@ static void nfsd4_cb_offload_release(struct nfsd4_cal=
lback *cb)
>  		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
> =20
>  	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
> +	nfsd4_put_client(cb->cb_clp);
>  }
> =20
>  static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
> @@ -1870,10 +1949,14 @@ static void dup_copy_fields(struct nfsd4_copy *src,=
 struct nfsd4_copy *dst)
> =20
>  static void release_copy_files(struct nfsd4_copy *copy)
>  {
> -	if (copy->nf_src)
> +	if (copy->nf_src) {
>  		nfsd_file_put(copy->nf_src);
> -	if (copy->nf_dst)
> +		copy->nf_src =3D NULL;
> +	}
> +	if (copy->nf_dst) {
>  		nfsd_file_put(copy->nf_dst);
> +		copy->nf_dst =3D NULL;
> +	}
>  }
> =20
>  static void cleanup_async_copy(struct nfsd4_copy *copy)
> @@ -1892,18 +1975,34 @@ static void cleanup_async_copy(struct nfsd4_copy *c=
opy)
>  static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
>  {
>  	struct nfsd4_cb_offload *cbo =3D &copy->cp_cb_offload;
> +	struct nfs4_client *clp =3D copy->cp_clp;
> +
> +	/*
> +	 * cp_clp is NULL when called via nfsd4_shutdown_copy() during
> +	 * client destruction. Skip the callback; the client is gone.
> +	 */
> +	if (!clp) {
> +		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
> +		return;
> +	}
> =20
>  	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
>  	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
>  	cbo->co_nfserr =3D copy->nfserr;
>  	cbo->co_retries =3D 5;
> =20
> -	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
> +	/*
> +	 * Hold a reference on the client while the callback is in flight.
> +	 * Released in nfsd4_cb_offload_release().
> +	 */
> +	kref_get(&clp->cl_nfsdfs.cl_ref);
> +
> +	nfsd4_init_cb(&cbo->co_cb, clp, &nfsd4_cb_offload_ops,
>  		      NFSPROC4_CLNT_CB_OFFLOAD);
>  	nfsd41_cb_referring_call(&cbo->co_cb, &cbo->co_referring_sessionid,
>  				 cbo->co_referring_slotid,
>  				 cbo->co_referring_seqno);
> -	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
> +	trace_nfsd_cb_offload(clp, &cbo->co_res.cb_stateid,
>  			      &cbo->co_fh, copy->cp_count, copy->nfserr);
>  	nfsd4_try_run_cb(&cbo->co_cb);
>  }
> @@ -1918,6 +2017,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *=
copy)
>  static int nfsd4_do_async_copy(void *data)
>  {
>  	struct nfsd4_copy *copy =3D (struct nfsd4_copy *)data;
> +	__be32 nfserr =3D nfs_ok;
> =20
>  	trace_nfsd_copy_async(copy);
>  	if (nfsd4_ssc_is_inter(copy)) {
> @@ -1928,23 +2028,25 @@ static int nfsd4_do_async_copy(void *data)
>  		if (IS_ERR(filp)) {
>  			switch (PTR_ERR(filp)) {
>  			case -EBADF:
> -				copy->nfserr =3D nfserr_wrong_type;
> +				nfserr =3D nfserr_wrong_type;
>  				break;
>  			default:
> -				copy->nfserr =3D nfserr_offload_denied;
> +				nfserr =3D nfserr_offload_denied;
>  			}
>  			/* ss_mnt will be unmounted by the laundromat */
>  			goto do_callback;
>  		}
> -		copy->nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> -					     false);
> +		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> +				       false);
>  		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
>  	} else {
> -		copy->nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> -					     copy->nf_dst->nf_file, false);
> +		nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> +				       copy->nf_dst->nf_file, false);
>  	}
> =20
>  do_callback:
> +	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
> +		copy->nfserr =3D nfserr;
>  	/* The kthread exits forthwith. Ensure that a subsequent
>  	 * OFFLOAD_CANCEL won't try to kill it again. */
>  	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ea4d6eff0d2f..61f99bcce7f6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2413,7 +2413,13 @@ static void __free_client(struct kref *k)
>  	kmem_cache_free(client_slab, clp);
>  }
> =20
> -static void drop_client(struct nfs4_client *clp)
> +/**
> + * nfsd4_put_client - release a reference on an nfs4_client
> + * @clp: the client to be released
> + *
> + * When the last reference is released, the client is freed.
> + */
> +void nfsd4_put_client(struct nfs4_client *clp)
>  {
>  	kref_put(&clp->cl_nfsdfs.cl_ref, __free_client);
>  }
> @@ -2435,7 +2441,7 @@ free_client(struct nfs4_client *clp)
>  		clp->cl_nfsd_dentry =3D NULL;
>  		wake_up_all(&expiry_wq);
>  	}
> -	drop_client(clp);
> +	nfsd4_put_client(clp);
>  }
> =20
>  /* must be called under the client_lock */
> @@ -2833,7 +2839,7 @@ static int client_info_show(struct seq_file *m, void =
*v)
>  	spin_unlock(&clp->cl_lock);
>  	seq_puts(m, "\n");
> =20
> -	drop_client(clp);
> +	nfsd4_put_client(clp);
> =20
>  	return 0;
>  }
> @@ -3099,7 +3105,7 @@ static int client_states_open(struct inode *inode, st=
ruct file *file)
> =20
>  	ret =3D seq_open(file, &states_seq_ops);
>  	if (ret) {
> -		drop_client(clp);
> +		nfsd4_put_client(clp);
>  		return ret;
>  	}
>  	s =3D file->private_data;
> @@ -3113,7 +3119,7 @@ static int client_opens_release(struct inode *inode, =
struct file *file)
>  	struct nfs4_client *clp =3D m->private;
> =20
>  	/* XXX: alternatively, we could get/drop in seq start/stop */
> -	drop_client(clp);
> +	nfsd4_put_client(clp);
>  	return seq_release(inode, file);
>  }
> =20
> @@ -3169,7 +3175,7 @@ static ssize_t client_ctl_write(struct file *file, co=
nst char __user *buf,
>  	if (!clp)
>  		return -ENXIO;
>  	force_expire_client(clp);
> -	drop_client(clp);
> +	nfsd4_put_client(clp);
>  	return 7;
>  }
> =20
> @@ -3204,7 +3210,7 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp =3D cb->cb_clp;
> =20
> -	drop_client(clp);
> +	nfsd4_put_client(clp);
>  }
> =20
>  static int
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 04125917e635..6bf1acaddb04 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -285,6 +285,7 @@ static ssize_t write_unlock_fs(struct file *file, char =
*buf, size_t size)
>  	 * 2.  Is that directory a mount point, or
>  	 * 3.  Is that directory the root of an exported file system?
>  	 */
> +	nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
>  	error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
>  	mutex_lock(&nfsd_mutex);
>  	nn =3D net_generic(netns(file), nfsd_net_id);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 508b7e36d846..f1c1bac173a5 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -822,6 +822,8 @@ static inline void nfsd4_try_run_cb(struct nfsd4_callba=
ck *cb)
> =20
>  extern void nfsd4_shutdown_callback(struct nfs4_client *);
>  extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
> +void nfsd4_put_client(struct nfs4_client *clp);
> +void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
>  void nfsd4_async_copy_reaper(struct nfsd_net *nn);
>  bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
>  extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netob=
j name,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ae75846b3cd7..1be2814b5288 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -732,6 +732,7 @@ struct nfsd4_copy {
>  #define NFSD4_COPY_F_COMMITTED		(3)
>  #define NFSD4_COPY_F_COMPLETED		(4)
>  #define NFSD4_COPY_F_OFFLOAD_DONE	(5)
> +#define NFSD4_COPY_F_CB_ERROR		(6)
> =20
>  	/* response */
>  	__be32			nfserr;
> --=20
> 2.52.0
>=20
>=20


