Return-Path: <linux-nfs+bounces-11182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB689A944D5
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3740176E56
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8861DF24F;
	Sat, 19 Apr 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFK/GjTA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3311DF991
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083705; cv=none; b=OaQpuC+CScnIdxzukaJAbO/iHQo2p97eQua+kbd04gG06j9TLVE/Fnm7fWf7yX/rB+ppJxm93a3lCMDi5WAIQUYmG1cHCDMSuvahviKbYTI4qbKNY12Box34dmn0PmOZrE+UmbSjAO2lP/M+Vtf2o6+uB2uzLTlklJSegqwV7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083705; c=relaxed/simple;
	bh=w2ShGO9ROIkEGlEzAtRx2bKgV2rgvqHhzRiDIS44PCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DR/QxYULEiz/GN9Jforh3Qfbq/1HY4yvPg4Ptpcx3hL32A1jkHG28UiLhQZUgvASTb0jNcVMdZGYVAn8ihOEo0lZR3Sg0UMH4qnehiwhvD/As0BNI9yX3zRNOBDiirDLyE9CITEMWFVXrjzWcg656vNT5BxTX9E4RRCTsF7jR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFK/GjTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D0DC4CEEE;
	Sat, 19 Apr 2025 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083705;
	bh=w2ShGO9ROIkEGlEzAtRx2bKgV2rgvqHhzRiDIS44PCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFK/GjTACDI8zZTYmaTg40oyo8Fqai6w4Hv7zbUBkm+pP106XYv7EfXg1hQoi7vjN
	 k+l0Ip9nkonJvW8tzSQlo5H0q6OjpiYpR3WhCyaVXyd4FctiSJwTWmdcrZoFbbAHey
	 c/7ekvkvwD1xaktUmhRM9/9kaJ495iIBNY+MCB81zYtKdNXytBkiWF5MZY+MirXwmQ
	 QUr67+FOZ+clK5DG+c5uFev6+XctHqlwr+oVGazftRkPxyk1q7YlzPtHdJb/21sXl1
	 0zwAKKpSi9ve2Y1puiqmFk3/QamweCScpr11nj6Iuz7SZu/dhGYObJVnrhTS0ABc/Z
	 BILxfd7hU8geA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 04/10] sunrpc: Replace the rq_vec array with dynamically-allocated memory
Date: Sat, 19 Apr 2025 13:28:12 -0400
Message-ID: <20250419172818.6945-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
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
the rq_vec[] array is 4144 bytes. Replacing it with a single
pointer reduces the size of struct svc_rqst to about 5400 bytes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         | 1 -
 fs/nfsd/vfs.c              | 2 +-
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 8 +++++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b397246dae7b..d1be58b557d1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1228,7 +1228,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 
 	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
-	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
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
index 96ac12dbb04d..72d016772711 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -207,7 +207,7 @@ struct svc_rqst {
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


