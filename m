Return-Path: <linux-nfs+bounces-20572-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFSpG6M3zGn7RQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20572-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:07:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 947453715FD
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC9773025F32
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994043DA55;
	Tue, 31 Mar 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJjpjf3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C344B66B;
	Tue, 31 Mar 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991232; cv=none; b=SSwp0w4Gqha6Iv3zaup0wfs+PUnCwL3f3prgMuPmqHQzKTKYY60jVIhidGEFtmtSMzzTEe6GyWb25ZzBMKVJCsnhnseyPb/yTgdnoCysvMGaiBkKexqbnA0vkYvQl6DWpWayvBzXJ3kuvBwQe/4Jsds1LgG2OiDRxYLQhU9PYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991232; c=relaxed/simple;
	bh=UsJ5e/RhuVuFtvHeikldmw2lMh7vPiDAng13HfDxIw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKO6VmPt2JD8OqZYlSscxmZMcmEmTTb5yacU3gLNV2BIbAJQVPGEU4+E5E+zRCMoZ1YOZ5PjMy70HLQRFx5DOrHIwwpa+Qgxknii6w0n7/5cpBMQyEnwR1o11JA8f7+YukRtL518yODU6RHNL8Kpeu3Jq6JXF5s/PH5EKSE4kkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJjpjf3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB54C19423;
	Tue, 31 Mar 2026 21:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991232;
	bh=UsJ5e/RhuVuFtvHeikldmw2lMh7vPiDAng13HfDxIw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pJjpjf3pBs7AY4jZvoI26yABo0xpnYSIndXvxqq76jWSDZNgEj2z88SImUA1n5Mis
	 rpqNuquS29oay42CoguNoG2KkLpTznOnLsQhy1+cke/mquPSTEggbjXK72vzkVrgDG
	 F4yuhkHN7N/2IkOv47KqdpZNBNVXFNKx8DqkGtUfDDH9M7peRULivg+1Q3XHsHa9Ug
	 bsrG2wTUklNHYUBKXa+DGWb5O+VW7Hij//crW0AjESQUDk2ck7domvxNx1BkNH/YEn
	 Wn4mFAcDkKbMSTHjDJZkXgTMi/jwsHqskkq6R1+ln+Uxdcg65/Ar3oWEm8BrpmjP0Q
	 5fswio4LJcGnA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:07:01 -0400
Subject: [PATCH v7 7/7] NFSD: Close cached file handles when revoking
 export state
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-7-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=YtL1hMNF50B7TzqcOei4fxTM/rP0tuBogvyqIxf0LKg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5PWOBuMeXQB0hohtvG4EsPYi9/oy5RjA+a
 rLl4ZnKag6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l8zgEAC7U49XnIxM9cTaM3o7JGXp11BJX8WRcTPW4GtEEbkIDPGHLqQjzdhBwocnCwQr64Kl0wt
 IqxiyLHWctNlIVSmqTOOd6dznJOFbROLVjK2CMbW6g3dVAyw5M+Llm4EbzxwZgGKahTY22fK414
 qxFruiEjbB9SyWSk90xsIsyHsH/o+TZ3hhkgIE1AHdCO9RuP/i9O7iWwcQCwdmt2I+kc2Iut2GM
 u1WXHw5VrEXApcwLMQGMqZmn2dnCUvCy+Jvs+YLqtFmu9nJgvcVjBAAHusacgYZyioWBqoP5Bfm
 SuR70GO3/cH7mTSxPbkMM14ZDsXsE9kwgy9UC8J3JTGlBuAHfI5nkO7wy5dcs5aGw48dTOtKi4B
 Koro9sIZ/76eDH/7kb0WVoJNOKVcf5JKXGRDFyaLmO5DjB3aqsGtHptOHdGFTRRUHohLMz05MxX
 Z7ZuMYNIMO9j6fvo6Ni7l3uG3+ACIPy1GyXKawWH5ySztqqBV19Z1fZ8iudIKrKO4RAQEhkfLtY
 SUcP9zHbfJ0LVD+ldbt2jODzIiNGKt7w0FB3bvLQ1utXMkervdbW5g5tZabbuG/J9WSLmOl7a0S
 TLOOrPS+NVDu5GoHrrpjBiV5xexvy/U6cFChnMOICT4YX/m4/c57PpH24QcmTpT/W3NCuVlTmMt
 JkUGlgSy3bQZPRg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20572-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 947453715FD
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
index 0bbcd5bae340..8aef18a0c0f2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2313,9 +2313,10 @@ int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
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


