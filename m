Return-Path: <linux-nfs+bounces-20082-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULGvDQg0s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20082-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E927A291
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 352BB3024EE7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747938B7C1;
	Thu, 12 Mar 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hbrrmB/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhphY9/j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93130EF6C;
	Thu, 12 Mar 2026 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351940; cv=none; b=eQmRqzQNnxeNKxBrcG4F1a6lWyKA3Oc9gMGWRo3rNX9r4jKo0lsOjf6yANGxh7JHrpZ0HQiZ/zHC5HM7lr3YQSnJp86SDcOJhpDAhrOcz3ervM2IJULGPpOBmR+v8+lRkgQZMYnzPZ3P3tkp8QI47Hs9bl6EzJK++wBb2TxQ0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351940; c=relaxed/simple;
	bh=YQkXOSgp83B/Cz1fXXisbAxol9xPiNsqyGq0ZBXi3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5XwRHZyHnV8TuqIa4zwmZ90UwTMPOONeJFI/20yV1SSpGaq/HZ+ng+SNs+GpII53vgpsBrLyUzbC9Dp9ZLjpQ1u5GEWLajW9B4EnbyiRBOVgep8Xb8sX9yM5b5oN4n94Xr+Y4V2zMP2JdpZcffVkrHEkp9a1G0M0DQRCMKJGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hbrrmB/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhphY9/j; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 0E4311301B3F;
	Thu, 12 Mar 2026 17:45:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773351935;
	 x=1773359135; bh=O1YxbmqYb+khk6pko/HFlSvaKBSqoQTQ01IgO7TQZ74=; b=
	hbrrmB/a166tqOQOVT4NkAAwVTlDRNdyii5dwLNiRynQXXoWvbBbRtx+h88L4vOJ
	jIJXOLZgIp9GBPi2wJw/kV8H0LJEFuPwJQ2fxzOmZgyi1f4nTWKtJ7xIya9M3iRo
	KioHZgVxZ+etWjZIf9endsa4OD+fYoxHJ2K6hPu8+AjKfDQ5nACCD0mG77p2LVbR
	B7RFI0hXNJXvIQRo7/0ipuon8gODWLwoSlRMmD7tKQ5dMEx0EGWOkjccGppIdtjA
	IEDzA0FwhpfrwAts5mfFIBspOTQGMW3/CKxE0kXicOYHTPvyedCaZ+mM1MtzlyBQ
	LdyoCUNEoA8Lpjozc/kG0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773351935; x=1773359135; bh=O
	1YxbmqYb+khk6pko/HFlSvaKBSqoQTQ01IgO7TQZ74=; b=RhphY9/jKBnqOrXDs
	/qmHyDdkfvkv55x1YQPU3y3KMlv3+U80qJUNl0GchvJc6M4TpS72Tilj4eftZDoA
	Fxm0C2RLUllQ3UbnOphIWEAgzTMhkkiqc3Y1VD1zewnm0iOC8FscyO3FSSKby9IK
	Btmky+DqeaVKewKNCGQR7CnfQ/OyVtfaXSmt4o5RJ/VGq3cPmj5IHzKNmWlw1EiO
	EOjgG/5ownsl6rYlG+c0ZiEbjpUkMPOTlVNu+ohZHtMeSeypyl/h6MPSU0s55CLm
	XcnufTGYQAJzGWbsvO0ffzzKzpzOcQLHM+4bXJ6tKDg8YK4m2V02gJBCpSt3g0oO
	g15/A==
X-ME-Sender: <xms:_zOzaeQBAkTu7nOnoOopSJN8O5bhH5ePuc7uiApw6ijGE2rwp2ekwg>
    <xme:_zOzaXdgXM-YVFNrX2bBf5elmeSjQxmkmn2TRyAtXo5E2ZY8Xdsktne5-CTQzU3vR
    WJMn9dq5Y67rEeB7IS26RUBJzz0qXDJvD0wGV0ZQnLsM9B1xQ>
X-ME-Received: <xmr:_zOzaW4KBl8Lgj3K-HgVcGSctHwBlRPmYGVd5ZHepEJYjepIfozkYLtTsoU61OO8CMiRqvzrfBR2pxol1janBUJFw3a6BeWWXn12p2gZjySB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:_zOzaXck0p9GCqhQGHHlh1P5LqnLCgmzwTbQgzkH-GORoeQUdqUzgQ>
    <xmx:_zOzadCNKE0lgCjy2CGPJZh8icmlf92iL82C-SKN_B1_PRwIMsO3Nw>
    <xmx:_zOzaTHJn_LEn8cGsAUtkYHYN0Im8K4GCxJ143nmkeR8S8o1vRXTQw>
    <xmx:_zOzaVgI_zqUVs2T9VlM6e7oh7KAGjT_7aWnvjBZ6KJ6b5QDtPau2w>
    <xmx:_zOzaRugOMgMQgfv5d8FOna5TlVZ6QCPn8yyzG0OgNY9HquLtg5tc28I>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:45:22 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 04/53] VFS: use global wait-queue table for d_alloc_parallel()
Date: Fri, 13 Mar 2026 08:11:51 +1100
Message-ID: <20260312214330.3885211-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20082-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EE9E927A291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
This must have a life time which extends until the lookup is completed.

