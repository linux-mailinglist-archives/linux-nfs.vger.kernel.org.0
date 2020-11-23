Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418222C13DC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 20:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKWSt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKWSt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:49:56 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F6C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 10:49:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8D01A6EA1; Mon, 23 Nov 2020 13:49:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8D01A6EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606157395;
        bh=NM9itye/TQ7EafLrOfXgomWyvrmd8zzDAynuuN0gj8Y=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=lWZKDX7VXHzXPEGjZPf70wMfW56Ma+nA5mb3yatH2MPb/WXglv2SxG0wYu5agjlXW
         iSTidaqQ5ffvpCczyGXxPFPPk7G+qjq0NH6d6Ip5Nk8MQtf8LXuwpPOgJ1n8EG3RiF
         /nJ75x7WBUokX4A8+XFH1tUnfRwIcWzJyD9LwHFo=
Date:   Mon, 23 Nov 2020 13:49:55 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 003/118] SUNRPC: Prepare for xdr_stream-style decoding
 on the server-side
Message-ID: <20201123184955.GG32599@fieldses.org>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590444205.1340.4589231865882719752.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160590444205.1340.4589231865882719752.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 03:34:02PM -0500, Chuck Lever wrote:
> A "permanent" struct xdr_stream is allocated in struct svc_rqst so
> that it is usable by all server-side decoders. A per-rqst scratch
> buffer is also allocated to handle decoding XDR data items that
> cross page boundaries.
> 
> To demonstrate how it will be used, add the first call site for the
> new svcxdr_init_decode() API.
> 
> As an additional part of the overall conversion, add symbolic
> constants for successful and failed XDR operations. Returning "0" is
> overloaded. Sometimes it means something failed, but sometimes it
> means success. To make it more clear when XDR decoding functions
> succeed or fail, introduce symbolic constants.

I'm not sure how I feel about that part.  Do you plan to change this
everywhere?

Maybe it'd be simpler or clearer to make pc_decode return bool?

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c          |    3 ++-
>  fs/nfsd/nfssvc.c           |    4 +++-
>  include/linux/sunrpc/svc.h |   16 ++++++++++++++++
>  include/linux/sunrpc/xdr.h |    5 +++++
>  net/sunrpc/svc.c           |    5 +++++
>  5 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e3c6bea83bd6..66274ad05a9c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5321,7 +5321,8 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
>  	args->ops = args->iops;
>  	args->rqstp = rqstp;
>  
> -	return !nfsd4_decode_compound(args);
> +	return nfsd4_decode_compound(args) == nfs_ok ?	XDR_DECODE_DONE :
> +							XDR_DECODE_FAILED;
>  }
>  
>  int
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 27b1ad136150..daeab72975a3 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1020,7 +1020,9 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
>  	 * (necessary in the NFSv4.0 compound case)
>  	 */
>  	rqstp->rq_cachetype = proc->pc_cachetype;
> -	if (!proc->pc_decode(rqstp, argv->iov_base))
> +
> +	svcxdr_init_decode(rqstp, argv->iov_base);
> +	if (proc->pc_decode(rqstp, argv->iov_base) == XDR_DECODE_FAILED)
>  		goto out_decode_err;
>  
>  	switch (nfsd_cache_lookup(rqstp)) {
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index c220b734fa69..bb6c93283697 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -248,6 +248,8 @@ struct svc_rqst {
>  	size_t			rq_xprt_hlen;	/* xprt header len */
>  	struct xdr_buf		rq_arg;
>  	struct xdr_buf		rq_res;
> +	struct xdr_stream	rq_xdr_stream;
> +	struct page		*rq_scratch_page;
>  	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
>  	struct page *		*rq_respages;	/* points into rq_pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
> @@ -557,4 +559,18 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
>  	svc_reserve(rqstp, space + rqstp->rq_auth_slack);
>  }
>  
> +/**
> + * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
> + * @rqstp: controlling server RPC transaction context
> + * @p: Starting position
> + *
> + */
> +static inline void svcxdr_init_decode(struct svc_rqst *rqstp, __be32 *p)
> +{
> +	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
> +
> +	xdr_init_decode(xdr, &rqstp->rq_arg, p, NULL);
> +	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
> +}
> +
>  #endif /* SUNRPC_SVC_H */
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 2729d2d6efce..abbb032de4e8 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -19,6 +19,11 @@
>  struct bio_vec;
>  struct rpc_rqst;
>  
> +enum xdr_decode_result {
> +	XDR_DECODE_FAILED = 0,
> +	XDR_DECODE_DONE = 1,
> +};
> +
>  /*
>   * Buffer adjustment
>   */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index b41500645c3f..4187745887f0 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -614,6 +614,10 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
>  	rqstp->rq_server = serv;
>  	rqstp->rq_pool = pool;
>  
> +	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
> +	if (!rqstp->rq_scratch_page)
> +		goto out_enomem;
> +
>  	rqstp->rq_argp = kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, node);
>  	if (!rqstp->rq_argp)
>  		goto out_enomem;
> @@ -842,6 +846,7 @@ void
>  svc_rqst_free(struct svc_rqst *rqstp)
>  {
>  	svc_release_buffer(rqstp);
> +	put_page(rqstp->rq_scratch_page);
>  	kfree(rqstp->rq_resp);
>  	kfree(rqstp->rq_argp);
>  	kfree(rqstp->rq_auth_data);
> 
