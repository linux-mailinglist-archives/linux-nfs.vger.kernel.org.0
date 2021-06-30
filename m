Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A23B8920
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhF3T1C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhF3T07 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 15:26:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976AC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 12:24:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C746A64B9; Wed, 30 Jun 2021 15:24:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C746A64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625081069;
        bh=9q09zb/a9pi+v9zGtqPXj4ZX8NE3dbNc6C0rG4tPJVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhJSCGU8sY0vY/2R/JGgdPAd2Y77F95e1TDNK+0y2pRxA8hSWAApx4KN8VDEODVqH
         cBF5py6H0xienElZWC1ZrGnU1aZ4czUrf6YPUlaakH3cX7M+0iNSljDQEs2XClysOA
         g0RURsvsMOMuME1wPF9UtqBqm+4BA5BquVdmuTEs=
Date:   Wed, 30 Jun 2021 15:24:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210630192429.GH20229@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
 <20210630180527.GE20229@fieldses.org>
 <08caefcd-5271-8d44-326d-395399ff465c@oracle.com>
 <20210630185519.GG20229@fieldses.org>
 <08884534-931b-d828-0340-33c396674dd5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08884534-931b-d828-0340-33c396674dd5@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 12:13:35PM -0700, dai.ngo@oracle.com wrote:
> 
> On 6/30/21 11:55 AM, J. Bruce Fields wrote:
> >On Wed, Jun 30, 2021 at 11:49:18AM -0700, dai.ngo@oracle.com wrote:
> >>On 6/30/21 11:05 AM, J. Bruce Fields wrote:
> >>>On Wed, Jun 30, 2021 at 10:51:27AM -0700, dai.ngo@oracle.com wrote:
> >>>>>On 6/28/21 1:23 PM, J. Bruce Fields wrote:
> >>>>>>where ->fl_expire_lock is a new lock callback with second
> >>>>>>argument "check"
> >>>>>>where:
> >>>>>>
> >>>>>>     check = 1 means: just check whether this lock could be freed
> >>>>Why do we need this, is there a use case for it? can we just always try
> >>>>to expire the lock and return success/fail?
> >>>We can't expire the client while holding the flc_lock.  And once we drop
> >>>that lock we need to restart the loop.  Clearly we can't do that every
> >>>time.
> >>>
> >>>(So, my code was wrong, it should have been:
> >>>
> >>>
> >>>	if (fl->fl_lops->fl_expire_lock(fl, 1)) {
> >>>		spin_unlock(&ct->flc_lock);
> >>>		fl->fl_lops->fl_expire_locks(fl, 0);
> >>>		goto retry;
> >>>	}
> >>>
> >>>)
> >>This is what I currently have:
> >>
> >>retry:
> >>                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> >>                         if (!posix_locks_conflict(request, fl))
> >>                                 continue;
> >>
> >>                         if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock) {
> >>                                 spin_unlock(&ctx->flc_lock);
> >>                                 ret = fl->fl_lmops->lm_expire_lock(fl, 0);
> >>                                 spin_lock(&ctx->flc_lock);
> >>                                 if (ret)
> >>                                         goto retry;
> >We have to retry regardless of the return value.  Once we've dropped
> >flc_lock, it's not safe to continue trying to iterate through the list.
> 
> Yes, thanks!
> 
> >
> >>                         }
> >>
> >>                         if (conflock)
> >>                                 locks_copy_conflock(conflock, fl);
> >>
> >>>But the 1 and 0 cases are starting to look pretty different; maybe they
> >>>should be two different callbacks.
> >>why the case of 1 (test only) is needed,  who would use this call?
> >We need to avoid dropping the spinlock in the case there are no clients
> >to expire, otherwise we'll make no forward progress.
> 
> I think we can remember the last checked file_lock and skip it:

I doubt that works in the case there are multiple locks with
lm_expire_lock set.

If you really don't want another callback here, maybe you could set some
kind of flag on the lock.

At the time a client expires, you're going to have to walk all of its
locks to see if anyone's waiting for them.  At the same time maybe you
could set an FL_EXPIRABLE flag on all those locks, and test for that
here.

If the network partition heals and the client comes back, you'd have to
remember to clear that flag again.

--b.

> retry:
>                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>                         if (!posix_locks_conflict(request, fl))
>                                 continue;
> 
>                         if (checked_fl != fl && fl->fl_lmops &&
>                                         fl->fl_lmops->lm_expire_lock) {
>                                 checked_fl = fl;
>                                 spin_unlock(&ctx->flc_lock);
>                                 fl->fl_lmops->lm_expire_lock(fl);
>                                 spin_lock(&ctx->flc_lock);
>                                 goto retry;
>                         }
> 
>                         if (conflock)
>                                 locks_copy_conflock(conflock, fl);
> 
> -Dai
> 
> >
> >--b.