Future patches will make more use of d_alloc_parallel() and use it in
contexts where having an on-stack wait_queue_head is not convenient.
For exaple lookup_one_qstr_excl() can only use d_alloc_parallel() if it
accepts a wait_queue_head pass in by the caller.

The interface would be easier to use if this need were removed.  Rather
than passing a wait_queue_head into lookup_one_qstr_excl() we can let
d_alloc_parallel() manage the wait_queue_head entirely itself.

This patch replaces the on-stack wqs with a global array of wqs which
are used as needed.  A wq is NOT assigned when a dentry is first
created but only when a second thread attempts to use the same name and
so is forced to wait.  At this moment a wq is chosen using a hash of the
dentry pointer and that wq is assigned to ->d_wait.  The ->d_lock is
then dropped and the task waits.

When the dentry is finally moved out of "in_lookup" a wake up is only
sent if ->d_wait is not NULL.  This avoids an (uncontended) spin
lock/unlock which saves a couple of atomic operations in a common case.

The wake up passes the dentry that the wake up is for as the "key" and
the waiter will only wake processes waiting on the same key.  This means
that when these global waitqueues are shared (which is inevitable
though unlikely to be frequent), a task will not be woken prematurely.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  6 +++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 78 ++++++++++++++++++++++-----
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +--
 fs/nfs/dir.c                          |  6 +--
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                |  3 +-
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 560b473e02d0..6a507c508ccf 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1375,3 +1375,9 @@ similar.
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
 
+---
+
+**mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
+from an internal table when needed.
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
index 6dfc2c7110ba..c80406bfa0d8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2199,8 +2199,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2210,7 +2209,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2576,6 +2575,46 @@ void d_rehash(struct dentry * entry)
 }
 EXPORT_SYMBOL(d_rehash);
 
+#define PAR_LOOKUP_WQ_BITS	8
+#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
+static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
+
+static int __init par_wait_init(void)
+{
+	int i;
+
+	for (i = 0; i < PAR_LOOKUP_WQS; i++)
+		init_waitqueue_head(&par_wait_table[i]);
+	return 0;
+}
+fs_initcall(par_wait_init);
+
+struct par_wait_key {
+	struct dentry *de;
+	struct wait_queue_entry wqe;
+};
+
+static int d_wait_wake_fn(struct wait_queue_entry *wq_entry,
+			  unsigned mode, int sync, void *key)
+{
+	struct par_wait_key *pwk = container_of(wq_entry,
+						 struct par_wait_key, wqe);
+	if (pwk->de == key)
+		return default_wake_function(wq_entry, mode, sync, key);
+	return 0;
+}
+
+static inline void d_wake_waiters(struct wait_queue_head *d_wait,
+				  struct dentry *dentry)
+{
+	/* ->d_wait is only set if some thread is actually waiting.
+	 * If we find it is NULL - the common case - then there was no
+	 * contention and there are no waiters to be woken.
+	 */
+	if (d_wait)
+		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
+}
+
 static inline unsigned start_dir_add(struct inode *dir)
 {
 	preempt_disable_nested();
@@ -2588,31 +2627,42 @@ static inline unsigned start_dir_add(struct inode *dir)
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       wait_queue_head_t *d_wait, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
+	d_wake_waiters(d_wait, de);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
+		struct par_wait_key wk = {
+			.de = dentry,
+			.wqe = {
+				.private = current,
+				.func = d_wait_wake_fn,
+			},
+		};
+		struct wait_queue_head *wq;
+
+		if (!dentry->d_wait)
+			dentry->d_wait = &par_wait_table[hash_ptr(dentry,
+								  PAR_LOOKUP_WQ_BITS)];
+		wq = dentry->d_wait;
+		add_wait_queue(wq, &wk.wqe);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock(&dentry->d_lock);
 			schedule();
 			spin_lock(&dentry->d_lock);
 		} while (d_in_lookup(dentry));
+		remove_wait_queue(wq, &wk.wqe);
 	}
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2625,6 +2675,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return ERR_PTR(-ENOMEM);
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
+	new->d_wait = NULL;
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
@@ -2715,7 +2766,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2753,7 +2803,7 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	d_wake_waiters(__d_lookup_unhash(dentry), dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2780,7 +2830,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 	if (inode)
 		__d_instantiate(dentry, inode);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2964,7 +3014,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..f588252891af 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -160,7 +160,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
 
 	if (!o->nodeid) {
@@ -197,7 +196,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 6ffb8367b1cf..d31c3db7eb5e 100644
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
@@ -4408,7 +4407,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4417,7 +4415,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..52e7656195ec 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -727,7 +727,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -756,7 +755,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2107,7 +2106,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2163,7 +2161,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
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
index 4eec684baca9..070c0d58b2da 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2129,8 +2129,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 
 	child = try_lookup_noperm(&qname, dir);
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
index 8615a8747b7f..47f5d620b750 100644
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
index 898c60d21c92..c6440c626a0f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -244,8 +244,7 @@ extern void d_delete(struct dentry *);
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
index ff1f12aa73d2..1acc2479cb38 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1740,7 +1740,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.50.0.107.gf914562f5916.dirty


