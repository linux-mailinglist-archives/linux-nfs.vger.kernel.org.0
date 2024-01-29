Return-Path: <linux-nfs+bounces-1555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30C8408F6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF771F2798B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE40152DE7;
	Mon, 29 Jan 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URzKkg3P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C38664DE;
	Mon, 29 Jan 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539858; cv=none; b=T4jKeXc88YcWFnCD7WoYalju03bn31LNHcjelrKbA70GR4UfzSRORYK5pDqH2rE3fwhiIqsZndDoZGt95MFS4NGGg5q6AjC1qfUTiYIMnNFpjO5Vn/+NLrz0cNQp62nWO4TKuilkwpdNdXAlF5YflrBHvV0/PymFDC20jRViTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539858; c=relaxed/simple;
	bh=bvcVwU0dkB9Z73d5B21G/1JHHanO0TgLYJApJSvI37M=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjVtTUK7nxl7LhRoBrnGtQN0zdDMUzATt7NL2DtWZe0W7i20G2gQRPaAHnZAIKN4WU/YtIm+5/3K2mHF7helM2YOTI+gG7/U+LGl+9ajdLpEZUtUWsvU30/SRhpasgFVoS/VKiShI2CjjylicpwREqDSswPE8xQoOVqVOEpl2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URzKkg3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F9C433C7;
	Mon, 29 Jan 2024 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539857;
	bh=bvcVwU0dkB9Z73d5B21G/1JHHanO0TgLYJApJSvI37M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=URzKkg3POvtbdlGIbpgm5A2e5/lDDA2MII7W4iIHQp60GklJ8QrpP3BaasDZBt4d/
	 LtVW0zOlOgZ/pBkmbGVOjVUhYoN99kJRwEWzhqGr/R8RtFt6vZJM7LiK5BiNc4qg7T
	 nWvy7r1PYLZbjE8HG4jYBu/dJYU2brKLYq/ovkRKMLua9qYsUCF9XYxTRrTs+N4W1G
	 J5ud1bGZphU076T/Wf1VLGyv/Ykz/OkR8EBBQ1vNQMqYbls8pwwaYOk1o0WhUVd8y5
	 T7C0y1IRbTMr2GWZGlRQDyqxckHs1l9bzXHZIty21gYZWmC6YopWGlxzfcUwIgDUb+
	 HvfK96UPxyysg==
Subject: [PATCH v1 04/11] svcrdma: Fix SQ wake-ups
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:50:56 -0500
Message-ID: 
 <170653985631.24162.990683035035649882.stgit@manet.1015granger.net>
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

Ensure there is a wake-up when increasing sc_sq_avail.

Likewise, if a wake-up is done, sc_sq_avail needs to be updated,
otherwise the wait_event() conditional is never going to be met.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 1a49b7f02041..f1f5c7b58fce 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -335,11 +335,11 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	/* If the SQ is full, wait until an SQ entry is available */
 	while (1) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
+			svc_rdma_wake_send_waiters(rdma, 1);
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
 			trace_svcrdma_sq_full(rdma, &ctxt->sc_cid);
-			atomic_inc(&rdma->sc_sq_avail);
 			wait_event(rdma->sc_send_wait,
-				   atomic_read(&rdma->sc_sq_avail) > 1);
+				   atomic_read(&rdma->sc_sq_avail) > 0);
 			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
 				return -ENOTCONN;
 			trace_svcrdma_sq_retry(rdma, &ctxt->sc_cid);
@@ -355,7 +355,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 
 	trace_svcrdma_sq_post_err(rdma, &ctxt->sc_cid, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
-	wake_up(&rdma->sc_send_wait);
+	svc_rdma_wake_send_waiters(rdma, 1);
 	return ret;
 }
 



