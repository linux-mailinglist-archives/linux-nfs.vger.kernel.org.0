Return-Path: <linux-nfs+bounces-13788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C99B2CE40
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B2B1C25543
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 20:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5E343214;
	Tue, 19 Aug 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYBjVCEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D30343211
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636481; cv=none; b=fQoQ2xhqtKiFWEh2QBwuuNNVmwRq3omR1XFr775VZJ5zEGtb5ZnBy9FFb6CKE7GpC+PlKaFrCJLBIRLFpNwPh8K7ywG0t25nx4uv7fI7dXhrCeEr582G1Ie7oz7xTdBCmCv2dKBUnf2mTDAUN0KBGrOzrUli/ZZ28PVkn6mhRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636481; c=relaxed/simple;
	bh=8VnlfLC/A9+HVhi4eRIgyalXts7SAQ+G+v/yw13PBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv0DQgNxvP/ZB3kbzge8hkmy8dG6bgx8dE9N96dqpu5FGlkSzWl4pl7V2B1Xl6B2goRZnHOclfcSoRGMA047nIpVwMrmA3Y4J/rIe3NRyWXv5n2Dt+aGBQtUI+WWfwDW8cjk8BO9w8HBfdVucsMwZbAFU47Mqf7/HO9XDYgh3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYBjVCEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E02C4CEF1;
	Tue, 19 Aug 2025 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755636480;
	bh=8VnlfLC/A9+HVhi4eRIgyalXts7SAQ+G+v/yw13PBHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYBjVCEgqBBPzzRsyvI0aEUgvir4plJREz40DmY0vzU3rXQgMpL/UfdvHYVciT3tZ
	 a4MmDKdSQ7cDpyOJybero9DRhtw5hGk5RzJbEgRd3Kz2YSWp3lxJG34bjbjUy2Rhl1
	 gwtAv3Ii42Z7e9+0pyna0poJhfOMZXY5Oqfx5kFGoseX5PGmiI2DiCNFsjo1VC8FJ+
	 80fG1WJwrbQQv3k0sIuy9REOboplltF4C5/uplT+6PvBy4gkh30egORsDIkHP1M2X1
	 YcU41G83703BDWcIM318CfD0EqbTdb30u43IU79Ih85iIGt4iQryu2C/W8axOGeBkN
	 rWwoBwdu4MH8g==
Date: Tue, 19 Aug 2025 16:47:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Joe Quanaim <jdq@meta.com>, Andrew Steffen <aksteffen@meta.com>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
Message-ID: <aKTi_kk7AtKMLqGZ@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
 <91cdd62fb2c8c4e5632ae8d1f830451577d6c3f1.camel@kernel.org>
 <901355448adc0db38b1dd4a3bc9f99f15651fcad.camel@kernel.org>
 <b7ee5254a556321c55cff1fb4520f28f39125bb0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ee5254a556321c55cff1fb4520f28f39125bb0.camel@kernel.org>

