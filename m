Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0283B8577
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhF3Oye (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhF3Oyd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 10:54:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AFC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 07:52:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4CA464B9; Wed, 30 Jun 2021 10:52:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4CA464B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625064723;
        bh=3oZEYQfeMaBggxsi5qiZVnGDz9iVj4z3NyspxR/lQPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIEJz/8/FCyW6x39Y66yyzqBUpn3QagknfYfG9D8NRJOgai1e3wFGo4uKHLPIRfAj
         Wx3WwqwwVMjNseKOULBY9FKl6vx7w3jET6z41ATY8Aj+szhvmR1r0YDGJF5puTqB1W
         V979AR8XIeIwZZ7MfpHOaaCtVDZRtTJm9g+TGJ3U=
Date:   Wed, 30 Jun 2021 10:52:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210630145203.GA20229@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <fae4d46d-286c-013b-7606-97231fb1c17e@oracle.com>
 <20210630013529.GA6200@fieldses.org>
 <4d05112d-4d75-afeb-c7c6-ebba650d0f1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d05112d-4d75-afeb-c7c6-ebba650d0f1b@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 01:41:32AM -0700, dai.ngo@oracle.com wrote:
> 
> On 6/29/21 6:35 PM, J. Bruce Fields wrote:
> >On Mon, Jun 28, 2021 at 09:40:56PM -0700, dai.ngo@oracle.com wrote:
> >>On 6/28/21 4:39 PM, dai.ngo@oracle.com wrote:
> >>>On 6/28/21 1:23 PM, J. Bruce Fields wrote:
> >>>>On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> >>>>>@@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp,
> >>>>>struct nfsd4_compound_state *cstate,
> >>>>>       case -EAGAIN:        /* conflock holds conflicting lock */
> >>>>>           status = nfserr_denied;
> >>>>>           dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> >>>>>-        nfs4_set_lock_denied(conflock, &lock->lk_denied);
> >>>>>+
> >>>>>+        /* try again if conflict with courtesy client  */
> >>>>>+        if (nfs4_set_lock_denied(conflock, &lock->lk_denied)
> >>>>>== -EAGAIN && !retried) {
> >>>>>+            retried = true;
> >>>>>+            goto again;
> >>>>>+        }
> >>>>Ugh, apologies, this was my idea, but I just noticed it only
> >>>>handles conflicts
> >>>>from other NFSv4 clients.  The conflicting lock could just as
> >>>>well come from
> >>>>NLM or a local process.  So we need cooperation from the common
> >>>>locks.c code.
> >>>>
> >>>>I'm not sure what to suggest....
> >>One option is to use locks_copy_conflock/nfsd4_fl_get_owner to detect
> >>the lock being copied belongs to a courtesy client and schedule the
> >>laundromat to run to destroy the courtesy client. This option requires
> >>callers of vfs_lock_file to provide the 'conflock' argument.
> >I'm not sure I follow.  What's the advantage of doing it this way?
> 
> I'm not sure it's an advantage but I was trying to minimize changes to
> the fs code. The only change we need is to add the conflock argument
> to do_lock_file_wait to handle local lock conflicts.

Got it.

That's a clever but kind of unexpected use of lm_get_owner; I think it
could be confusing to a future reader.  And I'd rather not require the
extra retry.  A new lock callback is a complication, but at least it's
pretty obvious what it does.

> If you don't think we're going to get objection with the new callback,
> fl_expire_lock, then I will take that approach. We still need to add
> the conflock argument to do_lock_file_wait in this case.

Why is that?

--b.
