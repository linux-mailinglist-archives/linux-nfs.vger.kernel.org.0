Return-Path: <linux-nfs+bounces-16008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06579C31C21
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55BE188545D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064052550A3;
	Tue,  4 Nov 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS314Sab"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D15253F13
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268809; cv=none; b=dHH+y3Qd6j0iq4qi9+W97Ps/8ClFO/QIEImTa6QqCYQ6FHaMCP+Odj1HK8Ig3qnvDEhxuGN8kFytA2XOIOCkuZnem3G6rTN8sFqNAk2LzIYJ3qUndYm1gpuhyi97Yuuq5e0PgTajRTVfTX9cNZR9jYxI4v63FV/IolTi9gCQDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268809; c=relaxed/simple;
	bh=FU4Y6R4uHud7ReVmAxXGXTCbe6Oa6StGQFVdvkXG0P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9BRGLMmMkobCaQfqB+1RESfjahq3/6NGkqUsyTMJtB+jLnA7qtw+UJAN/xlC1xtdE7rVh4hRG0LXNjcbpiS21DPNc6XAo8gm5akLr5tMTAjok87+Kb6vR6ArxZecxj6Q02FBzK/f5xqqtiinOPz0HIVRobLprvFdARJtviAeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS314Sab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8607C116B1;
	Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268809;
	bh=FU4Y6R4uHud7ReVmAxXGXTCbe6Oa6StGQFVdvkXG0P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iS314SabZ1t466fPj/EiZT019ZQa+Dk524SVTiPIOEt5ZA5igXU8494FxW6mtDIJ7
	 ykjP85fXL6+EcAZyd/krWtI5rXNtw416BrV6VBESynKXx9wbsrHvGYKVkPztNogqvx
	 01JSVKk+vdhje9JLzD/hhCuB0QPGR/JwIlclEYaMZeZdR7sf3b051yTuAHegUHWxs5
	 CzAlc/uAH4ywbGj1WeYm5ZUS+843PK6UEtFEIQwgRdATBj4BifoYIzE6+F72JknbsM
	 O5p96agtXihSzh4IL7HvDZSg98VxQbu3rBWBQJV7lmONgk/+nmoGXn+shM2cUqVPHD
	 tN4SlwqATRUHA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 5/5] NFS: Add a module option to disable directory delegations
Date: Tue,  4 Nov 2025 10:06:45 -0500
Message-ID: <20251104150645.719865-6-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104150645.719865-1-anna@kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

When this option is disabled then the client will not request directory
delegations or check if we have one during the revalidation paths.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/delegation.c | 7 +++++++
 fs/nfs/delegation.h | 2 ++
 fs/nfs/nfs4proc.c   | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index b4c192f00e94..2248e3ad089a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -30,6 +30,11 @@
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
 module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
+bool directory_delegations = true;
+module_param(directory_delegations, bool, 0644);
+MODULE_PARM_DESC(directory_delegations,
+		 "Enable the use of directory delegations, defaults to on.");
+
 static struct hlist_head *nfs_delegation_hash(struct nfs_server *server,
 		const struct nfs_fh *fhandle)
 {
@@ -143,6 +148,8 @@ static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
  */
 int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
+	if (S_ISDIR(inode->i_mode) && !directory_delegations)
+		nfs_inode_evict_delegation(inode);
 	return nfs4_do_check_delegation(inode, type, flags, true);
 }
 
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 8968f62bf438..46d866adb5c2 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -124,6 +124,8 @@ static inline int nfs_have_delegated_mtime(struct inode *inode)
 						 NFS_DELEGATION_FLAG_TIME);
 }
 
+extern bool directory_delegations;
+
 static inline void nfs_request_directory_delegation(struct inode *inode)
 {
 	if (S_ISDIR(inode->i_mode))
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fa176db362c7..33b64d000c40 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4463,6 +4463,8 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 static bool should_request_dir_deleg(struct inode *inode)
 {
+	if (!directory_delegations)
+		return false;
 	if (!inode)
 		return false;
 	if (!S_ISDIR(inode->i_mode))
-- 
2.51.2


