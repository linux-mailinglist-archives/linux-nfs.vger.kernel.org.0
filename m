Return-Path: <linux-nfs+bounces-7992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE869CD5C1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 04:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57175282688
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D06537FF;
	Fri, 15 Nov 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M0O4fxXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kX4drUT9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M0O4fxXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kX4drUT9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B483224FA
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640381; cv=none; b=BMVtH6mtLzXx/0QSWH7wgty4+025o3q9lULBCOY00xFlx9fjdazUFTls5y1b7yj+L1jrTRt0Ws8N/gTRu9jW3+r3rbuxafnofNvqlbo1htpfNEW3NCt8dVfsLr5keIW8KbBMuD2dEZeLxd0yi1w/sfiGoV3MPQoDOMGKy6h+xPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640381; c=relaxed/simple;
	bh=m1iZnZg20zi3URmfFlFEABDZO+XrAoVTFSR2uURPOEY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tOQOA+SP+fpGO/Vlx3c6uVFp4NYnRC23ChTHC+LbB0WGHdl184UJVxfAFeAX1nDKbk8h6f0ctuezNOiTDeAa2cs9R3GI56EaJ6eBomx+keZQMwmQupBEq2H2RaGTNWfm5jaaD7RVxQkgF+EuTU/TMfTbk5nl258k5alruEquuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M0O4fxXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kX4drUT9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M0O4fxXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kX4drUT9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F4221907;
	Fri, 15 Nov 2024 03:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731640376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZtvHeNUWdToSQaFXACUOLlfpnaeMn36kkakdyFYUGg=;
	b=M0O4fxXo3yy8fJ58mqTLlVkfR918tfWD3BYx+zU0gJ+bqoCCvK/IDw3zTzN4pZ5ohMrRrY
	ieeybfH57b6axZYZ1Tc/goszejKvC3HEnJeX9FJkwCyRvA4v4gOybwGGZcnBKwg0lTNp7n
	9OI5/JUGuQ2q/E1PgHIPIPnxM/1QaJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731640376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZtvHeNUWdToSQaFXACUOLlfpnaeMn36kkakdyFYUGg=;
	b=kX4drUT9njxAjt1vYOtT3Th2jm/C06OL8Ccez/nfdoEc1VmVdbA5WlYs4O0XY0ZnhOXPnQ
	6PSWd04YB7/lVXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731640376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZtvHeNUWdToSQaFXACUOLlfpnaeMn36kkakdyFYUGg=;
	b=M0O4fxXo3yy8fJ58mqTLlVkfR918tfWD3BYx+zU0gJ+bqoCCvK/IDw3zTzN4pZ5ohMrRrY
	ieeybfH57b6axZYZ1Tc/goszejKvC3HEnJeX9FJkwCyRvA4v4gOybwGGZcnBKwg0lTNp7n
	9OI5/JUGuQ2q/E1PgHIPIPnxM/1QaJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731640376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZtvHeNUWdToSQaFXACUOLlfpnaeMn36kkakdyFYUGg=;
	b=kX4drUT9njxAjt1vYOtT3Th2jm/C06OL8Ccez/nfdoEc1VmVdbA5WlYs4O0XY0ZnhOXPnQ
	6PSWd04YB7/lVXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C05D913485;
	Fri, 15 Nov 2024 03:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DqaDHTW8Nme5VwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Nov 2024 03:12:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH v2 06/15] nfs: cache all open LOCALIO
 nfsd_file(s) in client
In-reply-to: <20241114035952.13889-7-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>,
 <20241114035952.13889-7-snitzer@kernel.org>
