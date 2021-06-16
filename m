Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7933AA0B3
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPQEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFPQEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 12:04:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9383C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jun 2021 09:02:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A41986814; Wed, 16 Jun 2021 12:02:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A41986814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623859359;
        bh=+ZPS8odEPKio/+xuM8jgEq2RmH3ZSrHW/yM5lNmkOn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBv1tY/mkI1YlWc3pHdZ1neHM48OJNZh2Xpg2wq4eNHBFBPwVarZm4xtAYNoPPfNs
         egUax/Gu9Xw/W1dGijDj3jDcee20xxh2e79E5cufDZRMvZ+w4H2ERvZLcfY8EVbRAb
         tV/IEH10wcbKgDED4bA8GPCu2vzVpemGfAoZj0SQ=
Date:   Wed, 16 Jun 2021 12:02:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210616160239.GC4943@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603181438.109851-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunges
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
> reconnect and attempt to use the (now) expired state.
> 
> The default lease period for the Linux server is 90 seconds.  The typical
> client cuts that in half and will issue a lease renewing operation every
> 45 seconds. The 90 second lease period is very short considering the
> potential for moderately long term network partitions.  A network partition
> refers to any loss of network connectivity between the NFS client and the
> NFS server, regardless of its root cause.  This includes NIC failures, NIC
> driver bugs, network misconfigurations & administrative errors, routers &
> switches crashing and/or having software updates applied, even down to
> cables being physically pulled.  In most cases, these network failures are
> transient, although the duration is unknown.
> 
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recognize
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server reboots.
> 
> The initial implementation of the Courteous Server will do the following:
> 
> . when the laundromat thread detects an expired client and if that client
> still has established states on the Linux server then marks the client as a
> COURTESY_CLIENT and skips destroying the client and all its states,
> otherwise destroy the client as usual.
> 
> . detects conflict of OPEN request with a COURTESY_CLIENT, destroys the
> expired client and all its states, skips the delegation recall then allows
> the conflicting request to succeed.
> 
> . detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, destroys
> the expired client and all its states then allows the conflicting request
> to succeed.
> 
> To be done:
> 
> . fix a problem with 4.1 where the Linux server keeps returning
> SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after the expired
> client re-connects, causing the client to keep sending BCTS requests to server.

Hm, any progress working out what's causing that?

> . handle OPEN conflict with share reservations.

Sounds doable.

> . instead of destroy the client anf all its state on conflict, only destroy
> the state that is conflicted with the current request.

The other todos I think have to be done before we merge, but this one I
think can wait.

> . destroy the COURTESY_CLIENT either after a fixed period of time to release
> resources or as reacting to memory pressure.

I think we need something here, but it can be pretty simple.

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c        | 94 +++++++++++++++++++++++++++++++++++++++++++---
>  fs/nfsd/state.h            |  1 +
>  include/linux/sunrpc/svc.h |  1 +
>  3 files changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b517a8794400..969995872752 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -171,6 +171,7 @@ renew_client_locked(struct nfs4_client *clp)
>  
>  	list_move_tail(&clp->cl_lru, &nn->client_lru);
>  	clp->cl_time = ktime_get_boottime_seconds();
> +	clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>  }
>  
>  static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -4610,6 +4611,38 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>  	nfsd4_run_cb(&dp->dl_recall);
>  }
>  
> +/*
> + * Set rq_conflict_client if the conflict client have expired
> + * and return true, otherwise return false.
> + */
> +static bool
> +nfsd_set_conflict_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp;
> +	struct nfsd_net *nn;
> +	bool ret;
> +
> +	if (!i_am_nfsd())
> +		return false;
> +	rqst = kthread_data(current);
> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;

This says we do nothing if the lock request is not coming from nfsd and
v4.  That doesn't sound right.

For example, if the conflicting lock is coming from a local process (not
from an NFS client at all), we still need to revoke the courtesy state
so that process can make progress.

--b.

