Return-Path: <linux-nfs+bounces-22143-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMo/FDkwHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22143-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:09:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C561AB3F
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 224E2307B545
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868A380FFA;
	Mon,  1 Jun 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="A7LjxTJv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k024SUrC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612037FF5B;
	Mon,  1 Jun 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297276; cv=none; b=orZ+alHP0MC0dX+1EtLAEJ8zQ3ORDqMcieJDVg3gGctmecl3di3QsFdxp6HJHrZtlADQacQiO8IqUDtkRO9kLnqzKirm2idw5GQxI+i5Xhs8TA5h/MWjWBWFlaUfXNlEHtUu0JvCEvjtPObX6vJLFBZsjCip3Im7D4Z7WAy0Z3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297276; c=relaxed/simple;
	bh=KMplpZ3Byo2PQ7thjwl5y/NkcmyadFkCeC9sIlj63aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDMRCq9dZrUUXJdO43kJXgI+8AUkLED4jxGjtt81l1OVRXYxnUUOAvOw3wgNsR99aCfTMyet0mt3HmKR1wkRUE66YPv63C673XSMXRfQsEC64t6jlw74ltiLqQmT6K3QzLR3HUEbOX+EyHNn4jZTcF57TWfl6qIPtoO00J7D22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=A7LjxTJv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k024SUrC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D21914000E5;
	Mon,  1 Jun 2026 03:01:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 03:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297274;
	 x=1780383674; bh=eF2/1+5rkxNico07hAMT7wSkKMnwCslQoORk9t+09ro=; b=
	A7LjxTJvd4R7sZ41t42qFSvO+7UXMd1bfy8zvBVGTgqhl6YZfX6/OEH7e9lKnem9
	yBU5oPM+Oe0plZzW28tT06gq3Tu4wccrxRxQxCzeZ/2YPnWeRwWUpFSyLifZVF8Q
	UJR8gHcd5EtK4WB+CIR38SJQBGd8TKiPh/idacNzet0rg38rd8f7MLkiBrrTL8cs
	kmbXIWUvnAAZ1urqktpMFpkLU5Pie1P6Z7QsFr6bun5u8GBA1GMgMuWJMgDvkwLo
	IyR8gs9iMookyQR7dHOXX009wxXOwiHe+JjduxlZjyyLQo/Puh3HnMCPUQJmY3Kg
	rmODI1P4U0J1oAxrs0OpnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297274; x=1780383674; bh=e
	F2/1+5rkxNico07hAMT7wSkKMnwCslQoORk9t+09ro=; b=k024SUrCHbGYcmGcs
	rlhGkoEG/x7wSPiLrBRIR1meRHXah1qosyUsu4+3vMA6H4R4ieoUoE+udeLMOWpY
	wjgX8w4PK3NXFKTUE9KNgKlI4FJlsp7KsRmiXp+FF8JdQcMIy0uH+HBuB9inGV3+
	iceIf+1N3Uqrr5ZUgv+eZ8bSirWdphbDV3mXoO+kVQWwtvbyBI2x1VKqvqNIfG3L
	0+DqDR//HDwVGxAO49aNqYi+HZlzGsV/o+BZzJtuWVKJQgA1Rsk9sYHC+p6UeRx8
	POF/rvgJtKYWXrEcZzfFfgG4SY5maGzWxaKUdALilHo/vRPpCfCnYDPHQ8SViyei
	N0H2Q==
X-ME-Sender: <xms:OS4dao_8vsHwzf-ZS6g0lGsFbKqYxgLZW5gwzYe0Nl-ITR-V9WW4Wg>
    <xme:OS4dao4TgK3_mimVFcyDhGvWg_vM9HKxYpPKsZ8zFOr2UNCbRzEA0SC2LRP76g7qW
    AuROmwBz1_-whl-DVT4vuLNzne6PXgbkNbnusi4gIj_lfPn>
X-ME-Received: <xmr:OS4dapmpfKXTHHn7-ZuqPX1QRIqJO_v4zk_w2Bn_opkx4E4PfdfOg09BfJdq_CXhkjOvbq2AwaNCygTg3W-lQtbOw3swx1c>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrIY
    bTjIF17mbPPIU3OxEjC0ivie0Gi1/kS5e0/7P4IVjV+KfWgR5EvPgLmNtljv9JCYVJMpFe
    L+Uqiqbu2iShhC4pA7FqrVOGLUKSzEX62+fmHHzakAw/n59VKvMFErCYOIBlkXawUk0MMz
    WsvGZmJtLHu7tDallGu/xhKGDmATjBi8JGjaMBqY9ccIvUe3uQJAvyVTRBiNFego74ukLp
    V3k6ohRzmmR0vTBliZAQID6oc7xcONWSV2v8mzOPhfYgl6F6JYMmBmigNLdtr53YRDc6oT
    ywt294NvMgVvjwJmTgYx3CFjGPPHCYKV97fP4/eghUa3b4sQ/UGtFUBjfn7g
