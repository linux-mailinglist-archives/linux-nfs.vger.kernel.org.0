Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC526355892
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbhDFPzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbhDFPzZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 11:55:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF20C06174A;
        Tue,  6 Apr 2021 08:55:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 78D656A45; Tue,  6 Apr 2021 11:55:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 78D656A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617724515;
        bh=nRm55Izeeu9GtkxYFyBXOz1IRLsd8oDZIEb2vVZr8EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0jeWQvS2DKDUG1GvsdlE2G0XzZB2OA1xEq1RtAtdJxN1Baf/FZCC0gDPViu+Vs+U
         om66k2s+JMtiOZbApn9xgITyre11SMsc0hCEAypwJcVl1OOHSk5IFKkdAYP7SelPDi
         bYxnBPQv/pggiZ2GLnw7kAAhRslAWqDiwCG8PBW0=
Date:   Tue, 6 Apr 2021 11:55:15 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Huang Guobin <huangguobin4@huawei.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] NFSD: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210406155515.GA21267@fieldses.org>
References: <1617710898-49064-1-git-send-email-huangguobin4@huawei.com>
 <5B67E76D-139B-4004-9DE0-A626026CAEB1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B67E76D-139B-4004-9DE0-A626026CAEB1@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 06, 2021 at 03:46:34PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 6, 2021, at 8:08 AM, Huang Guobin <huangguobin4@huawei.com> wrote:
> > 
> > From: Guobin Huang <huangguobin4@huawei.com>
> > 
> > spinlock can be initialized automatically with DEFINE_SPINLOCK()
> > rather than explicitly calling spin_lock_init().
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
> 
> This same patch was sent last July, without the Reported-by:
> 
> https://lore.kernel.org/linux-nfs/1617710898-49064-1-git-send-email-huangguobin4@huawei.com/T/#u
> 
> If I'm reading the code correctly, it appears that set_max_drc()
> can be called more than once by user space API functions via
> nfsd_create_serv().
> 
> It seems to me we want to guarantee that nfsd_drc_lock is
> initialized exactly once, and using DEFINE_SPINLOCK() would
> do just that.
> 
> Likewise, re-initializing nfsd_drc_mem_used is probably not good
> to do either, but clobbering a spinlock like that might lead to
> a crash.
> 
> Bruce, any further thoughts?

The other nfsd_drc_lock users run in nfsd threads, which shouldn't be
running yet at the point we call set_max_drc.

Reinitializing the lock each time is pretty weird, though, ACK to the
patch even if it's just cleanup.

--b.

> 
> 
> > ---
> > fs/nfsd/nfssvc.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index b2eef4112bc2..82ba034fa579 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -84,7 +84,7 @@ DEFINE_MUTEX(nfsd_mutex);
> >  * version 4.1 DRC caches.
> >  * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
> >  */
> > -spinlock_t	nfsd_drc_lock;
> > +DEFINE_SPINLOCK(nfsd_drc_lock);
> > unsigned long	nfsd_drc_max_mem;
> > unsigned long	nfsd_drc_mem_used;
> > 
> > @@ -563,7 +563,6 @@ static void set_max_drc(void)
> > 	nfsd_drc_max_mem = (nr_free_buffer_pages()
> > 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> > 	nfsd_drc_mem_used = 0;
> > -	spin_lock_init(&nfsd_drc_lock);
> > 	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> > }
> > 
> > 
> 
> --
> Chuck Lever
> 
> 
