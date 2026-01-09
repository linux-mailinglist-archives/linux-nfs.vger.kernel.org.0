Return-Path: <linux-nfs+bounces-17711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC4D0C329
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5843010CCF
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BA19D8BC;
	Fri,  9 Jan 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2PB3ywv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A11A285
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991276; cv=none; b=tnxMXOtcuT75ptJCVV8AjjX4hPKd5xqomZzI9VbVqQrEdC/Ed69wtgHCqTrJo3LpM3/OvXoRe4Q56iFr3jzitxevqt7oWE3VVkSEeshuGZpzKUieHeBuyxeZgb72F0OT6Vd5s5b1sPr4nx06kvhBZzUPB1xza7e+wC5Sn+I51aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991276; c=relaxed/simple;
	bh=hSX/y/RcBz2ZX0QMRyv+gbLoQ7F/ofZgbF588OMEjdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQDe9zISUQYvXfNLiFVTWw2LmEG1JU02LiOu68F9l4o/xYDnMlCdkuLecdq9tExKnrFl4+OkzoKNXzKdI+BCnhj+O8/jKvQsSa4S/3r+GcGzYmrBzA6O6prmt7jYnwHnUUP09cYjTayWpkWSXUVujwgNKN7IZj5ZPuad8BbW9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2PB3ywv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB90C4CEF1;
	Fri,  9 Jan 2026 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767991275;
	bh=hSX/y/RcBz2ZX0QMRyv+gbLoQ7F/ofZgbF588OMEjdE=;
	h=From:To:Cc:Subject:Date:From;
	b=t2PB3ywvJPzvznN0qIOV3KnM1zKRT86gjRk6ARW1N3KGm8z4q6u7QWXvHf0vqA/wZ
	 ouAxRdUYkZxzfLX08QJHy9hw4xQemypvX8m8czvndGgIblcdGrKmm0xbtwaLWm8HHu
	 nH2Vpzv0s9FzOYEtkXJzSzgaOEpw9tAR6slcD/zbnERDls7xPOt3xBozhsLDwM4xNZ
	 KUwtO2TldUAZoEzhvogCpkTDbjiQdHyh4Z9JhvK+FKpVAljbS48HsbrGyh+SJ1ahEs
	 etaAP1My9vI9/raTqvu3VqexWcZT/lnvrHvjR1paKSD/U91VodYW/ziio9tkHZQge9
	 64wi6wZs6V7og==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Don't immediately return directory delegations when disabled
Date: Fri,  9 Jan 2026 15:41:14 -0500
Message-ID: <20260109204114.390304-1-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

The function nfs_inode_evict_delegation() immediately and synchronously
returns a delegation when called. This means we can't call it from
nfs4_have_delegation(), since that function could be called under a
lock. Instead we should mark the delegation for return and let the state
manager handle it for us.

Fixes: b6d2a520f463 ("NFS: Add a module option to disable directory delegations")
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/delegation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index c9fa4c1f68fc..8a3857a49d84 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -149,7 +149,7 @@ static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
 int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
 	if (S_ISDIR(inode->i_mode) && !directory_delegations)
-		nfs_inode_evict_delegation(inode);
+		nfs4_inode_set_return_delegation_on_close(inode);
 	return nfs4_do_check_delegation(inode, type, flags, true);
 }
 
-- 
2.52.0


