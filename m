Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2EC27A0
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfI3VBY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 17:01:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41309 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3VBY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Sep 2019 17:01:24 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so13583802ioj.8
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2019 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+TDvatBt840NWh+phf+SeLlgmVzpeSaJYKmHp09Nb4=;
        b=p5wJnnFaLg9+gZGiB0JMwF6DZAd5lHLxQz2WvXXpoXHgPk/IfKhgRU8dVIpX6lUDAm
         8MPNo3VkcO34c77p6fHzknoP36q3RKo9OProYNEKWDHckRo58LFm6onwJzSCs08VxAc+
         Nohc7s5O8fePkrWYZJS/WYu1PylRk0KFGVhkrg6c9+z5fvn1rQBwIKrZkzj8ORzxafKE
         nnKF9qOMFIMURHFHtyAVtjUJM6ny8/kLK0R7aWiiEf73oIGTngbVsbEUo6JZhPjsSQpu
         FhrKcmaX94pfzqCQYGCUWIP7XXAIgyXpUH0WlmiWJCnU0oASaiypsjvcnE4BcEdFp8hR
         BISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+TDvatBt840NWh+phf+SeLlgmVzpeSaJYKmHp09Nb4=;
        b=MFlZGvOs/Yu9N9l8UMuaSZuzyf/xRXPt9k+tXGCITBuNIBxdQoKbecwOTIcK7MIJz0
         tFGm2Ko19XrYbjQoDlVrHqe6JnUVVdJ1iyDYSsYZduQ4J8Dn6HCXHFQDSyW7OuRBWmmW
         nUC/Y7kpMMNnmOHbOEJSOmrWpXTLy69oGHr2Gku5GH0u/piJLnLQ3TW9xBScKw9s2WYx
         9yToKtmOHEkU/AXK/yA7+u0Vm9BUutYyzgn7hC59dm94wXVtvtdJauGmnc6uYWF9J/4A
         qx0rwlVrFrbYNIg2xfzpjOUz6vA9n0ueq6cs9CPuO0YsN9exoNQh/YWxSx04XJKwyTSZ
         warA==
X-Gm-Message-State: APjAAAUbeC2LexfjuNnvTUb/UtztdrBNO0aNsvnSXIWRGSVOyKwGyb/F
        pW5VXcvCbpE40bi2J0SzlVgu4DusAg==
X-Google-Smtp-Source: APXvYqyvvMFYvUL2mKBIS0Zb5EWsVAUvcduxRUGKHEgypSWCS7wkm8VYvoMfAixm7Jp22+8tgw524A==
X-Received: by 2002:a6b:5002:: with SMTP id e2mr998310iob.15.1569866705715;
        Mon, 30 Sep 2019 11:05:05 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id g68sm5153123ilh.88.2019.09.30.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:05:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Fix O_DIRECT accounting of number of bytes read/written
Date:   Mon, 30 Sep 2019 14:02:56 -0400
Message-Id: <20190930180257.23395-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930180257.23395-1-trond.myklebust@hammerspace.com>
References: <1569834678-16117-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190930180257.23395-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a series of O_DIRECT reads or writes are truncated, either due to
eof or due to an error, then we should return the number of contiguous
bytes that were received/sent starting at the offset specified by the
application.

Currently, we are failing to correctly check contiguity, and so we're
failing the generic/465 in xfstests when the race between the read
and write RPCs causes the file to get extended while the 2 reads are
outstanding. If the first read RPC call wins the race and returns with
eof set, we should treat the second read RPC as being truncated.

Reported-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Fixes: 1ccbad9f9f9bd ("nfs: fix DIO good bytes calculation")
Cc: stable@vger.kernel.org # 4.1+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 78 +++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 222d7115db71..98a9a0bcdf38 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -123,32 +123,49 @@ static inline int put_dreq(struct nfs_direct_req *dreq)
 }
 
 static void
