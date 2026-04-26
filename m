Return-Path: <linux-nfs+bounces-21101-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODSKNqH97WndpgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21101-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:57:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE40469ACA
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 809EE3007A51
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C4359A91;
	Sun, 26 Apr 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpQWXeX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A3318ED2;
	Sun, 26 Apr 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204604; cv=none; b=nhBsnEqUVXH0Ay0TPr2ArtpYLQ4yJ9ZE+VPMSX84EHP1Sei49MOi1uB2aAm/FKXVaS28LHdq5NEnqn8fCupnSQHIXjuIlq6Oe6F7FBCt52raxUWOZHRlBjkH6QK8pHV+xJ01txsApQwRZfg1iroAxZMapxici526BTEs7OQA6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204604; c=relaxed/simple;
	bh=lShvPUZtkzEbs9UjOJnKGezjl/aC+9FCH6gTzp0HT98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHxJoFSe4/IZV8YRa1BeIeYZmuZNg8k1icjYLebpDFbsgj6+/Xk/ofgETKsVg/8UJ5LMbce1D9Im4BrZygl46j3DSf0ER1/dqF1HCnfCb4e2p+EE1/WLX0Zi71d7bdYz2QsvzIICEFX4Zdfr/51DpPu9xecHLEHUI4YH5v7sKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpQWXeX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE65C2BCC7;
	Sun, 26 Apr 2026 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777204604;
	bh=lShvPUZtkzEbs9UjOJnKGezjl/aC+9FCH6gTzp0HT98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CpQWXeX6Lr0IU6cU5AKbX7juxAPZ2vfsbItLZDeWUgH3Z4eJIwsM6Gc4nsVK841XD
	 RyBWlxKyKlvt89D8DbRvb9wNjA7sy9BlqhoYEWEA699T1gXPxnXdWEY9HshDvScyLr
	 /wcTEK+Eqoazk77ZQa+RFa6yhYnubfoJ9aDQ8A1CEOgvEuBg5vSqvzkTr4BIXJr/2W
	 2EcFxwBNH/w0f2VWxqpcBbDmhGn/xXCyJ8YrAWa5106JL7z7pyPw4ht1vBqq2DDWA/
	 H2DaxEwm7Og21ULSsJFM+aMPJ8XakxjLJdvLs6wOINSuWraZnuSRoEdxsb9uDZOCsn
	 vZdWnb5DHBXbw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 26 Apr 2026 07:56:07 -0400
Subject: [PATCH v3 1/4] mm: add NR_DONTCACHE_DIRTY node page counter
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-dontcache-v3-1-79eb37da9547@kernel.org>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
In-Reply-To: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lShvPUZtkzEbs9UjOJnKGezjl/aC+9FCH6gTzp0HT98=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp7f1zf9CTlq6JPeG4iiERHYH/s7/r/mpN6W0Zy
 r/eX9lzvNWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCae39cwAKCRAADmhBGVaC
 FcMUEADGRbm+5W/V/7ipFOu8wKZLLjr66aeLjuTR64OiEWQt/7Mf8tX1jqzZeYEGG7citRX3Ha6
 maC5/LmG+ZFi1yXJ6yPJydpPjVKgo1zC5iLxQSeXNs3k+zaBtKkeOTaFF+WgRUu9G/Uf2amnkhP
 0K3mbty3oitNjI9JoLjVd/r8haA/dNB9PNIJxPfyqrwXYvVcqEyik8JUda4+9VuuRrPsKray2ie
 xwlWxU696drZ0K1I3QaevnUL+sVlWI4sAjBPvDheanRzu8uRtIliQ5Go2e2SV9AtYZn72zkm5Qg
 28Ux5aoKw11unzRxBMixl4xS5b9V2481YKdsQApM3D8qnQkJa/if5XthtDh77SP4fyqn70x1N93
 GeeePY3fjn1XJVeyuntR4qgH/perFKxwC49yMpE4zjkW3FQZ7//kOFyJdhVCj7I0Vwntp7Gmslk
 bSNrxyaPW5Q0LFb45FcG61hDtT2ySjpw4L956modzI7heHQ+z6gAZ1MWTPvDxoJrVzXmcRMsZWV
 PZpkUcv9JUf968U/7dU8Tzqi6rAzIrJaSJ/E92quPKyck15bPAIDeEmGn5955nQ4elCIrl4/axE
 STdCKtcr1dcAg/WdZ18pY6dwBaoEQw83xXyZcoKbc00oGqqhKk/DRkkm9UU9czBD6OJ998hY8TT
 /Gc26l2XZkJL9tQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: EAE40469ACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21101-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add a per-node page counter that tracks the number of dirty pages with