Date: Fri, 15 Nov 2024 14:12:46 +1100
Message-id: <173164036674.1734440.14888275520804852973@noble.neil.brown.name>
X-Spam-Score: -4.27
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.855];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024, Mike Snitzer wrote:
> This commit switches from leaning heavily on NFSD's filecache (in
> terms of GC'd nfsd_files) back to caching nfsd_files in the
> client. A later commit will add the callback mechanism needed to
> allow NFSD to force the NFS client to cleanup all caches files.
>=20
> Add nfs_fh_localio_init() and 'struct nfs_fh_localio' to cache opened
> nfsd_file(s) (both a RO and RW nfsd_file is able to be opened and
> cached for a given nfs_fh).
>=20
> Update nfs_local_open_fh() to cache the nfsd_file once it is opened
> using __nfs_local_open_fh().
>=20
> Introduce nfs_close_local_fh() to clear the cached open nfsd_files and
> call nfs_to_nfsd_file_put_local().
>=20
> Refcounting is such that:
> - nfs_local_open_fh() is paired with nfs_close_local_fh().
> - __nfs_local_open_fh() is paired with nfs_to_nfsd_file_put_local().
> - nfs_local_file_get() is paired with nfs_local_file_put().
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c | 29 +++++----
>  fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
>  fs/nfs/inode.c                         |  3 +
>  fs/nfs/internal.h                      |  4 +-
>  fs/nfs/localio.c                       | 89 +++++++++++++++++++++-----
>  fs/nfs/pagelist.c                      |  5 +-
>  fs/nfs/write.c                         |  3 +-
>  fs/nfs_common/nfslocalio.c             | 52 ++++++++++++++-
>  include/linux/nfs_fs.h                 | 22 ++++++-
>  include/linux/nfslocalio.h             | 18 +++---
>  10 files changed, 181 insertions(+), 45 deletions(-)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout=
/flexfilelayout.c
> index f78115c6c2c12..451f168d882be 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -164,18 +164,17 @@ decode_name(struct xdr_stream *xdr, u32 *id)
>  }
> =20
>  static struct nfsd_file *
> -ff_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
> +		 struct nfs_client *clp, const struct cred *cred,
>  		 struct nfs_fh *fh, fmode_t mode)
>  {
> -	if (mode & FMODE_WRITE) {
> -		/*
> -		 * Always request read and write access since this corresponds
> -		 * to a rw layout.
> -		 */
> -		mode |=3D FMODE_READ;
> -	}
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	struct nfs4_ff_layout_mirror *mirror =3D FF_LAYOUT_COMP(lseg, ds_idx);
> =20
> -	return nfs_local_open_fh(clp, cred, fh, mode);
> +	return nfs_local_open_fh(clp, cred, fh, &mirror->nfl, mode);
> +#else
> +	return NULL;
> +#endif
>  }
> =20
>  static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
> @@ -247,6 +246,9 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mi=
rror(gfp_t gfp_flags)
>  		spin_lock_init(&mirror->lock);
>  		refcount_set(&mirror->ref, 1);
>  		INIT_LIST_HEAD(&mirror->mirrors);
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +		nfs_localio_file_init(&mirror->nfl);
> +#endif

Can we make nfs_localio_file_init() a #define in the no-NFS_LOCALIO
case, we don't need the #if.
(every time you write #if in a .c file think to your self "Neil will
hate this".  See also coding-style.rst. 21) Conditional Compilation.


>  	}
>  	return mirror;
>  }
> @@ -257,6 +259,9 @@ static void ff_layout_free_mirror(struct nfs4_ff_layout=
_mirror *mirror)
> =20
>  	ff_layout_remove_mirror(mirror);
>  	kfree(mirror->fh_versions);
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	nfs_close_local_fh(&mirror->nfl);
> +#endif
>  	cred =3D rcu_access_pointer(mirror->ro_cred);
>  	put_cred(cred);
>  	cred =3D rcu_access_pointer(mirror->rw_cred);
> @@ -1820,7 +1825,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
>  	hdr->mds_offset =3D offset;
> =20
>  	/* Start IO accounting for local read */
> -	localio =3D ff_local_open_fh(ds->ds_clp, ds_cred, fh, FMODE_READ);
> +	localio =3D ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh, FMODE_RE=
AD);
>  	if (localio) {
>  		hdr->task.tk_start =3D ktime_get();
>  		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
> @@ -1896,7 +1901,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr,=
 int sync)
