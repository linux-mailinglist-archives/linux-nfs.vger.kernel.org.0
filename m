Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94EB45A7B2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 17:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhKWQeL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhKWQeL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Nov 2021 11:34:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6368060F5A;
        Tue, 23 Nov 2021 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637685062;
        bh=xtNWoVQwGCRfWAXLpyMCUAo8gWyCO58xThvhX/m0DJw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IXaps8ScMzBi/QENtcwmK7UvdsJScy2/5cGFy5AdwrU5hPmAVkaaAfe9DcoYyhjk/
         MUm8JWw4Qt2ZA7ccq7z7kXbQ9Lm/MIeRQ6PUOpBC+eWZ53LM/JNVpVqA/gSTsA6BOw
         MW/WwX7id6AIJ8R2klNj0+D1Gs48qCkJjQuiRQbmHnPla4L/Y4j1Tc7RCsqDPv4UDJ
         snks2Py0GgWDZazB1lfhpj8suCLA1X6QJQcT5hAHl31Fpco5cbaN+M+5seS/lYKD+C
         ITAtSt9HuMRjxuNng+LLxT1EB5RdpWPkGxv7zV+oe9+hCiETPU+k9yC+jMQCj65zNa
         /a6tuM/C/yedQ==
Message-ID: <ed633e0aaa64847d159e1db1087b4a3da9143ec4.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com,
        Vasily Averin <vvs@virtuozzo.com>
Date:   Tue, 23 Nov 2021 11:31:01 -0500
In-Reply-To: <20211123155918.GC8978@fieldses.org>
References: <20211123122223.69236-1-jlayton@kernel.org>
         <20211123155918.GC8978@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-11-23 at 10:59 -0500, J. Bruce Fields wrote:
> On Tue, Nov 23, 2021 at 07:22:23AM -0500, Jeff Layton wrote:
> > Vasily reported a case where vfs_lock_file took a very long time to
> > return (longer than a lease period). The laundromat eventually ran and
> > reaped the thing and when the vfs_lock_file returned, it ended up
> > accessing freed memory.
> 
> By the way, once we've called vfs_lock_file(), is there anything
> preventing nfsd4_cb_notify_lock_release() from freeing nbl before we get
> here?
> 

No, I don't think there is. Good catch.

Hmm...the only way I can see to fix that would be to add a refcount to
these things, in which case we probably don't need this patch since it
would prevent the original issue as well...

> > 
> > Don't put entries onto the LRU until vfs_lock_file returns.
> > 
> > Reported-by: Vasily Averin <vvs@virtuozzo.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4state.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index bfad94c70b84..8cfef84b9355 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	}
> >  
> >  	if (fl_flags & FL_SLEEP) {
> > -		nbl->nbl_time = ktime_get_boottime_seconds();
> >  		spin_lock(&nn->blocked_locks_lock);
> >  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> > -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> >  		spin_unlock(&nn->blocked_locks_lock);
> >  	}
> >  
> > @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  			nn->somebody_reclaimed = true;
> >  		break;
> >  	case FILE_LOCK_DEFERRED:
> > +		nbl->nbl_time = ktime_get_boottime_seconds();
> > +		spin_lock(&nn->blocked_locks_lock);
> > +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> > +		spin_unlock(&nn->blocked_locks_lock);
> >  		nbl = NULL;
> >  		fallthrough;
> >  	case -EAGAIN:		/* conflock holds conflicting lock */
> > -- 
> > 2.33.1

-- 
Jeff Layton <jlayton@kernel.org>
