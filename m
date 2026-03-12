Return-Path: <linux-nfs+bounces-20111-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDeMJBA6s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20111-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:11:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72C27ADDB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 168AB305A0EF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA8346E55;
	Thu, 12 Mar 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WfHfWNbc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qx5rCR2g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E534A797;
	Thu, 12 Mar 2026 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352713; cv=none; b=Xih5iItiq46g5beVbKcRdndH58wA7zPNUJiKZNrJmKruVyPn2U6lC47Q7r0Q46cUrxhs9A/OGuPej7419nWkDYz+nRflLAItEOlvj9vKU/swxAkCaLz8Dp1tBXiF4uZv5WKuSbYGCpqIYfcPJ2RvUEKh2Byy60GjRdgLxm/4rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352713; c=relaxed/simple;
	bh=1JkkAedomWBG14G0WAqvfZiAthqy/JF/uu16ADzus+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKClF/lPsAmEGh9OIqDY4oHVLGofE6kPQDWaZ5j3aTXQQwk28Zo9Ejc+j4eIgjgnGOBa2fnjYVSfU2gikDI2wzK1FZwRcFk7II7mZvlDUTpPNtWkE/JdRkWnDLrUEenxZo2JmTB99Uu0tbz7cvkvxnKGvxYKj4ycRe+sY2AGsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WfHfWNbc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qx5rCR2g; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6F3A01301B63;
	Thu, 12 Mar 2026 17:58:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352709;
	 x=1773359909; bh=1h/4KUNGDnlL7CBwVpO5v6kJjyfz+9NwtNaAhRC9U10=; b=
	WfHfWNbch9UGB+eGabQxTdEvIDD4DFelol7k3LjdQO/lb65xfuejEmzAoM8pvQ4+
	gJ4ol9X9HCBFTIzeKB0Viue1L3jG1Q9bqBwZUTphx4m6U3Rk2ls8GfzEdN0PiZi5
	LCTknHndu4dqomidg/k3sGUcGTijbG2dTWjKHVNypIRljDAxdhO3oxfrhMJkCel/
	D96BUDM2dcr86sPQiHqSYInXl70rtCkrmk8TxgB7ddCaXEgipNdaZIjXJPrb/0fJ
	BpP944NRphZdvubke4smP5FoL2inwaqZC6E92n9ErQLi+cdxDBeLIX0EUFb3yR9T
	sC3KzRrjSgOF44kCJiHBIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352709; x=1773359909; bh=1
	h/4KUNGDnlL7CBwVpO5v6kJjyfz+9NwtNaAhRC9U10=; b=Qx5rCR2gTxh9pg1aW
	AjDwaxfHDw0YiqmAUCgdlStHI0PQga3+vcnB8gfVa/y4ZBpWzH0QrLbujnOmZKv8
	6tBLD2DKb69VB5WgrYmfGt41UvEtR9qwufkNY6SmUVXS1uuj8MG8L6/WcUbufqDc
	tGCfJnZa7u52el6AobUREmziO6p1gxAhhfQlvnqIsQf2Ry0YMLdAYgehYR7OvjBg
	Hf7z6Fv/FTfS3TEpRoly9oXmw9v58aAJTrvP/BMYbLSbx0Zd0jSOWF8jkC76ErM+
	pvhKfqXWeCDyRvi7kvD8qfxdIcxMmWn10jVuo8IUlE8Mq9uzo+hkJ6Se7a+KyFPv
	Jtq8g==
X-ME-Sender: <xms:BDezaeDk-tf73yJk64NfYXpVkLe13Fb67FhI36-hmpCPXbhrmSx06A>
    <xme:BDezaQGTbVnpuP2GT1EBX8QC0ET_IzkqZcSSEIBFgFdxLd_hU-UQGFfd5VrmpR1oO
    kIL6kOb_d_BurdrJW7IFO2WbFmlfQdOaEgUMsInBgI5DCaGNYY>
