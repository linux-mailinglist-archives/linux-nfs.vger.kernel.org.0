Return-Path: <linux-nfs+bounces-18521-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMpxOnbRd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18521-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E778D2F9
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D1030530C4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2B2D6E7C;
	Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmVHEYoL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2B2D6E74
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459985; cv=none; b=MNRU49WrunxX4tvKtZ68YtDU9IYo/ndcUEa5zoIP+m0JINYcWJ7tBnUcgfn63Ix0nIHd6NeIRF2/b2VtpQHQfG2VtCpdOygYjQx6/SbmEIWkTWc9S8F31yPe8Q/Oqa52pIEp/GIU37Ml6IFC9CxMF3IMHw9APlWjYZb8aHCrf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459985; c=relaxed/simple;
	bh=GEIiIBhVBBrZVDJPQxxX9JqTX1zDjnYQ0P2CWSmgpvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6b/jfVimo4S8r2kkKSoO1B0mnKcL/qLH3EXr3WSy4H4s6HUlg7u5wEzBRBQq0grmgca6wFrRXqNe5mb81Y0ueBStOOnsqelkZ18se+In1I1z/bXZMmJGgUdutXJRSJ9wguy40JBtTCdJkGQzboa3iJFnaNhB3E6R1JEe+mvY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmVHEYoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAC7C2BC86;
	Mon, 26 Jan 2026 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459984;
	bh=GEIiIBhVBBrZVDJPQxxX9JqTX1zDjnYQ0P2CWSmgpvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmVHEYoLYt/Cuha2B94FvUKRVb1toTXxqIdWdSLo7/9LorUptgzEYCHGqo/bUg1RY
	 rMvgS97SbXv1yecXrufUw9nPoj9JYKAb1QrbOL3oxya3efwyivGyktIdVmxCbTNIX9
	 Cmc6DPbrj/FwfSxy9Jp6S7yP0VfspOErKQTjzq+MEPoF8zUiQChbucsbb3lCnz4jbl
	 d6Dzk7BZ5FwcqV0afWFHXT3cmP4P7kAKI+OqKVOhcDy+1lkjixj2RPZYs/jy7vKERc
	 rfhMxSQI/THmhcd0KG/3uIPtcJ5UNOOZnpfUbKdHTa41q1pyGdMOBo1TBoHB9NME6X
	 5IZaztUpS/KHA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 10/14] NFS: Move NFS v4.0 pathdown recovery into nfs40client.c
Date: Mon, 26 Jan 2026 15:39:34 -0500
Message-ID: <20260126203938.450304-11-anna@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18521-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 73E778D2F9
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h       |  1 +
 fs/nfs/nfs40client.c | 23 +++++++++++++++++++++++
 fs/nfs/nfs4state.c   | 23 +----------------------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 5a9c5d367b12..ee09aac738c8 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -6,6 +6,7 @@
 /* nfs40client.c */
 void nfs40_shutdown_client(struct nfs_client *);
 int nfs40_init_client(struct nfs_client *);
+void nfs40_handle_cb_pathdown(struct nfs_client *clp);
 
 /* nfs40proc.c */
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
index b0719403495d..0f88e7cbdc5e 100644
--- a/fs/nfs/nfs40client.c
+++ b/fs/nfs/nfs40client.c
@@ -3,6 +3,7 @@
 #include "nfs4_fs.h"
 #include "nfs4session.h"
 #include "callback.h"
+#include "delegation.h"
 #include "internal.h"
 #include "netns.h"
 #include "nfs40.h"
@@ -80,6 +81,28 @@ int nfs40_init_client(struct nfs_client *clp)
 	return 0;
 }
 
+/*
+ * nfs40_handle_cb_pathdown - return all delegations after NFS4ERR_CB_PATH_DOWN
+ * @clp: client to process
+ *
+ * Set the NFS4CLNT_LEASE_EXPIRED state in order to force a
+ * resend of the SETCLIENTID and hence re-establish the
+ * callback channel. Then return all existing delegations.
+ */
+void nfs40_handle_cb_pathdown(struct nfs_client *clp)
+{
+	set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
+	nfs_expire_all_delegations(clp);
+	dprintk("%s: handling CB_PATHDOWN recovery for server %s\n", __func__,
+			clp->cl_hostname);
+}
+
+void nfs4_schedule_path_down_recovery(struct nfs_client *clp)
+{
+	nfs40_handle_cb_pathdown(clp);
+	nfs4_schedule_state_manager(clp);
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5edc11cb2de0..1546351e76b2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -54,6 +54,7 @@
 #include <linux/sunrpc/clnt.h>
 
 #include "nfs4_fs.h"
+#include "nfs40.h"
 #include "callback.h"
 #include "delegation.h"
 #include "internal.h"
@@ -1294,28 +1295,6 @@ int nfs4_client_recover_expired_lease(struct nfs_client *clp)
 	return ret;
 }
 
-/*
- * nfs40_handle_cb_pathdown - return all delegations after NFS4ERR_CB_PATH_DOWN
- * @clp: client to process
- *
- * Set the NFS4CLNT_LEASE_EXPIRED state in order to force a
- * resend of the SETCLIENTID and hence re-establish the
- * callback channel. Then return all existing delegations.
- */
-static void nfs40_handle_cb_pathdown(struct nfs_client *clp)
-{
-	set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
-	nfs_expire_all_delegations(clp);
-	dprintk("%s: handling CB_PATHDOWN recovery for server %s\n", __func__,
-			clp->cl_hostname);
-}
-
-void nfs4_schedule_path_down_recovery(struct nfs_client *clp)
-{
-	nfs40_handle_cb_pathdown(clp);
-	nfs4_schedule_state_manager(clp);
-}
-
 static int nfs4_state_mark_reclaim_reboot(struct nfs_client *clp, struct nfs4_state *state)
 {
 
-- 
2.52.0