>  	hdr->args.offset =3D offset;
> =20
>  	/* Start IO accounting for local write */
> -	localio =3D ff_local_open_fh(ds->ds_clp, ds_cred, fh,
> +	localio =3D ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
>  				   FMODE_READ|FMODE_WRITE);
>  	if (localio) {
>  		hdr->task.tk_start =3D ktime_get();
> @@ -1981,7 +1986,7 @@ static int ff_layout_initiate_commit(struct nfs_commi=
t_data *data, int how)
>  		data->args.fh =3D fh;
> =20
>  	/* Start IO accounting for local commit */
> -	localio =3D ff_local_open_fh(ds->ds_clp, ds_cred, fh,
> +	localio =3D ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
>  				   FMODE_READ|FMODE_WRITE);
>  	if (localio) {
>  		data->task.tk_start =3D ktime_get();
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout=
/flexfilelayout.h
> index f84b3fb0dddd8..095df09017a57 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -83,6 +83,7 @@ struct nfs4_ff_layout_mirror {
>  	nfs4_stateid			stateid;
>  	const struct cred __rcu		*ro_cred;
>  	const struct cred __rcu		*rw_cred;
> +	struct nfs_file_localio		nfl;

This probably wants a #if around it though - it is in a .h after all.

>  	refcount_t			ref;
>  	spinlock_t			lock;
>  	unsigned long			flags;
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 596f351701372..1aa67fca69b2f 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1137,6 +1137,8 @@ struct nfs_open_context *alloc_nfs_open_context(struc=
t dentry *dentry,
>  	ctx->lock_context.open_context =3D ctx;
>  	INIT_LIST_HEAD(&ctx->list);
>  	ctx->mdsthreshold =3D NULL;
> +	nfs_localio_file_init(&ctx->nfl);
> +
>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
> @@ -1168,6 +1170,7 @@ static void __put_nfs_open_context(struct nfs_open_co=
ntext *ctx, int is_sync)
>  	nfs_sb_deactive(sb);
>  	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
>  	kfree(ctx->mdsthreshold);
> +	nfs_close_local_fh(&ctx->nfl);
>  	kfree_rcu(ctx, rcu_head);
>  }
> =20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 430733e3eff26..57af3ab3adbe5 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -459,6 +459,7 @@ extern void nfs_local_probe(struct nfs_client *);
>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
>  					   const struct cred *,
>  					   struct nfs_fh *,
> +					   struct nfs_file_localio *,
>  					   const fmode_t);
>  extern int nfs_local_doio(struct nfs_client *,
>  			  struct nfsd_file *,
> @@ -474,7 +475,8 @@ static inline void nfs_local_disable(struct nfs_client =
*clp) {}
>  static inline void nfs_local_probe(struct nfs_client *clp) {}
>  static inline struct nfsd_file *
>  nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> -		  struct nfs_fh *fh, const fmode_t mode)
> +		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
> +		  const fmode_t mode)
>  {
>  	return NULL;
>  }
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 7191135b47a42..7e432057c3a1f 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -211,27 +211,33 @@ void nfs_local_probe(struct nfs_client *clp)
>  }
>  EXPORT_SYMBOL_GPL(nfs_local_probe);
> =20
> +static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
> +{
> +	return nfs_to->nfsd_file_get(nf);
> +}
> +
> +static inline void nfs_local_file_put(struct nfsd_file *nf)
> +{
> +	nfs_to->nfsd_file_put(nf);
> +}
> +
>  /*
> - * nfs_local_open_fh - open a local filehandle in terms of nfsd_file
> + * __nfs_local_open_fh - open a local filehandle in terms of nfsd_file.
>   *
> - * Returns a pointer to a struct nfsd_file or NULL
> + * Returns a pointer to a struct nfsd_file or ERR_PTR.
> + * Caller must release returned nfsd_file with nfs_to_nfsd_file_put_local(=
).
>   */
> -struct nfsd_file *
> -nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> -		  struct nfs_fh *fh, const fmode_t mode)
> +static struct nfsd_file *
> +__nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +		    struct nfs_fh *fh, struct nfs_file_localio *nfl,
> +		    const fmode_t mode)
>  {
>  	struct nfsd_file *localio;
> -	int status;
> -
> -	if (!nfs_server_is_local(clp))
> -		return NULL;
> -	if (mode & ~(FMODE_READ | FMODE_WRITE))
> -		return NULL;
> =20
>  	localio =3D nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
> -				    cred, fh, mode);
> +				    cred, fh, nfl, mode);
>  	if (IS_ERR(localio)) {
> -		status =3D PTR_ERR(localio);
> +		int status =3D PTR_ERR(localio);
>  		trace_nfs_local_open_fh(fh, mode, status);
>  		switch (status) {
>  		case -ENOMEM:
> @@ -240,10 +246,59 @@ nfs_local_open_fh(struct nfs_client *clp, const struc=
t cred *cred,
>  			/* Revalidate localio, will disable if unsupported */
>  			nfs_local_probe(clp);
>  		}
> -		return NULL;
>  	}
>  	return localio;
>  }
> +
> +/*
> + * nfs_local_open_fh - open a local filehandle in terms of nfsd_file.
> + * First checking if the open nfsd_file is already cached, otherwise
> + * must __nfs_local_open_fh and insert the nfsd_file in nfs_file_localio.
> + *
> + * Returns a pointer to a struct nfsd_file or NULL.
> + */
> +struct nfsd_file *
> +nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
> +		  const fmode_t mode)
> +{
> +	struct nfsd_file *nf, *new, __rcu **pnf;
> +
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +	if (mode & ~(FMODE_READ | FMODE_WRITE))
> +		return NULL;
> +
> +	if (mode & FMODE_WRITE)
> +		pnf =3D &nfl->rw_file;
> +	else
> +		pnf =3D &nfl->ro_file;
> +
> +	new =3D NULL;
> +	rcu_read_lock();
> +	nf =3D rcu_dereference(*pnf);
> +	if (!nf) {
> +		rcu_read_unlock();
> +		new =3D __nfs_local_open_fh(clp, cred, fh, nfl, mode);
> +		if (IS_ERR(new))
> +			return NULL;
> +		/* try to swap in the pointer */
> +		spin_lock(&clp->cl_uuid.lock);
> +		nf =3D rcu_dereference_protected(*pnf, 1);
> +		if (!nf) {
> +			nf =3D new;
> +			new =3D NULL;
> +			rcu_assign_pointer(*pnf, nf);
> +		}
> +		spin_unlock(&clp->cl_uuid.lock);
> +		rcu_read_lock();
> +	}
> +	nf =3D nfs_local_file_get(nf);
> +	rcu_read_unlock();
> +	if (new)
> +		nfs_to_nfsd_file_put_local(new);
> +	return nf;
> +}
>  EXPORT_SYMBOL_GPL(nfs_local_open_fh);
> =20
>  static struct bio_vec *
> @@ -347,7 +402,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
>  {
>  	struct nfs_pgio_header *hdr =3D iocb->hdr;
> =20
> -	nfs_to_nfsd_file_put_local(iocb->localio);
> +	nfs_local_file_put(iocb->localio);
>  	nfs_local_iocb_free(iocb);
>  	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
>  }
> @@ -694,7 +749,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_=
file *localio,
>  	if (status !=3D 0) {
>  		if (status =3D=3D -EAGAIN)
>  			nfs_local_disable(clp);
> -		nfs_to_nfsd_file_put_local(localio);
> +		nfs_local_file_put(localio);
>  		hdr->task.tk_status =3D status;
>  		nfs_local_hdr_release(hdr, call_ops);
>  	}
> @@ -745,7 +800,7 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
>  		struct nfs_commit_data *data,
>  		const struct rpc_call_ops *call_ops)
>  {
> -	nfs_to_nfsd_file_put_local(localio);
> +	nfs_local_file_put(localio);
>  	call_ops->rpc_call_done(&data->task, data);
>  	call_ops->rpc_release(data);
>  }
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index e27c07bd89290..11968dcb72431 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -961,8 +961,9 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descr=
iptor *desc)
>  		struct nfs_client *clp =3D NFS_SERVER(hdr->inode)->nfs_client;
> =20
>  		struct nfsd_file *localio =3D
> -			nfs_local_open_fh(clp, hdr->cred,
> -					  hdr->args.fh, hdr->args.context->mode);
> +			nfs_local_open_fh(clp, hdr->cred, hdr->args.fh,
> +					  &hdr->args.context->nfl,
> +					  hdr->args.context->mode);
> =20
>  		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
>  			task_flags =3D RPC_TASK_MOVEABLE;
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 2da00987d9ed4..75779e3cac16d 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1817,7 +1817,8 @@ nfs_commit_list(struct inode *inode, struct list_head=
 *head, int how,
>  		task_flags =3D RPC_TASK_MOVEABLE;
> =20
>  	localio =3D nfs_local_open_fh(NFS_SERVER(inode)->nfs_client, data->cred,
> -				    data->args.fh, data->context->mode);
> +				    data->args.fh, &data->context->nfl,
> +				    data->context->mode);
>  	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
>  				   data->mds_ops, how,
>  				   RPC_TASK_CRED_NOREF | task_flags, localio);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index abc132166742e..35a2e48731df6 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -9,7 +9,7 @@
>  #include <linux/nfslocalio.h>
>  #include <linux/nfs3.h>
>  #include <linux/nfs4.h>
> -#include <linux/nfs_fs_sb.h>
> +#include <linux/nfs_fs.h>
>  #include <net/netns/generic.h>
> =20
>  MODULE_LICENSE("GPL");
> @@ -151,9 +151,18 @@ void nfs_localio_invalidate_clients(struct list_head *=
cl_uuid_list)
>  }
>  EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> =20
> +static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_locali=
o *nfl)
> +{
> +	spin_lock(&nfs_uuid_lock);
> +	if (!nfl->nfs_uuid)
> +		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
> +	spin_unlock(&nfs_uuid_lock);
> +}
> +
>  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
> +		   const fmode_t fmode)
>  {
>  	struct net *net;
>  	struct nfsd_file *localio;
> @@ -180,11 +189,50 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  					     cred, nfs_fh, fmode);
>  	if (IS_ERR(localio))
>  		nfs_to_nfsd_net_put(net);
> +	else
> +		nfs_uuid_add_file(uuid, nfl);
> =20
>  	return localio;
>  }
>  EXPORT_SYMBOL_GPL(nfs_open_local_fh);
> =20
> +void nfs_close_local_fh(struct nfs_file_localio *nfl)
> +{
> +	struct nfsd_file *ro_nf =3D NULL;
> +	struct nfsd_file *rw_nf =3D NULL;
> +	nfs_uuid_t *nfs_uuid;
> +
> +	rcu_read_lock();
> +	nfs_uuid =3D rcu_dereference(nfl->nfs_uuid);

nfl->nfs_uuid is a void*.  Why do you assign it to an 'nfs_uuid_t *' ??

And why do we need rcu here?  We never dereference that pointer.

I would just have

  if (!nfl->nfs_uuid || (!nfl->ro_file && !nfl->rw_file))
        return;

then take the spinlock and do it the real work.

> +	if (!nfs_uuid) {
> +		/* regular (non-LOCALIO) NFS will hammer this */
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	ro_nf =3D rcu_access_pointer(nfl->ro_file);
> +	rw_nf =3D rcu_access_pointer(nfl->rw_file);
> +	if (ro_nf || rw_nf) {
> +		spin_lock(&nfs_uuid_lock);
> +		if (ro_nf)
> +			ro_nf =3D rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
> +		if (rw_nf)
> +			rw_nf =3D rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> +
> +		rcu_assign_pointer(nfl->nfs_uuid, NULL);
> +		spin_unlock(&nfs_uuid_lock);
> +		rcu_read_unlock();
> +
> +		if (ro_nf)
> +			nfs_to_nfsd_file_put_local(ro_nf);
> +		if (rw_nf)
> +			nfs_to_nfsd_file_put_local(rw_nf);
> +		return;
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(nfs_close_local_fh);
> +
>  /*
>   * The NFS LOCALIO code needs to call into NFSD using various symbols,
>   * but cannot be statically linked, because that will make the NFS
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954f..67ae2c3f41d20 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -77,6 +77,23 @@ struct nfs_lock_context {
>  	struct rcu_head	rcu_head;
>  };
> =20
> +struct nfs_file_localio {
> +	struct nfsd_file __rcu *ro_file;
> +	struct nfsd_file __rcu *rw_file;
> +	struct list_head list;
> +	void __rcu *nfs_uuid; /* opaque pointer to 'nfs_uuid_t' */

I've said it above but just to be clear:  No "__rcu" here.

Thanks,
NeilBrown

