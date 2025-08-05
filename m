Return-Path: <linux-nfs+bounces-13450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D85B1BD09
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948D018A44FA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABE2BDC24;
	Tue,  5 Aug 2025 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/qFeQGt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743D20B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436072; cv=none; b=eonhfuVCl4IWvds/tgsn7uYttPGo6GxTZ0TKP8CtEBBZP5pUkA0EbErtv7klBvkbTptVx2z+nHfv+dOEcjIFYT0vWzf1gj72kI9zh7hZLgOupUIyA2WJjl2OHJRhvRwxYJU0qMno54EMrzKsMByqbJcGc2Te6vtRC8zmxOVolws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436072; c=relaxed/simple;
	bh=RfjTIreZRs9TszA589YndPgWlkd3Lq5Ml3Yi9Zv4nVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rf+JtSlbaZ7ixLJQhMuKWgDjF7OMaOvBDcYRvkr+PCHUD/CfJ9wbt5iM47F3D/YrWUkdoXT1665KEY6VqVkfTZPkELv9fJNRqOMRhY4e43J7L3uzwC5aYFyROwApjg3avT8PrwkiEDtbblgFJRz5orLtgbZwQCfZ2ncuFZFWNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/qFeQGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A21C4CEF0;
	Tue,  5 Aug 2025 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436072;
	bh=RfjTIreZRs9TszA589YndPgWlkd3Lq5Ml3Yi9Zv4nVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/qFeQGtHPgnVUsWjaDyVH7W643qv+UyZCZe04UdvLfBNAHAeEG4ZvFW8RHqPMtTS
	 PgU1kVKuN/Jwa4bQCkWfakQ0wC9rahfENKuF464TuzbbAWQ2x0iXQ6eBcfEIJ2FIxh
	 +iT8mja/jt8/UsD0vL46c+z36DPV+B4WLZSvotsFZVxMn3uE9EiY3BidAoASFzLnaW
	 esqrk7ly3QgSz6ehoqABfP5SxS9rYwYLmDsgX8XROq1GEWyyDr0+JO/Acrtw6ynkJD
	 i65XrdRsHWKFNkfhKBriiGT51MHYPgRQGK1wxHGBh69jf8P0AsBLUFyeJfAv0uzNJh
	 bDi+Vv6qIdMdQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 03/11] NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file
Date: Tue,  5 Aug 2025 19:20:58 -0400
Message-ID: <20250805232106.8656-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use store_release_wake_up() instead of wake_up_var_locked(), because the
waiter cannot retake the nfs_uuid->lock.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Suggested-by: NeilBrown <neil@brown.name>
Link: https://lore.kernel.org/all/175262948827.2234665.1891349021754495573@noble.neil.brown.name/
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f1f1592ac1348..dd715cdb6c043 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -198,8 +198,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
 		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+		store_release_wake_up(&nfl->nfs_uuid, RCU_INITIALIZER(NULL));
 	}
 
 	/* Remove client from nn->local_clients */
-- 
2.44.0


