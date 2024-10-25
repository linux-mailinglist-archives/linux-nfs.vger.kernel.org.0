Return-Path: <linux-nfs+bounces-7461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41BE9AF7CE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 05:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1416DB216FB
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296B1531C4;
	Fri, 25 Oct 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PuAKk7aO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FB/NICgG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KZ2CWORC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BgcLgBFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266022B644
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825270; cv=none; b=ihsbtgAyjdqQa/V85LwIWcBYoA6cTwQA8McFyz8CpnPcBrk6fhbTdu3kiCv4t8P2wUECtT8ffaFX+rPBh7QXlOtoOoixPQhdR7AZhFrY1hr/2KZ2EkJiTM++VwDfBaQFXRovPGSOMTWWzbZi5DN0su8jXzOEX/eNWu22sFlMW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825270; c=relaxed/simple;
	bh=jNzlMEuUvXYYwa4H0ATNVsx/vqyxIQ0eCs8EIEu6FwI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FvL/rs5s169guGeP7qJXG/gUUuokvx3dNeFtG9VxToFY6oHuTU+i/KcF47OvfsXK1/L14wNEZUb+52YPCDcXTNkN5vmMHvV2fCroLK7+SEE0FlnoCSYqcHLFeyX3sZqYdxzGVpRIv2dP/CMYScqN3vClJbTT2KKfhTAIsNztehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PuAKk7aO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FB/NICgG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KZ2CWORC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BgcLgBFj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57CB921EF0;
	Fri, 25 Oct 2024 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729825263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKnAfSIJDxaH3W+5H46iTcCjJKBdZJaSQOtuCXP4ryI=;
	b=PuAKk7aOzLWeJ+HSErHU2OtI8FrHbvOmEVdQ1TVEHJb3oEXk/i+4YK3AnFn67KZgWw/p6n
	wqfmQhsXsl2GWpUb8jWrcE3M55bWUpX4lPJpnUpLh81Jwv0p455duDjyXfo69l9Tl0Rtsh
	gmNkmHy0vG7GHdKNIe60G9FXNiutEl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729825263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKnAfSIJDxaH3W+5H46iTcCjJKBdZJaSQOtuCXP4ryI=;
	b=FB/NICgG9ubmhmsMbq/T+6Y/jE2AA25mlf13WtqaAplgyN4W5qDupZBG7HZ/txK45eRTWI
	V13AOOUkOS+CRRBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KZ2CWORC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BgcLgBFj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729825262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKnAfSIJDxaH3W+5H46iTcCjJKBdZJaSQOtuCXP4ryI=;
	b=KZ2CWORC58UzUh6se5UCxX8hFYoEyztjKJ/FF2FbVIvXleI4/CZqOnyZZvSMwEXTkuzIBp
	1CdoYShh0lhM19vzz9W/xJ/xRrwHzsivKxrofuRJSr8aSzydP7FLd2nYIVJI6pPj34YIDZ
	aHOsC9FvUIeNFde+UrN4Q0CtdOxURYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729825262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKnAfSIJDxaH3W+5H46iTcCjJKBdZJaSQOtuCXP4ryI=;
	b=BgcLgBFjbGbc2Xvq57f59YDdcY3bFRhob/Xrooi2B8ZvUtzK8Rb4sn+uFHIQOkBfSDc6Hy
	82Ul2IhnxDR8udCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC59F136F5;
	Fri, 25 Oct 2024 03:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0bz/J+sJG2fLBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 25 Oct 2024 03:00:59 +0000
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
Subject: Re: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
In-reply-to: <20241024185526.76146-1-snitzer@kernel.org>
References: <20241024185526.76146-1-snitzer@kernel.org>
Date: Fri, 25 Oct 2024 14:00:56 +1100
Message-id: <172982525650.81717.5861053414648479623@noble.neil.brown.name>
X-Rspamd-Queue-Id: 57CB921EF0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 25 Oct 2024, Mike Snitzer wrote:
> Rather than make nfsd_file_do_acquire() more complex (by training
> it to conditionally skip both fh_verify() and nfsd_file allocation
> and contruction) introduce nfsd_file_acquire_gc_cached() -- which
> duplicates the minimalist subset of nfsd_file_do_acquire() needed to
> achieve nfsd_file lookup using an opaque @inode_key.
>=20
> nfsd_file_acquire_gc_cached() only returns a cached and GC'd nfsd_file
> obtained using the opaque @inode_key, established from a previous call
> to nfsd_file_do_acquire_local() that originally added the GC'd
> nfsd_file to the filecache.
>=20
> Update nfsd_open_local_fh to store @inode_key in @nfs_fh so later
> calls can check if it maps to an open GC'd nfsd_file in the filecache
> using nfsd_file_acquire_gc_cached().  Its nfsd_file_lookup_locked()
> call will only find a match if @cred matches the nfsd_file's nf_cred.
>=20
> And care is taken to clear the inode_key in nfsd_file_free() if the
> nfsd_file has a non-NULL nf_inodep (which is a pointer to the address
> of the opaque inode_key stored in the nfs_fh).  This avoids any risk
> of re-using the old inode_key for a different nfsd_file.
>=20
> This commit's cached nfsd_file lookup dramatically speeds up LOCALIO
> performance, especially for small 4K O_DIRECT IO, e.g.:
>=20
> before: read: IOPS=3D376k,  BW=3D1469MiB/s (1541MB/s)(28.7GiB/20001msec)
> after:  read: IOPS=3D1037k, BW=3D4050MiB/s (4247MB/s)(79.1GiB/20002msec)
>=20
> Note that LOCALIO calls nfsd_open_local_fh() for every IO it issues to
> the underlying filesystem using the returned nfsd_file.  This is why
> caching the opaque 'inode_key' in 'struct nfs_fh' is so helpful for
> LOCALIO to quickly return the cached nfsd_file.  Whereas regular NFS
> avoids fh_verify()'s costly duplicate lookups of the underlying
> filesystem's dentry by caching it in 'fh_dentry' of 'struct svc_fh'.
> LOCALIO cannot take the same approach, of storing the dentry, without
> creating object lifetime issues associated with dentry references
> holding server mounts open and preventing unmounts.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