On Tue, Aug 19, 2025 at 03:48:32PM -0400, Jeff Layton wrote:
> On Tue, 2025-08-19 at 11:28 -0700, Trond Myklebust wrote:
> > On Tue, 2025-08-19 at 13:10 -0400, Jeff Layton wrote:
> > > On Sat, 2025-08-16 at 07:51 -0700, Trond Myklebust wrote:
> > > > On Sat, 2025-08-16 at 09:01 -0400, Jeff Layton wrote:
> > > > > 
> > > > > I finally caught something concrete today. I had the attached
> > > > > bpftrace
> > > > > script running while running the reproducer on a dozen or so
> > > > > machines,
> > > > > and it detected a hole in some data being written:
> > > > > 
> > > > > -------------8<---------------
> > > > > Attached 2 probes
> > > > > Missing nfs_page: ino=10122173116 idx=2 flags=0x15ffff0000000029
> > > > > Hole: ino=10122173116 idx=3 off=10026 size=2262
> > > > > Prev folio: idx=2 flags=0x15ffff0000000028 pgbase=0 bytes=4096
> > > > > req=0
> > > > > prevreq=0xffff8955b2f55980
> > > > > -------------8<---------------
> > > > > 
> > > > > What this tells us is that the page at idx=2 got submitted to
> > > > > nfs_do_writepage() (so it was marked dirty in the pagecache), but
> > > > > when
> > > > > it got there, folio->private was NULL and it was ignored.
> > > > > 
> > > > > The kernel in this case is based on v6.9, so it's (just) pre-
> > > > > large-
> > > > > folio support. It has a fair number of NFS patches, but not much
> > > > > to
> > > > > this portion of the code. Most of them are are containerization
> > > > > fixes.
> > > > > 
> > > > > I'm looking askance at nfs_inode_remove_request(). It does this:
> > > > > 
> > > > >         if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > > > >                 struct folio *folio = nfs_page_to_folio(req-
> > > > > > wb_head);
> > > > >                 struct address_space *mapping = folio->mapping;
> > > > > 
> > > > >                 spin_lock(&mapping->i_private_lock);
> > > > >                 if (likely(folio)) {
> > > > >                         folio->private = NULL;
> > > > >                         folio_clear_private(folio);
> > > > >                         clear_bit(PG_MAPPED, &req->wb_head-
> > > > > > wb_flags);
> > > > >                 }
> > > > >                 spin_unlock(&mapping->i_private_lock);
> > > > >         }
> > > > > 
> > > > > If nfs_page_group_sync_on_bit() returns true, then the nfs_page
> > > > > gets
> > > > > detached from the folio. Meanwhile, if a new write request comes
> > > > > in
> > > > > just after that, nfs_lock_and_join_requests() will call
> > > > > nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:
> > > > > 
> > > > > static int
> > > > > nfs_cancel_remove_inode(struct nfs_page *req, struct inode
> > > > > *inode)
> > > > > {
> > > > >         int ret;
> > > > > 
> > > > >         if (!test_bit(PG_REMOVE, &req->wb_flags))
> > > > >                 return 0;
> > > > >         ret = nfs_page_group_lock(req);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >         if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > > > >                 nfs_page_set_inode_ref(req, inode);
> > > > >         nfs_page_group_unlock(req);                          
> > > > >         return 0;                                    
> > > > > }                     
> > > > > 
> > > > > ...but that does not reattach the nfs_page to the folio. Should
> > > > > it?
> > > > >                         
> > > > 
> > > > That's not sufficient AFAICS. Does the following patch work?
> > > > 
> > > > 8<------------------------------------------------------------
> > > > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00
> > > > 2001
> > > > Message-ID:
> > > > <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.mykl
> > > > ebust@hammerspace.com>
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > > > Subject: [PATCH] NFS: Fix a race when updating an existing write
> > > > 
> > > > After nfs_lock_and_join_requests() tests for whether the request is
> > > > still attached to the mapping, nothing prevents a call to
> > > > nfs_inode_remove_request() from succeeding until we actually lock
> > > > the
> > > > page group.
> > > > The reason is that whoever called nfs_inode_remove_request()
> > > > doesn't
> > > > necessarily have a lock on the page group head.
> > > > 
> > > > So in order to avoid races, let's take the page group lock earlier
> > > > in
> > > > nfs_lock_and_join_requests(), and hold it across the removal of the
> > > > request in nfs_inode_remove_request().
> > > > 
> > > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request
> > > > into nfs_lock_and_join_requests")
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > ---
> > > >  fs/nfs/pagelist.c        |  9 +++++----
> > > >  fs/nfs/write.c           | 29 ++++++++++-------------------
> > > >  include/linux/nfs_page.h |  1 +
> > > >  3 files changed, 16 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > > > index 11968dcb7243..6e69ce43a13f 100644
> > > > --- a/fs/nfs/pagelist.c
> > > > +++ b/fs/nfs/pagelist.c
> > > > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> > > >  	nfs_page_clear_headlock(req);
> > > >  }
> > > >  
> > > > -/*
> > > > - * nfs_page_group_sync_on_bit_locked
> > > > +/**
> > > > + * nfs_page_group_sync_on_bit_locked - Test if all requests have
> > > > @bit set
> > > > + * @req: request in page group
> > > > + * @bit: PG_* bit that is used to sync page group
> > > >   *
> > > >   * must be called with page group lock held
> > > >   */
> > > > -static bool
> > > > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned
> > > > int bit)
> > > > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req,
> > > > unsigned int bit)
> > > >  {
> > > >  	struct nfs_page *head = req->wb_head;
> > > >  	struct nfs_page *tmp;
> > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > index fa5c41d0989a..8b7c04737967 100644
> > > > --- a/fs/nfs/write.c
> > > > +++ b/fs/nfs/write.c
> > > > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req,
> > > > struct inode *inode)
> > > >  	}
> > > >  }
> > > >  
> > > > -static int
> > > > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > > > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct
> > > > inode *inode)
> > > >  {
> > > > -	int ret;
> > > > -
> > > > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > > > -		return 0;
> > > > -	ret = nfs_page_group_lock(req);
> > > > -	if (ret)
> > > > -		return ret;
> > > >  	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > > >  		nfs_page_set_inode_ref(req, inode);
> > > > -	nfs_page_group_unlock(req);
> > > > -	return 0;
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -585,19 +575,18 @@ static struct nfs_page
> > > > *nfs_lock_and_join_requests(struct folio *folio)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	ret = nfs_page_group_lock(head);
> > > > +	if (ret < 0)
> > > > +		goto out_unlock;
> > > > +
> > > >  	/* Ensure that nobody removed the request before we locked
> > > > it */
> > > >  	if (head != folio->private) {
> > > > +		nfs_page_group_unlock(head);
> > > >  		nfs_unlock_and_release_request(head);
> > > >  		goto retry;
> > > >  	}
> > > >  
> > > > -	ret = nfs_cancel_remove_inode(head, inode);
> > > > -	if (ret < 0)
> > > > -		goto out_unlock;
> > > > -
> > > > -	ret = nfs_page_group_lock(head);
> > > > -	if (ret < 0)
> > > > -		goto out_unlock;
> > > > +	nfs_cancel_remove_inode(head, inode);
> > > >  
> > > >  	/* lock each request in the page group */
> > > >  	for (subreq = head->wb_this_page;
> > > > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct
> > > > nfs_page *req)
> > > >  {
> > > >  	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
> > > >  
> > > > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > > > +	nfs_page_group_lock(req);
> > > > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> > > >  		struct folio *folio = nfs_page_to_folio(req-
> > > > > wb_head);
> > > >  		struct address_space *mapping = folio->mapping;
> > > >  
> > > > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct
> > > > nfs_page *req)
> > > >  		}
> > > >  		spin_unlock(&mapping->i_private_lock);
> > > >  	}
> > > > +	nfs_page_group_unlock(req);
> > > >  
> > > >  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> > > >  		atomic_long_dec(&nfsi->nrequests);
> > > > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > > > index 169b4ae30ff4..9aed39abc94b 100644
> > > > --- a/include/linux/nfs_page.h
> > > > +++ b/include/linux/nfs_page.h
> > > > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page
> > > > *head,
> > > >  extern int nfs_page_group_lock(struct nfs_page *);
> > > >  extern void nfs_page_group_unlock(struct nfs_page *);
> > > >  extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned
> > > > int);
> > > > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *,
> > > > unsigned int);
> > > >  extern	int nfs_page_set_headlock(struct nfs_page *req);
> > > >  extern void nfs_page_clear_headlock(struct nfs_page *req);
> > > >  extern bool nfs_async_iocounter_wait(struct rpc_task *, struct
> > > > nfs_lock_context *);
> > > 
> > > I backported this patch to the kernel we've been using to reproduce
> > > this and have had the test running for almost 24 hours now. The
> > > longest
> > > it's taken to reproduce on this test rig is about 12 hours. So, the
> > > initial signs are good.
> > > 
> > > The patch also looks good to me. This one took a while to track down,
> > > and I needed a lot of help to set up the test rig. Can you add these?
> > > 
> > > Tested-by: Joe Quanaim <jdq@meta.com>
> > > Tested-by: Andrew Steffen <aksteffen@meta.com>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > 
> > > Joe and Andrew spent a lot of time getting us a reproducer.
> > > 
> > > I assume we also want to send this to stable? I'm pretty sure the
> > > Fixes: tag is wrong. The kernel we were using didn't have that patch.
> > > I
> > > took a look at some earlier releases, and AFAICT, this bug has been
> > > present for a long time -- at least since v6.0 and probably well
> > > before.
> > > 
> > 
> > I've set
> > Fixes: bd37d6fce184 ("NFSv4: Convert nfs_lock_and_join_requests() to use nfs_page_find_head_request()")
> > 
> > on the very latest commit tags. That's about as far back as I can trace
> > it before going cross-eyed.
> 
> Thanks. Looks like that went into v4.14. That's probably far enough. :)

Indeed, but we'll need to provide specialized backports for each
stable@ kernel the further back it needed.  So your 6.9 backport might
help with 6.6.  The other active older stable trees are 6.1 and 6.12.

Gregkh et al will quickly defer to domain experts to see that a fix
like this lands everywhere it needed.

Mike

