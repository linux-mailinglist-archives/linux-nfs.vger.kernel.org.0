Return-Path: <linux-nfs+bounces-20249-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOK6Igy2umlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20249-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A7F2BD0EF
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84E6F319CAA2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13103D75B7;
	Wed, 18 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRiyf/9x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E353DB630;
	Wed, 18 Mar 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843330; cv=none; b=St0Y5d7DUI+KOqP1smP3C7fs2qcKEj9auAtH1J3L/UFcG19/Bfau1WZNPL/nb3nWeU+wOJ7wQHkx8K47hRcur8Lrfzxpy47wIVAXpVe9JuWrEAJOtySMN+NmLfIS+ihGworUMAkB6L/KOIZAkhF6dChDKmXrow0RNLczs9qnYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843330; c=relaxed/simple;
	bh=unM4OyFOPlhktQu10UwZbOwpsYrHAx/eWabnrP6dBJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyuJJJka7l59DHy2s08l9TfvwGevgO8qNZS1nOyrpxhf+j2FPQ3Q+R7zRJrniBoB0nv0JOXCRy+qimJ+m+ZlBetHfv6WrBHI66UY6XM85rAluo8buhChGOiSPQGnLzQ2pDfV2+5nfdPdFJWvldh4Tz/2+J7NkSGr/S6gl6CbhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRiyf/9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C911C2BCB3;
	Wed, 18 Mar 2026 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843329;
	bh=unM4OyFOPlhktQu10UwZbOwpsYrHAx/eWabnrP6dBJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRiyf/9xC8et94m804zBvrsmFkkP2eDtqzbbsBL2beXM0DAINia6chfwTZA8TYvK0
	 j4+zYywq9lIvsVV4xxlPlHVExILCB7K/oDC8yvQJgvs5vui4CjbZrJlpvjavzUKsgc
	 XotbqYIoCZPp4woRQBuwjUFnfjCvTJyMGta/dobQuAEXYvWzvA8k9KY0thXa0hHo33
	 f1uKjSi07FWdDBrdxQI7N0L/1qSgQJjP3xFuNzcWMNc9NyoIWUVwJVn7UD+vsZbBZ9
	 B4+pTuccBFttVoBQ701bH/UtKpxLdVvaVGiSxj78rzqbGvspUqAJkP4OgPuZ1hxfP6
	 IqaictZ/cX3nw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 18 Mar 2026 10:15:07 -0400