X-ME-Received: <xmr:BDezaZKa3oxupZo6pLYX2hZHOPFFEp4_zBAzHVrWEsRCvcx9iIozV_Brb3ypPGSD9f1gTokDI8bTrgruheFv_l6J6loqMa10nUDMBYaV9oQ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BDezacuDcaEYuf-NLXhpOb2dLaFha1-HNF0jmkqey_I7OUu43PF9yw>
    <xmx:BDezaerX6an-TitZCLXTy6rc8NohWgzxNAAI-NSV7MHuvd-1hJsd_A>
    <xmx:BDezaYUBkgN3WmTPYxbF5g9BtCM-3qEWtWav9KPyAbUOWWYAxhSR5g>
    <xmx:BDezaaEbljsEZbwl3e31dk7jT6eFmUkQYIViwoCP6MmaL9bzcl5zYQ>
    <xmx:BTezaecpo7eNRtrIb1aUD4dNUl5iVrgPYnQFKaYDhtW8iJl5a4T4S-T7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:58:15 -0400 (EDT)
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
Subject: [PATCH 52/53] VFS: lift d_alloc_parallel above inode_lock
Date: Fri, 13 Mar 2026 08:12:39 +1100
Message-ID: <20260312214330.3885211-53-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20111-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 9F72C27ADDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

d_alloc_parallel() can block waiting on a d_in_lookup() dentry
so it is important to order it consistently with other blocking locks
such as inode_lock().

Currenty d_alloc_parallel() is ordered after inode_lock(): it can be
called while the inode is locked, and so the inode cannot be locked
while a d_in_lookup() dentry is held.

This patch reverses that order.  d_alloc_parallel() must now be called
*before* locking the directory, and must not be called afterwards.  This
allows directory locking to be moved closer to the filesystem
operations, and ultimately into those operations.

lookup_one_qstr_excl() is now called without an lock held, exclusive or
otherwise, so the "_excl" is dropped - it is now lookup_one_qstr().

As a lock is taken *after* lookup, start_dirop() and start_renaming()
must ensure that if the dentry isn't d_in_lookup() that after the lock
is taken the parent is still correct and the dentry is still hashed.

lookup_one_qstr() and lookup_slow() don't need to re-check the parent as
the dentry is always d_in_lookup() so parent cannot change.

The locking in lookup_slow() is moved into __lookup_slow() immediately
before/after ->lookup, and lookup_slow() just sets the task state for
waiting.

Parent locking is removed from open_last_lookups() and performed in
lookup_open().  A shared lock is taken if ->lookup() needs to be called.
An exclusive lock is taken separately if ->create() needs to be called -
with checks that the dentry hasn't become positive.

If ->atomic_open is needed we take exclusive or shared parent lock as
appropriate and check for a positive dentry or DEAD parent.

The fsnotify_create() call is kept inside the locked region in
lookup_open().  I don't know if this is important.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 239 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 154 insertions(+), 85 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bba419f2fc53..3d213070a515 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1773,8 +1773,19 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 	return dentry;
 }
 
+static inline bool inode_lock_shared_state(struct inode *inode, unsigned int state)
+{
+	if (state == TASK_KILLABLE) {
+		if (down_read_killable(&inode->i_rwsem) != 0) {
+			return false;
+		}
+	} else {
+		inode_lock_shared(inode);
+	}
+	return true;
+}
+
 /*
- * Parent directory has inode locked.
  * If Lookup_EXCL or LOOKUP_RENAME_TARGET is set
  * d_lookup_done() must be called before the dentry is dput()
  * If the dentry is not d_in_lookup():
@@ -1783,8 +1794,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * If it is d_in_lookup() then these conditions can only be checked by the
  * file system when carrying out the intent (create or rename).
  */
