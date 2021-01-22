Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D353C300CC1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbhAVThj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 14:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbhAVSsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 13:48:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2EC061786
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 10:47:55 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 160576E97; Fri, 22 Jan 2021 13:47:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 160576E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611341274;
        bh=6qYDmKUQQN9uy1WwJye0hryd/s38VuaiUyV+IeNFclY=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=YtPfjUfIRfSiH/LTonIkLI+NoG0GA8pFUaJTZxC1sSU1XUEKfAdVPKPMfOXc0omCF
         gf8L9qfGC0QOMJfQDoJoK204+JSvJ9u9m/plees479TxLBzxwJDLOp9ezAmfa150zD
         KMWZ53e2Ym4IEj5a1le5/wY4/4ZRNfx823beJtKA=
Date:   Fri, 22 Jan 2021 13:47:54 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 07/42] NFSD: Update WRITE3arg decoder to use struct
 xdr_stream
Message-ID: <20210122184754.GC18583@fieldses.org>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <160986061812.5532.3122782251888690881.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160986061812.5532.3122782251888690881.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 05, 2021 at 10:30:18AM -0500, Chuck Lever wrote:
> As part of the update, open code that sanity-checks the size of the
> data payload against the length of the RPC Call message has to be
> re-implemented to use xdr_stream infrastructure.

I'm having a little trouble parsing that.  Did you mean "write code"?

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3xdr.c |   51 ++++++++++++++++++++-------------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index ff98eae5db81..0aafb096de91 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -405,52 +405,41 @@ nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
>  int
>  nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
>  {
> +	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
>  	struct nfsd3_writeargs *args = rqstp->rq_argp;
> -	unsigned int len, hdr, dlen;
>  	u32 max_blocksize = svc_max_payload(rqstp);
>  	struct kvec *head = rqstp->rq_arg.head;
>  	struct kvec *tail = rqstp->rq_arg.tail;
> +	size_t remaining;
>  
> -	p = decode_fh(p, &args->fh);
> -	if (!p)
> +	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
>  		return 0;
> -	p = xdr_decode_hyper(p, &args->offset);
> -
> -	args->count = ntohl(*p++);
> -	args->stable = ntohl(*p++);
> -	len = args->len = ntohl(*p++);
> -	if ((void *)p > head->iov_base + head->iov_len)
> +	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
>  		return 0;
> -	/*
> -	 * The count must equal the amount of data passed.
> -	 */
> -	if (args->count != args->len)
> +	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
> +		return 0;
> +	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
>  		return 0;
>  
> -	/*
> -	 * Check to make sure that we got the right number of
> -	 * bytes.
> -	 */
> -	hdr = (void*)p - head->iov_base;
> -	dlen = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len - hdr;
> -	/*
> -	 * Round the length of the data which was specified up to
> -	 * the next multiple of XDR units and then compare that
> -	 * against the length which was actually received.
> -	 * Note that when RPCSEC/GSS (for example) is used, the
> -	 * data buffer can be padded so dlen might be larger
> -	 * than required.  It must never be smaller.
> -	 */
> -	if (dlen < XDR_QUADLEN(len)*4)
> +	/* opaque data */
> +	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
>  		return 0;
>  
> +	/* request sanity */
> +	if (args->count != args->len)
> +		return 0;
> +	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
> +	remaining -= xdr_stream_pos(xdr);
> +	if (remaining < xdr_align_size(args->len))
> +		return 0;
>  	if (args->count > max_blocksize) {
>  		args->count = max_blocksize;
> -		len = args->len = max_blocksize;
> +		args->len = max_blocksize;
>  	}
>  
> -	args->first.iov_base = (void *)p;
> -	args->first.iov_len = head->iov_len - hdr;
> +	args->first.iov_base = xdr->p;
> +	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
> +
>  	return 1;
>  }
>  
> 
