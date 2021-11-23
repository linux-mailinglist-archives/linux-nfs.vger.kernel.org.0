Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C862545A98E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 18:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhKWRFR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 12:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236804AbhKWRFR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Nov 2021 12:05:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBD3660E54;
        Tue, 23 Nov 2021 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637686929;
        bh=zyJc1u9Pkg0P+VsaCrcGtzu5csn/OckyCmhcNgoyFMI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fpd5ARZnxLq7WzPCgMixDXgvdByfiNA8fQcwevayXmieyopl5G33hlmjb/dT7EO6P
         0cLEevxrFx16+TAQEHzVj2PwrH2+ruRiT1h7XcG76JlZg4No1AEr5DExlznoQvCfum
         o/ZFpKXw4YFHOQAHI/uQBZk7CJVDtir8An2RHnKEzoaWjggoPwhFvZ3Bvzmib8dhiW
         UN63bWbuETTTS0zC5rwMAt2cjfHxdFcFFH2B7TkkjmZl1FwOq6Xk0PqYjuU4F0zIcd
         EHjWcv5el9ORZHFCdQhRqJX+1MrnICVm6zmu0udQUWz+acU1Ev4d5WMz3jBK522mmn
         adeRdEtLAGMfw==
Message-ID: <7935c251b5b91c46b8abe6dcb14b97d2a934ce4c.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com,
        Vasily Averin <vvs@virtuozzo.com>
Date:   Tue, 23 Nov 2021 12:02:07 -0500
In-Reply-To: <20211123164141.GD8978@fieldses.org>
References: <20211123122223.69236-1-jlayton@kernel.org>
         <20211123155918.GC8978@fieldses.org>
         <ed633e0aaa64847d159e1db1087b4a3da9143ec4.camel@kernel.org>
         <20211123164141.GD8978@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-11-23 at 11:41 -0500, J. Bruce Fields wrote:
> On Tue, Nov 23, 2021 at 11:31:01AM -0500, Jeff Layton wrote:
> > On Tue, 2021-11-23 at 10:59 -0500, J. Bruce Fields wrote:
> > > On Tue, Nov 23, 2021 at 07:22:23AM -0500, Jeff Layton wrote:
> > > > Vasily reported a case where vfs_lock_file took a very long time to
> > > > return (longer than a lease period). The laundromat eventually ran and
> > > > reaped the thing and when the vfs_lock_file returned, it ended up
> > > > accessing freed memory.
> > > 
> > > By the way, once we've called vfs_lock_file(), is there anything
> > > preventing nfsd4_cb_notify_lock_release() from freeing nbl before we get
> > > here?
> > > 
> > 
> > No, I don't think there is. Good catch.
> 
> It may be a rare race (an rpc's not normally going to reply in that
> time), but I wouldn't be surprised if there's some error condition where
> it's possible.
> 
> > Hmm...the only way I can see to fix that would be to add a refcount to
> > these things, in which case we probably don't need this patch since it
> > would prevent the original issue as well...
> 
> Depending on how long that might take, I'd be OK with applying this as a
> stopgap.
> 
> 

I won't have the cycles to do that anytime soon, unfortunately, so you
may want to.

> > 
> > > > 
> > > > Don't put entries onto the LRU until vfs_lock_file returns.
> > > > 
> > > > Reported-by: Vasily Averin <vvs@virtuozzo.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index bfad94c70b84..8cfef84b9355 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >  	}
> > > >  
> > > >  	if (fl_flags & FL_SLEEP) {
> > > > -		nbl->nbl_time = ktime_get_boottime_seconds();
> > > >  		spin_lock(&nn->blocked_locks_lock);
> > > >  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> > > > -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> > > >  		spin_unlock(&nn->blocked_locks_lock);
> > > >  	}
> > > >  
> > > > @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >  			nn->somebody_reclaimed = true;
> > > >  		break;
> > > >  	case FILE_LOCK_DEFERRED:
> > > > +		nbl->nbl_time = ktime_get_boottime_seconds();
> > > > +		spin_lock(&nn->blocked_locks_lock);
> > > > +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> > > > +		spin_unlock(&nn->blocked_locks_lock);
> > > >  		nbl = NULL;
> > > >  		fallthrough;
> > > >  	case -EAGAIN:		/* conflock holds conflicting lock */
> > > > -- 
> > > > 2.33.1
> > 
> > -- 
> > Jeff Layton <jlayton@kernel.org>

-- 
Jeff Layton <jlayton@kernel.org>
