Return-Path: <linux-nfs+bounces-21141-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAAwIYvh7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21141-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:09:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1AA46CE91
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E57B30440AA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E600366823;
	Mon, 27 Apr 2026 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bc1QJpAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAzMN8m9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE227A916;
	Mon, 27 Apr 2026 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262794; cv=none; b=nUCoMTJYhnZUT4UEPZaF5Oez6fdiJ1NbLVetj2uXWzoT3rezdCJE4Rds/wEEeTUhA1e43p/qwRCsEO9TxRQk6AEsp4GqR1nYjT0qLImmotlqde6ph1Tj8mnT8jVEmXI8fOjbi9kV5aPCki+Gx3pnhTNyi2kEsG8A26X/EWd+Sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262794; c=relaxed/simple;
	bh=hPdDy+nq9BZvu+CByh4OHTQfVNub6SCjd8b0Ejvbz/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbZc5JgO8d34Hb+khh5A4s6fVOfkH2zxHr7zEzMmHMkF5fjf4ETI9uvBPAwgvO3dN+kFAz/zU12ifuS6ng7mE36afnjcACQIV4JbQXWT71f7GqaL6evWIFndTp9MXp8chQvEriSrnISuRgwJwUgByOP2sA5WfUuPF0w9knJdz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bc1QJpAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAzMN8m9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 04102EC03EF;
	Mon, 27 Apr 2026 00:06:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 00:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262792;
	 x=1777349192; bh=+evKnFZms5Q1zExWnLek6gAyl1qy9MDPzvO/EAV2rd4=; b=
	bc1QJpAbAYvKQPU+fMYntSxEJa83LpU6gos0ONSKgkn8Ot5UnDpCQTeNexaN47US
	Jba4lI2NLFwcmg+Ijtv4Hhbh0u1/6wvdhM5XYno0VQvncy469l0eVoTZrdZQKYkL
	PtohFaKqWPlCWFifHd/F4GvUEJZSRsDzoDiKGBP3ot90aJjsmMpBTIQdib8BHYT5
	VNjI1qyOwltpAz2CiUDLbWnQkni2fYBxph2viXrwhJJixyoP64qS7rkE05xu/Lx9
	BbCqbuDl/p9ZPyJkFuHptKfqL1C+ug5Ff/kY43SyoeRuxyFICNBMZpYBNoQSVgVM
	HwWUBnKU4frFtbCpJsP9OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262792; x=1777349192; bh=+
	evKnFZms5Q1zExWnLek6gAyl1qy9MDPzvO/EAV2rd4=; b=JAzMN8m9bnS/u4MUi
	tAlEhXDF6T3aNkl7jug3iJ/NiRx/R9DPxK/4SrfT3+C/GVQGotwsNNMwRkmQTfbh
	kHxqO4yXQZC2P/tpqKzq8X7i79ljwbETO7eINP9AqOxamjCSbqYEibyUzzpA0WrM
	qB48oiC6EAh9ZbW6G+7GbuQOTO9BaaxKx88YqL4sVePUu4QzRnCMgIqZc2VMvJRV
	FesnqqkNKqqwgBrzwz3PdkZYpW3VgB229rrL70mOa2I37HrPMoFwGzP20c9Yk7VD
	LlTFxumft6T5JrdWFG2BiQipTFE8JsP5o796mq7+qqEGiuVj7lq7uj9oWL5rITWe
	QC44A==
X-ME-Sender: <xms:x-DuaYoOI-wu5qdItYvKsAMnjL8r1OcRrKH6mDny_L0RSumK22u2_Q>
    <xme:x-Duaa_2tsr2mBrY-BWOcxBYsoxsqhqldvj1qhaGrLSMitsXOiasLhmVQuQXsTYAb
    -hgkzjWwb4RemugZXPfNOG1sVma0U7rTyT1f1JA8xb69FATRQ>
