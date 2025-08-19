Return-Path: <linux-nfs+bounces-13789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F564B2CE9C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 23:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05071C22AC3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590824C68B;
	Tue, 19 Aug 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9z04e6m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2923B615
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639487; cv=none; b=UBSywn6F9f1G23/Z6rxZuhAwsELQ4n6hBneNnAnZbpaCUAN4XLhLdU4j/Pzqm8anodbssIWMfmo1BgTHwY9sR8HxV0qJWbemv0GwCxNpsKzX0rDfVoXMz/mBAmkjYs34GgXU9ziQXSIIdZHAbH5M5SvGF7DUbyNyavtnJxXcAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639487; c=relaxed/simple;
	bh=C8iaAYckqF83TmKeYGB8ISdTsHnAg82SCxn/R0s7LQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBwlkuoYOAYo8q2wc7n83xvwU9V5GUZ3QGVEfZG/l7Dz4+RNISjoNc0fBSc0g972kgLCH6mszGCAsUVcwIyfSU0gLUfOmGog6MEQLcw9aRhPa17HqKimIXEipmwr1TVEXYX/ivuQYbYxSc3O6WQX8Y5q/ILlN7GV0tQiTwiP2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9z04e6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062F4C4CEF1;
	Tue, 19 Aug 2025 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755639487;
	bh=C8iaAYckqF83TmKeYGB8ISdTsHnAg82SCxn/R0s7LQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9z04e6m+O3QrtsGM8D4mEbUXbfJ5CmY6+lUuUGQK2jikL1ZoTSrrImDs6mCmfBvB
	 YlQSz8ZRfT1jYooH8wveHjDEQXCFzWkENuLZDiKxGqdzppDR82t8100nPRMbDOLTcr
	 HvD0a/9h5QgYERBk3gbKAlTGal89oaaNkPfLh0jOWku/AWvBzEfiYevj9ElUCd5K9z
	 YRG3OZeKyKGf09KnJGuoQrtwZz5KzZMWFovaqR8BaQzY2N10LCXusJ3uo1RBIJTmKF
	 m/9ArBe0LHspHjyV4xybfcwpTY5TODnbfoejPesGPt6JkVR77WCFBzlv1h5E706iit
	 ROu77cIRjhh2g==
Date: Tue, 19 Aug 2025 17:38:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	jonathan.flynn@hammerspace.com
Subject: seeing CRC mismatch with NFS DIRECT WRITE when
 localio_O_DIRECT_align_misaligned_IO=Y
Message-ID: <aKTuvJiJdnchV38f@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
 <aKD3SFcyCnb8snst@kernel.org>
 <aKTEsmOAXsHEGEEz@kernel.org>
 <06e0e537326414677386eab40a27d5cf1b3ea3c1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e0e537326414677386eab40a27d5cf1b3ea3c1.camel@kernel.org>

