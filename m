Return-Path: <linux-nfs+bounces-21139-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEEJIj7h7mk6zQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21139-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D938A46CE07
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA17A30166E2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D3299A84;
	Mon, 27 Apr 2026 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aGgp10yP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tK5vndnm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F7258EC1;
	Mon, 27 Apr 2026 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262778; cv=none; b=kGm8GYV9Mx4bV2/Az4Bgz0oqOEaHDSOfi2bH3SRcWXnVS6Bv3ZmzUurHDI4iHSFLBGskGcZ3wgSkkO9i2j8g0KaFUQ53hW0O1ZPGCwtZfJkac9EgXkj54Wv2OPKmFj48USJ07OPb3HKdI+Q1yrHNliNqXitSUDTyotcjyZojeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262778; c=relaxed/simple;
	bh=CfKT9Gn4c1XhDbo0WloY/nniuKRLh4xGe4NRIk+ECX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyoU9uI303Xe5weBy8fMtJOGENdFp6aImhzQAMnGvn3yUmXFKTTeWV/ngGoiCrFgJXYkNVh67HpN5w/QfgMUyDdrosJlK5dPvT0W60x7p8TaRjDawbOGzgJ+rij3Em9iEQlI7RqsJdQTY0vG0okW8H9ZDqc5NlTDon20KQspAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aGgp10yP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tK5vndnm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BACB51400018;
	Mon, 27 Apr 2026 00:06:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 00:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262775;
	 x=1777349175; bh=M+q69xEVOxYDlLesgsc7OKN8RwYSBXfFhfRK/I9my0w=; b=
	aGgp10yP76Wkf65zuOzOBpCLDu7ydSxEm6packZGwr2eZgcjA+YNLQTDg1Bpuh7K
	9QLCvpRf4UK+ALH8wcetH1QeoBwfJHmoAOzoW7tEcRRxCd1P41RlFLt3fH/6wega
	ajznoda773+jYmR+ddmn+B+fm0gSX11GRSVtt3uuy7r5cZSpRiDuET3SHtx+pRaP
	TPslxDaoKja6csPL8cMjzPXdidBx/kDR+tsuq2VVQBlByIkbhRmHhvqZHGwZKPz0
	XyXJnmkzDPcNv5MN6C+/abt8BSBk9m2ailHozh0FinGWsBABGQU4eST80gmTvAgl
	KTMTnhXGDmy3XaOKRd2FzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262775; x=1777349175; bh=M
	+q69xEVOxYDlLesgsc7OKN8RwYSBXfFhfRK/I9my0w=; b=tK5vndnmd6XjEVb0P
	yxt70x/JVJyWWTPpYoQVz+Ixbd0RHQOgcb/WI58dJvaUlJH/B3lGDZ8RPVYRKtMf
	KES6l4AgU7thYnnr/tPEFjBbLYvq9DrfAMrg8GsSPUG9LwlxmOcbz6ivB7iLKt1t
	e8z/QSSuiTRnEU+0yN5Lwvu4qy9HQtOsIAcTYsS2kqPdjw4rCokoVec6Q47hD//P
	rUJXgAAzvGITD+YsieXWjJoxaooZLjE4brOd/epNxBfWxo2ZVLYurO+z2kTJ2jsm
	oBCyjjMs+yGgMsp1tbHekEWzX2RhIXtnNlWwvsUYdnYdAejJU7WhgUUSLP6TBuKz
	ARvlw==
X-ME-Sender: <xms:t-DuafRudh7cgW3ACbhjWIcJpqA9iwXCW4K7Uek6lJbkI9e7y3SVNg>
    <xme:t-DuadE_ju5GEHpai666lbapgRxk8hXcFtlfJV6X-n-WApNXxz1J0Yx-Xp3qFBg31
    FtiLnhhEQQlQZRRs5pIIvHQSWuIvYsuV3DqyfFiqVsjZId12A>
X-ME-Received: <xmr:t-DuaWeUiCxwpWtMd_YNWonOwOV509XpbWsqzzEODiLkG9T3Z3UN1PTyOo0rloKlBlAJCshh-7PhWtQ-L-QPIDOyq1fFUVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:t-DuacJ4tBW3w6rT8QBdX3K6VVEOD5b2KSMJb4vcSxt1TroB8GGB9Q>
    <xmx:t-DuadpSD7SnoKoLtiYjTzp-LNt0tCuxCCSPPVMiKyTBRiI82xSYwQ>
    <xmx:t-DuaaX7k_5AeyLxnESEX7zs-tDQ1XAfqMz0qOvM_sO5CIsyBtVzog>
    <xmx:t-DuaQ0W9HciOULkx2h3xr0-IbOpHSNWQejAsQ4GPXyKdDS5QgxFVQ>
    <xmx:t-DuaSgxWWZt2Yl8J8M5FyClmxxVzlVRU5pvc1X7PZGD-75q18QYCc9o>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:06:10 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
