Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E0277C6A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 01:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIXXp1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Sep 2020 19:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXp0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Sep 2020 19:45:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3FBC0613CE
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 16:45:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0C496425E; Thu, 24 Sep 2020 19:45:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0C496425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600991126;
        bh=3YEuRUB2lkVtvhO7b4Y6LOppDnJGdbiNVb803j3AyiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shWGBqZrGsnMnLgcL6mbpgOWMmuYTTyNlESTgA/vv4d75tr36YhXPTI/K5urxFl4N
         +N28MeXtP/3/061Q+pCj77mJaOc7ukS7JoSo0nKpBu+1IwQlimfEILP3NkCLcLkmdj
         mANhpQrp+Ypw4mWDIra5YVtXjPY/v0HbowQK7t/M=
Date:   Thu, 24 Sep 2020 19:45:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bill.Baker@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 26/27] NFSD: Add tracepoints in the NFS dispatcher
Message-ID: <20200924234526.GB12407@fieldses.org>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 21, 2020 at 02:13:07PM -0400, Chuck Lever wrote:
> This is follow-on work to the tracepoints added in the NFS server's
> duplicate reply cache. Here, tracepoints are introduced that report
> replies from cache as well as encoding and decoding errors.
> 
> The NFSv2, v3, and v4 dispatcher requirements have diverged over
> time, leaving us with a little bit of technical debt. In addition,
> I wanted to add a tracepoint for NFSv2 and NFSv3 similar to the
> nfsd4_compound/compoundstatus tracepoints. Lastly, removing some
> conditional branches from this hot path helps optimize CPU
> utilization. So, I've duplicated the nfsd_dispatcher function.

Comparing current nfsd_dispatch to the nfsv2/v3 nfsd_dispatch: the only
thing I spotted removed from the v2/v3-specific dispatch is the
rq_lease_breaker = NULL.  (I think that's not correct, actually.  We
could remove the need for that to be set in the v2/v3 case, but with the
current code it does need to be set.)

Comparing current nfsd_dispatch to the nfsv4 nfsd4_dispatch, the
v4-specific dispatch does away with nfs_request_too_big() and the
v2-specific shortcut in the error encoding case.

So these still look *very* similar.  I don't feel like we're getting a
lot of benefit out of splitting these out.

By the way, the combination of copying a bunch of code, doing some
common cleanup, and dropping version-specific stuff makes it a little
hard to sort out what's going on.  If it were me, I'd do this as:

	- one patch to do common cleanup (dropping some redundant
	  comments, using argv/resv variables to cleanup calculations,
	  etc.)
	- a second patch that just duplicates the one nfsd_dispatch into
	  nfsd_dispatch and nfsd4_dispatch
	- a third patch that just removes the stuff we don't need from
	  the newly duplicated dispatchers.

