Return-Path: <linux-nfs+bounces-1556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4168408F8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67841F279D1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4DA152E00;
	Mon, 29 Jan 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzxWnW/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA27664DE;
	Mon, 29 Jan 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539864; cv=none; b=fGlcaS70ek4Q2uQWHDWlQ8TM+iTnp81biKgJdqt7my1I0ubYZMYbckkd5aA5EU1hv7piLzgnvnrD8F0SN4dKS7gwhGfWlOza6uqDc0PgVtrBjOmMKGWWypSA5HcHaOx3zMjU+o1gnV/e3VZFz8nVxaRvHPWKt1HGlNn+hpcuPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539864; c=relaxed/simple;
	bh=Q8M+ZV8AwjWJN106yxlomJOUg4m9WT4jLLZhalyAC+0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+ZWAgoq9AQ9/VArcfwb5gMHFRFLC3xFb894PAovLeP+4RNYfgGaCK/Eg0W4yH8Srp6vgCoRkCBLkcIh68fKp/xAM/MzyDF3pH5unAG0HKQRbQpFhehee+/PghOoyiTJFLinj0N8lAg5fKVWl/Ie3kQORJ9DY/djbK0OwfIneCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzxWnW/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAAFC433F1;
	Mon, 29 Jan 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539863;
	bh=Q8M+ZV8AwjWJN106yxlomJOUg4m9WT4jLLZhalyAC+0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bzxWnW/bzPTe1TM+K74RooCuKcH7X2qBQILl/Z+PeieQ6tMaaQznA1chqK/+R1z1I
	 ApDEkOKut6l/5MaHlKH9eoHTsQDQ2a30Mp+AoGbUjhCwrbeKv1NdVBqmQcI6w9Yiys
	 89JcNuz5Y4b/sPxNpsiaRrKdJ1X8xaEraqceG/4g/Eki+WgQKv+aBS5oj9RXCF8tqE
	 vd8kBh1vGlrfi5HYmUqjtrQbhBNEAGgUS8hgg7YrG4AtvDnmg1HeSY2clh5oM+SJQg
	 m/JJlPZmHLuxhBo5QAHMMtwfbB4M9kuGAp6SGXsJWhOJj92UJ7INmfxpgdx8fCYKht
	 m+XIxC5Ny8Vqw==
Subject: [PATCH v1 05/11] svcrdma: Prevent a UAF in svc_rdma_send()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:51:02 -0500
Message-ID: 
 <170653986273.24162.4447192396691167938.stgit@manet.1015granger.net>
In-Reply-To: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
References: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
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

In some error flow cases, svc_rdma_wc_send() releases @ctxt. Copy
the sc_cid field in @ctxt to a stack variable in order to guarantee
that the value is available after the ib_post_send() call.

In case the new comment looks a little strange, this will be done
with at least one more field in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f1f5c7b58fce..b6fc9299b472 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -316,12 +316,17 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * @rdma: transport on which to post the WR
  * @ctxt: send ctxt with a Send WR ready to post
  *
+ * Copy fields in @ctxt to stack variables in order to guarantee
+ * that these values remain available after the ib_post_send() call.
+ * In some error flow cases, svc_rdma_wc_send() releases @ctxt.
+ *
  * Returns zero if the Send WR was posted successfully. Otherwise, a
  * negative errno is returned.
  */
 int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 {
 	struct ib_send_wr *wr = &ctxt->sc_send_wr;
+	struct rpc_rdma_cid cid = ctxt->sc_cid;
 	int ret;
 
 	might_sleep();
@@ -337,12 +342,12 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
 			svc_rdma_wake_send_waiters(rdma, 1);
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
-			trace_svcrdma_sq_full(rdma, &ctxt->sc_cid);
+			trace_svcrdma_sq_full(rdma, &cid);
 			wait_event(rdma->sc_send_wait,
 				   atomic_read(&rdma->sc_sq_avail) > 0);
 			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
 				return -ENOTCONN;
-			trace_svcrdma_sq_retry(rdma, &ctxt->sc_cid);
+			trace_svcrdma_sq_retry(rdma, &cid);
 			continue;
 		}
 
@@ -353,7 +358,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		return 0;
 	}
 
-	trace_svcrdma_sq_post_err(rdma, &ctxt->sc_cid, ret);
+	trace_svcrdma_sq_post_err(rdma, &cid, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 	svc_rdma_wake_send_waiters(rdma, 1);
 	return ret;



