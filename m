Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFD32B74B
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhCCKyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376371AbhCBUqK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 15:46:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049DC061788
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 12:45:21 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 120D41E3B; Tue,  2 Mar 2021 15:45:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 120D41E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614717920;
        bh=zhdvxoHmaTycKDht8GvGbvKV9sBC6veJjiiJx44KJEY=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=jxWDB2gwCN1+g6qiAkMXW5w31rquzHmdH99dPszHITo14d2lJqp36lEtq5fqnP6gl
         b6tg6KOhIBfrMxf2qBAKIjpbYx80fVgtzJrfaTAvjnMnt9yu6p49g4D3xi4a7yZJ75
         mdSu2uQlm3He3NDREHxt4tylkTiFsZn4L2gutpZE=
Date:   Tue, 2 Mar 2021 15:45:20 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 12/42] NFSD: Update the NFSv3 FSSTAT3res encoder to
 use struct xdr_stream
Message-ID: <20210302204520.GF3400@fieldses.org>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461179102.8508.11890812651210896607.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161461179102.8508.11890812651210896607.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 10:16:31AM -0500, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3xdr.c |   58 ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index e159e4557428..e4a569e7216d 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -17,6 +17,13 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_XDR
>  
>  
> +/*
> + * Force construction of an empty post-op attr
> + */
> +static const struct svc_fh nfs3svc_null_fh = {
> +	.fh_no_wcc	= true,
> +};
> +
>  /*
>   * Mapping of S_IF* types to NFS file types
>   */
> @@ -1392,27 +1399,50 @@ nfs3svc_encode_entry_plus(void *cd, const char *name,
>  	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
>  }
>  
> +static bool
> +svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
> +			   const struct nfsd3_fsstatres *resp)
> +{
> +	const struct kstatfs *s = &resp->stats;
> +	u64 bs = s->f_bsize;
> +	__be32 *p;
> +
> +	p = xdr_reserve_space(xdr, XDR_UNIT * 13);
> +	if (!p)
> +		return false;
> +	p = xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
> +	p = xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
> +	p = xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes */
> +	p = xdr_encode_hyper(p, s->f_files);		/* total inodes */
> +	p = xdr_encode_hyper(p, s->f_ffree);		/* free inodes */
> +	p = xdr_encode_hyper(p, s->f_ffree);		/* user available inodes */
> +	*p = cpu_to_be32(resp->invarsec);		/* mean unchanged time */
> +
> +	return true;
> +}
> +
>  /* FSSTAT */
>  int
>  nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
>  {
> +	struct xdr_stream *xdr = &rqstp->rq_res_stream;
>  	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
> -	struct kstatfs	*s = &resp->stats;
> -	u64		bs = s->f_bsize;
>  
> -	*p++ = resp->status;
> -	*p++ = xdr_zero;	/* no post_op_attr */
> -
> -	if (resp->status == 0) {
> -		p = xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
> -		p = xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
> -		p = xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes */
> -		p = xdr_encode_hyper(p, s->f_files);	/* total inodes */
> -		p = xdr_encode_hyper(p, s->f_ffree);	/* free inodes */
> -		p = xdr_encode_hyper(p, s->f_ffree);	/* user available inodes */
> -		*p++ = htonl(resp->invarsec);	/* mean unchanged time */
> +	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
> +		return 0;
> +	switch (resp->status) {
> +	case nfs_ok:
> +		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
> +			return 0;
> +		if (!svcxdr_encode_fsstat3resok(xdr, resp))
> +			return 0;
> +		break;
> +	default:
> +		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
> +			return 0;

Dumb question: will this result in the same xdr on the wire as the above
that just hard-coded xdr_zero?

I feel like there's a lot of biolerplate error handling.  In the v4 case
I centralized some of it after a fuzzer found an oops in some of that
copy-pasted boilerplate:

	b7571e4cd39a nfsd4: skip encoder in trivial error cases
	bac966d60652 nfsd4: individual encoders no longer see error cases

I dunno, maybe that was overkill.

--b.

>  	}
> -	return xdr_ressize_check(rqstp, p);
> +
> +	return 1;
>  }
>  
>  /* FSINFO */
> 
