Return-Path: <linux-nfs+bounces-22325-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0v3KblPI2p5owEAu9opvQ
	(envelope-from <linux-nfs+bounces-22325-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:37:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01564BAD9
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:37:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XV47B6By;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22325-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22325-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005373011F13
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB54071ED;
	Fri,  5 Jun 2026 22:31:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DA3D3332;
	Fri,  5 Jun 2026 22:31:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698681; cv=none; b=ty0s0lQVMXKMi9ah7/P0xtIbXPIqqPzIYsNoBHJ1DBIK0qvl1aQfL8oDbozDq073hspp13RHrGLQWH4gDoVmHX5B9dgIsZgsQlS71GZxzwhbEwjRySOfch+eGVdLYve/to/GnSLxD7Eyd/Jj4XK4U9NAp87cZYh8aEm6KFI7mEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698681; c=relaxed/simple;
	bh=//fl8NY8cHCuLu0F6IcD2+A7VFp0LS+mBjTKvPo0Mkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+XyuaKPc/A8Scg1fGf2kps6oGqvcduSUFohJJSv2bZn9kiF9xOdvC4fbnrk1J+H6XH43D1wlst5ppf3MtSU72JNffMGbBelIFVQBfnsB3Bmg0j5SyGAOD4O1m8IO+8sKhIMAZ876P4nWkj5UX40e7qMwtq+dZx5rqT9P9DaLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV47B6By; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFBC1F00893;
	Fri,  5 Jun 2026 22:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698680;
	bh=+biCh8iFNbHBCiJ/wzUPBBlfLt4ML/msKMECFhIQ4+M=;
	h=From:To:Cc:Subject:Date;
	b=XV47B6ByzDuqQZsnYNuit8tWlCitgnM/wytQSeUXQUf+YIDiV+3Q8ivZ1JpC/YRDF
	 lmsrkJFeX8BYUDOD8cFe5nel8Y5UvhazUr5lDTkTUiGow5ODIDm0Onoid3RchCCEtU
	 u1l9Mo2TPY9/GKbnljICeyG+XDIdxosfHOkXot/z6WCbE9F5OxzLzlXRISyWvqbBIb
	 KkPgrmiY6hzbVaqCVWj/coXOaQdqCAOm0ru0z7d48Qz9AFEMJad72U8C6ECdXMAISl
	 XWjY88lPHpty4gT0JfBqT8BFvKTK2oTaie6aZzOZyKKRcHrQQF9PboQgbRoaymKqrn
	 8WDvIAYq59DTA==
From: Chuck Lever <cel@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Subject: [PATCH] svcrdma: Avoid direct reclaim when allocating Read sink buffers
Date: Fri,  5 Jun 2026 18:31:18 -0400
Message-ID: <20260605223118.75092-1-cel@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22325-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,m:jonathan.flynn@hammerspace.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F01564BAD9

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_alloc_read_pages() passes __GFP_NORETRY, which limits the
allocator to a single round of direct reclaim and asynchronous
compaction per attempt. Under memory pressure or fragmentation that
round can take a long time, and the fallback loop repeats it at
each order, multiplying the stall while the RPC waits for its Read
sink buffer.

The contiguous allocation is opportunistic: when it fails, Read
sink buffers come from the pages already in rq_pages[]. Direct
reclaim effort buys little here. Allocate with GFP_NOWAIT instead,
which omits __GFP_DIRECT_RECLAIM so the allocator takes pages only
from the free lists and returns NULL immediately when none are
available. GFP_NOWAIT retains __GFP_KSWAPD_RECLAIM, so a failed
attempt still wakes kswapd to replenish higher-order pages in the
background, and it already includes __GFP_NOWARN. __GFP_NORETRY
has no effect once direct reclaim is off. skb_page_frag_refill()
takes the same approach for its opportunistic high-order
allocation.

Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink buffers")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


Given the perf symbol resolution inaccuracies I can't swear this
will fix the issue, but here's a stab at it.


diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 587e4cd29303..efde26cac961 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -746,10 +746,9 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 }
 
 /*
- * Cap contiguous RDMA Read sink allocations at order-4.
- * Higher orders risk allocation failure under
- * __GFP_NORETRY, which would negate the benefit of the
- * contiguous fast path.
+ * Cap contiguous RDMA Read sink allocations at order-4. Higher orders risk
+ * allocation failure under GFP_NOWAIT, which would negate the benefit of
+ * the contiguous fast path.
  */
 #define SVC_RDMA_CONTIG_MAX_ORDER	4
 
@@ -758,9 +757,11 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
  * @nr_pages: number of pages needed
  * @order: on success, set to the allocation order
  *
- * Attempts a higher-order allocation, falling back to smaller orders.
- * The returned pages are split immediately so each sub-page has its
- * own refcount and can be freed independently.
+ * Attempts a higher-order allocation, falling back to smaller orders. The
+ * allocation is opportunistic: it takes pages only from the free lists,
+ * without direct reclaim, so it fails fast under memory pressure. The
+ * returned pages are split immediately so each sub-page has its own
+ * refcount and can be freed independently.
  *
  * Returns a pointer to the first page on success, or NULL if even
  * order-1 allocation fails.
@@ -775,8 +776,7 @@ svc_rdma_alloc_read_pages(unsigned int nr_pages, unsigned int *order)
 		SVC_RDMA_CONTIG_MAX_ORDER);
 
 	while (o >= 1) {
-		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN,
-				   o);
+		page = alloc_pages(GFP_NOWAIT, o);
 		if (page) {
 			split_page(page, o);
 			*order = o;
-- 
2.54.0


