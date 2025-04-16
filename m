Return-Path: <linux-nfs+bounces-11148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD52A907BE
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558301907B76
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148D20D4E0;
	Wed, 16 Apr 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGJgFp3l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5072080DB
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817339; cv=none; b=T1y4r3EOZ/V1tREQzeHJG0Ca1h0YwBJZH8LEGb09LjtA7EmE7GQgM+TJSEZT26WBHs7GvgvYavN/l9/Wcdt1udsuOcu835WfqcudR8ABDy/GfAD9YuqXiolfTxaN0BgAJHg6saAWU9A9AbCC0LhEpKQWMciMkVlp4sDKwIYmr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817339; c=relaxed/simple;
	bh=cCJQXTL4g18PQ9Q7cI4mJ71WzF5rruMcQyqcExY9Y50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+fxOFXno2Po0KG5vpU7Z/UyE258Z0YJ28DqoFVQgNkz6UgtCT9p60DZ8w+cManbAu5DUkJUSglc/s/KL5Pk2dYQOXdaWALxf8GPsE/etqbzMtS19c4Vs/zwUBnT0FQ8vfoBX9B/FBCfmaWz+OOk+7fuvjXS6Gx4ZkeSUaIACgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGJgFp3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E353C4CEF1;
	Wed, 16 Apr 2025 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744817339;
	bh=cCJQXTL4g18PQ9Q7cI4mJ71WzF5rruMcQyqcExY9Y50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGJgFp3lMEeOO+fYonnh0qxVh7gWhq3uZJGzfiZIkWLxfmLPwbhh0k5wWL8f+306y
	 bLDl5W5/MvXmfLYJ9Oi35TjL5NX2PggjMwhptJNxUDIXeJ3XVwtD4dBW+osuSXzlfV
	 2KYPUIt2XZg/Fyl6EatRjnGYHLTwar9WiWapK8ctogToPw4ur+wuouAG1yO5dX69Wg
	 DiokDQzin2MHm5eGAp7FS6CUE7A5JUreqMhVW25NNQLhJVOasWNfH3iKUas1CYQNiH
	 oqMpBfiqfbFbrkupC7iodl9qR5w8BKqL9GeLgcnpeAE+/eKo4faCBNc4CdpNg/TZcK
	 /3NuG8o4/+8lQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] sunrpc: Replace the rq_vec array with dynamically-allocated memory
Date: Wed, 16 Apr 2025 11:28:54 -0400
Message-ID: <20250416152854.15269-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416152854.15269-1-cel@kernel.org>
References: <20250416152854.15269-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

As a step towards making NFSD's maximum rsize and wsize variable,
replace the fixed-size rq_vec[] array in struct svc_rqst with a
chunk of dynamically-allocated memory.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_vec[] array is 4144 bytes. Replacing it with a single
pointer reduces the size of struct svc_rqst to about 3300 bytes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         | 2 +-
 fs/nfsd/vfs.c              | 2 +-
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 8 +++++++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b397246dae7b..79ee58202396 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1228,7 +1228,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 
 	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
-	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
+	/* WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec)); */
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9abdc4b75813..ae0901d6db1a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1094,7 +1094,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		++v;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
+	WARN_ON_ONCE(v > RPCSVC_MAXPAGES);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 225c385085c3..13b6d0753bc0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -194,7 +194,7 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
+	struct kvec		*rq_vec;
 	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index db29819716b8..8d28aeb74e1b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -674,6 +674,7 @@ svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
 	kfree(rqstp->rq_bvec);
+	kfree(rqstp->rq_vec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
@@ -712,6 +713,11 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
 		goto out_enomem;
 
+	rqstp->rq_vec = kcalloc_node(RPCSVC_MAXPAGES, sizeof(struct kvec),
+				      GFP_KERNEL, node);
+	if (!rqstp->rq_vec)
+		goto out_enomem;
+
 	rqstp->rq_bvec = kcalloc_node(RPCSVC_MAXPAGES, sizeof(struct bio_vec),
 				      GFP_KERNEL, node);
 	if (!rqstp->rq_bvec)
@@ -1754,7 +1760,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
 		++pages;
 	}
 
-	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));
+	WARN_ON_ONCE(i > RPCSVC_MAXPAGES);
 	return i;
 }
 EXPORT_SYMBOL_GPL(svc_fill_write_vector);
-- 
2.49.0


