Return-Path: <linux-nfs+bounces-20754-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC0QOzZm1mnIEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20754-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:29:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E43BDA7A
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE4E3024A74
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6333D3CF3;
	Wed,  8 Apr 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8w13Z7t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EE335063;
	Wed,  8 Apr 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658340; cv=none; b=XgpcfCBgE/iWbNldUT/ucUHGqUds8/N4YIbE/RacTMGjDRPw1c4NfdqHJvQC9A4xzfjps5w4qzMZqp/Pp26Qb8HMNLNsi/gI2l9DRXeizf/T0i5Z1y2LUY3ff0XQvUp4B5hlEChDHR3HIb6Rsv9zDPrEgEUGw2JKmAZbyhBPdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658340; c=relaxed/simple;
	bh=qp5bMkCPIicW0vAK3EBrW1A8yDhhLZgvKi1mDE1KQ+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XG7uDAkccdl5GopxoHV4kTo3x4IaD/AamTD2DURn87yMiR8+8UHyy9bHTmRIUPLvU7LD3Fbv7NSz8Fp1YWxPjOGGM+tT8Gkz80jn4A855vjfjIcjUSu8dqfNSPQqZNj8oeeMMkVBd5BlEWhOZYIdoWAIc/U+fS23GuOiHXC5fsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8w13Z7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ED3C2BC87;
	Wed,  8 Apr 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658339;
	bh=qp5bMkCPIicW0vAK3EBrW1A8yDhhLZgvKi1mDE1KQ+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E8w13Z7tZwKG3xeGLv3x0jmBMpYPL3PfUJqgccOnYQntg7oRsXpq3Q1t78OijpZ8b
	 Ca8VucyWJXLtN7bk4oIHrtfk1nRiMy98z76ztseABwbrI7VWqgx63gVuvok3Fq6UAS
	 DpizIlGIwsbCGhgG9ocHvr1kt1MH8Nf/byIxoAqN0Ee1H8bAIPjZQxuDBEPb0haUJl
	 3dsxEMFie5LIacV5bRYEGGQIkNQ1FiFaNqnPvEcDQz2X4ZaTtAHxJQKRRHDYXQhe6G
	 2RDmzAlJGv1Pe0gZrA0kz9Q7mO/7LI87CS6hFgOnvH623sNqHPMw7nzjYqCOHM7pHJ
	 mUpzFxnthSzbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Apr 2026 10:25:21 -0400
Subject: [PATCH v2 1/3] mm: kick writeback flusher instead of inline flush
 for IOCB_DONTCACHE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
In-Reply-To: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qp5bMkCPIicW0vAK3EBrW1A8yDhhLZgvKi1mDE1KQ+Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1mVfpEPxZ1DKFWwnUBWNtGPYod8zrgho1SpyC
 EpBrB6x/oSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadZlXwAKCRAADmhBGVaC
 FSd8D/97DxdSGpMqJRUTtYA7ZwjJxYqUSrSZuP3a8ITeFMIlQhUU4vnFN5vV4/z0DgAtoFwkzfk
 l4wCk29KBgfa+nrGhWlO0ndZakYnqFP61L30vVSn0QAJm95TsuAUmkRFup1B9Vbstw1QCKcOzez
 XeD9UU8gs1Ft0afeuZz05T/U5ymF24ZwN3oWIYcbPYsTLDzUnrCE7ahsvfdmJKH4Tt+G+kBr2EO
 4YYYx02yAdnDP3z/65GpIdtVZVBxqcDWeXI6sn23BmopzDhHUCokatLqoM5GIVBC1oV3iQMQ2zE
 hmXMKtyjMzb1nJsWhfIXTs0yrUUdAn5EfNv0WJqTM9ZWor42LccpyfZHRhC0k02VAGMJAvTqhVl
 4enQn4c2S9N6AwN3T8NFUAfIM9qViPK7Q+0dT5/0ar89P8Gzy42+znK8sJNrJPCbPKG9C0KUtPa
 eFFZmxvf6wf3iwF4UjdDRUh146QSctEy/n2/XFgQiZNfljJY1XW4/W5A8oblTi+kabmotpvFq2n
 qEoa/KM/JEouKtbdVk4MVpGZUWcgcpXS4mj35GjFdVgXiI+bFHZIEl7S+myQl92xTltbvuIAail
 26L0w0byo+141FgqyUgqvaKDfd7JFVOq6HQEECkzU1lKZ4zj57E/tEUFd9iDLbF0QcBHCKiLQvN
 0EIWx1aXzxLNVOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20754-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736E43BDA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IOCB_DONTCACHE writeback path in generic_write_sync() calls
filemap_flush_range() on every write, submitting writeback inline in
the writer's context.  Perf lock contention profiling shows the
performance problem is not lock contention but the writeback submission
work itself — walking the page tree and submitting I/O blocks the
writer for milliseconds, inflating p99.9 latency from 23ms (buffered)
to 93ms (dontcache).

Replace the inline filemap_flush_range() call with a
wakeup_flusher_threads_bdi() call that kicks the BDI's flusher thread
to drain dirty pages in the background.  This moves writeback
submission completely off the writer's hot path.  The flusher thread
handles writeback asynchronously, naturally coalescing and rate-limiting
I/O without any explicit skip-if-busy or dirty pressure checks.

Add WB_REASON_DONTCACHE as a new writeback reason for tracing
visibility.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fs-writeback.c                | 14 ++++++++++++++
 include/linux/backing-dev-defs.h |  1 +
 include/linux/fs.h               |  6 ++----
 include/trace/events/writeback.h |  3 ++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3c75ee025bda..88dc31388a31 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2466,6 +2466,20 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	rcu_read_unlock();
 }
 
+/**
+ * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
+ * @mapping:	address_space that was just written to
+ *
+ * Wake the BDI flusher thread to start writeback of dirty pages in the
+ * background.
+ */
+void filemap_dontcache_kick_writeback(struct address_space *mapping)
+{
+	wakeup_flusher_threads_bdi(inode_to_bdi(mapping->host),
+				   WB_REASON_DONTCACHE);
+}
+EXPORT_SYMBOL(filemap_dontcache_kick_writeback);
+
 /*
  * Wakeup the flusher threads to start writeback of all currently dirty pages
  */
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c88fd4d37d1f..4a81c90a8928 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -55,6 +55,7 @@ enum wb_reason {
 	 */
 	WB_REASON_FORKER_THREAD,
 	WB_REASON_FOREIGN_FLUSH,
+	WB_REASON_DONTCACHE,
 
 	WB_REASON_MAX,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..2fd36608ac73 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2610,6 +2610,7 @@ extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
 int filemap_flush_range(struct address_space *mapping, loff_t start,
 		loff_t end);
+void filemap_dontcache_kick_writeback(struct address_space *mapping);
 
 static inline int file_write_and_wait(struct file *file)
 {
@@ -2643,10 +2644,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 		if (ret)
 			return ret;
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
-		struct address_space *mapping = iocb->ki_filp->f_mapping;
-
-		filemap_flush_range(mapping, iocb->ki_pos - count,
-				iocb->ki_pos - 1);
+		filemap_dontcache_kick_writeback(iocb->ki_filp->f_mapping);
 	}
 
 	return count;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 4d3d8c8f3a1b..9727af542699 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -44,7 +44,8 @@
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
 	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
-	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
+	EM( WB_REASON_FOREIGN_FLUSH,		"foreign_flush")	\
+	EMe(WB_REASON_DONTCACHE,		"dontcache")
 
 WB_WORK_REASON
 

-- 
2.53.0