X-ME-Received: <xmr:x-Duae3k0Zb7GWLpSgrXQxpNK2fhreDxOwqEeipuRdRSV7F10YAEVaLY2bWne9C1LtjCnUUMXIitLW3Vwqw_qkij2DBHQZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeilecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:x-DuadAlzKRrUuMQ7yQdnEE0cmrtLQfgcR1pAbHiOfJ4dFLrSg3n1A>
    <xmx:x-DuadCVhpMLAI6NAQyly8GnuZcj8LEk1-iEPSxDcWz5YpDm8h7o5Q>
    <xmx:x-DuaWOCTFmy_p8c-ki0e9PV037IBtr2EHB6OkxQloBPpx_2ZXDKiQ>
    <xmx:x-DuafMovNyEXPl2KhG3WFQ1svJJxs8_wxGbb1Fs3t0GyhaBg2fCkw>
    <xmx:yODuaQ5G0JF5FFDpYxj1_GA-SDsxwvrerLDabToz1yT7BXjwqjmsmDoC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:06:27 -0400 (EDT)
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
Subject: [PATCH v3 06/19] VFS: add d_duplicate()
Date: Mon, 27 Apr 2026 14:01:24 +1000
Message-ID: <20260427040517.828226-7-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: EA1AA46CE91
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
	TAGGED_FROM(0.00)[bounces-21141-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

Occasionally a single operation can require two sub-operations on the
same name, and it is important that a d_alloc_parallel() (once that can
be run unlocked) does not create another dentry with the same name
between the operations.

Two examples:
1/ rename where the target name (a positive dentry) needs to be
  "silly-renamed" to a temporary name so it will remain available on the
  server (NFS and AFS).  Here the same name needs to be the subject
  of one rename, and the target of another.
2/ rename where the subject needs to be replaced with a white-out
  (shmemfs).  Here the same name need to be the target of a rename
  and the target of a mknod()

In both cases the original dentry is renamed to something else, and a
replacement is instantiated, possibly as the target of d_move(), possibly
by d_instantiate().

Currently d_alloc() is used to create the dentry and the exclusive lock
on the parent ensures no other dentry is created.  When
d_alloc_parallel() is moved out of the parent lock, this will no longer
be sufficient.  In particular if the original is renamed away before the
new is instantiated, there is a window where d_alloc_parallel() could
create another name.  "silly-rename" does work in this order.  shmemfs
whiteout doesn't open this hole but is essentially the same pattern and
should use the same approach.

The new d_duplicate() creates an in-lookup dentry with the same name as
the original dentry, which must be hashed.  There is no need to check if
an in-lookup dentry exists with the same name as d_alloc_parallel() will
never try add one while the hashed dentry exists.  Once the new
in-lookup is created, d_alloc_parallel() will find it and wait for it to
complete, then use it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index dc06e70695d2..569a8ddf4c0d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1900,6 +1900,57 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 }
 EXPORT_SYMBOL(d_alloc);
 
+/**
+ * d_duplicate: duplicate a dentry for combined atomic operation
+ * @dentry: the dentry to duplicate
+ *
+ * Some rename operations need to be combined with another operation
+ * inside the filesystem.
+ * 1/ A cluster filesystem when renaming to an in-use file might need to
+ *   first "silly-rename" that target out of the way before the main rename
+ * 2/ A filesystem that supports white-out might want to create a whiteout
+ *   in place of the file being moved.
+ *
+ * For this they need two dentries which temporarily have the same name,
+ * before one is renamed.  d_duplicate() provides for this.  Given a
+ * positive hashed dentry, it creates a second in-lookup dentry.
+ * Because the original dentry exists, no other thread will try to
+ * create an in-lookup dentry, os there can be no race in this create.
+ *
+ * The caller should d_move() the original to a new name, often via a
+ * rename request, and should call d_lookup_done() on the newly created
+ * dentry.  If the new is instantiated and the old MUST either be moved
+ * or dropped.
+ *
+ * Parent must be locked.
+ *
+ * Returns: an in-lookup dentry, or an error.
+ */
+struct dentry *d_duplicate(struct dentry *dentry)
+{
+	unsigned int hash = dentry->d_name.hash;
+	struct dentry *parent = dentry->d_parent;
+	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
+	struct dentry *new = __d_alloc(parent->d_sb, &dentry->d_name);
+
+	if (unlikely(!new))
+		return ERR_PTR(-ENOMEM);
+
+	new->d_flags |= DCACHE_PAR_LOOKUP;
+	spin_lock(&parent->d_lock);
+	new->d_parent = dget_dlock(parent);
+	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
+	spin_unlock(&dentry->d_parent->d_lock);
+
+	hlist_bl_lock(b);
+	hlist_bl_add_head(&new->d_in_lookup_hash, b);
+	hlist_bl_unlock(b);
+	return new;
+}
+EXPORT_SYMBOL(d_duplicate);
+
 struct dentry *d_alloc_anon(struct super_block *sb)
 {
 	return __d_alloc(sb, NULL);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 85e8570cbd48..3991f9988599 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -259,6 +259,7 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-- 
2.50.0.107.gf914562f5916.dirty


