Return-Path: <linux-nfs+bounces-5283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13994DE58
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E1282C6C
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84C433DD;
	Sat, 10 Aug 2024 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhQNJ241"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEF1311A3;
	Sat, 10 Aug 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320040; cv=none; b=n+Dy0il/h70iuaf5EmCh6ydWmodr5wRmHffJct/x4mMENNDCxKzryPqTKOZ7NHOI0g+HUmOPQbyVcRkk1TMzea6Nqwa2Pub+XxaivXpMXWZBhx+oWag5xl2qgYtnqo6miE+HM9yCytqCwiJjT2pWIOx4aCtmyc/0454HsCqMwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320040; c=relaxed/simple;
	bh=HjXqy8kZoyCgeag+JoPJH2/6sIrd9WEt+uua3aV19c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpQMVbEP7Q1qhCmHwzPjEzo92aFCA4x2akCPwh4fe9DrjkrHnku0ts/DAhK+Fw04b9HcjKCaJdInepUgAlwdYR4TEwzqGQcZ1yyqiKy5Z7oWymBVhDeFV9G25VV9Ph5K2ylKVlOv0QBnvOnlARV1V0EjKto+pq5iWF4PT50PUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhQNJ241; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE0BC4AF0D;
	Sat, 10 Aug 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320039;
	bh=HjXqy8kZoyCgeag+JoPJH2/6sIrd9WEt+uua3aV19c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhQNJ241Oi2WT2OtssmA2d0mu9jy+xVr5Sc/8W2+Qv5xc3TUdHHIBHSN9sRSoXp5Z
	 BkuYa1RqIykmJuekgziI5rkdTZ40NfJWmCajP1neHdeqWAzB07vh+1ustVW/8ZInfL
	 F+s9g0BGJnyrUey/0XiDfioZJfoV2i25qjdCE6SLh20UHcxIFl79+vnjPVe4llCiWx
	 SLIoH3wWoZTs5X0dtH6CqiuaZ0xTfaK1e09M4MoNde1Gfb7DjqhnuanV4xflTE+TS/
	 vuM6nts6Z6CR2y1KuYxhjl2LqosIiMDUFDmP0h71nuYii7LisQZHeXE20jYokjI41b
	 +s5IpFuk05jKw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 03/18] NFSD: Refactor nfsd_reply_cache_free_locked()
Date: Sat, 10 Aug 2024 15:59:54 -0400
Message-ID: <20240810200009.9882-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
index 2c6942e2344c..11d00b2853ff 100644
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


