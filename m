Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C911966FE
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgC1Peq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgC1Pei (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:38 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0792073B
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409677;
        bh=4UKHW+bceR/NVQzUHY3TZwKQ1VBLWQyS8R7IzFwQMr8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ofJHEV19qLdVjx1Red+FWOGbdPgGqvLBhtmD/HOpX/dgTye41hselAAPxni9Mn43g
         j4jkbdf8P8m5sQhHOCuZrcUA44C7TecyJhr1qDzsVUz57K0nuF74IrjtZSyd7qVOVM
         +SoarJ03rLU+65P3FQ1mc4t4wPQEN08H1+qi0kyw=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/22] NFS: Fix O_DIRECT commit verifier handling
Date:   Sat, 28 Mar 2020 11:32:08 -0400
Message-Id: <20200328153220.1352010-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-10-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
 <20200328153220.1352010-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of trying to save the commit verifiers and checking them against
previous writes, adopt the same strategy as for buffered writes, of
just checking the verifiers at commit time.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c   | 135 +++++-----------------------------------------
 fs/nfs/internal.h |   8 +++
 fs/nfs/write.c    |   3 +-
 3 files changed, 22 insertions(+), 124 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index f7bf1181b690..4ee26465b510 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -95,7 +95,6 @@ struct nfs_direct_req {
 	/* for read */
 #define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
 #define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
-	struct nfs_writeverf	verf;		/* unstable write verifier */
 };
 
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops;
@@ -152,106 +151,6 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 		dreq->count = dreq_len;
 }
 
-/*
- * nfs_direct_select_verf - select the right verifier
- * @dreq - direct request possibly spanning multiple servers
- * @ds_clp - nfs_client of data server or NULL if MDS / non-pnfs
- * @commit_idx - commit bucket index for the DS
- *
- * returns the correct verifier to use given the role of the server
- */
-static struct nfs_writeverf *
-nfs_direct_select_verf(struct nfs_direct_req *dreq,
-		       struct nfs_client *ds_clp,
-		       int commit_idx)
-{
-	struct nfs_writeverf *verfp = &dreq->verf;
-
-#ifdef CONFIG_NFS_V4_1
-	/*
-	 * pNFS is in use, use the DS verf except commit_through_mds is set
-	 * for layout segment where nbuckets is zero.
-	 */
-	if (ds_clp && dreq->ds_cinfo.nbuckets > 0) {
-		if (commit_idx >= 0 && commit_idx < dreq->ds_cinfo.nbuckets)
-			verfp = &dreq->ds_cinfo.buckets[commit_idx].direct_verf;
-		else
-			WARN_ON_ONCE(1);
-	}
-#endif
-	return verfp;
-}
-
-
-/*
- * nfs_direct_set_hdr_verf - set the write/commit verifier
- * @dreq - direct request possibly spanning multiple servers
- * @hdr - pageio header to validate against previously seen verfs
- *
- * Set the server's (MDS or DS) "seen" verifier
- */
-static void nfs_direct_set_hdr_verf(struct nfs_direct_req *dreq,
-				    struct nfs_pgio_header *hdr)
-{
-	struct nfs_writeverf *verfp;
-
-	verfp = nfs_direct_select_verf(dreq, hdr->ds_clp, hdr->ds_commit_idx);
-	WARN_ON_ONCE(verfp->committed >= 0);
-	memcpy(verfp, &hdr->verf, sizeof(struct nfs_writeverf));
-	WARN_ON_ONCE(verfp->committed < 0);
-}
-
-static int nfs_direct_cmp_verf(const struct nfs_writeverf *v1,
-		const struct nfs_writeverf *v2)
-{
-	return nfs_write_verifier_cmp(&v1->verifier, &v2->verifier);
-}
-
-/*
- * nfs_direct_cmp_hdr_verf - compare verifier for pgio header
- * @dreq - direct request possibly spanning multiple servers
- * @hdr - pageio header to validate against previously seen verf
- *
- * set the server's "seen" verf if not initialized.
- * returns result of comparison between @hdr->verf and the "seen"
- * verf of the server used by @hdr (DS or MDS)
- */
-static int nfs_direct_set_or_cmp_hdr_verf(struct nfs_direct_req *dreq,
-					  struct nfs_pgio_header *hdr)
-{
-	struct nfs_writeverf *verfp;
-
-	verfp = nfs_direct_select_verf(dreq, hdr->ds_clp, hdr->ds_commit_idx);
-	if (verfp->committed < 0) {
-		nfs_direct_set_hdr_verf(dreq, hdr);
-		return 0;
-	}
-	return nfs_direct_cmp_verf(verfp, &hdr->verf);
-}
-
-/*
- * nfs_direct_cmp_commit_data_verf - compare verifier for commit data
- * @dreq - direct request possibly spanning multiple servers
- * @data - commit data to validate against previously seen verf
- *
- * returns result of comparison between @data->verf and the verf of
- * the server used by @data (DS or MDS)
- */
-static int nfs_direct_cmp_commit_data_verf(struct nfs_direct_req *dreq,
-					   struct nfs_commit_data *data)
-{
-	struct nfs_writeverf *verfp;
-
-	verfp = nfs_direct_select_verf(dreq, data->ds_clp,
-					 data->ds_commit_index);
-
-	/* verifier not set so always fail */
-	if (verfp->committed < 0 || data->res.verf->committed <= NFS_UNSTABLE)
-		return 1;
-
-	return nfs_direct_cmp_verf(verfp, data->res.verf);
-}
-
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
  * @iocb: target I/O control block
