Return-Path: <linux-nfs+bounces-11146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D4A907BD
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C90D1907A1C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D70210180;
	Wed, 16 Apr 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q36HLyII"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E220FA8F
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817338; cv=none; b=O/TMkQews2tuI/a/mN7We05Ckg1KWu6ktKru7NX51vlIB0fGm33n2Zn+Pra2bP7O2AFxwLsaiiSxsVy1abaXvefNKj50Wb0O1ut6i1s9mOjRQMCVenMTl8SYnn6uni9ixd2wXjK4q2pdbuom4ftvVzLTzKbim34cCgHBr77FnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817338; c=relaxed/simple;
	bh=qPFP7oGu0c544aP1y/hr1yJ5l/51lj0mVvbLatfmbOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbpu6MZhxltQmgjER7Sk/gSfQJNWj5NDaE3N5hQopC3qTx5yysV/qdAPlOnT+avEyA3QkVxCznOeEDa8R+fBRtHPQGt2+klIZxw3q2zdj9PhywqYnny1PnXqMHaCIZULwU+fQax/Jtz0zjdspwNG3pY4vZzFwjiSRBxggzPuswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q36HLyII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613ADC4CEE2;
	Wed, 16 Apr 2025 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744817338;
	bh=qPFP7oGu0c544aP1y/hr1yJ5l/51lj0mVvbLatfmbOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q36HLyIIQPgzPVfh+dUMSiQhBWJcp/C77Jc0uqsSEgQcY27qcWaEOLfYLoY70xZF5
	 xu2s6h7v0PTUMmJnZI/IToGUm43ALX8MK0TbGGwyz0xHGUKmi67ojzptGSgclMS2m9
	 kEAa24LAno9MCK9az61Zsi6VhZjZLqvrzt4woU5KV9W/H3Yp0b92u+4GuTiWjV+yG3
	 JnmATJXg6bWsI3bTR7fv+6CFyIq2vNe0PS0XK/ob9bUAoodTiW7/kpLe1K4+EcnsdI
	 bJmZYrBFsu8i2pqlruRETEzU+gmSbghE7J+y4Zroo0ClWpuOA+A9avJIgDjn4CsI1W
	 6K0Rn+0jlDqiA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] sunrpc: Replace the rq_bvec array with dynamically-allocated memory
Date: Wed, 16 Apr 2025 11:28:53 -0400
Message-ID: <20250416152854.15269-2-cel@kernel.org>
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
replace the fixed-size rq_bvec[] array in struct svc_rqst with a
chunk of dynamically-allocated memory.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_bvec[] array is 4144 bytes. Replacing it with a single
pointer reduces the size of struct svc_rqst to about 7500 bytes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 6 ++++++
 net/sunrpc/svcsock.c       | 7 +++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..225c385085c3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -195,7 +195,7 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
+	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..db29819716b8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -673,6 +673,7 @@ static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
+	kfree(rqstp->rq_bvec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
@@ -711,6 +712,11 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
 		goto out_enomem;
 
+	rqstp->rq_bvec = kcalloc_node(RPCSVC_MAXPAGES, sizeof(struct bio_vec),
+				      GFP_KERNEL, node);
+	if (!rqstp->rq_bvec)
+		goto out_enomem;
+
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
 	serv->sv_nrthreads += 1;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 72e5a01df3d3..671640933f18 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -713,8 +713,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec,
-				ARRAY_SIZE(rqstp->rq_bvec), xdr);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec, RPCSVC_MAXPAGES, xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      count, rqstp->rq_res.len);
@@ -1219,8 +1218,8 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
-				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, RPCSVC_MAXPAGES,
+				&rqstp->rq_res);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
-- 
2.49.0


