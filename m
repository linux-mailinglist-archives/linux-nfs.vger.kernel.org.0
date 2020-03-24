Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BF191DBA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCXXtq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCXXtq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:46 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0FC2072E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093785;
        bh=k5rZj86dcDGk+1q5xIdpBhWggFIGK8n7JGoeppfbZaI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FrubboOuLzCmgm420McS92k2Q6APd+PdNliGKPbTMzJYc2+nCBVqV/1KI42mHoOe0
         +k3eKQ3VEFJjKZlTiy09dkvGZagjgvT8z2JzSzyEyV9BDCSyRm6+aLKHwfDWdnJ41R
         sk4QV26TQ4JI7rzgArh8cstokfbqTFrExmY5q+so=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 17/22] NFS/pNFS: Simplify bucket layout segment reference counting
Date:   Tue, 24 Mar 2020 19:47:23 -0400
Message-Id: <20200324234728.8997-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-17-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
 <20200324234728.8997-9-trondmy@kernel.org>
 <20200324234728.8997-10-trondmy@kernel.org>
 <20200324234728.8997-11-trondmy@kernel.org>
 <20200324234728.8997-12-trondmy@kernel.org>
 <20200324234728.8997-13-trondmy@kernel.org>
 <20200324234728.8997-14-trondmy@kernel.org>
 <20200324234728.8997-15-trondmy@kernel.org>
 <20200324234728.8997-16-trondmy@kernel.org>
 <20200324234728.8997-17-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c       | 39 ++++++++++++++++++++-------------------
 include/linux/nfs_xdr.h |  3 +--
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 06df2e6663dc..abf16fc98346 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -59,6 +59,17 @@ void pnfs_generic_commit_release(void *calldata)
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_commit_release);
 
+static struct pnfs_layout_segment *
+pnfs_free_bucket_lseg(struct pnfs_commit_bucket *bucket)
+{
+	if (list_empty(&bucket->committing) && list_empty(&bucket->written)) {
+		struct pnfs_layout_segment *freeme = bucket->lseg;
+		bucket->lseg = NULL;
+		return freeme;
+	}
+	return NULL;
+}
+
 /* The generic layer is about to remove the req from the commit list.
  * If this will make the bucket empty, it will need to put the lseg reference.
  * Note this must be called holding nfsi->commit_mutex
@@ -78,8 +89,7 @@ pnfs_generic_clear_request_commit(struct nfs_page *req,
 		bucket = list_first_entry(&req->wb_list,
 					  struct pnfs_commit_bucket,
 					  written);
-		freeme = bucket->wlseg;
-		bucket->wlseg = NULL;
+		freeme = pnfs_free_bucket_lseg(bucket);
 	}
 out:
 	nfs_request_remove_commit_list(req, cinfo);
@@ -103,8 +113,7 @@ pnfs_alloc_commit_array(size_t n, gfp_t gfp_flags)
 	for (b = &p->buckets[0]; n != 0; b++, n--) {
 		INIT_LIST_HEAD(&b->written);
 		INIT_LIST_HEAD(&b->committing);
-		b->wlseg = NULL;
-		b->clseg = NULL;
+		b->lseg = NULL;
 		b->direct_verf.committed = NFS_INVALID_STABLE_HOW;
 	}
 	return p;
@@ -246,12 +255,6 @@ pnfs_bucket_scan_ds_commit_list(struct pnfs_commit_bucket *bucket,
 	if (ret) {
 		cinfo->ds->nwritten -= ret;
 		cinfo->ds->ncommitting += ret;
-		if (bucket->clseg == NULL)
-			bucket->clseg = pnfs_get_lseg(bucket->wlseg);
-		if (list_empty(src)) {
-			pnfs_put_lseg(bucket->wlseg);
-			bucket->wlseg = NULL;
-		}
 	}
 	return ret;
 }
@@ -317,9 +320,8 @@ pnfs_bucket_recover_commit_reqs(struct list_head *dst,
 		if (!nwritten)
 			continue;
 		ret += nwritten;
-		if (list_empty(&b->written)) {
-			freeme = b->wlseg;
-			b->wlseg = NULL;
+		freeme = pnfs_free_bucket_lseg(b);
+		if (freeme) {
 			pnfs_put_lseg(freeme);
 			goto restart;
 		}
@@ -405,15 +407,12 @@ pnfs_bucket_get_committing(struct list_head *head,
 			   struct pnfs_commit_bucket *bucket,
 			   struct nfs_commit_info *cinfo)
 {
-	struct pnfs_layout_segment *freeme;
 	struct list_head *pos;
 
 	list_for_each(pos, &bucket->committing)
 		cinfo->ds->ncommitting--;
 	list_splice_init(&bucket->committing, head);
-	freeme = bucket->clseg;
-	bucket->clseg = NULL;
-	return freeme;
+	return pnfs_free_bucket_lseg(bucket);
 }
 
 static struct nfs_commit_data *
@@ -425,6 +424,8 @@ pnfs_bucket_fetch_commitdata(struct pnfs_commit_bucket *bucket,
 	if (!data)
 		return NULL;
 	data->lseg = pnfs_bucket_get_committing(&data->pages, bucket, cinfo);
+	if (!data->lseg)
+		data->lseg = pnfs_get_lseg(bucket->lseg);
 	return data;
 }
 
@@ -1182,8 +1183,8 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 		 * off due to a rewrite, in which case it will be done in
 		 * pnfs_common_clear_request_commit
 		 */
-		WARN_ON_ONCE(buckets[ds_commit_idx].wlseg != NULL);
-		buckets[ds_commit_idx].wlseg = pnfs_get_lseg(lseg);
+		if (!buckets[ds_commit_idx].lseg)
+			buckets[ds_commit_idx].lseg = pnfs_get_lseg(lseg);
 	}
 	set_bit(PG_COMMIT_TO_DS, &req->wb_flags);
 	cinfo->ds->nwritten++;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index adbbeae9ce5b..7bbb1f6fc1b1 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1265,8 +1265,7 @@ struct nfstime4 {
 struct pnfs_commit_bucket {
 	struct list_head written;
 	struct list_head committing;
-	struct pnfs_layout_segment *wlseg;
-	struct pnfs_layout_segment *clseg;
+	struct pnfs_layout_segment *lseg;
 	struct nfs_writeverf direct_verf;
 };
 
-- 
2.25.1

