Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AD5271BC
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiENOOa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiENOOY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54301580E
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E78160F1A
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DDAC34117;
        Sat, 14 May 2022 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537662;
        bh=3/4qHphF9RAyki3MqwJ+YC7f2Va4FCTc7dWLqokT5II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1+wlxFS5xATwYOZ/vJTlHoydSSA9AFzrw8G3m6RZH7CTI4O+StKFa4abmH7L+skA
         8geOytbufXhdBYFplJ1jv0qVz2/7hzHolvTcuUvStpj9GBzJ6wo7CzfFmoDlQgMxTS
         z+y+JhM3mywhVR3aMjk4bU0MCCTsH2SAH5SaouqaigK5qCKaicmA0+alnxYmkYgKHR
         NhfFKbzxFmiwIpjFBcCGePvR7kWUMhcqiNbD4a7/hCyGtBjsYyP4LuXQzkZqWSqnSQ
         eBId7o1o+PF2xrL2bCts5i9962F2DIPf/AQ3JDhmSYsuUL0BxKHOCYeoh6LGPW8l2/
         TxIgKaeG3VwYA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFS: Further fixes to the writeback error handling
Date:   Sat, 14 May 2022 10:08:12 -0400
Message-Id: <20220514140814.3655-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514140814.3655-2-trondmy@kernel.org>
References: <20220514140814.3655-1-trondmy@kernel.org>
 <20220514140814.3655-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we handle an error by redirtying the page, we're not corrupting the
mapping, so we don't want the error to be recorded in the mapping.
If the caller has specified a sync_mode of WB_SYNC_NONE, we can just
return AOP_WRITEPAGE_ACTIVATE. However if we're dealing with
WB_SYNC_ALL, we need to ensure that retries happen when the errors are
non-fatal.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Fixes: 8fc75bed96bb ("NFS: Fix up return value on fatal errors in nfs_page_async_flush()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f00d45cf80ef..a8eb348947a6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -603,8 +603,9 @@ static void nfs_write_error(struct nfs_page *req, int error)
  * Find an associated nfs write request, and prepare to flush it out
  * May return an error if the user signalled nfs_wait_on_request().
  */
-static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
-				struct page *page)
+static int nfs_page_async_flush(struct page *page,
+				struct writeback_control *wbc,
+				struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_page *req;
 	int ret = 0;
@@ -630,11 +631,11 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 		/*
 		 * Remove the problematic req upon fatal errors on the server
 		 */
-		if (nfs_error_is_fatal(ret)) {
-			if (nfs_error_is_fatal_on_server(ret))
-				goto out_launder;
-		} else
-			ret = -EAGAIN;
+		if (nfs_error_is_fatal_on_server(ret))
+			goto out_launder;
+		if (wbc->sync_mode == WB_SYNC_NONE)
+			ret = AOP_WRITEPAGE_ACTIVATE;
+		redirty_page_for_writepage(wbc, page);
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
 	} else
@@ -650,15 +651,8 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
 			    struct nfs_pageio_descriptor *pgio)
 {
-	int ret;
-
 	nfs_pageio_cond_complete(pgio, page_index(page));
-	ret = nfs_page_async_flush(pgio, page);
-	if (ret == -EAGAIN) {
-		redirty_page_for_writepage(wbc, page);
-		ret = AOP_WRITEPAGE_ACTIVATE;
-	}
-	return ret;
+	return nfs_page_async_flush(page, wbc, pgio);
 }
 
 /*
@@ -737,12 +731,15 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		priority = wb_priority(wbc);
 	}
 
-	nfs_pageio_init_write(&pgio, inode, priority, false,
-				&nfs_async_write_completion_ops);
-	pgio.pg_io_completion = ioc;
-	err = write_cache_pages(mapping, wbc, nfs_writepages_callback, &pgio);
-	pgio.pg_error = 0;
-	nfs_pageio_complete(&pgio);
+	do {
+		nfs_pageio_init_write(&pgio, inode, priority, false,
+				      &nfs_async_write_completion_ops);
+		pgio.pg_io_completion = ioc;
+		err = write_cache_pages(mapping, wbc, nfs_writepages_callback,
+					&pgio);
+		pgio.pg_error = 0;
+		nfs_pageio_complete(&pgio);
+	} while (err < 0 && !nfs_error_is_fatal(err));
 	nfs_io_completion_put(ioc);
 
 	if (err < 0)
-- 
2.36.1

