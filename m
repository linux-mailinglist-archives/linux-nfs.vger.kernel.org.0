Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9C791BB9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjIDQlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjIDQlg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513181B7
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA708B80DBB
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB84C433CA;
        Mon,  4 Sep 2023 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845690;
        bh=GBBVt9dGPIamSYSRHKtGDMv0qL637V/v9K/ZVz4RWXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6Yrcsolzddm9e4Yi4Deb/9Y/7ldwCr8kTiGrK77ZwyIhEaWPMneK4VZuqR+dQBO7
         sOAdrsS/JCz44seI22ZNRzCfyItUE2VdA3IOE2Oew2lz6zNnwo1/oZOucCHd7QN+ij
         AUEE1SESFh+lGKWjlZrT95P3Irmt62DkR+CfqB+S4VVvtUpYPZBTat0wvfksrFDGrd
         +s+i4GFxKvv+zFqPBjbMOnEy2T7w6rt344VDXrNu2aM1fN50qEowfy6zLaEYtBuqQF
         q8HtxabLA7VPZ5F65XrquwjCzsvA+9MBe7BN8X2vwj6a0tcIJ9MHAdB7GTc1ZI+m46
         AAdpjbWaAMlzg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/5] NFS: More O_DIRECT accounting fixes for error paths
Date:   Mon,  4 Sep 2023 12:34:39 -0400
Message-ID: <20230904163441.11950-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904163441.11950-3-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <20230904163441.11950-3-trondmy@kernel.org>
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

If we hit a fatal error when retransmitting, we do need to record the
removal of the request from the count of written bytes.

Fixes: 031d73ed768a ("NFS: Fix O_DIRECT accounting of number of bytes read/written")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index e8a1645857dd..a53e50123499 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -93,12 +93,10 @@ nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
 		dreq->max_count = dreq_len;
 		if (dreq->count > dreq_len)
 			dreq->count = dreq_len;
-
-		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
-			dreq->error = hdr->error;
-		else /* Clear outstanding error if this is EOF */
-			dreq->error = 0;
 	}
+
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) && !dreq->error)
+		dreq->error = hdr->error;
 }
 
 static void
@@ -120,6 +118,18 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 		dreq->count = dreq_len;
 }
 
+static void nfs_direct_truncate_request(struct nfs_direct_req *dreq,
+					struct nfs_page *req)
+{
+	loff_t offs = req_offset(req);
+	size_t req_start = (size_t)(offs - dreq->io_start);
+
+	if (req_start < dreq->max_count)
+		dreq->max_count = req_start;
+	if (req_start < dreq->count)
+		dreq->count = req_start;
+}
+
 /**
  * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
@@ -537,10 +547,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 
 	nfs_direct_join_group(&reqs, dreq->inode);
 
-	dreq->count = 0;
-	dreq->max_count = 0;
-	list_for_each_entry(req, &reqs, wb_list)
-		dreq->max_count += req->wb_bytes;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	get_dreq(dreq);
 
@@ -574,10 +580,14 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 		req = nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
 		nfs_unlock_and_release_request(req);
-		if (desc.pg_error == -EAGAIN)
+		if (desc.pg_error == -EAGAIN) {
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
-		else
+		} else {
+			spin_lock(&dreq->lock);
+			nfs_direct_truncate_request(dreq, req);
+			spin_unlock(&dreq->lock);
 			nfs_release_request(req);
+		}
 	}
 
 	if (put_dreq(dreq))
@@ -597,8 +607,6 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 	if (status < 0) {
 		/* Errors in commit are fatal */
 		dreq->error = status;
-		dreq->max_count = 0;
-		dreq->count = 0;
 		dreq->flags = NFS_ODIRECT_DONE;
 	} else {
 		status = dreq->error;
@@ -609,7 +617,12 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
-		if (status >= 0 && !nfs_write_match_verf(verf, req)) {
+		if (status < 0) {
+			spin_lock(&dreq->lock);
+			nfs_direct_truncate_request(dreq, req);
+			spin_unlock(&dreq->lock);
+			nfs_release_request(req);
+		} else if (!nfs_write_match_verf(verf, req)) {
 			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 			/*
 			 * Despite the reboot, the write was successful,
@@ -617,7 +630,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 			 */
 			req->wb_nio = 0;
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
-		} else /* Error or match */
+		} else
 			nfs_release_request(req);
 		nfs_unlock_and_release_request(req);
 	}
@@ -670,6 +683,7 @@ static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
 	while (!list_empty(&reqs)) {
 		req = nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
+		nfs_direct_truncate_request(dreq, req);
 		nfs_release_request(req);
 		nfs_unlock_and_release_request(req);
 	}
@@ -719,7 +733,8 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 
 	nfs_direct_count_bytes(dreq, hdr);
-	if (test_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags)) {
+	if (test_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags) &&
+	    !test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
 		if (!dreq->flags)
 			dreq->flags = NFS_ODIRECT_DO_COMMIT;
 		flags = dreq->flags;
-- 
2.41.0

