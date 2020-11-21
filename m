Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6222BBB5D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 02:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgKUA7f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 19:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgKUA7d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 19:59:33 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB9C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 16:59:32 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 45E7968A6; Fri, 20 Nov 2020 19:59:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 45E7968A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605920372;
        bh=Ws+U2MloROwFdifttqBgGQRlzwlPBPgsZwgn8BxYYGw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WJHXWiLQIpwVvuAhutL/tKehgiD2xMsxyJcYARabHwLQD7wCr5hY+sOuwA1e9xKpj
         sMR+cPDxwR1m3MyX9Cv4kna43tVjqCrRInkkFkPs69Ykc543JM+o6zFOIPvZ0oBJR9
         B8ZvXMuzHD6JATdjjE1Q1vBykPr21l8A8k7XQ7Oc=
Date:   Fri, 20 Nov 2020 19:59:32 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 001/118] NFSD: Fix returned READDIR offset cookie
Message-ID: <20201121005932.GD7705@fieldses.org>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590443133.1340.6772360578279663543.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160590443133.1340.6772360578279663543.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 03:33:51PM -0500, Chuck Lever wrote:
> Code inspection shows that the server's NFSv3 READDIR implementation
> returns the same offset cookie as the client sent, instead of the
> last cookie it returns in the reply's dirlist. This is unlike the
> NFSv2 READDIR, NFSv3 READDIRPLUS, and NFSv4 READDIR implementations,
> and it's been like this since the beginning of kernel git history.

Surely this should have caused actual failures in practice.

> I copied the logic from nfsd3_proc_readdirplus().
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index d9be589fed15..e0ad18d6b5a8 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -430,6 +430,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
>  	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
>  	int		count = 0;
> +	loff_t		offset;
>  	struct page	**p;
>  	caddr_t		page_addr = NULL;
>  
> @@ -448,7 +449,9 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  	resp->common.err = nfs_ok;
>  	resp->buffer = argp->buffer;
>  	resp->rqstp = rqstp;
> -	resp->status = nfsd_readdir(rqstp, &resp->fh, (loff_t *)&argp->cookie,

Doesn't nfsd_readdir() update argp->cookie to point to the last offset?

> +	offset = argp->cookie;
> +
> +	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
>  				    &resp->common, nfs3svc_encode_entry);
>  	memcpy(resp->verf, argp->verf, 8);
>  	count = 0;
> @@ -464,8 +467,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  	}
>  	resp->count = count >> 2;
>  	if (resp->offset) {
> -		loff_t offset = argp->cookie;

So, this shouldn't be equal to the initial cookie any more.

Am I missing something?

--b.

> -
>  		if (unlikely(resp->offset1)) {
>  			/* we ended up with offset on a page boundary */
>  			*resp->offset = htonl(offset >> 32);
> 
