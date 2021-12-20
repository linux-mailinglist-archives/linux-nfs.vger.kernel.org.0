Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96AC47B0F4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 17:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhLTQMa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 11:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTQM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 11:12:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC8C061574
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 08:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 404B3B80F6F
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE266C36AE7;
        Mon, 20 Dec 2021 16:12:26 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org
Subject: [PATCH v2] NFSD: Fix READDIR buffer overflow
Date:   Mon, 20 Dec 2021 11:12:25 -0500
Message-Id:  <164001673838.4178.920683483571162515.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; h=from:subject:message-id; bh=9veGKbOWpnLJUVTFXHPWtucPazKSc5oLZMi0iCyiMrA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhwKtiXXiwNkvdXC5oTCJyS7urCmtsl85feV3pScf9 pZoEbcWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcCrYgAKCRAzarMzb2Z/lyRBEA CBZFdiiQiGrywCfiG+d+9J1vC5vqlgPxoArD9N2UrPnLQB87KxCJAgXN6tymDzXwVd9utwLHpS8c2t l9PaP0h7VMDehF+Ew2wX0CT5BuGKzNVim/WtDOWC1/a27bISI2d3H7XonGebCChJLwbUDqEHz/O6AQ RINX38zbm2aS5GERNN2n2YaMWhEBLC8+Z2q9If40330oS3LcL1Rp2waviTK4LmlFZsYebH+fmnrOX0 wzmpvyE/bAAq7VDqvIRSD0uuUe7nSuhvHcbG6xf53CWCg8HrO6cBH325eq9UVg7B9s4JdLjdb6flz3 MhUrvwPRN8r29grAdScrNnIZCvwOvGmhsg2OET+7vUuK8iNwmDaBKvyzq9ESNUyO6yHnQgV9MUptmD t3pEsvpZELFoxjneYXt2mzN+vjowTTozjjck+iNoz7tOIxGFN3eGVWLwTTwMI0gCHirwSX98B3mHTe GySanBATpg2fW7xtXJRwwBSMrqYZmIZMt90puve/yR2Yhlq6RdHohl55BaEzGYC/2R7XCEcx8RV2vq e/TeKDub+Fbk0lb/13D5is/QtobKTw5lLE2t7FNyPQnCkXoCVA95D5QBU54VWc1JqM9r0/PxOrjwn9 04kTZlIxHLzVphhsSI1mt9DYK1HzzlZs5asdQxjDRy0WAtfwgY2cG2qfUGkg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a client sends a READDIR count argument that is too small (say,
zero), then the buffer size calculation in the new init_dirlist
helper functions results in an underflow, allowing the XDR stream
functions to write beyond the actual buffer.

This calculation has always been suspect. NFSD has never sanity-
checked the READDIR count argument, but the old entry encoders
managed the problem correctly.

With the commits below, entry encoding changed, exposing the
underflow to the pointer arithmetic in xdr_reserve_space().

Modern NFS clients attempt to retrieve as much data as possible
for each READDIR request. Also, we have no unit tests that
exercise the behavior of READDIR at the lower bound of @count
values. Thus this case was missed during testing.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream")
Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   11 ++++-------
 fs/nfsd/nfsproc.c  |    8 ++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 4418517f6f12..15dac36ca852 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -438,22 +438,19 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 
 static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 				     struct nfsd3_readdirres *resp,
-				     int count)
+				     u32 count)
 {
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = min_t(u32, count, svc_max_payload(rqstp));
+	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
 
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
 	buf->buflen = count - XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
-	while (count > 0) {
-		rqstp->rq_next_page++;
-		count -= PAGE_SIZE;
-	}
+	rqstp->rq_next_page += (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* This is xdr_init_encode(), but it assumes that
 	 * the head kvec has already been consumed. */
@@ -462,7 +459,7 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 	xdr->page_ptr = buf->pages;
 	xdr->iov = NULL;
 	xdr->p = page_address(*buf->pages);
-	xdr->end = xdr->p + (PAGE_SIZE >> 2);
+	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
 	xdr->rqst = NULL;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index eea5b59b6a6c..de282f3273c5 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -556,17 +556,17 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 
 static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 				    struct nfsd_readdirres *resp,
-				    int count)
+				    u32 count)
 {
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = min_t(u32, count, PAGE_SIZE);
+	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
 
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
-	buf->buflen = count - sizeof(__be32) * 2;
+	buf->buflen = count - XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 
@@ -577,7 +577,7 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 	xdr->page_ptr = buf->pages;
 	xdr->iov = NULL;
 	xdr->p = page_address(*buf->pages);
-	xdr->end = xdr->p + (PAGE_SIZE >> 2);
+	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
 	xdr->rqst = NULL;
 }
 

