Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6932C6BF
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCDA35 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhCCWH3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 17:07:29 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5FC061764
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 13:55:16 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F40542501; Wed,  3 Mar 2021 16:55:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F40542501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614808516;
        bh=i/0oTfap9dioHKtbm/yfkYe7wKjQ1mNV79vf8s9A/PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxWK4hGpgQ+wvtPwco/0QNmB0eBrXI3GmGnUBja6rD8FUm4FEOHzLBmfCHgEhxycn
         6iujJBJqw8cb+FkQ80gHWtrvryo/M367tmYFlDMhXLJH4yB2TFN5hSUCw/alktN/TM
         D+vKgB2paPpvNB4qAQ/k5QyKnCwoeVQMmi27IBT8=
Date:   Wed, 3 Mar 2021 16:55:15 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: helper for laundromat expiry calculations
Message-ID: <20210303215515.GF3949@fieldses.org>
References: <20210302154623.GA2263@fieldses.org>
 <AC0F5679-8B32-4D75-B28B-67171027B70D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC0F5679-8B32-4D75-B28B-67171027B70D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 03, 2021 at 09:35:18PM +0000, Chuck Lever wrote:
> 
> 
> > On Mar 2, 2021, at 10:46 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > We do this same logic repeatedly, and it's easy to get the sense of the
> > comparison wrong.
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 49 +++++++++++++++++++++++++--------------------
> > 1 file changed, 27 insertions(+), 22 deletions(-)
> > 
> > My original version of this patch... actually got the sense of the
> > comparison wrong!
> > 
> > Now actually tested.
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 61552e89bd89..8e6938902b49 100644
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
> > +	if (last_refresh < lt->cutoff)
> > +		return true;
> > +	time_remaining = last_refresh - lt->cutoff;
> > +	lt->new_timeo = min(lt->new_timeo, time_remaining);
> > +	return false;
> > +}
> > +
> 
> /home/cel/src/linux/linux/fs/nfsd/nfs4state.c:5371:6: warning: no previous prototype for ‘state_expired’ [-Wmissing-prototypes]
>  5371 | bool state_expired(struct laundry_time *lt, time64_t last_refresh)
>       |      ^~~~~~~~~~~~~
> 
> Should this new helper be static, or instead perhaps these items
> should be defined in a header file.

Whoops, should have been static, yes, do you want to fix it up or should
I resend?

--b.

> 
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
> > +		if (!state_expired(&lt, dp->dl_time))
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
> > +		if (!state_expired(&lt, nbl->nbl_time))
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
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 
> 
