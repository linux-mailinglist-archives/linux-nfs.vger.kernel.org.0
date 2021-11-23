Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28045A70C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhKWQC1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhKWQC1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 11:02:27 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3AC061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Nov 2021 07:59:19 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8ACCF32EC; Tue, 23 Nov 2021 10:59:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8ACCF32EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637683158;
        bh=s1vJPL4RlAP4SnqLDTvE3hLlH5Nl1KmEpof9fp213Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yx/Q4/8QQ5ETs7v9vRA9WQi05eWNZjNMkA2/qoSGARmuLdXDy6ordiLuRdddSGV0H
         UQp9Pgy/E4nvPimfE2SOwaTDgL34Cowi7qKumNTrGW6T9uYC6AzXU5IE2wCMAwFM1X
         oxaS8BS8XtpEvVcwC5lzmmQmCj0VyM/Rzokox54A=
Date:   Tue, 23 Nov 2021 10:59:18 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
Message-ID: <20211123155918.GC8978@fieldses.org>
References: <20211123122223.69236-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123122223.69236-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 23, 2021 at 07:22:23AM -0500, Jeff Layton wrote:
> Vasily reported a case where vfs_lock_file took a very long time to
> return (longer than a lease period). The laundromat eventually ran and
> reaped the thing and when the vfs_lock_file returned, it ended up
> accessing freed memory.

By the way, once we've called vfs_lock_file(), is there anything
preventing nfsd4_cb_notify_lock_release() from freeing nbl before we get
here?

> 
> Don't put entries onto the LRU until vfs_lock_file returns.
> 
> Reported-by: Vasily Averin <vvs@virtuozzo.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index bfad94c70b84..8cfef84b9355 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  
>  	if (fl_flags & FL_SLEEP) {
> -		nbl->nbl_time = ktime_get_boottime_seconds();
>  		spin_lock(&nn->blocked_locks_lock);
>  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>  		spin_unlock(&nn->blocked_locks_lock);
>  	}
>  
> @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			nn->somebody_reclaimed = true;
>  		break;
>  	case FILE_LOCK_DEFERRED:
> +		nbl->nbl_time = ktime_get_boottime_seconds();
> +		spin_lock(&nn->blocked_locks_lock);
> +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> +		spin_unlock(&nn->blocked_locks_lock);
>  		nbl = NULL;
>  		fallthrough;
>  	case -EAGAIN:		/* conflock holds conflicting lock */
> -- 
> 2.33.1
