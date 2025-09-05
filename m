Return-Path: <linux-nfs+bounces-14087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E7B463BD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3765C3A1D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91C28137D;
	Fri,  5 Sep 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAwHASMD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBD280CC8
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100924; cv=none; b=atLG14Twsb19sMpJdkmeMy/c5NVGxeLKYunafcplkn9WSjgQYhlJRtAjBgC1xUNDJDCK5gnsdH3bh/zN9LuSmDLd31D87KH/8PQqnWENZ3hcq/4LTZ31suV2JlBQh5TKHd5QqYMvnSp0CCDeF7uXB2/ZYo9g46rT3fjkPmug0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100924; c=relaxed/simple;
	bh=PK7UwfVVXeYl3TjSc6icWEgyv+pcG8uxPjXju/Q1w7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeyzCiJAozc9yRHIbfuhUjyuqsLSqK0CWUX6V9fDlBOBWBFj/cboThZZYPRuiuhtpnV6Qi7Gm13u/gDATL43jJqljSRmLWfIShTTPHrCu63uzWq0qiPgbOd0/d7gGsxCUNPfxLQEv6nGHKVkyLCxAQLypldZpT2X/PeDWvn5Gko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAwHASMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EC4C4CEF1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100924;
	bh=PK7UwfVVXeYl3TjSc6icWEgyv+pcG8uxPjXju/Q1w7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lAwHASMDM2LPENU5Px0i06oCg2ZW5kpbGOZ9gM+3Wb3Pv56tTlTP24N9CG9qIusX8
	 5S+vZfjvCkVZzQ50us8L+LG3s+Ph3PbwZTj4DYFgToBR2Xx20eT7y09pT5BRtjGYu2
	 z0Mud17WBALu7gUKdzyNy9CScpU6l+Mng1UriruUxIiaZRsUyAUwpOVgwZwCdKGg35
	 e5y7ia7aQT+2kvdgoDZhNAWskNESa0Wurz7GtN6R3HvVGva6QHG0iNc+nNaPgdaPwn
	 7NOPXYeCzMPQXr8h0uaTtuoxl6jSYiEgm39z3KAiIXZMmKpp4iFWqBQyt2d7XX0aDd
	 IBxfX1dJCvUSw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFS: Fix the marking of the folio as up to date
Date: Fri,  5 Sep 2025 15:35:20 -0400
Message-ID: <9acf55d1551908b9bc19ec207b846af496290ef7.1757100278.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757100278.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
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


