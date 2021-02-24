Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC63246E9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhBXWed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 17:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhBXWec (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 17:34:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1EC061756
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 14:33:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 75FC221DD; Wed, 24 Feb 2021 17:33:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 75FC221DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614206029;
        bh=/lYHEVu4ZGeGowBZy4yyy8RYP1cxkl9zS9Fg4I3iK70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGFXY9rxKYPHqrNNQ2XUKHDeWOLZOv3cn6S8zF0deEdhw2H+QtLyXCKIlyL0i1QmW
         dRfyx4ANsDDmyfMufFXaEol9gCzDk/IdwvBcAw9cZLRtxf6gRx+eBrsjR2g64WAgt5
         1kDbJjUEQrvtu6pK7K8FwtBbtQs1OnX79RW2j5+U=
Date:   Wed, 24 Feb 2021 17:33:49 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] nfsd: don't abort copies early
Message-ID: <20210224223349.GB25689@fieldses.org>
References: <20210224183950.GB11591@fieldses.org>
 <20210224193135.GC11591@fieldses.org>
 <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 24, 2021 at 07:34:10PM +0000, Chuck Lever wrote:
> 
> 
> > On Feb 24, 2021, at 2:31 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > I confess I always have to stare at these comparisons for a minute to
> > figure out which way they should go.  And the logic in each of these
> > loops is a little repetitive.
> > 
> > Would it be worth creating a little state_expired() helper to work out
> > the comparison and the new timeout?
> 
> That's better, but aren't there already operators on time64_t data objects
> that can be used for this?

No idea.

--b.

> 
> 
> > --b.
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 61552e89bd89..00fb3603c29e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
> > 	return true;
> > }
> > 
> > +struct laundry_time {
> > +	time64_t cutoff;
> > +	time64_t new_timeo;
> > +};
> > +
> > +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
> > +{
> > +	time64_t time_remaining;
> > +
> > +	if (last_refresh > lt->cutoff)
> > +		return true;
> > +	time_remaining = lt->cutoff - last_refresh;
> > +	lt->new_timeo = min(lt->new_timeo, time_remaining);
> > +	return false;
> > +}
> > +
> > static time64_t
> > nfs4_laundromat(struct nfsd_net *nn)
> > {
> > @@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	struct nfs4_ol_stateid *stp;
> > 	struct nfsd4_blocked_lock *nbl;
> > 	struct list_head *pos, *next, reaplist;
> > -	time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
> > -	time64_t t, new_timeo = nn->nfsd4_lease;
> > +	struct laundry_time lt = {
> > +		.cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
> > +		.new_timeo = nn->nfsd4_lease
> > +	};
> > 	struct nfs4_cpntf_state *cps;
> > 	copy_stateid_t *cps_t;
> > 	int i;
> > 
> > 	if (clients_still_reclaiming(nn)) {
> > -		new_timeo = 0;
> > +		lt.new_timeo = 0;
> > 		goto out;
> > 	}
> > 	nfsd4_end_grace(nn);
> > @@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> > 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> > 		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
> > -				cps->cpntf_time < cutoff)
> > +				state_expired(&lt, cps->cpntf_time))
> > 			_free_cpntf_state_locked(nn, cps);
> > 	}
> > 	spin_unlock(&nn->s2s_cp_lock);
> > @@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	spin_lock(&nn->client_lock);
> > 	list_for_each_safe(pos, next, &nn->client_lru) {
> > 		clp = list_entry(pos, struct nfs4_client, cl_lru);
> > -		if (clp->cl_time > cutoff) {
> > -			t = clp->cl_time - cutoff;
> > -			new_timeo = min(new_timeo, t);
> > +		if (!state_expired(&lt, clp->cl_time))
> > 			break;
> > -		}
> > 		if (mark_client_expired_locked(clp)) {
> > 			trace_nfsd_clid_expired(&clp->cl_clientid);
> > 			continue;
> > @@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	spin_lock(&state_lock);
> > 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> > 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > -		if (dp->dl_time > cutoff) {
> > -			t = dp->dl_time - cutoff;
> > -			new_timeo = min(new_timeo, t);
> > +		if (!state_expired(&lt, clp->cl_time))
> > 			break;
> > -		}
> > 		WARN_ON(!unhash_delegation_locked(dp));
> > 		list_add(&dp->dl_recall_lru, &reaplist);
> > 	}
> > @@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	while (!list_empty(&nn->close_lru)) {
> > 		oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
> > 					oo_close_lru);
> > -		if (oo->oo_time > cutoff) {
> > -			t = oo->oo_time - cutoff;
> > -			new_timeo = min(new_timeo, t);
> > +		if (!state_expired(&lt, oo->oo_time))
> > 			break;
> > -		}
> > 		list_del_init(&oo->oo_close_lru);
> > 		stp = oo->oo_last_closed_stid;
> > 		oo->oo_last_closed_stid = NULL;
> > @@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 	while (!list_empty(&nn->blocked_locks_lru)) {
> > 		nbl = list_first_entry(&nn->blocked_locks_lru,
> > 					struct nfsd4_blocked_lock, nbl_lru);
> > -		if (nbl->nbl_time > cutoff) {
> > -			t = nbl->nbl_time - cutoff;
> > -			new_timeo = min(new_timeo, t);
> > +		if (!state_expired(&lt, oo->oo_time))
> > 			break;
> > -		}
> > 		list_move(&nbl->nbl_lru, &reaplist);
> > 		list_del_init(&nbl->nbl_list);
> > 	}
> > @@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > 		free_blocked_lock(nbl);
> > 	}
> > out:
> > -	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> > -	return new_timeo;
> > +	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> > }
> > 
> > static struct workqueue_struct *laundry_wq;
> 
> --
> Chuck Lever
> 
> 
