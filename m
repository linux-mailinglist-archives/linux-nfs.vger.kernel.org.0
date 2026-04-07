Return-Path: <linux-nfs+bounces-20688-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JxEMJoF1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20688-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C643AEFFB
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 735F13096274
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22A3B7B61;
	Tue,  7 Apr 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH40D6Ld"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5743B6C10;
	Tue,  7 Apr 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568145; cv=none; b=YTvV9FduT78XeHDF2JtMwiEfZP/igrTTJQdb34Dh08U7IH9o8vyFf9i/jvE1pHMuimGUs1bZAoKFUnouZ9BpItMuQoRtNrRwhWgzqMwtaXJAJE5xCS9eocft34R7BegKv5fn4yQ1Mbmyd2wljkpGQtoj6Y1aQSrmvkBZQ866Dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568145; c=relaxed/simple;
	bh=4QeHfiTNd6hAM54W0DZtZMvv0guE9uRnMT2hpLvnyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lISoA1101sWFOmUA4v4Ak+GqDSjjoxF2uim4sUGAW8kNwBuzWLWcSn9qQP7L21VQe4OuxZrNoVahkU78NwvDK4JVq/Mo7MXTKk8yeP9zU+ei9K00iV46rLmuZUlEtqnjlsJmDG5vMeEIujJVKSSS0nAShPtqiJIwBRUbRgOrtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH40D6Ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6139BC2BCAF;
	Tue,  7 Apr 2026 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568144;
	bh=4QeHfiTNd6hAM54W0DZtZMvv0guE9uRnMT2hpLvnyhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LH40D6LdTLQzkyUyw8yfKTYLHTFK9MSE5ONIEUECBF2rJWlNNc5IoVjq6tZm/zVKj
	 Ht9ERE/m/jOreI3ZQRtr2ZQCm6BB2elgdCuDTL9dfQZvSGSSV2uOrGLHnRtd7VugNS
	 yoblOkUHBGzbf/SA7odcrCwUotGtGHVUzwLnaqvGha4M9o76Zsc9vofxAQUFjAE5BR
	 oh6Jg+/s10OIfrcts+v6d56L0GEfeyxkiDG/WIIQMQKfMvoRpwTWNU6AFJJMxT0qvK
	 bukEeFhF2Fk5UFTQToIZfiFQZ+at9mZlv5cOnzGdrgudq3uLFed5drTgHfJDKzyOTR
	 H8d7P4SX4zngg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:14 -0400
Subject: [PATCH 01/24] filelock: add support for ignoring deleg breaks for
 dir change events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-1-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14110; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4QeHfiTNd6hAM54W0DZtZMvv0guE9uRnMT2hpLvnyhE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUD48Cxvy7hrSh3w51rn/Vnc0eTro7iKkmiu
 fNVL6xGV2mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFAwAKCRAADmhBGVaC
 FZ+1EACZWYczShZfj4YGPjRF/EhTJDIjvHhR8oN5kJiA6X/b9ri33OIEAiVze+1fEaSKpE95Lhm
 ooNhb42MqgCubes4FxaCVJ9nrdpDq+yI7XtR6M7KjeuqcKi7A+aspvdKJ4/2p8KMT+nAeHZFlUW
 9D33/b2VI3tBc/0q0xM7aRB8YGH/VKWR+1CI9ahlU4lpdovuysj+CnLEBbE+OypxB0vcw+dD63o
 GE4NXS8X8VCT1CPzwAisKkpCKnPyX43A9ssrdkkiz7Xrk6KSv6VgeTXJMqaJz2BeuHzxOTCOGcO
 4RkdoU2b0qQMzlaY9Qvoyk31Bjs6mjrs017p7LWgJ0QY4zT8WgGCnvqMIga27yLeCxaWAG4KtL2
 dKzeQdyjRPWyz6hSgf5UOGwopNN+rjlBaOjJ5oJyRaj69eEAg8A/4KhTIzElyj9ZUxMJeKU7030
 bJF8iuf66khFxh1Z4cgZXHOB6GxOueryOtgRxozKqWOrpblwXfwGknR3YS7pC9TZeyOIM8BBcvT
 HzPIOWt+P2+grUe/z7gbHSqnSgbg4AU54uJHfX5k6NZ3DODbPib2lpu0QaZmkqwKrRCsMtIdZkI
 SH1QDqDnoNxwWkye2giLnWMueKojs6nzgbzM1T/8YOfCd98DATsetpJW9v+E43VWkL/MsUbQv77
 9zciZWJZJSIHjXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20688-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67C643AEFFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If a NFS client requests a directory delegation with a notification
