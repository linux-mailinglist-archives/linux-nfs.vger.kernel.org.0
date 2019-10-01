Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EFC41BA
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfJAUWL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 16:22:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32779 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJAUWL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 16:22:11 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so51568669ior.0
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpNiScNWRwRmw3Wln9TEgC0GAqJOt5oeeIpmKTQpPKI=;
        b=rSInxYbC20x36Ty1G/Mf6SfR8jFh0hOISM5tlZ6TuVp6lmwQUpP9PsHnusLxL+c36t
         xo2uZO15YviA9ZPRAZ64YnGJ01tMmzfMEy9KioSaQFZQ6DaYBYzaTeahtSFG9nwIjigK
         wXCmHt+j0DjWlX4IH1VS/BKABLEjYVxsA6Ms8U8d84HQDYmpr+lY7iF6e8FjGTlWwAMI
         v49hoPCdysZ6e5MSYUpBLytKbwrqAczPtT2wA5FvvCDFX15IOWXrEB9OltMEAfW6bAOe
         hz4RYj47SetrG14fIXU9JolNjhWlegnmAyvx0hIKxQw4ceObJn7BSVVdff56wqJuIsRG
         LWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpNiScNWRwRmw3Wln9TEgC0GAqJOt5oeeIpmKTQpPKI=;
        b=GE95d23Lc1f0+H88MweZp4uCRnOmhOtffRXMl2rxJBKYcCPHA3V3yQSz+59OpT7J6W
         NgGF2AL9aOZk0Hh6f2yd9I58q/GKO08cuMcn4sYXUED3tK+Hx2NUmqkrBzrBsUaHXpTw
         NZ7SeH77cw2EQmILb+YoPa8xvsi89mJ0ox1RA905GcEmxZxYYN/8eIWBXGShuf9Yyv9R
         sQ7RsKWtgKe01p0FGp6bJQPG5ZKzCeFWAzFLA/gEBCcNE7330GadsNP+YROYy1h5V6eM
         FC/Kw1GIk6JYriDOj+Ya9jns71vHbCIvlP/lv3EGsBoKGbecm8CRR5MiWYBT8s67Mj0X
         551g==
X-Gm-Message-State: APjAAAU2gizEknZfx+jKF67kTwQ/Gv7gs575uMDaJtGYt1jCGLAWVlf0
        NKmTJCT2a2ulhXfl4aqQ6w==
X-Google-Smtp-Source: APXvYqwxy7CHU2FHeg3DQBF2lUSGeF2QjNLiJF3Alb9gq3BCpbQKbkvqO8eHTcLK8vdEftYW036TFg==
X-Received: by 2002:a6b:c382:: with SMTP id t124mr9505iof.105.1569961329801;
        Tue, 01 Oct 2019 13:22:09 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c65sm8038648ilg.26.2019.10.01.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:22:08 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFS: Fix O_DIRECT accounting of number of bytes read/written
Date:   Tue,  1 Oct 2019 16:19:59 -0400
Message-Id: <20191001202000.13248-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001202000.13248-1-trond.myklebust@hammerspace.com>
References: <20191001202000.13248-1-trond.myklebust@hammerspace.com>
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
 fs/nfs/direct.c | 82 ++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 222d7115db71..62cb4a1a87f0 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -123,32 +123,53 @@ static inline int put_dreq(struct nfs_direct_req *dreq)
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
+	loff_t hdr_arg = hdr->io_start + hdr->args.count;
+	ssize_t expected = 0;
+
+	if (hdr_arg > dreq->io_start)
+		expected = hdr_arg - dreq->io_start;
+
+	if (dreq_len == expected)
+		return;
+	if (dreq->max_count > dreq_len) {
+		dreq->max_count = dreq_len;
+		if (dreq->count > dreq_len)
+			dreq->count = dreq_len;
+
+		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
+			dreq->error = hdr->error;
+		else if (hdr->good_bytes > 0)
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
@@ -402,20 +423,12 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
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
@@ -652,6 +665,9 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
 	dreq->count = 0;
+	dreq->max_count = 0;
+	list_for_each_entry(req, &reqs, wb_list)
+		dreq->max_count += req->wb_bytes;
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	for (i = 0; i < dreq->mirror_count; i++)
@@ -791,17 +807,13 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
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

