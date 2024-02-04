Return-Path: <linux-nfs+bounces-1758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CE849186
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B491C21247
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7528F72;
	Sun,  4 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3ZRPlOD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413BC8CE;
	Sun,  4 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088637; cv=none; b=GxkAKrn3B9EN9D3bB7+qBpmVD4CrPh6/ufOFws0waf8LivIshStWfrME/6v1P/J5q0hw9FExHxiGS25xSmzbFJHq19+Is1I8lZ2muWWQ/chqT+VxNexMG2LfJfRyQpSn/m3Bohz1MwoN1o81gKzaml6Pk+B3VC/kBNjfipURDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088637; c=relaxed/simple;
	bh=AxYa8OHD5oTe38D0Fdj6WOQrLqgmLObq7aN1YDqlrJ0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p698ngxlxzyFt/Apht89NdMz9GMPH36EEf4ledyGNwBe5g0zEcMItmFt1ZtMHgsnihIBJjsu2tjQzUnqVBOgphjD8QR2tEeJ0wjSstYwzyMqOPkiQMkhsv6af+hVHUvu8NBI0eKaETZRQa+CdfiK0lE3CWEYR0pY/BWOlfJIU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3ZRPlOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA73DC433F1;
	Sun,  4 Feb 2024 23:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088637;
	bh=AxYa8OHD5oTe38D0Fdj6WOQrLqgmLObq7aN1YDqlrJ0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=t3ZRPlODTXsGMSiWB+An5bh0qOU2tvsBnmzYhorAY7pFj8ZkeBVxPfIvRHdODg0NO
	 aJyun45+cZ/LBjaWOw8jgYYOCa3QoX0Txd/qupOOSWUR7S3N1U5Ur06J7lqiU4t8g+
	 zqLXiMd7B4xWt4vZletyPnb4fI77wb+i1U5AUFLnXPR7ghSMgqbtQJnidI5lN36pNu
	 ZBwurP2bvI3S/jLHm51lpgjEtbl4hkeaAkEzdhP5nPbZ7aWNDNOJyJUmU1qCI0slu2
	 Y2UvKN3b4S9LZW8ZQxqbXzVC0KUDL08GT8vQSqc9tcC1FAYnDza7/Tb/WTHeZoot43
	 MwrvPBd0UY/5g==
Subject: [PATCH v2 07/12] svcrdma: Fix retry loop in svc_rdma_send()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:15 -0500
Message-ID: 
 <170708863598.28128.10828477777645028041.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
References: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Don't call ib_post_send() at all if the transport is already
shutting down.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index b6fc9299b472..0ee9185f5f3f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -320,8 +320,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * that these values remain available after the ib_post_send() call.
  * In some error flow cases, svc_rdma_wc_send() releases @ctxt.
  *
- * Returns zero if the Send WR was posted successfully. Otherwise, a
- * negative errno is returned.
+ * Return values:
+ *   %0: @ctxt's WR chain was posted successfully
+ *   %-ENOTCONN: The connection was lost
  */
 int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 {
@@ -338,30 +339,35 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 				      DMA_TO_DEVICE);
 
 	/* If the SQ is full, wait until an SQ entry is available */
-	while (1) {
+	while (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags)) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
 			svc_rdma_wake_send_waiters(rdma, 1);
+
+			/* When the transport is torn down, assume
+			 * ib_drain_sq() will trigger enough Send
+			 * completions to wake us. The XPT_CLOSE test
+			 * above should then cause the while loop to
+			 * exit.
+			 */
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
 			trace_svcrdma_sq_full(rdma, &cid);
 			wait_event(rdma->sc_send_wait,
 				   atomic_read(&rdma->sc_sq_avail) > 0);
-			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
-				return -ENOTCONN;
 			trace_svcrdma_sq_retry(rdma, &cid);
 			continue;
 		}
 
 		trace_svcrdma_post_send(ctxt);
 		ret = ib_post_send(rdma->sc_qp, wr, NULL);
-		if (ret)
+		if (ret) {
+			trace_svcrdma_sq_post_err(rdma, &cid, ret);
+			svc_xprt_deferred_close(&rdma->sc_xprt);
+			svc_rdma_wake_send_waiters(rdma, 1);
 			break;
+		}
 		return 0;
 	}
-
-	trace_svcrdma_sq_post_err(rdma, &cid, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
-	svc_rdma_wake_send_waiters(rdma, 1);
-	return ret;
+	return -ENOTCONN;
 }
 
 /**



