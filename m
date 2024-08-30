Return-Path: <linux-nfs+bounces-6024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0B96554E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD610B22FBF
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F93380;
	Fri, 30 Aug 2024 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gz5+juHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8UtUZDo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gz5+juHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8UtUZDo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B02C18C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985546; cv=none; b=F/P7hQqkIpI7HF4PoD8RlUSrMadpeJm2mlgfRr64PziN9ym10ZEkK7XVbsVbyBE2FWxWgnyYnHmmZWITSOnxAhUeWZQpizD+3neyGgB6159JEyOC3waWJyQq77CV2e6TZfHH24Wu5V9pcM672rcUCQo//heqzCpSd+zX8VWiaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985546; c=relaxed/simple;
	bh=7B48hc0EycFcZF4I3bj8DltkfzXZBBgNth+o7Qr7AOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN6IzS0wveSUFjObzEXEAyFUX3Eg7cJSL/r/x1DWPRP2vTppbV/WdcR2Co1rnk3OJ4mp1ixZkOvdtShRGBLhWwJ7WB2R7N4BNvpMaJdYjsxn/TZeljipc9Y5WgOYxe7fNGOWJM2yhxJXGRcusotv9OMY2mMA4PBANQ2ors0AWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gz5+juHE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8UtUZDo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gz5+juHE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8UtUZDo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53AEA219F0;
	Fri, 30 Aug 2024 02:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frSftmE8tk4SPvBHtWtYJJIy7qxU+Rs5xCVx8ks19yg=;
	b=gz5+juHE3OiyJlmg7vUzVQj9pN2eVUP9R2zwrMY5Imp2CqMsMY1SauAcSeJFJWMOiIFvlu
	VroYavumeSp6w0N1b4DaYFa0FDAgQIJwEaHGhmPWrlu96o5GLlq3+dRKpxbbjClKK7OCHX
	8qMArhLkMq7/5mihAFnjszjt9JD3XCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frSftmE8tk4SPvBHtWtYJJIy7qxU+Rs5xCVx8ks19yg=;
	b=A8UtUZDoan9Bida++PPkGPh6gnu88g1UI2QoxUSYkwpJvqaQLrK5FMZGxezCa80G/wS+t0
	6TxVGyzmT3uz84Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frSftmE8tk4SPvBHtWtYJJIy7qxU+Rs5xCVx8ks19yg=;
	b=gz5+juHE3OiyJlmg7vUzVQj9pN2eVUP9R2zwrMY5Imp2CqMsMY1SauAcSeJFJWMOiIFvlu
	VroYavumeSp6w0N1b4DaYFa0FDAgQIJwEaHGhmPWrlu96o5GLlq3+dRKpxbbjClKK7OCHX
	8qMArhLkMq7/5mihAFnjszjt9JD3XCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frSftmE8tk4SPvBHtWtYJJIy7qxU+Rs5xCVx8ks19yg=;
	b=A8UtUZDoan9Bida++PPkGPh6gnu88g1UI2QoxUSYkwpJvqaQLrK5FMZGxezCa80G/wS+t0
	6TxVGyzmT3uz84Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD1E136A4;
	Fri, 30 Aug 2024 02:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 36W3HMQw0WbRFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:00 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 14/25] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Fri, 30 Aug 2024 12:20:27 +1000
Message-ID: <20240830023531.29421-15-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Mike Snitzer <snitzer@kernel.org>

fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS client
to generate a nonce (single-use UUID) and associated nfs_uuid_t struct,
register it with nfs_common for subsequent lookup and verification by
the NFS server and if matched the NFS server populates members in the
nfs_uuid_t struct.

When the server populates the structure, it is moved onto a private list
allowing the server to invalidate the ->net pointer when the name space
is shut down.  A maybe_get_net() call under rcu_read_lock() can be used
to stablish the net pointer active use.

nfs_common's nfs_uuids list is the basis for localio enablement, as
such it has members that point to nfsd memory for direct use by the
client (e.g. 'net' is the server's network namespace, through it the
client can access nn->nfsd_serv with proper rcu read access).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/Makefile     |   3 ++
 fs/nfs_common/nfslocalio.c | 108 +++++++++++++++++++++++++++++++++++++
 include/linux/nfslocalio.h |  34 ++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index e58b01bb8dda..a5e54809701e 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
+nfs_localio-objs := nfslocalio.o
+
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
new file mode 100644
index 000000000000..f78cf99e2547
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+#include <net/netns/generic.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS localio protocol bypass support");
+
+static DEFINE_SPINLOCK(nfs_uuid_lock);
+
+/*
+ * Global list of nfs_uuid_t instances, add/remove
+ * is protected by nfs_uuid_lock.
+ * Reads are protected by RCU read lock (see below).
+ */
+LIST_HEAD(nfs_uuids);
+
+void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+{
+	nfs_uuid->net = NULL;
+	nfs_uuid->dom = NULL;
+	uuid_gen(&nfs_uuid->uuid);
+
+	spin_lock(&nfs_uuid_lock);
+	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_begin);
+
+void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net == NULL) {
+		spin_lock(&nfs_uuid_lock);
+		list_del_init(&nfs_uuid->list);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_end);
+
+/* Must be called with RCU read lock held. */
+static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	list_for_each_entry(nfs_uuid, &nfs_uuids, list)
+		if (uuid_equal(&nfs_uuid->uuid, uuid))
+			return nfs_uuid;
+
+	return NULL;
+}
+
+void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
+		       struct net *net, struct auth_domain *dom)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	spin_lock(&nfs_uuid_lock);
+	nfs_uuid = nfs_uuid_lookup(uuid);
+	if (nfs_uuid) {
+		kref_get(&dom->ref);
+		nfs_uuid->dom = dom;
+		/* We don't hold a ref on the net, but instead put
+		 * ourselves on a list so the net pointer can be
+		 * invalidated.
+		 */
+		list_move(&nfs_uuid->list, list);
+		nfs_uuid->net = net;
+	}
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
+
+static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net)
+		put_net(nfs_uuid->net);
+	nfs_uuid->net = NULL;
+	if (nfs_uuid->dom)
+		auth_domain_put(nfs_uuid->dom);
+	nfs_uuid->dom = NULL;
+	list_del_init(&nfs_uuid->list);
+}
+
+void nfs_uuid_invalidate_clients(struct list_head *list)
+{
+	nfs_uuid_t *nfs_uuid, *tmp;
+
+	spin_lock(&nfs_uuid_lock);
+	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
+		nfs_uuid_put_locked(nfs_uuid);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		spin_lock(&nfs_uuid_lock);
+		nfs_uuid_put_locked(nfs_uuid);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..a8216a777b40
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/list.h>
+#include <linux/uuid.h>
+#include <linux/sunrpc/svcauth.h>
+#include <linux/nfs.h>
+#include <net/net_namespace.h>
+
+/*
+ * Useful to allow a client to negotiate if localio
+ * possible with its server.
+ *
+ * See Documentation/filesystems/nfs/localio.rst for more detail.
+ */
+typedef struct {
+	uuid_t uuid;
+	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
+	struct auth_domain *dom; /* auth_domain for localio */
+} nfs_uuid_t;
+
+void nfs_uuid_begin(nfs_uuid_t *);
+void nfs_uuid_end(nfs_uuid_t *);
+void nfs_uuid_is_local(const uuid_t *, struct list_head *,
+		       struct net *, struct auth_domain *);
+void nfs_uuid_invalidate_clients(struct list_head *list);
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