Date: Mon, 27 Apr 2026 14:01:22 +1000
Message-ID: <20260427040517.828226-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427040517.828226-1-neilb@ownmail.net>
References: <20260427040517.828226-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D938A46CE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21139-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
This must have a life time which extends until the lookup is completed.

This makes it awkward to use and particularly make it hard to use in
lookup_one_qstr_excl() which I hope to do in the future.

This patch changes d_alloc_parallel() to use wake_up_var_locked() to
wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
is used for synchronisation as it is already held and the relevant
times.

In most cases there will be no waiters so the wake_up_var_locked()
call is a complete waste.  To optimise this a new ->d_flags flag is
added: DCACHE_LOCK_WAITERS.  This is set whenever any thread prepares to
wait for the dentry, and if it isn't set when DCACHE_PAR_LOOKUP is
cleared, no wakeup is sent.
(The name is deliberately generic as I plan to replace DCACHE_PAR_LOOKUP
with more generic per-dentry locking in the future).

__d_lookup_unhash() now returns a bool rather than a wq.  This is true
if DCACHE_LOCK_WAITERS was sent and is used to decide to send the wake
up.  It would be easier to send the wakeup immediately when clearing
DCACHE_LOCK_WAITERS, but then the waiter could wake a bit earlier and
then spend time spinning on ->d_lock.  I don't know if that cost is
interesting.

__d_lookup_unhash() no longer needs to re-init ->d_lru.  That was
previously shared (in a union) with ->d_wait but ->d_wait is now gone
so it no longer corrupts ->d_lru.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 64 ++++++++++++---------------
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +--
 fs/nfs/dir.c                          |  6 +--
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                | 11 +++--
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bfdff4608028..85c7b2007f8c 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1385,3 +1385,10 @@ for_each_alias(dentry, inode) instead of hlist_for_each_entry; better
 yet, see if any of the exported primitives could be used instead of
 the entire loop.  You still need to hold ->i_lock of the inode over
 either form of manual loop.
+
+---
+
+**mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.
+
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index a748fd133faf..982bb6ec15f0 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -248,13 +248,11 @@ int afs_silly_iput(struct dentry *dentry, struct inode *inode)
 	struct dentry *alias;
 	int ret;
 
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
 
 	down_read(&dvnode->rmdir_lock);
 
-	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 	if (IS_ERR(alias)) {
 		up_read(&dvnode->rmdir_lock);
 		return 0;
diff --git a/fs/dcache.c b/fs/dcache.c
index d0a504fc62e5..2dcefa60db32 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2268,8 +2268,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2279,7 +2278,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2657,31 +2656,24 @@ static inline unsigned start_dir_add(struct inode *dir)
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       bool do_wake, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
+	if (do_wake)
+		wake_up_var_locked(&de->d_flags, &de->d_lock);
 }
 
-static void d_wait_lookup(struct dentry *dentry)
+static inline bool d_must_wait(struct dentry *dentry)
 {
-	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
-		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock(&dentry->d_lock);
-			schedule();
-			spin_lock(&dentry->d_lock);
-		} while (d_in_lookup(dentry));
-	}
+	if (!d_in_lookup(dentry))
+		return false;
+	dentry->d_flags |= DCACHE_LOCK_WAITER;
+	return true;
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2763,7 +2755,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		d_wait_lookup(dentry);
+		wait_var_event_spinlock(&dentry->d_flags,
+					!d_must_wait(dentry),
+					&dentry->d_lock);
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2784,7 +2778,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2800,29 +2793,29 @@ EXPORT_SYMBOL(d_alloc_parallel);
  * - Retrieve and clear the waitqueue head in dentry
  * - Return the waitqueue head
  */
