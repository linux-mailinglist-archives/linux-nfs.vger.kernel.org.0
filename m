Return-Path: <linux-nfs+bounces-20250-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDn8Cg62umlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20250-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E882BD0F6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86343213D37
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A503DBD74;
	Wed, 18 Mar 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXOR+ehl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD513D9DBE;
	Wed, 18 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843330; cv=none; b=ufL4OPqnHzntBf1626rzMPY/08d3Ds0YFqVwySKH3bmByLO+3Ok/mHL3BeN2wI85vIjal7jRWoZrLrMH8iffTl6jS0pBzDb6GEOJorzbUO7z6olAvrxHRev6ZzelTrjCkayhQsZ6MYq+KK2vsDEgxyb97LsC1wicYTQwEoyr3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843330; c=relaxed/simple;
	bh=WfblvdFGtIF0rUv9XNsk7ycA7a+TEB7OybXZ3BPp7NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dz0SfVqG9utUzk9wm41GtuuWkVBbuWX0tV9ACUbcHaIYLCsM0R5HKfDlhVDJJfcXGqLMJOewwEuVT06Z7KG1LzccoVpyFxTxJB2PJvcWXxYANcHNFRhj/0YrRQLbhlMY7ab7VwbMJSKx3Ba0TlIteKQyRtQY/5KEGVopncB5xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXOR+ehl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DB3C2BCB2;
	Wed, 18 Mar 2026 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843330;
	bh=WfblvdFGtIF0rUv9XNsk7ycA7a+TEB7OybXZ3BPp7NU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VXOR+ehljFDfmx9/CoNcDbRyACm/WVWOU1e/fthnq6/C8ooCwvsLbWzPOLmwt9cYn
	 4mb+HmhxiYCDT4mccYwkM8MzGupTX6A3BTFka/OvN9ivocWrQKz+WeS33bN09MLe+k
	 EWsvWOPXvK+2UKbYiGdmQoUaPshcvDM66dUFF+g9/34qM7RpBg2Sq6KNKClNmj7Fzt
	 GKyll+QZS2/AC+IGNjzxCjlwvVlQJjwh1St0qvCQCZx0u2TNOTAUwCI8em533DuwRA
	 2sDVgIwexIXwY8aNkLdkm5pe+vPAdlHkczExiBPUQVH+dbOWLcGcrpyM8aQj62xJxP
	 nQpD4pQLunS/Q==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 18 Mar 2026 10:15:08 -0400
Subject: [PATCH v4 6/6] NFSD: Add nfsd_file_close_export() for file cache
 cleanup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-umount-kills-nfsv4-state-v4-6-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=LGVN7sc2eqL9hTHKy7nquo+MwN9593ppYM/wySuya8I=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurN8O7wsqip+pvd39ru02JEbaJiTfIoVASZqn
 USDNwJqRQSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzfAAKCRAzarMzb2Z/
 lwulEAC20W4SJp/f7qZz28z36RNGZdZZ3k70CP8cbM+Ldh4I2whxddRPDVqmiHvsPHwupvhLZxd
 impFyNobHOHl2EEOHwiq9/D9kT+qU8wEtWq/P30gNE99R7xvpmNI1sPLloL7iB728eo6nPlOahD
 b0f2Qi3BsQfOD31VTHpmBnor/kYRHhoK+3IZqKAQ4SMUM+y/uA/sO3UDBE8WFfigtIzrWScYPPS
 Ti9kZ3qpr4ZIRZuEG8bPLt1Kj1js0fgjR0eEiq5QJMo6wQxgMKZD3V0ndgxLU9AfnVwpjz73ozb
 CEN4S+TuDAon7Gi2xx/pFDK5EQ59rOzJ3zHt2i7Goe7Tj8tmENbyRTEYtGSwDxZ1YVXYXdMHSsT
 evWTD9edHv3etRHcqRfLM7xBDw8Zh0EaPwfK9/BpgUQK4GyQePmoII3Gr6+cZYGiF1Zsvj4dydZ
 wrPMw6z39QWOyFWSurHgt7MptH7FXRbG2bg75ZKNpr7g3x7Fh12Mp0y5iTqoAT1MpyXTqZEvDZp
 06ki3DmHZ0Syn/Ttl0Yw5oqE0lN0iM5mfsiztXTevBqpFPhCZqOZTT4obkj3o95Ir+ENzlDLifD
 aK6ykmhLp2oHWP9rYzHiQtAGCqrzokcJXxx6V/oukbW24PmMVM0A74BmhXDt1ilgvIWC+htxfOW
 GkgdA5ktp47m9fg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20250-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7E882BD0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

After NFSv4 state revocation, GC-managed entries in the
nfsd_file cache can still pin a filesystem and prevent unmount. Add
nfsd_file_close_export() to close cached files scoped to a specific
export subtree, matching the granularity of
nfsd4_revoke_export_states().

nfsd_file_close_export() walks the nfsd_file rhashtable and
disposes GC-managed entries whose backing file resides on the
target superblock and under the export root dentry. When the export
root is the filesystem root, the is_subdir() check is elided.

nfsd_nl_unlock_by_filesystem() calls nfsd_file_close_export() after
state revocation to release any remaining file cache references.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfsctl.c    |  6 ++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index cd09be0c5465..0944019ef645 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -926,6 +926,51 @@ bool nfsd_file_inode_is_in_subtree(struct inode *inode,
 	return found;
 }
 
+/**
+ * nfsd_file_close_export - close cached files for an export
+ * @sb:           super_block of the export's filesystem
+ * @root_dentry:  dentry of the export root directory
+ *
+ * Walk the nfsd_file cache and close GC-managed entries whose files
+ * reside under @root_dentry on @sb.  When @root_dentry is the
+ * filesystem root, all GC-managed entries on @sb are closed.
+ *
+ * Non-GC entries are opened by NFSv4, which closes them explicitly
+ * via CLOSE or state revocation; they require no cache-level flush.
+ */
+void nfsd_file_close_export(struct super_block *sb, struct dentry *root_dentry)
+{
+	struct rhashtable_iter iter;
+	struct nfsd_file *nf;
+	LIST_HEAD(dispose);
+
+	lockdep_assert_held(&nfsd_mutex);
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
+		return;
+
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		nf = rhashtable_walk_next(&iter);
+		while (!IS_ERR_OR_NULL(nf)) {
+			if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+			    nf->nf_file &&
+			    file_inode(nf->nf_file)->i_sb == sb &&
+			    (root_dentry == sb->s_root ||
+			     nfsd_file_inode_is_in_subtree(
+				file_inode(nf->nf_file), root_dentry)))
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
 static struct nfsd_fcache_disposal *
 nfsd_alloc_fcache_disposal(void)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 36c9a8e388d2..c324f85b495f 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -71,6 +71,7 @@ struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_inode_is_in_subtree(struct inode *inode, struct dentry *root_dentry);
+void nfsd_file_close_export(struct super_block *sb, struct dentry *root_dentry);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d9c61c939059..55392f2d7882 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2206,11 +2206,13 @@ static int nfsd_nl_unlock_by_filesystem(struct genl_info *info)
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_serv) {
 		nfsd4_revoke_export_states(nn, path.dentry->d_sb,
 					   path.dentry);
-	else
+		nfsd_file_close_export(path.dentry->d_sb, path.dentry);
+	} else {
 		error = -EINVAL;
+	}
 	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);

-- 
2.53.0


