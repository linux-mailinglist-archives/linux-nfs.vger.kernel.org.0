Return-Path: <linux-nfs+bounces-11627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60526AB1CFD
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3507B258F2
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7112242D8F;
	Fri,  9 May 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQNtrFf1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E707242927;
	Fri,  9 May 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817441; cv=none; b=tu42WvsmaLbKaDTibnJrJ2aMewmlB+EP3GndiNmkpoSpkh3/4EH9NWgO06GPd5bfc6bu3fitN+HoL3H1HIaM3VXKsUy1rtPBRdWuxmTO1daPF/9SnSOviNz1YXm3o0AJXMGUb7UyqnVpZ4YGWmprjxbq1jVvABFPwdtUXckjCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817441; c=relaxed/simple;
	bh=/X2X+zBHcf2RKDjtns5MTw+U22icGLFH94R3sA/buAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojAA1lF3wPerNUfRClRt7fJouicsvlLC9DGLmPHX3/QbamW+8MSfz2Dh5medfsKT70hTQqtlYLUEEC3hFFXr1NlBk830uCuQTny2Q8ExGN4YxSCEgyo+EqoUmmkSVaX2zdifHGEjcoop2b+5NZzETDlS0Z//K/N/RtEmALM5y/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQNtrFf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A62DC4CEE4;
	Fri,  9 May 2025 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817441;
	bh=/X2X+zBHcf2RKDjtns5MTw+U22icGLFH94R3sA/buAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQNtrFf1tJGuovGDdWsYRED3QBx/jgZ/MDLxUCBVcwg1h4Ys9XWM4//oLGW5QMpl6
	 lDn4p/XUN4X8aBVCdIJgSlSTLNFWAebviiTXFAaOFZYYP2t2a9D4LQJwnjwnrcXJ2A
	 ItIntRN8SKl2jRMc40ftslRfVAhQMYvljs895kMqda9z7/oOaxwhbbUCx+F7Gv62xi
	 uLZiDikfk9L9u9A5Z2Tdtzx32C/WTJ0vK8956yN056uIg/A/G/BADVePLnN5uX9Mdd
	 AzjQPLcDfelHH9+LM+8qhVz/i7lTnhLLWmdBU9J+3JldfoW6ubvlVA5WJoyZSrSeD0
	 3cgVWb+Ihqcgg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 05/19] sunrpc: Replace the rq_bvec array with dynamically-allocated memory
Date: Fri,  9 May 2025 15:03:39 -0400
Message-ID: <20250509190354.5393-6-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
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
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 7 +++++++
 net/sunrpc/svcsock.c       | 7 +++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 57be69539888..538bea716c6b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -213,7 +213,7 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
+	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d320837e09f0..2c1c4aa93f43 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -672,6 +672,7 @@ static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
+	kfree(rqstp->rq_bvec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
@@ -710,6 +711,12 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv, node))
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


