Return-Path: <linux-nfs+bounces-8067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BF9D1A63
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685C2281AF0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51BB1E7C39;
	Mon, 18 Nov 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFEha+Ai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65D1E766A;
	Mon, 18 Nov 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964842; cv=none; b=lLHcKRWqT6w/0uD3FbVHXoxPmppq96Gw4OnrO9ix9qX7iCw5CKTsjGr7dI0oELP/fpXToaZDrGjyCj66C25ed8dJXDwPXw0CD+lMKUPgpCNchrrUpiHDxlB4hyHn1aeXZkEzwC/H7RT3geotbBuuUKbZD6Aw3S5Fx31ysUTZnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964842; c=relaxed/simple;
	bh=fWrSiMws6/NVSlD3rl0cBMzI6ncthjnXXVasGMSXgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Jrtd4JHenZQrdGZtuB/OZRAqljWH+Z4B5Mc9PfljT25uqcGcbYXkMqQnT4jySerKnbnAq9M/16EPMU+TU48BtCbK5kLTRP5n32D6ib6gHc965IH46Onz9IQ+8A3KDcz6orc83+lWPHbaAyJKVZAthKiZcHx9OS0y+4YjnR2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFEha+Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D137C4CED0;
	Mon, 18 Nov 2024 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964842;
	bh=fWrSiMws6/NVSlD3rl0cBMzI6ncthjnXXVasGMSXgOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFEha+AiHh1ElKMRaKbWO3c2/uv7klZ9XGzkRPfqRI4Yy1kqsGQXojI6rBPMe98hV
	 dGrdFMsBz9UfcCG/fBI2EQE1SkUj8d/V8LX18ZonbqO72UmlUP00UWiZRIv3rHxa9v
	 G77f4NcqfYWDJEOSZMJJLhCZ+EhlBP7ZkwQhJ23rmbxcZG9qlMk/jD2cnlByioygEh
	 JKzfHrJLc9gi42dvPGK1UhRQtpJi/EzzLQ+vWL3HxfnHkMNztWFVUOEMBr+15wrXAl
	 BG3nc9Yj98ZXe+cyCeK1zBl6XC8nxE+zRlcz0or3Is26R17eHwT1I6xZtKdyLst//q
	 P72IIcU7VaDwQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15.y 03/18] NFSD: Refactor nfsd_reply_cache_free_locked()
Date: Mon, 18 Nov 2024 16:20:18 -0500
Message-ID: <20241118212035.3848-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
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
2.45.2


