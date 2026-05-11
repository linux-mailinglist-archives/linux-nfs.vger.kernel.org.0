Return-Path: <linux-nfs+bounces-21459-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SImDKDfFAWqSjgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21459-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:01:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8C50D426
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C813055EBE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A9378D89;
	Mon, 11 May 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9IJXCdZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAC3783D5;
	Mon, 11 May 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500727; cv=none; b=kHEZUr1y9n+Rdt6ZtXnA/wVZmS92PFr3jg8GsqjplLPMEFVS5rYHwKT5nfqcuHb5lNuskTuXRUAh/SbZLjgBE2iSXbohVAZJKEga6IZOsVGZS4XetIgzcRMRUAj1V+lD794ZTktgHrNCHByoM2A8FJIYQZlvulJeUWybOcSHcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500727; c=relaxed/simple;
	bh=CosZHTq2j2jb6ZSY38VLO1g0AZgB8KfqDu8O1xyEp7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F32dektq4uLY6aVoHp4VbgxMQbGwzwnoat8Bj3ln5uN8a/R2c/0T+sCd27oSZ4V/78GhfDH8TYA0w9lJpEtR4ntOs2WIsLAdysLgnv2f8zmXt4UH2I+ucbK4pU2lqgoCudkorSvHthmBadnsJz119C9XDnq/NFnX/dRfxu4QS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9IJXCdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4939FC2BCF7;
	Mon, 11 May 2026 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500727;
	bh=CosZHTq2j2jb6ZSY38VLO1g0AZgB8KfqDu8O1xyEp7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t9IJXCdZEAvL+UiAUdALKiaOAv4Z3yfVg9GVqpPJv0Jnku/OZm7X2zY9V0bMQAvLz
	 lhdOKp3hViWV2UTH1D+qp2l/xJcYX7UWDvNVQBxCJOOEa5stxTmBjaTJ59lU7Q/HGp
	 JIMzbOc/64KlhylTCkH6zqGm2FimhnreyIUQWck/PULPM8NmaLSW7SB5yecfLxm8E0
	 4sxTDANTWg+OD50t7zuPlM+bGBC3czWEGq4vjSmOSO5iPk2q50aTn3YsXt+/ii33m0
	 voYmEqsasfc+GW1TsTJs2AzaWB3vSWDBHQNTOSyqouOhfYVP+VqSCrCZxWlfY0A/By
	 /7ZygqupTRr6A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 May 2026 07:58:28 -0400
Subject: [PATCH v7 2/3] mm: track DONTCACHE dirty pages per bdi_writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
In-Reply-To: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CosZHTq2j2jb6ZSY38VLO1g0AZgB8KfqDu8O1xyEp7I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqAcRwRhMfp+nQZKNB7vdmS68Q5wZanT4Sp2CH/
 C6Wq24eWPuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagHEcAAKCRAADmhBGVaC
 FVi5D/0RkGeyFY1pqY14JmBK5en2j4bGs+0zCOoaggIm1apekSZxTTt4ZSrcDbo7RrZqrwjzuwW
 6ALobK9dF/Jn7eyHIZ5LYs5ewwDGzJETSQjI3XlA4plxjuLXkIl2/eMKwJXMwknogGFjTl25lND
 cy8/cEVn6IgC8kIhk0oWiiUfZHd38XM57v4hhoWJ8wT5OBZlMBHGZZDk/K+i8lUGgDH5hwxsmNO
 l3s1ZUjkZXcM2v6z5/MBlw9cC9BKDdgEE/c2hDWliZ9MrIovMsn8avXGss3FS5RLiwWWQCQ7f2U
 aZ1SH766/YAHNL/jMjqDqKUZGLvY0chZqTeoyOLK5+NNlrbnYLxOSOTITIKN4d/q95SJWjeyLSs
 ZW/l4dLKng0TQ70kG4GgwSgi+8WJOIjeIwta4bTP0rRqrSV6fP3A2tETttLFwHw7PVxVD8EKdym
 XuZulPsek8YvrGLdBbmdAAqAu7hAsbgfhZUUeOCM7tGZ8LobKWv181GjJteC7xUqyTCJuN54twN
 Y8NJIlxfLtZFu8t4L+k8oVNtmvtUTYY32OFjNuXHB0rcc9b5snvDIDdBiN9SJ8OZedPdhk68l/c
 urDXf1QNcLWbDC8cWevuzJu9J/vxT/J6zMFkWwY+pArhbI+5mXeGZ+REhPmd8J/Eg/IDzys0hmO
 b/kd9P/lwpFMMAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 48D8C50D426
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21459-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

Transfer the counter alongside WB_RECLAIMABLE in inode_do_switch_wbs() so
that the stat is properly migrated when an inode switches cgroup writeback
domains.

The counter will be used by the writeback flusher to determine how many
pages to write back when expediting writeback for IOCB_DONTCACHE writes,
without flushing the entire BDI's dirty pages.

Suggested-by: Jan Kara <jack@suse.cz>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fs-writeback.c                |  4 ++++
 include/linux/backing-dev-defs.h |  1 +
 mm/filemap.c                     | 15 +++++++++++++--
 mm/page-writeback.c              |  6 ++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..32ecc745f5f7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -432,6 +432,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
 			long nr = folio_nr_pages(folio);
 			wb_stat_mod(old_wb, WB_RECLAIMABLE, -nr);
 			wb_stat_mod(new_wb, WB_RECLAIMABLE, nr);
+			if (folio_test_dropbehind(folio)) {
+				wb_stat_mod(old_wb, WB_DONTCACHE_DIRTY, -nr);
+				wb_stat_mod(new_wb, WB_DONTCACHE_DIRTY, nr);
+			}
 		}
 	}
 
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
index 4e636647100c..179f2886f8c0 100644
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
+			long nr = folio_nr_pages(folio);
+
+			wb = unlocked_inode_to_wb_begin(inode, &cookie);
+			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
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


