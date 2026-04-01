Return-Path: <linux-nfs+bounces-20597-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNO7DI1uzWnvdQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20597-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:14:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37A37FB64
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1403303CE2D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23931A7F6;
	Wed,  1 Apr 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUnJBnGa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987633F8C3;
	Wed,  1 Apr 2026 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070682; cv=none; b=u4IlPW/vENbJlNCufvOOf/Da+c7Ly4XTKNQbbBsT0hLhDJS+UeO+X+2UXLdcSx4iec6SgVaXM1+7wOTAhUfu2KFV7sraeV/z9LrLiJN/XJZni2FP6G4JK5rHIH/zhVH+f9iUaBoDWKqQBma1QqKxj5SG1CFECHHpix7ONLjnBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070682; c=relaxed/simple;
	bh=n7l9LGVOvDCd2+hzVMt9/rX50u2r86z4dGB9ckGBacs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzWDsr4UTpSX+BTUcVSS2Ukix7AX0ZkLmfENfVHUXq1hIpJ2iu7spi0mbOYKMD7rNvQkPFhS0ZEsKDUzQ3ilALPMlG815ADAjf+yhbUfH/mLn/2pD1MYMxXmhVEhAECiITJMwRw3USFE5qFvcauIa1npsi94b+cm3ie42SKVQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUnJBnGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E65C2BCB0;
	Wed,  1 Apr 2026 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070681;
	bh=n7l9LGVOvDCd2+hzVMt9/rX50u2r86z4dGB9ckGBacs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SUnJBnGaMXzuGq2jfYs5fyq28qNIXelBnO41hoV9B/TDNXaFNLeaPBA2u3IMD422G
	 Ef6b8Zmsw7GAGQcn7TyhEIdCdl6Jn0ONVBWJw8mFzvClmoMfSUuUTRHcZgndSQjL7j
	 6Ix4yrbDHn/OGZLU/GQng+CtK6HHtIe1VsTa9haE1EululVtYpLj3/SzuMcZ7FCPlD
	 JzWsYwWE4BWEDLVp6nesvMuvbK3TlxevVn1b1OItdbzsPmXSXQGwe+atQUtZdQ728k
	 l9Fn9FKi6h6StO7mevqc6+hID5bh/R+NxiUbjVVkfjkQBRAA+yCWJx0IlRu5jmJFQO
	 zghBTtxY4mTXQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Apr 2026 15:10:59 -0400
Subject: [PATCH 2/4] mm: add atomic flush guard for IOCB_DONTCACHE
 writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-dontcache-v1-2-1f5746fab47a@kernel.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
In-Reply-To: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <msnitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4833; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n7l9LGVOvDCd2+hzVMt9/rX50u2r86z4dGB9ckGBacs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpzW3T1yRFo42zG4qubsASRC7nh36KGdmLOG0+u
 SYX0QTMzu+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCac1t0wAKCRAADmhBGVaC
 FXRND/wLxlUsyChusdT+tMPyQlfIoRYVZSMnojtBnUxpk4ci5Ejisdqd31zG5v6L9d8nO2CqZ/7
 XOkPlNuHLyCnnyvsNQfUoazU5/RyJKEmCUpAlVYl1p23ZACTrxj4dFv0rLIGuUf3i1hZU79WZ2V
 RZbFm0iLhHUS4IUYslnQm8Ybyn3AY1WtsM7n8aKqzF3ojSAZScFAkuiybXbkTL9J3x64/9e0Bsl
 e1NS+ojwLWQvZSy/D/dSYz0A6HuW81amiFk0cruWpqIBHIqpIDTzYXeXdqLbymCEYQV2yYdCGPN
 L4utfged3Ib93dMnGPE1gq1hP8Xc09bDojftaQ0Wjn2zJ//axjaMpLVZb/Auo2vfxY9h8RHWYmK
 mhJM6oR3tjgTf3FnUBoOqN5PIMObMl3fb6/VOZ3MybiSyx8jFCnR77b0+G2RLsuZhIqgGXjrhye
 2sQWYaohXVjIXg410jVNstXP8tO8z+UjNAY35AMkBuW5Od5sE5RMR1f6OCu9dGppesvkmHoDHzP
 3PlLqZOh8CjjS0gxnwq4jp2VWqSO0fr1ciFGtVF9CNytB/iIzXXhns1IJMTP0sbquNuM17N/HRt
 EIzcNuT3AxXLENvanZOvvzU9ooef3c62RM6qckIl2xdtB4wMoDEA/CaTKcji10x5zdyijBa7iiw
 p58BsgyOdBCCZsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20597-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D37A37FB64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the PAGECACHE_TAG_WRITEBACK tag clears after a round of writeback
