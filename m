Return-Path: <linux-nfs+bounces-13785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CAB2CC38
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11EC3B5DCD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E22E2295;
	Tue, 19 Aug 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PatBktCA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54C23815D
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628724; cv=none; b=e5RUFWd5XVcVSY5kFuHmYwIOLko8ZOYE0S5xpn+3ueqCjUd9dOAcZ9UxL2/7tzvc/A3jXGaTDORLflwog2oJwyx8gemrshaEb4yVVKLgM/28AhlE8dGn0weOvtepiNAzmZKKHraqsBFOHa1hnQWVZ82jaUmXLR7CKVHzflVfVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628724; c=relaxed/simple;
	bh=1908dNV8ogOK65RJyqKNMdQIjPP/6KDZFCg+MQwMrSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA4m1adWNr3dvSNcwRYtmAanG7mE3gEkx5qgzKNmczpykgQxzZoLZKyyFPvxftIHC3MRAtF3DKw9mKSL9FTAzXzPr91vm1jFrG3w1x0hqCgbVlaguZAXWM2MzVK4YN68txD97vXEuNyBk5fZB4KiTBJ8NyeozN/R1NHzOy/s75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PatBktCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549FFC4CEF4;
	Tue, 19 Aug 2025 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628723;
	bh=1908dNV8ogOK65RJyqKNMdQIjPP/6KDZFCg+MQwMrSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PatBktCAPNFy5KBWcUFVun+H1qIbWOYDEm5ez6DY/MmcBmWwUm+h4eGgTGnCz4chp
	 Ox3Ky6KOta1+WV/5o3I4VzLMxyVHmtCCKWSt8v9ofzjl25p31wNPW8K75mBpoYaKTu
	 ZGQsyoTcDBrnazYCt4clIHTVRUOT9Qaqxh4lt8VVztCost3JStwIfi4wfKeGGuYy/T
	 JRnrcWKjxL05DA33Bm3HsgzTBwL09IHndWYaxRg5P2KhVd2bsCjFbSY/AN4z077/p3
	 GUxkVMrMrQ8y0hFnDjwYY7RGuPbq7PD0u5YI4mE7dzaugtLLTjYe6dN2VMZO0CHyav
	 Y9Gdv5drOcyzg==
Date: Tue, 19 Aug 2025 14:38:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	jonathan.flynn@hammerspace.com
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
Message-ID: <aKTEsmOAXsHEGEEz@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
 <aKD3SFcyCnb8snst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKD3SFcyCnb8snst@kernel.org>