the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE writes).

Increment the counter alongside NR_FILE_DIRTY in folio_account_dirtied()
when the folio has the dropbehind flag set, and decrement it in
folio_clear_dirty_for_io(), folio_account_cleaned(), and when a
non-DONTCACHE access clears the dropbehind flag on a dirty folio.

The counter is visible via /proc/vmstat as "nr_dontcache_dirty" and
will be used by the writeback flusher to determine how many pages to
write back when expediting writeback for IOCB_DONTCACHE writes, without
flushing the entire BDI's dirty pages.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mmzone.h | 1 +
 mm/filemap.c           | 6 +++++-
 mm/page-writeback.c    | 7 +++++++
 mm/vmstat.c            | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da5..ed9cc61c7627 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -259,6 +259,7 @@ enum node_stat_item {
 			   only modified from process context */
 	NR_FILE_PAGES,
 	NR_FILE_DIRTY,
+	NR_DONTCACHE_DIRTY,
 	NR_WRITEBACK,
 	NR_SHMEM,		/* shmem pages (included tmpfs/GEM pages) */
 	NR_SHMEM_THPS,
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..45089fde5150 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2052,8 +2052,12 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio)
 		return ERR_PTR(-ENOENT);
 	/* not an uncached lookup, clear uncached if set */
-	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
+	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE)) {
+		if (folio_test_dirty(folio))
+			lruvec_stat_mod_folio(folio, NR_DONTCACHE_DIRTY,
+					      -folio_nr_pages(folio));
 		folio_clear_dropbehind(folio);
+	}
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio_mpol);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 88cd53d4ba09..e1df93fb3e3b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2630,6 +2630,8 @@ static void folio_account_dirtied(struct folio *folio,
 		wb = inode_to_wb(inode);
 
 		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
+		if (folio_test_dropbehind(folio))
+			lruvec_stat_mod_folio(folio, NR_DONTCACHE_DIRTY, nr);
 		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
 		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
@@ -2651,6 +2653,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 	long nr = folio_nr_pages(folio);
 
 	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+	if (folio_test_dropbehind(folio))
+		lruvec_stat_mod_folio(folio, NR_DONTCACHE_DIRTY, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 	task_io_account_cancelled_write(nr * PAGE_SIZE);
@@ -2920,6 +2924,9 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		if (folio_test_clear_dirty(folio)) {
 			long nr = folio_nr_pages(folio);
 			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+			if (folio_test_dropbehind(folio))
+				lruvec_stat_mod_folio(folio,
+						NR_DONTCACHE_DIRTY, -nr);
 			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 			ret = true;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..c3e5dfadb9a5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1240,6 +1240,7 @@ const char * const vmstat_text[] = {
 	[I(NR_FILE_MAPPED)]			= "nr_mapped",
 	[I(NR_FILE_PAGES)]			= "nr_file_pages",
 	[I(NR_FILE_DIRTY)]			= "nr_dirty",
+	[I(NR_DONTCACHE_DIRTY)]			= "nr_dontcache_dirty",
 	[I(NR_WRITEBACK)]			= "nr_writeback",
 	[I(NR_SHMEM)]				= "nr_shmem",
 	[I(NR_SHMEM_THPS)]			= "nr_shmem_hugepages",

-- 
2.53.0


