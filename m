Return-Path: <linux-nfs+bounces-6770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0498C6D9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 22:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2301F25121
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC987199234;
	Tue,  1 Oct 2024 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuHcjJp9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7329A1
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814838; cv=none; b=mdSbVNXcmwzpiiyHhuzem5tCUpFJFG6Vf8aAveWO4d9VZWUHQ11MXCYc81y7e58hVNqWappCu2IwAtFmc+GwMwsaL2NsP/aElVBCexp9eItTEoYpwZ8YGj+kCZty5zd9Z08/2PCOcWE1frdB3iCSTHqC+MXHHOPDMhwJ5oCXazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814838; c=relaxed/simple;
	bh=BPN+CkXGShy37jfH6DzT5IFkdLaPG28FNAgrbfkcIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm708Qfxbw5QzPrY3xBeSbDDGGfuDDNytYLX6OGcJvr9G2qJReWqxLeTa8JPHY1SargVOtk6SGV37Aryo0NBecTWXcpHsPq/vGpsZuenLoLVoqPP4a7W5vDwoN8eJ5gZlpnEmFzeY4kzP8nKD9VuciaUGW5kbvt2lvSHrtgvfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuHcjJp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0580BC4CEC6;
	Tue,  1 Oct 2024 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727814838;
	bh=BPN+CkXGShy37jfH6DzT5IFkdLaPG28FNAgrbfkcIWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuHcjJp94USjvYMNnhumpIqYoYQJMLwX/J7cFucmWtU1cjDuurewfxbwZ7xkFFLzE
	 +3N1Ibb7jlr+Zb73Dadyqtu/HBdam7y2lpHL+Evf6vG8JTuuEtRv27uPIcrH+DmbYt
	 LJYbIHVWFwT4rsNOKU/pIlz8lwldjy29sJIyeDv0cVYzmRstxCaGAIz91InLRXLkvP
	 F4cFWdWSvkCc+2iwYzIea5nFKLo+A1R9/IqmeiX8okpUAaGYUtz/2mMMfWOlfVJTQO
	 INi8OvjBOiF4ys245kCEM4+rU2BCHumuHUN/KNXeisSJtk+O1+cAPXDRSCCXSO4c84
	 E4pmc9JZ6usMQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 1/5] NFS: Clean up locking the nfs_versions list
Date: Tue,  1 Oct 2024 16:33:40 -0400
Message-ID: <20241001203344.327044-2-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001203344.327044-1-anna@kernel.org>
References: <20241001203344.327044-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This patch replaces the nfs_version_mutex and nfs_version_lock with a
single RW lock that protects access to the nfs_versions list.

The mutex around request_module() seemed unnecessary to me, and I
couldn't find any other callers using a lock around calls to
request_module() when I looked.

At the same time, I saw fs/filesystems.c using a RW lock to protect
their filesystems list. This seems like a better idea than a spinlock to
me, so I'm also making that change while I'm here.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/client.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index a1d21c4be0ac..15340df117a7 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -55,8 +55,7 @@
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
 static DECLARE_WAIT_QUEUE_HEAD(nfs_client_active_wq);
-static DEFINE_SPINLOCK(nfs_version_lock);
-static DEFINE_MUTEX(nfs_version_mutex);
+static DEFINE_RWLOCK(nfs_version_lock);
 static LIST_HEAD(nfs_versions);
 
 /*
@@ -79,16 +78,16 @@ const struct rpc_program nfs_program = {
 static struct nfs_subversion *find_nfs_version(unsigned int version)
 {
 	struct nfs_subversion *nfs;
-	spin_lock(&nfs_version_lock);
+	read_lock(&nfs_version_lock);
 
 	list_for_each_entry(nfs, &nfs_versions, list) {
 		if (nfs->rpc_ops->version == version) {
-			spin_unlock(&nfs_version_lock);
+			read_unlock(&nfs_version_lock);
 			return nfs;
 		}
 	}
 
-	spin_unlock(&nfs_version_lock);
+	read_unlock(&nfs_version_lock);
 	return ERR_PTR(-EPROTONOSUPPORT);
 }
 
@@ -97,10 +96,8 @@ struct nfs_subversion *get_nfs_version(unsigned int version)
 	struct nfs_subversion *nfs = find_nfs_version(version);
 
 	if (IS_ERR(nfs)) {
-		mutex_lock(&nfs_version_mutex);
 		request_module("nfsv%d", version);
 		nfs = find_nfs_version(version);
-		mutex_unlock(&nfs_version_mutex);
 	}
 
 	if (!IS_ERR(nfs) && !try_module_get(nfs->owner))
@@ -115,23 +112,23 @@ void put_nfs_version(struct nfs_subversion *nfs)
 
 void register_nfs_version(struct nfs_subversion *nfs)
 {
-	spin_lock(&nfs_version_lock);
+	write_lock(&nfs_version_lock);
 
 	list_add(&nfs->list, &nfs_versions);
 	nfs_version[nfs->rpc_ops->version] = nfs->rpc_vers;
 
-	spin_unlock(&nfs_version_lock);
+	write_unlock(&nfs_version_lock);
 }
 EXPORT_SYMBOL_GPL(register_nfs_version);
 
 void unregister_nfs_version(struct nfs_subversion *nfs)
 {
-	spin_lock(&nfs_version_lock);
+	write_lock(&nfs_version_lock);
 
 	nfs_version[nfs->rpc_ops->version] = NULL;
 	list_del(&nfs->list);
 
-	spin_unlock(&nfs_version_lock);
+	write_unlock(&nfs_version_lock);
 }
 EXPORT_SYMBOL_GPL(unregister_nfs_version);
 
-- 
2.46.2


