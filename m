Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6729318F459
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 13:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgCWMTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 08:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgCWMTB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Mar 2020 08:19:01 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BE220788;
        Mon, 23 Mar 2020 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584965941;
        bh=CClf7O83QfleM4O376KuCPsKR11KdYRT/XN1UwRaHsg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eEL65bHzbE6iGt7VU5eR4hNnlUtnKWjMWc8E30CCy4NW7ua8TjaOwrlkARttwFKBo
         p8fxDW3Gn7Vpow1RkGh2VMaWmo1K5xI6CL6PIk7hWCANzF7XV1hgXRLSMK8Y7IxFKk
         oi5yoy4hxAa5ydOuzw4UZVbxWBu3FaG3C+pj4R5w=
Message-ID: <7a3124cd2431eabe2495e0e8cd80068fe7261b1b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: memory corruption in nfsd4_lock()
From:   Jeff Layton <jlayton@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Mar 2020 08:18:59 -0400
In-Reply-To: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
References: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-03-23 at 10:55 +0300, Vasily Averin wrote:
> New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
> does not initialised nbl_list and nbl_lru.
> If conflock allocation fails rollback can call list_del_init()
> access uninitialized fields and corrupt memory.
> 
> Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for v4.1+ lock")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/nfsd/nfs4state.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 369e574c5092..176ef8d24fae 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6524,6 +6524,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		goto out;
>  	}
>  
> +	conflock = locks_alloc_lock();
> +	if (!conflock) {
> +		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> +		status = nfserr_jukebox;
> +		goto out;
> +	}
> +
>  	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
>  	if (!nbl) {
>  		dprintk("NFSD: %s: unable to allocate block!\n", __func__);
> @@ -6542,13 +6549,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
>  	nfs4_transform_lock_offset(file_lock);
>  
> -	conflock = locks_alloc_lock();
> -	if (!conflock) {
> -		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> -		status = nfserr_jukebox;
> -		goto out;
> -	}
> -
>  	if (fl_flags & FL_SLEEP) {
>  		nbl->nbl_time = jiffies;
>  		spin_lock(&nn->blocked_locks_lock);
> @@ -6581,17 +6581,15 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		status = nfserrno(err);
>  		break;
>  	}
> -out:
> -	if (nbl) {
> -		/* dequeue it if we queued it before */
> -		if (fl_flags & FL_SLEEP) {
> -			spin_lock(&nn->blocked_locks_lock);
> -			list_del_init(&nbl->nbl_list);
> -			list_del_init(&nbl->nbl_lru);
> -			spin_unlock(&nn->blocked_locks_lock);
> -		}
> -		free_blocked_lock(nbl);
> +	/* dequeue it if we queued it before */
> +	if (fl_flags & FL_SLEEP) {
> +		spin_lock(&nn->blocked_locks_lock);
> +		list_del_init(&nbl->nbl_list);
> +		list_del_init(&nbl->nbl_lru);
> +		spin_unlock(&nn->blocked_locks_lock);
>  	}
> +	free_blocked_lock(nbl);
> +out:
>  	if (nf)
>  		nfsd_file_put(nf);
>  	if (lock_stp) {

Good catch! Is there any reason not to just fix this by initializing the
list_heads in find_or_allocate_block? That seems like it'd be a simpler
fix.

-- 
Jeff Layton <jlayton@kernel.org>

