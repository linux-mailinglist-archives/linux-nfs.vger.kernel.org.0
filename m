Return-Path: <linux-nfs+bounces-7470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BB9B059F
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71831C23694
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A391632CD;
	Fri, 25 Oct 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNOVduQq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423981D9668
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866098; cv=none; b=gyA4mbRg0BHZTzB9CZ6y3HS7hG4bd6+PbaMRFG11UHPej0XPH4UGBrUnkN64yC/9iHkU/ylJj3NQfpGn4evWHxWoHY29IFRoQ3kOZrT/gBVBOCjT/eMWfDaqmlm1rXbYfzeoQJp3ojT4qnExbHk1xPOl2Q4XLoPsP884/gYbMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866098; c=relaxed/simple;
	bh=yaVePRW8u21LVEQ+f3o7FqbRzghfJz2lUp9DG8xPa5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oExXIrt0GIhM+H3jicCy5ZQcZKcbalzpkU63oRcl81uaJOZk3RltfKtzAbNT2QoXBZzNyRkASuwtAzl4DUrXXP8uK8QDVBZsJsGp8dNL24WabYKj0LHteXC6sm0TWZ29ackGOTxjkHMMqYN4dpjq4CB/svvnvZe6+jOiOUQk/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNOVduQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6076FC4CEC3;
	Fri, 25 Oct 2024 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729866097;
	bh=yaVePRW8u21LVEQ+f3o7FqbRzghfJz2lUp9DG8xPa5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNOVduQqxeFLDByKYT6IGCDI6niCE6/G0p09qIbDSgmAx+YuU+1BiY3WFm0Eagqct
	 4aN0dBGNtpOzm/z0No7GcjmvYhKbmqvK7PJjrB8mNRuXmSBBeXmoJJoIgMI4w5RLYF
	 mFqZb/ZSNlPra2Y/tl6nuy8NZuF9EhsAoxyzN5YkOFRggtQZsd1JWIBARbSF3TUyH7
	 SSA3C4jsAV4SEgodaAEvFRFQdx6I71bEFLCOvHpHzxXhaCPMVfFXW2D1iuaAjJVH58
	 RDbHKXAPWqpjWa0JjXQ2Zzq/H8zMVx551KO6tKL+rjkn/d//F8XAztr430ywv9LMEI
	 iYoesONmtY20Q==
Date: Fri, 25 Oct 2024 10:21:36 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: nfsd/filecache: add nfsd_file_acquire_gc_cached
Message-ID: <ZxupcAD4Keohs0TL@kernel.org>
References: <20241024185526.76146-1-snitzer@kernel.org>
 <172982525650.81717.5861053414648479623@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172982525650.81717.5861053414648479623@noble.neil.brown.name>

