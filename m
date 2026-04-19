Return-Path: <linux-nfs+bounces-20965-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCDzNRMl5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20965-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:55:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2E425282
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC64A301DE2D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C72F5A36;
	Sun, 19 Apr 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biVVlvmv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CE2EB856;
	Sun, 19 Apr 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624806; cv=none; b=u0JX3d0aHWrWZ82IgXHW56qD5SOsEYdho6zXk8EInHj//YFiYFpY4Zlx7Sfs7uIb3FNnnI0erIhbvOf8VEXz6T85KVBbMYQ0ayzuAUIj2X9Je6jblvUBfOkDm8lD5zHTLYpj0eZkqxjaAiht96eCMyqm9PYzBBzzKp14l8GA+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624806; c=relaxed/simple;
	bh=QV16RRTroR60pYIPNpVr2u935zYJuhq0gQLQqu9lLvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWPzGtCfm+tI4lv8Y+2Rio36Dp/AjlPzWmEpIujx8xuCCLeNgxtLzmS9IMxkzhk6Nsq+SI8VFud5IP/Zl8bi/fdJT+FVywa3SgB38dgGtZ8Rpziao39sMM94Bl7oImryBZeB8PgZ4C72DPdAT7/RIwVurCtCvCxXrzY0K6CumVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biVVlvmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA5C2BCB8;
	Sun, 19 Apr 2026 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624806;
	bh=QV16RRTroR60pYIPNpVr2u935zYJuhq0gQLQqu9lLvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=biVVlvmv8KAqXiFxT4ZJkMNI09Q3lWyxDtCbWk+9xxvc272tQIcQjjhcQWusmJiNU
	 t5EIwS4tLOgZA0YX+ouYc/p0Ws4/SGuu50zqfBIPtG7nudYfcsV5oeVNXv+7i3Embl
	 YIg+2ClZEYSIzuT0ietVfn2iezi+UI3+rXdbvaiDU8KsOaSbwNDD20o5ND8GBDNnA6
	 1XaK9+pDklkJ8RII3BrLIzTpO4sN6fZ6aKVm0L8ALf+m95apoCiE8XsRsQsy9p0iiR
	 i5UufFf5Q3KnkYb2Jn662JOTlISweE2TAzeNYqYqKI1ZaZ4V7q2ASIoti3yMH+HQzC
	 EqyLK8eNZ8itQ==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:53:07 -0400
Subject: [PATCH v9 9/9] NFSD: Close cached file handles when revoking
 export state
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-9-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x0TdrtltMY1YuvVdaaPef/iF+vzHaDIQXyUSoJA5eh8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSe6xZrpbBSMwQ8lX1fx55ZJawolGYNUBn/5
 xjC2MS4FxWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUkngAKCRAzarMzb2Z/
 l33DD/9ax5Bjp/QuHBrqLBJiiA7+UTDClTTlhdDM4VeUgaUeUZVXhqd1en1Ug27JGPHKeYwVNaS
 fqqOR8F+iVVczw0HK7ew8KW0EpKSmEOwvG+JEKemDZOAOwS8p/nusTgvztsf1AIuFMitEKp7uuZ
 pngMwsq+t+v0I7xxX2WH6Q6hFucB8CXuUMdEVxc99UF2O3UK4x4E5Hs0mCl4LCiMzYaKMfRCT/v
 baClY3YVwf2OHImLRy0sq021NGxNdw065iEq6t+ebaX7aYfOjNcnVwu2wCx/UFke6n+s5q5lOMZ
 DaAQbYCmoiaCizqlzVu/Dpd1wcfUcUo8VEOzCsdusI6rKtv8u3l2WYRVY2LJd1gNM1c508sm+E9
 gFov+hd9Nr0ZFhQhGOB6kAJ2SUxNXhgRiHfsd8WXQM3ylO5bOOQRqPnn8IjiRuRav2P1twQzPQw
 2TSl34hOgh1OuznpuMUSSIyT4bUgPuTjR+RULdcG/DNdqQsmUBj5a4Udp6ghLT16FSp2kFGqOE+
 34rI18k99CZpWyaj6K4eo3wGPgPyFaOc5gdGjC0/QY8Sb5aV5iLoKE4JUY/pl0OygyoilnPrFSw
 vXM8p0NFeR8lc7ZUi20ZdoDiQFVm8jze/ZwxP5WMjdw2uz6lvMlf7Gcl4mqs+jIRtmmdaeH6meV
 XNs98HzZw2yaV6Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20965-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5AA2E425282
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