X-ME-Proxy: <xmx:OS4dajEy-N_9t8VUlXnx_encXU_hC5j446aRhjy88BWJUp-Oi2of7w>
    <xmx:OS4dao-oPxQ5EN1OOHubcKwQOde6wLi_jplSztBAfhXWPP3ntwHulg>
    <xmx:OS4daskRRC25GoRT-Go3z8IOE3Gbp6kYgHJIx-eImM5bbzt1M_MbCg>
    <xmx:OS4darBDDfHeKFnCfHMlip1OZd-Hd9cGT49zzbwzXvE-85EM_RH3sw>
    <xmx:Oi4datepTgsy6sRap6xqxYbRnHaUTPtMncX2Y0TVSK8YPlQsAtEUgK4x>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:10 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 03/18] VFS: replace nameidata and open_flag args to lookup_open()
Date: Mon,  1 Jun 2026 16:37:51 +1000
Message-ID: <20260601070042.249432-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22143-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: B00C561AB3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

lookup_open is currently given "struct nameiodata" and "struct
open_flag" pointer args.  These structures are internal to VFS.  Replace
these with the individual fields that lookup_open() actually needs.
This will allow it be exported so it can be used to replace
dentry_create().

As lookup_open() can change both open_flag and mode, we keep the local
variable and create an arg with a different name which is assigned to
the local variable.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b00ff3f2faf7..18a43c24d7f1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4402,12 +4402,15 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  *
  * An error code is returned on failure.
  */
-static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op)
+static struct dentry *lookup_open(const struct path *path, struct file *file,
+				  const struct qstr *last,
+				  unsigned int lookup_flags,
+				  struct filename *name,
+				  int open_flag_arg, umode_t mode_arg)
 {
 	struct delegated_inode delegated_inode = { };
 	struct mnt_idmap *idmap;
-	struct dentry *dir = nd->path.dentry;
+	struct dentry *dir = path->dentry;
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag;
 	struct dentry *dentry;
@@ -4416,13 +4419,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	bool got_write;
 
 retry:
-	open_flag = op->open_flag;
+	open_flag = open_flag_arg;
 	got_write = false;
-	mode = op->mode;
+	mode = mode_arg;
 	create_error = 0;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
+		got_write = !mnt_want_write(path->mnt);
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
 		 * a different error; let lookup_open() decide; we'll be
@@ -4440,17 +4443,17 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 
 	file->f_mode &= ~FMODE_CREATED;
-	dentry = d_lookup(dir, &nd->last);
+	dentry = d_lookup(dir, last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last);
+			dentry = d_alloc_parallel(dir, last);
 			if (IS_ERR(dentry))
 				goto out;
 		}
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dir_inode, &nd->last, dentry, nd->flags);
+		error = d_revalidate(dir_inode, last, dentry, lookup_flags);
 		if (likely(error > 0))
 			break;
 		if (error)
@@ -4465,7 +4468,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 
 	if (open_flag & O_CREAT)
-		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
+		audit_inode(name, dir, AUDIT_INODE_PARENT);
 
 	/*
 	 * Checking write permission is tricky, bacuse we don't know if we are
@@ -4478,13 +4481,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	 */
 	if (unlikely(!got_write))
 		open_flag &= ~O_TRUNC;
-	idmap = mnt_idmap(nd->path.mnt);
+	idmap = mnt_idmap(path->mnt);
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
-			create_error = may_o_create(idmap, &nd->path,
+			create_error = may_o_create(idmap, path,
 						    dentry, mode);
 		else
 			create_error = -EROFS;
@@ -4492,9 +4495,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (create_error)
 		open_flag &= ~O_CREAT;
 	if (dir_inode->i_op->atomic_open) {
-		if (nd->flags & LOOKUP_DIRECTORY)
+		if (lookup_flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
-		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
+		dentry = atomic_open(path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
 		goto out;
@@ -4502,7 +4505,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags);
+							     lookup_flags);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
@@ -4550,7 +4553,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		inode_unlock_shared(dir_inode);
 
 	if (got_write)
-		mnt_drop_write(nd->path.mnt);
+		mnt_drop_write(path->mnt);
 
 	if (is_delegated(&delegated_inode)) {
 		/* Must have come through out_dput */
@@ -4637,7 +4640,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 		}
 	}
 
-	dentry = lookup_open(nd, file, op);
+	dentry = lookup_open(&nd->path, file, &nd->last,
+			     nd->flags, nd->name, op->open_flag, op->mode);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-- 
2.50.0.107.gf914562f5916.dirty