-static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-					   struct dentry *base, unsigned int flags)
+static struct dentry *lookup_one_qstr(const struct qstr *name,
+				      struct dentry *base, unsigned int flags,
+				      unsigned int state)
 {
 	struct dentry *dentry;
 	struct dentry *old;
@@ -1806,7 +1818,16 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 		/* Raced with another thread which did the lookup */
 		goto found;
 
-	old = dir->i_op->lookup(dir, dentry, flags);
+	if (!inode_lock_shared_state(dir, state)) {
+		d_lookup_done(dentry);
+		dput(dentry);
+		return ERR_PTR(-EINTR);
+	}
+	if (unlikely(IS_DEADDIR(dir)))
+		old = ERR_PTR(-ENOENT);
+	else
+		old = dir->i_op->lookup(dir, dentry, flags | LOOKUP_SHARED);
+	inode_unlock_shared(dir);
 	if (unlikely(old)) {
 		d_lookup_done(dentry);
 		dput(dentry);
@@ -1897,7 +1918,8 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 /* Fast lookup failed, do it the slow way */
 static struct dentry *__lookup_slow(const struct qstr *name,
 				    struct dentry *dir,
-				    unsigned int flags)
+				    unsigned int flags,
+				    unsigned int state)
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
@@ -1920,8 +1942,17 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 			dput(dentry);
 			dentry = ERR_PTR(error);
 		}
+	} else if (!inode_lock_shared_state(inode, state)) {
+		d_lookup_done(dentry);
+		dput(dentry);
+		return ERR_PTR(-EINTR);
 	} else {
-		old = inode->i_op->lookup(inode, dentry, flags);
+		if (unlikely(IS_DEADDIR(inode)))
+			old = ERR_PTR(-ENOENT);
+		else
+			old = inode->i_op->lookup(inode, dentry,
+						  flags | LOOKUP_SHARED);
+		inode_unlock_shared(inode);
 		d_lookup_done(dentry);
 		if (unlikely(old)) {
 			dput(dentry);
@@ -1935,26 +1966,14 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 				  struct dentry *dir,
 				  unsigned int flags)
 {
-	struct inode *inode = dir->d_inode;
-	struct dentry *res;
-	inode_lock_shared(inode);
-	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
-	inode_unlock_shared(inode);
-	return res;
+	return __lookup_slow(name, dir, flags | LOOKUP_SHARED, TASK_NORMAL);
 }
 
 static struct dentry *lookup_slow_killable(const struct qstr *name,
 					   struct dentry *dir,
 					   unsigned int flags)
 {
-	struct inode *inode = dir->d_inode;
-	struct dentry *res;
-
-	if (inode_lock_shared_killable(inode))
-		return ERR_PTR(-EINTR);
-	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
-	inode_unlock_shared(inode);
-	return res;
+	return __lookup_slow(name, dir, flags | LOOKUP_SHARED, TASK_KILLABLE);
 }
 
 static inline int may_lookup(struct mnt_idmap *idmap,
@@ -2908,18 +2927,26 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 
-	if (state == TASK_KILLABLE) {
-		int ret = down_write_killable_nested(&dir->i_rwsem,
-						     I_MUTEX_PARENT);
-		if (ret)
-			return ERR_PTR(ret);
-	} else {
-		inode_lock_nested(dir, I_MUTEX_PARENT);
-	}
-	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
-	if (IS_ERR(dentry))
+	while(1) {
+		dentry = lookup_one_qstr(name, parent, lookup_flags, state);
+		if (IS_ERR(dentry))
+			return dentry;
+		if (state == TASK_KILLABLE) {
+			if (down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT) != 0) {
+				d_lookup_done(dentry);
+				dput(dentry);
+				return ERR_PTR(-EINTR);
+			}
+		} else {
+			inode_lock_nested(dir, I_MUTEX_PARENT);
+		}
+		if (d_in_lookup(dentry) ||
+		    (!d_unhashed(dentry) && dentry->d_parent == parent))
+			return dentry;
 		inode_unlock(dir);
-	return dentry;
+		d_lookup_done(dentry);
+		dput(dentry);
+	}
 }
 
 /**
@@ -3830,26 +3857,37 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 	if (rd->flags & RENAME_NOREPLACE)
 		target_flags |= LOOKUP_EXCL;
 
-	trap = lock_rename(rd->old_parent, rd->new_parent);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
-
-	d1 = lookup_one_qstr_excl(old_last, rd->old_parent,
-				  lookup_flags);
+retry:
+	d1 = lookup_one_qstr(old_last, rd->old_parent,
+			     lookup_flags, TASK_NORMAL);
 	err = PTR_ERR(d1);
 	if (IS_ERR(d1))
-		goto out_unlock;
+		goto out_err;
 
-	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
-				  lookup_flags | target_flags);
+	d2 = lookup_one_qstr(new_last, rd->new_parent,
+			     lookup_flags | target_flags, TASK_NORMAL);
 	err = PTR_ERR(d2);
 	if (IS_ERR(d2))
 		goto out_dput_d1;
 
+	trap = lock_rename(rd->old_parent, rd->new_parent);
+	err = PTR_ERR(trap);
+	if (IS_ERR(trap))
+		goto out_unlock;
+
+	if (unlikely((!d_in_lookup(d1) && d_unhashed(d1)) || d1->d_parent != rd->old_parent ||
+		     (!d_in_lookup(d2) && d_unhashed(d2)) || d2->d_parent != rd->new_parent)) {
+		unlock_rename(rd->old_parent, rd->new_parent);
+		d_lookup_done(d1); dput(d1);
+		d_lookup_done(d2); dput(d2);
+		dput(trap);
+		goto retry;
+	}
+
 	if (d1 == trap) {
 		/* source is an ancestor of target */
 		err = -EINVAL;
