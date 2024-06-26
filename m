Return-Path: <linux-nfs+bounces-4321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C19187E6
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5644B261FD
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E118F2EE;
	Wed, 26 Jun 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT2vYedf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475118F2C9
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420565; cv=none; b=IaMbffSA0JOmAQ0z8oSZcJWfT+AuryZ9aEnCcJtFOypQFNFUyyrPL/j/Ew7aBjDwoieACoFRwa+58rOjDVMLXVOd3beJrwBE7IA9P/+S6+OE1lNkJgIOWdD4/Mxyl9vtKpHOa/06149MK4/6Mhw6NwpJRMd3xMAkVBPVzwGt8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420565; c=relaxed/simple;
	bh=cZtoET+oK9Ia07TmFejRa22QX7VP5D2bw5LynXe6nJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th+UByHE/QQ/q5YjB9lORQrI+6QnyT2aLQRsTLReWdxazWppZoYNpzZYH5wLwec8HGfxDY/BAoBQ5TTmlz2yIqBd8UJNd193VsjjSI5YWIZh+h2e2sqImIwXhgXcuYtmlI6mwHC0XFA/8OLOzjyYBcnEtYKelrEOGwlwaGnnFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT2vYedf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C89C116B1;
	Wed, 26 Jun 2024 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420564;
	bh=cZtoET+oK9Ia07TmFejRa22QX7VP5D2bw5LynXe6nJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT2vYedf4I50p78PKGBlrg7S5qpvjSz/pdhNCZB1B7RbpIrhp1ms+9tB7TdsZTRA9
	 nCMzk4w1iKW+g5pOSWcXyrrPK9NenfLGV8hDDKRvVVUjCSed9xfBPAmVasdMsgh4H2
	 UJYiCkehELzGdGhiUPi/OYTptWAiyjTqG3npMenG4Iw6sMcka06d1SPq0UOZlEkyoW
	 TbykmczTTFyjURqrYJRpgWEPr3pLEbUnVu09B/nVGs3YyjcrQSoDdv7ckfRDhUpa4X
	 90Nt8DfRUh3utX76bbInuWEwf9EtWUnzHryaYWFhyyIj9STPjX9euQWy4zgfiCyIz4
	 UfVioFgwypGpA==
Date: Wed, 26 Jun 2024 12:49:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 17/20] nfsd: use SRCU to dereference nn->nfsd_serv
Message-ID: <ZnxGk4N5WRhAUXdL@kernel.org>
References: <>
 <9473de7704c599192a91b12465e3f6aba278d10e.camel@kernel.org>
 <171935815356.14261.943840832291192923@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171935815356.14261.943840832291192923@noble.neil.brown.name>

On Wed, Jun 26, 2024 at 09:29:13AM +1000, NeilBrown wrote:
> On Tue, 25 Jun 2024, Jeff Layton wrote:
> > On Mon, 2024-06-24 at 12:27 -0400, Mike Snitzer wrote:
> > > Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
> > > the nfsd code to prevent nfsd_destroy_serv from destroying
> > > nn->nfsd_serv until all nfsd code is done with it (particularly the
> > > localio code that doesn't run in the context of nfsd's svc threads,
> > > nor does it take the nfsd_mutex).
> > > 
> > > Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
> > > familiar well-worn pattern for how implement.
> > > 
> > > Suggested-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/filecache.c | 13 ++++++++---
> > >  fs/nfsd/netns.h     | 14 ++++++++++--
> > >  fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
> > >  fs/nfsd/nfsctl.c    |  7 ++++--
> > >  fs/nfsd/nfssvc.c    | 54 ++++++++++++++++++++++++++++++++++++---------
> > >  5 files changed, 88 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 99631fa56662..474b3a3af3fb 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
> > >  		struct nfsd_file *nf = list_first_entry(dispose,
> > >  						struct nfsd_file, nf_lru);
> > >  		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> > > +		int srcu_idx;
> > > +		struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
> > >  		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> > >  
> > >  		spin_lock(&l->lock);
> > >  		list_move_tail(&nf->nf_lru, &l->freeme);
> > >  		spin_unlock(&l->lock);
> > > -		svc_wake_up(nn->nfsd_serv);
> > > +		svc_wake_up(serv);
> > > +		nfsd_serv_put(nn, srcu_idx);
> > >  	}
> > >  }
> > >  
> > > @@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
> > >  		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
> > >  			list_move(l->freeme.next, &dispose);
> > >  		spin_unlock(&l->lock);
> > > -		if (!list_empty(&l->freeme))
> > > +		if (!list_empty(&l->freeme)) {
> > > +			int srcu_idx;
> > > +			struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
> > >  			/* Wake up another thread to share the work
> > >  			 * *before* doing any actual disposing.
> > >  			 */
> > > -			svc_wake_up(nn->nfsd_serv);
> > > +			svc_wake_up(serv);
> > > +			nfsd_serv_put(nn, srcu_idx);
> > > +		}
> > >  		nfsd_file_dispose_list(&dispose);
> > >  	}
> > >  }
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 0c5a1d97e4ac..92d0d0883f17 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -139,8 +139,14 @@ struct nfsd_net {
> > >  	u32 clverifier_counter;
> > >  
> > >  	struct svc_info nfsd_info;
> > > -#define nfsd_serv nfsd_info.serv
> > > -
> > > +	/*
> > > +	 * The current 'nfsd_serv' at nfsd_info.serv.  Using 'void' rather than
> > > +	 * 'struct svc_serv' to guard against new code dereferencing nfsd_serv
> > > +	 * without using proper synchronization.
> > > +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> > > +	 */
> > > +	void __rcu *nfsd_serv;
> > > +	struct srcu_struct nfsd_serv_srcu;
> > 
> > I'm still not sold on the use of a void pointer here. It might protect
> > you from using nn->nfsd_serv directly, but if you do:
> > 
> >     struct svc_serv *serv = nn->nfsd_serv;
> > 
> > ...that will still work. If you really want to guard against direct
> > dereferencing, maybe it should be an unsigned long? Then you really
> > will have to cast to use it.
> 
> I agree.  The point of the "__rcu" attribute is that sparse will
> complain if you use the pointer without using srcu_dereference().
> And CONFIG_PROVE_RCU gives you run-time splats.
> We should use the tools we already have.

Good news, I've switched from using SRCU to a percpu-refcount.  So v8
will be considerably cleaner (less shotgun blast due to dropping the
excessive churn from SRCU prep and implementation).

SRCU would've enabled us to drop the client notifier spinlock, and
maybe more but certianly best to avoid all the SRCU changes.

Mike

