Return-Path: <linux-nfs+bounces-22873-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WOjkCHAaQmoU0QkAu9opvQ
	(envelope-from <linux-nfs+bounces-22873-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:10:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75F6D6CC8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:10:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=IH4WA187;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22873-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22873-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68315303418C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4183BB9F7;
	Mon, 29 Jun 2026 07:00:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA63B42F3;
	Mon, 29 Jun 2026 07:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716401; cv=none; b=Mjy8EsmTB81wrnRQDcpqC0mlK+US5ukra+uXh6iOsdCtz4/WBWacs+xIrDurtvLXv9P4oJ4tOM/juDBPjTQrFFnbfN5lzbaUnDQ5pkc6kXlK2479EKWTvq5tqQj1VK4ymJqZyosy3PiTffcux/VDQl8ftt1X7o71pKsryX9l0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716401; c=relaxed/simple;
	bh=3Bh67Rhear4HXJlB0f6oEBZ06ayAUssQ/AE/W391kzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko/5k1qRwtBzenbigRjA3uFAUeBp0RHC68VCgFtssKAulttQHirhE2nHUPd2MReC+oowDOkrBedGjq54SXikmGSQCzhYiqsHl581SGV3L3zqp7PsiKfztD/fzlCtrDkTmUzT65guZe+9Ba2Kf0m+Dssz2TuEfPKohmaxwIZODlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IH4WA187; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 969AA1380258;
	Mon, 29 Jun 2026 02:59:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 02:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782716399; x=1782723599; bh=H
	d9u+t0/JHPpivou+bxOeaCLs9z6hVwj5BRfCRd9pA4=; b=IH4WA187U/MCF1d3x
	1UmGq9duRqqTxw6nF9lOixCYrjcjpb6R1b+OATva2zDK3lb4MpTkmrOCLYFnVCis
	v6w5H+kC6ptT9vr4MuZMmcJ1CtcKw6NtoHdks2lCnQFtL5omDmFjOHaqMdd4vbAO
	M5Fi9JjZduzknzcmdvHJj0thi/dmGRQQbM1f3NgJ0by9rzTPbSThdRGi2CWHRgx9
	S0hOpapWTInuZGJPtaRbNZD/HdsN5qUGmvIg7jTh7KeyUJsqn8f08ZH39gzFAdEW
	Xo/uv47+zJgfIUz+wl66hgX3rM/Sm+CI+D3Obznn0+OYVPNsdqyeJ8L5bTTfYAhP
	4E96Q==
X-ME-Sender: <xms:7xdCahvf0qiFHol3EpQDUrO5B494alqmQiYIrIZacqCBG5vRa9H4Cw>
    <xme:7xdCatF_FAH4pMn1FTfb41dUY4fq-dE4d8ZlQwTaOcDbUGvjxFlCFhlbpOlfoPwzS
    CzgbXOiVOD5b6RVNgitZK7NwA6umrsi4YRsOonXeQ5ewjjPsRCzgAQ>
X-ME-Received: <xmr:7xdCakTgVU0HmeQe6xk7tK0i16b6iRMnSTt48rD1D9g_qnnAXuK_80DckBrU-gh_dxRq4mi-9DPyAkTvpIMDuj16FbNEDtamH1-HWQ>
X-ME-Proxy-Cause: dmFkZTE0TOhd9GbmDkyBsP8X2baFSR0qTjJdUi6Ie/aj/g72xxX3zNyKsxkgBZ9ESQl03P
    LQPUDeJdZQoIfDiTF4xYBZDu4UT1y35l589JB+VUT++SfVV5IcOKkVnN4SE0hoXSmKZ1GK
    DowX4uJqKI+AHa+AetMPrwiEYeHd3DQFZ6eYAH7+c/BFMO75TUZYTcJ60oTfOlBwkPa/pX
    st7TD866HPwuZ0Cleh67bqmxefO2KGsN+3Zm/++28D95+zsxrztHGsMFsHIlQfiH0UJ6O8
    v2/wLFjdcEjuoauSbbFt5mZA2xvCfD9U+MpGQjt0xYUcqaQNS8q1rCCtprtzDJbGcZYjnN
    8ArE5QmedQuLd2p96JgdtGdbi+LeuocEciAf9qVnjSRFGQ3RN71TXNCfROsR2PN+94VlwI
    8jl/oUD4wuyo8uQosEYifCNYvRQ3aGWrwrH3Mm0mb19f5ZfGMBLL1TDGZqpyEVHZfJFEZw
    F4YSukoLT2FFBDrSPtwyuWF9Bvt4EhQrvlxIr07Sd+r/UIj27Y7VZM0clxKev3JN7M8OLw
    3rgt+sSE8D4hu3/y9eAdCsRn1I7ybJUCiLSXzEvYUfoUx//6nFP7/iTTTussFg7jNyoDrV
    Rn03i4kUBV3nFLwWehQNQHhyPghpOC7ZFcCLqT2wKDMOaGc5bMQ+8ozZdZqA
X-ME-Proxy: <xmx:7xdCapiIQ3tDxsiDvmZWPhFo5mPtE_Xd5VURTPRzeaSc_vpf9rmEww>
    <xmx:7xdCagbfC8gNrBkqWNFFG35wbbFPIE3J1FfsFuekcKhRIaod_-9-kA>
    <xmx:7xdCaiVbiJ6Ut3iF-S88vEPdhfNwRWz5twFfW0kzapcFkHJoNQmd3A>
    <xmx:7xdCaha4zqlLHUAgiF1QmCAUVnPyjdr9Nv75wnTuqMW7AeEe_i5tcQ>
    <xmx:7xdCammyCyxEbrXYFVL8s_NLNAZ1mbE-hp0ZK0GE-DdLQvWWndcRRRw6>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:59:58 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "Andy Lutomirski" <luto@kernel.org>,	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,	"Jan Kara" <jack@suse.cz>,
	"David Howells" <dhowells@redhat.com>,	"Chuck Lever" <cel@kernel.org>,
	"Jeff Layton" <jlayton@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"David Laight" <david.laight.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,	"Li Chen" <me@linux.beauty>,
	"Cong Wang" <cwang@multikernel.io>,	"Arnd Bergmann" <arnd@arndb.de>,
	"Thomas Gleixner" <tglx@kernel.org>,	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"Jonathan Corbet" <corbet@lwn.net>,	"Kees Cook" <kees@kernel.org>,
	"Sergei Zimmerman" <sergei@zimmerman.foo>,
	"Farid Zakaria" <farid.m.zakaria@gmail.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-api <linux-api@vger.kernel.org>,	netfs <netfs@lists.linux.dev>,
	linux-nfs <linux-nfs@vger.kernel.org>
Cc: John Ericson <mail@JohnEricson.me>
Subject: [RFC PATCH 2/3] fs: support tasks with a null root or cwd
Date: Mon, 29 Jun 2026 02:58:21 -0400
Message-ID: <20260629065934.1425479-3-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
References: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-22873-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,linuxfoundation.org,gmail.com,zytor.com,linux.beauty,multikernel.io,arndb.de,alien8.de,linux.intel.com,lwn.net,zimmerman.foo,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:cel@kernel.org,m:jlayton@kernel.org,m:skhan@linuxfoundation.org,m:david.laight.linux@gmail.com,m:hpa@zytor.com,m:me@linux.beauty,m:cwang@multikernel.io,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:corbet@lwn.net,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:netfs@lists.linux.dev,m:linux-nfs@vger.kernel.org,m:mail@JohnEricson.me,m:davidlaightlinux@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,johnericson.me:email,Obsidian.Systems:mid,Obsidian.Systems:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B75F6D6CC8

From: John Ericson <mail@JohnEricson.me>

A task's root directory (`fs->root`) and current working directory
(`fs->pwd`) are normally established by `chroot(2)`/`pivot_root(2)` and
`chdir(2)`/`fchdir(2)` (or inherited across `fork(2)`). Allow either to
instead be the null path, as documented in `struct fs_struct`. The two
are independent: a task may opt out of one, the other, or both.

A task with no root cannot use absolute pathnames, and its `..` is no
longer bounded by a process root: it climbs to the root of the mount the
walk is in (the security implications are discussed in `struct
fs_struct`). A task with no cwd cannot use `AT_FDCWD`-relative
pathnames. Either way it can still name files through the `*at(2)`
descriptors it holds.

Teach the readers of these fields to cope instead of dereferencing the
NULL dentry, each checking the field it uses:

- namei: `set_root()` now tolerates a NULL root (skipping the
  `nd->root.dentry->d_seq` read), so `nd_jump_root()` returns `-ENOENT`
  for absolute paths and symlinks, while `..` falls through to
  `follow_dotdot()` -- which already treats a NULL `nd->root` as "no
  boundary" and climbs. The `AT_FDCWD` legs of `path_init()` return
  `-ENOENT` with no cwd; real-dirfd lookups (`openat(2)`, `openat2(2)`)
  are unaffected.

- `getcwd(2)`, `/proc/PID/{root,cwd}`, `open_by_handle_at()` with
  `AT_FDCWD`, and the cachefiles `cull`/`inuse` commands return an error
  rather than dereferencing the NULL path.

The setters need no change: `chdir(2)`/`chroot(2)`/`pivot_root(2)`
resolve via `filename_lookup(AT_FDCWD, ...)`, which simply fails with no
root or cwd, and `fchdir(2)` installs a cwd from an fd without
consulting the old one. `d_path()` is unaffected: `__prepend_path()`
only compares against the root.

These opt-outs are not sticky; keeping a task rootless or cwd-less is an
orthogonal policy decision (e.g. seccomp filtering the setters above).

Link: https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/
Signed-off-by: John Ericson <mail@JohnEricson.me>
Assisted-by: Claude:claude-opus-4-8
---
 fs/cachefiles/daemon.c    |  6 ++++--
 fs/d_path.c               |  6 +++++-
 fs/fhandle.c              |  3 +++
 fs/namei.c                | 22 ++++++++++++++++++++--
 fs/proc/base.c            |  8 ++++++--
 include/linux/fs_struct.h | 13 +++++++++++++
 6 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 4117b145ac94..344feeb89c61 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -652,7 +652,8 @@ static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 
 	get_fs_pwd(current->fs, &path);
 
-	if (!d_can_lookup(path.dentry))
+	/* A task may have no cwd. */
+	if (!path.mnt || !d_can_lookup(path.dentry))
 		goto notdir;
 
 	cachefiles_begin_secure(cache, &saved_cred);
@@ -723,7 +724,8 @@ static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 
 	get_fs_pwd(current->fs, &path);
 
-	if (!d_can_lookup(path.dentry))
+	/* A task may have no cwd. */
+	if (!path.mnt || !d_can_lookup(path.dentry))
 		goto notdir;
 
 	cachefiles_begin_secure(cache, &saved_cred);
diff --git a/fs/d_path.c b/fs/d_path.c
index a48957c0971e..5f16d1efa37c 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -422,7 +422,11 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 	rcu_read_lock();
 	get_fs_root_and_pwd_rcu(current->fs, &root, &pwd);
 
-	if (unlikely(d_unlinked(pwd.dentry))) {
+	/* A task may have no cwd. */
+	if (unlikely(!pwd.mnt)) {
+		rcu_read_unlock();
+		error = -ENOENT;
+	} else if (unlikely(d_unlinked(pwd.dentry))) {
 		rcu_read_unlock();
 		error = -ENOENT;
 	} else {
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 1ca7eb3a6cb5..560f88f53633 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -180,6 +180,9 @@ static int get_path_anchor(int fd, struct path *root)
 
 	if (fd == AT_FDCWD) {
 		get_fs_pwd(current->fs, root);
+		/* A task may have no cwd. */
+		if (!root->mnt)
+			return -ENOENT;
 		return 0;
 	}
 
diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..06b16815e866 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1120,11 +1120,20 @@ static int set_root(struct nameidata *nd)
 		do {
 			seq = read_seqbegin(&fs->seq);
 			nd->root = fs->root;
-			nd->root_seq = __read_seqcount_begin(&nd->root.dentry->d_seq);
+			/*
+			 * A task may have no root. Leave nd->root as the NULL
+			 * path and skip the d_seq read: absolute lookups turn
+			 * the absence into -ENOENT in nd_jump_root(), while ".."
+			 * treats a NULL root as "no boundary" and climbs to its
+			 * mount root.
+			 */
+			if (likely(nd->root.mnt))
+				nd->root_seq = __read_seqcount_begin(&nd->root.dentry->d_seq);
 		} while (read_seqretry(&fs->seq, seq));
 	} else {
 		get_fs_root(fs, &nd->root);
-		nd->state |= ND_ROOT_GRABBED;
+		if (likely(nd->root.mnt))
+			nd->state |= ND_ROOT_GRABBED;
 	}
 	return 0;
 }
@@ -1143,6 +1152,9 @@ static int nd_jump_root(struct nameidata *nd)
 		if (unlikely(error))
 			return error;
 	}
