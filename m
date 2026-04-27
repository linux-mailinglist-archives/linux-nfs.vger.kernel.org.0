Return-Path: <linux-nfs+bounces-21137-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID6VNPHg7mk6zQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21137-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A346CD8C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFFC300DDEB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C412749ED;
	Mon, 27 Apr 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="K8nE7L4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVIXD13D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62B258EC1;
	Mon, 27 Apr 2026 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262762; cv=none; b=p6fi63xjapz3GpxaZtrSjXkptE4qTj3cBPuzZL4CRqFH8bWeiqm99d0brHETIKJpCSJdEqTA4sjAvRImvq+6TdRWOoIRNBXjGcwCsI8DeZ3NyxF3xZkbhI3ucXodee+cPAFWNY001Cy7cscVWm8iX85UB5dIZOJ+hQ/Z+UmU4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262762; c=relaxed/simple;
	bh=Pki1tNYev0WXH8WJnTY1L/60frqpJhclJSGzSK1gdE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPu3lvNOV4HT42ayG6PFiQADijNdmx0Hm/ugWrbynE/ngkNsvd+YbCW0HwtzeH95RZ1f6zt5gPxSTel53jJud56v09paA3A+oJsJpo/Y0aHHa6giQGzIp0Aj3uJqwOQUcN8jw1WmJn6ZWEmyGRgIWCn7etF0o62Cbm0jvywC8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=K8nE7L4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVIXD13D; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F34FF14000CC;
	Mon, 27 Apr 2026 00:05:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 00:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262759;
	 x=1777349159; bh=7sA1Vl5jolxK70Oa0cKHhOdpSjEUXYli5D2vNFWfhhY=; b=
	K8nE7L4pduA5y0M83Qf5dIrYU3gdYV+ygo3gUwi72byP8YkYRxgh+cxhM0elmonp
	fR5EYWE24xEs1IPBKdEKEJQAK0XvHUHpDW7Oeol654b8FNanBA0rhWjN1U8vtOg9
	5N+JrS8n4c30wd4l9fFlhbz7iP9wJHeZr0sfSq0quAQygr4aw69grTJGugslwRP+
	6hUNJKLLJq5JjHVmI+7tn4GVPyiAcjZENxcffZgps02Lv3Y50XNpHR+jQDxEAc/A
	oCr2zwDjzMoOpWudksPLuXOM+Gp1+tToCC5YmiOBPNJ11173QU/2+SRA9NkrJlEu
	RTw5GXZgjVUaJsjSHVHQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262759; x=1777349159; bh=7
	sA1Vl5jolxK70Oa0cKHhOdpSjEUXYli5D2vNFWfhhY=; b=SVIXD13DUYlFT5//a
	ySoJ5mhnUm9g8t/6Mrkq9r/J49CaFtk+wxGMKcxcY+AslsqK8v2xCk5WA6vWxrCD
	eGc43vDp3e8KB72FCI8MnmZ2mNRy5YbGthgssruPQWGk3DD1tzvffnwFUWDwtayT
	cmsc0nKrxo515pJjRANG7ZKZcafCni0yXuxFKlaFnnBOQU7Nmji8rugdXsTWvzVh
	Yr3EvUpMm5xa3I4Zaq2XPtyGUMo3v3u+L/tyzpDHtEYVGKpUtMBrA/qRTp4IERp+
	hz9IsBr4v3XylCJx70Dhu16QFzModvq1auvC+geM+I4FpVaLXPhkgH8d+UTRHgPp
	kEIPQ==
X-ME-Sender: <xms:p-DuaSh38MoshfzZpAXbej9UOMVGMKQTcytP539YaQChCNvXbR8iOA>
    <xme:p-DuafV10qlBaGGux97VjWoxho0LEpxP39ba5FVljB5Ss_pdhqJJZi7uJ6z9tj3by
    x9IQHPuigxitg5RW3HlR7GPNXVaXGOJJYMpwIx_JmFGaqr4RA>
X-ME-Received: <xmr:p-Duabv5Z1KUmNOCc9ZWg4QnFg0eP0U-4WL0uzFzYimU4ADlGxyfp1g6YkDQE3J6mxvHjJ4SFfIvWSA97WDxrEchbv1XN6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeijecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:p-DuaYYVTCxxeELKb-4AEFGw5YCuMmARZKTxSnhSMwwcRWeegPjA-w>
    <xmx:p-DuaU4qJQbnNnGAxbSSXFC8w50mank_9LrtRucVEPIT0D5SvOTe1g>
    <xmx:p-DuaQnwYsiKaOS28csA3TsJ-muH4ulv_FOlR8jmQQo1n4ykUvO9qQ>
    <xmx:p-DuaaH801ikFjnkZBO7L2zb9lxguNc_-z3XmI28q4wbIDncvSaR9Q>
    <xmx:p-Duabwz9RWjnmNgA2XOuzVUwlXO1YefmVXAjdwGj1rRCu_hu8riHX1C>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:05:55 -0400 (EDT)
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
Subject: [PATCH v3 02/19] VFS: enhance d_splice_alias() to handle in-lookup dentries
Date: Mon, 27 Apr 2026 14:01:20 +1000
Message-ID: <20260427040517.828226-3-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 743A346CD8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21137-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

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
dentry is still negative.  Others d_drop() the dentry so they can use
d_splice_alias().

This last will cause a problem for proposed changes to locking which
require the dentry to remain hashed while and operation proceeds on it.

There is also no interface which splices a directory (which might
already have a dentry) to a hashed dentry.  Filesystems which need to do
this d_drop() first.

Some filesystemss (NFS) skip ->lookup processes for
  LOOKUP_CREATE|LOOKUP_EXCL
which includes mknod, link, symlink etc.  So these inode operations
might get an unhashed or a hashed-negative dentry.  There is no
interface for instantiating these so against they need to unhash first.

So with this patch d_splice_alias() can handle hashed, unhashed, or
in-lookup dentries.  This makes it suitable for ->lookup, ->atomic_open,
and ->mkdir and others.

As a side effect d_add() will also now handle hashed dentries, but
I have plans to remove d_add() as there is no benefit having it as
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
index 2c61aeea41f4..789544525c56 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2068,7 +2068,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(d_really_is_positive(entry));
@@ -2822,18 +2821,14 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
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
-		hlist_add_head(&dentry->d_alias, &inode->i_dentry);
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
@@ -3133,8 +3128,6 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
-
 	if (!inode)
 		goto out;
 
@@ -3183,6 +3176,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3190,16 +3185,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
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


