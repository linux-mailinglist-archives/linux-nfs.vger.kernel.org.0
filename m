Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D4A483828
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 22:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiACVAO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 16:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiACVAO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 16:00:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBCCC061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 13:00:13 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 69C3C72F7; Mon,  3 Jan 2022 16:00:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 69C3C72F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641243613;
        bh=bHfdBBvHoz6KaCgdxNxjOCCstQDTEYE8MdM0oQqLue8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rm8PrZKGhxeIRCZ3PWre2pt+b58fLvs+MZ7JYZ5rcaPVzAlXSfU7dUebfIrIfdKeW
         ooLvh5CC2259in4vJaCzY2ccjaFsrw+8uFnNcK2AfwB7QwgT4cC+i9uX33wFlxW+3J
         Ry5KRu8mtJumhDpfZ8m+yXxm9nh+OxskICs/o1kg=
Date:   Mon, 3 Jan 2022 16:00:13 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Message-ID: <20220103210013.GK21514@fieldses.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 21, 2021 at 10:23:25AM -0500, Chuck Lever wrote:
> The Linux NFS server currently responds to a zero-length NFSv3 WRITE
> request with NFS3ERR_IO. It responds to a zero-length NFSv4 WRITE
> with NFS4_OK and count of zero.
> 
> RFC 1813 says of the WRITE procedure's @count argument:
> 
> count
>          The number of bytes of data to be written. If count is
>          0, the WRITE will succeed and return a count of 0,
>          barring errors due to permissions checking.
> 
> RFC 8881 has similar language for NFSv4, though NFSv4 removed the
> explicit @count argument because that value is already contained in
> the opaque payload array.
> 
> The synthetic client pynfs's WRT4 and WRT15 tests do emit zero-
> length WRITEs to exercise this spec requirement, but interestingly
> the Linux NFS client does not appear to emit zero-length WRITEs,
> instead squelching them.
> 
> I'm not aware of a test that can generate such WRITEs for NFSv3, so
> I wrote a naive C program to generate a zero-length WRITE and test
> this fix.

I know it's probably only a few lines, but still may be worth posting
somewhere and making it the start of a collection of protocol-level v3
tests.

--b.

> 
> Fixes: 14168d678a0f ("NFSD: Remove the RETURN_STATUS() macro")
> Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> 
> Here's an alternate approach to addressing the zero-length NFSv3
> WRITE failures.
> 
> 
>  fs/nfsd/nfs3proc.c |    6 +-----
>  fs/nfsd/nfsproc.c  |    5 -----
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 4418517f6f12..2c681785186f 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -202,15 +202,11 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->committed = argp->stable;
>  	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
> -	if (!nvecs) {
> -		resp->status = nfserr_io;
> -		goto out;
> -	}
> +
>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>  				  rqstp->rq_vec, nvecs, &cnt,
>  				  resp->committed, resp->verf);
>  	resp->count = cnt;
> -out:
>  	return rpc_success;
>  }
>  
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index eea5b59b6a6c..1743ed04197e 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -235,10 +235,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  		argp->len, argp->offset);
>  
>  	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
> -	if (!nvecs) {
> -		resp->status = nfserr_io;
> -		goto out;
> -	}
>  
>  	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
>  				  argp->offset, rqstp->rq_vec, nvecs,
> @@ -247,7 +243,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status == nfserr_jukebox)
>  		return rpc_drop_reply;
> -out:
>  	return rpc_success;
>  }
>  