> +	rqst->rq_conflict_client = NULL;
> +	clp = dp->dl_recall.cb_clp;
> +	nn = net_generic(clp->net, nfsd_net_id);
> +	spin_lock(&nn->client_lock);
> +
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) &&
> +				!mark_client_expired_locked(clp)) {
> +		rqst->rq_conflict_client = clp;
> +		ret = true;
> +	} else
> +		ret = false;
> +	spin_unlock(&nn->client_lock);
> +	return ret;
> +}
> +
>  /* Called from break_lease() with i_lock held. */
>  static bool
>  nfsd_break_deleg_cb(struct file_lock *fl)
> @@ -4618,6 +4651,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>  	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
>  
> +	if (nfsd_set_conflict_client(dp))
> +		return false;
>  	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
>  
>  	/*
> @@ -5237,6 +5272,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>  	 */
>  }
>  
> +static bool
> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
> +{
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	if (!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ||
> +			mark_client_expired_locked(clp)) {
> +		spin_unlock(&nn->client_lock);
> +		return false;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	expire_client(clp);
> +	return true;
> +}
> +
>  __be32
>  nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>  {
> @@ -5286,7 +5337,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  			goto out;
>  		}
>  	} else {
> +		rqstp->rq_conflict_client = NULL;
>  		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		}
> +
>  		if (status) {
>  			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
> @@ -5472,6 +5529,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	};
>  	struct nfs4_cpntf_state *cps;
>  	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
> +	int id = 0;
>  	int i;
>  
>  	if (clients_still_reclaiming(nn)) {
> @@ -5495,6 +5554,15 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
>  		if (!state_expired(&lt, clp->cl_time))
>  			break;
> +
> +		spin_lock(&clp->cl_lock);
> +		stid = idr_get_next(&clp->cl_stateids, &id);
> +		spin_unlock(&clp->cl_lock);
> +		if (stid) {
> +			/* client still has states */
> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			continue;
> +		}
>  		if (mark_client_expired_locked(clp)) {
>  			trace_nfsd_clid_expired(&clp->cl_clientid);
>  			continue;
> @@ -6440,7 +6508,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>  	.lm_put_owner = nfsd4_fl_put_owner,
>  };
>  
> -static inline void
> +static inline int
>  nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>  {
>  	struct nfs4_lockowner *lo;
> @@ -6453,6 +6521,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>  			/* We just don't care that much */
>  			goto nevermind;
>  		deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
> +		if (nfs4_destroy_courtesy_client(lo->lo_owner.so_client))
> +			return -EAGAIN;
>  	} else {
>  nevermind:
>  		deny->ld_owner.len = 0;
> @@ -6467,6 +6537,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>  	deny->ld_type = NFS4_READ_LT;
>  	if (fl->fl_type != F_RDLCK)
>  		deny->ld_type = NFS4_WRITE_LT;
> +	return 0;
>  }
>  
>  static struct nfs4_lockowner *
> @@ -6734,6 +6805,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	unsigned int fl_flags = FL_POSIX;
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	bool retried = false;
>  
>  	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
>  		(long long) lock->lk_offset,
> @@ -6860,7 +6932,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>  		spin_unlock(&nn->blocked_locks_lock);
>  	}
> -
> +again:
>  	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
>  	switch (err) {
>  	case 0: /* success! */
> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	case -EAGAIN:		/* conflock holds conflicting lock */
>  		status = nfserr_denied;
>  		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
> +
> +		/* try again if conflict with courtesy client  */
> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
> +			retried = true;
> +			goto again;
> +		}
>  		break;
>  	case -EDEADLK:
>  		status = nfserr_deadlock;
> @@ -6962,6 +7039,8 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_lockowner *lo = NULL;
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	bool retried = false;
> +	int ret;
>  
>  	if (locks_in_grace(SVC_NET(rqstp)))
>  		return nfserr_grace;
> @@ -7010,14 +7089,19 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
>  
>  	nfs4_transform_lock_offset(file_lock);
> -
> +again:
>  	status = nfsd_test_lock(rqstp, &cstate->current_fh, file_lock);
>  	if (status)
>  		goto out;
>  
>  	if (file_lock->fl_type != F_UNLCK) {
>  		status = nfserr_denied;
> -		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
> +		ret = nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
> +		if (ret == -EAGAIN && !retried) {
> +			retried = true;
> +			fh_clear_wcc(&cstate->current_fh);
> +			goto again;
> +		}
>  	}
>  out:
>  	if (lo)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..bdc3605e3722 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,7 @@ struct nfs4_client {
>  #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>  					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>  	unsigned long		cl_flags;
>  	const struct cred	*cl_cb_cred;
>  	struct rpc_clnt		*cl_cb_client;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e91d51ea028b..2f0382f9d0ff 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -304,6 +304,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	void			*rq_conflict_client;
>  };
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> -- 
> 2.9.5
