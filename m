Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741867456D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjASWDK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjASWCd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23171C41E9
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E66D961D66
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64941C433D2;
        Thu, 19 Jan 2023 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164419;
        bh=GAp/AQBiIe4Q9kAQsb+g9Hews7VOhEWHxq6f5MjkLgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2m6D9aF4UH/xFXfH0oWiKoFQeCIKWi2iA09ZwP5qx3Y/khJgshYfAjYo2EI9NjsK
         bcrL6q/G3YvqdrrA8syO48samXRbMecx1cWkvbZAcIJ4I7VS+HvORQVCQiRco+6q6l
         4YLUFrK7DnNQhQ7x4k/QiYbsXJ7MIx+Gz/oxG3C1UN5qoVo4q8Wo5Ts9kCgoRRCb29
         1lioDe/jrnk+h+C9GrzvZ3MkljmtcuOMF2m6koIj1OE7sude65fHjjWaXZkKlRIiDG
         fUV4j0jNk9JCBGjFzpyT5hYQCRDhFtS30Tny2WOdHgDAG8VS69rNRBl+V75etUb3je
         X8KgkMqr2CC1Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/18] NFS: Fix nfs_coalesce_size() to work with folios
Date:   Thu, 19 Jan 2023 16:33:37 -0500
Message-Id: <20230119213351.443388-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-4-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use the helper folio_size() where appropriate.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        | 28 +++++++++++++++++++---------
 include/linux/nfs_page.h | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 174462722266..16c146ca7ffc 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1084,6 +1084,24 @@ static bool nfs_match_lock_context(const struct nfs_lock_context *l1,
 	return l1->lockowner == l2->lockowner;
 }
 
+static bool nfs_page_is_contiguous(const struct nfs_page *prev,
+				   const struct nfs_page *req)
+{
+	size_t prev_end = prev->wb_pgbase + prev->wb_bytes;
+
+	if (req_offset(req) != req_offset(prev) + prev->wb_bytes)
+		return false;
+	if (req->wb_pgbase == 0)
+		return prev_end == nfs_page_max_length(prev);
+	if (req->wb_pgbase == prev_end) {
+		struct folio *folio = nfs_page_to_folio(req);
+		if (folio)
+			return folio == nfs_page_to_folio(prev);
+		return req->wb_page == prev->wb_page;
+	}
+	return false;
+}
+
 /**
  * nfs_coalesce_size - test two requests for compatibility
  * @prev: pointer to nfs_page
@@ -1112,16 +1130,8 @@ static unsigned int nfs_coalesce_size(struct nfs_page *prev,
 		    !nfs_match_lock_context(req->wb_lock_context,
 					    prev->wb_lock_context))
 			return 0;
-		if (req_offset(req) != req_offset(prev) + prev->wb_bytes)
+		if (!nfs_page_is_contiguous(prev, req))
 			return 0;
-		if (req->wb_page == prev->wb_page) {
-			if (req->wb_pgbase != prev->wb_pgbase + prev->wb_bytes)
-				return 0;
-		} else {
-			if (req->wb_pgbase != 0 ||
-			    prev->wb_pgbase + prev->wb_bytes != PAGE_SIZE)
-				return 0;
-		}
 	}
 	return pgio->pg_ops->pg_test(pgio, prev, req);
 }
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index d2ddc9a594c5..192071a6e5f6 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -189,6 +189,21 @@ static inline struct page *nfs_page_to_page(const struct nfs_page *req,
 	return folio_page(folio, pgbase >> PAGE_SHIFT);
 }
 
+/**
+ * nfs_page_max_length - Retrieve the maximum possible length for a request
+ * @req: pointer to a struct nfs_page
+ *
+ * Returns the maximum possible length of a request
+ */
+static inline size_t nfs_page_max_length(const struct nfs_page *req)
+{
+	struct folio *folio = nfs_page_to_folio(req);
+
+	if (folio == NULL)
+		return PAGE_SIZE;
+	return folio_size(folio);
+}
+
 /*
  * Lock the page of an asynchronous request
  */
-- 
2.39.0

