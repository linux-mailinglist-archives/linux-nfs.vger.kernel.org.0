Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2A321E6B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 18:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhBVRop (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 12:44:45 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:57899 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhBVRoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 12:44:44 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 542DAC0BB6
        for <linux-nfs@vger.kernel.org>; Mon, 22 Feb 2021 17:43:51 +0000 (GMT)
Received: (qmail 29816 invoked from network); 22 Feb 2021 17:43:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Feb 2021 17:43:51 -0000
Date:   Mon, 22 Feb 2021 17:43:49 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH RFC] SUNRPC: Refresh rq_pages using a bulk page allocator
Message-ID: <20210222174349.GJ3697@techsingularity.net>
References: <161340498400.7780.962495219428962117.stgit@klimt.1015granger.net>
 <20210222093505.GG3697@techsingularity.net>
 <33A16CEA-24CA-447A-AE8C-824771E9B3E1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <33A16CEA-24CA-447A-AE8C-824771E9B3E1@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 22, 2021 at 02:58:04PM +0000, Chuck Lever wrote:
> > There is a conflict at the end where rq_page_end gets updated. The 5.11
> > code assumes that the loop around the allocator definitely gets all
> > the required pages. What tree is this patch based on and is it going in
> > during this merge window? While the conflict is "trivial" to resolve,
> > it would be buggy because on retry, "i" will be pointing to the wrong
> > index and pages potentially leak. Rather than guessing, I'd prefer to
> > base a series on code you've tested.
> 
> I posted this patch as a proof of concept. There is a clean-up patch
> that goes before it to deal properly with rq_page_end. I can post
> both if you really want to apply this and play with it.
> 

It's for the best. It doesn't belong in the series as such but it may
affect what the bulk allocator usage looks like.

> 
> > The slowpath for the bulk allocator also sucks a bit for the semantics
> > required by this caller. As the bulk allocator does not walk the zonelist,
> > it can return failures prematurely -- fine for an optimistic bulk allocator
> > that can return a subset of pages but not for this caller which really
> > wants those pages. The allocator may need NOFAIL-like semantics to walk
> > the zonelist if the caller really requires success or at least walk the
> > zonelist if the preferred zone is low on pages. This patch would also
> > need to preserve the schedule_timeout behaviour so it does not use a lot
> > of CPU time retrying allocations in the presense of memory pressure.
> 
> Waiting half a second before trying again seems like overkill, though.
> 

It is both overkill and time is not directly correlated with memory
pressure. However, I would also suggest removing the timeout as a separate
patch as it's not related to the bulk allocator in case someone does
encounter a high CPU usage problem and bisects it the patch using the
bulk allocator for the first time.

-- 
Mel Gorman
SUSE Labs