On Sat, Aug 16, 2025 at 05:25:28PM -0400, Mike Snitzer wrote:
> On Sat, Aug 16, 2025 at 07:51:17AM -0700, Trond Myklebust wrote:
> > 
> > That's not sufficient AFAICS. Does the following patch work?
> > 
> > 8<------------------------------------------------------------
> > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00 2001
> > Message-ID: <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.myklebust@hammerspace.com>
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > Subject: [PATCH] NFS: Fix a race when updating an existing write
> > 
> > After nfs_lock_and_join_requests() tests for whether the request is
> > still attached to the mapping, nothing prevents a call to
> > nfs_inode_remove_request() from succeeding until we actually lock the
> > page group.
> > The reason is that whoever called nfs_inode_remove_request() doesn't
> > necessarily have a lock on the page group head.
> > 
> > So in order to avoid races, let's take the page group lock earlier in
> > nfs_lock_and_join_requests(), and hold it across the removal of the
> > request in nfs_inode_remove_request().
> > 
> > Reported-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/pagelist.c        |  9 +++++----
> >  fs/nfs/write.c           | 29 ++++++++++-------------------
> >  include/linux/nfs_page.h |  1 +
> >  3 files changed, 16 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index 11968dcb7243..6e69ce43a13f 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> >  	nfs_page_clear_headlock(req);
> >  }
> >  
> > -/*
> > - * nfs_page_group_sync_on_bit_locked
> > +/**
> > + * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
> > + * @req: request in page group
> > + * @bit: PG_* bit that is used to sync page group
> >   *
> >   * must be called with page group lock held
> >   */
> > -static bool
> > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
> > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
> >  {
> >  	struct nfs_page *head = req->wb_head;
> >  	struct nfs_page *tmp;
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index fa5c41d0989a..8b7c04737967 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
> >  	}
> >  }
> >  
> > -static int
> > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> >  {
> > -	int ret;
> > -
> > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > -		return 0;
> > -	ret = nfs_page_group_lock(req);
> > -	if (ret)
> > -		return ret;
> >  	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> >  		nfs_page_set_inode_ref(req, inode);
> > -	nfs_page_group_unlock(req);
> > -	return 0;
> >  }
> >  
> >  /**
> > @@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
> >  		}
> >  	}
> >  
> > +	ret = nfs_page_group_lock(head);
> > +	if (ret < 0)
> > +		goto out_unlock;
> > +
> >  	/* Ensure that nobody removed the request before we locked it */
> >  	if (head != folio->private) {
> > +		nfs_page_group_unlock(head);
> >  		nfs_unlock_and_release_request(head);
> >  		goto retry;
> >  	}
> >  
> > -	ret = nfs_cancel_remove_inode(head, inode);
> > -	if (ret < 0)
> > -		goto out_unlock;
> > -
> > -	ret = nfs_page_group_lock(head);
> > -	if (ret < 0)
> > -		goto out_unlock;
> > +	nfs_cancel_remove_inode(head, inode);
> >  
> >  	/* lock each request in the page group */
> >  	for (subreq = head->wb_this_page;
> > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
> >  {
> >  	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
> >  
> > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > +	nfs_page_group_lock(req);
> > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> >  		struct folio *folio = nfs_page_to_folio(req->wb_head);
> >  		struct address_space *mapping = folio->mapping;
> >  
> > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
> >  		}
> >  		spin_unlock(&mapping->i_private_lock);
> >  	}
> > +	nfs_page_group_unlock(req);
> >  
> >  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> >  		atomic_long_dec(&nfsi->nrequests);
> > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > index 169b4ae30ff4..9aed39abc94b 100644
> > --- a/include/linux/nfs_page.h
> > +++ b/include/linux/nfs_page.h
> > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
> >  extern int nfs_page_group_lock(struct nfs_page *);
> >  extern void nfs_page_group_unlock(struct nfs_page *);
> >  extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
> > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
> >  extern	int nfs_page_set_headlock(struct nfs_page *req);
> >  extern void nfs_page_clear_headlock(struct nfs_page *req);
> >  extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
> > -- 
> > 2.50.1
> > 
> > 
> 
> 
> Trond,
> 
> You're the best! ;)
> 
> Your patch fixes corruption I've been chasing for the past week
> relative to NFS DIRECT, specifically with:
> echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_align_misaligned_IO
> 
> So you need my latest NFS DIRECT patchset:
> https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/
> 
> With it, writes would be corrupted when using the attached reproducer
> (from Jon Flynn, with the assistance of ChatGPT) that pulls out the
> subset of MLperf unet3d test (when ran in buffered IO mode, so
> entirely misaligned relative to DIO-alignment requirements) that we've
> seen npz CRC compare failure with.
> 
> I tested my patchset with your patch applied and it all "just works".
> 
> Ship it all!
> 
> Thanks,
> Mike
> 
> ps. running the attached reproducer is as simple as:
> ./mlperf_npz_tool.py --npz-path /mnt/share1/sample_a.npz

So even with this patch there is something still causing data
corruption on much faster systems.  This mlperf_npz_tool.py reproducer
works fine on a slower VMware based testbed, but once I load the same
kernel (with Trond's fix applied) on a very fast baremetal system I
still see CRC mismatch due to write corruption if
localio_O_DIRECT_align_misaligned_IO=Y (from my NFS DIRECT patchset).

Again, both of my latest NFSD DIRECT and NFS DIRECT patchsets are
applied:
https://lore.kernel.org/linux-nfs/20250815144607.50967-1-snitzer@kernel.org/
https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/

And I'm hacking nfs4 to impose O_DIRECT on buffered IO (reproducer
doesn't open its files with O_DIRECT but NFS client acts like it did).
I can dig out the patch to achieve that if others are interested.

Mike

