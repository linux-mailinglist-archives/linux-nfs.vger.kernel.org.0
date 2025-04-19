Return-Path: <linux-nfs+bounces-11183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71225A944D6
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D85B176B4D
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173F1E00B4;
	Sat, 19 Apr 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnczJQbX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C11DF991
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083706; cv=none; b=CqVBtZ+5jAzM/ncAgS/PXIe7Y62dDs5iCq2Iva4uAdasoOrQIAIieWYP0SzzajHoWBQ/HNpm3iWSUoKxi/eRo2x4udsP0lPckR3jNqNEP7wg7FJXXLpsBRceM5EJChYPaWVFaH51TTVP4+IuAdKz0p3WpFc4RTRml9hCxAG1TuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083706; c=relaxed/simple;
	bh=HO6bNgwZ6Z25hu73jBi7/XBCBhOiGkqDksIbWNEiP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj1q7kwQlnqvh2kLbV+hfBSzy7nfaDpCitqns9AgxN6IM/lM83bZPaVmdj144WmLV3eMnAeiSACLz+x2xo+t89yTFT/J7Km4OdYJXi43IR7pnixxdX2jj3AgUnbDUtf9cRNj1Ch9SpzvdN+PbX1W1SuP7OkmyMHHeytfUOHn/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnczJQbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A1C4CEED;
	Sat, 19 Apr 2025 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083706;
	bh=HO6bNgwZ6Z25hu73jBi7/XBCBhOiGkqDksIbWNEiP54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnczJQbXY0LwhjtkkfOCZxO91Hoji9aukTIMVLkR1ixVzbNTM82QyM+ZJx5UG8nNN
	 asUmHXALE4AeTAfAa3OUozq1uiKHj76Alw5UxEav2FoGohV5NypnWfNEARHoF1WbcU
	 CdTA+/udYObAf2b7YCQuKflWL133rtkdjUat7lLzn4/xpQ3g99tTO6M5qHKuFug8E5
	 F1Hnmw7X+r3wy8M4o6ylI+NT8pzs5YPu5Je19zKDo/oFflZ2+kGoBrD0/FphzUwkEC
	 uZEc2qmosrmQ/KppZB2KODNaAxcaN2dkE/smizYDO01pfaPeL10QzWjHaPlQZrl/Cq
	 rmi92KAKri15A==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 05/10] sunrpc: Replace the rq_bvec array with dynamically-allocated memory
Date: Sat, 19 Apr 2025 13:28:13 -0400
Message-ID: <20250419172818.6945-6-cel@kernel.org>
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
run-time, replace the fixed-size rq_bvec[] array in struct svc_rqst
with a chunk of dynamically-allocated memory.

The rq_bvec[] array contains enough bio_vecs to handle each page in
a maximum size RPC message.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_bvec[] array is 4144 bytes. Replacing it with a single
pointer reduces the size of struct svc_rqst to about 1240 bytes, or
just over 19 cache lines.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 7 +++++++
 net/sunrpc/svcsock.c       | 7 +++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 72d016772711..a524564094d6 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -208,7 +208,7 @@ struct svc_rqst {
 
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


