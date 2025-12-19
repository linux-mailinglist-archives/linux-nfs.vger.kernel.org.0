Return-Path: <linux-nfs+bounces-17245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F5CD1BAB
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 21:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C0C1308F15D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656633F362;
	Fri, 19 Dec 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf5oHeWD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EB32A3C3
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175226; cv=none; b=twMw/rIlPK+EYuQBjg14cYmWV+F28kNYQFxE1nqmFB7Va0vJJ34pNBL/V6bpmvtAjEfEjMSH8jc0SPPdsRmGPVB7MBwHSylULypD6Fg4N4bceg2Sj7a0zfI8tqkcHj2zn8RBJuIHDylk2kmKQM+cEccNAzCUhx/HM2JWVhcgtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175226; c=relaxed/simple;
	bh=mjM2shdJxcodvTrZ+OrNqVdAvVgILMspwSUHCDUqCrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTZk3AiGi3vU+xNMKbTUTZ2imBRp0zo+WL1IExFsBWyirBgfN7rJOAf0+mR0TToPnl32s76nL2qTPTJHbhLf3z9x0UZrla+7/iyO6kH9NS7pnihopMwibIfmK4mwUq6ctbmtn1/6wtyMzCt37lNanyNlVNpRR4dkhFrId7+U0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf5oHeWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95550C116D0;
	Fri, 19 Dec 2025 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175225;
	bh=mjM2shdJxcodvTrZ+OrNqVdAvVgILMspwSUHCDUqCrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Jf5oHeWDAwHf49UI6dvnYfIz49l0b4p7RgW/42X7Bit8AOo1Iv9S3WIbR6ySdO5l6
	 UbU4CyFHCvJQTX1+SlL9nS+ffazTHAJO/B9Wi1DmByweHEmJkYhxQaWMIV9D2+rHe4
	 PLhRe+OVeOl0FxoHqlraMbUrurOjAAgj1XP5sGeXG5AsIlviZt3cfnECQWOBWlL6vj
	 zI8P040LQtOGWrfr9oPZu3G0+8jxPECy5k+nl1F4mNI07bX53peFx5NA1NHrKfeV98
	 E6IQO/8sIffFQOop6i1ySOZyMU/51hFcwdsNQ3EGLGHQ8gZbeh6cTMf+Ss79IS2gAw
	 HHAWSQcla5lOA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Fix directory delegation verifier checks
Date: Fri, 19 Dec 2025 15:13:44 -0500
Message-ID: <20251219201344.380279-1-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Doing this check in nfs_check_verifier() resulted in many, many more
lookups on the wire when running Christoph's delegation benchmarking
script. After some experimentation, I found that we can treat directory
delegations exactly the same as having a delegated verifier when we
reach nfs4_lookup_revalidate() for the best performance.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK")
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/dir.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 23a78a742b61..c0e9d5a45cd0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1516,14 +1516,6 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
 
-	/*
-	 * If we have a directory delegation then we don't need to revalidate
-	 * the directory. The delegation will either get recalled or we will
-	 * receive a notification when it changes.
-	 */
-	if (nfs_have_directory_delegation(dir))
-		return 0;
-
 	/* Revalidate nfsi->cache_change_attribute before we declare a match */
 	if (nfs_mapping_need_revalidate_inode(dir)) {
 		if (rcu_walk)
@@ -2216,13 +2208,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
 
-static int
-nfs_lookup_revalidate_delegated_parent(struct inode *dir, struct dentry *dentry,
-				       struct inode *inode)
-{
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
-}
-
 static int
 nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 		       struct dentry *dentry, unsigned int flags)
@@ -2247,12 +2232,10 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	if (inode == NULL)
 		goto full_reval;
 
-	if (nfs_verifier_is_delegated(dentry))
+	if (nfs_verifier_is_delegated(dentry) ||
+	    nfs_have_directory_delegation(inode))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
 
-	if (nfs_have_directory_delegation(dir))
-		return nfs_lookup_revalidate_delegated_parent(dir, dentry, inode);
-
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto full_reval;
-- 
2.52.0