Subject: [PATCH v4 5/6] NFSD: Add export-scoped state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-umount-kills-nfsv4-state-v4-5-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9696;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yr9pMNSBVSj7ytTva2Ft7icfHQBJIYH41Xvyn2aA4Qo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurN8l40I52C4FX7I6i72Ml1XYFhheAdWPoEK7
 aayCvTKQ3qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzfAAKCRAzarMzb2Z/
 l/2OD/4/WFt6xFqzym7EA7xUrd8l/joEgYFSHr3L8qzAiW5wqYu6/mkrnhXz/+FBaXEoaOiwvfo
 O6b5x6LHhefS0PmcOB42dUafbVJsMbsOSDC+2zqRUA+xUsl74orS5zECvAzuG0hvDAD9nPO+rqg
 AU0NRw1tqCLVNc4S8P+CaNPTMWdvrSDNEWABi4uAt2Albi5RcmVDEn7Ek5EAkQdsGrLM08XraIO
 5elZg/6ef0t6LnfgYv+fmKW1WnN3rVfsG/IriWZiJD5M+YMD+z8aRlRic3bl0T2aBgrFlaEVHuD
 O/3/wmMMxcHQBzkuAjFES0LYyJRo9uZy1aU/QmGHNd2/u+IwNkg9OBq0lSdfvqObydiNHSDHS1X
 lVXbrf3WnEwOPo86scCFlW/xOkdVHW70Vf0Rezbuupni1M0yo6uUtedjLP+aCH9K2t073Z+1U9F
 gWWF7WEysQ/3a2b6AtGXuNV6pRY1PpCKbuaCIikJ3uKTjqMlZg5rIQNvKvktZefLrlIbpW6wY0W
 A7jbGpgdia//kqaIcz/R/OoPvvx2X65JVaw6OBwaVMn/T2Ur7nB0cQfysA88hOBaETLov9FyOuq
 La2mao8LGd7+mdqPwdpsTSdpLlvYfHYxIlaxJaIeQcX/wgHxfcU4y2iPS2t10GL7r3aURrhwNKt
 WKuV7TqJm6CCCcg==
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
	TAGGED_FROM(0.00)[bounces-20249-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 36A7F2BD0EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_revoke_states() revokes all NFSv4 state on an entire
superblock, which is too coarse when multiple exports share a
filesystem. Add nfsd4_revoke_export_states() to revoke only
state associated with files under a specific export root, then
convert nfsd4_revoke_states() to a thin wrapper that passes
sb->s_root.

nfsd4_revoke_export_states() uses find_next_sb_stid() to locate
candidate stids, then verifies each against the export root via
nfsd_file_inode_is_in_subtree(). That helper is placed in the
file cache layer (filecache.c) because it operates on VFS types
with no NFSv4 state dependency. It walks all of an inode's
dentry aliases rather than calling d_find_any_alias(), because
for hard-linked files an arbitrary alias may fall outside the
export subtree even when another alias is inside it.

When the export root is the filesystem root, the subtree check
is elided and every stid matching the superblock is revoked
directly.

The NFSD_UNLOCK_TYPE_FILESYSTEM handler now calls
nfsd4_revoke_export_states() with the resolved path dentry,
enabling subtree-scoped revocation through the netlink
interface.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 32 +++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfs4state.c | 92 +++++++++++++++++++++++++++++++++++++----------------
 fs/nfsd/nfsctl.c    |  3 +-
 fs/nfsd/state.h     |  7 ++++
 5 files changed, 107 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e2b38ed1d35..cd09be0c5465 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -894,6 +894,38 @@ __nfsd_file_cache_purge(struct net *net)
 	nfsd_file_dispose_list(&dispose);
 }
 
+/**
+ * nfsd_file_inode_is_in_subtree - check whether an inode is under a subtree
+ * @inode:        inode to test
+ * @root_dentry:  dentry of the subtree root
+ *
+ * Check whether @inode has any dentry alias that falls within the
+ * subtree rooted at @root_dentry.  Hard-linked files can have aliases
+ * in multiple directories, so all aliases must be tested.
+ *
+ * Return: %true if any dentry alias of @inode is at or below
+ * @root_dentry, %false otherwise.
+ */
+bool nfsd_file_inode_is_in_subtree(struct inode *inode,
+				   struct dentry *root_dentry)
+{
+	struct dentry *alias;
+	bool found = false;
+
+	/* i_lock stabilizes the alias list; is_subdir() nests
+	 * rename_lock (a seqlock) beneath it but does not sleep.
+	 */
+	spin_lock(&inode->i_lock);
+	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+		if (is_subdir(alias, root_dentry)) {
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&inode->i_lock);
+	return found;
+}
+
 static struct nfsd_fcache_disposal *
 nfsd_alloc_fcache_disposal(void)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b383dbc5b921..36c9a8e388d2 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+bool nfsd_file_inode_is_in_subtree(struct inode *inode, struct dentry *root_dentry);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 891669b32804..581f38395c42 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1763,15 +1763,6 @@ static struct nfs4_stid *find_next_sb_stid(struct nfs4_client *clp,
 	return stid;
 }
 
-static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
-					  struct super_block *sb,
-					  unsigned int sc_types)
-{
-	unsigned long id = 0;
-
-	return find_next_sb_stid(clp, sb, sc_types, &id);
-}
-
 static void revoke_ol_stid(struct nfs4_client *clp,
 			   struct nfs4_ol_stateid *stp)
 {
@@ -1835,20 +1826,19 @@ static void revoke_one_stid(struct nfs4_client *clp, struct nfs4_stid *stid)
 }
 
 /**
- * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
- * @nn:   used to identify instance of nfsd (there is one per net namespace)
- * @sb:   super_block used to identify target filesystem
+ * nfsd4_revoke_export_states - revoke states associated with a given export
+ * @nn:           nfsd_net identifying the nfsd instance (one per net namespace)
+ * @sb:           super_block of the export's filesystem
+ * @root_dentry:  dentry of the export root directory
  *
  * All nfs4 states (open, lock, delegation, layout) held by the server instance
- * and associated with a file on the given filesystem will be revoked resulting
- * in any files being closed and so all references from nfsd to the filesystem
- * being released.  Thus nfsd will no longer prevent the filesystem from being
- * unmounted.
- *
- * The clients which own the states will subsequently being notified that the
- * states have been "admin-revoked".
+ * and associated with files under the given export will be revoked.  When
+ * @root_dentry is the filesystem root, all state on @sb is revoked (equivalent
+ * to nfsd4_revoke_states).  When @root_dentry is a subdirectory, only state on
+ * files within that subtree is revoked.
  */
