Return-Path: <linux-nfs+bounces-20738-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN9DN81M1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20738-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:40:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 574093BC4B0
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 354DC30FC6AF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E883CA4B7;
	Wed,  8 Apr 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFCe8N02"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF33CCFC2;
	Wed,  8 Apr 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651416; cv=none; b=RFDT4EFKdrcCEUlqUboFldtdocETOyfcGh+s4ovfsygUGwU/PlJFwDbjN6DDWkXcltBkgO0p6TpnQ+zPl6W+cRrU2YHQZun/TLysx+20UiJUHIPgvujeNlt2yUpiawnsedwnmStINEXETEnVzHXa703xW5gCF9WsFQWNTtn908s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651416; c=relaxed/simple;
	bh=QV16RRTroR60pYIPNpVr2u935zYJuhq0gQLQqu9lLvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6AYVNMHS9xjadzgGeEnpLoXpOQhF0A5eA7vy2OHMEJmgDtNXysL0nVX4U2QK0XPrb0IjdhiTnMueu7Renqmk5QhX4T7Kp7JTN2d5X5tVgcNhWdEM71QZVi58VLmvYBVxEe2vCAesSKNoGZjxF9Xu96u72gdHXEo6sP6LEdUXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFCe8N02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09B5C2BCB2;
	Wed,  8 Apr 2026 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651416;
	bh=QV16RRTroR60pYIPNpVr2u935zYJuhq0gQLQqu9lLvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eFCe8N02TpDHW/ZbZosKV9/VS1vaAGRjLKIUnfwYE1sDE1fETmrsNFnhsS+fr5q0T
	 g52RFNTgpKT5bjdTjIFkbkf6h8oNhf3ZjvGDR+HCV1qi6YFhkR3R6HNF4yUams2zjt
	 e+uWFsxpBSonljJSFCvrzAula5AzSpdwtU4lz6ZqGOopXvV3g+dH/IGyORVmXzaeFB
	 A1V8+zicAorVRb1Czb+wfSAYipeD9vJB691Mq2/1arUGeR4V2GXU1JGxzEZvA7BySb
	 GTYgPzRfBbSoQjs8kAbTiV6xmF8f7aczOcx8qla9fKSrhRnaEEF2QgpGJYZbG7yj7e
	 FTuQrjvjDXHAw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:59 -0400
Subject: [PATCH v8 9/9] NFSD: Close cached file handles when revoking
 export state
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-9-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x0TdrtltMY1YuvVdaaPef/iF+vzHaDIQXyUSoJA5eh8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPN5pIN2MdZrZD3w+J6eTPhZTLnULkE8DFE
 1Fva2WQn6CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l7K2D/420PgP+aqp5xuNQwNaw4LIxQQ36Chj9REItKq1ny4xTBvkUlWPCH01Kd5IRnFKWqLLbgF
 DTHUb4kPku85BPlW0kB/6xx/tNCyQUtz/dhnYi+hF3cl2c88EFfDwVmEeHy1isTOF7MjIJuxaZ3
 TuTf+SYyyNo0C/WSld4h6GYXWiaOOXiCMJp+FqcG7YNKnRPxO/5PuPvwb0M1uQeD39QAMqaqgKz
 /zVzjiO/IV+q0UMvdvEdg1P3FiRVqVsoU3lwL0AOtV8UaNcNONHSjfPUUXuIGffVAZhUNg1bdT1
 vuib9cJUeGvpVwHTaiyP4gUpQjCxCRqJOwzY58UsVKE6JoT1ALtgDGxNhxyBEY/mLkIbxo2dQK9
 LPxjn4uhb8y72SEb0cVqwKmVaV8otEYPFUbIBxsIF0jOb+S9jrEugZsUSQZowYxZuDRfdlu4DiS
 q73mnDKb3tNG8k37RflbQ/plPDwpRS+Ux2Ad7qyqZ72gMh6O0dUxu1EOwTssNsQfwnPSnjC21Cf
 9SfWCyDTzauzvOcUKYnd5K8Jr0oBtvyj5SFrVJ/eRf5aSnZlkCDgpdofZO574+6TvktWsMdkACs
 vzUnbY4tDT3N8Yv8T7aKO3Wnz6DLZh3isvcgYOahHAbfuI7hnSsYbwN5fLcuomcHetyEXOVuWFC
 6bA36tvc9r3AqJw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20738-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 574093BC4B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When NFSD_CMD_UNLOCK_EXPORT revokes NFSv4 state for an export path,
GC-managed nfsd_file entries for files under that path may remain
in the file cache.  These cached handles hold the underlying
filesystem busy, preventing a subsequent unmount.

Add nfsd_file_close_export(), which walks the nfsd_file hash table
and closes GC-eligible entries whose underlying file resides on the
same filesystem and is a descendant of the export path.  Because
nfsd_file entries do not carry an export reference, the ancestry
check uses is_subdir() on the file's dentry.  False positives --
closing a cached handle that did not originate from the target
export -- are harmless; the handle is simply reopened on the next
access.

The handler calls nfsd_file_close_export() before revoking NFSv4
state, mirroring the order used by NFSD_CMD_UNLOCK_FILESYSTEM
(which cancels copies and releases NLM locks before revoking
state).  Both calls run under nfsd_mutex.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfsctl.c    |  5 +++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e2b38ed1d35..24511c3208db 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -724,6 +724,52 @@ nfsd_file_close_inode_sync(struct inode *inode)
 	nfsd_file_dispose_list(&dispose);
 }
 
+/**
+ * nfsd_file_close_export - close cached file handles for an export
+ * @net: net namespace in which to operate
+ * @path: export path whose cached files should be closed
+ *
+ * Close out GC-managed nfsd_file entries whose underlying file is on
+ * the same filesystem as, and a descendant of, @path.  nfsd_file
+ * entries do not carry an export reference, so the check uses the
+ * file's dentry ancestry.  False positives (closing a cached handle
+ * that did not originate from the target export) are harmless -- the
+ * handle is simply reopened on the next access.
+ *
+ * Called from the NFSD_CMD_UNLOCK_EXPORT handler before revoking
+ * NFSv4 state, to ensure that cached file handles do not hold the
+ * filesystem busy.
+ */
+void nfsd_file_close_export(struct net *net, const struct path *path)
+{
+	struct rhashtable_iter iter;
+	struct nfsd_file *nf;
+	LIST_HEAD(dispose);
+
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		nf = rhashtable_walk_next(&iter);
+		while (!IS_ERR_OR_NULL(nf)) {
+			if (nf->nf_net == net &&
+			    test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+			    nf->nf_file &&
+			    file_inode(nf->nf_file)->i_sb ==
+					path->dentry->d_sb &&
+			    is_subdir(nf->nf_file->f_path.dentry,
+				      path->dentry))
+				nfsd_file_cond_queue(nf, &dispose);
+			nf = rhashtable_walk_next(&iter);
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (nf == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+
+	nfsd_file_dispose_list(&dispose);
+}
+
 static int
 nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 			    void *data)
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b383dbc5b921..683b6437cacc 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_close_export(struct net *net, const struct path *path);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 65f4c757a0f4..c76849f316f7 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2392,9 +2392,10 @@ int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
 		return error;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_serv) {
+		nfsd_file_close_export(net, &path);
 		nfsd4_revoke_export_states(nn, &path);
-	else
+	} else
 		error = -EINVAL;
 	mutex_unlock(&nfsd_mutex);
 

-- 
2.53.0


