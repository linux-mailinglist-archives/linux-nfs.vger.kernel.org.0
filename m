Return-Path: <linux-nfs+bounces-16547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C57C6F3EE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 314A04F88DC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDE3594F;
	Wed, 19 Nov 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Shoq26"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC59363C6E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560710; cv=none; b=mgNtEOCgtpObv5y2N/J5sDDUoCV4ATw0sZh09xkh7YSlUPtyuAvhSeYZf+5IOvup4dCjxwJwl4mbkPgLX8PySY+6vOIupDbpQIYnzWS3MZLlrAOO7rqDTjEIxAvwH0zk85GP5W2rBrOkAE9yeHA+5LXLYYi1KitwjvVRyoYXdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560710; c=relaxed/simple;
	bh=mFWmAViUrImBciBqffKt97F5kH4mfg5ZWN89A1nq3ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROmsXopI+fwjufK23gOGTlDXKkVhYUQVFsRc+plKy9V4ap6BlTwOFa09QFNz+gLhUjPgaLXDlvSufjPLqlQxrESQkbjVMYDkrmZb/03AMXcftpys/54uqP8PSE1w6GHTAF9xhBFcOTWBja2hn/8JZay/l4j2+qCrjPxq4ETllPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Shoq26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E3C4AF0D;
	Wed, 19 Nov 2025 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560710;
	bh=mFWmAViUrImBciBqffKt97F5kH4mfg5ZWN89A1nq3ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8Shoq26tpRnWcf2tOKHTdN8drqja+a4crv/RlC3A9GqOhpMipJGD2DH0l9/DE/eo
	 CxuqGJGpHQiVgRegTNiQdNEnyJiuob8NEsFQ6s5HdBprm0Z2mNqhzejbjagKYfF9yQ
	 KzgkSyc4n9OZAJF8D8KuhpxRn/3NWpqSJZvvvpPw8ggRJ7IsQHUmGBwf03Yj0+zMQM
	 y6JHOuFf67ase+uaEPkqrlAYdZM8Cx2U5D8+85b+BN/y3GKMO7r9YOQF0cjZ10ms9f
	 NBFNNmvVL3qKx5wkOrsv95TaO0Ok1VEnIPY63kh7cHSmONgl7hUF1YETf8lpUHYcGg
	 Voa6isPC+594w==
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Stoler <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_state
Date: Wed, 19 Nov 2025 08:58:26 -0500
Message-ID: <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763560328.git.trond.myklebust@hammerspace.com>
References: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org> <cover.1763560328.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the verifiers are initialised before calling
d_splice_alias() in _nfs4_open_and_get_state().

Reported-by: Michael Stoler <michael.stoler@vastdata.com>
Fixes: cf5b4059ba71 ("NFSv4: Fix races between open and dentry revalidation")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 93c6ce04332b..54595983525d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3174,18 +3174,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
 		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
 
-	dentry = opendata->dentry;
-	if (d_really_is_negative(dentry)) {
-		struct dentry *alias;
-		d_drop(dentry);
-		alias = d_splice_alias(igrab(state->inode), dentry);
-		/* d_splice_alias() can't fail here - it's a non-directory */
-		if (alias) {
-			dput(ctx->dentry);
-			ctx->dentry = dentry = alias;
-		}
-	}
-
 	switch(opendata->o_arg.claim) {
 	default:
 		break;
@@ -3196,7 +3184,20 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 			break;
 		if (opendata->o_res.delegation.type != 0)
 			dir_verifier = nfs_save_change_attribute(dir);
-		nfs_set_verifier(dentry, dir_verifier);
+	}
+	nfs_set_verifier(dentry, dir_verifier);
+
+	dentry = opendata->dentry;
+	if (d_really_is_negative(dentry)) {
+		struct dentry *alias;
+		d_drop(dentry);
+		alias = d_splice_alias(igrab(state->inode), dentry);
+		/* d_splice_alias() can't fail here - it's a non-directory */
+		if (alias) {
+			dput(ctx->dentry);
+			nfs_set_verifier(alias, dir_verifier);
+			ctx->dentry = dentry = alias;
+		}
 	}
 
 	/* Parse layoutget results before we check for access */
-- 
2.51.1


