Return-Path: <linux-nfs+bounces-10172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D5A3A189
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16C43AED4F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E026E142;
	Tue, 18 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtRk5xnB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745126D5CC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893185; cv=none; b=TnXp3lTHNbdE/g8thi2hz03K8L0bwtgKfjrtc4k2qdxlDw2kD8Jh7ePxRr93C4WZCwAOByOydZocf2BwkxQk4RxPEjg4djdKUW7mZu/SYNek7jCxDWsIHLsRU0tR+MXGBtA3Eo7mhI7J+hV572lixPq+GjlbWtMVBwiRf7q4og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893185; c=relaxed/simple;
	bh=1k2PgSxTzE2sJtExkePSUbe2IWZcR1pB82e08Xr8iSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmpMxBfF0mgCnhLZkWkfluWWfW1G5yXO9Svbr+tv/gE8XYCs0f2fLzjCvJAPyjxHRD/jRrZ677l8x4hTyvru4lfiwVNpjH1CCDNmUSEZGDWS8xkXqZgcy7wMFoRzD068ZZcGr9otojVc6h/rQt5GXshsmWEp9bbjc/tVqHdMack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtRk5xnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C668AC4CEE2;
	Tue, 18 Feb 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893184;
	bh=1k2PgSxTzE2sJtExkePSUbe2IWZcR1pB82e08Xr8iSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtRk5xnBtWBBfrzspWhA8xedoj1iyiHTRPnzGYk+Fc4vmTdlJiMsiF9Mbda/tvpvT
	 Tuk1HyGmRW5zDZdRUBKygsb3CfjRPlkaQkGFr1d72tD4Xy2uL9XbBixtKsZVlAiwNf
	 FDBmP3cOlPwn1JJg5XJRZTqSUhOZ6/cvtVlML+T4YIf0EDOGNZ3C5P4rvnlcITFk6N
	 ianyCacg3pYDa/GESDZXCCDjpBqhSOr0J+mPqL6Xi75PmXDEBFmqpToBZphrV3a2Q3
	 A3XYdoMRftmUA+FxEyle1UgX9lwxcZmrU6GRvMQknAu0jLEegrHsYjVcjEs2cPl393
	 zA5jLObHyki3w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 4/7] nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
Date: Tue, 18 Feb 2025 10:39:34 -0500
Message-ID: <20250218153937.6125-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

list_lru_walk() is only useful when the aim is to remove all elements
from the list_lru.  It will repeatedly visit rotated elements of the
first per-node sublist before proceeding to subsequent sublists.

This patch changes nfsd_file_gc() to use list_lru_walk_node() and
list_lru_count_node() on each NUMA node.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 143b5993a437..747929c8c0d5 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -537,11 +537,16 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 static void
 nfsd_file_gc(void)
 {
+	unsigned long ret = 0;
 	LIST_HEAD(dispose);
-	unsigned long ret;
+	int nid;
 
-	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
-			    &dispose, list_lru_count(&nfsd_file_lru));
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
+
+		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
+					  &dispose, &nr);
+	}
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 }
-- 
2.47.0


