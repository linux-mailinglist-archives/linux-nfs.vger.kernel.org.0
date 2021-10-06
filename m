Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97542402C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJFOf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJFOf2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:35:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E0C061749
        for <linux-nfs@vger.kernel.org>; Wed,  6 Oct 2021 07:33:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0E95F14DE; Wed,  6 Oct 2021 10:33:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0E95F14DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633530815;
        bh=T72+NZqfghdbb51MB1XfcxqKua1U0na8W1wsF55f7bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzTmG+AsuIYtQ8nhWK+NZg4V1reWsYNhr3A4zg3ow5cb2l7vUaKAvj/MVSiC9qUsN
         hbhBeajfaAkIN5A9boNSdHNzzQ3i4dfufy6nZQ0MZBdOVdFfuZFIaoB8j6ig5hrkWR
         87XSL07EWd8p5vq3M+A30ryfQaDq7m8LL5p5bF9U=
Date:   Wed, 6 Oct 2021 10:33:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Keep existing listners on portlist error
Message-ID: <20211006143335.GA15343@fieldses.org>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 06, 2021 at 10:18:05AM -0400, Benjamin Coddington wrote:
> If nfsd has existing listening sockets without any processes, then an error
> returned from svc_create_xprt() for an additional transport will remove
> those existing listeners.  We're seeing this in practice when userspace
> attempts to create rpcrdma transports without having the rpcrdma modules
> present before creating nfsd kernel processes.  Fix this by checking for
> existing sockets before callingn nfsd_destroy().

That seems like an improvement.

I'm curious, though, what the rpc.nfsd behavior is on partial failure.
And what do we want it to be?

If a user runs rpc.nfsd expecting it to start up tcp and rdma, but rdma
fails, do we want rpc.nfsd to succeed or fail?  Should it exit with nfsd
running or not?

--b.

> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..df4613a4924c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
>  		svc_xprt_put(xprt);
>  	}
>  out_err:
> -	nfsd_destroy(net);
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks))
> +		nfsd_destroy(net);
> +	else
> +		nn->nfsd_serv->sv_nrthreads--;
>  	return err;
>  }
>  
> -- 
> 2.30.2
