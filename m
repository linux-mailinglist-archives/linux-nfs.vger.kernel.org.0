Return-Path: <linux-nfs+bounces-11572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF14AAE266
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40877BF0A3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3828D8C9;
	Wed,  7 May 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTaoaOhu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43328936C
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626855; cv=none; b=kMgW0QLQ3ydpgk++/8VaPbBxqRp6UJG914FIXaEKqhLMyqCL8lH4JQkCvJ0OC8zZD3i0RNoEMymYzx/Lq2lPp4cgda7EiwDAfzxgoTZjjmjUopbrluVGaFOBFZ5VwfOQdy+8+iq1/ffoYJkXpctOn88uMzYjws1u5tOXSxoC0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626855; c=relaxed/simple;
	bh=3xV+wGVl4vkjxelYrs6ZfSfLfkF6nkDcd4wpAQabJXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvzabQSz37+ILwZFXTigOAP0PjxQLlUut+ODG5r7avDfAxLP3R/9034Q0NA6SWrRxyIyeEw8sB2186Ekkj2sxQOcNKIj25yZ24M3A14D6oQuNz4Wb49YCXuhovrCIZt8X+S3A2imjxWMarzWLmvj+WYX0eaqR6BLrZ5a591S1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTaoaOhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA66AC4CEE8;
	Wed,  7 May 2025 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626854;
	bh=3xV+wGVl4vkjxelYrs6ZfSfLfkF6nkDcd4wpAQabJXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTaoaOhuQDVUzf+u9G/pM+2wqKcvezYkzgmnL8ageOyhXr7qCZfeVtK5AQbbgymr0
	 riGHlP09MV+EcstD85pcoBCXaOcQarPPJXDC7T9wTr2wZfL94071ujDfN+miNaLiNy
	 vVhKwrb5R96h8qT8LtZUBNbHjHq6vO7G6sE9F6Tn0Bedb5455h1lTZ1A20WQ4YYQcJ
	 dvqJbRZRTXyCGZ2/pWiqCK3c8z9LftJN3HUxIKVZdfk1jlwxJwrvy4lCOJ8hGN9avb
	 kI+aeswuOd7itt4+9nSij7meN1PVpcjap7JmrXcvXcyB+gRVCwEaO3zFUwwOwkr0Y+
	 8h3FTr7+0oTcQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 3/4] NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
Date: Wed,  7 May 2025 10:07:27 -0400
Message-ID: <20250507140728.6497-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507140728.6497-1-cel@kernel.org>
References: <20250507140728.6497-1-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c    |  2 +-
 net/sunrpc/svc.c | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9673ab33ee5d..334bdf8a576d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1204,7 +1204,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7ad65e562470..77e9c180f48b 100644
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
 				   const struct xdr_buf *payload)
 {
 	const struct kvec *first = payload->head;
 	struct page **pages = payload->pages;
-	struct kvec *vec = rqstp->rq_vec;
+	struct bio_vec *vec = rqstp->rq_bvec;
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