bitmask covering directory change events, the server shouldn't recall
the delegation. Instead the client will be notified of the change after
the fact.

Add support for ignoring lease breaks on directory changes. Add a new
flags parameter to try_break_deleg() and teach __break_lease how to
ignore certain types of delegation break events.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c                       |  2 +-
 fs/locks.c                      | 55 +++++++++++++++++++++++++++++++++++------
 fs/namei.c                      | 31 ++++++++++++-----------
 fs/posix_acl.c                  |  4 +--
 fs/xattr.c                      |  4 +--
 include/linux/filelock.h        | 53 +++++++++++++++++++++++++++------------
 include/trace/events/filelock.h |  5 +++-
 7 files changed, 110 insertions(+), 44 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index e7d7c6d19fe9..28744f0e9ff4 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -547,7 +547,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * breaking the delegation in this case.
 	 */
 	if (!(ia_valid & ATTR_DELEG)) {
-		error = try_break_deleg(inode, delegated_inode);
+		error = try_break_deleg(inode, 0, delegated_inode);
 		if (error)
 			return error;
 	}
diff --git a/fs/locks.c b/fs/locks.c
index 8e44b1f6c15a..dafa0752fdce 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1597,15 +1597,52 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 	return false;
 }
 
+static bool
+ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
+{
+	if ((flags & LEASE_BREAK_DIR_CREATE) && (fl->c.flc_flags & FL_IGN_DIR_CREATE))
+		return true;
+	if ((flags & LEASE_BREAK_DIR_DELETE) && (fl->c.flc_flags & FL_IGN_DIR_DELETE))
+		return true;
+	if ((flags & LEASE_BREAK_DIR_RENAME) && (fl->c.flc_flags & FL_IGN_DIR_RENAME))
+		return true;
+
+	return false;
+}
+
+static bool
+visible_leases_remaining(struct inode *inode, unsigned int flags)
+{
+	struct file_lock_context *ctx = locks_inode_context(inode);
+	struct file_lease *fl;
+
+	lockdep_assert_held(&ctx->flc_lock);
+
+	if (list_empty(&ctx->flc_lease))
+		return false;
+
+	if (!S_ISDIR(inode->i_mode))
+		return true;
+
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+		if (!ignore_dir_deleg_break(fl, flags))
+			return true;
+	}
+	return false;
+}
+
 /**
- *	__break_lease	-	revoke all outstanding leases on file
- *	@inode: the inode of the file to return
- *	@flags: LEASE_BREAK_* flags
+ * __break_lease	-	revoke all outstanding leases on file
+ * @inode: the inode of the file to return
+ * @flags: LEASE_BREAK_* flags
  *
- *	break_lease (inlined for speed) has checked there already is at least
- *	some kind of lock (maybe a lease) on this file.  Leases are broken on
- *	a call to open() or truncate().  This function can block waiting for the
- *	lease break unless you specify LEASE_BREAK_NONBLOCK.
+ * break_lease (inlined for speed) has checked there already is at least
+ * some kind of lock (maybe a lease) on this file. Leases and Delegations
+ * are broken on a call to open() or truncate(). Delegations are also
+ * broken on any event that would change the ctime. Directory delegations
+ * are broken whenever the directory changes (unless the delegation is set
+ * up to ignore the event). This function can block waiting for the lease
+ * break unless you specify LEASE_BREAK_NONBLOCK.
  */
 int __break_lease(struct inode *inode, unsigned int flags)
 {
@@ -1655,6 +1692,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		if (!leases_conflict(&fl->c, &new_fl->c))
 			continue;
+		if (S_ISDIR(inode->i_mode) && ignore_dir_deleg_break(fl, flags))
+			continue;
 		if (want_write) {
 			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 				continue;
@@ -1670,7 +1709,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 			locks_delete_lock_ctx(&fl->c, &dispose);
 	}
 
-	if (list_empty(&ctx->flc_lease))
+	if (!visible_leases_remaining(inode, flags))
 		goto out;
 
 	if (flags & LEASE_BREAK_NONBLOCK) {
diff --git a/fs/namei.c b/fs/namei.c
index 9e5500dad14f..e3cbd9f877bd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4176,7 +4176,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, di);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, true);
@@ -4475,7 +4475,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -5091,7 +5091,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		return error;
 
