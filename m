Return-Path: <linux-nfs+bounces-14103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25217B474E8
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341005849B9
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7562580CB;
	Sat,  6 Sep 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHMM+PKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A14257AC8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176942; cv=none; b=LdMURtXm2sDQu3QaJufX9rL/4+rqrZ/fpSgM0m7vpbwu5j9nTF6Ol/9LopAY+ZOKa7sVzj72KsSmTqCpedKonHd9YIDIslHymORkmHr2+gZDRhsNEnCxAHvDhEAPtZPXcNgX4HJXnJrqQCPkF4gV6VnNQ3b/e+7rksUEELfNn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176942; c=relaxed/simple;
	bh=r4ixVD6X/jPjJSHHj+Y7iYx0agpyAlvmkSAYjzDind0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxclNfRQLG2qdT02xloEdF9mZ3kF5x8qR9d8rHB+GwCfX9YNNDcu3o58Bs3x/0sRDWuIBZlsuvIAPci+oYL+joyT0aBvpOtUkI2vdluwv09qmNEU78AlMW/37n3Ft+c/Bhz9w2OWO4s9iI2KWBdcP+K96kfE74luq5fQAKEbdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHMM+PKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A7C4CEF8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176941;
	bh=r4ixVD6X/jPjJSHHj+Y7iYx0agpyAlvmkSAYjzDind0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AHMM+PKqpoU1SoIgwgwfi+v5oqiYZSzCOaYBjXDvUbjjN59jP/8ACXUl3JsUbSWVe
	 /yD26BDJbExJG/tVuriUwiG0lp2WEBqiAPPuCZiZCcnE3u4wSqlDkySvT3wk7mVfQK
	 ikja8BPwftC3mz8aKRpx2fy/oQA1SjZwvkWmUiFxVlETxgTwFxAhlHewKG9WsSU/vg
	 Wci7BHAo3QzcEpYhKlrhaz5tmzqOy4Frzk1jk3viRt4bpz9amx4aYalev3sXcfSaPn
	 kZl50IV6IJiABdemAcjwzIe2DZqXxfR717CFspKqspxRZQBKo19ohonSbh02cTqP2n
	 Wrod4EHXkowlg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/8] NFS: nfs_invalidate_folio() must observe the offset and size arguments
Date: Sat,  6 Sep 2025 12:42:15 -0400
Message-ID: <89de884eefd2874274a1e4b163ab8abe3b0da0d4.1757176392.git.trond.myklebust@hammerspace.com>
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

If we're truncating part of the folio, then we need to write out the
data on the part that is not covered by the cancellation.

Fixes: d47992f86b30 ("mm: change invalidatepage prototype to accept length")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c  | 7 ++++---
 fs/nfs/write.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index a3105f944a0e..8059ece82468 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -475,10 +475,11 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
 		 folio->index, offset, length);
 
-	if (offset != 0 || length < folio_size(folio))
-		return;
 	/* Cancel any unstarted writes on this page */
-	nfs_wb_folio_cancel(inode, folio);
+	if (offset != 0 || length < folio_size(folio))
+		nfs_wb_folio(inode, folio);
+	else
+		nfs_wb_folio_cancel(inode, folio);
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 	trace_nfs_invalidate_folio(inode, folio_pos(folio) + offset, length);
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8b7c04737967..e359fbcdc8a0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2045,6 +2045,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 		 * release it */
 		nfs_inode_remove_request(req);
 		nfs_unlock_and_release_request(req);
+		folio_cancel_dirty(folio);
 	}
 
 	return ret;
-- 
2.51.0


