Return-Path: <linux-nfs+bounces-21145-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHIpEQTh7mk6zQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21145-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1546CDA6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B6703006F3D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2A22423A;
	Mon, 27 Apr 2026 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aWucrkuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEhqmDtK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8385258EC1;
	Mon, 27 Apr 2026 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262844; cv=none; b=IZA275hYdWWVgoGA+IVB33JW2GvqrGI7XvGOUwDJwWxQKzukeBZl9LmxisIIziGGvQFeNrFIeVWQqx5NafsAVjytIKoentGMkoCGv4gQwteLUUnZ7BSlnAPfqTG1NnABNrFCPTgqITIpfog9x5exmLKxF4h1tjrSx84wnTfg0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262844; c=relaxed/simple;
	bh=VecR1S/RUz2yVvlcP8kNlxqqZIjt+aDgC768AxT9B68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TasECPSU0ZO4GibHtgYyrbNlmbbVNIfH/JXKuYt454HBZE1ikqbSWc/laI87nGHQMF8OY+KDA5zSI2bEjT0NrO26Sp5/N73rsnhnDVoCoagEOKx9RtGgU+I1csySydWmV9w/WL8oJLDtYQzyIaBxVOsp9G3ZgOu4e0So2ophI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aWucrkuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEhqmDtK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5962114000B0;
	Mon, 27 Apr 2026 00:07:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262842;
	 x=1777349242; bh=4qLfGt5u8e8xG1LfUYl9b2VNKtzHCyChlkSyeX9DFOM=; b=
	aWucrkuPdh0hDTFVIHIJ/z2l7UWezBybhVUerOuTHSLnFJVBEpBarf+NL+CA8AgI
	oOSbSdZH0wuEOtCfotVNlCVnMlTRoX9QqrRkAUz4jFuJ8KJx4lDAZ2x+LPIVxWGE
	aW2s2B4npbPYlqlh6eyD6eBkWUOu5lNGkQzr1z2zHDA9QxLxihVS+ZqWYeRTRWmJ
	T/YqRlIv99uxO4tU1RJHrCFSBLvfst1K94gf/Wk4YCmkshnS7dFtNQCVEaQHou9s
	ekXgouUal1wjvAflJK01tuRCZx/BsjBR9aufi5znxI23lifhC5SqWScYcaOpd4ol
	FhoaHFvjZhuvlv5zZ2bgIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262842; x=1777349242; bh=4
	qLfGt5u8e8xG1LfUYl9b2VNKtzHCyChlkSyeX9DFOM=; b=UEhqmDtKrJko5r1F4
	3Cx8eNHhkP+oT7harB7vebmP3i5eG7yKVuRQJYttvu5D51+gGSXmf6bRH57RhQLQ
	c+ZACvYtZOiV1KWmzuyAfK5j1pbQvBqB3mwEAPwq+xw13x0ma7NqaPGkgACeemEj
	ITtsA/goCesJ73oz75ZAzzaujGZ1eoQffM7RPjNnCBRZojMvPv8U5eBprhYSveV2
	ivTM79k0e76hnY3jhOlKt5XYE8V9utto9487fm7175Ca14UjS2bL/2ThKmMArMpK
	6XY+9zNU4METKyBjrYlXSZ3x6ZuhnSyGrQWcTi1S/y0PnLiLcKbvl11gXkBuNwzu
	Uv83Q==
X-ME-Sender: <xms:-uDuaeg9myAM_VgM6vGPdAYCDB8jLr7y8FnvXw5he2xDS9clSdW1dw>
    <xme:-uDuabWVGUsmxlGMplWDvBRlhUrSiI6aEQE2Br67FJapk7fniAZtsgpWUZtNrXDEq
    GoQAQmRN_i_0m1Pog8TcXGumDrjaRavF-HqGFPRNwAz3Qo>
