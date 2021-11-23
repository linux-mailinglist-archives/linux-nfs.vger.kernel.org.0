Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4B45A8C6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhKWQpI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbhKWQo6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 11:44:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4868C061746
        for <linux-nfs@vger.kernel.org>; Tue, 23 Nov 2021 08:41:42 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F01477351; Tue, 23 Nov 2021 11:41:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F01477351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637685701;
        bh=gKfBuSEQr96E4RgFOk2mkVJNNqGhmpuQWgHpdHq/704=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrvvQ91IxAb/tnC47NLsloZa8Xz6J8CRoFw9CCq4KmJlMpCmBLoDH7ZOWnFlOJwLv
         kSLP3c4QAze6l9coQvjylUu4gYQI45Y29dWm/RKl6kxrUfzShAWPbL/9RvDRQF+DUN
         FEPLQxdQzErOjK9YPlIElAq/wh1il08v+C/tQqbo=
Date:   Tue, 23 Nov 2021 11:41:41 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
Message-ID: <20211123164141.GD8978@fieldses.org>
References: <20211123122223.69236-1-jlayton@kernel.org>
 <20211123155918.GC8978@fieldses.org>
 <ed633e0aaa64847d159e1db1087b4a3da9143ec4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed633e0aaa64847d159e1db1087b4a3da9143ec4.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 23, 2021 at 11:31:01AM -0500, Jeff Layton wrote:
> On Tue, 2021-11-23 at 10:59 -0500, J. Bruce Fields wrote:
> > On Tue, Nov 23, 2021 at 07:22:23AM -0500, Jeff Layton wrote:
> > > Vasily reported a case where vfs_lock_file took a very long time to
> > > return (longer than a lease period). The laundromat eventually ran and
> > > reaped the thing and when the vfs_lock_file returned, it ended up
> > > accessing freed memory.
> > 
> > By the way, once we've called vfs_lock_file(), is there anything
> > preventing nfsd4_cb_notify_lock_release() from freeing nbl before we get
> > here?
> > 
> 
> No, I don't think there is. Good catch.

It may be a rare race (an rpc's not normally going to reply in that
time), but I wouldn't be surprised if there's some error condition where
it's possible.

> Hmm...the only way I can see to fix that would be to add a refcount to
> these things, in which case we probably don't need this patch since it
> would prevent the original issue as well...

Depending on how long that might take, I'd be OK with applying this as a
stopgap.

--b.

> 
> > > 
> > > Don't put entries onto the LRU until vfs_lock_file returns.
> > > 
> > > Reported-by: Vasily Averin <vvs@virtuozzo.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4state.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index bfad94c70b84..8cfef84b9355 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	}
> > >  
> > >  	if (fl_flags & FL_SLEEP) {
> > > -		nbl->nbl_time = ktime_get_boottime_seconds();
> > >  		spin_lock(&nn->blocked_locks_lock);
> > >  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> > > -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> > >  		spin_unlock(&nn->blocked_locks_lock);
> > >  	}
> > >  
> > > @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  			nn->somebody_reclaimed = true;
> > >  		break;
> > >  	case FILE_LOCK_DEFERRED:
> > > +		nbl->nbl_time = ktime_get_boottime_seconds();
> > > +		spin_lock(&nn->blocked_locks_lock);
> > > +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> > > +		spin_unlock(&nn->blocked_locks_lock);
> > >  		nbl = NULL;
> > >  		fallthrough;
> > >  	case -EAGAIN:		/* conflock holds conflicting lock */
> > > -- 
> > > 2.33.1
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
