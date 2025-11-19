Return-Path: <linux-nfs+bounces-16548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01727C6F29C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A024F4986
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F15363C76;
	Wed, 19 Nov 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la2pGxnn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE20363C6F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560710; cv=none; b=Uh3oh/VpVj2RloS2aNcmxfNtaA0R4tTTnuR8E7P5adRIFAuF7Kg+6sVNXHXUbyl/y4bErmMOFO5oEVMY7oZJZSNXltWfyidbM6znrU+yZY9KBoNpBkNEghmOU/ezpCs60WJY2/MyPxYSuqMCRk/ujWJvwdQmqY20ZHojHpAOBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560710; c=relaxed/simple;
	bh=SA/+FHEIoOAHSAeJjDLECMwX8iGRBxPgqrkb19mp3fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW2RzP+TMnLiOQ6O1L4tKOKbaFjyfTzBDWipqyNLCpayAXyRTQYzt65tSLHtQ+3Nfs2FWOlggV2IlViCXf4YsR7BF4JQ7c6A2eLqvIaHKnnesnwNxQBQ5hmhWO4AOb46Rm+Lptw7EBocafG6/1FVR5zVu8go6OeRKR2eLpEKHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la2pGxnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D648C4CEF5;
	Wed, 19 Nov 2025 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560709;
	bh=SA/+FHEIoOAHSAeJjDLECMwX8iGRBxPgqrkb19mp3fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la2pGxnnfm/XFEZwDNiW85Lx96SRUmYbrhFz3Gm1BBOK+n5FPsXlZuiP48SGHJe2X
	 135QOALj4Squ8QPHIVHkZ7ZgergeL8Dql6hBlrIa9VTKg/UrrrnKxFtVdllL+O9u6d
	 ZY93Cz8uNwGtxJuuf7fO9l6PAiCSL4xHzBk/Jn01BF+4Lh6mw0H7b4MjRIVs2v7CwA
	 TZpw/b7Xl+HwlisGEEuKzUeyxoMZ/VR+ia1zy83E9ub9f10qi3tEn3CCeKlC5Oqxh1
	 cgA9atkkpbz324fCR7jvlo721dugJx3Iu7G873BgPHh+lk7agACgKxgAIx5+DMt7Pe
	 mOKpTzUD4j6kg==
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Stoler <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
Date: Wed, 19 Nov 2025 08:58:25 -0500
Message-ID: <518c32a1bc4f8df1a8442ee8cdfea3e2fcff20a0.1763560328.git.trond.myklebust@hammerspace.com>
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
d_splice_alias() in nfs_atomic_open().

Reported-by: Michael Stoler <michael.stoler@vastdata.com>
Fixes: 809fd143de88 ("NFSv4: Ensure nfs_atomic_open set the dentry verifier on ENOENT")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2eead7e85be5..3b8250ee0141 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2144,12 +2144,12 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
-			d_splice_alias(NULL, dentry);
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
 				dir_verifier = inode_peek_iversion_raw(dir);
 			else
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
+			d_splice_alias(NULL, dentry);
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
-- 
2.51.1


