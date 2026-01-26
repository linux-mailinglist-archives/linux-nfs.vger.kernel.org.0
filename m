Return-Path: <linux-nfs+bounces-18499-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJA0OM7Gd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18499-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816948CCFA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DF83028EF2
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63E28A72F;
	Mon, 26 Jan 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE4MwLlu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69765288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457343; cv=none; b=bjP8EtiwbZaInyFNHEWpSGBYCWdtEknUxE4lq9h5vToIPhYd94ceTOaaJAarHzGChqZYP7BGVVe6vXvx4A0XtCnS3gnBCHZsMEdanQmWEaTwLu33DotBndqzLlzWz3fnXyR0vb2FNoYciyGQIkX0PcgR//C8TwTqBcD6ypPcdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457343; c=relaxed/simple;
	bh=2c0PsMx697+hGjn6DM2vui2JV+pM7+gwVfgdqB90CNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLfX/XR92PuMCJ51B+bz5DyzEHMqHPmQ230Ecr230QfQhRTem8zVx0Ve1GOgww1hqSDPuG22+8sxn/LvNO4bnBMyPidpFOBx2w4q+hhZ17XvBxYPUtxKaOexDQi/Un/x2yQn5p9HPFvsCNNLXNfR8xpwllXQpk9hzhRQWRmwVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE4MwLlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF50C116C6;
	Mon, 26 Jan 2026 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457343;
	bh=2c0PsMx697+hGjn6DM2vui2JV+pM7+gwVfgdqB90CNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE4MwLluoeCvb/NZChkRVmYYjdYHHIbfSgBkyikCqZjO+uoR9T7FJXQWLx4R3EwzR
	 DXeaUSOA7qz4nsXkYAdO/U/W7sgN0ksyN/fh+b8YarF5o1DgsCw0RB5SSC+3owEETh
	 F5/8a7rYYgh3mSqFfZmvHaYYxTkw3wrDC3W394PMhr5K9Ugbh7nqVP4Pu58v2mYpGW
	 TDQvupX2e1l+/j/1w3/m7UxzQhGaG+1azrpyR2divI2IsO7nYLc9yPd6TKoEqedQJ9
	 O3fff0yFoXUse8FUwhrkWHXTOoUW/QS+QR7QIDqaIL+NQs0HuV9v2gyta/Qelmo4IP
	 GHjfFNSteuK4g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 06/14] NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM
Date: Mon, 26 Jan 2026 14:55:27 -0500
Message-ID: <20260126195535.154697-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18499-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 816948CCFA
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

A race condition exists in shutdown_store() when writing to the sysfs
"shutdown" file concurrently with nlm_shutdown_hosts_net(). Without
synchronization, the following sequence can occur:

  1. shutdown_store() reads server->nlm_host (non-NULL)
  2. nlm_shutdown_hosts_net() acquires nlm_host_mutex, calls
     rpc_shutdown_client(), sets h_rpcclnt to NULL, and potentially
     frees the host via nlm_gc_hosts()
  3. shutdown_store() dereferences the now-stale or freed host

Introduce nlmclnt_shutdown_rpc_clnt(), which acquires nlm_host_mutex
before accessing h_rpcclnt. This synchronizes with
nlm_shutdown_hosts_net() and ensures the rpc_clnt pointer remains
valid during the shutdown operation.

This change also improves API layering: NFS client code no longer
needs to include the internal lockd header to access nlm_host fields.
The new helper resides in bind.h alongside other public lockd
interfaces.

Reported-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/host.c            | 29 +++++++++++++++++++++++++++++
 fs/nfs/sysfs.c             |  4 ++--
 include/linux/lockd/bind.h |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 5e6877c37f73..87c88a8f9902 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -306,6 +306,35 @@ void nlmclnt_release_host(struct nlm_host *host)
 	}
 }
 
+/* Callback for rpc_cancel_tasks() - matches all tasks for cancellation */
+static bool nlmclnt_match_all(const struct rpc_task *task, const void *data)
+{
+	return true;
+}
+
+/**
+ * nlmclnt_shutdown_rpc_clnt - safely shut down NLM client RPC operations
+ * @host: nlm_host to shut down
+ *
+ * Cancels outstanding RPC tasks and marks the client as shut down.
+ * Synchronizes with nlmclnt_release_host() via nlm_host_mutex to prevent
+ * races between shutdown and host destruction. Safe to call if h_rpcclnt
+ * is NULL or already shut down.
+ */
+void nlmclnt_shutdown_rpc_clnt(struct nlm_host *host)
+{
+	struct rpc_clnt *clnt;
+
+	mutex_lock(&nlm_host_mutex);
+	clnt = host->h_rpcclnt;
+	if (clnt) {
+		clnt->cl_shutdown = 1;
+		rpc_cancel_tasks(clnt, -EIO, nlmclnt_match_all, NULL);
+	}
+	mutex_unlock(&nlm_host_mutex);
+}
+EXPORT_SYMBOL_GPL(nlmclnt_shutdown_rpc_clnt);
+
 /**
  * nlmsvc_lookup_host - Find an NLM host handle matching a remote client
  * @rqstp: incoming NLM request
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index ea6e6168092b..008b3decde24 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -12,7 +12,7 @@
 #include <linux/string.h>
 #include <linux/nfs_fs.h>
 #include <linux/rcupdate.h>
-#include <linux/lockd/lockd.h>
+#include <linux/lockd/bind.h>
 
 #include "internal.h"
 #include "nfs4_fs.h"
@@ -285,7 +285,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		shutdown_client(server->client_acl);
 
 	if (server->nlm_host)
-		shutdown_client(server->nlm_host->h_rpcclnt);
+		nlmclnt_shutdown_rpc_clnt(server->nlm_host);
 out:
 	shutdown_nfs_client(server->nfs_client);
 	return count;
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 82eca0a13ccc..39c124dcb19c 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -57,6 +57,7 @@ struct nlmclnt_initdata {
 extern struct nlm_host *nlmclnt_init(const struct nlmclnt_initdata *nlm_init);
 extern void	nlmclnt_done(struct nlm_host *host);
 extern struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host);
+extern void	nlmclnt_shutdown_rpc_clnt(struct nlm_host *host);
 
 /*
  * NLM client operations provide a means to modify RPC processing of NLM
-- 
2.52.0


