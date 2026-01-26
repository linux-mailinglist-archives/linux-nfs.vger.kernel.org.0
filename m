Return-Path: <linux-nfs+bounces-18512-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SgsdNErRd2mFlwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18512-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:40:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC888D2A1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D572301DAD5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0572D73BD;
	Mon, 26 Jan 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngnhoUyY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64F2D73AE
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459980; cv=none; b=iznXDVnaWftENE2y98EsMjxRy5/Z9YTLgyNTA26hESRW6QjpM1nfkR11hGclPiGER3AgJUDJDw1yPUY10i3ihd0jhAqb7M/2sDloKJjXZsioCjOA878nhxpo6Z/nHld1oM0jErGZYbeLt37UsTdF0d1pYpDN8Z3//HUdu4zRg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459980; c=relaxed/simple;
	bh=B2FrcvJMCfou6H77u6fLcgaAOVHmRfpYWhVB9YYSrlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBPtdkrI+BOTtOcPQpbNQ7FbNpT051+oAM4eqibPBGmDQrD/6cdXd5DlRCtY08UXg03GkRBgu1MOvANEPyyMOC0Z47/zoZmNY+AhrATJ7iTKfryb0Bfo4zw6VjQ0r1iFPLVGEdsFOeiwXA3iEHZPgVrpfvROfTqfzqtVr6dajTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngnhoUyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209DC2BC87;
	Mon, 26 Jan 2026 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459980;
	bh=B2FrcvJMCfou6H77u6fLcgaAOVHmRfpYWhVB9YYSrlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngnhoUyYoKA2KEpLheJjv9tN4E9+WIvX9L28n9uWMx31UlcDvz74zFdFXuIThd/pQ
	 Hnvi6MiPOvY6sreKk/yuyRWHjN/DDWtWRbuT5y6eYYhmkHCvzEJz5YZe9SgM9db1bz
	 MM7mOQEyqfGJ32ZUreO18YuXr/ZCLOIYGTK5WVFE85RPlvFY15bSCYnIZAtOocZH+9
	 PXlGB8rjEYc3QrTRqAUwACoAcu+A1GPNb3fEZRMlkxoemmVUC7HzlVEXgoM65/UXqM
	 h5IpgMr0KAwsFHPmEqwc47DIDA7MXW9/YpfsfVA8YqpirCR3CBlZvD7Q+t4nzhbfxw
	 q4rIHpKsET2yQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 01/14] NFS: Move nfs40_call_sync_ops into nfs40proc.c
Date: Mon, 26 Jan 2026 15:39:25 -0500
Message-ID: <20260126203938.450304-2-anna@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18512-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 4DC888D2A1
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

This is the first step in extracting NFS v4.0 into its own set of files
that can be disabled through Kconfig.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/Makefile    |  2 +-
 fs/nfs/nfs40.h     |  8 ++++++++
 fs/nfs/nfs40proc.c | 24 ++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h   |  6 ++++++
 fs/nfs/nfs4proc.c  | 25 +------------------------
 5 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 fs/nfs/nfs40.h
 create mode 100644 fs/nfs/nfs40proc.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 9fb2f2cac87e..937c775a04a3 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -27,7 +27,7 @@ CFLAGS_nfs4trace.o += -I$(src)
 nfsv4-y := nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o nfs4super.o nfs4file.o \
 	  delegation.o nfs4idmap.o callback.o callback_xdr.o callback_proc.o \
 	  nfs4namespace.o nfs4getroot.o nfs4client.o nfs4session.o \
-	  dns_resolve.o nfs4trace.o
+	  dns_resolve.o nfs4trace.o nfs40proc.o
 nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
new file mode 100644
index 000000000000..58a59109987a
--- /dev/null
+++ b/fs/nfs/nfs40.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_FS_NFS_NFS4_0_H
+#define __LINUX_FS_NFS_NFS4_0_H
+
+
+extern const struct rpc_call_ops nfs40_call_sync_ops;
+
+#endif /* __LINUX_FS_NFS_NFS4_0_H */
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
new file mode 100644
index 000000000000..6d27dedad055
--- /dev/null
+++ b/fs/nfs/nfs40proc.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/nfs4.h>
+#include <linux/nfs.h>
+#include <linux/sunrpc/sched.h>
+#include <linux/nfs_fs.h>
+#include "nfs4_fs.h"
+
+static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
+{
+	struct nfs4_call_sync_data *data = calldata;
+	nfs4_setup_sequence(data->seq_server->nfs_client,
+				data->seq_args, data->seq_res, task);
+}
+
+static void nfs40_call_sync_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs4_call_sync_data *data = calldata;
+	nfs4_sequence_done(task, data->seq_res);
+}
+
+const struct rpc_call_ops nfs40_call_sync_ops = {
+	.rpc_call_prepare = nfs40_call_sync_prepare,
+	.rpc_call_done = nfs40_call_sync_done,
+};
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 44cf167f65c6..1b4b32d1b0ef 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -286,6 +286,12 @@ int nfs4_replace_transport(struct nfs_server *server,
 size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr_storage *ss,
 			     size_t salen, struct net *net, int port);
 /* nfs4proc.c */
+struct nfs4_call_sync_data {
+	const struct nfs_server *seq_server;
+	struct nfs4_sequence_args *seq_args;
+	struct nfs4_sequence_res *seq_res;
+};
+
 extern int nfs4_handle_exception(struct nfs_server *, int, struct nfs4_exception *);
 extern int nfs4_async_handle_error(struct rpc_task *task,
 				   struct nfs_server *server,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 85cf577cf957..0f9494eb02e6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -67,6 +67,7 @@
 #include "nfs4idmap.h"
 #include "nfs4session.h"
 #include "fscache.h"
+#include "nfs40.h"
 #include "nfs42.h"
 
 #include "nfs4trace.h"
@@ -769,12 +770,6 @@ static void renew_lease(const struct nfs_server *server, unsigned long timestamp
 		do_renew_lease(clp, timestamp);
 }
 
-struct nfs4_call_sync_data {
-	const struct nfs_server *seq_server;
-	struct nfs4_sequence_args *seq_args;
-	struct nfs4_sequence_res *seq_res;
-};
-
 void nfs4_init_sequence(struct nfs4_sequence_args *args,
 			struct nfs4_sequence_res *res, int cache_reply,
 			int privileged)
@@ -1174,24 +1169,6 @@ int nfs4_setup_sequence(struct nfs_client *client,
 }
 EXPORT_SYMBOL_GPL(nfs4_setup_sequence);
 
-static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
-{
-	struct nfs4_call_sync_data *data = calldata;
-	nfs4_setup_sequence(data->seq_server->nfs_client,
-				data->seq_args, data->seq_res, task);
-}
-
-static void nfs40_call_sync_done(struct rpc_task *task, void *calldata)
-{
-	struct nfs4_call_sync_data *data = calldata;
-	nfs4_sequence_done(task, data->seq_res);
-}
-
-static const struct rpc_call_ops nfs40_call_sync_ops = {
-	.rpc_call_prepare = nfs40_call_sync_prepare,
-	.rpc_call_done = nfs40_call_sync_done,
-};
-
 static int nfs4_call_sync_custom(struct rpc_task_setup *task_setup)
 {
 	int ret;
-- 
2.52.0


