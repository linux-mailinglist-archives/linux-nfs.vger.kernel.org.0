Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F53B6772
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhF1RRo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhF1RRl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 13:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD9AE61C49;
        Mon, 28 Jun 2021 17:15:15 +0000 (UTC)
Subject: [PATCH] mm/page_alloc: Return nr_populated when the array is full
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 28 Jun 2021 13:15:15 -0400
Message-ID: <162490051493.1165.8122675403341013520.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The SUNRPC consumer of __alloc_bulk_pages() legitimately calls it
with a full array sometimes. In that case, the correct return code,
according to the API contract, is to return the number of requested
pages.

Fixes: b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after checking populated elements")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/page_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef2265f86b91..79f88c4ae372 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return 0;
+		return nr_pages;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)


