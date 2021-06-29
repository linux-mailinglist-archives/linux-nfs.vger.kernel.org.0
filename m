Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91D3B7379
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhF2Nuo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhF2Nun (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 29 Jun 2021 09:50:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E360761D8B;
        Tue, 29 Jun 2021 13:48:15 +0000 (UTC)
Subject: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk() return
 value
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com
Date:   Tue, 29 Jun 2021 09:48:15 -0400
Message-ID: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The author of commit b3b64ebd3822 ("mm/page_alloc: do bulk array
bounds check after checking populated elements") was possibly
confused by the mixture of return values throughout the function.

The API contract is clear that the function "Returns the number of
pages on the list or array." It does not list zero as a unique
return value with a special meaning. Therefore zero is a plausible
return value only if @nr_pages is zero or less.

Clean up the return logic to make it clear that the returned value
is always the total number of pages in the array/list, not the
number of pages that were allocated during this call.

The only change in behavior with this patch is the value returned
if prepare_alloc_pages() fails. To match the API contract, the
number of pages currently in the array/list is returned in this
case.

The call site in __page_pool_alloc_pages_slow() also seems to be
confused on this matter. It should be attended to by someone who
is familiar with that code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/page_alloc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e7af86e1a312..49eb2e134f9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5059,7 +5059,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	int nr_populated = 0;
 
 	if (unlikely(nr_pages <= 0))
-		return 0;
+		goto out;
 
 	/*
 	 * Skip populated array elements to determine if any pages need
@@ -5070,7 +5070,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return nr_populated;
+		goto out;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
@@ -5080,7 +5080,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
-		return 0;
+		goto out;
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
@@ -5153,6 +5153,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	local_irq_restore(flags);
 
+out:
 	return nr_populated;
 
 failed_irq:
@@ -5168,7 +5169,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	return nr_populated;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(__alloc_pages_bulk);
 


