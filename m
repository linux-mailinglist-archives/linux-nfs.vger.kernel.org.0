Return-Path: <linux-nfs+bounces-4077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136DF90F4FE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C1285394
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E30155C8B;
	Wed, 19 Jun 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvC5B15y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D0155C8A
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817987; cv=none; b=OjtEuUCWYsoMZpH1p1JWTL7XunS6cBuDk0+OxK2HITF6DXgNwOjlssPUePZ/mflTPM9q8X6uQMj9V1dSzLJwv9vmsrNT0VntR8yrMy4IwcBBcoWfT9BPV9buuSH+JbLl3WkjHI6XkX++Ku/3oHm6YdDrfTv20ieXchfSeeZ0UBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817987; c=relaxed/simple;
	bh=ilCFfZGmqUK0y5pVuZCP6Vs0M/4k/wVAGQPDXv2KjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPHodL8xR3MG7whayK7hWuc/qip6zTOh+kaO5uOfpwxYSqxqm2+nHS4LKIgyLVtzAG6KBtWL8jHmZbR7odYyTrbjoxYQjbsw3fe2S3VEfH8LvgCCW2fsudgfexQUQN+L6kfc6uo1ek8vRiMHZktOuewg4A2/9ghO+Bc5x9Z4Bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvC5B15y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD79C2BBFC;
	Wed, 19 Jun 2024 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718817984;
	bh=ilCFfZGmqUK0y5pVuZCP6Vs0M/4k/wVAGQPDXv2KjJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvC5B15ypCXKTjmt6L9UX8zLRlG6omY+KsnS3BVxKCK9k7aJFHCOFmAiq8BqSKv/3
	 p5jAiGAMQND03nZA/Hmknv6ao8KxcBSrgT0mhhsOfDSMbmuuN6NQEvd9TM9CKhmyCS
	 doO4/fEB/m9v5brUD/pDtd4NSo3DLmLd8KGf6dOxdciCArm0P/FHH6QW7utdiV2e9I
	 v/QqYnQ6aQLulNi3Z0bomtIwAFT0wXd7cqYLucKod6H9RyBcPhT93kN7kN4UVL+W2n
	 LM33INVuE7pTPsXhdAtyiOyongEQh5iBMuwzbMUv1QXe9Uo0qZsobMPkRtMPyBNOAo
	 21UXd76lW+biQ==
Date: Wed, 19 Jun 2024 13:26:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 16/19] nfsd: use SRCU to dereference nn->nfsd_serv
Message-ID: <ZnMUv3NJ7w1cE5dU@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <20240618201949.81977-17-snitzer@kernel.org>
 <808b8e465430e66b5b3c3bf048a3a165ba41231b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808b8e465430e66b5b3c3bf048a3a165ba41231b.camel@kernel.org>

On Wed, Jun 19, 2024 at 08:39:46AM -0400, Jeff Layton wrote:
> On Tue, 2024-06-18 at 16:19 -0400, Mike Snitzer wrote:
> > Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
> > the nfsd code to prevent nfsd_destroy_serv from destroying
> > nn->nfsd_serv until all nfsd code is done with it (particularly the
> > localio code that doesn't run in the context of nfsd's svc threads,
> > nor does it take the nfsd_mutex).
> > 
> > Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
> > familiar well-worn pattern for how implement.
> > 
> > Suggested-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 13 ++++++++---
> >  fs/nfsd/netns.h     | 12 ++++++++--
> >  fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
> >  fs/nfsd/nfsctl.c    |  7 ++++--
> >  fs/nfsd/nfssvc.c    | 55 ++++++++++++++++++++++++++++++++++++---------
> >  5 files changed, 87 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 99631fa56662..474b3a3af3fb 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
> >  		struct nfsd_file *nf = list_first_entry(dispose,
> >  						struct nfsd_file, nf_lru);
> >  		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> > +		int srcu_idx;
> > +		struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
> >  		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> >  
> >  		spin_lock(&l->lock);
> >  		list_move_tail(&nf->nf_lru, &l->freeme);
> >  		spin_unlock(&l->lock);
> > -		svc_wake_up(nn->nfsd_serv);
> > +		svc_wake_up(serv);
> > +		nfsd_serv_put(nn, srcu_idx);
> >  	}
> >  }
> >  
> > @@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
> >  		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
> >  			list_move(l->freeme.next, &dispose);
> >  		spin_unlock(&l->lock);
> > -		if (!list_empty(&l->freeme))
> > +		if (!list_empty(&l->freeme)) {
> > +			int srcu_idx;
> > +			struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
> >  			/* Wake up another thread to share the work
> >  			 * *before* doing any actual disposing.
> >  			 */
> > -			svc_wake_up(nn->nfsd_serv);
> > +			svc_wake_up(serv);
> > +			nfsd_serv_put(nn, srcu_idx);
> > +		}
> >  		nfsd_file_dispose_list(&dispose);
> >  	}
> >  }
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 0c5a1d97e4ac..0eebcc03bcd3 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -139,8 +139,12 @@ struct nfsd_net {
> >  	u32 clverifier_counter;
> >  
> >  	struct svc_info nfsd_info;
> > -#define nfsd_serv nfsd_info.serv
> > -
> > +	/*
> > +	 * The current 'nfsd_serv' at nfsd_info.serv
> > +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> > +	 */
> > +	void __rcu *nfsd_serv;
> 
> I don't understand why you need a void pointer here. This should only
> ever hold a pointer to the serv or NULL. It seems like this work just
> as well: 
> 
> 	struct svc_serv __rcu *nfsd_serv;
> 

It is defensive, future-proofs us from some new code being introduced
that dereferences nn->nfsd_serv without proper use of nfsd_serv_get().


> > @@ -589,9 +615,12 @@ void nfsd_destroy_serv(struct net *net)
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv = nn->nfsd_serv;
> >  
> > +	lockdep_assert_held(&nfsd_mutex);
> > +
> >  	spin_lock(&nfsd_notifier_lock);
> > -	nn->nfsd_serv = NULL;
> > +	rcu_assign_pointer(nn->nfsd_serv, NULL);
> >  	spin_unlock(&nfsd_notifier_lock);
> > +	nfsd_serv_sync(nn);
> >  
> >  	/* check if the notifier still has clients */
> >  	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
> > @@ -711,6 +740,10 @@ int nfsd_create_serv(struct net *net)
> >  	if (nn->nfsd_serv)
> >  		return 0;
> >  
> > +	error = init_srcu_struct(&nn->nfsd_serv_srcu);
> > +	if (error)
> > +		return error;
> > +
> >  	if (nfsd_max_blksize == 0)
> >  		nfsd_max_blksize = nfsd_get_default_max_blksize();
> >  	nfsd_reset_versions(nn);
> > @@ -727,8 +760,10 @@ int nfsd_create_serv(struct net *net)
> >  	}
> >  	spin_lock(&nfsd_notifier_lock);
> >  	nn->nfsd_info.mutex = &nfsd_mutex;
> > -	nn->nfsd_serv = serv;
> > +	nn->nfsd_info.serv = serv;
> > +	rcu_assign_pointer(nn->nfsd_serv, nn->nfsd_info.serv);
> >  	spin_unlock(&nfsd_notifier_lock);
> > +	nfsd_serv_sync(nn);
> 
> I get why you're doing the synchronize on destroy, but why on the
> create? You're not tearing anything down here, so I don't see the need
> to ensure synchronization.

Yeah, it isn't needed.  Fixed, thanks.

Mike

