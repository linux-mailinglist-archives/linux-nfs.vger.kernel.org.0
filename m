Return-Path: <linux-nfs+bounces-20080-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENlYHfkzs2mDTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20080-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289227A266
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2CB33073198
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980FB38B135;
	Thu, 12 Mar 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IdiQOok0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gn3FSBiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641E3FBECB;
	Thu, 12 Mar 2026 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351905; cv=none; b=Wt4UDta7wuxOHUVdBwdDzPlki0+oZq1+Yen8V7vQ/OeBCIW1f04dNrCGqpTQ5DyISepPK+IO5+bI+p7sZo175WfjrwIgFUdO+E96vPYfHAau6kTk/K6AnL+gG5WPU3SEc3NUTb2YXdLSV5qC4ECAvXvJY3wX5lasTZbpLtVW/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351905; c=relaxed/simple;
	bh=lzfrMWH5ucEdjaxtNb8IRio8YrNVnNRvEyHHmeNBdQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD8uVa+2wSwxJmIUjj8vHBomfVLnFxfS9Ti9FJkBKJXBtFUqOroKjB7MXdI+7kWTU6sI2bKQ7GHUHObFGy7WImulhLB4vEs7QVy1hLgqybTzvdRLyWL3wju3daCMjYADVaiR+NzvHx7BET4XtNjiNFPXHaO9ambJmxFdckBG16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IdiQOok0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gn3FSBiy; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 81DD11301B38;
	Thu, 12 Mar 2026 17:45:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 17:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773351901;
	 x=1773359101; bh=q86JqY5nWN61fk3HDIejbBzlZhC8qHqz4CWZQB9c0L0=; b=
	IdiQOok0NjcrVf3aBusgGZebFc2FHPnBB240qLNehAkc7QtrbGn+geGKng8idZGJ
	M8pgixjygkApnAS7lO7rlFmPWlnnVc7ZI+3NAFk4bKgxoEsSTJuJIpvXIQuhgkma
	hsj48bh9bZxX7e4DyJzIwbfCzQvDxXWTmxKYQxvUyWPBtqMB6vuaI8evFMQ+3Jzh
	YSXOHhEDMLnNXBxs3yMi4X2136zsPqA4HLfDUfQ5+O6mWKecRhNKoZtTqE1QKErs
	g24i9txs2z+6G+MZxrL9Ej0SJjyw4K3nGOm1peFDYO090Nbn5QSClI80O8eSgMF1
	HbW6gTFEIoXvPCxkC4/H1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773351901; x=1773359101; bh=q
	86JqY5nWN61fk3HDIejbBzlZhC8qHqz4CWZQB9c0L0=; b=gn3FSBiya6mz1Vl3j
	ZeHBiF7isXmDXq2Bj4NSdhVT01lccsHK2oNMG6rixbhMm5laJfOC1MNhF8URhPjY
	zfPpCGAv3EMgHswdAkM/NC63JIWQyCZMIvD9eoFCbdGn+0yca0TbrUF3xlLPtfSV
	MUMJ9mlzkwgs9wiwJvdrDOJZhGBQSoaUTvFyqBIoZR0BlZ7ZR7J6/Nl2uiHx+yV0
	OC48PirUBgXwfeDTTjEs0yLtaGLh608R+QD9jMUeUCQ8aCmPwgH4WdYQwhrv5rE+
	vvwfvA29XDqkVJ0VtODTYv+fXm11AMn7ghiP+W2k7wX75lWIdJJmBRaa2rRnR1Xj
	ha7ag==
X-ME-Sender: <xms:3DOzaSOy-EJ5M52dAeSiXhXiu4QmWzk4ZyygSCtRG1LbJnhV1pkN2Q>
    <xme:3DOzaUoF0hy8FkdKKemtyuUufzuos19b2bX-V3nh8QF-sbNkbNes3ZB17Gc8Sj3Ut
    2mi6jAcF7BiowP15Df6NOFLMh13DwCA8KtDPY1Agv5z5yLeSIU>
X-ME-Received: <xmr:3DOzaUXKtvg8cy8a1Yn4hKeTax-m9uWCMnfrt0a9U-DC2UwgvyxHZN4eWYnTx572jZguHkC49TNt2vnDNoReXnWA0iDzJEU-p78umv_v6rZn>
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
X-ME-Proxy: <xmx:3DOzaQL9oijhqt4yjewGv3-1S6vRY49CYT-U2urGlkwLd-x95GWolw>
    <xmx:3DOzaf-ixVp_b2UGlSQkkpFtYH9pFCmJoOWJvH9bGaaot8XaFp04aQ>
    <xmx:3DOzaTQI3iitOQoKEqT2SGyjmIoeU4se1JZ53JzkJnUoq2S6h5telg>
    <xmx:3DOzaZ-O4PBgH2A_M20T6yNHevRLSfpBAowMm9FF_xpLEf-CcUgekg>
    <xmx:3TOzaTYsrE7RjVaZM_ZuJoMi7XQDVLNSOynY1Ipjh500LSgYWf_cUWZm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:44:47 -0400 (EDT)
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
Subject: [PATCH 02/53] VFS: enhance d_splice_alias() to handle in-lookup dentries
Date: Fri, 13 Mar 2026 08:11:49 +1100
Message-ID: <20260312214330.3885211-3-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20080-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3289227A266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