I think this is a good idea.  If we are to avoid a complete lookup for
every IO we need some back-pointer from the nfsd filecache to something
in nfs so that a cached lookup can be invalidated.  Various other
schemes have been suggested before.  This one seems particularly simple.

I'm wondering about the request for a garbage-collected nfsd_file
though.  For NFSv3 that makes sense.  For NFSv4 we would expect the file
to already be open as a non-garbage-collected nfsd_file and opening it
again seems wasteful.  That doesn't need to be fixed for this patch and
maybe doesn't need to be fixed at all, but it seemed worth highlighting.

More below

> ---
>  fs/nfs/inode.c             |  3 ++
>  fs/nfs_common/nfslocalio.c |  2 +-
>  fs/nfsd/filecache.c        | 78 ++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h        |  7 ++++
>  fs/nfsd/localio.c          | 46 +++++++++++++++++++---
>  include/linux/nfs.h        |  4 ++
>  include/linux/nfslocalio.h |  6 +--
>  7 files changed, 136 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index cc7a32b32676..3051d65e3a89 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2413,6 +2413,9 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
>  #endif /* CONFIG_NFS_V4 */
>  #ifdef CONFIG_NFS_V4_2
>  	nfsi->xattr_cache =3D NULL;
> +#endif
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	nfsi->fh.inode_key =3D NULL;
>  #endif
>  	nfs_netfs_inode_init(nfsi);
> =20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 09404d142d1a..bacebaa1e15c 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -130,7 +130,7 @@ EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
> =20
>  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +		   struct nfs_fh *nfs_fh, const fmode_t fmode)
>  {
>  	struct net *net;
>  	struct nfsd_file *localio;
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1408166222c5..5ab978ac3555 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -221,6 +221,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, u=
nsigned char need,
>  	INIT_LIST_HEAD(&nf->nf_gc);
>  	nf->nf_birthtime =3D ktime_get();
>  	nf->nf_file =3D NULL;
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	nf->nf_inodep =3D NULL;
> +#endif

All these "#if IS_ENABLED" are ugly.  I wonder if we could get rid of
them.
Using __GFP_ZERO for the alloc would work here, but might be an unwanted
cost.  Maybe nf_inodep could be ignored if nf_file is NULL.

>  	nf->nf_cred =3D get_current_cred();
>  	nf->nf_net =3D net;
>  	nf->nf_flags =3D want_gc ?
> @@ -285,6 +288,12 @@ nfsd_file_free(struct nfsd_file *nf)
>  		nfsd_file_check_write_error(nf);
>  		nfsd_filp_close(nf->nf_file);
>  	}
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	if (nf->nf_inodep) {
> +		*(nf->nf_inodep) =3D NULL;
> +		nf->nf_inodep =3D NULL;
> +	}
> +#endif

This one is harder to hide.  We don't really need the final assignment
though so maybe we could

#define NF_INODEP(nf) (nf->nf_inodep)
or
#define NF_INODEP(nf) (NULL)

