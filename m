Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84279C41BB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfJAUWL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 16:22:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46285 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfJAUWL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 16:22:11 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so51287264ioo.13
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfXlUD2/FjVI6IpngUHytoepLuqiG/fjbsVIP91taqU=;
        b=EADg+HA6yDjHOohmYSjZFIbnlT1hsLw6LEnCBsFkpdEwt5NZhvrGiSIsqmR3tSo3e/
         1evG+qaZwkvCBmih2sNwzwg3Uq7j1fnyWVQroNLGUpNen1cDWG/7ENvh3fcoozLDCBUF
         0oYFV88SlMVFn20uMQz3sb+HjdtZEvHSauKL9J0RLm2/Ef3384Nojtq4RGLfgmG7HcQB
         nbKtTFZBF8nTu/VUqjUjTi1LmsU5CJ7O+EmR/G0h6BnzEXwB/5CR9mVi9XYg4i9o2Tof
         9Kde/5QsiPYRRdvKg98Ai39mzwLzaf3+qsHjMChJyvgbuiOoNGjkVYPprDJb3lYZF/Tn
         q2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfXlUD2/FjVI6IpngUHytoepLuqiG/fjbsVIP91taqU=;
        b=Sjbkv/OcXIscLj7Rw4wHahwWViaVQtAr6u8+OQcogA0jWSdc2hfWUGbZgfFiyMtptj
         2pRJSFw/hcoq2w3WHd5G09qVAqJkOi36PwvBBSxvv6OuZ0TJPdvOKECyjkWSNPhud9gV
         xfIIgAvQGyFjaVkukvHGAXVfD2ultd+1WyJwy1MGHO3R3PigycMYphlOCUfj4fsD+BB5
         5IFpIQI+8iJvFxPEjigZskfdnjAZFfWuCI4y/jHpdEMilxMnhv8UxMziHDSUOba6Eo9t
         1y4IKLr9nb5l3/n1wXR3TO0BfY2/pTkWoNozhhXVLUW3sjMcaFqTtjIhMeOSpgikJj2A
         Nxkw==
X-Gm-Message-State: APjAAAWPe+3TWSweXgrUI4RN/r8LEuSyUl+ms3hSKhA3oTk/SDI1IJrL
        PWbxHubRot4WKum9U15Xdg==
X-Google-Smtp-Source: APXvYqwerP7F//FcXpZxQFP6y4ClLaDN0qVOTGnj2jPPxqXZsyucIJw9CPF1DM/qLS27OzIJJDW4jQ==
X-Received: by 2002:a92:8c84:: with SMTP id s4mr28689324ill.106.1569961330617;
        Tue, 01 Oct 2019 13:22:10 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c65sm8038648ilg.26.2019.10.01.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:22:10 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFS: Remove redundant mirror tracking in O_DIRECT
Date:   Tue,  1 Oct 2019 16:20:00 -0400
Message-Id: <20191001202000.13248-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001202000.13248-2-trond.myklebust@hammerspace.com>
References: <20191001202000.13248-1-trond.myklebust@hammerspace.com>
 <20191001202000.13248-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We no longer need the extra mirror length tracking in the O_DIRECT code,
as we are able to track the maximum contiguous length in dreq->max_count.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 62cb4a1a87f0..c959d7a3044c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -64,13 +64,6 @@
 
 static struct kmem_cache *nfs_direct_cachep;
 
-/*
- * This represents a set of asynchronous requests that we're waiting on
- */
-struct nfs_direct_mirror {
-	ssize_t count;
-};
-
 struct nfs_direct_req {
 	struct kref		kref;		/* release manager */
 
@@ -84,9 +77,6 @@ struct nfs_direct_req {
 	atomic_t		io_count;	/* i/os we're waiting for */
 	spinlock_t		lock;		/* protect completion state */
 
-	struct nfs_direct_mirror mirrors[NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX];
-	int			mirror_count;
-
 	loff_t			io_start;	/* Start offset for I/O */
 	ssize_t			count,		/* bytes actually processed */
 				max_count,	/* max expected count */
@@ -127,7 +117,6 @@ nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
 			    const struct nfs_pgio_header *hdr,
 			    ssize_t dreq_len)
 {
-	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
 	loff_t hdr_arg = hdr->io_start + hdr->args.count;
 	ssize_t expected = 0;
 
@@ -146,15 +135,12 @@ nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
 		else if (hdr->good_bytes > 0)
 			dreq->error = 0;
 	}
-	if (mirror->count > dreq_len)
-		mirror->count = dreq_len;
 }
 
 static void
 nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 		       const struct nfs_pgio_header *hdr)
 {
-	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
 	loff_t hdr_end = hdr->io_start + hdr->good_bytes;
 	ssize_t dreq_len = 0;
 
@@ -166,8 +152,6 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 	if (dreq_len > dreq->max_count)
 		dreq_len = dreq->max_count;
 
-	if (mirror->count < dreq_len)
-		mirror->count = dreq_len;
 	if (dreq->count < dreq_len)
 		dreq->count = dreq_len;
 }
@@ -314,18 +298,6 @@ void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 	cinfo->completion_ops = &nfs_direct_commit_completion_ops;
 }
 
-static inline void nfs_direct_setup_mirroring(struct nfs_direct_req *dreq,
-					     struct nfs_pageio_descriptor *pgio,
-					     struct nfs_page *req)
-{
-	int mirror_count = 1;
-
-	if (pgio->pg_ops->pg_get_mirror_count)
-		mirror_count = pgio->pg_ops->pg_get_mirror_count(pgio, req);
-
-	dreq->mirror_count = mirror_count;
-}
-
 static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 {
 	struct nfs_direct_req *dreq;
@@ -340,7 +312,6 @@ static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 	INIT_LIST_HEAD(&dreq->mds_cinfo.list);
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;	/* not set yet */
 	INIT_WORK(&dreq->work, nfs_direct_write_schedule_work);
-	dreq->mirror_count = 1;
 	spin_lock_init(&dreq->lock);
 
 	return dreq;
@@ -659,7 +630,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(reqs);
 	struct nfs_commit_info cinfo;
 	LIST_HEAD(failed);
-	int i;
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
@@ -670,21 +640,12 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 		dreq->max_count += req->wb_bytes;
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
-	for (i = 0; i < dreq->mirror_count; i++)
-		dreq->mirrors[i].count = 0;
 	get_dreq(dreq);
 
 	nfs_pageio_init_write(&desc, dreq->inode, FLUSH_STABLE, false,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
 
-	req = nfs_list_entry(reqs.next);
-	nfs_direct_setup_mirroring(dreq, &desc, req);
-	if (desc.pg_error < 0) {
-		list_splice_init(&reqs, &failed);
-		goto out_failed;
-	}
-
 	list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
 		/* Bump the transmission count */
 		req->wb_nio++;
@@ -702,7 +663,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	}
 	nfs_pageio_complete(&desc);
 
-out_failed:
 	while (!list_empty(&failed)) {
 		req = nfs_list_entry(failed.next);
 		nfs_list_remove_request(req);
@@ -935,7 +895,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 				break;
 			}
 
-			nfs_direct_setup_mirroring(dreq, &desc, req);
 			if (desc.pg_error < 0) {
 				nfs_free_request(req);
 				result = desc.pg_error;
-- 
2.21.0