We currently have three interfaces for attaching existing inodes to
normal filesystems(*).
- d_add() requires an unhashed or in-lookup dentry and doesn't handle
  splicing in case a directory already has dentry
- d_instantiate() requires a hashed dentry, and also doesn't handle
  splicing.
- d_splice_alias() requires unhashed or in-lookup and does handle
  splicing, and can return an alternate dentry.

So there is no interface that supports both hashed and in-lookup, which
is what ->atomic_open needs to deal with.

Some filesystems check for in-lookup in their atomic_open and if found,
perform a ->lookup and can subsequently use d_instantiate() if the
dentry is still negative.  Other d_drop() the dentry so they can use
d_splice_alias().

This last will cause a problem for proposed changes to locking which
require the dentry to remain hashed while and operation proceeds on it.

There is also no interface which splices a directory (which might
already have a dentry) to a hashed dentry.  Filesystems which need to do
this d_drop() first.

So with this patch d_splice_alias() can handle hashed, unhashed, or
in-lookup dentries.  This makes it suitable for ->lookup, ->atomic_open,
and ->mkdir.

As a side effect d_add() will also now handle hashed dentries, but
future patches will remove d_add() as there is no benefit having it as
well as the others.

__d_add() currently contains code that is identical to
__d_instantiate(), so the former is changed to call the later, and both
d_add() and d_instantiate() call __d_add().

* There is also d_make_persistent() for filesystems which are
  dcache-based and don't support mkdir, create etc, and
  d_instantiate_new() for newly created inodes that are still locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst |  4 ++--
 fs/dcache.c                       | 31 ++++++++++++-------------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c753148af88..d8df0a84cdba 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -507,8 +507,8 @@ otherwise noted.
 	dentry before the first mkdir returns.
 
 	If there is any chance this could happen, then the new inode
-	should be d_drop()ed and attached with d_splice_alias().  The
-	returned dentry (if any) should be returned by ->mkdir().
+	should be attached with d_splice_alias().  The returned
+	dentry (if any) should be returned by ->mkdir().
 
 ``rmdir``
 	called by the rmdir(2) system call.  Only required if you want
diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..2a100c616576 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2001,7 +2001,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -2755,18 +2754,14 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
 		d_wait = __d_lookup_unhash(dentry);
+		__d_rehash(dentry);
+	} else if (d_unhashed(dentry)) {
+		__d_rehash(dentry);
 	}
 	if (unlikely(ops))
 		d_set_d_op(dentry, ops);
-	if (inode) {
-		unsigned add_flags = d_flags_for_inode(inode);
-		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
-		raw_write_seqcount_begin(&dentry->d_seq);
-		__d_set_inode_and_type(dentry, inode, add_flags);
-		raw_write_seqcount_end(&dentry->d_seq);
-		fsnotify_update_flags(dentry);
-	}
-	__d_rehash(dentry);
+	if (inode)
+		__d_instantiate(dentry, inode);
 	if (dir)
 		end_dir_add(dir, n, d_wait);
 	spin_unlock(&dentry->d_lock);
@@ -3066,8 +3061,6 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
-
 	if (!inode)
 		goto out;
 
@@ -3116,6 +3109,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3123,16 +3118,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
  * we should error out: directories can't have multiple aliases.
  *
- * This is needed in the lookup routine of any filesystem that is exportable
- * (via knfsd) so that we can build dcache paths to directories effectively.
+ * This should be used to return the result of ->lookup() and to
+ * instantiate the result of ->mkdir(), is often useful for
+ * ->atomic_open, and may be used to instantiate other objects.
  *
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
- * is returned.  This matches the expected return value of ->lookup.
+ * is returned.  This matches the expected return value of ->lookup and
+ * ->mkdir.
  *
- * Cluster filesystems may call this function with a negative, hashed dentry.
- * In that case, we know that the inode will be a regular file, and also this
- * will only occur during atomic_open. So we need to check for the dentry
- * being already hashed only in the final case.
  */
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
-- 
2.50.0.107.gf914562f5916.dirty


