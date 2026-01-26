Return-Path: <linux-nfs+bounces-18519-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNeUEG/Rd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18519-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5198D2EA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EF030500C2
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337228468E;
	Mon, 26 Jan 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me6l745H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B251DDC07
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459984; cv=none; b=k66+LWa1S7QWbLld0ZC9tu34ECAK5XtxnLpad4v11FWUgymRUDiPL/7wlXGXNcPRwgdWWfSvM/pTKlQv562gwiIvulm9fAVyrPvvprAnQ1RctevhPt/F4qRjv7Wcm0vK8TJ/iPNbIP3SEuuBH/khQQkeHMh7i/BWBg+4EQZ8N7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459984; c=relaxed/simple;
	bh=/t4/ZUNWelO5rPYPzmM41sbRWoXj0hUCQYmO3+bYpzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeCLeWMzKCEegXx5vEJmBIBcptUlf/JCa8sdQ2h0iAc/zTHcvZVmbIq1G9ctDXJbYnBzeRDsUB5ac+oyMPk9vP7ENy52pXE5Y35/JRdEkkGofQeef4wL2pXEaHTzU6OkjSTnaCX5u3NSCXHZbmNyVJl1pDX6eHmy/d0Qlcao7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me6l745H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54241C19422;
	Mon, 26 Jan 2026 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459983;
	bh=/t4/ZUNWelO5rPYPzmM41sbRWoXj0hUCQYmO3+bYpzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Me6l745HhAYhqabUKZCJp1jcu4lUu4weUQXNKVTBz/UIRSEksWucR6ybBgZ9KVKj5
	 zHZt+GQu5kR9RVlATWEcdq9c43DXaOHrKK0ruFTh8RS6B5D832Lgzw6azY4aNjGiHH
	 20OauubgqKyp6RWeuekMWaOzRS4jUAa0Uz21DAaSQrQIOW/+90bEB1Ss43KzYE6I29
	 dAGauBEsh9IvotOKOWdL2/rMo2JJgYrtIdE67UXBKHelIbQb+kVSlCAB7tM4ugNq1v
	 PsBqSZrJ7jfBWmtADZ4OlDOQuc+3GQYstubkEw82mY/KX2OyP4JbiV0WQfjqM9vA7q
	 l7Z0tsndNUTlQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 08/14] NFS: Move nfs40_shutdown_client into nfs40client.c
Date: Mon, 26 Jan 2026 15:39:32 -0500
Message-ID: <20260126203938.450304-9-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126203938.450304-1-anna@kernel.org>
References: <20260126203938.450304-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18519-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: CE5198D2EA
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h       | 3 +++
 fs/nfs/nfs40client.c | 9 +++++++++
 fs/nfs/nfs40proc.c   | 1 +
 fs/nfs/nfs4_fs.h     | 1 -
 fs/nfs/nfs4client.c  | 8 --------
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 272e1ffdb161..9369bb08825a 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -3,6 +3,9 @@
 #define __LINUX_FS_NFS_NFS4_0_H
 
 
+/* nfs40client.c */
+void nfs40_shutdown_client(struct nfs_client *);
+
 /* nfs40proc.c */
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
 
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
index bab073b6506b..8397d75a2f46 100644
--- a/fs/nfs/nfs40client.c
+++ b/fs/nfs/nfs40client.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/nfs_fs.h>
 #include "nfs4_fs.h"
+#include "nfs4session.h"
 #include "callback.h"
 #include "internal.h"
 #include "netns.h"
@@ -44,6 +45,14 @@ static bool nfs4_same_verifier(nfs4_verifier *v1, nfs4_verifier *v2)
 	return memcmp(v1->data, v2->data, sizeof(v1->data)) == 0;
 }
 
+void nfs40_shutdown_client(struct nfs_client *clp)
+{
+	if (clp->cl_slot_tbl) {
+		nfs4_shutdown_slot_table(clp->cl_slot_tbl);
+		kfree(clp->cl_slot_tbl);
+	}
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 5968a3318d14..0399e2e68c6b 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -5,6 +5,7 @@
 #include <linux/nfs_fs.h>
 #include "internal.h"
 #include "nfs4_fs.h"
+#include "nfs40.h"
 #include "nfs4trace.h"
 
 static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 333dd0774517..bfc0afb796ff 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -482,7 +482,6 @@ extern const u32 nfs4_pathconf_bitmap[3];
 extern const u32 nfs4_fsinfo_bitmap[3];
 extern const u32 nfs4_fs_locations_bitmap[3];
 
-void nfs40_shutdown_client(struct nfs_client *);
 void nfs41_shutdown_client(struct nfs_client *);
 int nfs40_init_client(struct nfs_client *);
 int nfs41_init_client(struct nfs_client *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 517cf8af2943..d83a8a2a3c70 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -189,14 +189,6 @@ void nfs41_shutdown_client(struct nfs_client *clp)
 }
 #endif	/* CONFIG_NFS_V4_1 */
 
-void nfs40_shutdown_client(struct nfs_client *clp)
-{
-	if (clp->cl_slot_tbl) {
-		nfs4_shutdown_slot_table(clp->cl_slot_tbl);
-		kfree(clp->cl_slot_tbl);
-	}
-}
-
 struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 {
 	char buf[INET6_ADDRSTRLEN + 1];
-- 
2.52.0


