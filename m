Return-Path: <linux-nfs+bounces-4466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42191D76F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66381B24076
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D72BB0D;
	Mon,  1 Jul 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHXK56pC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B4381CC
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811648; cv=none; b=KQEpRCq3QLIQVzr75U+F3pvci3N+BsorlNFpX9dr4HgirZAuTfjGWGT0sbQYaUUV1wvydvqhYASKIBx1CgFuTlhRQSNcS44fVxWawi63xWTgFPvMCEuEPwkUfFOsUPOiRJyBHQVfQOvkq2xQB9t0ldsyOGefcdfJl7C/7FW3P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811648; c=relaxed/simple;
	bh=ROe+xNNPrognDJz4pUK0bRiVHT0cxZy/EaxiVEQ/ShI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikp05LFHCchgDFukxRi2/s4/osLcav6Zf7ltdFQ7ey2NVtWWHfjG9sGdFULqwClJtIIK38+guo6mwug4HwuCYSUnQFDs2pmMd7CEmKSaHOt6R5sfxtpFDzJmb9jx/Gt5EE7AmR5L0NgKoxOoCyefsRu3H5pZqBPOvoAmnqRXEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FHXK56pC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=00YbQ6d+qYP8tghGU+BS9kAJ+4lvDj0NKL8b2b0fdMM=; b=FHXK56pCG//MtiUPWbsDJLAhJd
	cCNy0wc7pCNc0QyC2AlamDfIaSr939epMcjruYUWeoPTDbMN7PEuJwe63Px8hHC5u985ildZwg2Z0
	6NO1dHVKnCVoupPQXazf/yA/IdA4EPaXg/D0Pd1f7aHJTRH6+BldYhPLLsTU7eux7eJzWrGrhOxmR
	P6ED5tvgUn4XMD2PuTtrRJieE43TCQlcXKywuXDWu1CuWRdEc+wX33wcHnQCDRHQer3TZb/M2tLZe
	AIZvqHLUwnTWLbCHWi0C3m3okJZ5XJd/MCI1yI8LzuoL9OW2RJDAktxqccYp6oHlyRRXSi0PVJndU
	HU9V8yFw==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZW-00000001kDb-3R5Z;
	Mon, 01 Jul 2024 05:27:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] nfs: move nfs_wait_on_request to write.c
Date: Mon,  1 Jul 2024 07:26:53 +0200
Message-ID: <20240701052707.1246254-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701052707.1246254-1-hch@lst.de>
References: <20240701052707.1246254-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_wait_on_request is now only used in write.c.  Move it there
and mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/pagelist.c        | 19 -------------------
 fs/nfs/write.c           | 17 +++++++++++++++++
 include/linux/nfs_page.h |  1 -
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index fa7971072900b3..04124f22666530 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -598,25 +598,6 @@ void nfs_release_request(struct nfs_page *req)
 }
 EXPORT_SYMBOL_GPL(nfs_release_request);
 
-/**
- * nfs_wait_on_request - Wait for a request to complete.
- * @req: request to wait upon.
- *
- * Interruptible by fatal signals only.
- * The user is responsible for holding a count on the request.
- */
-int
-nfs_wait_on_request(struct nfs_page *req)
-{
-	if (!test_bit(PG_BUSY, &req->wb_flags))
-		return 0;
-	set_bit(PG_CONTENDED2, &req->wb_flags);
-	smp_mb__after_atomic();
-	return wait_on_bit_io(&req->wb_flags, PG_BUSY,
-			      TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL_GPL(nfs_wait_on_request);
-
 /*
  * nfs_generic_pg_test - determine if requests can be coalesced
  * @desc: pointer to descriptor
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3ba298ebb0be14..2c089444303982 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -476,6 +476,23 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
 }
 
+/**
+ * nfs_wait_on_request - Wait for a request to complete.
+ * @req: request to wait upon.
+ *
+ * Interruptible by fatal signals only.
+ * The user is responsible for holding a count on the request.
+ */
+static int nfs_wait_on_request(struct nfs_page *req)
+{
+	if (!test_bit(PG_BUSY, &req->wb_flags))
+		return 0;
+	set_bit(PG_CONTENDED2, &req->wb_flags);
+	smp_mb__after_atomic();
+	return wait_on_bit_io(&req->wb_flags, PG_BUSY,
+			      TASK_UNINTERRUPTIBLE);
+}
+
 /*
  * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
  * @head: head request of page group, must be holding head lock
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 63eed97a18ade9..169b4ae30ff479 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -152,7 +152,6 @@ extern	void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *, pgoff_t);
 extern size_t nfs_generic_pg_test(struct nfs_pageio_descriptor *desc,
 				struct nfs_page *prev,
 				struct nfs_page *req);
-extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern void nfs_join_page_group(struct nfs_page *head,
-- 
2.43.0