@@ -5232,7 +5232,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		goto err;
 
@@ -5337,7 +5337,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_DELETE, delegated_inode);
 	if (error)
 		goto out;
 
@@ -5467,10 +5467,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
-			error = try_break_deleg(dir, delegated_inode);
+			error = try_break_deleg(dir, LEASE_BREAK_DIR_DELETE, delegated_inode);
 			if (error)
 				goto out;
-			error = try_break_deleg(target, delegated_inode);
+			error = try_break_deleg(target, 0, delegated_inode);
 			if (error)
 				goto out;
 			error = dir->i_op->unlink(dir, dentry);
@@ -5614,7 +5614,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = try_break_deleg(dir, delegated_inode);
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 	if (error)
 		return error;
 
@@ -5745,9 +5745,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
 	else {
-		error = try_break_deleg(dir, delegated_inode);
+		error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (!error)
-			error = try_break_deleg(inode, delegated_inode);
+			error = try_break_deleg(inode, 0, delegated_inode);
 		if (!error)
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
@@ -6011,21 +6011,24 @@ int vfs_rename(struct renamedata *rd)
 		    old_dir->i_nlink >= max_links)
 			goto out;
 	}
-	error = try_break_deleg(old_dir, delegated_inode);
+	error = try_break_deleg(old_dir,
+				old_dir == new_dir ? LEASE_BREAK_DIR_RENAME :
+						     LEASE_BREAK_DIR_DELETE,
+				delegated_inode);
 	if (error)
 		goto out;
 	if (new_dir != old_dir) {
-		error = try_break_deleg(new_dir, delegated_inode);
+		error = try_break_deleg(new_dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (error)
 			goto out;
 	}
 	if (!is_dir) {
-		error = try_break_deleg(source, delegated_inode);
+		error = try_break_deleg(source, 0, delegated_inode);
 		if (error)
 			goto out;
 	}
 	if (target && !new_is_dir) {
-		error = try_break_deleg(target, delegated_inode);
+		error = try_break_deleg(target, 0, delegated_inode);
 		if (error)
 			goto out;
 	}
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 12591c95c925..b4bfe4ddf64e 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1126,7 +1126,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = try_break_deleg(inode, &delegated_inode);
+	error = try_break_deleg(inode, 0, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
 
@@ -1234,7 +1234,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	error = try_break_deleg(inode, &delegated_inode);
+	error = try_break_deleg(inode, 0, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 3e49e612e1ba..6b67a6e76eeb 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -288,7 +288,7 @@ __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(inode, delegated_inode);
+	error = try_break_deleg(inode, 0, delegated_inode);
 	if (error)
 		goto out;
 
@@ -546,7 +546,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 	if (error)
 		goto out;
 
-	error = try_break_deleg(inode, delegated_inode);
+	error = try_break_deleg(inode, 0, delegated_inode);
 	if (error)
 		goto out;
 
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 5f0a2fb31450..5a19cdb047da 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -4,19 +4,22 @@
 
 #include <linux/fs.h>
 
-#define FL_POSIX	1
-#define FL_FLOCK	2
-#define FL_DELEG	4	/* NFSv4 delegation */
-#define FL_ACCESS	8	/* not trying to lock, just looking */
-#define FL_EXISTS	16	/* when unlocking, test for existence */
-#define FL_LEASE	32	/* lease held on this file */
-#define FL_CLOSE	64	/* unlock on close */
-#define FL_SLEEP	128	/* A blocking lock */
-#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
-#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
-#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
-#define FL_LAYOUT	2048	/* outstanding pNFS layout */
-#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define FL_POSIX		BIT(0)	/* POSIX lock */
+#define FL_FLOCK		BIT(1)	/* BSD lock */
+#define FL_LEASE		BIT(2)	/* file lease */
+#define FL_DELEG		BIT(3)	/* NFSv4 delegation */
+#define FL_LAYOUT		BIT(4)	/* outstanding pNFS layout */
+#define FL_ACCESS		BIT(5)	/* not trying to lock, just looking */
+#define FL_EXISTS		BIT(6)	/* when unlocking, test for existence */
+#define FL_CLOSE		BIT(7)	/* unlock on close */
+#define FL_SLEEP		BIT(8)	/* A blocking lock */
+#define FL_DOWNGRADE_PENDING	BIT(9)	/* Lease is being downgraded */
+#define FL_UNLOCK_PENDING	BIT(10) /* Lease is being broken */
+#define FL_OFDLCK		BIT(11) /* POSIX lock "owned" by struct file */
+#define FL_RECLAIM		BIT(12) /* reclaiming from a reboot server */
+#define FL_IGN_DIR_CREATE	BIT(13) /* ignore DIR_CREATE events */
+#define FL_IGN_DIR_DELETE	BIT(14) /* ignore DIR_DELETE events */
+#define FL_IGN_DIR_RENAME	BIT(15) /* ignore DIR_RENAME events */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -222,6 +225,10 @@ struct file_lease *locks_alloc_lease(void);
 #define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
 #define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
 #define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
+#define LEASE_BREAK_DIR_CREATE		BIT(6)  // dir deleg create event
+#define LEASE_BREAK_DIR_DELETE		BIT(7)  // dir deleg delete event
+#define LEASE_BREAK_DIR_RENAME		BIT(8)  // dir deleg rename event
+
 
 int __break_lease(struct inode *inode, unsigned int flags);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
@@ -516,12 +523,26 @@ static inline bool is_delegated(struct delegated_inode *di)
 	return di->di_inode;
 }
 
-static inline int try_break_deleg(struct inode *inode,
+/**
+ * try_break_deleg - do a non-blocking delegation break
+ * @inode: inode that should have its delegations broken
+ * @flags: extra LEASE_BREAK_* flags to pass to break_deleg()
+ * @di: returns pointer to delegated inode (may be NULL)
+ *
+ * Break delegations in a non-blocking fashion. If there are
+ * outstanding delegations and @di is set, then an extra reference
+ * will be taken on @inode and @di->di_inode will be populated so
+ * that it may be waited upon.
+ *
+ * Returns 0 if there is no need to wait or an error. If -EWOULDBLOCK
+ * is returned, then @di will be populated (if non-NULL).
+ */
+static inline int try_break_deleg(struct inode *inode, unsigned int flags,
 				  struct delegated_inode *di)
 {
 	int ret;
 
-	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
+	ret = break_deleg(inode, flags | LEASE_BREAK_NONBLOCK);
 	if (ret == -EWOULDBLOCK && di) {
 		di->di_inode = inode;
 		ihold(inode);
@@ -574,7 +595,7 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
-static inline int try_break_deleg(struct inode *inode,
+static inline int try_break_deleg(struct inode *inode, unsigned int flags,
 				  struct delegated_inode *delegated_inode)
 {
 	return 0;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 370016c38a5b..ef4bb0afb86a 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -28,7 +28,10 @@
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
 		{ FL_OFDLCK,		"FL_OFDLCK" },			\
-		{ FL_RECLAIM,		"FL_RECLAIM"})
+		{ FL_RECLAIM,		"FL_RECLAIM" },			\
+		{ FL_IGN_DIR_CREATE,	"FL_IGN_DIR_CREATE" },		\
+		{ FL_IGN_DIR_DELETE,	"FL_IGN_DIR_DELETE" },		\
+		{ FL_IGN_DIR_RENAME,	"FL_IGN_DIR_RENAME" })
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\

-- 
2.53.0


