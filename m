Return-Path: <linux-nfs+bounces-11320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C04A9F9A9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D7E464463
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B8297A48;
	Mon, 28 Apr 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Vp23it"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C36297A42;
	Mon, 28 Apr 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869031; cv=none; b=edZht4LnKQdVqKT/cYJkrQ+bWP7620ReJXV61GJBmlqnXmHuCkg5U1UkXScN8uYoCf+EhTlskNTbLpHhSNVa9sZvaVpZ/nVVQc824zylYmThqltcfA4cfWOpZD5yW3fyDKxsFmCnFKpuuv0JGHCFtZeXOJZBAaD13HMGQJGt35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869031; c=relaxed/simple;
	bh=0OKJoGCLQKnLhkdbONx7kkzAFfQ2qG1W1EiktOh8+es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H74JoK/2AakEtDLScKKNlpPBAjTP3IBYFQ+S5pfE0RG5pZPaOJfC1nov8vRjUIfjRmvwB69nS24t8VfLlvTuS8sFeu3ir0XWyxaLMz5BhUp67Jo4BmjxjdoCBW+M2YYjeS6pMQhvgLzoKjeSB0l2TMkx9occRFeNyYblNqI/nkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Vp23it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EABC4CEE4;
	Mon, 28 Apr 2025 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869031;
	bh=0OKJoGCLQKnLhkdbONx7kkzAFfQ2qG1W1EiktOh8+es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+Vp23itjVzsuc+GUkjs+o8B9t4MEdLrOtNP4WEXt3KV6XMTd+2/Nf1Rsf/63SpBk
	 4S56eWF8VP+gO3+bwRyGJJ4K5Ea6PJ1sDvYfbJzJ9M7EvF7B5srkW1Ney3qt4dUIsh
	 z8/3NDIRnP74oN/fq/sxfRcSCW9zjUMGExMcSEqaLjgNKDjHWIGwLOY6QsM2hnDKCf
	 qbOjOB4Ajnwz04Wb2BuWnKDCqyBE83IvI3u8cGwJHzAeF6qVrnNy91A0dcbO+mlmvW
	 Mz/JGpYtdzXFSzu1OSE78PUrjQbE1aTYunb8ljU2+E/c8AHlVGj73v3TjvOT7/atLU
	 gSTzgwSFdvIww==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 05/14] sunrpc: Replace the rq_vec array with dynamically-allocated memory
Date: Mon, 28 Apr 2025 15:36:53 -0400
Message-ID: <20250428193702.5186-6-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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
index 9abdc4b75813..4eaac3aa7e15 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1094,7 +1094,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


