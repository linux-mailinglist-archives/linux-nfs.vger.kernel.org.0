Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5003F33971C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 20:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhCLTHE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 14:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhCLTGg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 14:06:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91111C061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 11:06:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8648335BD; Fri, 12 Mar 2021 14:06:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8648335BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1615575994;
        bh=hFOij0Hqph3FECzDPmzwUNNmpSnGwagw4B3S6FpWt2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jj/YrSDCQYA26lXfzXPXy4Tz6T9O1dijmtRDSKLwuzYycvzQFFm5ZjtjaMmdT+uHs
         ymdIWyn6SF2BZpFQaQLLh8syjEkQFjIs9g7B2i5mKxgLwBuW7gERahgYmZLgyFohgQ
         nEBhl1BOJNJbTBoa3x1ppnKwFin0S2DKsjCn3C6o=
Date:   Fri, 12 Mar 2021 14:06:34 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: Log error on UMH upcall init failure and debug
 message on success
Message-ID: <20210312190634.GE24008@fieldses.org>
References: <20210312170604.56169-1-pmenzel@molgen.mpg.de>
 <20210312170943.57461-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312170943.57461-1-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 12, 2021 at 06:09:44PM +0100, Paul Menzel wrote:
> By default, using `printk()`, Linux logs messages with level warning,
> which leaves the user reading
> 
>     NFSD: Using UMH upcall client tracking operations.
> 
> wondering what to do about it. Reading `nfsd4_umh_cltrack_init()`, the
> message is actually logged on success, so nothing needs to be done, and
> it was decided to use the debug level.
> 
> Additionally, Linux now logs an error on init failure.
> 
>     NFSD: Failed to init UMH upcall client tracking operations.

The thing is, it's actually trying a series of different mechanisms (see
nfsd4_client_tracking_init) and taking the first one that works.  It's
more useful to see which one of them ends up being chosen rather than
the list of mechanisms that failed.  (And those failures are normal if
userland is configured to use something lower down in the list.)

So, let's just demote to "debug" and leave the logic otherwise
unchanged.

--b.

> 
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Log error and demote success message to debug-level (forgot `-a` in `git commit --amend`)
> v3: Actually sent correct diff
> 
>  fs/nfsd/nfs4recover.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 891395c6c7d3..fff89c739033 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -1863,8 +1863,11 @@ nfsd4_umh_cltrack_init(struct net *net)
>  
>  	ret = nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
>  	kfree(grace_start);
> -	if (!ret)
> -		printk("NFSD: Using UMH upcall client tracking operations.\n");
> +	if (ret)
> +		pr_debug("NFSD: Using UMH upcall client tracking operations.\n");
> +	else
> +		pr_err("NFSD: Failed to init UMH upcall client tracking operations.");
> +
>  	return ret;
>  }
>  
> -- 
> 2.30.2
