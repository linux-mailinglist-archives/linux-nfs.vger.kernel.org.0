Return-Path: <linux-nfs+bounces-20876-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEQeLHYe4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20876-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:37:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B159412EBC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F36A630FAF38
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F533688C;
	Thu, 16 Apr 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of8khSPk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195B33555B;
	Thu, 16 Apr 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360941; cv=none; b=QvG2JdCG/PaMWmk7kPEvlI2SZ93CfqD4osnl6Rnf/8JryoYD5ixVrre/GYiaD/G13jQOOEJtCFP8IZf1v8PjxOy+v6L6MKP+3LtcQxfdsMRfufJD8zVeS/YP/RJPLSYUsb222n0Zm7etsvmhYXC/XPkKGyCwf52pz+oKkwtkhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360941; c=relaxed/simple;
	bh=pB0N2i+uhHtG08aLQau3aXhTlxfd8Ebh8CUN+lCF0/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHRRhppCmHkEqDGH+fuT5D7bMwaBQGzEFPT0RVJGLMCW0jf9ymCJ+FGWzw/hx5V6ghxQHvvuy5TL8tLUe8+vwtPfZcT37BSHr1jeXwu9ogP41lrmpqy9nBywQm7UKxqj9B3YkJdAv6kn5/UB+sKnpdqnTgTGgZ4RypYJGhdSir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of8khSPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7755C2BCC6;
	Thu, 16 Apr 2026 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360939;
	bh=pB0N2i+uhHtG08aLQau3aXhTlxfd8Ebh8CUN+lCF0/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Of8khSPkxuR3w6zqy5QqZtezEvT05iGVcD4aT3rFnFmtTqzHifFgju1p3vvQx6LgN
	 NW4Hraj8E6/7VyQxJR8tObNisP2Sf3GGHQJqLpWVcvqDfrIRlHqtcjnLz9034lsry0
	 n1Sam8hPAxV/jBNDVG/3Z/ewYBDW8ri4YdoAskxzKIX4/GxH+SUnotWQIIeOEppw1K
	 7PuHL8UbtWZ0o7D8EtXfdYIiXTwCl8dP/vdrU6CPsGZSzMBds3XfbvDvRUk5sqcKWj
	 MlbZgZdAB9oA09D2u5h0bv1W4AEBY31kF3K9rrnKzgp+GOhLrfo3bbbHj3SfurT9/y
	 wYQsAKjyE9nyw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:03 -0700
Subject: [PATCH v2 02/28] filelock: add support for ignoring deleg breaks
 for dir change events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-2-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16023; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pB0N2i+uhHtG08aLQau3aXhTlxfd8Ebh8CUN+lCF0/4=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGnhHeGglkaFf/0b9fO0/HZ4XOyrAGseBw3z2N4NQc5OXVQjz
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJp4R3hAAoJEAAOaEEZVoIVpZAQAItM
 +Awe8bD7PZjdnhxEutLlNgpO7nrtVuswLQkgNfAjeFYf8CJZHWol3ChSfPFZ96AIbWRlFMmy/5U
 5KQR7lFFcUaywOSPG8g/U5Nm6F4DLstZ/GZXFVQbV3qVCvI5BEpPl0RjjBmKNgem5LIjci6ShWW
 jSYmqHubsnCgvXaW8c2pnM4FJfxfO9BJJ5wWtR790fq1WdUB8m7jL9c1MILCMk9uN8l1VwxU9qD
 7P2MijHU1JGAE2sOP8FBaankwfI5dBuXsiQq1KZhI16njFJbLr1O++jW4C4CY9xc8271b/wia3d
 XETcc3OlT8nMKDAXBCz6i5g2vwJGQZDCFkDi34nvWYvGc7zCDyrmH1x1sdDqa1HkUp+/GSJG44m
 ynmV3ojEWLk+mc5Pythheb+cHmmx9KXY5oJMsC62JzBeDwdowOlYARU99bVhS+/Yt+sdbrXyaqx
 fQXFMIP0Ien6+eBoO1CqyhTQs5iwFRFhHh9y6kSUHO3Qx+aHmng9F7ZJaXNgwBai/5MhTMrzr6y
 /x5hOYHn10PBIfwgL4fLDC4tdJT6jPBiwRo+QLfCTCJuJzjs3oXt48l/ZHTyEwHXWk9M9VY7oLd
 y/VEEt2CX2X4YM+4/4UMChBBC1KLd4sGDF1DillF/+m5qalfnOmIe55IVT+eMXTW9Gvn/DQ5Tg7
 EFXyL
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20876-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B159412EBC
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
 fs/locks.c                      | 82 ++++++++++++++++++++++++++++-------------
 fs/namei.c                      | 31 +++++++++-------
 fs/posix_acl.c                  |  4 +-
 fs/xattr.c                      |  4 +-
 include/linux/filelock.h        | 53 ++++++++++++++++++--------
 include/trace/events/filelock.h |  5 ++-
 7 files changed, 120 insertions(+), 61 deletions(-)

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
index d82c5be7aa5b..8b5958f34b61 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1583,29 +1583,63 @@ static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc
 }
 
 static bool