On Fri, Oct 25, 2024 at 02:00:56PM +1100, NeilBrown wrote:
> On Fri, 25 Oct 2024, Mike Snitzer wrote:
> > Rather than make nfsd_file_do_acquire() more complex (by training
> > it to conditionally skip both fh_verify() and nfsd_file allocation
> > and contruction) introduce nfsd_file_acquire_gc_cached() -- which
> > duplicates the minimalist subset of nfsd_file_do_acquire() needed to
> > achieve nfsd_file lookup using an opaque @inode_key.
> > 
> > nfsd_file_acquire_gc_cached() only returns a cached and GC'd nfsd_file
> > obtained using the opaque @inode_key, established from a previous call
> > to nfsd_file_do_acquire_local() that originally added the GC'd
> > nfsd_file to the filecache.
> > 
> > Update nfsd_open_local_fh to store @inode_key in @nfs_fh so later
> > calls can check if it maps to an open GC'd nfsd_file in the filecache
> > using nfsd_file_acquire_gc_cached().  Its nfsd_file_lookup_locked()
> > call will only find a match if @cred matches the nfsd_file's nf_cred.
> > 
> > And care is taken to clear the inode_key in nfsd_file_free() if the
> > nfsd_file has a non-NULL nf_inodep (which is a pointer to the address
> > of the opaque inode_key stored in the nfs_fh).  This avoids any risk
> > of re-using the old inode_key for a different nfsd_file.
> > 
> > This commit's cached nfsd_file lookup dramatically speeds up LOCALIO
> > performance, especially for small 4K O_DIRECT IO, e.g.:
> > 
> > before: read: IOPS=376k,  BW=1469MiB/s (1541MB/s)(28.7GiB/20001msec)
> > after:  read: IOPS=1037k, BW=4050MiB/s (4247MB/s)(79.1GiB/20002msec)
> > 
> > Note that LOCALIO calls nfsd_open_local_fh() for every IO it issues to
> > the underlying filesystem using the returned nfsd_file.  This is why
> > caching the opaque 'inode_key' in 'struct nfs_fh' is so helpful for
> > LOCALIO to quickly return the cached nfsd_file.  Whereas regular NFS
> > avoids fh_verify()'s costly duplicate lookups of the underlying
> > filesystem's dentry by caching it in 'fh_dentry' of 'struct svc_fh'.
> > LOCALIO cannot take the same approach, of storing the dentry, without
> > creating object lifetime issues associated with dentry references
> > holding server mounts open and preventing unmounts.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> 
> I think this is a good idea.  If we are to avoid a complete lookup for
> every IO we need some back-pointer from the nfsd filecache to something
> in nfs so that a cached lookup can be invalidated.  Various other
> schemes have been suggested before.  This one seems particularly simple.
> 
> I'm wondering about the request for a garbage-collected nfsd_file
> though.  For NFSv3 that makes sense.  For NFSv4 we would expect the file
> to already be open as a non-garbage-collected nfsd_file and opening it
> again seems wasteful.  That doesn't need to be fixed for this patch and
> maybe doesn't need to be fixed at all, but it seemed worth highlighting.

Maybe you're referring to the nfsd_file_acquire_gc_cached() kernel doc
text?  The code doesn't impose the nfsd_file must be a GC'd nfsd_file
(nor do I ever create an nfsd_file, if it isn't in the filecache then
it returns NULL).

GC'd just buys us a more likely chance of finding the nfsd_file in the
cache so it pairs nicely with GC having been requested/used when the
nfsd_file originally created and added to the cache.

Anyway, what follows in my reply is all moot given this thread has
teased out the desire to utilize a callback mechanism to allow the NFS
client to hold a longterm reference on the open nfsd_file.

BUT I will be folding in all the things covered below so I can at
least put nfsd_file_acquire_cached() out to pasture in more fully
formed state (should there ever be a need to revisit it)...