-		goto out_dput_d2;
+		goto out_unlock;
 	}
 
 	if (d2 == trap) {
@@ -3858,7 +3896,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 			err = -EINVAL;
 		else
 			err = -ENOTEMPTY;
-		goto out_dput_d2;
+		goto out_unlock;
 	}
 
 	rd->old_dentry = d1;
@@ -3866,14 +3904,14 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 	dget(rd->old_parent);
 	return 0;
 
-out_dput_d2:
+out_unlock:
+	unlock_rename(rd->old_parent, rd->new_parent);
 	d_lookup_done(d2);
 	dput(d2);
 out_dput_d1:
 	d_lookup_done(d1);
 	dput(d1);
-out_unlock:
-	unlock_rename(rd->old_parent, rd->new_parent);
+out_err:
 	return err;
 }
 
@@ -3927,10 +3965,22 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 	if (rd->flags & RENAME_NOREPLACE)
 		target_flags |= LOOKUP_EXCL;
 
-	/* Already have the dentry - need to be sure to lock the correct parent */
+retry:
+	d2 = lookup_one_qstr(new_last, rd->new_parent,
+			     lookup_flags | target_flags, TASK_NORMAL);
+	err = PTR_ERR(d2);
+	if (IS_ERR(d2))
+		goto out_unlock;
+
+	/*
+	 * Already have the old_dentry - need to be sure to lock
+	 * the correct parent
+	 */
 	trap = lock_rename_child(old_dentry, rd->new_parent);
+	err = PTR_ERR(trap);
 	if (IS_ERR(trap))
-		return PTR_ERR(trap);
+		goto out_dput_d2;
+
 	if (d_unhashed(old_dentry) ||
 	    (rd->old_parent && rd->old_parent != old_dentry->d_parent)) {
 		/* dentry was removed, or moved and explicit parent requested */
@@ -3938,16 +3988,19 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 		goto out_unlock;
 	}
 
