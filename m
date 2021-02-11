Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D752318712
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBKJ1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 04:27:10 -0500
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:52440 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhBKJVB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Feb 2021 04:21:01 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 04:20:59 EST
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id F3F07BEED0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Feb 2021 09:12:37 +0000 (GMT)
Received: (qmail 21012 invoked from network); 11 Feb 2021 09:12:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Feb 2021 09:12:37 -0000
Date:   Thu, 11 Feb 2021 09:12:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210211091235.GC3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
 <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon>
 <20210210130705.GC3629@suse.de>
 <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 10, 2021 at 10:58:37PM +0000, Chuck Lever wrote:
> > Not in the short term due to bug load and other obligations.
> > 
> > The original series had "mm, page_allocator: Only use per-cpu allocator
> > for irq-safe requests" but that was ultimately rejected because softirqs
> > were affected so it would have to be done without that patch.
> > 
> > The last patch can be rebased easily enough but it only batch allocates
> > order-0 pages. It's also only build tested and could be completely
> > miserable in practice and as I didn't even try boot test let, let alone
> > actually test it, it could be a giant pile of crap. To make high orders
> > work, it would need significant reworking but if the API showed even
> > partial benefit, it might motiviate someone to reimplement the bulk
> > interfaces to perform better.
> > 
> > Rebased diff, build tested only, might not even work
> 
> Thanks, Mel, for kicking off a forward port.
> 
> It compiles. I've added a patch to replace the page allocation loop
> in svc_alloc_arg() with a call to alloc_pages_bulk().
> 
> The server system deadlocks pretty quickly with any NFS traffic. Based
> on some initial debugging, it appears that a pcplist is getting corrupted
> and this causes the list_del() in __rmqueue_pcplist() to fail during a
> a call to alloc_pages_bulk().
> 

Parameters to __rmqueue_pcplist are garbage as the parameter order changed.
I'm surprised it didn't blow up in a spectacular fashion. Again, this
hasn't been near any testing and passing a list with high orders to
free_pages_bulk() will corrupt lists too. Mostly it's a curiousity to see
if there is justification for reworking the allocator to fundamentally
deal in batches and then feed batches to pcp lists and the bulk allocator
while leaving the normal GFP API as single page "batches". While that
would be ideal, it's relatively high risk for regressions. There is still
some scope for adding a basic bulk allocator before considering a major
refactoring effort.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f8353ea7b977..8f3fe7de2cf7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5892,7 +5892,7 @@ __alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
 	pcp_list = &pcp->lists[migratetype];
 
 	while (nr_pages) {
-		page = __rmqueue_pcplist(zone, gfp_mask, migratetype,
+		page = __rmqueue_pcplist(zone, migratetype, alloc_flags,
 								pcp, pcp_list);
 		if (!page)
 			break;
-- 
Mel Gorman
SUSE Labs
