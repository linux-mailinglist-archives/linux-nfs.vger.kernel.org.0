Return-Path: <linux-nfs+bounces-11608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D5AB018C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215CA9E3AD9
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34878283FD9;
	Thu,  8 May 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckJTCpXq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D852213E8B
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725867; cv=none; b=Gd7rPoiZNPvSDqapVzB4nFMBmeG1iKSowVtvKxQ42SDujytbra4yCk6NVl5OjXBdvprtbHXY1b4A7R9CxeY7CdMrtqOM1VkRLRkKB1Cb3IK/KmH+uuvFBL5AIbngeuCNTPuwdMFZCN8UQzmuuSi03Q8NzRHY41QunaHvS0WjRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725867; c=relaxed/simple;
	bh=V0B1p1ru/Jq4fINn5HcByEh8Km75eJzl/IesLyVZy+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItEhovdMNSVh5vBIAzfbyCQot/VmhxGOOVBbCPK/njC1cYiNqKsBYUVeAS2H2jOgQTe83Vnslxfp6g6fUykrItOpjOp2KPX8QmU3gdyUxJ51Yy9y3mb+jXs5jrAZ9lBOeoBt61BnPUrKyiKXIFoRqFCMxsVFQLvx09V7wwYEbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckJTCpXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C87DC4CEE7;
	Thu,  8 May 2025 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725865;
	bh=V0B1p1ru/Jq4fINn5HcByEh8Km75eJzl/IesLyVZy+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckJTCpXq3f1j4jSFkvlEolOSz2AeUxPZ+DPiJRpM+2V/DT6EAwYZ8N4Z9574NdqQl
	 OWHt7z+6Qjj2A/BKmvaQovwai+nimT3P43NQdN/mSVGb56bCns/eNCfTcszchqZSzu
	 k0byPtomHn7heMCsYWd2qN9kLixVmzwBf4ZuyWo082S4iVRySIaPjBt5ps/IEP/kE8
	 hPWNk5t7lPL7vXvV+se/AIdmkOlRo8yNUt2rchraZ/vw9j1VoYCNMbSUF9hDbN64JT
	 Il00PfCsN7LultCXc00RNshms7ZBdWl3E1Yfx+nnyWtOqxhY/6MWnlsIzl893B3W5G
	 NdZlC4xQBk3aA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 4/6] NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
Date: Thu,  8 May 2025 13:37:38 -0400
Message-ID: <20250508173740.5475-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If we can get rid of all uses of rq_vec, then it can be removed.
Replace one use of rqstp::rq_vec with rqstp::rq_bvec.

The feeling of layering violation grows stronger now that we've
included <linux/sunrpc/xdr.h> in fs/nfsd/vfs.c.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c    |  5 +++--
 net/sunrpc/svc.c | 23 +++++++++++++----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e92036251ee7..15195fedc44e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -31,6 +31,7 @@
 #include <linux/exportfs.h>
 #include <linux/writeback.h>
 #include <linux/security.h>
+#include <linux/sunrpc/xdr.h>
 
 #include "xdr3.h"
 
@@ -1204,8 +1205,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	nvecs = svc_fill_write_vector(rqstp, payload);
-	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 930a10cac90b..d113f44798a1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1727,35 +1727,38 @@ EXPORT_SYMBOL_GPL(svc_encode_result_payload);
 
 /**
  * svc_fill_write_vector - Construct data argument for VFS write call
- * @rqstp: svc_rqst to operate on
+ * @rqstp: RPC execution context
  * @payload: xdr_buf containing only the write data payload
  *
- * Fills in rqstp::rq_vec, and returns the number of elements.
+ * Fills in @rqstp->rq_bvec, and returns the number of elements it
+ * populated in that array.
  */
 unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
 				   struct xdr_buf *payload)
 {
 	struct page **pages = payload->pages;
+	struct bio_vec *vec = rqstp->rq_bvec;
 	struct kvec *first = payload->head;
-	struct kvec *vec = rqstp->rq_vec;
 	size_t total = payload->len;
-	unsigned int i;
+	unsigned int base, len, i;
 
 	/* Some types of transport can present the write payload
 	 * entirely in rq_arg.pages. In this case, @first is empty.
 	 */
 	i = 0;
 	if (first->iov_len) {
-		vec[i].iov_base = first->iov_base;
-		vec[i].iov_len = min_t(size_t, total, first->iov_len);
-		total -= vec[i].iov_len;
+		len = min_t(size_t, total, first->iov_len);
+		bvec_set_virt(&vec[i], first->iov_base, len);
+		total -= len;
 		++i;
 	}
 
+	base = payload->page_base;
 	while (total) {
-		vec[i].iov_base = page_address(*pages);
-		vec[i].iov_len = min_t(size_t, total, PAGE_SIZE);
-		total -= vec[i].iov_len;
+		len = min_t(size_t, total, PAGE_SIZE);
+		bvec_set_page(&vec[i], *pages, len, base);
+		total -= len;
+		base = 0;
 		++i;
 		++pages;
 	}
-- 
2.49.0


