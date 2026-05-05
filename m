Return-Path: <linux-nfs+bounces-21396-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNoyFFo++mmjLAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21396-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B94D2F9A
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25006305EF50
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1177495528;
	Tue,  5 May 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/63nRja"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2833CF683;
	Tue,  5 May 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007615; cv=none; b=LJyiaDOA3c9DeAQhEGYpNkEzkBkS0gNdB7tgYhCFO0yjMteGvYRWURgC5/p+/8BLwAIcwEVqOoy3w9z1QhF+Uc0H8YFqbhbqREmPraAjJ8M5HiddSB7wyC5KPxrg/v/9mQ9H1+XlMDuiuWT4R5uV+tcu4zKZggAiphILoelc5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007615; c=relaxed/simple;
	bh=VNFDaVKtHxfKb5Jtg4lw1jtyfG4WqayLBxu+KyjdETI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7cckYrJs7R3Chl6LlXbaSu/Hv0C3viu1Oq5cl8cVxWEFD3NvzuYPTGxez8vtevKjnOQ/sSB/Wv/JV5uEEkl46+FvWo+ghpK4cReX+Smioi9Itg7nTjZ5ZfbYXF+GWXrjK2JlRYcBBA0/yihBJ2j5SQXRQEWrC0eD9zx1jAMKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/63nRja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ED1C2BCB4;
	Tue,  5 May 2026 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007615;
	bh=VNFDaVKtHxfKb5Jtg4lw1jtyfG4WqayLBxu+KyjdETI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F/63nRjaUCMUeXblGr32PcC5EvgwHVUSYc2KMVZZYd2AXLUXRg2vrU7OOiweSLmAz
	 Ey0FQDJuRcYeSomo5C5yHitaEH34lItP6ooE5ardeEA4zoOkaQsQn4hg25KW3VqH3H
	 f4vrxfBzb6VdxbtSQOm1UjWHWhEE5K5kgS5TFbyk15gvR3GTdAGvB0bUxXNsHOHlkT
	 a7aKqpIl1NlQb0kWuBjSk1XEpHZVbro8qsNRNIzDG4gs0OmPtwUAQ1ZNin4IC0RxRY
	 1UEXhZuejm2V4wu+l0u/WfRB0cI954NwGaD2b8hKlJ4Ix1ncWVYdVzw41T0Lc7qSQ5
	 3XwrkjU1fJeaw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 05 May 2026 20:59:48 +0200
Subject: [PATCH v6 1/2] mm: track DONTCACHE dirty pages per bdi_writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-dontcache-v6-1-66463805dd6a@kernel.org>
References: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
In-Reply-To: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VNFDaVKtHxfKb5Jtg4lw1jtyfG4WqayLBxu+KyjdETI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp+j4zKs26S/A9Ogbbp0fUGJuKz7QkA8Ss6E16g
 9ZgN8VzOGiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafo+MwAKCRAADmhBGVaC
 FbHuEAClfB9yntbp0VqHfI94dQPxUMse8RDGZxSS7rytsC1YCO6tM8EOs6PSMXyZ5zGp8ZijYGk
 4MnLilXhL2s6P9YBhrdC3RfRbKcbiY+vtny8oGucvHnEe7Q8MjdUjp31AcAkN0/DhLYYz/jKT/Y
 ctlkhyan7088mUgwwL7jVVdlht6dnp7XEhkNya332Q3tgcffiR2NUUFPY4sorFpkcgkpnypI1tL
 GKhmT+XvPQ/kPeq4d+RfWWe/lJNUGtmU1zgSLJ2RBgrDPkxVOESrzcTVvVjb8gYcjLmmmJqsTzz
 1NGInwei02fIoO79WpaXalTDTNO75+NcCQf+DKjjhX2Ln0e8/LvlGFbr3mYraTuPNBXMw7gMrrc
 5qxd/cM4ruPr5HdoQm8Bn64wdbW3trY9nY8wvb6A6sqbgQbWrXoOAAi3lpv1H2239YovXFBVeA2
 5rWA4tV9zc6cNm4++YD7SA1nR9DeEBItq996hWr89i1WRFgXf6R7Wzw5lEaySOJyBEc1d3zUuLR
 y7+OPc5GMP2p6KjtjjCjovc8GhSyUZ5gdRS6EoKbYh5/R54ypCSxCXmWPHnnXBELS4VmAABQ+8Z
 40tCPbgSmoTKbXnnGurViHDMlpEsnvU/NF8CREIG1YGk1MBneldUdDzSDYk4nsvHFO0NiZmfMTb
 AVtn8Wx8tKTA5Jw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: BD3B94D2F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21396-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]

Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
writes).

Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
when the folio has the dropbehind flag set, and decrement it in
folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
when a non-DONTCACHE lookup atomically clears the dropbehind flag on a
dirty folio in __filemap_get_folio_mpol(), using folio_test_clear_dropbehind()
to prevent concurrent lookups from double-decrementing the counter, and
guarding the decrement with mapping_can_writeback() to match the increment
path.

The counter will be used by the writeback flusher to determine how many
pages to write back when expediting writeback for IOCB_DONTCACHE writes,
without flushing the entire BDI's dirty pages.

Suggested-by: Jan Kara <jack@suse.cz>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/backing-dev-defs.h |  1 +
 mm/filemap.c                     | 15 +++++++++++++--
 mm/page-writeback.c              |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

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
index 4e636647100c..e706f5c4ece4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2052,8 +2052,19 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio)
 		return ERR_PTR(-ENOENT);
 	/* not an uncached lookup, clear uncached if set */
-	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
-		folio_clear_dropbehind(folio);
+	if (!(fgp_flags & FGP_DONTCACHE) && folio_test_clear_dropbehind(folio)) {
+		if (folio_test_dirty(folio) &&
+		    mapping_can_writeback(mapping)) {
+			struct inode *inode = mapping->host;
+			struct bdi_writeback *wb;
+			struct wb_lock_cookie cookie = {};
+
+			wb = unlocked_inode_to_wb_begin(inode, &cookie);
+			wb_stat_mod(wb, WB_DONTCACHE_DIRTY,
+				    -folio_nr_pages(folio));
+			unlocked_inode_to_wb_end(inode, &cookie);
+		}
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


