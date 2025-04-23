Return-Path: <linux-nfs+bounces-11239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5AA99251
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28AE9231F0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147B2BE105;
	Wed, 23 Apr 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBt/GNGh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA302857DB
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421684; cv=none; b=qn2ikHbua2NuLD+MDJnU0BisnOvJbZ8be0JNvuUTS/+J9HU0VcPmt2Duj3CPDwxM4uXQXfamgwx6z+62f5aiMsXhGS1ctAWZiJDM0WNwy+mSwQNooMFPHvn1ZPjn9HfrL23MCjU9BNjXceYN/ocyqEeqAhMW0Lm0TTWiLNrP60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421684; c=relaxed/simple;
	bh=iv//vtMwEHMbLjxBD+hAoNFYdmYZibgDGGFH4huj2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6MIpfONNM1bo4rM3hg9QXANOeQ+nHSOQ5ozYJBwPJPR45zZBrTtE8M8XixWYcTPttBpw7ixxt5n72hSN8Mt14vb7QTPErjTw2PAbsSnPUoRLYsM88QcGBccsumGXrNaQ5dcl4GGS+RNMhUzkr4qvId9/TCL2sjgOsuqm8s0pRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBt/GNGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82127C4CEE2;
	Wed, 23 Apr 2025 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421684;
	bh=iv//vtMwEHMbLjxBD+hAoNFYdmYZibgDGGFH4huj2mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBt/GNGhSckTgudxrrGsc1J88mrIav5Zj8B6fGaTqLNsK2XXEUHtfix9oAbpi+7zn
	 xLLI+dvx69dNp3e01uQtwQOhM7SBGPUPAv8Zq7NTxGhpthjmilcvu3XImjxZN6i9GH
	 o7oK8LGl/4t1vjyLEQH7UY5rrdYDQGeZoLNap9K/ofs/GHdp1J/9wmU3vP1qDvuBfw
	 jXg7QfyMO61GZirw6ggdu22v9WsYt9rEL3EsnCb5F0XKtyqWsdWRGfT7xmnfM4pdVw
	 6duuSGI36Wq22DpfCqDylcpi1W7ptsG709RNVj2BwsxFenTDRaH/hdjoIMi2/OF1fk
	 FfMLx9bfSZs/g==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 04/11] sunrpc: Replace the rq_vec array with dynamically-allocated memory
Date: Wed, 23 Apr 2025 11:21:10 -0400
Message-ID: <20250423152117.5418-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

As a step towards making NFSD's maximum rsize and wsize variable at
run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
with a chunk of dynamically-allocated memory.

The rq_vec array is sized assuming request processing will need at
most one kvec per page in a maximum-sized RPC message.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_vec[] array is 4144 bytes. This patch replaces that array
with a single 8-byte pointer field.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c              | 2 +-
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 68f7d0094b06..ea0773bb7c05 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1096,7 +1096,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		++v;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
+	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ea3a33eec29b..f663d58abd7a 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -212,7 +212,7 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
+	struct kvec		*rq_vec;
 	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 682e11c9be36..5808d4b97547 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -675,6 +675,7 @@ static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
+	kfree(rqstp->rq_vec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
@@ -713,6 +714,11 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv, node))
 		goto out_enomem;
 
+	rqstp->rq_vec = kcalloc_node(rqstp->rq_maxpages, sizeof(struct kvec),
+				      GFP_KERNEL, node);
+	if (!rqstp->rq_vec)
+		goto out_enomem;
+
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
 	serv->sv_nrthreads += 1;
@@ -1750,7 +1756,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
 		++pages;
 	}
 
-	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));
+	WARN_ON_ONCE(i > rqstp->rq_maxpages);
 	return i;
 }
 EXPORT_SYMBOL_GPL(svc_fill_write_vector);
-- 
2.49.0


