Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99CC196701
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1Pej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgC1Pei (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:38 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267032082D
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409677;
        bh=CJ8DY17KMdhfCO9nyiXNNd4crXhjDpelxBt0kju1zOw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1qsdctqpXtSB9W6+jRdk6bVH1DmPnzSmRMEeb1g9UOCpfsua5Xc8ewaDyn12EHLNm
         9Q2r9yq/GSSooFABAteKwA/q5hFJNh4a7DFtERR7flQiP+rYoik1ESEwpk0peeu3pI
         A+QH4f9hzmEVORuX2KNLGucuQnHP1Ao7HRPNyDSA=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/22] NFS: commit errors should be fatal
Date:   Sat, 28 Mar 2020 11:32:07 -0400
Message-Id: <20200328153220.1352010-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-9-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix the O_DIRECT code to avoid retries if the COMMIT fails with a fatal
error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 7ef7f71ae315..f7bf1181b690 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -94,6 +94,7 @@ struct nfs_direct_req {
 #define NFS_ODIRECT_RESCHED_WRITES	(2)	/* write verification failed */
 	/* for read */
 #define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
+#define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
 	struct nfs_writeverf	verf;		/* unstable write verifier */
 };
 
@@ -678,8 +679,17 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 	struct nfs_page *req;
 	int status = data->task.tk_status;
 
+	if (status < 0) {
+		/* Errors in commit are fatal */
+		dreq->error = status;
+		dreq->max_count = 0;
+		dreq->count = 0;
+		dreq->flags = NFS_ODIRECT_DONE;
+	} else if (dreq->flags == NFS_ODIRECT_DONE)
+		status = dreq->error;
+
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
-	if (status < 0 || nfs_direct_cmp_commit_data_verf(dreq, data))
+	if (nfs_direct_cmp_commit_data_verf(dreq, data))
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 
 	while (!list_empty(&data->pages)) {
@@ -708,7 +718,8 @@ static void nfs_direct_resched_write(struct nfs_commit_info *cinfo,
 	struct nfs_direct_req *dreq = cinfo->dreq;
 
 	spin_lock(&dreq->lock);
-	dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+	if (dreq->flags != NFS_ODIRECT_DONE)
+		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 	spin_unlock(&dreq->lock);
 	nfs_mark_request_commit(req, NULL, cinfo, 0);
 }
@@ -731,6 +742,22 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 		nfs_direct_write_reschedule(dreq);
 }
 
+static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
+{
+	struct nfs_commit_info cinfo;
+	struct nfs_page *req;
+	LIST_HEAD(reqs);
+
+	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
+
+	while (!list_empty(&reqs)) {
+		req = nfs_list_entry(reqs.next);
+		nfs_list_remove_request(req);
+		nfs_unlock_and_release_request(req);
+	}
+}
+
 static void nfs_direct_write_schedule_work(struct work_struct *work)
 {
 	struct nfs_direct_req *dreq = container_of(work, struct nfs_direct_req, work);
@@ -745,6 +772,7 @@ static void nfs_direct_write_schedule_work(struct work_struct *work)
 			nfs_direct_write_reschedule(dreq);
 			break;
 		default:
+			nfs_direct_write_clear_reqs(dreq);
 			nfs_zap_mapping(dreq->inode, dreq->inode->i_mapping);
 			nfs_direct_complete(dreq);
 	}
-- 
2.25.1

