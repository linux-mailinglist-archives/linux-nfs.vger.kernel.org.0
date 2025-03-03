Return-Path: <linux-nfs+bounces-10429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E655DA4CA9A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524E53BECE9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C621531C8;
	Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeCSv0su"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C88229B07
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023332; cv=none; b=PV8nF2nz+qtnBW6x+YE2MRYAmJxfJMDNfyLTWSN/ZRGfrzYMs/BIIQd8qTIvKfp1NcDZh5uLq/sWpiqWWKpyoCEwSoPQuBgqHDNBoLBw8anWde5pZoKHcmWPfx8scWtlm5BaeO8EPCyglFdZ1wwND78dOCoXZbIdg9TxSa94goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023332; c=relaxed/simple;
	bh=EpKWPQzTNBw177+7i7o4nHfA55aEQaK6Lpc7ifz2b9k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k01DNgbXdktXG+6+hBSs5rwsARINlBc/nvKgtYos+97kY8jqVrq/fq0t+tdzmVNN2JsYXuMLW9YijdyudiXIGjmWFPmaE90nHq5HZ1Pc5vZmdXEDfC+tmpB/Hw5XnPNUxdjezwsGnr/fy7V40PSFsrPcL2tqZzukjESohTUFAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeCSv0su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20A6C4CEE6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023331;
	bh=EpKWPQzTNBw177+7i7o4nHfA55aEQaK6Lpc7ifz2b9k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jeCSv0suN/YfGCvYugTxCw/KDAHERWzEwQzUa4VivzVbUI07tNouaxveM/myZkZqJ
	 mSJmo6FPpns83YWNdqGVsdGJ0XOIxWEXufl34LXMQdqNEH4SdhI/w73yZm7Xjnph6u
	 hBU4PHh+KIU+4w1e0oi1xzGKUqO1LYDZDNNbpNJ0PWo2WWWoevVt2J+/ONDCXqa7mH
	 uCqBGiotvJt4HygDee8JamhA5GLIaCZNsfbrDvnSzFSYt6g/iEw4GFzJhtLk1dqE9z
	 7/UmGRlNCJ/fKZKPtpcALZffthyJqaa5AfDyVNujyUEFJ5vFqJCpGRMbS/8xHbOSTm
	 LZCWORHcPrtig==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFSv4: Don't trigger uneccessary scans for return-on-close delegations
Date: Mon,  3 Mar 2025 12:35:26 -0500
Message-ID: <045c99eddfe99f10c4c16675f7e6955a16a17810.1741023037.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741023037.git.trond.myklebust@hammerspace.com>
References: <cover.1741023037.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The amount of looping through the list of delegations is occasionally
leading to soft lockups. Avoid at least some loops by not requiring the
NFSv4 state manager to scan for delegations that are marked for
return-on-close. Instead, either mark them for immediate return (if
possible) or else leave it up to nfs4_inode_return_delegation_on_close()
to return them once the file is closed by the application.

Fixes: b757144fd77c ("NFSv4: Be less aggressive about returning delegations for open files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 4db912f56230..df77d68d9ff9 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -590,17 +590,6 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
-	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
-		struct inode *inode;
-
-		spin_lock(&delegation->lock);
-		inode = delegation->inode;
-		if (inode && list_empty(&NFS_I(inode)->open_files))
-			ret = true;
-		spin_unlock(&delegation->lock);
-	}
-	if (ret)
-		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
@@ -878,11 +867,25 @@ int nfs4_inode_make_writeable(struct inode *inode)
 	return nfs4_inode_return_delegation(inode);
 }
 
-static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
-		struct nfs_delegation *delegation)
+static void
+nfs_mark_return_if_closed_delegation(struct nfs_server *server,
+				     struct nfs_delegation *delegation)
 {
-	set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+	struct inode *inode;
+
+	if (test_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags))
+		return;
+	spin_lock(&delegation->lock);
+	inode = delegation->inode;
+	if (!inode)
+		goto out;
+	if (list_empty(&NFS_I(inode)->open_files))
+		nfs_mark_return_delegation(server, delegation);
+	else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out:
+	spin_unlock(&delegation->lock);
 }
 
 static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
-- 
2.48.1


