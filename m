Return-Path: <linux-nfs+bounces-21327-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ez+L7R39Gk7BgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21327-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:51:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2714AB662
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D154E3037433
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621F37F017;
	Fri,  1 May 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKVnoSQr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F03659FB;
	Fri,  1 May 2026 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629020; cv=none; b=ndU3P2BCwvKH1Xg2+Pnr0JG9EIvK7WrurNtLNdT0pC4jZgGq1Uql7omknCC82Dkw2xPrrrFfGIfkH2gyofORnOZB2+Jh2VLpl+zEluoMwvIxtiH41+VyAeac+JCi87TLy8HhkF+yTkVT2amXMi7qPkZwpie/6cwUTnvWEyGC32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629020; c=relaxed/simple;
	bh=4CYXeOlFdNJ/l03z2utNHrOYCz+YwEmVX7CEA57VKaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN8S7tuKcjb91wcocshIxSZ6YNPnJIw5A+MQ8tWLze5itQWY/O5pgGr6CURJKOQQV2PiWKPElelhvcUv3izu/Ei0s7gwdroKmSmbfqfbg+wBqyLCdeiFzzTsUgSy6DPxcpYCTxsVRDQ4KMh357HGQqugwMTWW02aLRm8t+hjHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKVnoSQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D515DC2BCB7;
	Fri,  1 May 2026 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777629019;
	bh=4CYXeOlFdNJ/l03z2utNHrOYCz+YwEmVX7CEA57VKaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kKVnoSQrWJeDILj7+mIfDLX2WD/0fJg2ViILcSv46jpdeO9Vx4w9kZ3AW5tXAdSOT
	 VqjrDTlg+ZM8yUOrQeTKFdDtbqtAJbkuE25QQv9n4mh+DLkOSnWP9ltsCfvQ0iKTrO
	 aPUX4tQALCljkv8adxFtd6xicjVU+UKZSKcCcE0D9gnA67ltC8miBdOYnuiLS+UiGz
	 6qSbqes/CKa+6PETChdfQtDAvz+VZELHp/F9gTEozl9Cm7a5HqbsZYKT+QD6ecbhug
	 9IhKebdVDSvcBDKqPWOAAbQcqA+7duHlwUNjdhWLAWges5mS9/vKTAjVypZTmtO6u1
	 vYYq+7Mcfoc6g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 01 May 2026 10:49:35 +0100
Subject: [PATCH v4 1/4] mm: track DONTCACHE dirty pages per bdi_writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-dontcache-v4-1-5d5e6dc71cb3@kernel.org>
References: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
In-Reply-To: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4CYXeOlFdNJ/l03z2utNHrOYCz+YwEmVX7CEA57VKaQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp9HdPPFn55EVKdK2kssKhcP5f4apt0ClJopsC7
 t1wRkqHf96JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafR3TwAKCRAADmhBGVaC
 FeqCD/0Zqep3sm7p/GXonKUD3Hrr+qlUGhzPqP4bv5R18zbFwInLPz9G7ypQwV1i3w8OE/BfKcb
 zYYwJQi7Oke6qUeEkVur0wj0z0ZP+G5rUK/HlhNVYzG+XQgomTnznPcMEBtbtwS7VYL+0anFLQf
 IG4wpFtM959wNowJe0wgV79AwhezsYimbD2BZzSiqk9vSibo+7jkRChHIpQCK9flDS10GJoSFO6
 hPRiLSO4y8Gc6HE77vD+Cu6JinCmzhQ1Amy9Z7b94vzcyi4wjgDdYKlHtUMI/9zQP5Z5lWV9QXX
 Kk5sfuv1g8KQ885ZXKDkq91bWtTZCJdHzPDPu0L5KI3w7jIWZh+39y+C/XIYHlxJ9AMFcVYwpo+
 4BFipwwcEpXuO064LT9CkbFddWSfPR83RDoV2H4N5Inylh8sqVp7LdnRT2H9TmDbEDWAaEdJoff
 G5HgvlhpoPevt7C9nFP9h8Kz4Gnz4hsF0xaeyMLzJIF01liLM5VNPr32utprTE75JCxrX5Vag4e
 kYevA9gwOe40xAjnOZmeH24qW0Aeesuc21gzO4DM1+fNikEjzHkQ609t6spwJrMp168x/jOx47w
 iLuinj8ZUYiBP2sxFQYgStBcRqVP3l1wlQtoeU3oOyMR5UX9vi3vHlqXjSTy0Ex+VbbX9AS5XUX
 STkQPWt0m0Q1q0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 1F2714AB662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21327-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]

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


