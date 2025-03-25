Return-Path: <linux-nfs+bounces-10878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F8A70CF9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E95175C11
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663426A08C;
	Tue, 25 Mar 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL+CWGBh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264B1E1E05
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942127; cv=none; b=fornh6LGw6KpAfV3s6S1ZsL7hI5o2tpVwjV4l3Zcep1klLIRv+ZC/MWG9aav4bpeKOevANIH0V+zNdXz5dP07JsVx3LaEwQ/S5et8Q42upR98fOWi96HsVICjnWJWMArin3kCOb2VooDt6FfAxt9cbDn8mxb0QZFhLqJlGYBduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942127; c=relaxed/simple;
	bh=K7QEDIqXlGyjS1hIhlW1Y9CwsIMrcCHqp6+rAQeHiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmrBMws1rrVUllo7Abr5INu/4J/eaZZOnEcE3bNdv/wxmHjokwessRGxMDCrxAFOW4NT3bzH9o9MCWuxjbzlvpdui8wHBN2JUsYHvcVsgG0zlMRgaDQGYGmcMjGE/21kpsXbsGvJhS7qKfo8zHPtKCJ+0jL2vV5tD8qZq8nBUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL+CWGBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D0BC4CEEE;
	Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942126;
	bh=K7QEDIqXlGyjS1hIhlW1Y9CwsIMrcCHqp6+rAQeHiUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dL+CWGBh1FeYs9kLP5+2p3/fsBIDhUmXDY+MWwcgph7vFkZT/blvxyiJ3gwPjbFy7
	 9GnfPHGw5JuWurZAeqIYKfplfNpToEzqRs5CRsQ+Yt9qxRntpE2j/PtVw0dB3YdbKO
	 zh1j3cfWpH/g2zo4DEX6X9munEzU4fDHfdMm2GOIs/OJB2fIz7Qt1oLI5n3rEN0ClV
	 HEqpY1ol74dvEcl0uZ5p/6eBSJJXLbjglqpa16/nHkQjX/iqs/TQoFRSwWY8Nru6gk
	 m0ugnrWJk7XgWx5TPmLt15WtomW41cDLFQJThFmbHwOlCPvNg54pftpagDr4ny4EKT
	 iUaZmSZ2zY5ww==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 3/6] NFS: Shut down the nfs_client only after all the superblocks
Date: Tue, 25 Mar 2025 18:35:20 -0400
Message-ID: <1cefd7cbadf0eaec5bae66e0870cdb89c7120070.1742941932.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The nfs_client manages state for all the superblocks in the
"cl_superblocks" list, so it must not be shut down until all of them are
gone.

Fixes: 7d3e26a054c8 ("NFS: Cancel all existing RPC tasks when shutdown")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/sysfs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index b30401b2c939..37cb2b776435 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 #include <linux/lockd/lockd.h>
 
+#include "internal.h"
 #include "nfs4_fs.h"
 #include "netns.h"
 #include "sysfs.h"
@@ -228,6 +229,25 @@ static void shutdown_client(struct rpc_clnt *clnt)
 	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
 }
 
+/*
+ * Shut down the nfs_client only once all the superblocks
+ * have been shut down.
+ */
+static void shutdown_nfs_client(struct nfs_client *clp)
+{
+	struct nfs_server *server;
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
+		if (!(server->flags & NFS_MOUNT_SHUTDOWN)) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+	nfs_mark_client_ready(clp, -EIO);
+	shutdown_client(clp->cl_rpcclient);
+}
+
 static ssize_t
 shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -259,7 +279,6 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	server->flags |= NFS_MOUNT_SHUTDOWN;
 	shutdown_client(server->client);
-	shutdown_client(server->nfs_client->cl_rpcclient);
 
 	if (!IS_ERR(server->client_acl))
 		shutdown_client(server->client_acl);
@@ -267,6 +286,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (server->nlm_host)
 		shutdown_client(server->nlm_host->h_rpcclnt);
 out:
+	shutdown_nfs_client(server->nfs_client);
 	return count;
 }
 
-- 
2.49.0


