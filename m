Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162473B6823
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhF1SP0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 14:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhF1SP0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 14:15:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A0F061C6F;
        Mon, 28 Jun 2021 18:13:00 +0000 (UTC)
Subject: [PATCH v2] mm/page_alloc: Return nr_populated when the array is full
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 28 Jun 2021 14:12:59 -0400
Message-ID: <162490397938.1485.7782934829743772831.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The SUNRPC consumer of __alloc_bulk_pages() legitimately calls it
with a full array sometimes. In that case, the correct return code,
according to the API contract, is to return the number of pages
already in the array/list.

Let's clean up the return logic to make it clear that the returned
value is always the total number of pages in the array/list, not the
number of pages that were allocated during this call.

Fixes: b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after checking populated elements")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/page_alloc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef2265f86b91..270719898b47 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5047,7 +5047,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	int nr_populated = 0;
 
 	if (unlikely(nr_pages <= 0))
-		return 0;
+		goto out;
 
 	/*
 	 * Skip populated array elements to determine if any pages need
@@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return 0;
+		goto out;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
@@ -5068,7 +5068,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
-		return 0;
+		goto out;
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
@@ -5141,6 +5141,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	local_irq_restore(flags);
 
+out:
 	return nr_populated;
 
 failed_irq:
@@ -5156,7 +5157,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	return nr_populated;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(__alloc_pages_bulk);
 


