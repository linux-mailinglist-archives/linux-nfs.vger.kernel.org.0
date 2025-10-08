Return-Path: <linux-nfs+bounces-15062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C48FBC6661
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3386D3BD253
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74E2C21E1;
	Wed,  8 Oct 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV0EupLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70692C21DA;
	Wed,  8 Oct 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949953; cv=none; b=Tl+omA48Idh+eqbje94QMNqKQN6za2a4ri8GHzJ1smDlS3mEl+A5yhwBMLMXOCp152Mb2mZwF4dQjGcDUeJjqKQYZdpd0oY8omKLGU1gx5x4ZGmJWWxjS3d6CPL7k5h+dtWedP9ibmFCc0oJA0I2CmdrFxB180pZQtzY7nUpH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949953; c=relaxed/simple;
	bh=UiVGnSi7V58UwvWYVwmNngyeBVLlQrbzs8iMIl+lk7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfuRq91ii8OVXGE8KFUvasF94lV1GrLKkLXwFwU0EaMe2F/6+OM51ffQDIYtpX1gFkzZ2ZCcYV2UMS2D3gFMA3vPOOBYu+LGVg2lFpbiZBVmDQ4dGPi7grVFrRsr3gYocd2qKR84nW5ZjYIFUmpMMthuoMxRXWiOsL3QqEaoq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV0EupLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE9FC4CEF4;
	Wed,  8 Oct 2025 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759949952;
	bh=UiVGnSi7V58UwvWYVwmNngyeBVLlQrbzs8iMIl+lk7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WV0EupLV8NGMMmqprWMPf7WDJtFoCP8mFFeGCh3VEVW36C2XsQw28Pn502HLgofog
	 AodP0oTYDP+3V3qeMislpdw79CcSVz9QxyDMZmSWvZr3DHyotfU52sDMFE5cd9O+EJ
	 WwBnycJufiAE3kGwtj19UXam04bwQFiWQs0BPB2O7p0tisbgxrGjhEXhmPQ2l+eGDt
	 v0LmvYDtlrp0XJTE/SXD6Bru0KMy8D+tirnRYdDbAYoG/V6Ee9I68fUVWYDSrlVeFG
	 wGqyHgC3NRzMyZUMQ601ujfnURsYRlODyRvvi31C68QQ29AE51O/qk+QWimiMtCLAC
	 8prGWOYirsTww==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Oct 2025 14:58:53 -0400
Subject: [PATCH 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record
 marker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-rq_bvec-v1-2-7f23d32d75e5@kernel.org>
References: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
In-Reply-To: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UiVGnSi7V58UwvWYVwmNngyeBVLlQrbzs8iMIl+lk7U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5rR5tQ0FvTVZCbZfd0an2dxVjsmqXo5gRpOMP
 5txDP3gnmuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOa0eQAKCRAADmhBGVaC
 FTJoEADGiBU2q9VGU1AXdgokO8glagusbBXI/NLtYb3MNyAK0KrtjnBtjAj+5G/fm+5pgVZhnEh
 +U6dal1ux6vlGXoEq5wMq8t/1NXkhHV2BULWKd5fOGZddPHb2jR5Q5qW4i6D9BH7aO1r2iCk9uZ
 ODktXhoqZoGj5DZ/dCveubpWE+7J0z6SccZQI+4Y1ym8Kgw2rsWgL9ENM/D6MRZt4MCw8O9i7+u
 +yPdFPBGqzf4sZz1vhb3V6Zca/Ntk3jnourKvN9ZRUUjg1+OdBXVvPjI8+leOpgkApKfF4lDK+N
 vhXztVG4wgmMsZr1Hv3axRnOEpTevbOq0eeRSKbHf4VLGTKQk0IKbfY+lXOf28cZFwCEpePSkIK
 Sl+C76b0d27BSXIFMu83g1g+Sjr38I76EQYB+FkO9J6GFduXCMkFEkcFYVH5aDlY0nL2vJoicdM
 KtBxn3PlbffXh+KVQ8ao6qJBChDiQUbOL29BpNi2Eqb1X1Br2nVi7qzL51Mhz04WxiSAK5n4KKY
 ANk/Y+YDwYaTG7Kk/qs7g/ULonQSXLNxK+8iaX64gisAslxbk1yobGQgGEWTtwsDIRdsKrR9hVN
 o35IVJT26MbCFAuzUPWf7N/7N4SR5eT0jIkqyvgjcB5gw5X9STbh0GVU9EYvFLubblR0VuKD/GU
 uDODuWnKbUND8nA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

svc_tcp_sendmsg steals a slot in the rq_bvec array for the TCP record
marker. If the send is an unaligned READ call though, then there may not
be enough slots in the rq_bvec array.

Add a slot to the rq_bvec array, and fix up the array length
calculations.

Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c        | 6 +++---
 net/sunrpc/svc.c     | 3 ++-
 net/sunrpc/svcsock.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 77f6879c2e063fa79865100bbc2d1e64eb332f42..c4e9300d657cf7fdba23f2f4e4bdaad9cd99d1a3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v = 0;
 	total = dio_end - dio_start;
-	while (total && v < rqstp->rq_maxpages &&
+	while (total && v < rqstp->rq_maxpages + 1 &&
 	       rqstp->rq_next_page < rqstp->rq_page_end) {
 		len = min_t(size_t, total, PAGE_SIZE);
 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
@@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v = 0;
 	total = *count;
-	while (total && v < rqstp->rq_maxpages &&
+	while (total && v < rqstp->rq_maxpages + 1 &&
 	       rqstp->rq_next_page < rqstp->rq_page_end) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
@@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		kiocb.ki_flags |= IOCB_DSYNC;
 
-	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284eccc9e2bc64cf22947666facfa86a..919263a0c04e3f1afa607414bc1893ba02206e38 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -706,7 +706,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv, node))
 		goto out_enomem;
 
-	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages,
+	/* +1 for the TCP record marker */
+	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages + 1,
 				      sizeof(struct bio_vec),
 				      GFP_KERNEL, node);
 	if (!rqstp->rq_bvec)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..5f8bb11b686bcd7302b94476490ba9b1b9ddc06a 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      count, rqstp->rq_res.len);
@@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
 				&rqstp->rq_res);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,

-- 
2.51.0


