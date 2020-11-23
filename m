Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24B2C172A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 22:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgKWUzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgKWUzN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:55:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E6C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:55:13 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 18ACA6EA1; Mon, 23 Nov 2020 15:55:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 18ACA6EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606164912;
        bh=dHmeuLEB+pPCltH2/vSYGu+9m4HGXkAE4YxgdYbliis=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=EFE9I69eMYuccvJO4uKUdBaonNEK2Ip9tL6Jd6JBN6iJqOEVED+y2pQUxz5coQkyr
         cAL/ilTvwZtWM9NSZn2cci94w1Vj5H9Q2D7O2hgGPLZttM/+eI1HXfjeErwE2S8xlD
         JgkLkphIJ7nrMqjQY8cKt/ma/+pzUuH28M8AW0NQ=
Date:   Mon, 23 Nov 2020 15:55:12 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 087/118] NFSD: Update READDIR3args decoders to use
 struct xdr_stream
Message-ID: <20201123205512.GI32599@fieldses.org>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590488919.1340.2035631615670807514.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160590488919.1340.2035631615670807514.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 03:41:29PM -0500, Chuck Lever wrote:
> As an additional clean up, neither nfsd3_proc_readdir() nor
> nfsd3_proc_readdirplus() make use of the dircount argument, so
> remove it.

Are we technically violating the protocol if we return more than
dircount entries?

https://tools.ietf.org/html/rfc1813#page-82 doesn't say it's optional.
I suppose we'd know by now if any client actually cared.  Seems like
it'd be easy to implement, though.

Anyway, for now:

>  int
>  nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
>  {
> +	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
>  	struct nfsd3_readdirargs *args = rqstp->rq_argp;

maybe just add "/* ignored */" to make it clear it's inentional we're
not actually using the value read into this variable?:

> +	u32 dircount;

--b.

>  
> -	p = decode_fh(p, &args->fh);
> -	if (!p)
> -		return 0;
> -	p = xdr_decode_hyper(p, &args->cookie);
> -	args->verf     = p; p += 2;
> -	args->dircount = ntohl(*p++);
> -	args->count    = ntohl(*p++);
> +	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
> +		return XDR_DECODE_FAILED;
> +	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
> +		return XDR_DECODE_FAILED;
> +	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
> +	if (!args->verf)
> +		return XDR_DECODE_FAILED;
> +	if (xdr_stream_decode_u32(xdr, &dircount) < 0)
> +		return XDR_DECODE_FAILED;
> +	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
> +		return XDR_DECODE_FAILED;
>  
> -	return xdr_argsize_check(rqstp, p);
> +	return XDR_DECODE_DONE;
>  }
>  
>  int
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 789a364d5e69..64af5b01c5d7 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -90,7 +90,6 @@ struct nfsd3_symlinkargs {
>  struct nfsd3_readdirargs {
>  	struct svc_fh		fh;
>  	__u64			cookie;
> -	__u32			dircount;
>  	__u32			count;
>  	__be32 *		verf;
>  };
> 
