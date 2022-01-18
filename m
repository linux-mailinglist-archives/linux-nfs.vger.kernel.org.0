Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641D24930D5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349995AbiARWfI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiARWfH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:35:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7AC061574;
        Tue, 18 Jan 2022 14:35:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BDC453DDA; Tue, 18 Jan 2022 17:35:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BDC453DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642545305;
        bh=t2AsXyVLAWmqYQGBLsOjhjyKdu16wtjBmE5q6ZDtIgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dl7RqCM/OQvD2DSoj+7Ntl1r4n7BRlbqZIXAkO7Fg/cg5U/MzRV9bQXFI7SFKSleW
         rWh0BVNfsEpLSmQN4XpDXIKdi0FT4IJiPZoM7kwHomtE9q01dhmycP/LudlMVz23S9
         bR+XxAlemLZU9B9qo3Bu7w2jdZQyQCJPue8Feyp4=
Date:   Tue, 18 Jan 2022 17:35:05 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with
 FL_SLEEP
Message-ID: <20220118223505.GE16108@fieldses.org>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
 <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
 <20220103195333.GG21514@fieldses.org>
 <7666958f-6215-a8eb-3412-b613158406db@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7666958f-6215-a8eb-3412-b613158406db@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 16, 2022 at 03:44:21PM +0300, Vasily Averin wrote:
> On 03.01.2022 22:53, J. Bruce Fields wrote:
> > On Wed, Dec 29, 2021 at 11:24:43AM +0300, Vasily Averin wrote:
> >> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
> >> asynchronous processing of blocking locks.
> >>
> >> Currently nfs4 use locks_lock_inode_wait() function which is blocked
> >> for such requests. To handle them correctly FL_SLEEP flag should be
> >> temporarily reset before executing the locks_lock_inode_wait() function.
> >>
> >> Additionally block flag is forced to set, to translate blocking lock to
> >> remote nfs server, expecting it supports async processing of the blocking
> >> locks too.
> > 
> > But this on its own isn't enough for the client to support asynchronous
> > blocking locks, right?  Don't we also need the logic that calls knfsd's
> > lm_notify when it gets a CB_NOTIFY_LOCK from the server?
> 
> No, I think this should be enough.
> We are here a nfs client,
> we can get F_SETLK with FL_SLEEP from nfsd only (i.e. in re-export case)
> we need to avoid blocking if lock is already taken, 
> so we need to call locks_lock_inode_wait without FL_SLEEP,
> then we submit _sleeping_ request to NFS server (i.e. set )data->arg.block = 1)
> and waiting for reply from server.
> 
> Here we rely that server will NOT block on such request too, so our reply wel not be blocked too.

Just on that one point: if there's a lock conflict, an NFSv4 server will
return NFS4ERR_DENIED immediately and leave it to the client to poll.
Or if you're using NFS version >= 4.1, the server has the option of
calling back to the client with a CB_NOTIFY_LOCK to let the client know
when the lock might be available.  (See
https://datatracker.ietf.org/doc/html/rfc8881#section-20.11 for
details.)  But if a server that blocked and didn't reply to the original
LOCK request until the lock became available, that would be a bug.

(Apologies for responding just to that one point, I'm also trying to get
caught back up again here....).

--b.

> Under "block" I mean that handler can sleep or process request for a very long time 
> but it will NOT BE BLOCKED if lock is taken already, it WILL NOT WAIT when lock will be released,
> it just return some error in this case.
> 
> I think it is correct.
> Do you think I am wrong or maybe I missed something? 
> 
> Thank you,
> 	Vasily Averin
> 
> However I noticed now that past is incorrect, 
> temporally dropped FL_SLEEP should be restored back in _nfs4_proc_setlk before _nfs4_do_setlk() call.
> I'll fix it in next version of this patch-set.
> 
> >> https://bugzilla.kernel.org/show_bug.cgi?id=215383
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >> ---
> >>  fs/nfs/nfs4proc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >> index ee3bc79f6ca3..9b1380c4223c 100644
> >> --- a/fs/nfs/nfs4proc.c
> >> +++ b/fs/nfs/nfs4proc.c
> >> @@ -7094,7 +7094,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
> >>  			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
> >>  	if (data == NULL)
> >>  		return -ENOMEM;
> >> -	if (IS_SETLKW(cmd))
> >> +	if (IS_SETLKW(cmd) || (fl->fl_flags & FL_SLEEP))
> >>  		data->arg.block = 1;
> >>  	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
> >>  				recovery_type > NFS_LOCK_NEW);
> >> @@ -7200,6 +7200,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
> >>  	int status;
> >>  
> >>  	request->fl_flags |= FL_ACCESS;
> >> +	if (((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
> >> +		request->fl_flags &= ~FL_SLEEP;
> >> +
> >>  	status = locks_lock_inode_wait(state->inode, request);
> >>  	if (status < 0)
> >>  		goto out;
> >> -- 
> >> 2.25.1