On Tue, Aug 19, 2025 at 04:13:16PM -0400, Jeff Layton wrote:
> On Tue, 2025-08-19 at 14:38 -0400, Mike Snitzer wrote:
> > On Sat, Aug 16, 2025 at 05:25:28PM -0400, Mike Snitzer wrote:
> > > On Sat, Aug 16, 2025 at 07:51:17AM -0700, Trond Myklebust wrote:
> > > > 
> > > > That's not sufficient AFAICS. Does the following patch work?
> > > > 
> > > > 8<------------------------------------------------------------
> > > > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00 2001
> > > > Message-ID: <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.myklebust@hammerspace.com>
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > > > Subject: [PATCH] NFS: Fix a race when updating an existing write
> > > > 
> > > > After nfs_lock_and_join_requests() tests for whether the request is
> > > > still attached to the mapping, nothing prevents a call to
> > > > nfs_inode_remove_request() from succeeding until we actually lock the
> > > > page group.
> > > > The reason is that whoever called nfs_inode_remove_request() doesn't
> > > > necessarily have a lock on the page group head.
> > > > 
> > > > So in order to avoid races, let's take the page group lock earlier in
> > > > nfs_lock_and_join_requests(), and hold it across the removal of the
> > > > request in nfs_inode_remove_request().
> > > > 
> > > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > ---
> > > >  fs/nfs/pagelist.c        |  9 +++++----
> > > >  fs/nfs/write.c           | 29 ++++++++++-------------------
> > > >  include/linux/nfs_page.h |  1 +
> > > >  3 files changed, 16 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > > > index 11968dcb7243..6e69ce43a13f 100644
> > > > --- a/fs/nfs/pagelist.c
> > > > +++ b/fs/nfs/pagelist.c
> > > > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> > > >  	nfs_page_clear_headlock(req);
> > > >  }
> > > >  
> > > > -/*
> > > > - * nfs_page_group_sync_on_bit_locked
> > > > +/**
> > > > + * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
> > > > + * @req: request in page group
> > > > + * @bit: PG_* bit that is used to sync page group
> > > >   *
> > > >   * must be called with page group lock held
> > > >   */
> > > > -static bool
> > > > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
> > > > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
> > > >  {
> > > >  	struct nfs_page *head = req->wb_head;
> > > >  	struct nfs_page *tmp;
> > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > index fa5c41d0989a..8b7c04737967 100644
> > > > --- a/fs/nfs/write.c
> > > > +++ b/fs/nfs/write.c
> > > > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
> > > >  	}
> > > >  }
> > > >  
> > > > -static int
> > > > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > > > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > > >  {
> > > > -	int ret;
> > > > -
> > > > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > > > -		return 0;
> > > > -	ret = nfs_page_group_lock(req);
> > > > -	if (ret)
> > > > -		return ret;
> > > >  	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > > >  		nfs_page_set_inode_ref(req, inode);
> > > > -	nfs_page_group_unlock(req);
> > > > -	return 0;
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	ret = nfs_page_group_lock(head);
> > > > +	if (ret < 0)
> > > > +		goto out_unlock;
> > > > +
> > > >  	/* Ensure that nobody removed the request before we locked it */
> > > >  	if (head != folio->private) {
> > > > +		nfs_page_group_unlock(head);
> > > >  		nfs_unlock_and_release_request(head);
> > > >  		goto retry;
> > > >  	}
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
> > > >  	/* lock each request in the page group */
> > > >  	for (subreq = head->wb_this_page;
> > > > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
> > > >  {
> > > >  	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
> > > >  
> > > > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > > > +	nfs_page_group_lock(req);
> > > > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> > > >  		struct folio *folio = nfs_page_to_folio(req->wb_head);
> > > >  		struct address_space *mapping = folio->mapping;
> > > >  
> > > > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
> > > >  		}
> > > >  		spin_unlock(&mapping->i_private_lock);
> > > >  	}
> > > > +	nfs_page_group_unlock(req);
> > > >  
> > > >  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> > > >  		atomic_long_dec(&nfsi->nrequests);
> > > > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > > > index 169b4ae30ff4..9aed39abc94b 100644
> > > > --- a/include/linux/nfs_page.h
> > > > +++ b/include/linux/nfs_page.h
> > > > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
> > > >  extern int nfs_page_group_lock(struct nfs_page *);
> > > >  extern void nfs_page_group_unlock(struct nfs_page *);
> > > >  extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
> > > > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
> > > >  extern	int nfs_page_set_headlock(struct nfs_page *req);
> > > >  extern void nfs_page_clear_headlock(struct nfs_page *req);
> > > >  extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
> > > > -- 
> > > > 2.50.1
> > > > 
> > > > 
> > > 
> > > 
> > > Trond,
> > > 
> > > You're the best! ;)
> > > 
> > > Your patch fixes corruption I've been chasing for the past week
> > > relative to NFS DIRECT, specifically with:
> > > echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_align_misaligned_IO
> > > 
> > > So you need my latest NFS DIRECT patchset:
> > > https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/
> > > 
> > > With it, writes would be corrupted when using the attached reproducer
> > > (from Jon Flynn, with the assistance of ChatGPT) that pulls out the
> > > subset of MLperf unet3d test (when ran in buffered IO mode, so
> > > entirely misaligned relative to DIO-alignment requirements) that we've
> > > seen npz CRC compare failure with.
> > > 
> > > I tested my patchset with your patch applied and it all "just works".
> > > 
> > > Ship it all!
> > > 
> > > Thanks,
> > > Mike
> > > 
> > > ps. running the attached reproducer is as simple as:
> > > ./mlperf_npz_tool.py --npz-path /mnt/share1/sample_a.npz
> > 
> > So even with this patch there is something still causing data
> > corruption on much faster systems.  This mlperf_npz_tool.py reproducer
> > works fine on a slower VMware based testbed, but once I load the same
> > kernel (with Trond's fix applied) on a very fast baremetal system I
> > still see CRC mismatch due to write corruption if
> > localio_O_DIRECT_align_misaligned_IO=Y (from my NFS DIRECT patchset).
> > 
> > Again, both of my latest NFSD DIRECT and NFS DIRECT patchsets are
> > applied:
> > https://lore.kernel.org/linux-nfs/20250815144607.50967-1-snitzer@kernel.org/
> > https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/
> > 
> > And I'm hacking nfs4 to impose O_DIRECT on buffered IO (reproducer
> > doesn't open its files with O_DIRECT but NFS client acts like it did).
> > I can dig out the patch to achieve that if others are interested.
> > 
> > Mike
> 
> Can you compare a corrupt file with the expected output? That might
> give us a clue about the nature of this bug.

While it _is_ interesting that "speed kills" my particular lithmus
test: I've changed the $SUBJECT because this issue could easily be
unique to my new NFS DIRECT code or the test itself.  So best to
divorce my issue from the original issue you reported that was the
catalyst for Trond's fix (that did seem to help my testcase).

To be clear, this may well be some bug in the python application (that
happens to be part of the MLperf "industry benchmark")...

Using other tools to verify data integrity have all passed.  In
particular, dt isn't able to see any issues (but dt is more of an open
secret in the utility belt of companies like NetApp, Red Hat, now
Hammerspace, etc): https://github.com/RobinTMiller/dt.git
This patch header in the NFSD DIRECT series shows how dt proved very
useful:
https://lore.kernel.org/linux-nfs/20250815144607.50967-6-snitzer@kernel.org/

But back to the mlperf_npz_tool.py, I can easily generate good vs bad
files, any words of wisdom for useful tools to analyze the
differences?  ChatGPT?  Other AIs?

hexdump isn't showing useful or approachable differences, basically
the entire good vs bad file is different:

# hexdump /tmp/good.npz > /root/analyze_this/good.hd
# hexdump /tmp/bad.npz > /root/analyze_this/bad.hd
# diff -Naur /root/analyze_this/good.hd /root/analyze_this/bad.hd > hd.diff

# ls -alh
total 1.7G
drwxr-xr-x   2 root root   50 Aug 19 20:53 .
dr-xr-x---. 25 root root 4.0K Aug 19 20:56 ..
-rw-r--r--   1 root root 421M Aug 19 20:52 bad.hd
-rw-r--r--   1 root root 421M Aug 19 20:51 good.hd
-rw-r--r--   1 root root 803M Aug 19 20:54 hd.diff

# less hd.diff
--- /root/analyze_this/good.hd  2025-08-19 20:51:55.797022245 +0000
+++ /root/analyze_this/bad.hd   2025-08-19 20:52:14.868669416 +0000
@@ -254,983046 +254,983046 @@
 0000fd0 a73d eae0 f2b0 df27 6098 16be b990 f5b0
 0000fe0 e2d1 857f 1843 6b2f 079b f319 5386 b6f7
 0000ff0 e5ac ec09 29cd 17e9 1341 8a18 e54b 5057
-0001000 7711 ef46 982e fe27 a0b5 0d2f 0f05 0130
-0001010 d6e2 4a4c 74be f4cc a1ed cd98 fe09 0ba0
-0001020 65b5 05a1 426f 7658 c9d9 0381 8ed5 b4ad
...
+0001000 2325 8099 b007 9fd9 8596 01fe ae93 d384
+0001010 422e 7685 abab 0d9b 0a05 b4e9 b774 f619
+0001020 10fc 37d0 9e72 795c 82cd c9c8 9cac 4665
...
 8b01000 ce50 6a33 b82d f7ce 0699 5948 1a7e 4e33
 8b01010 ed0c f087 853e 952b 77c4 6e51 2790 26af
 8b01020 d588 4bc7 313e d729 c20f 4412 8844 8fa6

Mike