in a header (where #if are more acceptable), then make this code:

 if (NF_INODEP(nf))
	*NF_INODEP(nf) =3D NULL;

Is that better or worse I wonder.

> =20
>  	/*
>  	 * If this item is still linked via nf_lru, that's a bug.
> @@ -1255,6 +1264,75 @@ nfsd_file_acquire_local(struct net *net, struct svc_=
cred *cred,
>  	return beres;
>  }
> =20
> +/**
> + * nfsd_file_acquire_cached - Get cached GC'd open file using inode
> + * @net: The network namespace in which to perform a lookup
> + * @cred: the user credential with which to validate access
> + * @inode_key: inode to use as opaque lookup key
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: found cached GC'd "struct nfsd_file" object
> + *
> + * Rather than make nfsd_file_do_acquire more complex (by training
> + * it to conditionally skip fh_verify(), nfsd_file allocation and
> + * contruction) duplicate the minimalist subset of it that is
> + * needed to achieve nfsd_file lookup using the opaque @inode_key.
> + *
> + * The nfsd_file object returned by this API is reference-counted
> + * and garbage-collected. The object is retained for a few
> + * seconds after the final nfsd_file_put() in case the caller
> + * wants to re-use it.
> + *
> + * Return values:
> + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> + *   count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_cached(struct net *net, const struct cred *cred,
> +			 void *inode_key, unsigned int may_flags,
> +			 struct nfsd_file **pnf)
> +{
> +	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
> +	struct nfsd_file *nf;
> +	__be32 status;
> +
> +	rcu_read_lock();
> +	nf =3D nfsd_file_lookup_locked(net, cred, inode_key, need, true);
> +	rcu_read_unlock();
> +
> +	if (unlikely(!nf))
> +		return nfserr_noent;
> +
> +	/*
> +	 * If the nf is on the LRU then it holds an extra reference
> +	 * that must be put if it's removed. It had better not be
> +	 * the last one however, since we should hold another.
> +	 */
> +	if (nfsd_file_lru_remove(nf))
> +		WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));

Just use refcount_dec(&nf->nf_ref).  It will provide a warning of the
count reaches zero.  In general you should never need warnings when
using refcount as it generates the needed warnings itself.

> +
> +	if (WARN_ON_ONCE(test_bit(NFSD_FILE_PENDING, &nf->nf_flags) ||
> +			 !test_bit(NFSD_FILE_HASHED, &nf->nf_flags))) {
> +		status =3D nfserr_inval;
> +		goto error;
> +	}

Do we really want the above?  I guess you were following the pattern in
nfsd_file_do_acquire() which waits for FILE_PENDING and then re-tests
FILE_HASHED (nfsd_file_lookup_locked() already tested it).
I guess it doesn't hurt, but I'm not sure it helps.

> +	this_cpu_inc(nfsd_file_cache_hits);
> +
> +	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_fl=
ags));
> +	if (status !=3D nfs_ok) {
> +error:
> +		nfsd_file_put(nf);
> +		nf =3D NULL;
> +	} else {
> +		this_cpu_inc(nfsd_file_acquisitions);
> +		nfsd_file_check_write_error(nf);
> +		*pnf =3D nf;
> +	}
> +	trace_nfsd_file_acquire(NULL, inode_key, may_flags, nf, status);
> +	return status;
> +}
> +
>  /**
>   * nfsd_file_acquire_opened - Get a struct nfsd_file using existing open f=
ile
>   * @rqstp: the RPC transaction being executed
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index cadf3c2689c4..e000f6988dc8 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -47,6 +47,10 @@ struct nfsd_file {
>  	struct list_head	nf_gc;
>  	struct rcu_head		nf_rcu;
>  	ktime_t			nf_birthtime;
> +
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	void **			nf_inodep;
> +#endif
>  };
> =20
>  int nfsd_file_cache_init(void);
> @@ -71,5 +75,8 @@ __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>  __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
>  			       struct auth_domain *client, struct svc_fh *fhp,
>  			       unsigned int may_flags, struct nfsd_file **pnf);
> +__be32 nfsd_file_acquire_cached(struct net *net, const struct cred *cred,
> +			       void *inode_key, unsigned int may_flags,
> +			       struct nfsd_file **pnf);
>  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>  #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index f441cb9f74d5..34a229409117 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -58,33 +58,67 @@ void nfsd_localio_ops_init(void)
>  struct nfsd_file *
>  nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +		   struct nfs_fh *nfs_fh, const fmode_t fmode)
>  {
>  	int mayflags =3D NFSD_MAY_LOCALIO;
>  	struct svc_cred rq_cred;
>  	struct svc_fh fh;
>  	struct nfsd_file *localio;
> +	void *nf_inode_key;
>  	__be32 beres;
> =20
>  	if (nfs_fh->size > NFS4_FHSIZE)
>  		return ERR_PTR(-EINVAL);
> =20
> -	/* nfs_fh -> svc_fh */
> -	fh_init(&fh, NFS4_FHSIZE);
> -	fh.fh_handle.fh_size =3D nfs_fh->size;
> -	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> -
>  	if (fmode & FMODE_READ)
>  		mayflags |=3D NFSD_MAY_READ;
>  	if (fmode & FMODE_WRITE)
>  		mayflags |=3D NFSD_MAY_WRITE;
> =20
> +	/*
> +	 * Check if 'inode_key' stored in @nfs_fh maps to an
> +	 * open nfsd_file in the filecache (from a previous
> +	 * nfsd_open_local_fh).
> +	 *
> +	 * The 'inode_key' may have become stale (due to nfsd_file
> +	 * being free'd by filecache GC) so the lookup will fail
> +	 * gracefully by falling back to using nfsd_file_acquire_local().
> +	 */
> +	nf_inode_key =3D READ_ONCE(nfs_fh->inode_key);

