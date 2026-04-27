Return-Path: <linux-nfs+bounces-21143-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INeFKNHh7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21143-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:10:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B846CEE2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD96300DDC3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7D367F4A;
	Mon, 27 Apr 2026 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gFsra7bG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHvOX9fH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299912877DE;
	Mon, 27 Apr 2026 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262828; cv=none; b=K9MoLvfU1emwgJOHjZ6nhfCA7WKTiR1YxKsPG1lVG+bs0GgxHqyGSTHXNy+uALoBfYtXBebymx8HHsG6yuirSMc+VIJkViXjZVNdu7dAY3QJLBenC2GsXk7Fto8eppMag8uioEDz18vx6hP8kYZebSZWZgpLWdtOYWsAlb0akk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262828; c=relaxed/simple;
	bh=yRP77MAWO+gIHiR84B9F5QCRIoLxg6i5LGDL4a/5i6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cveACFqVrStfrwJRe6S/fBbj/N7mrgH508JKNbnxqrF1WsUGUwwvEQex8WBu4OYABB16VCvsVZBqfHE7KGOVvG8JC+9WbKqK+wPdvWaQsBeOk1jZVthx/YxCZOhTjxYZuMMgYCp6RivTRBgU9aKQHrbqZtJgdabLjrm9zr4/6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gFsra7bG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHvOX9fH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6639DEC03EF;
	Mon, 27 Apr 2026 00:07:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 00:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262826;
	 x=1777349226; bh=zdXjCv6aJzC4DSxkackOkKHCbtNaMCphdlTQdbSEugA=; b=
	gFsra7bGf8UMphMuVAxQbRumNM2bR54fpb1xKK6YnsEfaCaRV24mMFdXlNG/913p
	zcRz+P+ly7tUcssyb8Mx/d3tDnKfMh/12U8q7jwIZuK0UEa30oaQruZuE57HauNC
	UiJI9EfjfHf85zJcjydqi6Qt+rxWroqYGhCXNP0qHgKHWOOPNZXoyomcpd8S/wSw
	z7/uqmFge1lkkTqUzq0ywuFXM+DXH4JP9YEV9wmIb2IzGWkWJ6iAR0DgVTela8FE
	PPVwDiYEnMhe2P3Ti/vGiWeeQ65VcYSXAZfrHRPZXY1lrmeZvs0xWkivaARdl4VV
	jhdWGBxeU4CrLNcWzwlv0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262826; x=1777349226; bh=z
	dXjCv6aJzC4DSxkackOkKHCbtNaMCphdlTQdbSEugA=; b=VHvOX9fHObbSZZud6
	RHElDtw62QGF62utVH+AXLsBO7NQxYgcZuZZ6Ib2omPOFXu8YVdiPwN3B0tXEUQk
	VFq2eaQH3Fml8ouh4jMz6+zy4hxfvv/SON0CUWPuE6eTLkri5KmT6N63gocftsJQ
	ZOcZbwM7DmwY0QpyNzJaPTKvWjEDv4Mz2lWMDnxcSz7lJjLgYtnLuHQclD3vFc13
	FAB6p55Ze6hdZoepq7mSqufHH+AkLhucC8AZkE3a/vWN6q9nbrxmniPFL3Tbktko
	kHWzp7QjXeX14U7TBSymVaAIlHrK0xxVFHfTXSYE9ch4rDWQeLOAGaRBx/bcJ9Y4
	YrQ8w==
X-ME-Sender: <xms:6uDuabMc51kjUItboBnhRI9MWWoU1KNtkn6xsbsVMuD9WXk6KAzEqQ>
    <xme:6uDuaSTUtUfqssVWHIHgctgDClSMnl06qzZI6-sDd3zLUGDRTssPqaf-1hZI_J4Gj
    vU1TIz3TPwyQ9X0zBxWAYPlnTiLUZLPvwo7Ze5BtvzRv2MaGw>
