Return-Path: <linux-nfs+bounces-8011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0F9CF2F3
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C308DB466FD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880B1D517F;
	Fri, 15 Nov 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EayOqm0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E161D434F
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689350; cv=none; b=m+I6stOi6iVLYsmjlN0UO/KBMYufgZ+9jVArWLahuPcMifIUsTQkV8j+F90PMsLofBNzy6LdFSJA8tk46e+Y+WNfwY8orNKHjRoXzlZrPx5CEwvsdl35+q/zPHVudvVaYuq67JbjPm0w8rK6KXbyAalERoS7YMlaG116z5v9JhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689350; c=relaxed/simple;
	bh=rEJcHs5NG7y52ScZ+ep+Yv2U6mjU8bNCmHpruthLw78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL8c9PYoKPRe0n459uGuhMn3xdM1t7FgTQkzqhGI92GcobaRJsjeixUQTxUhyPxYwdoOaZz1alLLm2+IxW7XWPo2GTuiVamauOgmWjvuEwNq73PlNipFklHDbw0fF2+Og+zn5Due88uyxvp8UBjYMmb7+T9JZ9v9fecLJgYuiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EayOqm0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC07C4CECF;
	Fri, 15 Nov 2024 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689349;
	bh=rEJcHs5NG7y52ScZ+ep+Yv2U6mjU8bNCmHpruthLw78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EayOqm0I+jtHrx1sS3L24RLfMO9KSDOhc0QpAyMxDlHJOrP41iMDhF4HKWRAZrERZ
	 oz08OdR1phH/RwGSomGXguFCNr1mxoIOhpqo5wW1o29xuuPMMjoCw+0fYhiMT6UmZB
	 8vJTuSgbqUeR47VRO2DrUUqDM3IIrxGeL3Ns7I4dIeaw5HiWNgjAASEUNSRrSCvgls
	 d+sijUhVeKPzZXcN0i13pluR6xlqduzcWzBeGpH3NlRj3dKM/aqMRzfPlHwGgeRcKa
	 KzmvFyTcnZDjTOgPkDDULyUXuW6xlokt5Idn88TmqOTj5gbWzyYF/WJy/oZwuKhSk6
	 46W2D4wjZQ57g==
Date: Fri, 15 Nov 2024 11:49:08 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH v2 06/15] nfs: cache all open LOCALIO
 nfsd_file(s) in client
Message-ID: <Zzd7hKl5_cu4yP2s@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
 <20241114035952.13889-7-snitzer@kernel.org>
 <173164036674.1734440.14888275520804852973@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173164036674.1734440.14888275520804852973@noble.neil.brown.name>

