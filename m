Return-Path: <linux-nfs+bounces-21115-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNDHLrzZ7mkNygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21115-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:36:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D246C5D6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C927E3008D04
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC3246768;
	Mon, 27 Apr 2026 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H0XNDIqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdLIigYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12312BDC32;
	Mon, 27 Apr 2026 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260985; cv=none; b=i55FAp276BtbpvDQKZu1jdsRv7q9dapok1cVtbYd0HXPGf0Oed1Fo7pL0PmAgmSgS8aCd7S8vtR9cOw7NojqiCGYR+jGxzOs+99i66ckRxeyuDM7tIsZrWY3825WfFhHNEueIQFv/gwadD7g6C3nEvfk8/xZMrEez5uNgiW81fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260985; c=relaxed/simple;
	bh=DELTMxF9kP8S3D0HUlogd9b5wHyCedqPjH1ZMIOOcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJRhilZyzoWGm4cbwJBBa1TAM1UoOKl4YswqbgbD6TD31fUAT6aSmyycBT2VDK3WTM8RY0VjK3j/nvIYO5KabR6MmcUtkyytwkTswEbYgJrQWk0pK0QKJMzXmvyv8DN/I/c2WeL8IoQd6E0855GlgPwn8n/bsdc8+saZs1wCkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H0XNDIqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdLIigYt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 070C01400057;
	Sun, 26 Apr 2026 23:36:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 23:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777260983;
	 x=1777347383; bh=/9kQHGI58tF58bk2NGiFwIvwHRvIsc6zHHG5MNu+tic=; b=
	H0XNDIqqGB4/yHCRRHVwzm6JUnVnT1cPW1g5ps9uBne8za9Tj6T9yqXsjtPEjKYT
	5AkVVv8UB3MKjrCyJ1vFCAwGIAEuF7jeVYkd1YL2jEQk7Rmfmvo2GOB2D+PeI1Da
	o7zeHWH7FqMV2A9qcryKa7dFt60ZHW1WDxjVwt6iCjSkz5KUATTawyz1R8jJGT4p
	4U2B2CZxAA1wHvcUI4q6S+1Lb5A78fCS4YuFb64kto+dLBAsVhB8CGMprbvxYJ6z
	eGlcxHn0tJoulVuo9Q7ZYH51fd9ulJcPuIm/nwp/edNKFNKhkSBynmvt0owYkRd7
	2Jxn1V2hUtYalMaT/d/9Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777260983; x=1777347383; bh=/
	9kQHGI58tF58bk2NGiFwIvwHRvIsc6zHHG5MNu+tic=; b=QdLIigYttmA5xqZ5i
	HDqX8XMiOnBqoLIxE8twjwUBZ5H8PpwNcN0/thZeO2phqN5n57kiHMMvYSavY9eS
	kLp+fuDvhWqWTxruxTZ9zZcwyHJ8R4W10zAf4eHXx/HLvF9Sjcc2x/qIfqp+tYYl
	MvducfuoF1U66/WmuOgL4hnZCp2W4/6FT/U3bwWq8KOFzzSsBZggTRTztckacrzr
	guWPhGYSbSPMXi0VQYE7n2AO0QRhsGbCMSw2CZ5+mxpw+NX0HDRxk751qMwCT8pR
	w0YIJax/SbsIp3Yj2eyuBlqya5cFaTjd+6mDQm/06jLisvCHMHoug1F2DWPRsW7x
	4u19Q==
X-ME-Sender: <xms:ttnuadX5wgBy0IF7ZYXz1Es1cJlmrnNt9fREmmsYqNd0jnTAVfSaPg>
    <xme:ttnuaYSWe6hIqUA0QSvsm1Pl3kCL6TVQhtdcx-ot5mpazIwMG3oar470jzzdzrtyb
    6USmNO79CeD1gDQlTHblxqrnc25UqEYkB8Dlop0fFIFj2CY5Q>
