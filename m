Return-Path: <linux-nfs+bounces-22142-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HT4IYEuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22142-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779E61A947
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97238300293E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434E38333E;
	Mon,  1 Jun 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="P21hQLA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiOcwnMA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AC3491D0;
	Mon,  1 Jun 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297270; cv=none; b=LTSwgp3LvuP+468m1Pe0+bcVgpU3XTULTxOHMB7//bBBXNW0kp6xs/vp9G5AM3DqPW0MxAjTt/vDvg1YgABqPPsDpyirZB8ld/afbxrIirhWGPyTmRkmGV2RcNig5Cuo6DhkP1Q/jo6ksgN2Y4xBlyYsJWj8SnjnGrsezBtobrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297270; c=relaxed/simple;
	bh=TDc7dh6NNNjKmWGcBvVj58tUBuQZBZ7jsPWv8gEbcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rToD3u7au8sebsyEBguXPvvfI0UPbsJqml5dXfAr04brpHiXj/LlX92xOTJ1CtZWcQKuWRRgVhLSGTC1BEGMUysxHPQFqPPhPuxRmEeifpR4KxKqZ5wuiMI56rSWBGoKqxwbsMeLAxvWz41Xbe1MDV0jAY8r20MucTLN8olCQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=P21hQLA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RiOcwnMA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BE0D2EC01FF;
	Mon,  1 Jun 2026 03:01:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 01 Jun 2026 03:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297268;
	 x=1780383668; bh=HdhnVtmOLibzEPZm8EzezN431iTgWB7oXxS2i/pzZq8=; b=
	P21hQLA+YiboKZRnbVsEPn7s77NTTDVquf1iZaVDg4SMfzF727uLilvWZz8k3CLO
	FDSYlmy94e41cAFnPOm8Rk8QMY7Vy7cg6UBB59cKJT4IydQIRZ1I8DfU37s3af4d
	5IqHIbMZ/6U/vHMWHZuOWTmlwJsTAUzLj9kN8i8Amdpo3R3fG/WJ1lojbANR2vsH
	102pqkWiG98UaO9FfhACuxLLKv8KjMPKDZXXngOu7qYRedMvXpDJ+C6e+i0e7RNJ
	lf+YgqbVIlEt0oGTjGG+T5Tmag4pCXQB+SSNl/qBsRTBCO5ZR0GrmGZ+ssSIJ+lW
	5erMwdNb/4ZCDSnHO5Qkow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297268; x=1780383668; bh=H
	dhnVtmOLibzEPZm8EzezN431iTgWB7oXxS2i/pzZq8=; b=RiOcwnMAil5mpjpiZ
	xux1d9xYPkQMu10xD+OnnBm60p7irz9TyyyFzXRa9V7QSMdzhY526bBLmr7Ey3rW
	wPIYVvwgudcnnWTcgQMV4hl859W4ja3MggJNW9P2i1czx6cCWB0eqfKxF+X3zljk
	A58yJ63e2Jyt4fKrYn3niEqlOz3W+18yD7MSGUf199vTKSrwvwYHvvJSyCL19npU
	KKTAAfeDoV4lWoVlNy7AJ6SOu46gB79ofMl5HahBgC0TLYlcYUsQpTrZ/XEg/JC4
	3FEPjG2t925FY5PddTH+c772IrLPhh/QNL6KB4fRBwDXoJ0i1/pHRCpkYgzH4R61
	ZNezQ==
X-ME-Sender: <xms:NC4dahNKrDbnF3-l1cOId6WsH5MR7_y2lWUrh3URdL5mK2BbWol9RA>
    <xme:NC4dasKs3pdGJR89ozRLfo6BVyd6WGr1akQLEFn0ybc8TUgDre9HeQwpU8lQ5wb1i
    phe4sA9TmGngaPvT7seCz6QWKoVBveRoKMorgBsM_G-Wh6T8w>
X-ME-Received: <xmr:NC4dar2cWMGZ9iyKl6YawX34ehjqghZNhl8smhIUa86Jo1vW9jki3lGk0Ho-NH4CMLpMmkrc2Cd7DUBEmxWN0lX5L-0h9eI>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrH3
    u5DugNt+9VYY7ht3vX3ZA2sronzbrcw68BvFm0E56hkJwI1Yl0GVcmIWbzIl9Pq5ssZlCN
    UNURw9uhcCNWhCAWxbO1QB/t9j0GEBN5EyyKIdt2u25sBH639+kk+XMnOARX6w3iEcFk1h
    VzwHz63C+n2EMFPtpWBtSkgS0yEv5dzeac0qalYlCnMueDuVKvKdxRbElZZYOZ7H+AWlvC
    n563p/6vuaENVPpmOR5/v/fEpPYQ/PEkglkBkety54/QLW8PsnfXVbPvgViQkyZ5zyqqiv
    sxv3qJOffTUzaJzmW4fnR/gRDJR6iWk39QzF0doNqJH4WOsVfPPdp1ai0AXw
X-ME-Proxy: <xmx:NC4daoUQQbZ2NtpEDimcsXcllA1VA-N-q6gsQk_3ZphTfgA6D4GjMg>
    <xmx:NC4dalPKdZalpGmLsX9YlHGLp22WX93B8n6geeWyU3S4k8zywvIMcA>
    <xmx:NC4daj2KVlkA12eeoYqDBk4LCq8K-32s6J-_Stvrq3BV3yiYkbkmEg>
    <xmx:NC4dahTFEvAvRmQHWgKwqU08ciSwPHfiIjbItJtl5LDtYfGOsrzULQ>
    <xmx:NC4daiwKd6vapraSMXv1SVkfRAfh5K40cenb-yvpHoyqrXy5tawOgG9H>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:05 -0400 (EDT)
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
Subject: [PATCH 02/18] VFS: move delegated_inode retry loop into lookup_open()
Date: Mon,  1 Jun 2026 16:37:50 +1000
Message-ID: <20260601070042.249432-3-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-22142-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 9779E61A947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

By moving this retry into lookup_open() we no longer need to pass around
the delegated_inode pointer.

Various variable assignments need to be moved out of the declaration
block so that they can still happen after the goto.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 998fde251fcf..b00ff3f2faf7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4403,17 +4403,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  * An error code is returned on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op,
-				  struct delegated_inode *delegated_inode)
+				  const struct open_flags *op)
 {
+	struct delegated_inode delegated_inode = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
-	int open_flag = op->open_flag;
+	int open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
-	umode_t mode = op->mode;
-	bool got_write = false;
+	int error, create_error;
+	umode_t mode;
+	bool got_write;
+
+retry:
+	open_flag = op->open_flag;
+	got_write = false;
+	mode = op->mode;
+	create_error = 0;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4511,7 +4517,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -4546,6 +4552,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
+	if (is_delegated(&delegated_inode)) {
+		/* Must have come through out_dput */
+		error = break_deleg_wait(&delegated_inode);
+
+		if (!error)
+			goto retry;
+	}
+
 	return dentry;
 
 out_dput:
@@ -4593,7 +4607,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
-	struct delegated_inode delegated_inode = { };
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
 	const char *res;
@@ -4623,19 +4636,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-retry:
-	dentry = lookup_open(nd, file, op, &delegated_inode);
-
-	if (IS_ERR(dentry)) {
-		if (is_delegated(&delegated_inode)) {
-			int error = break_deleg_wait(&delegated_inode);
 
-			if (!error)
-				goto retry;
-			return ERR_PTR(error);
-		}
+	dentry = lookup_open(nd, file, op);
+	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
-	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
-- 
2.50.0.107.gf914562f5916.dirty