+	/* Absolute paths need a root to jump to; a task may have none. */
+	if (unlikely(!nd->root.mnt))
+		return -ENOENT;
 	if (nd->flags & LOOKUP_RCU) {
 		struct dentry *d;
 		nd->path = nd->root;
@@ -2732,11 +2744,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			do {
 				seq = read_seqbegin(&fs->seq);
 				nd->path = fs->pwd;
+				/* A task may have no cwd. */
+				if (unlikely(!nd->path.mnt))
+					return ERR_PTR(-ENOENT);
 				nd->inode = nd->path.dentry->d_inode;
 				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
 			} while (read_seqretry(&fs->seq, seq));
 		} else {
 			get_fs_pwd(current->fs, &nd->path);
+			/* A task may have no cwd. */
+			if (unlikely(!nd->path.mnt))
+				return ERR_PTR(-ENOENT);
 			nd->inode = nd->path.dentry->d_inode;
 		}
 	} else {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..7f7cc86ce262 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -213,7 +213,9 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	task_lock(task);
 	if (task->fs) {
 		get_fs_root(task->fs, root);
-		result = 0;
+		/* A task may have no root. */
+		if (root->mnt)
+			result = 0;
 	}
 	task_unlock(task);
 	return result;
@@ -227,7 +229,9 @@ static int proc_cwd_link(struct dentry *dentry, struct path *path,
 	task_lock(task);
 	if (task->fs) {
 		get_fs_pwd(task->fs, path);
-		result = 0;
+		/* A task may have no cwd. */
+		if (path->mnt)
+			result = 0;
 	}
 	task_unlock(task);
 	return result;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index b5db5de9eb01..84423b4bd21a 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -13,18 +13,31 @@ struct fs_struct {
 	int umask;
 	int in_exec;
 
+	/*
+	 * Note that these paths are explicitly intended to be nullable.
+	 * Since they are inline structs and not pointers, we use `.mnt
+	 * == NULL` to indicate nullability of the path as a whole.
+	 */
+
 	/*
 	 * The root directory for the task(s) that points to this
 	 * `fs_struct`. The root directory also controls how `..`
 	 * resolve; path traversal is not allowed to resolve upwards
 	 * beyond the root directory. (It is for this latter reason that
 	 * `chroot` is a privileged operation.)
+	 *
+	 * If null (as described above), absolute paths will not
+	 * resolve. In addition `..` will be unbounded, until one
+	 * reaches the top of the mount tree.
 	 */
 	struct path root;
 
 	/*
 	 * The current working directory for the task(s) that points to
 	 * this `fs_struct`.
+	 *
+	 * If null (as described above), relative paths with `AT_FDCWD`
+	 * will not resolve.
 	 */
 	struct path pwd;
 } __randomize_layout;
-- 
2.51.2


