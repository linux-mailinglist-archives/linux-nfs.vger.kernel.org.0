Return-Path: <linux-nfs+bounces-1557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71948408FA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A0428A362
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A2152DE8;
	Mon, 29 Jan 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THlcY70v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5C1487DA;
	Mon, 29 Jan 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539870; cv=none; b=Wi+qoqmXMp8pDcPueqScTD6RgctdZT1kVabPiHQeMhPK7uKbTYMB5PMVIyU6BZUo326jzHIDajpZgtGSl5QtfatJW9iaTosfUtrKHCEhDUGXCs+Ajg1kU9Vtm6ofNeygEX0QBzpg1+J5kSz3j46rTbQ9SxI8n/hznGUoDE2xhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539870; c=relaxed/simple;
	bh=AxYa8OHD5oTe38D0Fdj6WOQrLqgmLObq7aN1YDqlrJ0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCrob0hV/gZV+jCMBvgPCD5gRxRNZ5h+WTEGxEiVCXCM8oyUO9bGansH7Tz2hrPBn4F2ghdSRJJ7SdECusz14ryc/zoEoGy64JKCVA73iW0O/WjVYkS8FKBal/IMq0MMJfTnTksXaFAKu0YN1vJ1MOKLKpHOpVmbDwhpc4OIEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THlcY70v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9BBC433C7;
	Mon, 29 Jan 2024 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539870;
	bh=AxYa8OHD5oTe38D0Fdj6WOQrLqgmLObq7aN1YDqlrJ0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=THlcY70v21GO3qlclwpsS+g67726GdDsx3RzYUPmfzWGLwWtWAqDfiRyb6tAMEwtS
	 urnnFSLAgOttNYzjAGTvpZUjUF8px9RxSqeET0pdlXZfPQzuQCvx5h3AuQaR2i3OKx
	 eVt3YNMchxQ8OVCEnXraOBebq9OkqghRrQ0XQoh96mCo949rtsZAt8hNGSrK10ovh7
	 NMrfrtnclmUa69kJw6IdnsZ7ri5Tg757hIKO2uok66a7wrySjPOeJ/qZKT4wwr0YGd
	 enzrrB6KT4DlJk84YDT3L8CwhJBTF2P93XQtAM4SGYZK+j/l7bPlv4PcfXB2SdlyjH
	 zxvkio8xJQ6ZQ==
Subject: [PATCH v1 06/11] svcrdma: Fix retry loop in svc_rdma_send()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:51:09 -0500
Message-ID: 
 <170653986907.24162.2435133775108024319.stgit@manet.1015granger.net>
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