-static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
+static bool __d_lookup_unhash(struct dentry *dentry)
 {
-	wait_queue_head_t *d_wait;
 	struct hlist_bl_head *b;
+	bool do_wake;
 
 	lockdep_assert_held(&dentry->d_lock);
 
 	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
-	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_in_lookup_hash);
-	d_wait = dentry->d_wait;
-	dentry->d_wait = NULL;
+	do_wake = !!(dentry->d_flags & DCACHE_LOCK_WAITER);
+	dentry->d_flags &= ~(DCACHE_PAR_LOOKUP|DCACHE_LOCK_WAITER);
+
 	hlist_bl_unlock(b);
 	dentry->waiters = NULL;
-	INIT_LIST_HEAD(&dentry->d_lru);
-	return d_wait;
+	return do_wake;
 }
 
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	if (__d_lookup_unhash(dentry))
+		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2832,14 +2825,15 @@ EXPORT_SYMBOL(__d_lookup_unhash_wake);
 static inline void __d_add(struct dentry *dentry, struct inode *inode,
 			   const struct dentry_operations *ops)
 {
-	wait_queue_head_t *d_wait;
+	bool do_wake = false;
 	struct inode *dir = NULL;
 	unsigned n;
+
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_unhash(dentry);
+		do_wake = __d_lookup_unhash(dentry);
 		__d_rehash(dentry);
 	} else if (d_unhashed(dentry)) {
 		__d_rehash(dentry);
@@ -2849,7 +2843,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 	if (inode)
 		__d_instantiate(dentry, inode);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, do_wake, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2962,7 +2956,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
 {
 	struct dentry *old_parent, *p;
-	wait_queue_head_t *d_wait;
+	bool do_wake = false;
 	struct inode *dir = NULL;
 	unsigned n;
 
@@ -2993,7 +2987,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir = target->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_unhash(target);
+		do_wake = __d_lookup_unhash(target);
 	}
 
 	write_seqcount_begin(&dentry->d_seq);
@@ -3033,7 +3027,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, do_wake, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..a2361f1d9905 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -164,7 +164,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
 
 	if (!o->nodeid) {
@@ -201,7 +200,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 65e60536a6d1..a6349b31fdb6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1891,13 +1891,12 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry = d_alloc_parallel(dir, name, &wq);
+	dentry = d_alloc_parallel(dir, name);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
@@ -4414,7 +4413,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4423,7 +4421,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..9580af999d70 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -726,7 +726,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -755,7 +754,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2106,7 +2105,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2162,7 +2160,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		d_drop(dentry);
 		switched = true;
 		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
+					  &dentry->d_name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 		if (unlikely(!d_in_lookup(dentry)))
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index df3ca4669df6..43ea897943c0 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -124,7 +124,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct dentry *alias;
 
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
-	alias = d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
+	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
@@ -185,7 +185,6 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr *name)
 
 	data->cred = get_current_cred();
 	data->res.dir_attr = &data->dir_attr;
-	init_waitqueue_head(&data->wq);
 
 	status = -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..d55a4b603188 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2132,8 +2132,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 		goto end_instantiate;
 
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			goto end_instantiate;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 49ab74e0bfde..04a382178c65 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -692,8 +692,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index be22bbc4a65a..a8995261831c 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -73,7 +73,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool posix = cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 	bool reparse_need_reval = false;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int rc;
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
@@ -105,7 +104,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name, &wq);
+		dentry = d_alloc_parallel(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2577c05f84ec..14b91a7d0bb6 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -116,10 +116,7 @@ struct dentry {
 					 * possible!
 					 */
 
-	union {
-		struct list_head d_lru;		/* LRU list */
-		wait_queue_head_t *d_wait;	/* in-lookup ones only */
-	};
+	struct list_head d_lru;		/* LRU list */
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
 	/*
@@ -210,6 +207,9 @@ enum dentry_flags {
 	DCACHE_REFERENCED		= BIT(6),	/* Recently used, don't discard. */
 	DCACHE_DONTCACHE		= BIT(7),	/* Purge from memory on final dput() */
 	DCACHE_CANT_MOUNT		= BIT(8),
+	DCACHE_LOCK_WAITER		= BIT(9),	/* A thread is waiting for
+							 * PAR_LOOKUP to clear
+							 */
 	DCACHE_SHRINK_LIST		= BIT(10),
 	DCACHE_OP_WEAK_REVALIDATE	= BIT(11),
 	/*
@@ -256,8 +256,7 @@ extern void d_delete(struct dentry *);
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index fcbd21b5685f..6aced49d5f00 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1743,7 +1743,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.50.0.107.gf914562f5916.dirty