I think you want the above in an rcu-locked region with
nfsd_file_acquire_cached().  Else the inode could be freed and
reallocated after the READ_ONCE and before the lookup.
Maybe pass the address if inode_key and have nfsd_file_acquire_cached()
deref after getting rcu_read_lock().

> +	if (nf_inode_key) {
> +		beres =3D nfsd_file_acquire_cached(net, cred,
> +						 nf_inode_key,
> +						 mayflags, &localio);
> +		if (beres =3D=3D nfs_ok)
> +			return localio;
> +		/*
> +		 * reset stale nfs_fh->inode_key and fallthru
> +		 * to use normal nfsd_file_acquire_local().
> +		 */
> +		nfs_fh->inode_key =3D NULL;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size =3D nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
>  	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> =20
>  	beres =3D nfsd_file_acquire_local(net, &rq_cred, dom,
>  					&fh, mayflags, &localio);
>  	if (beres)
>  		localio =3D ERR_PTR(nfs_stat_to_errno(be32_to_cpu(beres)));
> +	else {
> +		/*
> +		 * opaque 'inode_key' has a 1:1 mapping to both an
> +		 * nfsd_file and nfs_fh struct (And the nfs_fh is shared
> +		 * by all NFS client threads. So there is no risk of
> +		 * storing competing addresses in nfsd_file->nf_inodep
> +		 */
> +		localio->nf_inodep =3D (void **) &nfs_fh->inode_key;
> +		nfs_fh->inode_key =3D localio->nf_inode;
> +	}
> =20
>  	fh_put(&fh);
>  	if (rq_cred.cr_group_info)
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 9ad727ddfedb..56c894575c70 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -29,6 +29,10 @@
>  struct nfs_fh {
>  	unsigned short		size;
>  	unsigned char		data[NFS_MAXFHSIZE];
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	/* 'inode_key' is an opaque key used for nfsd_file hash lookups */
> +	void *			inode_key;
> +#endif

I wonder if this is really the right place to store the inode_key.
'struct nfs_fh' appears in lots of places and they only place where you
wan the inode_key is inside the nfs_inode.  Maybe store an augmented
nfs_fh in there...


Thanks,
NeilBrown

>  };
> =20
>  /*
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 3982fea79919..619eb1961ed6 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -43,7 +43,7 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
>  /* localio needs to map filehandle -> struct nfsd_file */
>  extern struct nfsd_file *
>  nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
> -		   const struct cred *, const struct nfs_fh *,
> +		   const struct cred *, struct nfs_fh *,
>  		   const fmode_t) __must_hold(rcu);
> =20
>  struct nfsd_localio_operations {
> @@ -53,7 +53,7 @@ struct nfsd_localio_operations {
>  						struct auth_domain *,
>  						struct rpc_clnt *,
>  						const struct cred *,
> -						const struct nfs_fh *,
> +						struct nfs_fh *,
>  						const fmode_t);
>  	void (*nfsd_file_put_local)(struct nfsd_file *);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> @@ -64,7 +64,7 @@ extern const struct nfsd_localio_operations *nfs_to;
> =20
>  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
>  		   struct rpc_clnt *, const struct cred *,
> -		   const struct nfs_fh *, const fmode_t);
> +		   struct nfs_fh *, const fmode_t);
> =20
>  static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
>  {
> --=20
> 2.44.0
>=20
>=20