> More below
> 
> > ---
> >  fs/nfs/inode.c             |  3 ++
> >  fs/nfs_common/nfslocalio.c |  2 +-
> >  fs/nfsd/filecache.c        | 78 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/filecache.h        |  7 ++++
> >  fs/nfsd/localio.c          | 46 +++++++++++++++++++---
> >  include/linux/nfs.h        |  4 ++
> >  include/linux/nfslocalio.h |  6 +--
> >  7 files changed, 136 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index cc7a32b32676..3051d65e3a89 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -2413,6 +2413,9 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
> >  #endif /* CONFIG_NFS_V4 */
> >  #ifdef CONFIG_NFS_V4_2
> >  	nfsi->xattr_cache = NULL;
> > +#endif
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	nfsi->fh.inode_key = NULL;
> >  #endif
> >  	nfs_netfs_inode_init(nfsi);
> >  
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > index 09404d142d1a..bacebaa1e15c 100644
> > --- a/fs/nfs_common/nfslocalio.c
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -130,7 +130,7 @@ EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
> >  
> >  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
> >  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +		   struct nfs_fh *nfs_fh, const fmode_t fmode)
> >  {
> >  	struct net *net;
> >  	struct nfsd_file *localio;
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 1408166222c5..5ab978ac3555 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -221,6 +221,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
> >  	INIT_LIST_HEAD(&nf->nf_gc);
> >  	nf->nf_birthtime = ktime_get();
> >  	nf->nf_file = NULL;
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	nf->nf_inodep = NULL;
> > +#endif
> 
> All these "#if IS_ENABLED" are ugly.  I wonder if we could get rid of
> them.
> Using __GFP_ZERO for the alloc would work here, but might be an unwanted
> cost.  Maybe nf_inodep could be ignored if nf_file is NULL.

I did originally nest the nf_inodep backpointer reset within
nfsd_file_free()'s nf->nf_file check, will go back to that.

Then nf_inodep is otherwise ignored everywhere.

> >  	nf->nf_cred = get_current_cred();
> >  	nf->nf_net = net;
> >  	nf->nf_flags = want_gc ?
> > @@ -285,6 +288,12 @@ nfsd_file_free(struct nfsd_file *nf)
> >  		nfsd_file_check_write_error(nf);
> >  		nfsd_filp_close(nf->nf_file);
> >  	}
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	if (nf->nf_inodep) {
> > +		*(nf->nf_inodep) = NULL;
> > +		nf->nf_inodep = NULL;
> > +	}
> > +#endif
> 
> This one is harder to hide.  We don't really need the final assignment
> though so maybe we could
>
> #define NF_INODEP(nf) (nf->nf_inodep)
> or
> #define NF_INODEP(nf) (NULL)
> 
> in a header (where #if are more acceptable), then make this code:
> 
>  if (NF_INODEP(nf))
> 	*NF_INODEP(nf) = NULL;
> 
> Is that better or worse I wonder.

Not opposed to this, will do.

> >  
> >  	/*
> >  	 * If this item is still linked via nf_lru, that's a bug.
> > @@ -1255,6 +1264,75 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> >  	return beres;
> >  }
> >  
> > +/**
> > + * nfsd_file_acquire_cached - Get cached GC'd open file using inode
> > + * @net: The network namespace in which to perform a lookup
> > + * @cred: the user credential with which to validate access
> > + * @inode_key: inode to use as opaque lookup key
> > + * @may_flags: NFSD_MAY_ settings for the file
> > + * @pnf: OUT: found cached GC'd "struct nfsd_file" object
> > + *
> > + * Rather than make nfsd_file_do_acquire more complex (by training
> > + * it to conditionally skip fh_verify(), nfsd_file allocation and
> > + * contruction) duplicate the minimalist subset of it that is
> > + * needed to achieve nfsd_file lookup using the opaque @inode_key.
> > + *
> > + * The nfsd_file object returned by this API is reference-counted
> > + * and garbage-collected. The object is retained for a few
> > + * seconds after the final nfsd_file_put() in case the caller
> > + * wants to re-use it.
> > + *
> > + * Return values:
> > + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> > + *   count boosted.
> > + *
> > + * On error, an nfsstat value in network byte order is returned.
> > + */
> > +__be32
> > +nfsd_file_acquire_cached(struct net *net, const struct cred *cred,
> > +			 void *inode_key, unsigned int may_flags,
> > +			 struct nfsd_file **pnf)
> > +{
> > +	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
> > +	struct nfsd_file *nf;
> > +	__be32 status;
> > +
> > +	rcu_read_lock();
> > +	nf = nfsd_file_lookup_locked(net, cred, inode_key, need, true);
> > +	rcu_read_unlock();
> > +
> > +	if (unlikely(!nf))
> > +		return nfserr_noent;
> > +
> > +	/*
> > +	 * If the nf is on the LRU then it holds an extra reference
> > +	 * that must be put if it's removed. It had better not be
> > +	 * the last one however, since we should hold another.
> > +	 */
> > +	if (nfsd_file_lru_remove(nf))
> > +		WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
> 
> Just use refcount_dec(&nf->nf_ref).  It will provide a warning if the
> count reaches zero.  In general you should never need warnings when
> using refcount as it generates the needed warnings itself.

OK, I lifted the code from nfsd_file_do_acquire() as a starting point;
so it should probably be cleaned up there (independent of this patch,
not it).

> > +
> > +	if (WARN_ON_ONCE(test_bit(NFSD_FILE_PENDING, &nf->nf_flags) ||
> > +			 !test_bit(NFSD_FILE_HASHED, &nf->nf_flags))) {
> > +		status = nfserr_inval;
> > +		goto error;
> > +	}
> 
> Do we really want the above?  I guess you were following the pattern in
> nfsd_file_do_acquire() which waits for FILE_PENDING and then re-tests
> FILE_HASHED (nfsd_file_lookup_locked() already tested it).
> I guess it doesn't hurt, but I'm not sure it helps.

Right, was just trying to maintain status-quo.  I think it doesn't
hurt, and may actually help given spin_lock isn't held around
nfsd_file_lookup_locked?  But the WARN_ON_ONCE should be removed.

> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index f441cb9f74d5..34a229409117 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -58,33 +58,67 @@ void nfsd_localio_ops_init(void)
> >  struct nfsd_file *
> >  nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
> >  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +		   struct nfs_fh *nfs_fh, const fmode_t fmode)
> >  {
> >  	int mayflags = NFSD_MAY_LOCALIO;
> >  	struct svc_cred rq_cred;
> >  	struct svc_fh fh;
> >  	struct nfsd_file *localio;
> > +	void *nf_inode_key;
> >  	__be32 beres;
> >  
> >  	if (nfs_fh->size > NFS4_FHSIZE)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	/* nfs_fh -> svc_fh */
> > -	fh_init(&fh, NFS4_FHSIZE);
> > -	fh.fh_handle.fh_size = nfs_fh->size;
> > -	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > -
> >  	if (fmode & FMODE_READ)
> >  		mayflags |= NFSD_MAY_READ;
> >  	if (fmode & FMODE_WRITE)
> >  		mayflags |= NFSD_MAY_WRITE;
> >  
> > +	/*
> > +	 * Check if 'inode_key' stored in @nfs_fh maps to an
> > +	 * open nfsd_file in the filecache (from a previous
> > +	 * nfsd_open_local_fh).
> > +	 *
> > +	 * The 'inode_key' may have become stale (due to nfsd_file
> > +	 * being free'd by filecache GC) so the lookup will fail
> > +	 * gracefully by falling back to using nfsd_file_acquire_local().
> > +	 */
> > +	nf_inode_key = READ_ONCE(nfs_fh->inode_key);
> 
> I think you want the above in an rcu-locked region with
> nfsd_file_acquire_cached().  Else the inode could be freed and
> reallocated after the READ_ONCE and before the lookup.
> Maybe pass the address of inode_key and have nfsd_file_acquire_cached()
> deref after getting rcu_read_lock().

Good point, will do.

> > +	if (nf_inode_key) {
> > +		beres = nfsd_file_acquire_cached(net, cred,
> > +						 nf_inode_key,
> > +						 mayflags, &localio);
> > +		if (beres == nfs_ok)
> > +			return localio;
> > +		/*
> > +		 * reset stale nfs_fh->inode_key and fallthru
> > +		 * to use normal nfsd_file_acquire_local().
> > +		 */
> > +		nfs_fh->inode_key = NULL;
> > +	}

> > diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> > index 9ad727ddfedb..56c894575c70 100644
> > --- a/include/linux/nfs.h
> > +++ b/include/linux/nfs.h
> > @@ -29,6 +29,10 @@
> >  struct nfs_fh {
> >  	unsigned short		size;
> >  	unsigned char		data[NFS_MAXFHSIZE];
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	/* 'inode_key' is an opaque key used for nfsd_file hash lookups */
> > +	void *			inode_key;
> > +#endif
> 
> I wonder if this is really the right place to store the inode_key.
> 'struct nfs_fh' appears in lots of places and the only place where you
> want the inode_key is inside the nfs_inode.  Maybe store an augmented
> nfs_fh in there...

Yeah, I went with nfs_fh because it served my needs (and nfs_fh is
passed to nfs_open_local_fh).  But very much open to suggestions.
While I'm not yet sure about your nfs_inode suggestion, I'll certainly
take a closer look after addressing your other feedback.

Thanks for your review!

Mike