@@ -307,7 +206,6 @@ static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 	init_completion(&dreq->completion);
 	INIT_LIST_HEAD(&dreq->mds_cinfo.list);
 	pnfs_init_ds_commit_info(&dreq->ds_cinfo);
-	dreq->verf.committed = NFS_INVALID_STABLE_HOW;	/* not set yet */
 	INIT_WORK(&dreq->work, nfs_direct_write_schedule_work);
 	spin_lock_init(&dreq->lock);
 
@@ -637,7 +535,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	dreq->max_count = 0;
 	list_for_each_entry(req, &reqs, wb_list)
 		dreq->max_count += req->wb_bytes;
-	dreq->verf.committed = NFS_INVALID_STABLE_HOW;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	get_dreq(dreq);
 
@@ -674,6 +571,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 
 static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 {
+	const struct nfs_writeverf *verf = data->res.verf;
 	struct nfs_direct_req *dreq = data->dreq;
 	struct nfs_commit_info cinfo;
 	struct nfs_page *req;
@@ -689,21 +587,19 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 		status = dreq->error;
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
-	if (nfs_direct_cmp_commit_data_verf(dreq, data))
-		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
-		if (dreq->flags == NFS_ODIRECT_RESCHED_WRITES) {
+		if (status >= 0 && !nfs_write_match_verf(verf, req)) {
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 			/*
 			 * Despite the reboot, the write was successful,
 			 * so reset wb_nio.
 			 */
 			req->wb_nio = 0;
-			/* Note the rewrite will go through mds */
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
-		} else
+		} else /* Error or match */
 			nfs_release_request(req);
 		nfs_unlock_and_release_request(req);
 	}
@@ -799,20 +695,15 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 
 	nfs_direct_count_bytes(dreq, hdr);
-	if (hdr->good_bytes != 0) {
-		if (nfs_write_need_commit(hdr)) {
-			if (dreq->flags == NFS_ODIRECT_RESCHED_WRITES)
-				request_commit = true;
-			else if (dreq->flags == 0) {
-				nfs_direct_set_hdr_verf(dreq, hdr);
-				request_commit = true;
-				dreq->flags = NFS_ODIRECT_DO_COMMIT;
-			} else if (dreq->flags == NFS_ODIRECT_DO_COMMIT) {
-				request_commit = true;
-				if (nfs_direct_set_or_cmp_hdr_verf(dreq, hdr))
-					dreq->flags =
-						NFS_ODIRECT_RESCHED_WRITES;
-			}
+	if (hdr->good_bytes != 0 && nfs_write_need_commit(hdr)) {
+		switch (dreq->flags) {
+		case 0:
+			dreq->flags = NFS_ODIRECT_DO_COMMIT;
+			request_commit = true;
+			break;
+		case NFS_ODIRECT_RESCHED_WRITES:
+		case NFS_ODIRECT_DO_COMMIT:
+			request_commit = true;
 		}
 	}
 	spin_unlock(&dreq->lock);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3b6fa9edc9b5..6542411c020f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -544,6 +544,14 @@ nfs_write_verifier_cmp(const struct nfs_write_verifier *v1,
 	return memcmp(v1->data, v2->data, sizeof(v1->data));
 }
 
+static inline bool
+nfs_write_match_verf(const struct nfs_writeverf *verf,
+		struct nfs_page *req)
+{
+	return verf->committed > NFS_UNSTABLE &&
+		!nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier);
+}
+
 /* unlink.c */
 extern struct rpc_task *
 nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1f8108f5a041..03b7f64f7c4f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1874,8 +1874,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 
 		/* Okay, COMMIT succeeded, apparently. Check the verifier
 		 * returned by the server against all stored verfs. */
-		if (verf->committed > NFS_UNSTABLE &&
-		    !nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier)) {
+		if (nfs_write_match_verf(verf, req)) {
 			/* We have a match */
 			if (req->wb_page)
 				nfs_inode_remove_request(req);
-- 
2.25.1

