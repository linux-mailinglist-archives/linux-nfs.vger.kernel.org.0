Return-Path: <linux-nfs+bounces-6232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2396DE41
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7625228ADA3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C57F7FC;
	Thu,  5 Sep 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMYe9qnF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E91990DB;
	Thu,  5 Sep 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550280; cv=none; b=F34+V7RpUsC4AlcwpsKcPL2ykjYtYU/zMTXW3Sn1/eZ5cb9WY7EmQG7yxUjdO4iY0kjb2hprfwSp5OXsnTCALeElZcBEV1EutEOIAdZxH3N6LNOJJdBOoeP7EKL/QfUKM/TBnfVMV4q2gZGBe/+q9RpQtGnsQ43aUt+RyS9rJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550280; c=relaxed/simple;
	bh=z/fizEp9PMZqfGdZjHwFh/InPmnKj3rJ99lDDgiWLWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuuzRVobbS9VJe7y1GvQNKpd5oglKw13J48GMBcd21+I/FBWb6gtA+CZGRFUOInliQBdF1MbVcTLaUsTMHOhQGo8YWnYIc0DIdqoBDHvf1WlUaYETf2UiLSBpvaQXlH0s8nm9utuCOlk+V5gss52S/B+yiez26KL9CPPDUu5aZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMYe9qnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35165C4CEC9;
	Thu,  5 Sep 2024 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550279;
	bh=z/fizEp9PMZqfGdZjHwFh/InPmnKj3rJ99lDDgiWLWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMYe9qnFiBz0g5lynZMqnhrzkYmN9TPS+H/anKc7aQuBfRVGxIBeBxL7wz+xhe2Zm
	 HZ5BwqryzcXt6L3ErI8pnGK/ZB6SkCryt6Ib4GVTw7E3/mTBR8ALvZcIRjw+VFQb1P
	 W+WGSKlsAsvIzPvzRXe2H3NnsjvbsWSZCw8052cRpSFsOKKpmfipIULI3eIkO4rUfw
	 6LqwoaRhL2OoKfonAvQE7RvmBir///j9Ndk7APffiJOqfLp8IWj4c1L1Y/D9UNLobG
	 FgDm6mQ4bF167sI+FSNeDjL8MZLfHeZUPqhjpLGpHO6yv6lI+ehoeLOy4pdJbX7030
	 qV+H1+zy/lQ0w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 03/19] NFSD: Refactor nfsd_reply_cache_free_locked()
Date: Thu,  5 Sep 2024 11:30:45 -0400
Message-ID: <20240905153101.59927-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 35308e7f0fc3942edc87d9c6dc78c4a096428957 ]

To reduce contention on the bucket locks, we must avoid calling
kfree() while each bucket lock is held.

Start by refactoring nfsd_reply_cache_free_locked() into a helper
that removes an entry from the bucket (and must therefore run under
the lock) and a second helper that frees the entry (which does not
need to hold the lock).

For readability, rename the helpers nfsd_cacherep_<verb>.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: a9507f6af145 ("NFSD: Replace nfsd_prune_bucket()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 587ff31deb6e..d078366fd0f8 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -110,21 +110,33 @@ nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
 	return rp;
 }
 
-static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
-				struct nfsd_net *nn)
+static void nfsd_cacherep_free(struct svc_cacherep *rp)
 {
-	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
-		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
+	if (rp->c_type == RC_REPLBUFF)
 		kfree(rp->c_replvec.iov_base);
-	}
+	kmem_cache_free(drc_slab, rp);
+}
+
+static void
+nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
+			    struct svc_cacherep *rp)
+{
+	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base)
+		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
 		atomic_dec(&nn->num_drc_entries);
 		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
 	}
-	kmem_cache_free(drc_slab, rp);
+}
+
+static void
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+				struct nfsd_net *nn)
+{
+	nfsd_cacherep_unlink_locked(nn, b, rp);
+	nfsd_cacherep_free(rp);
 }
 
 static void
@@ -132,8 +144,9 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
-	nfsd_reply_cache_free_locked(b, rp, nn);
+	nfsd_cacherep_unlink_locked(nn, b, rp);
 	spin_unlock(&b->cache_lock);
+	nfsd_cacherep_free(rp);
 }
 
 int nfsd_drc_slab_create(void)
-- 
2.45.1