X-ME-Received: <xmr:ttnuaQBhSQxcaoeF4vDKOwfLlAiGrVEySQ9ikukIxOc0LoH5HkSEKwLLezF4KElZoZ0hBbUDeEPEeBLxApMJWdC1VsCuBng>
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
X-ME-Proxy: <xmx:ttnuabTojDGrXZeSzl5UbTDWiv48gjGmiUQr0KYmwYo3YbdSFyWHPA>
    <xmx:ttnuaSTsn5oxH98-v5qH2jLI5j7xYdG_GXbZZOGlWYvFfxzNv0q2UA>
    <xmx:ttnuaZJ6is9MnRti4LcItxafs7sLMV-9FYdqPPX4NNbOwv7f44UkBQ>
    <xmx:ttnuaZEbZP62FskUSM4Bb0Zjl2-pfg9DN2Zxd8dwkrPtIoT5DKHGyA>
    <xmx:t9nuaf6TR-BtAP5FKdjx1cJ06Co0MoUkbt5JmvWWntXzeImsQY9UhIm->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:36:18 -0400 (EDT)
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
Subject: [PATCH v2 01/19] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Mon, 27 Apr 2026 13:29:34 +1000
Message-ID: <20260427033527.773006-2-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 1E0D246C5D6
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
	TAGGED_FROM(0.00)[bounces-21115-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

Various typos fixes.
start_creating_dentry() now documented as *creating*, not *removing* the
entry.
Unwanted spaces in Documentation/filesystems/porting.rst removed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  8 +++----
 fs/namei.c                            | 30 +++++++++++++--------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index fdf074429cd3..bfdff4608028 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1203,7 +1203,7 @@ will fail-safe.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
 take a qstr instead of a name and len.  These, not the "one_len"
@@ -1212,7 +1212,7 @@ that filesysmtem, through a mount point - which will have a mnt_idmap.
 
 ---
 
-** mandatory**
+**mandatory**
 
 Functions try_lookup_one_len(), lookup_one_len(),
 lookup_one_len_unlocked() and lookup_positive_unlocked() have been
@@ -1229,7 +1229,7 @@ already been performed such as after vfs_path_parent_lookup()
 
 ---
 
-** mandatory**
+**mandatory**
 
 d_hash_and_lookup() is no longer exported or available outside the VFS.
 Use try_lookup_noperm() instead.  This adds name validation and takes
@@ -1371,7 +1371,7 @@ similar.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..65e60536a6d1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2942,8 +2942,8 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
  * end_dirop - signal completion of a dirop
  * @de: the dentry which was returned by start_dirop or similar.
  *
- * If the de is an error, nothing happens. Otherwise any lock taken to
- * protect the dentry is dropped and the dentry itself is release (dput()).
+ * If the @de is an error, nothing happens. Otherwise any lock taken to
+ * protect the dentry is dropped and the dentry itself is released (dput()).
  */
 void end_dirop(struct dentry *de)
 {
@@ -3260,7 +3260,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
  *
- * Returns: A dentry, possibly negative, or
+ * Returns: A positive dentry, or
  *	   - same errors as lookup_one_unlocked() or
  *	   - ERR_PTR(-EINTR) if a fatal signal is pending.
  */
@@ -3382,7 +3382,7 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
 /**
- * start_creating - prepare to create a given name with permission checking
+ * start_creating - prepare to access or create a given name with permission checking
  * @idmap:  idmap of the mount
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
@@ -3414,8 +3414,8 @@ EXPORT_SYMBOL(start_creating);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
- * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * Locks are taken and a lookup is performed prior to removing an object
+ * from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
  * If the name doesn't exist, an error is returned.
@@ -3441,7 +3441,7 @@ EXPORT_SYMBOL(start_removing);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3470,7 +3470,7 @@ EXPORT_SYMBOL(start_creating_killable);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3500,7 +3500,7 @@ EXPORT_SYMBOL(start_removing_killable);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.
  *
  * If the name already exists, a positive dentry is returned.
@@ -3523,7 +3523,7 @@ EXPORT_SYMBOL(start_creating_noperm);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.
  *
  * If the name doesn't exist, an error is returned.
@@ -3544,11 +3544,11 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 EXPORT_SYMBOL(start_removing_noperm);
 
 /**
- * start_creating_dentry - prepare to create a given dentry
- * @parent: directory from which dentry should be removed
- * @child:  the dentry to be removed
+ * start_creating_dentry - prepare to access or create a given dentry
+ * @parent: directory of dentry
+ * @child:  the dentry to be prepared
  *
- * A lock is taken to protect the dentry again other dirops and
+ * A lock is taken to protect the dentry against other dirops and
  * the validity of the dentry is checked: correct parent and still hashed.
  *
  * If the dentry is valid and negative a reference is taken and
@@ -3581,7 +3581,7 @@ EXPORT_SYMBOL(start_creating_dentry);
  * @parent: directory from which dentry should be removed
  * @child:  the dentry to be removed
  *
- * A lock is taken to protect the dentry again other dirops and
+ * A lock is taken to protect the dentry against other dirops and
  * the validity of the dentry is checked: correct parent and still hashed.
  *
  * If the dentry is valid and positive, a reference is taken and
-- 
2.50.0.107.gf914562f5916.dirty


