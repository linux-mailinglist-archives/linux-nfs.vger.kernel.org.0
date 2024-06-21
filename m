Return-Path: <linux-nfs+bounces-4226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4799130FB
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 01:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0CB286BD5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825D16E86A;
	Fri, 21 Jun 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlB6crW1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250738FB9
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014324; cv=none; b=py/Z8rAphPO1FJDDgLvfplwNbeeoX1p4zlEKDDXAANcH9WHYdWPVyQaN3PRm7OwQUWyqo3rYUyd8twHSXzqca6DBLZIqLvrmWuYuEwj7bvKBob/PsZKWhBkiqfJ9/W+keYmUdwuQLF22k6osSaPR/0eqgvCHhRE1+Xm+e1rLJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014324; c=relaxed/simple;
	bh=M37eRCS6waoF++4/JqtjmQeZ/o+Q7BsyEisN3o7VKyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLh2dV+1Hal+Tihg7ewqgPDOBBx4Vn6/S+s0mmj2864uigedzPsTWLSMkTQHoUZAq6u6m006IuIXAPJNLyOmMxGuS5wzEXPQl8hGh7+y5KvwhHqNddDuupQoDFCUlL7N0th0Yuz0WqISXNSI3fJ0ZQxGdDybwOP8iec1kJPmT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlB6crW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD85C2BBFC;
	Fri, 21 Jun 2024 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719014323;
	bh=M37eRCS6waoF++4/JqtjmQeZ/o+Q7BsyEisN3o7VKyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlB6crW1+fFJ5nxafUL8RbIQjfMA7R0YYodC8qSmqWy4Crwfs/btg2ft6er+m+l6E
	 Jq+oO661h/WNFNjca1cZB4KX9vazCiCo8Or/M8yFbrGIc4SYlE0mrTgzGtE2GqA84P
	 H7xxVN2Z9zhU4Vl8gBqmBcG9pmWZCngLnNPzEmEECU1lYvSjz1xfMU9w4CPiWCab0L
	 GABzS76+2O5VHxdXzCp9fwHJUhJOcjYoBQLlcSghgeZ0TgIVGpWuIkIEoJWAPxnlGW
	 n7UEQDopCYkuO7D6YN7PDgC956hsjU9zGqytgTAblkMiYka+Q39w1mpMNPITlwQ8LP
	 fkM7LEwFIzHeg==
Date: Fri, 21 Jun 2024 19:58:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 15/18] nfsd: use SRCU to dereference nn->nfsd_serv
Message-ID: <ZnYTsl2N7DMWLhjb@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-16-snitzer@kernel.org>
 <171895171341.14261.1146008422146566199@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171895171341.14261.1146008422146566199@noble.neil.brown.name>

On Fri, Jun 21, 2024 at 04:35:13PM +1000, NeilBrown wrote:
> On Thu, 20 Jun 2024, Mike Snitzer wrote:
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
> >  fs/nfsd/netns.h     | 14 ++++++++++--
> >  fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
> >  fs/nfsd/nfsctl.c    |  7 ++++--
> >  fs/nfsd/nfssvc.c    | 54 ++++++++++++++++++++++++++++++++++++---------
> >  5 files changed, 88 insertions(+), 25 deletions(-)
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
> > index 0c5a1d97e4ac..92d0d0883f17 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -139,8 +139,14 @@ struct nfsd_net {
> >  	u32 clverifier_counter;
> >  
> >  	struct svc_info nfsd_info;
> > -#define nfsd_serv nfsd_info.serv
> > -
> > +	/*
> > +	 * The current 'nfsd_serv' at nfsd_info.serv.  Using 'void' rather than
> > +	 * 'struct svc_serv' to guard against new code dereferencing nfsd_serv
> > +	 * without using proper synchronization.
> > +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> > +	 */
> > +	void __rcu *nfsd_serv;
> > +	struct srcu_struct nfsd_serv_srcu;
> >  
> 
> srcu_struct is not tiny.  I think it would make sense to use a global
> struct for all net namespaces.

Right, definitely _not_ tiny.
 
> Most users do seem to be embed them in some other structure - but not
> all....  kfd_processes_srcu stm_source_srcu

I haven't used a global SRCU (DEFINE_SRCU, etc) for multiple objects
before.  I'll look closer but this won't be addressed in v7.

Thanks,
Mike