-void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
+void nfsd4_revoke_export_states(struct nfsd_net *nn, struct super_block *sb,
+				struct dentry *root_dentry)
 {
 	unsigned int idhashval;
 	unsigned int sc_types;
@@ -1861,18 +1851,53 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
-								  sc_types);
-			if (stid) {
-				spin_unlock(&nn->client_lock);
+			struct nfs4_stid *stid;
+			/* Resets to zero on each retry; revocation may
+			 * alter the IDR, so a stale cursor is unsafe.
+			 */
+			unsigned long id = 0;
+
+			while ((stid = find_next_sb_stid(clp, sb,
+						sc_types, &id)) != NULL) {
+				if (root_dentry != sb->s_root) {
+					bool match;
+
+					/* Bare inc to pin clp; get_client_locked() is
+					 * not used because its courtesy-to-active
+					 * transition is unwanted during revocation.
+					 */
+					atomic_inc(&clp->cl_rpc_users);
+					spin_unlock(&nn->client_lock);
+					match = nfsd_file_inode_is_in_subtree(
+							stid->sc_file->fi_inode,
+							root_dentry);
+					if (!match) {
+						nfs4_put_stid(stid);
+						spin_lock(&nn->client_lock);
+						put_client_renew_locked(clp);
+						id++;
+						continue;
+					}
+				} else {
+					/* Whole-sb: goto retry restarts the
+					 * client list immediately after
+					 * revocation, so clp needs no pin.
+					 */
+					spin_unlock(&nn->client_lock);
+				}
+
 				revoke_one_stid(clp, stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
+				if (root_dentry != sb->s_root)
+					put_client_renew_locked(clp);
 				if (clp->cl_minorversion == 0)
 					/* Allow cleanup after a lease period.
-					 * store_release ensures cleanup will
-					 * see any newly revoked states if it
-					 * sees the time updated.
+					 * The lock/unlock pair orders this
+					 * store after revoke_one_stid(), so
+					 * nfs40_clean_admin_revoked() sees
+					 * newly revoked states if it sees
+					 * the updated time.
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
@@ -1883,6 +1908,19 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 	spin_unlock(&nn->client_lock);
 }
 
+/**
+ * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
+ * @nn:   nfsd_net identifying the nfsd instance
+ * @sb:   super_block used to identify target filesystem
+ *
+ * Convenience wrapper around nfsd4_revoke_export_states() that revokes
+ * all state on @sb by passing sb->s_root as the export root.
+ */
+void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
+{
+	nfsd4_revoke_export_states(nn, sb, sb->s_root);
+}
+
 static inline int
 hash_sessionid(struct nfs4_sessionid *sessionid)
 {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d3ed343699bd..d9c61c939059 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2207,7 +2207,8 @@ static int nfsd_nl_unlock_by_filesystem(struct genl_info *info)
 
 	mutex_lock(&nfsd_mutex);
 	if (nn->nfsd_serv)
-		nfsd4_revoke_states(nn, path.dentry->d_sb);
+		nfsd4_revoke_export_states(nn, path.dentry->d_sb,
+					   path.dentry);
 	else
 		error = -EINVAL;
 	mutex_unlock(&nfsd_mutex);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..9e7c7884831c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -843,11 +843,18 @@ struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 #ifdef CONFIG_NFSD_V4
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
+void nfsd4_revoke_export_states(struct nfsd_net *nn, struct super_block *sb,
+				struct dentry *root_dentry);
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
 #else
 static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
 }
+static inline void nfsd4_revoke_export_states(struct nfsd_net *nn,
+					      struct super_block *sb,
+					      struct dentry *root_dentry)
+{
+}
 static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
 }

-- 
2.53.0


