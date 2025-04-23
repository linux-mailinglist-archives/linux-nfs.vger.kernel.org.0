Return-Path: <linux-nfs+bounces-11240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49DA9925D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E844C3BE56E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D0288C8A;
	Wed, 23 Apr 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSDAyf2F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0122857DB
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421685; cv=none; b=TE5UCIIzYgJrJcQBP14JIjxYwwM9AVLnDw+gruxuP3VUbkOK+g4vmjGYeTq14VOBPitDtYE6SeNCkMzVwQ30TpPfbTpcWERRGHEsJvCYM7MfJX7XVnZ1Rf/GJ1c72X5Z32aadEfNcIrf8e480BtVUH7N23nZa0eheU66yXQixNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421685; c=relaxed/simple;
	bh=eBFIWPtNAbEVfQi/Z1z7Z5RVO3wNCLFa16Z/kD3mglM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCj1fNnkc0004JfILTjkGvqZ/JNmKc14nYDDTOVc+xILcIJSbomnIOrdGFaR/WYRIa5DZX6A54iG4k2UCLBniZ300XrCanPLheiYH/ceR+0mpC6EXPzO+zqZSMES9CZCzOV70pEN6apShvD4QslNLSoqZGKQ/saZ+QL0kUzVNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSDAyf2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EC7C4CEE8;
	Wed, 23 Apr 2025 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421685;
	bh=eBFIWPtNAbEVfQi/Z1z7Z5RVO3wNCLFa16Z/kD3mglM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSDAyf2FYlYBE767zk5gpRrV1By1qBxPqoDbgw4Itw/pbBqF21G5jiHLe2UK345NK
	 LVhYZKxkOBhuogJl+XHq2YI1emd1/2BA7s9oAnydJ8q0hdJ2GuaPy91dK+wZOObuxe
	 xlfj4Cq3DCMWRPAJBtvSREfO6Y55RofEuXfxQmI4QAqOSZh6l51wViJbEzln22cZ2A
	 +3nfyqam7bYGTKVSWQPcVPjSkGpJeIotokPa4Xun6ANIZ21NzS2zQUrCCGyCFtrjWx
	 1AhPAffVCl9JoIlqRI+P0c7HZ4Fx26uZVvWyu7A36qM3ItqCMYTtZU6JQ8vmb+ES3T
	 L7sE0xCeiRaaA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 05/11] sunrpc: Replace the rq_bvec array with dynamically-allocated memory
Date: Wed, 23 Apr 2025 11:21:11 -0400
Message-ID: <20250423152117.5418-6-cel@kernel.org>
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
index 60f2883268fa..d9fdc6ae8020 100644
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


