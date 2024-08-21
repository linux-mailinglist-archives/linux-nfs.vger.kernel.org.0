Return-Path: <linux-nfs+bounces-5505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4395A086
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0CEB23546
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A31B2532;
	Wed, 21 Aug 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXv0EP3L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A1B252D;
	Wed, 21 Aug 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252180; cv=none; b=ga9F6ZIxYZO2dWKEANe2W/C+D6+kCakixa9kaBbLHsBRYLPZBPZVYjwn3bhXu45OeIp35Y200bcctyYyQLs8VP3s5G1Sj7XBA5ShzTWdrEnRgFmst4RpsfOK0Y5gOXF3LbkAnBCJTAibB50zHzrkhFNG5wlT8P44J7k6iX1vScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252180; c=relaxed/simple;
	bh=fWrSiMws6/NVSlD3rl0cBMzI6ncthjnXXVasGMSXgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoYEiSjK3B1pa2ZyO4l6po6u8anWAdLKT6TVclplDXDkn3BsxzS6KDzmpKCtXppFdCZFumH9SbdZ/ux5KCLljzLjAmSnpfUE/6RYYxIAGGcJUqn7kYpF+eW8NqjSgfOVRpr6lhHNGpATGSvp9ET6DFFacwBvP4LVQHcWZZY3FOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXv0EP3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ED5C32786;
	Wed, 21 Aug 2024 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252180;
	bh=fWrSiMws6/NVSlD3rl0cBMzI6ncthjnXXVasGMSXgOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXv0EP3L+ksT33XAjriO2ZYLEWcsGHNWj7TPe+GWdCqOzRJFMjfEFB/PA2C86kPmM
	 05VRCwATDAOXxSLJCA9duMLHSSkhiUoplZ55facn48SGX4yRgUwcMF30KuccevJ9pl
	 1im6tweShvVHY0a/S+kwddtAA/N9HMGZC5qpB2uOcAqHf7hV/aZ+pwDFQTI4EFZoze
	 M1GXNglKjOZksceFVJyOoo4XiVlqBE0mfOuNFus3H+FG5TFVZO5hmidJfPPg77OGVc
	 q8pBg2iqNeoo6nLS+od2XG4x6GSR49c6flyGTwd3BLhswGYKfxCMNYQB69AG02NZqG
	 qHArziHdono3w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 03/18] NFSD: Refactor nfsd_reply_cache_free_locked()
Date: Wed, 21 Aug 2024 10:55:33 -0400
Message-ID: <20240821145548.25700-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
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