-	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
-				  lookup_flags | target_flags);
-	err = PTR_ERR(d2);
-	if (IS_ERR(d2))
-		goto out_unlock;
+	if (unlikely((!d_in_lookup(d2) && d_unhashed(d2)) ||
+		     d2->d_parent != rd->new_parent)) {
+		/* d2 was moved/removed before lock - repeat lookup */
+		unlock_rename(old_dentry->d_parent, rd->new_parent);
+		d_lookup_done(d2); dput(d2);
+		dput(trap);
+		goto retry;
+	}
 
 	if (old_dentry == trap) {
 		/* source is an ancestor of target */
 		err = -EINVAL;
-		goto out_dput_d2;
+		goto out_unlock;
 	}
 
 	if (d2 == trap) {
@@ -3956,7 +4009,7 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 			err = -EINVAL;
 		else
 			err = -ENOTEMPTY;
-		goto out_dput_d2;
+		goto out_unlock;
 	}
 
 	rd->old_dentry = dget(old_dentry);
@@ -3964,11 +4017,11 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 	rd->old_parent = dget(old_dentry->d_parent);
 	return 0;
 
+out_unlock:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
 out_dput_d2:
 	d_lookup_done(d2);
 	dput(d2);
-out_unlock:
-	unlock_rename(old_dentry->d_parent, rd->new_parent);
 	return err;
 }
 
@@ -4319,8 +4372,19 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
-	error = dir->i_op->atomic_open(dir, dentry, file,
-				       open_to_namei_flags(open_flag), mode);
+
+	if (open_flag & O_CREAT)
+		inode_lock(dir);
+	else
+		inode_lock_shared(dir);
+	if (dentry->d_inode)
+		error = finish_no_open(file, NULL);
+	else if (unlikely(IS_DEADDIR(dir)))
+		error = -ENOENT;
+	else
+		error = dir->i_op->atomic_open(dir, dentry, file,
+					       open_to_namei_flags(open_flag),
+					       mode);
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
@@ -4339,6 +4403,13 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 				error = -ENOENT;
 		}
 	}
+	if (!error && (file->f_mode & FMODE_CREATED))
+		fsnotify_create(dir, dentry);
+	if (open_flag & O_CREAT)
+		inode_unlock(dir);
+	else
+		inode_unlock_shared(dir);
+
 	if (error) {
 		dput(dentry);
 		dentry = ERR_PTR(error);
@@ -4372,10 +4443,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	unsigned int shared_flag = (op->open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
-
-	if (unlikely(IS_DEADDIR(dir_inode)))
-		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -4420,7 +4487,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4439,8 +4506,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 
 	if (d_in_lookup(dentry)) {
-		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags | shared_flag);
+		struct dentry *res;
+
+		inode_lock_shared(dir_inode);
+		if (IS_DEADDIR(dir_inode))
+			res = ERR_PTR(-ENOENT);
+		else
+			res = dir_inode->i_op->lookup(dir_inode, dentry,
+						      nd->flags | LOOKUP_SHARED);
+		inode_unlock_shared(dir_inode);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
@@ -4459,15 +4533,22 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
-		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
+		inode_lock(dir_inode);
+		if (!dentry->d_inode && !unlikely(IS_DEADDIR(dir_inode))) {
+			file->f_mode |= FMODE_CREATED;
+			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+			if (!dir_inode->i_op->create) {
+				error = -EACCES;
+				goto out_dput;
+			}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+			error = dir_inode->i_op->create(idmap, dir_inode, dentry,
+							mode, open_flag & O_EXCL);
+			if (!error)
+				fsnotify_create(dir_inode, dentry);
+		} else if (!dentry->d_inode)
+			error = -ENOENT;
+		inode_unlock(dir_inode);
 		if (error)
 			goto out_dput;
 	}
@@ -4522,7 +4603,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct delegated_inode delegated_inode = { };
-	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -4562,22 +4642,11 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
-
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
-- 
2.50.0.107.gf914562f5916.dirty


