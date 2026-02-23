Return-Path: <linux-nfs+bounces-19141-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAw+Gk6LnGl8JQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19141-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:15:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B117A8AB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283B6317A97F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1B32ED2A;
	Mon, 23 Feb 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqEcbMjf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046C328608;
	Mon, 23 Feb 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866621; cv=none; b=mOC83zJdJxX9M2pXJFUQR0VyhRl3SYoCMR5k/55zZnJ00E+wGABPq0qnUuMZGHNQrOyXvev2OiEs+ElnefvfT1QnJWzvqRjDZ9181/jB9KBCnMzfaEDxx6Q/flOKbncsHNcfrC6fA1XWX0LiV+daF6od7HlXbpSJpM/vN7dJWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866621; c=relaxed/simple;
	bh=iBGTnjfk1/dGbsw0AeqIOOg9PivpMLxPlwAMF1EqA3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0S/zW8S8PMC2stz0PGGyfo1etgA6TlmagMdlwVY1ymOctK2icno1iQVuVPc6Eic8M9+33Pu0OvyKQQY3ctgHfZ6xg/NFCxZvQexR4FkVr96rdnxNHMFWeJksezwrCOY42RM1CfLORRXml8TitynrWsLe66bz3FBZ4xxCO2NhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqEcbMjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFDC116D0;
	Mon, 23 Feb 2026 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866621;
	bh=iBGTnjfk1/dGbsw0AeqIOOg9PivpMLxPlwAMF1EqA3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qqEcbMjfz1GtZsY0LqH1u8bPZBb0Asbc4cKuEMzyu0xQb77Xhi3/KQKuo7Qga6JOy
	 By+OTd9eIK15F7M5fN5hjcNhlzRugAhXIxfMhGFZrrAYZX0TDp2fctkjQQ+CEG4E9M
	 ZqGXUeMHHeUIpd3/xb82bgrE4xxB6rW363DWsEPMzPaP3OmIKtvv5wB7jBrNmLcXoJ
	 uVYXiIAXpsIs1PVCEhEfq8WJYDDDrTHBIg8cqUEL3cnUsUtT6hBj24yVEmjJVOOgiF
	 NV4Oi3syuFHKHAfvirlM2o8fsFFYbkilIvJYY2fX9IMhy4GPCy/6onpFF30c6sE+yv
	 I8Y4en+XV8xsg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 23 Feb 2026 12:10:00 -0500
Subject: [PATCH v2 3/4] sunrpc: convert queue_wait from global to
 per-cache-detail waitqueue
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-sunrpc-cache-v2-3-91fc827c4d33@kernel.org>
References: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
In-Reply-To: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iBGTnjfk1/dGbsw0AeqIOOg9PivpMLxPlwAMF1EqA3Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpnIn3Ci4860XifnM5rQrFGVZmHLtxuHCpa0mZX
 +spMGV0dOSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZyJ9wAKCRAADmhBGVaC
 FTF8EADXNzk2ezTn+jly5XOmD4zIbzPqPAgKpADWzvQMUtmg1nKLgt1raAJPe9C4ctFDZJqt6wt
 igiYUUY5jEvoQ9BVKd5b4ffqe68wpkGXMZn64x0CWq5tkSRGyKJhAQ0IyUms2PjPUhY47gWCvfY
 08ri3vJxRlFxD8yNRe3WmDz2pGOmQQUasA5pU97+WPbfGKAFFnmRsTjTu8d5X5sALCpy36Re4DL
 CSMpTKq4wDu3hPaw+1Q8SgDwhScf7IWRzvyDK4D9MtMbIFmo5Hbbhx5pE86nhIqCAkJIxAp5A9e
 6XAxbToNKbgi7MBGX++2KpZ/zpeIVkBXkrN0Cf3np0JLGPMKTf/62oQ7+nB3xM3uvLOcWq7PoSS
 t4KY0uIaIbDFWoDABJvIng/TzJXqw0TaetN6kwHaH8aOyeDkF02HXgPkjLU6YQWZka04zt3p5Ci
 9cEs8Kiqy09o3y0R7C9Hk1BtcCmCR1FDrePRasWMGyhFxaogZBvdluApBmMxl5S5IltpO6Cq0op
 cJgQ7B2xmGy07y6srW5QRJ5bdXLWT33/+MXIqS2vSX89VcBUEjKcVRJCL0S8q9eOrO1Cpg8Zln2
 FCVhyo8/4Bsubmqvu7YFS/w/foSBFTwv5QWxDPpP9m8W2aBZvVsgq6MamIGg3jUNMPeJ4SYxqLZ
 wWYF2hx2Vw0vtQg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19141-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C63B117A8AB
X-Rspamd-Action: no action

The queue_wait waitqueue is currently a file-scoped global, so a
wake_up for one cache_detail wakes pollers on all caches. Convert it
to a per-cache-detail field so that only pollers on the relevant cache
are woken.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h | 2 ++
 net/sunrpc/cache.c           | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 3d32dd1f7b05d35562d2064fed69877b3950fb51..031379efba24d40f64ce346cf1032261d4b98d05 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -16,6 +16,7 @@
 #include <linux/atomic.h>
 #include <linux/kstrtox.h>
 #include <linux/proc_fs.h>
+#include <linux/wait.h>
 
 /*
  * Each cache requires:
@@ -114,6 +115,7 @@ struct cache_detail {
 	/* fields for communication over channel */
 	struct list_head	queue;
 	spinlock_t		queue_lock;
+	wait_queue_head_t	queue_wait;
 
 	atomic_t		writers;		/* how many time is /channel open */
 	time64_t		last_close;		/* if no writers, when did last close */
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 1cfaae488c6c67a9797511804e4bbba16bcc70ae..fd02dca1f07afec2f09c591037bac3ea3e8d7e17 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -401,6 +401,7 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
 	spin_lock_init(&cd->hash_lock);
 	INIT_LIST_HEAD(&cd->queue);
 	spin_lock_init(&cd->queue_lock);
+	init_waitqueue_head(&cd->queue_wait);
 	spin_lock(&cache_list_lock);
 	cd->nextcheck = 0;
 	cd->entries = 0;
@@ -970,8 +971,6 @@ static ssize_t cache_write(struct file *filp, const char __user *buf,
 	return ret;
 }
 
-static DECLARE_WAIT_QUEUE_HEAD(queue_wait);
-
 static __poll_t cache_poll(struct file *filp, poll_table *wait,
 			       struct cache_detail *cd)
 {
@@ -979,7 +978,7 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 	struct cache_reader *rp = filp->private_data;
 	struct cache_queue *cq;
 
-	poll_wait(filp, &queue_wait, wait);
+	poll_wait(filp, &cd->queue_wait, wait);
 
 	/* alway allow write */
 	mask = EPOLLOUT | EPOLLWRNORM;
@@ -1259,7 +1258,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 		/* Lost a race, no longer PENDING, so don't enqueue */
 		ret = -EAGAIN;
 	spin_unlock(&detail->queue_lock);
-	wake_up(&queue_wait);
+	wake_up(&detail->queue_wait);
 	if (ret == -EAGAIN) {
 		kfree(buf);
 		kfree(crq);

-- 
2.53.0