completes, all concurrent IOCB_DONTCACHE writers see the tag clear
simultaneously and submit proportional flushes at once — a thundering
herd that causes p99.9 tail latency spikes.

Add an AS_DONTCACHE_FLUSHING flag to the address_space and use
test_and_set_bit() to ensure at most one IOCB_DONTCACHE writer
flushes at a time.  Other writers that find the bit set skip their
flush entirely.  The bit is cleared when the flush completes.

Together with the existing skip-if-busy check on
PAGECACHE_TAG_WRITEBACK (which provides temporal rate limiting by
skipping flushes while prior writeback is still draining), this
creates a two-level guard: the writeback tag paces flush frequency
to match device speed, while the atomic flag prevents the thundering
herd at tag-clear transitions.

Additionally, add a dirty pressure escape hatch: when dirty pages
exceed 75% of the dirty_ratio threshold, bypass the WRITEBACK tag
skip and attempt to flush anyway.  Under heavy multi-writer load,
the skip-if-busy check can cause dirty pages to accumulate (most
writers skip because writeback is always in progress), eventually
triggering balance_dirty_pages() throttling with severe tail latency.
By forcing extra flushes when dirty pressure is high, dontcache
writers help drain dirty pages before the throttle threshold is hit.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9d9850d37185418349b89e6efe420..e71bf75f6c22d0da5330c17c6e525cb12d254dfe 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_DONTCACHE_FLUSHING = 11, /* dontcache writeback in progress */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
diff --git a/mm/filemap.c b/mm/filemap.c
index af2024b736bef74571cc22ab7e3cde2c8e872efe..1b5577bd4eda8ad8ee182e58acd50d99f0a8f9f5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -444,11 +444,21 @@ EXPORT_SYMBOL_GPL(filemap_flush_range);
  * @end:	last byte offset (inclusive) for writeback
  * @nr_written:	number of bytes just written by the caller
  *
- * Rate-limited writeback for IOCB_DONTCACHE writes.  Skips the flush
- * entirely if writeback is already in progress on the mapping (skip-if-busy),
- * and when flushing, caps nr_to_write to the number of pages just written
- * (proportional cap).  Together these avoid writeback contention between
- * concurrent writers and prevent I/O bursts that starve readers.
+ * Rate-limited writeback for IOCB_DONTCACHE writes.  Uses three guards to
+ * avoid writeback contention between concurrent writers:
+ *
+ *  1. Skip-if-busy: if writeback is already in progress on the mapping
+ *     (PAGECACHE_TAG_WRITEBACK set), skip the flush — unless dirty pages
+ *     are approaching the dirty_ratio threshold, in which case flush anyway
+ *     to help drain before balance_dirty_pages() throttles all writers.
+ *
+ *  2. Atomic flush guard: use test_and_set_bit(AS_DONTCACHE_FLUSHING) so
+ *     that at most one dontcache writer flushes at a time, preventing a
+ *     thundering herd when the writeback tag clears and multiple writers
+ *     try to flush simultaneously.
+ *
+ *  3. Proportional cap: cap nr_to_write to the number of pages just written,
+ *     preventing any single flush from starving concurrent readers.
  *
  * Return: %0 on success, negative error code otherwise.
  */
@@ -456,13 +466,25 @@ int filemap_dontcache_writeback_range(struct address_space *mapping,
 		loff_t start, loff_t end, ssize_t nr_written)
 {
 	long nr;
+	int ret;
+
+	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
+		unsigned long thresh, bg_thresh, dirty;
 
-	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		global_dirty_limits(&bg_thresh, &thresh);
+		dirty = global_node_page_state(NR_FILE_DIRTY);
+		if (dirty < thresh * 3 / 4)
+			return 0;
+	}
+
+	if (test_and_set_bit(AS_DONTCACHE_FLUSHING, &mapping->flags))
 		return 0;
 
 	nr = (nr_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
+	ret = filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
 			WB_REASON_BACKGROUND);
+	clear_bit(AS_DONTCACHE_FLUSHING, &mapping->flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(filemap_dontcache_writeback_range);
 

-- 
2.53.0