-any_leases_conflict(struct inode *inode, struct file_lease *breaker)
+ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
 {
-	struct file_lock_context *ctx = inode->i_flctx;
-	struct file_lock_core *flc;
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
+static unsigned int
+break_lease_flags_to_type(unsigned int flags)
+{
+	if (flags & LEASE_BREAK_LEASE)
+		return FL_LEASE;
+	else if (flags & LEASE_BREAK_DELEG)
+		return FL_DELEG;
+	else if (flags & LEASE_BREAK_LAYOUT)
+		return FL_LAYOUT;
+	else
+		return 0;
+
+}
+
+static struct file_lease *
+first_visible_lease(struct inode *inode, struct file_lease *new_fl, unsigned int flags)
+{
+	struct file_lock_context *ctx = locks_inode_context(inode);
+	struct file_lease *fl;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
-		if (leases_conflict(flc, &breaker->c))
-			return true;
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+		if (!leases_conflict(&fl->c, &new_fl->c))
+			continue;
+		if (S_ISDIR(inode->i_mode) && ignore_dir_deleg_break(fl, flags))
+			continue;
+		return fl;
 	}
-	return false;
+	return NULL;
 }
 
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
@@ -1617,13 +1651,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
-	if (flags & LEASE_BREAK_LEASE)
-		type = FL_LEASE;
-	else if (flags & LEASE_BREAK_DELEG)
-		type = FL_DELEG;
-	else if (flags & LEASE_BREAK_LAYOUT)
-		type = FL_LAYOUT;
-	else
+	type = break_lease_flags_to_type(flags);
+	if (!type)
 		return -EINVAL;
 
 	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
@@ -1642,7 +1671,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 
 	time_out_leases(inode, &dispose);
 
-	if (!any_leases_conflict(inode, new_fl))
+	if (!first_visible_lease(inode, new_fl, flags))
 		goto out;
 
 	break_time = 0;
@@ -1655,6 +1684,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		if (!leases_conflict(&fl->c, &new_fl->c))
 			continue;
+		if (S_ISDIR(inode->i_mode) && ignore_dir_deleg_break(fl, flags))
+			continue;
 		if (want_write) {
 			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 				continue;
@@ -1670,7 +1701,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 			locks_delete_lock_ctx(&fl->c, &dispose);
 	}
 
-	if (list_empty(&ctx->flc_lease))
+	fl = first_visible_lease(inode, new_fl, flags);
+	if (!fl)
 		goto out;
 
 	if (flags & LEASE_BREAK_NONBLOCK) {
@@ -1680,7 +1712,6 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	}
 
 restart:
-	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
 	break_time = fl->fl_break_time;
 	if (break_time != 0) {
 		if (time_after(jiffies, break_time)) {
@@ -1711,7 +1742,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 		 */
 		if (error == 0)
 			time_out_leases(inode, &dispose);
-		if (any_leases_conflict(inode, new_fl))
+		fl = first_visible_lease(inode, new_fl, flags);
+		if (fl)
 			goto restart;
 		error = 0;
 	}
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
index 5f0a2fb31450..9dd4e67a6f30 100644
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
+#define FL_DELEG		BIT(2)	/* NFSv4 delegation */
+#define FL_ACCESS		BIT(3)	/* not trying to lock, just looking */
+#define FL_EXISTS		BIT(4)	/* when unlocking, test for existence */
+#define FL_LEASE		BIT(5)	/* file lease */
+#define FL_CLOSE		BIT(6)	/* unlock on close */
+#define FL_SLEEP		BIT(7)	/* A blocking lock */
+#define FL_DOWNGRADE_PENDING	BIT(8)	/* Lease is being downgraded */
+#define FL_UNLOCK_PENDING	BIT(9)	/* Lease is being broken */
+#define FL_OFDLCK		BIT(10) /* POSIX lock "owned" by struct file */
+#define FL_LAYOUT		BIT(11) /* outstanding pNFS layout */
+#define FL_RECLAIM		BIT(12) /* reclaiming from a reboot server */
+#define FL_IGN_DIR_CREATE	BIT(13) /* ignore DIR_CREATE events */
+#define FL_IGN_DIR_DELETE	BIT(14) /* ignore DIR_DELETE events */
+#define FL_IGN_DIR_RENAME	BIT(15) /* ignore DIR_RENAME events */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -222,6 +225,10 @@ struct file_lease *locks_alloc_lease(void);
 #define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
 #define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
 #define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
+#define LEASE_BREAK_DIR_CREATE		BIT(5)  // dir deleg create event
+#define LEASE_BREAK_DIR_DELETE		BIT(6)  // dir deleg delete event
+#define LEASE_BREAK_DIR_RENAME		BIT(7)  // dir deleg rename event
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