-nfs_direct_good_bytes(struct nfs_direct_req *dreq, struct nfs_pgio_header *hdr)
+nfs_direct_handle_truncated(struct nfs_direct_req *dreq,
+			    const struct nfs_pgio_header *hdr,
+			    ssize_t dreq_len)
 {
-	int i;
-	ssize_t count;
+	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
+
+	if (!(test_bit(NFS_IOHDR_ERROR, &hdr->flags) ||
+	      test_bit(NFS_IOHDR_EOF, &hdr->flags)))
+		return;
+	if (dreq->max_count >= dreq_len) {
+		dreq->max_count = dreq_len;
+		if (dreq->count > dreq_len)
+			dreq->count = dreq_len;
+
+		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
+			dreq->error = hdr->error;
+		else /* Clear outstanding error if this is EOF */
+			dreq->error = 0;
+	}
+	if (mirror->count > dreq_len)
+		mirror->count = dreq_len;
+}
 
-	WARN_ON_ONCE(dreq->count >= dreq->max_count);
+static void
+nfs_direct_count_bytes(struct nfs_direct_req *dreq,
+		       const struct nfs_pgio_header *hdr)
+{
+	struct nfs_direct_mirror *mirror = &dreq->mirrors[hdr->pgio_mirror_idx];
+	loff_t hdr_end = hdr->io_start + hdr->good_bytes;
+	ssize_t dreq_len = 0;
 
-	if (dreq->mirror_count == 1) {
-		dreq->mirrors[hdr->pgio_mirror_idx].count += hdr->good_bytes;
-		dreq->count += hdr->good_bytes;
-	} else {
-		/* mirrored writes */
-		count = dreq->mirrors[hdr->pgio_mirror_idx].count;
-		if (count + dreq->io_start < hdr->io_start + hdr->good_bytes) {
-			count = hdr->io_start + hdr->good_bytes - dreq->io_start;
-			dreq->mirrors[hdr->pgio_mirror_idx].count = count;
-		}
-		/* update the dreq->count by finding the minimum agreed count from all
-		 * mirrors */
-		count = dreq->mirrors[0].count;
+	if (hdr_end > dreq->io_start)
+		dreq_len = hdr_end - dreq->io_start;
 
-		for (i = 1; i < dreq->mirror_count; i++)
-			count = min(count, dreq->mirrors[i].count);
+	nfs_direct_handle_truncated(dreq, hdr, dreq_len);
 
-		dreq->count = count;
-	}
+	if (dreq_len > dreq->max_count)
+		dreq_len = dreq->max_count;
+
+	if (mirror->count < dreq_len)
+		mirror->count = dreq_len;
+	if (dreq->count < dreq_len)
+		dreq->count = dreq_len;
 }
 
 /*
@@ -402,20 +419,12 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 	struct nfs_direct_req *dreq = hdr->dreq;
 
 	spin_lock(&dreq->lock);
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
-		dreq->error = hdr->error;
-
 	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		spin_unlock(&dreq->lock);
 		goto out_put;
 	}
 
-	if (hdr->good_bytes != 0)
-		nfs_direct_good_bytes(dreq, hdr);
-
-	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
-		dreq->error = 0;
-
+	nfs_direct_count_bytes(dreq, hdr);
 	spin_unlock(&dreq->lock);
 
 	while (!list_empty(&hdr->pages)) {
@@ -652,6 +661,9 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
 	dreq->count = 0;
+	dreq->max_count = 0;
+	list_for_each_entry(req, &reqs, wb_list)
+		dreq->max_count += req->wb_bytes;
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	for (i = 0; i < dreq->mirror_count; i++)
@@ -791,17 +803,13 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 
 	spin_lock(&dreq->lock);
-
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
-		dreq->error = hdr->error;
-
 	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		spin_unlock(&dreq->lock);
 		goto out_put;
 	}
 
+	nfs_direct_count_bytes(dreq, hdr);
 	if (hdr->good_bytes != 0) {
-		nfs_direct_good_bytes(dreq, hdr);
 		if (nfs_write_need_commit(hdr)) {
 			if (dreq->flags == NFS_ODIRECT_RESCHED_WRITES)
 				request_commit = true;
-- 
2.21.0