and then it'd be obvious what's changed.

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs2acl.c  |    2 -
>  fs/nfsd/nfs3acl.c  |    2 -
>  fs/nfsd/nfs4proc.c |    2 -
>  fs/nfsd/nfsd.h     |    1 
>  fs/nfsd/nfssvc.c   |  198 ++++++++++++++++++++++++++++++++++------------------
>  fs/nfsd/trace.h    |   50 +++++++++++++
>  6 files changed, 183 insertions(+), 72 deletions(-)
> 
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 54e597918822..894b8f0594e2 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -416,6 +416,6 @@ const struct svc_version nfsd_acl_version2 = {
>  	.vs_nproc	= 5,
>  	.vs_proc	= nfsd_acl_procedures2,
>  	.vs_count	= nfsd_acl_count2,
> -	.vs_dispatch	= nfsd_dispatch,
> +	.vs_dispatch	= nfsd4_dispatch,
>  	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
>  };
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 7f512dec7460..924ebb19c59c 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -282,7 +282,7 @@ const struct svc_version nfsd_acl_version3 = {
>  	.vs_nproc	= 3,
>  	.vs_proc	= nfsd_acl_procedures3,
>  	.vs_count	= nfsd_acl_count3,
> -	.vs_dispatch	= nfsd_dispatch,
> +	.vs_dispatch	= nfsd4_dispatch,
>  	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
>  };
>  
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 49109645af24..61302641f651 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -3320,7 +3320,7 @@ const struct svc_version nfsd_version4 = {
>  	.vs_nproc		= 2,
>  	.vs_proc		= nfsd_procedures4,
>  	.vs_count		= nfsd_count3,
> -	.vs_dispatch		= nfsd_dispatch,
> +	.vs_dispatch		= nfsd4_dispatch,
>  	.vs_xdrsize		= NFS4_SVC_XDRSIZE,
>  	.vs_rpcb_optnl		= true,
>  	.vs_need_cong_ctrl	= true,
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index cb742e17e04a..7fa4b19dd2f7 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -78,6 +78,7 @@ extern const struct seq_operations nfs_exports_op;
>   */
>  int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
>  int		nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp);
> +int		nfsd4_dispatch(struct svc_rqst *rqstp, __be32 *statp);
>  
>  int		nfsd_nrthreads(struct net *);
>  int		nfsd_nrpools(struct net *);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index f7f6473578af..d626eea1c78a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -28,6 +28,7 @@
>  #include "vfs.h"
>  #include "netns.h"
>  #include "filecache.h"
> +#include "trace.h"
>  
>  #define NFSDDBG_FACILITY	NFSDDBG_SVC
>  
> @@ -964,7 +965,7 @@ static __be32 map_new_errors(u32 vers, __be32 nfserr)
>  {
>  	if (nfserr == nfserr_jukebox && vers == 2)
>  		return nfserr_dropit;
> -	if (nfserr == nfserr_wrongsec && vers < 4)
> +	if (nfserr == nfserr_wrongsec)
>  		return nfserr_acces;
>  	return nfserr;
>  }
> @@ -980,18 +981,6 @@ static __be32 map_new_errors(u32 vers, __be32 nfserr)
>  static bool nfs_request_too_big(struct svc_rqst *rqstp,
>  				const struct svc_procedure *proc)
>  {
> -	/*
> -	 * The ACL code has more careful bounds-checking and is not
> -	 * susceptible to this problem:
> -	 */
> -	if (rqstp->rq_prog != NFS_PROGRAM)
> -		return false;
> -	/*
> -	 * Ditto NFSv4 (which can in theory have argument and reply both
> -	 * more than a page):
> -	 */
> -	if (rqstp->rq_vers >= 4)
> -		return false;
>  	/* The reply will be small, we're OK: */
>  	if (proc->pc_xdrressize > 0 &&
>  	    proc->pc_xdrressize < XDR_QUADLEN(PAGE_SIZE))
> @@ -1000,81 +989,152 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
>  	return rqstp->rq_arg.len > PAGE_SIZE;
>  }
>  
> -int
> -nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
> +/**
> + * nfsd_dispatch - Process an NFSv2 or NFSv3 request
> + * @rqstp: incoming NFS request
> + * @statp: OUT: RPC accept_stat value
> + *
> + * Return values:
> + *  %0: Processing complete; do not send a Reply
> + *  %1: Processing complete; send a Reply
> + */
> +int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
>  {
> -	const struct svc_procedure *proc;
> -	__be32			nfserr;
> -	__be32			*nfserrp;
> -
> -	dprintk("nfsd_dispatch: vers %d proc %d\n",
> -				rqstp->rq_vers, rqstp->rq_proc);
> -	proc = rqstp->rq_procinfo;
> -
> -	if (nfs_request_too_big(rqstp, proc)) {
> -		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
> -		*statp = rpc_garbage_args;
> -		return 1;
> +	const struct svc_procedure *proc = rqstp->rq_procinfo;
> +	struct kvec *argv = &rqstp->rq_arg.head[0];
> +	struct kvec *resv = &rqstp->rq_res.head[0];
> +	__be32 nfserr, *nfserrp;
> +
> +	if (nfs_request_too_big(rqstp, proc))
> +		goto out_too_large;
> +
> +	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
> +		goto out_decode_err;
> +
> +	rqstp->rq_cachetype = proc->pc_cachetype;
> +	switch (nfsd_cache_lookup(rqstp)) {
> +	case RC_DROPIT:
> +		goto out_dropit;
> +	case RC_REPLY:
> +		goto out_cached_reply;
> +	case RC_DOIT:
> +		break;
>  	}
> -	rqstp->rq_lease_breaker = NULL;
> +
> +	nfserrp = resv->iov_base + resv->iov_len;
> +	resv->iov_len += sizeof(__be32);
> +	nfserr = proc->pc_func(rqstp);
> +	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
> +	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags))
> +		goto out_update_drop;
> +	if (rqstp->rq_proc)
> +		*nfserrp++ = nfserr;
> +
> +	/* For NFSv2, additional info is never returned in case of an error. */
> +	if (!(nfserr && rqstp->rq_vers == 2))
> +		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
> +			goto out_encode_err;
> +
> +	nfsd_cache_update(rqstp, proc->pc_cachetype, statp + 1);
> +	trace_nfsd_svc_status(rqstp, proc, nfserr);
> +	return 1;
> +
> +out_too_large:
> +	trace_nfsd_svc_too_large_err(rqstp);
> +	*statp = rpc_garbage_args;
> +	return 1;
> +
> +out_decode_err:
> +	trace_nfsd_svc_decode_err(rqstp);
> +	*statp = rpc_garbage_args;
> +	return 1;
> +
> +out_update_drop:
> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +out_dropit:
> +	trace_nfsd_svc_dropit(rqstp);
> +	return 0;
> +
> +out_cached_reply:
> +	trace_nfsd_svc_cached_reply(rqstp);
> +	return 1;
> +
> +out_encode_err:
> +	trace_nfsd_svc_encode_err(rqstp);
> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +	*statp = rpc_system_err;
> +	return 1;
> +}
> +
> +/**
> + * nfsd4_dispatch - Process an NFSv4 or NFSACL request
> + * @rqstp: incoming NFS request
> + * @statp: OUT: RPC accept_stat value
> + *
> + * Return values:
> + *  %0: Processing complete; do not send a Reply
> + *  %1: Processing complete; send a Reply
> + */
> +int nfsd4_dispatch(struct svc_rqst *rqstp, __be32 *statp)
> +{
> +	const struct svc_procedure *proc = rqstp->rq_procinfo;
> +	struct kvec *argv = &rqstp->rq_arg.head[0];
> +	struct kvec *resv = &rqstp->rq_res.head[0];
> +	__be32 nfserr, *nfserrp;
> +
>  	/*
>  	 * Give the xdr decoder a chance to change this if it wants
>  	 * (necessary in the NFSv4.0 compound case)
>  	 */
>  	rqstp->rq_cachetype = proc->pc_cachetype;
> -	/* Decode arguments */
> -	if (proc->pc_decode &&
> -	    !proc->pc_decode(rqstp, (__be32*)rqstp->rq_arg.head[0].iov_base)) {
> -		dprintk("nfsd: failed to decode arguments!\n");
> -		*statp = rpc_garbage_args;
> -		return 1;
> -	}
> +	rqstp->rq_lease_breaker = NULL;
> +
> +	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
> +		goto out_decode_err;
>  
> -	/* Check whether we have this call in the cache. */
>  	switch (nfsd_cache_lookup(rqstp)) {
>  	case RC_DROPIT:
> -		return 0;
> +		goto out_dropit;
>  	case RC_REPLY:
> -		return 1;
> -	case RC_DOIT:;
> -		/* do it */
> +		goto out_cached_reply;
> +	case RC_DOIT:
> +		break;
>  	}
>  
> -	/* need to grab the location to store the status, as
> -	 * nfsv4 does some encoding while processing 
> -	 */
> -	nfserrp = rqstp->rq_res.head[0].iov_base
> -		+ rqstp->rq_res.head[0].iov_len;
> -	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
> -
> -	/* Now call the procedure handler, and encode NFS status. */
> +	nfserrp = resv->iov_base + resv->iov_len;
> +	resv->iov_len += sizeof(__be32);
>  	nfserr = proc->pc_func(rqstp);
> -	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
> -	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags)) {
> -		dprintk("nfsd: Dropping request; may be revisited later\n");
> -		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> -		return 0;
> -	}
> -
> -	if (rqstp->rq_proc != 0)
> +	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
> +		goto out_update_drop;
> +	if (rqstp->rq_proc)
>  		*nfserrp++ = nfserr;
>  
> -	/* Encode result.
> -	 * For NFSv2, additional info is never returned in case of an error.
> -	 */
> -	if (!(nfserr && rqstp->rq_vers == 2)) {
> -		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp)) {
> -			/* Failed to encode result. Release cache entry */
> -			dprintk("nfsd: failed to encode result!\n");
> -			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> -			*statp = rpc_system_err;
> -			return 1;
> -		}
> -	}
> +	if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
> +		goto out_encode_err;
>  
> -	/* Store reply in cache. */
>  	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
>  	return 1;
> +
> +out_decode_err:
> +	trace_nfsd_svc_decode_err(rqstp);
> +	*statp = rpc_garbage_args;
> +	return 1;
> +
> +out_update_drop:
> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +out_dropit:
> +	trace_nfsd_svc_dropit(rqstp);
> +	return 0;
> +
> +out_cached_reply:
> +	trace_nfsd_svc_cached_reply(rqstp);
> +	return 1;
> +
> +out_encode_err:
> +	trace_nfsd_svc_encode_err(rqstp);
> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +	*statp = rpc_system_err;
> +	return 1;
>  }
>  
>  int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 53115fbc00b2..50ab4a84c25f 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -32,6 +32,56 @@
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
>  		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
>  
> +DECLARE_EVENT_CLASS(nfsd_simple_class,
> +	TP_PROTO(
> +		const struct svc_rqst *rqstp
> +	),
> +	TP_ARGS(rqstp),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +	),
> +	TP_fast_assign(
> +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +	),
> +	TP_printk("xid=0x%08x", __entry->xid)
> +);
> +
> +#define DEFINE_NFSD_SIMPLE_EVENT(name)			\
> +DEFINE_EVENT(nfsd_simple_class, nfsd_##name,		\
> +	TP_PROTO(const struct svc_rqst *rqstp),		\
> +	TP_ARGS(rqstp))
> +
> +DEFINE_NFSD_SIMPLE_EVENT(svc_too_large_err);
> +DEFINE_NFSD_SIMPLE_EVENT(svc_decode_err);
> +DEFINE_NFSD_SIMPLE_EVENT(svc_dropit);
> +DEFINE_NFSD_SIMPLE_EVENT(svc_cached_reply);
> +DEFINE_NFSD_SIMPLE_EVENT(svc_encode_err);
> +
> +TRACE_EVENT(nfsd_svc_status,
> +	TP_PROTO(
> +		const struct svc_rqst *rqstp,
> +		const struct svc_procedure *proc,
> +		__be32 status
> +	),
> +	TP_ARGS(rqstp, proc, status),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, version)
> +		__field(unsigned long, status)
> +		__string(procedure, rqstp->rq_procinfo->pc_name)
> +	),
> +	TP_fast_assign(
> +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->version = rqstp->rq_vers;
> +		__entry->status = be32_to_cpu(status);
> +		__assign_str(procedure, rqstp->rq_procinfo->pc_name);
> +	),
> +	TP_printk("xid=0x%08x version=%u procedure=%s status=%s",
> +		__entry->xid, __entry->version, __get_str(procedure),
> +		show_nfs_status(__entry->status)
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_access,
>  	TP_PROTO(
>  		const struct svc_rqst *rqstp,
> 
