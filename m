Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3550828BAD7
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbgJLO2n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Oct 2020 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbgJLO2n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Oct 2020 10:28:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A2C0613D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 07:28:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A83911E50; Mon, 12 Oct 2020 10:28:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A83911E50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602512922;
        bh=/YOyIFOUqRtG8nqsQThzt5byjqjOgp1Buhxw5vikabM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2JqBxVC90kuIF7YB7JeL1DqBf8+OPQBSpG/GlzjKGQTRqlmuar2dNmo7iCN7VIwJ
         vQXYWZMwuL1UF/imFC8UbDKQcBLuXtoErRe4lsLn7hOruZfBIAo2Y/DN1UDkqKy748
         TMJAzvaXddS4EycpBerBugtY1m13h/sHVdszDFGY=
Date:   Mon, 12 Oct 2020 10:28:42 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix oversight in .pc_func conversion
Message-ID: <20201012142842.GE26571@fieldses.org>
References: <160235898066.206859.15214008370147838310.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160235898066.206859.15214008370147838310.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 10, 2020 at 03:43:15PM -0400, Chuck Lever wrote:
> nfsd_proc_setattr() needs to return an accept_stat value, not an
> nfserr status code, when fh_verify() fails.

Thanks!  I'll fold that into "NFSD: Hoist status code encoding into XDR
encoder functions".

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsproc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Oops.
> 
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index f2450c719032..0d71549f9d42 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -85,7 +85,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
>  
>  		resp->status = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
>  		if (resp->status != nfs_ok)
> -			return resp->status;
> +			goto out;
>  
>  		if (delta < 0)
>  			delta = -delta;
> 
