Return-Path: <linux-nfs+bounces-15073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51EFBC692F
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C0B4089A8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506692C11E6;
	Wed,  8 Oct 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOkv2iLv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8D2C11E1;
	Wed,  8 Oct 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955020; cv=none; b=L32OZ9kUSpF5reM1r2yJdT2CJkdPNolFJdueA7eXG4FEBn9lUTpoLCCoe4or4lYvkQmlVMLTGhuVZum1Id+ifuG+2W1TQ6vBvE5Ju6WDVrjYpuLcSlu1q6qOLA7RRp+Wye7+kWenMt+0zIDOQqDKGtXRXcH9eBQhFVfF6E4mn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955020; c=relaxed/simple;
	bh=8nDSP5DbElALu/4XwcTShL3Nf1KZZPQ4UIs/7Xnd0n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpxQLBFMJ5rC8WSyUPp2zEbMgfzP64IsywGD1rPIXq+GaZhSxNjaYTOfTOEfZCuNgPqgvb3pV7KU5fofb6RC6bGuuQkqIT3b7ppnbzXPcRSn058oqD/ILnU01CVP0KPF23b19wfAAD+m4j5BXWyksdtVnYFcd88vuN/anJpVMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOkv2iLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A8C4CEE7;
	Wed,  8 Oct 2025 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759955018;
	bh=8nDSP5DbElALu/4XwcTShL3Nf1KZZPQ4UIs/7Xnd0n0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KOkv2iLvhBy5ynBEleTaSwS/kZS9zWAsG8hiLTQPBbVH4B2f6KEavHlGAO7lBzfAo
	 TbRb6wQqxMQ6sBrfoc/2fUOjoeTGG/X5KSUQyBVHwiC/JeDCxswl51ywaJlAA0rl+W
	 jrMYYbeijCr2vq0IQBNxiZuH7mZU3dvp0ZJtWfgT+awryksQyLxJGbQva6gSFyqWb1
	 gwK49hfS1t+l6sjxuFYlR534EMDV3ZLDBSLhE9v9uYTtXbFp6356mw+I5dKPTqEdjm
	 KJfC31PvdB6/kaTU4QZRX4eZoD5X9SivlR1F0cbCrDB45Ok+XD0+ln79q1rFGy6NVG
	 VHiejTpuETj9g==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Oct 2025 16:23:29 -0400
Subject: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record
 marker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-rq_bvec-v2-2-823c0a85a27c@kernel.org>
References: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>
In-Reply-To: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8nDSP5DbElALu/4XwcTShL3Nf1KZZPQ4UIs/7Xnd0n0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5shEGFZIHVCCntXGPRwPmy0neHUl73X8UKMkz
 tbI0oZUTkSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaObIRAAKCRAADmhBGVaC
 FZgMD/0a8oUM55E4RjbtzrgvBJToMG3K7TfrbpR3vKzegis3w1wNku4Pri+XD3SKy4rGz7/gEN6
 Vwe76VCpYOgRlUYwE75YWgynVyziVphSBRpKU3y0mZnBu2H8+p6F/rTkz7utbaQDpnlk9WusN6B
 5AKg2bJnRPRBpVs2u4OowFLk0reS2MYHJ1aDyOCJnVuGfX0kxsbIG4+I9JJZGa5ilsBp9d+jnAp
 hl/gb6DASxWCqjfAuZNUq5+vqQismi/KrY0d9iGpMVYPfK13ANvd9id2cUmjTsiRxHkUd/IwWsg
 4QkdR9Gi6NgqhhWZonznGQZXSwb0Blk4ZbmWPNR9qpURUdBB78X/nndUmOAL6YxS0LRyLN6E+bU
 SfRIgRresDJHamdU4pGxjg5rB6jpcEcsVxC0C5MHr8hk/RSS/X4g+A41LaR8+8LY1exssGWrb2X
 ZHOCdMixJUuBTgSp/gXsnV7OwfD0OBAn0ztEF8xG1zOI1LOX2qksO3gXdI2CKJOVXkiyb4PKCGm
 k0sKOv9EigGJaiZoAeuIrTOGgFbtGq/4btSlXEJPcxCDoFqT1KfWRW3Zs6tMtjxKHlfEwHGJkja
 b4+O9n12+WvpXZT5se+1ZpAbZJur6V/aqwbbU9ZBsKFni7ZVnh3U1u4g10h/6apCwIe3s2a5Uoc
 EAubcOqHvPDgtHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've seen some occurrences of messages like this in dmesg on some knfsd
servers:

    xdr_buf_to_bvec: bio_vec array overflow

Usually followed by messages like this that indicate a short send (note
that this message is from an older kernel and the amount that it reports
attempting to send is short by 4 bytes):

    rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting down socket

svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
marker. If the send is an unaligned READ call though, then there may not
be enough slots in the rq_bvec array in some cases.

Add a slot to the rq_bvec array, and fix up the array lengths in the
callers that care.

Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
Tested-by: Brandon Adams <brandona@meta.com>
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


