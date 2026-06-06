Return-Path: <linux-nfs+bounces-22328-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8WGA7CaI2qLvwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22328-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 05:57:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7964C513
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 05:57:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ndv1yhbZ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22328-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22328-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4297C300C837
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 03:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211A2C0F69;
	Sat,  6 Jun 2026 03:57:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AE27453;
	Sat,  6 Jun 2026 03:57:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718246; cv=none; b=ElbC2uPbG4EpG2Elf8SjIaLGzfz7er3Wxl/lB83itTvk2KtfFfDME3253cu0YSiA4rtpQMlY1JWuvuTnAFms3LMlSKSrnAjpH4ST2Kur1Xt4wWly0vJ52W65Et9gNLjeccfTIa3pgcoO5J29SmR3hCGRCt6tv2SYNXy+hkUgxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718246; c=relaxed/simple;
	bh=OAqwiumuW17VoV1AxYGi7mnejumgfnZxCLiartOLD/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l265Vrlmz9OuAKZpILTmLa5AJaZU8l8GHVu/yHjHwF2X5HNObBv6IOvGvnzMlbqwELK/VIw/fq9f9l+zQPVtoCIOc8YjTCdFRiKJRfYQPFYC//iEjNkyePf5sexWGxokQTiB3MHxDO608P/8Yqd+3VOGuJ8ySnhQ0VV5oeNvzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndv1yhbZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFD01F00893;
	Sat,  6 Jun 2026 03:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780718245;
	bh=DyAJxWMcfaVwU7Ubjr6avFpvSuPyA7t3dbZlo6hIvEE=;
	h=From:To:Cc:Subject:Date;
	b=Ndv1yhbZtMuwy4HFdvMYKO5o7j8AYzRbLplB2wdNYY6i6lhy6aszAwImtpkjIhzNJ
	 3ZLTfimfzdeEEF1hfYv3yueoHfUWWAqGrVwwl97vzfsbu9TBUNKH14VhaBweY3Sdez
	 D9RoSLjxuH3e7uVS/7Bt5vhYQRgi6dDAqqZENAcOvmr629z4Ki7eqHPbgDC1nx9eKG
	 9256/0MXg3qQ+d1r/BMb7Nt3qBFcAItVt5BvoidwcS6vlBbCBqQni481pmPMaU45ZA
	 R2QxpB8wo8P3QNg5lxp7OtJnjEK//2zmag+/QM/Pd5nhoLB3rocPYPLB8p7WtQ/S7/
	 Mis74PT4/Sebw==
From: Chuck Lever <cel@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Subject: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
Date: Fri,  5 Jun 2026 23:57:22 -0400
Message-ID: <20260606035722.83175-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22328-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,m:jonathan.flynn@hammerspace.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DE7964C513

From: Chuck Lever <chuck.lever@oracle.com>

Jonathan Flynn reports that commit 18755b8c2f24 ("svcrdma: Use
contiguous pages for RDMA Read sink buffers") regresses NFS/RDMA
WRITE throughput from 73.9 GiB/s to 30.3 GiB/s on a 128-core
single-NUMA-node server driving dual 400Gb/s links with 640 nfsd
threads. In the regressed configuration, server CPU utilization
rises from 8.5% to 76%, and 73% of all server CPU cycles are spent
in native_queued_spin_lock_slowpath.

The contended lock is zone->lock. The page allocator serves
allocations only up to PAGE_ALLOC_COSTLY_ORDER (3) from its per-CPU
page lists; SVC_RDMA_CONTIG_MAX_ORDER is 4, so every contiguous
sink buffer allocation falls through to rmqueue_buddy() and
acquires the zone lock. The workload above issues roughly half a
million order-4 allocations per second, all serialized on the
single zone lock of the one NUMA node. Replacing the GFP mask with
GFP_NOWAIT did not change the profile because direct reclaim never
ran: the cycles are spent acquiring the lock, not reclaiming
memory.

Cap the allocation order at PAGE_ALLOC_COSTLY_ORDER so contiguous
sink buffer allocations remain eligible for the per-CPU page
lists, where zone lock acquisition is amortized across pcp batch
refills. An order-3 chunk still replaces eight per-page bvecs with
one.

Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink buffers")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index efde26cac961..4546e594f2d7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -746,11 +746,12 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 }
 
 /*
- * Cap contiguous RDMA Read sink allocations at order-4. Higher orders risk
- * allocation failure under GFP_NOWAIT, which would negate the benefit of
- * the contiguous fast path.
+ * Cap contiguous RDMA Read sink allocations at PAGE_ALLOC_COSTLY_ORDER.
+ * The page allocator serves allocations at or below that order from
+ * its per-CPU page lists; above it, every allocation acquires the
+ * zone lock, which serializes all nfsd threads.
  */
-#define SVC_RDMA_CONTIG_MAX_ORDER	4
+#define SVC_RDMA_CONTIG_MAX_ORDER	PAGE_ALLOC_COSTLY_ORDER
 
 /**
  * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
-- 
2.54.0


