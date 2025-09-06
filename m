Return-Path: <linux-nfs+bounces-14106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E7B474F3
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7515A021D6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48322F74D;
	Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBiZe71T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18C1EB9E3
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757177299; cv=none; b=JV9sKoNCHrfhxE0MgTHLPPKKFbT3usvWrbRf4OLQE1Yy3+WbZSVpvJHd/0oXdOOMXtH9NkiQtgm5XjTGyHENkCjB+LF7htF9Di1KvQ7y2qI90EOUwEyNyogBXtooRVEGH0C0tO+kEFOXDxbRaLU/mGTyG2pCB5ria+G6ksIPsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757177299; c=relaxed/simple;
	bh=nKahzqIz83XaT+uPapT7Ju252SMX0ytFHAmEB6DhmoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+ZR5uSVVt5K51KMpd5e6DN3jAx37VcCltglJQL/sp4d/qo+0L2weBILttpsdgVs5xVHcBuQC93bRPiIeuhLAxs6RGeWaHGTqpiyOtxrfXHn4Or1PrnDCKRlVtoA2uwzJOm4GgwxqnBT8hVn7oIHSB/T7KGf1uEWoCaxjFU7GY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBiZe71T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD8FC4CEF7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757177298;
	bh=nKahzqIz83XaT+uPapT7Ju252SMX0ytFHAmEB6DhmoA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kBiZe71TkdOq66GFwuwq/lgYZUFNiihH0r0Y8XEYikluUJIGEesIa4I1wG8sb/gPy
	 /cDo60cuWZ04ENhPd6Lxg0q5t8FvqerAgPfey6O7XqWjVIOZzPX8x9MPEwLovkXLYu
	 O0bQ7EijLpSkEq2vkYkmE69fJ5NCwGMJ1gxd2FwCQOPPXFvZEyB1Y9gz6M/75xxAYl
	 OilzkPFlXoK2/Vp2i+qcn6JzW2esJOtcvLMJktdN0ZQpytSWqPVAyRdNzYMid/92BD
	 hhK6U1gWl8BBXakXwj/bMDS35yBf+XAUbfYXlSGJREC3b0YQ/aZR5dKsHNB0q+1iC8
	 4OW+9sBmsCkyw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/3] filemap: Add a helper for filesystems implementing dropbehind
Date: Sat,  6 Sep 2025 12:48:14 -0400
Message-ID: <ea24b487cd83da3f69f6f358d2d7a167a1dd7687.1757177140.git.trond.myklebust@hammerspace.com>
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

Add a helper to allow filesystems to attempt to free the 'dropbehind'
folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/all/5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com/
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/pagemap.h | 1 +
 mm/filemap.c            | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..201b7c6f6441 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..66cec689bec4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1608,7 +1608,7 @@ static void filemap_end_dropbehind(struct folio *folio)
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
  */
-static void filemap_end_dropbehind_write(struct folio *folio)
+void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
@@ -1625,6 +1625,7 @@ static void filemap_end_dropbehind_write(struct folio *folio)
 		folio_unlock(folio);
 	}
 }
+EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
 /**
  * folio_end_writeback - End writeback against a folio.
@@ -1660,7 +1661,7 @@ void folio_end_writeback(struct folio *folio)
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 
-	filemap_end_dropbehind_write(folio);
+	folio_end_dropbehind(folio);
 	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
-- 
2.51.0