On Fri, Nov 15, 2024 at 02:12:46PM +1100, NeilBrown wrote:
> On Thu, 14 Nov 2024, Mike Snitzer wrote:
> > This commit switches from leaning heavily on NFSD's filecache (in
> > terms of GC'd nfsd_files) back to caching nfsd_files in the
> > client. A later commit will add the callback mechanism needed to
> > allow NFSD to force the NFS client to cleanup all caches files.
> > 
> > Add nfs_fh_localio_init() and 'struct nfs_fh_localio' to cache opened
> > nfsd_file(s) (both a RO and RW nfsd_file is able to be opened and
> > cached for a given nfs_fh).
> > 
> > Update nfs_local_open_fh() to cache the nfsd_file once it is opened
> > using __nfs_local_open_fh().
> > 
> > Introduce nfs_close_local_fh() to clear the cached open nfsd_files and
> > call nfs_to_nfsd_file_put_local().
> > 
> > Refcounting is such that:
> > - nfs_local_open_fh() is paired with nfs_close_local_fh().
> > - __nfs_local_open_fh() is paired with nfs_to_nfsd_file_put_local().
> > - nfs_local_file_get() is paired with nfs_local_file_put().
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/flexfilelayout/flexfilelayout.c | 29 +++++----
> >  fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
> >  fs/nfs/inode.c                         |  3 +
> >  fs/nfs/internal.h                      |  4 +-
> >  fs/nfs/localio.c                       | 89 +++++++++++++++++++++-----
> >  fs/nfs/pagelist.c                      |  5 +-
> >  fs/nfs/write.c                         |  3 +-
> >  fs/nfs_common/nfslocalio.c             | 52 ++++++++++++++-
> >  include/linux/nfs_fs.h                 | 22 ++++++-
> >  include/linux/nfslocalio.h             | 18 +++---
> >  10 files changed, 181 insertions(+), 45 deletions(-)
> > 
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> > index f78115c6c2c12..451f168d882be 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > @@ -164,18 +164,17 @@ decode_name(struct xdr_stream *xdr, u32 *id)
> >  }
> >  
> >  static struct nfsd_file *
> > -ff_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> > +ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
> > +		 struct nfs_client *clp, const struct cred *cred,
> >  		 struct nfs_fh *fh, fmode_t mode)
> >  {
> > -	if (mode & FMODE_WRITE) {
> > -		/*
> > -		 * Always request read and write access since this corresponds
> > -		 * to a rw layout.
> > -		 */
> > -		mode |= FMODE_READ;
> > -	}
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
> >  
> > -	return nfs_local_open_fh(clp, cred, fh, mode);
> > +	return nfs_local_open_fh(clp, cred, fh, &mirror->nfl, mode);
> > +#else
> > +	return NULL;
> > +#endif
> >  }
> >  
> >  static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
> > @@ -247,6 +246,9 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
> >  		spin_lock_init(&mirror->lock);
> >  		refcount_set(&mirror->ref, 1);
> >  		INIT_LIST_HEAD(&mirror->mirrors);
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +		nfs_localio_file_init(&mirror->nfl);
> > +#endif
> 
> Can we make nfs_localio_file_init() a #define in the no-NFS_LOCALIO
> case, we don't need the #if.
> (every time you write #if in a .c file think to your self "Neil will
> hate this".  See also coding-style.rst. 21) Conditional Compilation.

It already was defined in header, and doesn't need wrapping in caller,
I just mistakenly wrapped it again in ff_layout_alloc_mirror().

Fixed.

> >  	}
> >  	return mirror;
> >  }
> > @@ -257,6 +259,9 @@ static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
> >  
> >  	ff_layout_remove_mirror(mirror);
> >  	kfree(mirror->fh_versions);
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	nfs_close_local_fh(&mirror->nfl);
> > +#endif
> >  	cred = rcu_access_pointer(mirror->ro_cred);
> >  	put_cred(cred);
> >  	cred = rcu_access_pointer(mirror->rw_cred);

I fixed this call to nfs_close_local_fh() to not use #if also.

> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
> > index f84b3fb0dddd8..095df09017a57 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> > @@ -83,6 +83,7 @@ struct nfs4_ff_layout_mirror {
> >  	nfs4_stateid			stateid;
> >  	const struct cred __rcu		*ro_cred;
> >  	const struct cred __rcu		*rw_cred;
> > +	struct nfs_file_localio		nfl;
> 
> This probably wants a #if around it though - it is in a .h after all.

I unconditionall defined 'struct nfs_file_localio' otherwise the
calls that access this nfl member (nfs_localio_file_init) _will_ need
special treatment.

> 
> >  	refcount_t			ref;
> >  	spinlock_t			lock;
> >  	unsigned long			flags;

<snip>

> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > index abc132166742e..35a2e48731df6 100644
> > --- a/fs/nfs_common/nfslocalio.c
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -151,9 +151,18 @@ void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> >  
> > +static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
> > +{
> > +	spin_lock(&nfs_uuid_lock);
> > +	if (!nfl->nfs_uuid)
> > +		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
> > +	spin_unlock(&nfs_uuid_lock);
> > +}
> > +
> >  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
> >  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > -		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
> > +		   const fmode_t fmode)
> >  {
> >  	struct net *net;
> >  	struct nfsd_file *localio;
> > @@ -180,11 +189,50 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
> >  					     cred, nfs_fh, fmode);
> >  	if (IS_ERR(localio))
> >  		nfs_to_nfsd_net_put(net);
> > +	else
> > +		nfs_uuid_add_file(uuid, nfl);
> >  
> >  	return localio;
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_open_local_fh);
> >  
> > +void nfs_close_local_fh(struct nfs_file_localio *nfl)
> > +{
> > +	struct nfsd_file *ro_nf = NULL;
> > +	struct nfsd_file *rw_nf = NULL;
> > +	nfs_uuid_t *nfs_uuid;
> > +
> > +	rcu_read_lock();
> > +	nfs_uuid = rcu_dereference(nfl->nfs_uuid);
> 
> nfl->nfs_uuid is a void*.  Why do you assign it to an 'nfs_uuid_t *' ??

Yeah, I made it void* to not have to play games with nfs_uuid_t in
include/linux/nfs_fs.h

It is assigned to 'nfs_uuid_t *' because I dereference it to get its
spinlock in later patch (that splits the nfs_uuid_lock).

> And why do we need rcu here?  We never dereference that pointer.

As I just said, I do in the patch that splits the nfs_uuid_lock.

And I made nfl->nfs_uuid management RCU protected given it being NULL
or not is significant and I'd rather not require other synchronization
via other locking.

SO while I appreciate your review here, the code in final form (once
nfs_uuid_lock lock split patch applied) does need RCU as I've written
it.

> I would just have
> 
>   if (!nfl->nfs_uuid || (!nfl->ro_file && !nfl->rw_file))
>         return;
> 
> then take the spinlock and do it the real work.
> 
> > +	if (!nfs_uuid) {
> > +		/* regular (non-LOCALIO) NFS will hammer this */
> > +		rcu_read_unlock();
> > +		return;
> > +	}
> > +
> > +	ro_nf = rcu_access_pointer(nfl->ro_file);
> > +	rw_nf = rcu_access_pointer(nfl->rw_file);
> > +	if (ro_nf || rw_nf) {
> > +		spin_lock(&nfs_uuid_lock);
> > +		if (ro_nf)
> > +			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
> > +		if (rw_nf)
> > +			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> > +
> > +		rcu_assign_pointer(nfl->nfs_uuid, NULL);
> > +		spin_unlock(&nfs_uuid_lock);
> > +		rcu_read_unlock();
> > +
> > +		if (ro_nf)
> > +			nfs_to_nfsd_file_put_local(ro_nf);
> > +		if (rw_nf)
> > +			nfs_to_nfsd_file_put_local(rw_nf);
> > +		return;
> > +	}
> > +	rcu_read_unlock();
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_close_local_fh);
> > +
> >  /*
> >   * The NFS LOCALIO code needs to call into NFSD using various symbols,
> >   * but cannot be statically linked, because that will make the NFS
> > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > index 039898d70954f..67ae2c3f41d20 100644
> > --- a/include/linux/nfs_fs.h
> > +++ b/include/linux/nfs_fs.h
> > @@ -77,6 +77,23 @@ struct nfs_lock_context {
> >  	struct rcu_head	rcu_head;
> >  };
> >  
> > +struct nfs_file_localio {
> > +	struct nfsd_file __rcu *ro_file;
> > +	struct nfsd_file __rcu *rw_file;
> > +	struct list_head list;
> > +	void __rcu *nfs_uuid; /* opaque pointer to 'nfs_uuid_t' */
> 
> I've said it above but just to be clear:  No "__rcu" here.

Please look at final form of nfs_close_local_fh() with all patches
applied.  I wanted to avoid churn in nfs_close_local_fh(), but yeah it
does have some needless RCU-ification in this intermediate patch.

That said, could be there is still room for cleanup even with the
final nfs_close_local_fh()...

Thanks,
Mike

