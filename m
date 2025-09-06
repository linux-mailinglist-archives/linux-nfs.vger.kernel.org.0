Return-Path: <linux-nfs+bounces-14104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373DB474E9
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252EF1BC3E7C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D7259C9A;
	Sat,  6 Sep 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM6l2mVX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D41258EF5
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176942; cv=none; b=EI4roCzlRoGLor7jeZs0c7tvVK/4+hjZx0VzLZ3HS2CX8X1eUc6iyYLd9lOT72oUrDNQCtsrM5IGTSeXcPIoXV8r4VQVSp6S8QQ42fgp0G1VJ0Li3U+9uR4s1thq4bY2fbPhOawNdLrBCD+nL2gvw6QH20pRQZS/Sdb5wXH6KRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176942; c=relaxed/simple;
	bh=PK7UwfVVXeYl3TjSc6icWEgyv+pcG8uxPjXju/Q1w7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8m/HFxyD+cB9Xq5VzI2bskN6F24j4IzJb++0NWLYvsbHQZGSJL4b3seyCZrvIgr/bDhz6kpdq6geXvvlX/6ilirT/8bzSuYUsPImbNOHzqbriLIXFNUmfwP12S2LYLnV2/kY/E0VEJ2uSK8M8r2UgbozoMBYJyW8dbcyAJP/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM6l2mVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05DAC4CEF9
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176942;
	bh=PK7UwfVVXeYl3TjSc6icWEgyv+pcG8uxPjXju/Q1w7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PM6l2mVXJRhUsdHsS+H+GSYTAoo4Zl+tP4lCYQGq8ypGSthMJMZtyKY/+SabxqFmG
	 mxMLwNNBEcwypRvFqVn4Agf4ni2P0JIvxEi5guTJuFzHveUZknR6gU6mkCAdr/oZDB
	 WZYexTwSruQGIbtwt4KuL4lxcBtF30mRQ/u5Er2U71MzmwDXVTN0T1ZWoM0oYI1WwH
	 mN6cjPqDogwwSHoCcUzdO8FrQTVygMxu/pNV0oUXaVDF6vSFg3Z582bbDB4sLnfBK+
	 fiRvfGzBnooK0qxpR9hYXgADeX75WccyEGjptM8QcwuyTh36E/sgVeESfjOrDIz7wh
	 gpuSyI+aN+WIw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/8] NFS: Fix the marking of the folio as up to date
Date: Sat,  6 Sep 2025 12:42:16 -0400
Message-ID: <97914875050a392e384a87e02429998216749d4f.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since all callers of nfs_page_group_covers_page() have already ensured
that there is only one group member, all that is required is to check
that the entire folio contains dirty data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 52 +++++---------------------------------------------
 1 file changed, 5 insertions(+), 47 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index e359fbcdc8a0..647c53d1418a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -237,59 +237,17 @@ static void nfs_mapping_set_error(struct folio *folio, int error)
 }
 
 /*
- * nfs_page_group_search_locked
- * @head - head request of page group
- * @page_offset - offset into page
+ * nfs_page_covers_folio
+ * @req: struct nfs_page
  *
- * Search page group with head @head to find a request that contains the
- * page offset @page_offset.
- *
- * Returns a pointer to the first matching nfs request, or NULL if no
- * match is found.
- *
- * Must be called with the page group lock held
- */
-static struct nfs_page *
-nfs_page_group_search_locked(struct nfs_page *head, unsigned int page_offset)
-{
-	struct nfs_page *req;
-
-	req = head;
-	do {
-		if (page_offset >= req->wb_pgbase &&
-		    page_offset < (req->wb_pgbase + req->wb_bytes))
-			return req;
-
-		req = req->wb_this_page;
-	} while (req != head);
-
-	return NULL;
-}
-
-/*
- * nfs_page_group_covers_page
- * @head - head request of page group
- *
- * Return true if the page group with head @head covers the whole page,
- * returns false otherwise
+ * Return true if the request covers the whole folio.
+ * Note that the caller should ensure all subrequests have been joined
  */
 static bool nfs_page_group_covers_page(struct nfs_page *req)
 {
 	unsigned int len = nfs_folio_length(nfs_page_to_folio(req));
-	struct nfs_page *tmp;
-	unsigned int pos = 0;
-
-	nfs_page_group_lock(req);
 
-	for (;;) {
-		tmp = nfs_page_group_search_locked(req->wb_head, pos);
-		if (!tmp)
-			break;
-		pos = tmp->wb_pgbase + tmp->wb_bytes;
-	}
-
-	nfs_page_group_unlock(req);
-	return pos >= len;
+	return req->wb_pgbase == 0 && req->wb_bytes == len;
 }
 
 /* We can set the PG_uptodate flag if we see that a write request
-- 
2.51.0


