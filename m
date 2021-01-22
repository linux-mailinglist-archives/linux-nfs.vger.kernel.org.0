Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A6300DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbhAVUgE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 15:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbhAVUfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 15:35:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6277C061786
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 12:34:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 143086E97; Fri, 22 Jan 2021 15:34:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 143086E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611347672;
        bh=2K3r/xAZaFHf9jaE/1JNYwDtbcaplDLMe1MvsCxl1os=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=pKnR2xGsm6FCjn6ekB4aBSJxjjUHtOzU6eybsAVI8QBwTotGhPl6kgMPytwjpZZuW
         NkrcfTBmNZ57aVrujDreLTBnj++UjzLzriPnwceP2p69Xc7pe5hJgo5DRJqf6+P7GQ
         weomzI19wHvq3e5/Xpr6kqHS6yPFE14mHQP5i3VA=
Date:   Fri, 22 Jan 2021 15:34:32 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFSD: Reduce svc_rqst::rq_pages churn during READDIR
 operations
Message-ID: <20210122203432.GA25405@fieldses.org>
References: <161134687025.19311.4882007133082076189.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161134687025.19311.4882007133082076189.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Makes sense to me.--b.

On Fri, Jan 22, 2021 at 03:21:10PM -0500, Chuck Lever wrote:
> During NFSv2 and NFSv3 READDIR/PLUS operations, NFSD advances
> rq_next_page to the full size of the client-requested buffer, then
> releases all those pages at the end of the request. The next request
> to use that nfsd thread has to refill the pages.
> 
> NFSD does this even when the dirlist in the reply is small. With
> NFSv3 clients that send READDIR operations with large buffer sizes,
> that can be 256 put_page/alloc_page pairs per READDIR request, even
> though those pages often remain unused.
> 
> We can save some work by not releasing dirlist buffer pages that
> were not used to form the READDIR Reply. I've left the NFSv2 code
> alone since there are never more than three pages involved in an
> NFSv2 READDIR operation.
> 
> Eventually we should nail down why these pages need to be released
> at all in order to avoid allocating and releasing pages
> unnecessarily.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 8675851199f8..569bfff314f0 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -492,6 +492,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  		}
>  		count += PAGE_SIZE;
>  	}
> +	rqstp->rq_next_page = p;
>  	resp->count = count >> 2;
>  	if (resp->offset) {
>  		if (unlikely(resp->offset1)) {
> @@ -557,6 +558,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
>  		}
>  		count += PAGE_SIZE;
>  	}
> +	rqstp->rq_next_page = p;
>  	resp->count = count >> 2;
>  	if (resp->offset) {
>  		if (unlikely(resp->offset1)) {
> 
