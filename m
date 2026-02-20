Return-Path: <linux-nfs+bounces-19062-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLEgNRlTmGk1GQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19062-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:27:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6C1677C6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13FDD307D7FC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF013446CB;
	Fri, 20 Feb 2026 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkrOgpUs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5380342CB4;
	Fri, 20 Feb 2026 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590380; cv=none; b=r7K4dlsePNlifMNOJHVJMO6VcL4PJrOlPu9BRLqKFhj8wUkQx/kThRcuDgarkTwuWv4U+ezYs3ETvHogERs6+FwV2d88S3YJj3zZN6mBqe1TOwZkcBFhRZtoXxaVZHFMMGmcoHRlImUVLtZi6vZkxbd8Vt03mZGqfDfHXHcez/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590380; c=relaxed/simple;
	bh=mYwMNG9Ivd3hyU5H/EAywc3MPDOTT54uByQxPgJoDPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbVRNd17rl/8ZuHZ0RKjitjVyLr4qbfJ0zje4pDOd5ILUjL9ah3aIT1nGf60d9EpNx+7Vxb5DrGOLqSVyRefGO6QNfjlryvEAGkP+wS6ZC/a9Z6IpskHDVUvzocYQwy2neKeokwQli38n3vzCwRflPfaQrlLzMpbq+NyTtDuglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkrOgpUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76608C19425;
	Fri, 20 Feb 2026 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771590380;
	bh=mYwMNG9Ivd3hyU5H/EAywc3MPDOTT54uByQxPgJoDPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WkrOgpUs0J02PlA5tTZkFNDec4SPR58JotfiBGntihRcO+irRb6QHzZDyrQtIQIU3
	 y2qKPGQBWg7ORNiFpERVSRYlgVpBp7Y40bC1E6on6ZzDJKMk5dXUdLgpWqTnXce/C3
	 lkmhFPNb5yWnXsfy7zcAgSmKz1Jkr/DOSVq/jDGcGez/hrmMeAgRtLvmYD6+ToP7mb
	 SYEcCWC86M+LuyvgIGgOatzO5agwu+VI4z2E5vw0Sf2V4bqoK+wrq264u2v3CCoIE5
	 /+npxiE2MwuezLPJBbZLO1bhfMAaI/wyU14PdVNK8xTM1C9qOGlMjWzMfgc16Oyfy9
	 EyiVDCvUVTYXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Feb 2026 07:26:04 -0500
Subject: [PATCH 2/3] sunrpc: convert queue_wait from global to
 per-cache_detail waitqueue
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-sunrpc-cache-v1-2-47d04014c245@kernel.org>
References: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
In-Reply-To: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mYwMNG9Ivd3hyU5H/EAywc3MPDOTT54uByQxPgJoDPs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpmFLo+xhhSwMSgeHDcTx2lJXbBuYk3qXTiGXk7
 VOQ7YCyNOyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZhS6AAKCRAADmhBGVaC
 Ff23EACVybFzTKqdLpaI7bUXpytOPAxhqznIaBt09tKphFqO2DOwo5o0oaHCnUqqAD585ET5+pV
 q2KZKcX6RYk5AMyGf2qFiq4T3rCGvsw6FYXj7o3/o/V9KSti2frwWcYmgJC6b6TB4oLSydrRA5w
 t2/RAzXJj2JcgOBfREy+eYVxScS2keZeQ52c50ii5U0H9t85C4DN8obx73rgFHTHrqugl1HvMkc
 MUGDs81RtNigAkfjqaZWaBu6i8mdIEvs21bN55VdpqqRyY1yN0HPXGmBSHjhjdJLdGxdJPFWiuW
 8U/MuvuyPD35+Wma+4MZUMFeXx2ipPq/ff+k4w9Db6qP+eNCUh76Ngu0LpZT5qbgErDXzLVdZ51
 Cm2qhDZkgoa9MRKb2cHw+26mq35PwFd2CIcCQUr8PAS+wMbrDA07C83VG8Mh353kD+7RFEh4tkJ
 LQJcjuJesD1fL0qDtisCiK2nDB2fWls43ikoHqgPPnQP/rWqQRPrk+27H393nVxDu30zr5UCsX0
 ntvxsmGj/2vI5t+bl9cIKk8SpQggtP8Bgd0t3YaHDtELjFm4tWkjm3xM2a0wVWKpvVphlT1kY4D
 5dwRAnSRz5yJ9KdahdqknPBEE1485loHuAWdl35Orduj6M7u9lImItjhYbY4d7zReJ4hbxjUhMQ
 Es+HXeLF/KTpuSw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19062-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE6C1677C6
X-Rspamd-Action: no action

The queue_wait waitqueue is currently a file-scoped global, so a
wake_up for one cache_detail wakes pollers on all caches. Convert it
to a per-cache_detail field so that only pollers on the relevant cache
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
index 6add2fe311425dc3aec63efce2c4bed06a3d3ba5..aef2607b3d7ffb61a42b9ea2ec17947465c026dc 100644
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
@@ -1243,7 +1242,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
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


