Return-Path: <linux-nfs+bounces-11321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F07A9F9AC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98A3464379
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D48297A78;
	Mon, 28 Apr 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfXfLQ0r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E72973BA;
	Mon, 28 Apr 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869032; cv=none; b=atDP4V4BvP+28ejEAymPU2Ga4s3ED5OHtDYQN1YQ6o8zv+t/UcTbloOmqY8vzoKr/PjODVjoMID9lzVADrVYuyAapei0YcVYXtPMbJ8207Dos/qgPNSADL2lJEWTedf4iTeir9ViupwBXdoSfWel2DJq2yzP09DPe9G/wbbx1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869032; c=relaxed/simple;
	bh=a95FVTfPPeJIlMNVDUJ6pHTHn0PoTrK7dSrY0fVkoww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3gr0lkYf150b9EzF3XU7PNnYTdnh2A3+BNVYSfkSBY04XCHIn219y2dfrvAzKZn7umMllwBa4xx7zlKB55BgA3gh0E68Zq8FnJq9cox9ffRBXWlnlNSA4bumUzcC8HZK5w+qiOKzOFT9Kt59f9rALSXyeE8xzvBE0wu9htQ7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfXfLQ0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8DFC4CEED;
	Mon, 28 Apr 2025 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869032;
	bh=a95FVTfPPeJIlMNVDUJ6pHTHn0PoTrK7dSrY0fVkoww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfXfLQ0ruLxbrvmbPMpJyyk5Kvku46Td6FL0+vNL/TdWOs508QelgSf12Uo+xXfGW
	 sgwzxFJMcQ4a/mPgEIfAstiXOhvl+FM4B0u2pRbDqTcmEL4IbE9oTGG/ibxX7dJYfo
	 geH/BGeg1VyQUr8WW51yC5CsmY1YDvQL9PraJDfhXrora0fDUbaluF/I2Vl/MCpmGa
	 OeTJBgkk1lnF1e3TPXjP0E8IKOWGOHXnR4i7ULWciv31deR9Lf42Rk3nC4//c4Y/Dm
	 jBs+yPMWuzw8mHhZ0c+BGId4cMMEE/c6N/DI8V5repvrtFJ4MrFgtxTuazWaGH2wNg
	 KDLgolLpgXPJA==
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
Subject: [PATCH v4 06/14] sunrpc: Replace the rq_bvec array with dynamically-allocated memory
Date: Mon, 28 Apr 2025 15:36:54 -0400
Message-ID: <20250428193702.5186-7-cel@kernel.org>
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
run-time, replace the fixed-size rq_bvec[] array in struct svc_rqst
with a chunk of dynamically-allocated memory.

The rq_bvec[] array contains enough bio_vecs to handle each page in
a maximum size RPC message.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_bvec[] array is 4144 bytes. This patch replaces that array
with a single 8-byte pointer field.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 7 +++++++
 net/sunrpc/svcsock.c       | 7 +++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f663d58abd7a..4e6074bb0573 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -213,7 +213,7 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		*rq_vec;
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
+	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 5808d4b97547..0741e506c35c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -675,6 +675,7 @@ static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
+	kfree(rqstp->rq_bvec);
 	kfree(rqstp->rq_vec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
@@ -719,6 +720,12 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp->rq_vec)
 		goto out_enomem;
 
+	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages,
+				      sizeof(struct bio_vec),
+				      GFP_KERNEL, node);
+	if (!rqstp->rq_bvec)
+		goto out_enomem;
+
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
 	serv->sv_nrthreads += 1;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 72e5a01df3d3..c846341bb08c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -713,8 +713,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec,
-				ARRAY_SIZE(rqstp->rq_bvec), xdr);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      count, rqstp->rq_res.len);
@@ -1219,8 +1218,8 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
-				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
+				&rqstp->rq_res);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
-- 
2.49.0


