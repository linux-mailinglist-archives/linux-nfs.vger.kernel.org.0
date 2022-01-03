Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732E24837C4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiACTxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiACTxe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 14:53:34 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852FC061761;
        Mon,  3 Jan 2022 11:53:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9E34E4C7F; Mon,  3 Jan 2022 14:53:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9E34E4C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641239613;
        bh=3MbLFj9rzrXHI8T5NRoT34vt+2y7QqBgVGUi0Oa5xJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfD1tvXiuQ03zPYRguomRZ7WqyDpx4bLW1sc3ZzvqXlUV7DK5txtIBouXEhkCtBca
         Ghf7ZyWRIaQ45o08m0wvCRSpOS+eYB8BsYLWYIX3yaQLkFooWrLhze4Tpny+1PCxrY
         T8Dpa+rTvrQblqZInBYojlhkHyUYIKSihkNtB8UA=
Date:   Mon, 3 Jan 2022 14:53:33 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with
 FL_SLEEP
Message-ID: <20220103195333.GG21514@fieldses.org>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
 <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 29, 2021 at 11:24:43AM +0300, Vasily Averin wrote:
> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
> asynchronous processing of blocking locks.
> 
> Currently nfs4 use locks_lock_inode_wait() function which is blocked
> for such requests. To handle them correctly FL_SLEEP flag should be
> temporarily reset before executing the locks_lock_inode_wait() function.
> 
> Additionally block flag is forced to set, to translate blocking lock to
> remote nfs server, expecting it supports async processing of the blocking
> locks too.

But this on its own isn't enough for the client to support asynchronous
blocking locks, right?  Don't we also need the logic that calls knfsd's
lm_notify when it gets a CB_NOTIFY_LOCK from the server?

--b.

> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215383
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/nfs/nfs4proc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index ee3bc79f6ca3..9b1380c4223c 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7094,7 +7094,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
>  			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
>  	if (data == NULL)
>  		return -ENOMEM;
> -	if (IS_SETLKW(cmd))
> +	if (IS_SETLKW(cmd) || (fl->fl_flags & FL_SLEEP))
>  		data->arg.block = 1;
>  	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
>  				recovery_type > NFS_LOCK_NEW);
> @@ -7200,6 +7200,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
>  	int status;
>  
>  	request->fl_flags |= FL_ACCESS;
> +	if (((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
> +		request->fl_flags &= ~FL_SLEEP;
> +
>  	status = locks_lock_inode_wait(state->inode, request);
>  	if (status < 0)
>  		goto out;
> -- 
> 2.25.1
