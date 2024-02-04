Return-Path: <linux-nfs+bounces-1756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD3849182
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D4282AD9
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F9BA27;
	Sun,  4 Feb 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9Stj1ry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B92BE49;
	Sun,  4 Feb 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088625; cv=none; b=RrZW2QP+c0c4XCl8MzpDo2PFR4uphcvKv4KdFT4jVhB3JXc1QqIukBHSrEtv7Xuk8b9UoAJ/koF5l9AT1qj3NAKH2kuMTZzoeuGToozZfQ2J2qCR33ZyLP7FFAqiKvntquNbeJ3X/cSH9CxXpqIbsx1WOZfhEGcZCp/FQKtHBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088625; c=relaxed/simple;
	bh=bvcVwU0dkB9Z73d5B21G/1JHHanO0TgLYJApJSvI37M=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1pOIkr7RiD6U+9hlcHAjK6Tq4UmRmaj6HPYlW0LvSGjLcl2SZlvkIQYYBCN8swf5mk3Qsu06EvXYbSz3aHnGWSiLohGERh2CUEOZoIIZ1Y2k7V3lmrtaYm33AT9mOQZ9om60N+fh6JrtFhLuwshBqms53yGMJuSIW3+5wEB04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9Stj1ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A825C43394;
	Sun,  4 Feb 2024 23:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088624;
	bh=bvcVwU0dkB9Z73d5B21G/1JHHanO0TgLYJApJSvI37M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=i9Stj1ryMTeI6JfgI/KCa++7zi49XFVdTCVmw6dKB0sUmQRjn5EmqoQV4MUyOdPrV
	 Lng27UEDGr/UIhnFsO0xH+/GTwe54p3CoqQK8P60qepEzkEocFvkyirQajBt7bec5i
	 3zz9+g/qTHIFmaowRB725Z6gFW1bn4OhKWbILO1cCUpF7GZT/gkPSqQxOEjhSEiwD+
	 OqGa5T8FT5IC1sZzNzbBo7i6XP3wu9MzhiufKVHr224SYN+e8mUJllHA3dp0UGW9OQ
	 Pcm+b5YqZ4dF2k4nrzew9oitE/fRvskNBeY96+/6AvPjVzJoeIq+EmPAKTzx2c5rKl
	 mAFOOvx/pSeWA==
Subject: [PATCH v2 05/12] svcrdma: Fix SQ wake-ups
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:03 -0500
Message-ID: 
 <170708862325.28128.5793674364971023505.stgit@bazille.1015granger.net>
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
 



