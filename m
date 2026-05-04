Return-Path: <linux-nfs+bounces-21382-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB2fNDSe+GnHxAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21382-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 15:25:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CFD4BDD62
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6701302DCCF
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944A3DA5DF;
	Mon,  4 May 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmW1qlBQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA5378D71;
	Mon,  4 May 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900888; cv=none; b=tDzY43VFzodLtmMH4WgLfseW6tm4R1jG5ZVo87MRP6AWh8ROURDBegDrk0fGdBDZO+KsFilb1+Z0EmO7sgz7VpwiT/NViGjqORKztywnLXT6lJA5e0O9UvYqBAjocm7Q4p9ryWwpGbGFfeTMq3crephHSrAi5WgboT7G4WKlETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900888; c=relaxed/simple;
	bh=2aFCrdi086X8qaY+nrQYNcsSeV5HvIWfW7LHiwbQchQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taiYiqx1/F8qC5UvkZMGh/JjlnSFwvUKTD1hA7bJhH3TyoK2BKlyuX++S23G4zjZnvkP/EqOip2KggoyP7X9sGAUZM/WoLml1bJYd3/CV9X5c7AnT1xVz9mz6eVEVTHb8+X9kOEaEkr55OM/ov4xI5vt+jOjb94PBvb01Dw0VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmW1qlBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34274C4AF09;
	Mon,  4 May 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900887;
	bh=2aFCrdi086X8qaY+nrQYNcsSeV5HvIWfW7LHiwbQchQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cmW1qlBQq1HOb3cm9DFTA9YWVwxGTYZ/7TDKbbF+u0tf0t0+vmPZw2hBkA+K8gxOI
	 aFjZC9Igr0Kf7wNgdzLmEu0yIwOhPPkmhQ8RFdE3H2G2BEGqdpjlihBLjHCyZz113T
	 PiFHPjWRTNQX64T+kzdNYo+BBay/WjHds/NBI2nIcopTuune73KPhKIKkdH8mnSt8/
	 mWaYsErFDGhpJx8I0j/uDTXjt6v4duueKgk3bKYpmzwD3JCDga8OjnPWjxEiVA1RkD
	 2finvn/5LM7g6+uSv+LuaUVfnrwlvhMv1DLRHIM4l+29nGQUfcQTbU6d/ysSVMKGXH
	 Ujiab4Xt/9Ikg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 04 May 2026 15:20:49 +0200
Subject: [PATCH v5 1/2] mm: track DONTCACHE dirty pages per bdi_writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dontcache-v5-1-4103e58bb377@kernel.org>
References: <20260504-dontcache-v5-0-4103e58bb377@kernel.org>
In-Reply-To: <20260504-dontcache-v5-0-4103e58bb377@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3721; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2aFCrdi086X8qaY+nrQYNcsSeV5HvIWfW7LHiwbQchQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp+J1NRZKbyI7QhGLiFF2oAvXgvp74opb+1ER2w
 V1/zzRaInuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafidTQAKCRAADmhBGVaC
 FVfRD/43QS9dZ/TF2zC6q4G6CqPoyA3ARP6obj1Xj+LbLpvyEmgsXxz+3d+U/FfnrA8BRHtb9QL
 qr+DcoUZk2qB+URtNgCPYPwKBDtqkgJ+SisKUHuXzqjw3qMTh6c4znnSG633tJttJopxbpR8YII
 s7t5olXjXb4eEmwPXIRAKzfrnxHBIj9WN9NZpWIKHDuQP529fBhbZEVyOnxorJuYKUebcLYerxm
 ha+rmiV4D17PNqIyUeX5rYbvKeeD3bUuXCQ1H+qI580RjMfbgUlisrWaK9vh7m+wB90snPQvcYQ
 dS9oFMbTspr49VuAUf/VEl6sFBgEllf+GwuujzQBWomgFJDCCM/xpeb1pRfc28ciMhTMzRD6lxq
 nLBiUtrwSR1UfOoruRdfA4PYDPsB6vFq5hNZMxgWhyJXgTrJhUif2Vzg+ADwlUMZfL49Xa1hYbu
 TS6q9Ph5QR+x1q7QaWGrax44oyb25sS7eRWljcso6CLFZU9EOrc6hoxEHFQyZpzVimCExJVFSkD
 BA8N0u5a9Wb27puAE8r2v0xFcGhZqf2qBiMZuTWNiiJ6csZBaeuvziWe+ESXIgabtB82LDJjkIm
 8DUcz0KpgvQYgTixhjkclRiF/6xqWnRG0G1EZ/CFfKBjt11N2Fd9F7enrpPODrT2CWcHbqoQuKr
 zLenDJ+Xa6OU7GQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 73CFD4BDD62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21382-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
writes).

Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
when the folio has the dropbehind flag set, and decrement it in
folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
when a non-DONTCACHE lookup clears the dropbehind flag on a dirty folio in
__filemap_get_folio_mpol(), using proper writeback domain locking.

The counter will be used by the writeback flusher to determine how many
pages to write back when expediting writeback for IOCB_DONTCACHE writes,
without flushing the entire BDI's dirty pages.

Suggested-by: Jan Kara <jack@suse.cz>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/backing-dev-defs.h |  1 +
 mm/filemap.c                     | 13 ++++++++++++-
 mm/page-writeback.c              |  6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index a06b93446d10..cb660dd37286 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -33,6 +33,7 @@ enum wb_stat_item {
 	WB_WRITEBACK,
 	WB_DIRTIED,
 	WB_WRITTEN,
+	WB_DONTCACHE_DIRTY,
 	NR_WB_STAT_ITEMS
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..1c9c0d5f495f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2052,8 +2052,19 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio)
 		return ERR_PTR(-ENOENT);
 	/* not an uncached lookup, clear uncached if set */
-	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
+	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE)) {
+		if (folio_test_dirty(folio)) {
+			struct inode *inode = mapping->host;
+			struct bdi_writeback *wb;
+			struct wb_lock_cookie cookie = {};
+
+			wb = unlocked_inode_to_wb_begin(inode, &cookie);
+			wb_stat_mod(wb, WB_DONTCACHE_DIRTY,
+				    -folio_nr_pages(folio));
+			unlocked_inode_to_wb_end(inode, &cookie);
+		}
 		folio_clear_dropbehind(folio);
+	}
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio_mpol);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 88cd53d4ba09..8e520717d1f6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2630,6 +2630,8 @@ static void folio_account_dirtied(struct folio *folio,
 		wb = inode_to_wb(inode);
 
 		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
+		if (folio_test_dropbehind(folio))
+			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, nr);
 		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
 		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
@@ -2651,6 +2653,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 	long nr = folio_nr_pages(folio);
 
 	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+	if (folio_test_dropbehind(folio))
+		wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 	task_io_account_cancelled_write(nr * PAGE_SIZE);
@@ -2920,6 +2924,8 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		if (folio_test_clear_dirty(folio)) {
 			long nr = folio_nr_pages(folio);
 			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+			if (folio_test_dropbehind(folio))
+				wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
 			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 			ret = true;

-- 
2.54.0


