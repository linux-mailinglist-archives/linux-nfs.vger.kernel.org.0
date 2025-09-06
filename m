Return-Path: <linux-nfs+bounces-14107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F4B474F4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940F758528C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065D143756;
	Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol0/oVKh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA525784B
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757177299; cv=none; b=JCElKLsrLCMsc6BWLF4+EOUpptoXjfVAny6XdegDIgQGogBI/wPrnkHUhJls7DA6RDABvA6VvY3YZ3KeT5mUK6Bi0iScmEJKNryfi0owkGIoZAjizyPEvz2NC5+XIJ+8XzhZJc3/8SuN3Or/phhgz2QNzNQPnh6ge/YfJxa4zVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757177299; c=relaxed/simple;
	bh=xUQBKYzzjC0nxS0cqJlNL8bOn1he6gYcCH5JnBuH2oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9JVMRYDkrRTrmk3tGjcCEo0V6fNdibDai1uyfBrTumTq7UAIZHirMIar4Hr7T/RRbSM+X3YV9V+V+2GEfGvQwjxXjJRaWRRQdoG1Iq80df2JafnsJ9/MsRgrJ8J9T84ecqbMTLNmPDccqgvVCSPSG9Vlkavg380050gMC93Ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol0/oVKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A45C4CEE7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757177299;
	bh=xUQBKYzzjC0nxS0cqJlNL8bOn1he6gYcCH5JnBuH2oY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ol0/oVKhqNh0CzwQWraHP2lBiYBq4fAFiXyXpE8xZEbR7NykWrxytp9VNGdP3WE/N
	 miwwyrIVhekub1RT8bH+apaBJKIXl7no+SWKA0E4swaUSeMPKKfn4guZ5fQkk9niXP
	 JRfAvfV23ptAXJ2qnMA8lWvDW4k8i61ZuwJFvHjllh5JdGuZTi0NDIXuvhZkAMVt65
	 LUM2Nv7JUqJwkffUENkXpyvwzCqTgVikajt9lmXMCx1WA8+L+dUTwoRE9PzgEFxtbG
	 L3wss5qY9dAGTdj1LXZUnomPqCVcsXKn32LpP1+FRnutKhh/WoWpNa1Vy72Q3lfaqx
	 UR2TKVHJJ97Ng==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v5 2/3] filemap: Add a version of folio_end_writeback that ignores dropbehind
Date: Sat,  6 Sep 2025 12:48:15 -0400
Message-ID: <dd70f28822299dd60cdd9b70e606a144724813d3.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757177140.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com> <cover.1757177140.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Filesystems such as NFS may need to defer dropbehind until after their
2-stage writes are done. This adds a helper
folio_end_writeback_no_dropbehind() that allows them to release the
writeback flag without immediately dropping the folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 201b7c6f6441..5b26465358ce 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
diff --git a/mm/filemap.c b/mm/filemap.c
index 66cec689bec4..d12bbb4c9d8a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1628,14 +1628,15 @@ void folio_end_dropbehind(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
 /**
- * folio_end_writeback - End writeback against a folio.
+ * folio_end_writeback_no_dropbehind - End writeback against a folio.
  * @folio: The folio.
  *
  * The folio must actually be under writeback.
+ * This call is intended for filesystems that need to defer dropbehind.
  *
  * Context: May be called from process or interrupt context.
  */
-void folio_end_writeback(struct folio *folio)
+void folio_end_writeback_no_dropbehind(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
@@ -1651,6 +1652,25 @@ void folio_end_writeback(struct folio *folio)
 		folio_rotate_reclaimable(folio);
 	}
 
+	if (__folio_end_writeback(folio))
+		folio_wake_bit(folio, PG_writeback);
+
+	acct_reclaim_writeback(folio);
+}
+EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehind);
+
+/**
+ * folio_end_writeback - End writeback against a folio.
+ * @folio: The folio.
+ *
+ * The folio must actually be under writeback.
+ *
+ * Context: May be called from process or interrupt context.
+ */
+void folio_end_writeback(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
+
 	/*
 	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
@@ -1658,11 +1678,8 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (__folio_end_writeback(folio))
-		folio_wake_bit(folio, PG_writeback);
-
+	folio_end_writeback_no_dropbehind(folio);
 	folio_end_dropbehind(folio);
-	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.51.0


