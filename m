Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C913B7B55
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 03:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhF3Bh7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF3Bh7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 21:37:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE687C061760
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 18:35:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 950BC64B9; Tue, 29 Jun 2021 21:35:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 950BC64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625016929;
        bh=zbAeRFff6luUdwVdp0TDreAhBUhSbYzmPZeSNqL7/NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sh2divpcysx2uBrkTwP60O54wT97EYkIrecYUBHlCtdvwwvVeKsJXGKozobW7NM+T
         kv+pIBxI+BNaKxikL7WnoBlfLbE98m1UXw4vPWf9gcUxqWqNLx/ZDyq9FYHPGrhhcU
         hItkUgwVcpgf34FeKnkjx2vWzMRcrwQBKefk3at0=
Date:   Tue, 29 Jun 2021 21:35:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210630013529.GA6200@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <fae4d46d-286c-013b-7606-97231fb1c17e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae4d46d-286c-013b-7606-97231fb1c17e@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 09:40:56PM -0700, dai.ngo@oracle.com wrote:
> 
> On 6/28/21 4:39 PM, dai.ngo@oracle.com wrote:
> >
> >On 6/28/21 1:23 PM, J. Bruce Fields wrote:
> >>On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> >>>@@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp,
> >>>struct nfsd4_compound_state *cstate,
> >>>      case -EAGAIN:        /* conflock holds conflicting lock */
> >>>          status = nfserr_denied;
> >>>          dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> >>>-        nfs4_set_lock_denied(conflock, &lock->lk_denied);
> >>>+
> >>>+        /* try again if conflict with courtesy client  */
> >>>+        if (nfs4_set_lock_denied(conflock, &lock->lk_denied)
> >>>== -EAGAIN && !retried) {
> >>>+            retried = true;
> >>>+            goto again;
> >>>+        }
> >>Ugh, apologies, this was my idea, but I just noticed it only
> >>handles conflicts
> >>from other NFSv4 clients.  The conflicting lock could just as
> >>well come from
> >>NLM or a local process.  So we need cooperation from the common
> >>locks.c code.
> >>
> >>I'm not sure what to suggest....
> 
> One option is to use locks_copy_conflock/nfsd4_fl_get_owner to detect
> the lock being copied belongs to a courtesy client and schedule the
> laundromat to run to destroy the courtesy client. This option requires
> callers of vfs_lock_file to provide the 'conflock' argument.

I'm not sure I follow.  What's the advantage of doing it this way?

> Regarding local lock conflick, do_lock_file_wait calls vfs_lock_file and
> just block waiting for the lock to be released. Both of the options
> above do not handle the case where the local lock happens before the
> v4 client expires and becomes courtesy client. In this case we can not
> let the v4 client becomes courtesy client.

Oh, good point, yes, we don't want that waiter stuck waiting forever on
this expired client....

> We need to have a way to
> detect that someone is blocked on a lock owned by the v4 client and
> do not allow that client to become courtesy client.  One way to handle
> this to mark the v4 lock as 'has_waiter', and then before allowing
> the expired v4 client to become courtesy client we need to search
> all the locks of this v4 client for any lock with 'has_waiter' flag
> and disallow it. The part that I don't like about this approach is
> having to search all locks of each lockowner of the v4 client for
> lock with 'has_waiter'.  I need some suggestions here.

I'm not seeing a way to do it without iterating over all the client's
locks.

I don't think you should need a new flag, though, shouldn't
!list_empty(&lock->fl_blocked_requests) be enough?

--b.

> 
> -Dai
> 
> >>
> >>Maybe something like:
> >>
> >>@@ -1159,6 +1159,7 @@ static int posix_lock_inode(struct inode
> >>*inode, struct file_lock *request,
> >>         }
> >>           percpu_down_read(&file_rwsem);
> >>+retry:
> >>         spin_lock(&ctx->flc_lock);
> >>         /*
> >>          * New lock request. Walk all POSIX locks and look for
> >>conflicts. If
> >>@@ -1169,6 +1170,11 @@ static int posix_lock_inode(struct inode
> >>*inode, struct file_lock *request,
> >>                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> >>                         if (!posix_locks_conflict(request, fl))
> >>                                 continue;
> >>+                       if (fl->fl_lops->fl_expire_lock(fl, 1)) {
> >>+ spin_unlock(&ctx->flc_lock);
> >>+ fl->fl_lops->fl_expire_locks(fl, 0);
> >>+                               goto retry;
> >>+                       }
> >>                         if (conflock)
> >>                                 locks_copy_conflock(conflock, fl);
> >>                         error = -EAGAIN;
> >>
> >>
> >>where ->fl_expire_lock is a new lock callback with second
> >>argument "check"
> >>where:
> >>
> >>    check = 1 means: just check whether this lock could be freed
> >>    check = 0 means: go ahead and free this lock if you can
> >
> >Thanks Bruce, I will look into this approach.
> >
> >-Dai
> >
> >>
> >>--b.
