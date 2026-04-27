Return-Path: <linux-nfs+bounces-21119-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGGnAw/a7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21119-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:37:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44D46C6AF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193553021B34
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3EC35F178;
	Mon, 27 Apr 2026 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="t+R/nq9t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEkw9lse"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D035FF58;
	Mon, 27 Apr 2026 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261015; cv=none; b=SP2eveLc5ZQHjXwMSfQaEQnIjQLxO7l+zVatKbYXHXf06Byk5XngRczbtvd33qDnRXtJHjrdltw3e2+TK50xG+zpLGlzkTRO+4iF3H1Bl71odBiL/NIHhgOfEp7Zu69HezIxdY/P38K9oeQRT7Tfo7Iuzlnp5Pfx9dfj6VKw3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261015; c=relaxed/simple;
	bh=7PSFy+u24kcVfO16woP75mAbbdGt9GZMtu9sxyLPjrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmQQxEe3HAModplhms+LGfiFMRow7XP0DdgKPVT4eaHxePgQzaLqcJXhca4xlp4G/+2zUQZlyqZdckQ4k8glkdnOAKFLlElDXoouFkbUaNcVawlJUEulh+biQhad0ErbSMRaCKHpov802un9Gdvyy6yjfIFPaqsSZUdmjQuT0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=t+R/nq9t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEkw9lse; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4908C14000B5;
	Sun, 26 Apr 2026 23:36:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 26 Apr 2026 23:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261013;
	 x=1777347413; bh=8lHsylfevHWLXpDXjo+WYhNqHlp+1vh5/Px2rcHI56c=; b=
	t+R/nq9tMyl1xoEN1Mub3Yxly9nytixOwUrHCzyfwDGJP4F/mKNkGWjpg38GfkOe
	RGyekFD/WgF71Ti91V99WaRRkHe0x1YmklTB3vBIfHeYwQB4xrbPFJySjLFjKdtz
	6MpFJ49lmgknkvVyS/tU9NT+G1mLl6FV3fcS/C50iPwF9uB8165dXCrVbfY9tmdj
	ARLCiappu1Te6wrwMZMR0+60tA+NWEloOphxyZ10XM/bSw/YS/Nu+iOQZGTEjB/w
	gt4ld/oXBAa6jK5mFluMShe7/b0RNnTqQpNO+lKkxZqIbDnhFYC7B73bjuYR6COx
	fDLv1/do5opzla9te/OAYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261013; x=1777347413; bh=8
	lHsylfevHWLXpDXjo+WYhNqHlp+1vh5/Px2rcHI56c=; b=YEkw9lse0KOMSucUD
	LqoMNyLQbPjzN5AvD7gd7iPla59GBsMXr1zC+MQZn8EyuGSIS3d+409m7P5SySz7
	xistkzCuV0YWCVYUdgo69tLOUFSjavmxPm9MpAT0Az2uX7Bj0+ks92+/JFcbSyAX
	w2YoseyGsPBWCjKFu8fg2lPLrbVs/9PLvskm3ys/U7oqnkvUzoLDl0cpHObPT9kf
	7u3ujOL2RvAzFve0bY05pTl1Lay0tP8K9gVh1SHhnSsMmYgDH3C19NoO6TziyW3c
	hyvwhzCCCJLMgQqN/70/yQnN+FunC5jkRIkRjD8yCdbPSFa1vtIR7IeFf2sAd4/W
	W9Wwg==
X-ME-Sender: <xms:1dnuaZCa5sZbpd5xK-clm54vvlfMkJGOlD2XI_ynnqhvvvXwTOOp0Q>
    <xme:1dnuaRzijEiwDxHiqmdiKsQYhfzdpfbueMW-lh2adYna0ccI9W9998FpwE5VVXE0J
    SH3kUBbGG0GpalMcy91Vyq52Gv-0LZxK5B_KkOuc-LS-37KAKA>
X-ME-Received: <xmr:1dnuaaAJGs4Scp5HD4T-ZaQSBG3YmOov4HAistQLsgC3Au_gI9bsAZnuGm7UScaLtR5Y9bBad3Jd2BCDG2vRv-tRUtRGpiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:1dnuaaD42g9xIk-4SfMX2YG4ArV6glftKS2twGKN0AFIN5JB7IRvcw>
    <xmx:1dnuaV4zNtHso1A1GdGtL3QRHVduQLiEkFKv3OrD756LqHgIrzi9Fw>
    <xmx:1dnuaW0SmUBmt346ODHpXR9JUJbsRptnMzenlq9haLIf3aghWaaIOQ>
    <xmx:1dnuaRB9LY5nckhjZXvOfQu-K4GNZihV2xsXrZjYkyvWbQ1QzMnzYw>
    <xmx:1dnuaW6sgcFkPE9jkqYPGkhFSUIMYlWl-_XSq_N7mbNNJEigoLLeZH6C>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:36:48 -0400 (EDT)
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
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel
Subject: [PATCH v2 05/19] VFS: introduce d_alloc_noblock()
Date: Mon, 27 Apr 2026 13:29:38 +1000
Message-ID: <20260427033527.773006-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
References: <20260427033527.773006-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC44D46C6AF
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
	TAGGED_FROM(0.00)[bounces-21119-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: NeilBrown <neil@brown.name>

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_noblock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Unlike d_alloc_parallel(), d_alloc_noblock() calculates the hash and
performs a lookup before an allocation, as that is what all callers
want.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 91 +++++++++++++++++++++++++++++++++++++++---
 include/linux/dcache.h |  1 +
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2dcefa60db32..dc06e70695d2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2672,8 +2673,16 @@ static inline bool d_must_wait(struct dentry *dentry)
 	return true;
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+};
+
+static inline
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2755,9 +2764,20 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		wait_var_event_spinlock(&dentry->d_flags,
-					!d_must_wait(dentry),
-					&dentry->d_lock);
+		if (d_in_lookup(dentry))
+			switch (how) {
+			case ALLOC_PARA_FAIL:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				dput(dentry);
+				return ERR_PTR(-EWOULDBLOCK);
+			case ALLOC_PARA_WAIT:
+				wait_var_event_spinlock(&dentry->d_flags,
+							!d_must_wait(dentry),
+							&dentry->d_lock);
+				/* ... and continue */
+			}
+
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2786,8 +2806,69 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_noblock() - find or allocate a new dentry
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_noblock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name need not already have ->hash set.
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM, %-EWOULDBLOCK, and anything returned by ->d_hash().
+ */
+struct dentry *d_alloc_noblock(struct dentry *parent,
+			       struct qstr *name)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_noblock);
+
 /*
  * - Unhash the dentry
  * - Retrieve and clear the waitqueue head in dentry
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 14b91a7d0bb6..85e8570cbd48 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty


