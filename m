Return-Path: <linux-nfs+bounces-14086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D231B463BE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1392188148C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA03280330;
	Fri,  5 Sep 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa7Pv5C4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45F27F732
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100924; cv=none; b=lo+kadP7eeUNaUG4wnLTh0ud4+1R5UDHhwTzAAdvd0ieTlfmAEnDFydwtvp9076J+YcGSLQUwBAuUnJYA7mxNd70JQfZs37taFd6p/Onz8rvA/NMnkP3QSghq11nZy73o3pfNjr3nrWtZH7JRg35k0QnJCLAdr42is3spcC8tIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100924; c=relaxed/simple;
	bh=InGWnPVVL1r+8auW3ba3qwk3An5cdaHB49BXdGBWsQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zpe97klY4RHLfjoRnOhxK7gXpNunWPYxZax3gHDGmFxXpqbdgTYC8tPayxl+5gIwdTozZ3kyJF0vs8nKMBqBlht0W+MB4tV6lKBVcJpwI4EEWju+ilq44l1bqJ5qI4QNEkG7MVhN3QBPglnf2+lLQeL4XFu7C1V15gRMpgJZ4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa7Pv5C4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB56C4CEF7
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100923;
	bh=InGWnPVVL1r+8auW3ba3qwk3An5cdaHB49BXdGBWsQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fa7Pv5C4AZy0XbmJR9nvFjYCmbLNmcS6gHp8PQXNiGrykU7v0+7qAeuHRxro84Xu2
	 an3ZbU4p4ouNtNbd6EOlEgjviMQ3r75noHMDrWk/jk0DXDeDzMjVcPeEDS4Dx3yr8Y
	 HdxA+bo8ppRmzp4XzWxoyJkcI6ZQ/hlAWDAmMWY9GFlhkQmoHweNpTUiBUspm3tbz3
	 OD82OA+IyR08NawyYOiVrcte31sZUDydJX2+iQ2fg5hiXv4M/uGTtI9y6dcw0goMx8
	 pEabLok8ymhgFE6ehKcFA4erW1S7YkFEmAhPEEp3mpE6tDJ69Tsgm4yQhREyZTvm7n
	 oqYGg45Inxo6g==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFS: nfs_invalidate_folio() must observe the offset and size arguments
Date: Fri,  5 Sep 2025 15:35:19 -0400
Message-ID: <8fe478b0d9bfcfa1bda39442d1c702d8c5a32560.1757100278.git.trond.myklebust@hammerspace.com>
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

If we're truncating part of the folio, then we need to write out the
data on the part that is not covered by the cancellation.

Fixes: d47992f86b30 ("mm: change invalidatepage prototype to accept length")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c  | 7 ++++---
 fs/nfs/write.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index af2fdbfcbbf6..7fa56af4d2cd 100644
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


