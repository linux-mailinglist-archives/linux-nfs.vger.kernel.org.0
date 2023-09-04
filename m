Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC50791BBA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjIDQlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjIDQlh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2C199
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46724B80E6D
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D84C433C9;
        Mon,  4 Sep 2023 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845691;
        bh=D7UCfNE+Mz3t76Pd6aqc5fxgctpnM1AE0uBJBM/GUwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRgIssJ0/T1UmKE1I4aaokn/X5/4CRjgf+BH9f4Rrecr8bgDno/48bYx7kkcx0h3k
         kvw1CxFonypDvSgo6SQRXuRT8S5RwWVcIarSaye1xB6txw5oaG8T2oWq6lFA9q1GUA
         192TG94qI5o4VAfipnJipwbcw1lL4wI8FkW14KiGvmOjSlpx+Dwqn3AZTC0I4imINV
         yhCY/WTuIVrsqgYQy8oIc/OisfO0nY75stgaSAl0apUK11Zs95dgGAU2mXj7yagRGI
         4QDjJcjp6oL07XBZMPrkHjMd6YOs+tyel4OqxaJA7nmXcRiND9yLnICToB8yPuyNH5
         fio1AhgNLNNEw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/5] NFS: Use the correct commit info in nfs_join_page_group()
Date:   Mon,  4 Sep 2023 12:34:40 -0400
Message-ID: <20230904163441.11950-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904163441.11950-4-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <20230904163441.11950-3-trondmy@kernel.org>
 <20230904163441.11950-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that nfs_clear_request_commit() updates the correct counters when
it removes them from the commit list.

Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c          |  8 +++++---
 fs/nfs/write.c           | 23 ++++++++++++-----------
 include/linux/nfs_page.h |  4 +++-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a53e50123499..3391c8b97da5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -498,7 +498,9 @@ static void nfs_direct_add_page_head(struct list_head *list,
 	kref_get(&head->wb_kref);
 }
 
-static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list,
+				  struct nfs_commit_info *cinfo,
+				  struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
@@ -520,7 +522,7 @@ static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 				nfs_release_request(subreq);
 			}
 		} while ((subreq = subreq->wb_this_page) != req);
-		nfs_join_page_group(req, inode);
+		nfs_join_page_group(req, cinfo, inode);
 	}
 }
 
@@ -545,7 +547,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
-	nfs_direct_join_group(&reqs, dreq->inode);
+	nfs_direct_join_group(&reqs, &cinfo, dreq->inode);
 
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	get_dreq(dreq);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f4cca8f00c0c..8c1ee1a1a28f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -59,7 +59,8 @@ static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
 static void nfs_inode_remove_request(struct nfs_page *req);
-static void nfs_clear_request_commit(struct nfs_page *req);
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
@@ -502,8 +503,8 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-void
-nfs_join_page_group(struct nfs_page *head, struct inode *inode)
+void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
+			 struct inode *inode)
 {
 	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
@@ -533,7 +534,7 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
 	do {
-		nfs_clear_request_commit(subreq);
+		nfs_clear_request_commit(cinfo, subreq);
 		subreq = subreq->wb_this_page;
 	} while (subreq != head);
 
@@ -566,8 +567,10 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 {
 	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_page *head;
+	struct nfs_commit_info cinfo;
 	int ret;
 
+	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
@@ -584,7 +587,7 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 		return ERR_PTR(ret);
 	}
 
-	nfs_join_page_group(head, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 
 	return head;
 }
@@ -955,18 +958,16 @@ static void nfs_folio_clear_commit(struct folio *folio)
 }
 
 /* Called holding the request lock on @req */
-static void
-nfs_clear_request_commit(struct nfs_page *req)
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req)
 {
 	if (test_bit(PG_CLEAN, &req->wb_flags)) {
 		struct nfs_open_context *ctx = nfs_req_openctx(req);
 		struct inode *inode = d_inode(ctx->dentry);
-		struct nfs_commit_info cinfo;
 
-		nfs_init_cinfo_from_inode(&cinfo, inode);
 		mutex_lock(&NFS_I(inode)->commit_mutex);
-		if (!pnfs_clear_request_commit(req, &cinfo)) {
-			nfs_request_remove_commit_list(req, &cinfo);
+		if (!pnfs_clear_request_commit(req, cinfo)) {
+			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
 		nfs_folio_clear_commit(nfs_page_to_folio(req));
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index aa9f4c6ebe26..1c315f854ea8 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -157,7 +157,9 @@ extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
-extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
+extern void nfs_join_page_group(struct nfs_page *head,
+				struct nfs_commit_info *cinfo,
+				struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
-- 
2.41.0