X-ME-Received: <xmr:-uDuaXv-NqkZagwdUS23v_Av27iZzKAJqdd7dA-P0mumw-_VC-WGSOhipg5FLAFL8xTZZcIxsSMpkZtr1MrhsDmt6IDOb5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:-uDuaUabtQH3ABPx1MjW8DT_AFy8Xso2IDElwWjux48__EE05TyNzA>
    <xmx:-uDuaQ6dPX9MngpNFMw-gmF2pnID-3tU0xF6SCKaZInzhEkecjSgRA>
    <xmx:-uDuaclL5Jc9Xg9YIt0eKfogCJhh9YIBBxULINc2ndZ6DrpUyzKeRQ>
    <xmx:-uDuaWGNVgDu63dlmi9SsZ7_yVqeURPJ4d2et1ZkKnUdE0WeSLh8Xg>
    <xmx:-uDuaXwEVHcofau825C0yJ6rvvSl-o8I30IHrG3chEYS4j6FhqCrc_IJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:07:17 -0400 (EDT)
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
Subject: [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
Date: Mon, 27 Apr 2026 14:01:28 +1000
Message-ID: <20260427040517.828226-11-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: EBC1546CDA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21145-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

ovl_lookup currently needs to check if a dentry with the same name has
already been added to the dcache as readdir might need to do.  This
is an unnecessary performance cost to manage a rare race.

If ovl could know which in-lookup dentries raced with readdir, it could
limit the extra lookup to just those.

So add d_alloc_noblock_return() which provides the in-lookup dentry when
it returns -EWOULDBLOCK.

ovl_readdir() can use this this and flag the dentry such that
ovl_lookup() and easily check if a repeat lookup is needed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c              | 50 ++++++++++++++++++++++++++++++++++++----
 fs/overlayfs/namei.c     | 23 ++++++++++--------
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/readdir.c   |  7 ++++--
 include/linux/dcache.h   |  2 ++
 5 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a2ddfe811df3..2f11257b725b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2749,7 +2749,8 @@ enum alloc_para {
 static inline
 struct dentry *__d_alloc_parallel(struct dentry *parent,
 				  const struct qstr *name,
-				  enum alloc_para how)
+				  enum alloc_para how,
+				  struct dentry **dentryp)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2836,7 +2837,10 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 			case ALLOC_PARA_FAIL:
 				spin_unlock(&dentry->d_lock);
 				dput(new);
-				dput(dentry);
+				if (dentryp)
+					*dentryp = dentry;
+				else
+					dput(dentry);
 				return ERR_PTR(-EWOULDBLOCK);
 			case ALLOC_PARA_WAIT:
 				wait_var_event_spinlock(&dentry->d_flags,
@@ -2899,7 +2903,7 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 struct dentry *d_alloc_parallel(struct dentry *parent,
 				const struct qstr *name)
 {
-	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT, NULL);
 }
 EXPORT_SYMBOL(d_alloc_parallel);
 
@@ -2931,11 +2935,49 @@ struct dentry *d_alloc_noblock(struct dentry *parent,
 
 	de = try_lookup_noperm(name, parent);
 	if (!de)
-		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL, NULL);
 	return de;
 }
 EXPORT_SYMBOL(d_alloc_noblock);
 
+/**
+ * d_alloc_noblock_return() - find or allocate a new dentry
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ * @dentryp - place to store the blocking dentry
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_noblock()
+ * returns with error %-EWOULDBLOCK and the blocking dentry is passed
+ * in @dentryp.  The dentry must be dput() by the caller.
+ *
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
+struct dentry *d_alloc_noblock_return(struct dentry *parent,
+				      struct qstr *name,
+				      struct dentry **dentryp)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL,
+					dentryp);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_noblock_return);
+
 /*
  * - Unhash the dentry
  * - Retrieve and clear the waitqueue head in dentry
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 69032eb2b1e2..524e661c3c8d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1400,16 +1400,19 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	/*
-	 * The existance of this in-lookup dentry might have forced
-	 * readdir to do the lookup with a new dentry.  If so we must
-	 * return that one.
-	 */
-	alias = try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
-					    dentry->d_name.len),
-				  dentry->d_parent);
-	if (alias && !IS_ERR(alias))
-		return alias;
+	if (ovl_dentry_test_flag(OVL_E_RACED_READDIR, dentry)) {
+		ovl_dentry_clear_flag(OVL_E_RACED_READDIR, dentry);
+		/*
+		 * The existance of this in-lookup dentry might have
+		 * forced readdir to do the lookup with a new dentry.
+		 * If so we must return that one.
+		 */
+		alias = try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
+						    dentry->d_name.len),
+					  dentry->d_parent);
+		if (alias && !IS_ERR(alias))
+			return alias;
+	}
 
 	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_layers(&ctx, &d);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b75df37f70ac..bd6f1a25aca1 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -71,6 +71,8 @@ enum ovl_entry_flag {
 	OVL_E_CONNECTED,
 	/* Lower stack may contain xwhiteout entries */
 	OVL_E_XWHITEOUTS,
+	/* dentry was found in-lookup during readdir */
+	OVL_E_RACED_READDIR,
 };
 
 enum {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e03b32491941..e483bd939a8c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -553,7 +553,7 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 {
 	struct dentry *dir = path->dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
-	struct dentry *this = NULL;
+	struct dentry *this = NULL, *in_lookup;
 	enum ovl_path_type type;
 	u64 ino = p->real_ino;
 	int xinobits = ovl_xino_bits(ofs);
@@ -574,7 +574,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
+	this = d_alloc_noblock_return(dir, &QSTR_LEN(p->name, p->len),
+				      &in_lookup);
 	if (this == ERR_PTR(-EWOULDBLOCK)) {
 		/*
 		 * Some other thead is looking up this name and will
@@ -583,6 +584,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 		 * lookup gets a turn it will find and return this
 		 * dentry.
 		 */
+		ovl_dentry_set_flag(OVL_E_RACED_READDIR, in_lookup);
+		dput(in_lookup);
 		this = d_alloc_name(dir, p->name);
 	}
 	if (!IS_ERR(this) && !d_unhashed(this)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 662b98185337..db7cdcbac775 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -258,6 +258,8 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
+extern struct dentry * d_alloc_noblock_return(struct dentry *, struct qstr *,
+					      struct dentry **);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
-- 
2.50.0.107.gf914562f5916.dirty


