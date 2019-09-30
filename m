Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64BC26EB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfI3Umn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 16:42:43 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:35767 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfI3Umn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Sep 2019 16:42:43 -0400
Received: by mail-io1-f42.google.com with SMTP id q10so42042443iop.2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2019 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpaLJj8dxMw9Hs4m6/PFmPhbHeinqqV9Imo/JDxMe3Q=;
        b=BHs5ZwAcOOMlnV/nZn8A9hgLJ/V8FHtX/lFsk3X+LMksVcyoSjfFllh/E/HZr5vYAZ
         shTy1uYqdGWATS2SiBjPqL5oombAjQjScSKzpw7Hi6wJFNqYiLos0q4R8P8Gs6rBrNaG
         8DCutn9Qnip5U7BeCBt14W3StLKWqy4hBLQLvbiQuc3KuQX8tGjMtTmyyr10IcHhhU2R
         Fzs5w8BgHq2lf2BNPo5jFIkPog3tEEMmVTps0oCTkurctvJUQVI8l4aRqs1aKd9C9F/L
         B6IuutkOA1AK3dVnNNlpH7Pox3I4lDC3QLAvTmC4Ss5CQkyov720SW5D7Xi+jZq66+pJ
         j8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpaLJj8dxMw9Hs4m6/PFmPhbHeinqqV9Imo/JDxMe3Q=;
        b=TS3T7elaM1OEDH0oPBTwcT4KsuSRft+IG7q2tH0iqJXotJS4TrgKvTXybGBsHH2GfT
         fMnrlZgXpc1m9qElXXKybzZwkQ4q2xgH/iRLv7Gdu3OBTaq4oH4DMZguPnnmrondwGen
         Y7ODjFFy4/S5H9AR8VOcDxJBajgeoOR2WDn2ccCzyk8bUkzO/LLNdeGk1YXuEaE+62Iv
         wLZKEU/KgbRRd1WCz7Ce48Ox5EqLPTnKCJ5jjJxb7XEBYUh93ZsSQKAMS0HSgTZa2Nuy
         KgGsN2WNcCR7PmbAazVl+9PTLsmlvIgZHg6nXGCxmPy83wL5BtX2u769b+mOEzMfSHmQ
         cpvA==
X-Gm-Message-State: APjAAAVb1KJ/+OZA+kGRa0XoS8x1bF+aXfIEJjmdudCAvEIGuZpppe/m
        OoB4Z8+uawDj4cjg1TgwOb04dZ6mSg==
X-Google-Smtp-Source: APXvYqwLkoKX9q8Q9bLTvhMkkE9wiNR5NEEJJcSCGxauU4HX/VybvPMs64Wnz9upYAG/rCm0PIs2Pw==
X-Received: by 2002:a6b:7109:: with SMTP id q9mr20336738iog.229.1569866706450;
        Mon, 30 Sep 2019 11:05:06 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id g68sm5153123ilh.88.2019.09.30.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:05:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Remove redundant mirror tracking in O_DIRECT
Date:   Mon, 30 Sep 2019 14:02:57 -0400
Message-Id: <20190930180257.23395-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930180257.23395-2-trond.myklebust@hammerspace.com>
References: <1569834678-16117-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190930180257.23395-1-trond.myklebust@hammerspace.com>
 <20190930180257.23395-2-trond.myklebust@hammerspace.com>
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
 fs/nfs/direct.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 98a9a0bcdf38..040a50fd9bf3 100644
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
@@ -127,8 +117,6 @@ nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
 			    const struct nfs_pgio_header *hdr,
 			    ssize_t dreq_len)
 {
-	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
-
 	if (!(test_bit(NFS_IOHDR_ERROR, &hdr->flags) ||
 	      test_bit(NFS_IOHDR_EOF, &hdr->flags)))
 		return;
@@ -142,15 +130,12 @@ nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
 		else /* Clear outstanding error if this is EOF */
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
 
@@ -162,8 +147,6 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 	if (dreq_len > dreq->max_count)
 		dreq_len = dreq->max_count;
 
-	if (mirror->count < dreq_len)
-		mirror->count = dreq_len;
 	if (dreq->count < dreq_len)
 		dreq->count = dreq_len;
 }
@@ -310,18 +293,6 @@ void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
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
@@ -336,7 +307,6 @@ static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 	INIT_LIST_HEAD(&dreq->mds_cinfo.list);
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;	/* not set yet */
 	INIT_WORK(&dreq->work, nfs_direct_write_schedule_work);
-	dreq->mirror_count = 1;
 	spin_lock_init(&dreq->lock);
 
 	return dreq;
@@ -655,7 +625,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(reqs);
 	struct nfs_commit_info cinfo;
 	LIST_HEAD(failed);
-	int i;
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
@@ -666,21 +635,12 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
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
@@ -698,7 +658,6 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	}
 	nfs_pageio_complete(&desc);
 
-out_failed:
 	while (!list_empty(&failed)) {
 		req = nfs_list_entry(failed.next);
 		nfs_list_remove_request(req);
@@ -931,7 +890,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 				break;
 			}
 
-			nfs_direct_setup_mirroring(dreq, &desc, req);
 			if (desc.pg_error < 0) {
 				nfs_free_request(req);
 				result = desc.pg_error;
-- 
2.21.0

