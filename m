Return-Path: <linux-nfs+bounces-18572-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CDrKC4pemlk3QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18572-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F41A3ABB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 066C33009382
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D036A01B;
	Wed, 28 Jan 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghg2xnKo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E936BCD7
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613583; cv=none; b=UQdWbphvYYVJlKOIZr749ZZ8ZmjFBREw/e/qrxb+/o/WNgO45MVBVB364gf6UNoKBpvCV60BM+YF1VYgG2YpfT9WQ6UhaMhzgDedsRgPKEcVAC9ZvBzS+FROdWjF1YO9IGlbSR8a5EaD4wIf4Qrx21mNM+rnSNWSaAZk7V5aTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613583; c=relaxed/simple;
	bh=2c0PsMx697+hGjn6DM2vui2JV+pM7+gwVfgdqB90CNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1MoUJCqdEMuonscam7Cidk8uJ+mEJ5NUZ4huM6bvVOGZZx4iStbYrrnGvf0U+i8IhuhwJP4kM5HuoVuCEPYC4GGr6ria4r3u/aNMsEQMjrv+kic1JJv13s/njtZlCB87JzSWYR3C6ggk31ozSNJQbTRAlQFsMLqbQh6YjmmOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghg2xnKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27E2C4CEF7;
	Wed, 28 Jan 2026 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613582;
	bh=2c0PsMx697+hGjn6DM2vui2JV+pM7+gwVfgdqB90CNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ghg2xnKo/5M7N+jp+ceEHLUl4CCu0dB/T0LVElgM28Bzzy+STEnMf4I9wQ7zB39Q8
	 KHYaPw5ksPGrAmFfGGrcrUSotL8f3yl19aUZbwdXuj8AwBntkj88HPatgvTLT2IANu
	 cFNJl/byWkiAMEmpxH8GHjjmcHeyXlFpDJneVooeeak4yy/wb6MREsbqE4yD8fW7hD
	 W7OOSnEdZREebs3viaZX1C1Ml3PLcyeghhSOg/fw0qWaDbxv27ejvQjGg/Jbo8gCVC
	 oilXdOLNSbOEiSDa0eV5ewZBKgH38UVqJSBk5/7fKpq+Q9Z5cGPdAKIKkanQgy20Bp
	 CMR0MUJzK6CDQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 06/14] NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM
Date: Wed, 28 Jan 2026 10:19:27 -0500
Message-ID: <20260128151935.1646063-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18572-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9F41A3ABB
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