X-ME-Received: <xmr:6uDuab5NKWhiL3Hy3O06DfjFRlBzQtE766XBHB_1RZablPb-xXNt2gwDPbD5YOIsI7mOQ0e_NIhF6icopXWTSY96u1SAs9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:6uDuac2M2y3rt7ZmNULvzlh8mqGhKp82IvSQJd70HzLzUqciA0O-zg>
    <xmx:6uDuaYm92ByPoKK4TPsDP_5Km6YLNgTwXGdYse88dvK6hkIIe56gnA>
    <xmx:6uDuaSiig63ooLAF438nqT9qvr_vHZWnj1Dyi5m-uyaubeCmJy_Qzg>
    <xmx:6uDuadStW17gYQj2aLCepR_jAtQjslrguPKky_WaEZ-IAapWvJ-8Aw>
    <xmx:6uDuaeQwY_ds6H_c_o1F575aXP1RZ15exPsmVi8_PKTtUxKsCZ5CPIFD>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:07:01 -0400 (EDT)
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
Subject: [PATCH v3 08/19] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
Date: Mon, 27 Apr 2026 14:01:26 +1000
Message-ID: <20260427040517.828226-9-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 104B846CEE2
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
	TAGGED_FROM(0.00)[bounces-21143-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ci_name.name:url,messagingengine.com:dkim,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

A proposed change will invert the lock ordering between
d_alloc_parallel() and inode_lock() on the parent.
When that happens it will not be safe to call d_alloc_parallel() while
holding the parent lock - even shared.

We don't need to keep the parent lock held when d_add_ci() is run - the
VFS doesn't need it as dentry is exclusively held due to
DCACHE_PAR_LOOKUP and the filesystem has finished its work.

So drop and reclaim the lock (shared or exclusive as determined by
LOOKUP_SHARED) to avoid future deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 18 +++++++++++++++++-
 fs/ntfs/namei.c        |  4 +++-
 fs/xfs/xfs_iops.c      |  3 ++-
 include/linux/dcache.h |  3 ++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 569a8ddf4c0d..a2ddfe811df3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2294,6 +2294,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * @dentry: the negative dentry that was passed to the parent's lookup func
  * @inode:  the inode case-insensitive lookup has found
  * @name:   the case-exact name to be associated with the returned dentry
+ * @bool:   %true if lookup was performed with LOOKUP_SHARED
  *
  * This is to avoid filling the dcache with case-insensitive names to the
  * same inode, only the actual correct case is stored in the dcache for
@@ -2306,7 +2307,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * the exact case, and return the spliced entry.
  */
 struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
-			struct qstr *name)
+			struct qstr *name, bool shared)
 {
 	struct dentry *found, *res;
 
@@ -2319,6 +2320,17 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
+	/*
+	 * We are holding parent lock and so don't want to wait for a
+	 * d_in_lookup() dentry.  We can safely drop the parent lock and
+	 * reclaim it as we have exclusive access to dentry as it is
+	 * d_in_lookup() (so ->d_parent is stable) and we are near the
+	 * end ->lookup() and will shortly drop the lock anyway.
+	 */
+	if (shared)
+		inode_unlock_shared(d_inode(dentry->d_parent));
+	else
+		inode_unlock(d_inode(dentry->d_parent));
 	if (d_in_lookup(dentry)) {
 		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
@@ -2332,6 +2344,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ENOMEM);
 		}
 	}
+	if (shared)
+		inode_lock_shared(d_inode(dentry->d_parent));
+	else
+		inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..30dddef43300 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -8,6 +8,7 @@
 
 #include <linux/exportfs.h>
 #include <linux/iversion.h>
+#include <linux/namei.h> // for LOOKUP_SHARED
 
 #include "ntfs.h"
 #include "time.h"
@@ -310,7 +311,8 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		}
 		nls_name.hash = full_name_hash(dent, nls_name.name, nls_name.len);
 
-		dent = d_add_ci(dent, dent_inode, &nls_name);
+		dent = d_add_ci(dent, dent_inode, &nls_name,
+				!!(flags & LOOKUP_SHARED));
 		kfree(nls_name.name);
 		return dent;
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 325c2200c501..f03d832f1468 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
+#include <linux/namei.h> // for LOOKUP_SHARED
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -369,7 +370,7 @@ xfs_vn_ci_lookup(
 	/* else case-insensitive match... */
 	dname.name = ci_name.name;
 	dname.len = ci_name.len;
-	dentry = d_add_ci(dentry, VFS_I(ip), &dname);
+	dentry = d_add_ci(dentry, VFS_I(ip), &dname, !!(flags & LOOKUP_SHARED));
 	kfree(ci_name.name);
 	return dentry;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3991f9988599..662b98185337 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -263,7 +263,8 @@ struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
+				bool);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
 extern struct dentry *d_find_any_alias(struct inode *inode);
-- 
2.50.0.107.gf914562f5916.dirty


