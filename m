Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538F8C2547
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfI3QhV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 12:37:21 -0400
Received: from fieldses.org ([173.255.197.46]:38388 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfI3QhV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Sep 2019 12:37:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id EECE063E; Mon, 30 Sep 2019 12:37:20 -0400 (EDT)
Date:   Mon, 30 Sep 2019 12:37:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     chuck.lever@oracle.com, trondmy@gmail.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: remove set but not used variable 'len'
Message-ID: <20190930163720.GD10012@fieldses.org>
References: <20190928042156.43228-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928042156.43228-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying for 5.5.--b.

On Sat, Sep 28, 2019 at 12:21:56PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/nfsd/nfs4xdr.c: In function nfsd4_encode_splice_read:
> fs/nfsd/nfs4xdr.c:3464:7: warning: variable len set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 83a63072c815 ("nfsd: fix nfs read eof detection")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 533d0fc..1883370 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3461,7 +3461,6 @@ static __be32 nfsd4_encode_splice_read(
>  	struct xdr_stream *xdr = &resp->xdr;
>  	struct xdr_buf *buf = xdr->buf;
>  	u32 eof;
> -	long len;
>  	int space_left;
>  	__be32 nfserr;
>  	__be32 *p = xdr->p - 2;
> @@ -3470,7 +3469,6 @@ static __be32 nfsd4_encode_splice_read(
>  	if (xdr->end - xdr->p < 1)
>  		return nfserr_resource;
>  
> -	len = maxcount;
>  	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
>  				  file, read->rd_offset, &maxcount, &eof);
>  	read->rd_length = maxcount;
> -- 
> 2.7.4
> 
