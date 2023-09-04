Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D48791BB6
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjIDQle (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjIDQld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E72B199
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A103616F4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19865C433C8;
        Mon,  4 Sep 2023 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845689;
        bh=2UwLvghTRLYp90etoAHUjh1QPfZfnDpXQaSvdBAmsM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jp0KHDD+r0pJ2e7CVrZhNhyqmVsa402/LO/jDwdQZ8g3jrh68JR1KpfPxBbnSw9MM
         WsWF1nxcrDO48x9FYrEbuItRa0kHERfb+lJhMz0pqAZ/YXoIRdejkRQ5eYeItYL1se
         1jp+7ZTNWb3VpEIbj2bDz9b5lpDiUMnNScUiHnsva31WHuhpSY59xfbidks5z+L5il
         VyWbw4uujoGrxzZTLQaoGlZXMvBYB37HMQ8HldffdTlOtUOIm7/QarqjzsNWybSUFz
         XGlQ+b2rAmfZH760Y8TdZ9A/Y03ntg77AF0fr4QtAD4A+eGufaCTtkOcH/kenwp7w6
         /eIEBT3S15Yvg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write scheduling
Date:   Mon,  4 Sep 2023 12:34:37 -0400
Message-ID: <20230904163441.11950-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904163441.11950-1-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we fail to schedule a request for transmission, there are 2
possibilities:
1) Either we hit a fatal error, and we just want to drop the remaining
   requests on the floor.
2) We were asked to try again, in which case we should allow the
   outstanding RPC calls to complete, so that we can recoalesce requests
   and try again.

Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 62 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 47d892a1d363..ee88f0a6e7b8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -528,10 +528,9 @@ nfs_direct_write_scan_commit_list(struct inode *inode,
 static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 {
 	struct nfs_pageio_descriptor desc;
-	struct nfs_page *req, *tmp;
+	struct nfs_page *req;
 	LIST_HEAD(reqs);
 	struct nfs_commit_info cinfo;
-	LIST_HEAD(failed);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
@@ -549,27 +548,36 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
 
-	list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
+	while (!list_empty(&reqs)) {
+		req = nfs_list_entry(reqs.next);
 		/* Bump the transmission count */
 		req->wb_nio++;
 		if (!nfs_pageio_add_request(&desc, req)) {
-			nfs_list_move_request(req, &failed);
 			spin_lock(&cinfo.inode->i_lock);
-			dreq->flags = 0;
-			if (desc.pg_error < 0)
+			if (dreq->error < 0) {
+				desc.pg_error = dreq->error;
+			} else if (desc.pg_error != -EAGAIN) {
+				dreq->flags = 0;
+				if (!desc.pg_error)
+					desc.pg_error = -EIO;
 				dreq->error = desc.pg_error;
-			else
-				dreq->error = -EIO;
+			} else
+				dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 			spin_unlock(&cinfo.inode->i_lock);
+			break;
 		}
 		nfs_release_request(req);
 	}
 	nfs_pageio_complete(&desc);
 
-	while (!list_empty(&failed)) {
-		req = nfs_list_entry(failed.next);
+	while (!list_empty(&reqs)) {
+		req = nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
 		nfs_unlock_and_release_request(req);
+		if (desc.pg_error == -EAGAIN)
+			nfs_mark_request_commit(req, NULL, &cinfo, 0);
+		else
+			nfs_release_request(req);
 	}
 
 	if (put_dreq(dreq))
@@ -794,9 +802,11 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 {
 	struct nfs_pageio_descriptor desc;
 	struct inode *inode = dreq->inode;
+	struct nfs_commit_info cinfo;
 	ssize_t result = 0;
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
+	bool defer = false;
 
 	trace_nfs_direct_write_schedule_iovec(dreq);
 
@@ -837,17 +847,37 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 				break;
 			}
 
-			nfs_lock_request(req);
-			if (!nfs_pageio_add_request(&desc, req)) {
-				result = desc.pg_error;
-				nfs_unlock_and_release_request(req);
-				break;
-			}
 			pgbase = 0;
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
 			dreq->bytes_left -= req_len;
+
+			if (defer) {
+				nfs_mark_request_commit(req, NULL, &cinfo, 0);
+				continue;
+			}
+
+			nfs_lock_request(req);
+			if (nfs_pageio_add_request(&desc, req))
+				continue;
+
+			/* Exit on hard errors */
+			if (desc.pg_error < 0 && desc.pg_error != -EAGAIN) {
+				result = desc.pg_error;
+				nfs_unlock_and_release_request(req);
+				break;
+			}
+
+			/* If the error is soft, defer remaining requests */
+			nfs_init_cinfo_from_dreq(&cinfo, dreq);
+			spin_lock(&cinfo.inode->i_lock);
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+			spin_unlock(&cinfo.inode->i_lock);
+			nfs_unlock_request(req);
+			nfs_mark_request_commit(req, NULL, &cinfo, 0);
+			desc.pg_error = 0;
+			defer = true;
 		}
 		nfs_direct_release_pages(pagevec, npages);
 		kvfree(pagevec);
-- 
2.41.0

