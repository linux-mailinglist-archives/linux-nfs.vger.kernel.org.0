Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8A141390
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQVqP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:46:15 -0500
Received: from fieldses.org ([173.255.197.46]:34008 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQVqP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:46:15 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D64511C84; Fri, 17 Jan 2020 16:46:14 -0500 (EST)
Date:   Fri, 17 Jan 2020 16:46:14 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] nfsd: Fix NFSv4 READ on RDMA when using readv
Message-ID: <20200117214614.GC27294@fieldses.org>
References: <20200115202647.2172.666.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115202647.2172.666.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 15, 2020 at 03:37:33PM -0500, Chuck Lever wrote:
> svcrdma expects that the READ payload falls precisely into the
> xdr_buf's page vector. Adding "xdr->iov = NULL" forces
> xdr_reserve_space() to always use pages from xdr->buf->pages when
> calling nfsd_readv.
> 
> Also, the XDR padding is problematic. For NFS/RDMA Write chunks,
> the padding needs to be in xdr->buf->tail so that the transport can
> skip over it. However for NFS/TCP and the NFS/RDMA Reply chunks,
> the padding has to be retained. Not yet sure how to add this.
> 
> Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> Howdy Bruce-
> 
> I'm struggling with nfsd4_encode_readv().
> 
> - for NFS/RDMA Write chunks, the READ payload has to be in
>   buf->pages. I've fixed that.
> 
> - xdr_reserve_space() calls don't need to explicitly align the
>   @nbytes argument: xdr_reserve_space() already does this?
> 
> - the while loop probably won't work if a later READ in the COMPOUND
>   doesn't start on a page boundary. This isn't a problem until we
>   run into a Solaris client in forcedirectio mode.

So the Solaris client sends multiple reads per compound in that case?

> - the XDR padding doesn't work for NFS/RDMA Write chunks, which are
>   supposed to skip padding altogether.

krb5i/p has to treat read data as padded regardless of the transport,
doesn't it?

--b.

> Do you have suggestions? Thanks in advance.
> 
> 
>  fs/nfsd/nfs4xdr.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index d2dc4c0e22e8..14c68a136b4e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3519,17 +3519,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  	u32 zzz = 0;
>  	int pad;
>  
> +	/* Ensure xdr_reserve_space behaves itself */
> +	if (xdr->iov == xdr->buf->head) {
> +		xdr->iov = NULL;
> +		xdr->end = xdr->p;
> +	}
> +
>  	len = maxcount;
>  	v = 0;
> -
> -	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
> -	p = xdr_reserve_space(xdr, (thislen+3)&~3);
> -	WARN_ON_ONCE(!p);
> -	resp->rqstp->rq_vec[v].iov_base = p;
> -	resp->rqstp->rq_vec[v].iov_len = thislen;
> -	v++;
> -	len -= thislen;
> -
>  	while (len) {
>  		thislen = min_t(long, len, PAGE_SIZE);
>  		p = xdr_reserve_space(xdr, (thislen+3)&~3);
> @@ -3548,7 +3545,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  	read->rd_length = maxcount;
>  	if (nfserr)
>  		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
> +	xdr_truncate_encode(xdr, starting_len + 8 + maxcount);
>  
>  	tmp = htonl(eof);
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
