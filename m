Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5503B462A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhFYO5H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFYO5F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Jun 2021 10:57:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60409C061574;
        Fri, 25 Jun 2021 07:54:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6EA616208; Fri, 25 Jun 2021 10:54:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6EA616208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624632883;
        bh=p4xrL//6v4PCv9apCr092hPA5bf7dpEAKaU7i4sG2Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muJG09KUGUXMfG2wKP4iy5zL6mAqtMz6dtE8C3u3Ct7S/tG1f6HtQ/Bue+blMwOqI
         kuMjFV8qm+0A1zCxYj+vpYQMlbr0X8gf/vcse91kmfnD6aTDVFwzirIGkMtAXHJpf8
         tefNZdNXoheoRYaICWMqiAOmaELBUBhWcsdpa0GQ=
Date:   Fri, 25 Jun 2021 10:54:43 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: remove redundant assignment to pointer 'this'
Message-ID: <20210625145443.GA26192@fieldses.org>
References: <20210513151639.73435-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513151639.73435-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry, overlooked this before somehow; applied for 5.14.--b.

On Thu, May 13, 2021 at 04:16:39PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'this' is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/nfsd/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f4ce93d7f26e..712df4b7dcb2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -3232,7 +3232,7 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
>  {
>  	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>  	struct nfsd4_compoundargs *argp = rqstp->rq_argp;
> -	struct nfsd4_op *this = &argp->ops[resp->opcnt - 1];
> +	struct nfsd4_op *this;
>  	struct nfsd4_compound_state *cstate = &resp->cstate;
>  	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
>  	u32 opiter;
> -- 
> 2.30.2
