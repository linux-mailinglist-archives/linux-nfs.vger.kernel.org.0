Return-Path: <linux-nfs+bounces-22158-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NEbMgEvHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22158-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:04:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC161AA07
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 890243010DE3
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840D347BBD;
	Mon,  1 Jun 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jTQEYteY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArFi2Rfe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932038331B;
	Mon,  1 Jun 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297355; cv=none; b=dzgcLa5C1EXy4tpWHJUic+K+81r438SfsZN3X6ezgbS+2sJUTYY/r9sTMWVmiWMmVcFWw7MrvSjPMNbg7y+al+eyyV8e8eGvr4RZvwt3f8J7+WdaIjqFE7WxABpAUebOfRmhiR39Yj1VOJLQTPhx+Lx4B8+B1W8mIa3SE9vvSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297355; c=relaxed/simple;
	bh=qXPKTLOiajVNkVAz4u4ZxJgDwHPvgwG/lj1R8p12sd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNn5wLlD6Yn7IrdtJUMHTgAIG3A3AZYtdBfWwt6oWPZNenvyWRBsD4XSB0+W6FUp7s2gexJUxQa6Qv807STfZ6EmDPnrGWnwuNt8d6LUry1cpBORL1bBO82v8fBmiGrGVQoS3ZPq7Ti2zkWfSkodVO3y0q4PMl1ZUVdid3lve+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jTQEYteY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArFi2Rfe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49FCF14000BA;
	Mon,  1 Jun 2026 03:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 03:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297352;
	 x=1780383752; bh=j3Apj8Sfk/i+RbaL+sg11Nf5puhOledUPmX0cPdnz1s=; b=
	jTQEYteYXEW3GjzjEJ187AqNRA/iIds9AF0SMm/wjgJngvrx/9c/NE/Tgq5j/BdO
	Q92iVMbgOtncR0fq4kOxtnqSeCRCYjShZYy6s3hmk1CZgkuwy/BELYKdtT6mxGyT
	rlXl1gkb+/Ys+FeS0cFl/D5naouRs/wDb8T3WS5ftlysJAry4Z3FHGAfPbC0K5/Z
	PnFyzhVWmjmfA79m3MXN7DZ+mLqtgb0p6JUssukZMqzepTknUCvlQ7OQOp56cxvJ
	nbQFNefcWTnBEhQ1iH2oOLPxwK3Y4IQS/RaqX9EOUlGSFb6k5GLK2V2yNWEzHCvu
	RkcSBE6fBkUK7mAaiUM+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297352; x=1780383752; bh=j
	3Apj8Sfk/i+RbaL+sg11Nf5puhOledUPmX0cPdnz1s=; b=ArFi2Rfej111KRdMX
	OSFWQuv/22GFvrLPgma/fWQwERgrcqj+8Nr5DcpiyZnMGrJBrR+H86Mq6Lm7kbyf
	ymowFfOMMcEPmWZeBSjczCrjXVtOQJnL5N34qSL4YO9WVp3/kq17TlMgyXiF5+h7
	dCXgW1VK6NRsn5cVHQcFbsrRbnoQoga4nHFRttQ4+8uNsCu/Ra0QWH4LNr4iu2e4
	x6VugHuWUR04BYMgU6qFCTzd9B4t9VwerJEZG/k0Lk9HcEcDhDwkaGtgqRUVqJVs
	J2ACref3m6jm8NG2Z+NpUzZiMgPBMHF81SZNhmNcu0JTLNy1b8lDDzboLY3nfd9D
	lWltg==
X-ME-Sender: <xms:iC4dagRfTcEK_9DuQs3-oW7tW5YFkM59Lf5VLx3XCezlptEOkrmurg>
    <xme:iC4dal8dcaMTAzYYKUYzsBKp2w1QGlGJJ_yWJ1TrUGTU1KC5dnqtiZCvt7b2eYP5z
    _o7_MUY9XWViOY0wArAaHfrYXl-JNZlcBxfuBXZThDqEtE>
X-ME-Received: <xmr:iC4dapadmzbaMcHmF7zxSY0gcUiSy0vliKmOmeywnM9srn6GJOD3LF-4DmahZjrMVvJbC2FhFfH3EWndP1iljEvn0K2I7ko>
X-ME-Proxy-Cause: dmFkZTGEUF1VHtABeBM7h+17oE/azWPgDSHyGC8OacUBc8I0E+XbqLSj+rrDsb9HrUfyZZ
    G6ZHqOdosDmCYx7KOvJKRY6oHzbE59WqHKYOTYiKZoODiXdtZjSNfE4t3zU3BVv1TdBrOK
    yp05iYSG/9ga5NcpcHfqQnXeKceNEpKORaIrxPQDkit9Zq1d3nGs2tKCBOurA0wNDXh8/H
    iqVbi0f/RhUnKplD+0vjT6h7ov8Fu53dx425whnbRtKHnwWuRPKwNq8qXesY8wcZUUcEk2
    ELQpwZQJeAYwLK9BvUBQSHxQVyu3tegeBqXUOiGwgqqJRvPGQdWR/ORYH5rNTVm+27fJYn
    g2xxwtsMwVgOY8PoRbJRjFpXj3FhejT9Z6aVCU2zP7DbNtM199sbQCOsbpsSHR3vqw5jin
    qDvMqVXMDc4d3lQUTRzq+MwKwIkBSw/ceB5YOsMgHdFOa+7W565/Bsek1BGHXCRKBuoYJq
    Mz/vhpB99k2nHvJDAxdixu2laOFxz81gaKR120SxA4YNFGh54jibdejRmvykOCsp/pz3Xl
    5S7KivpysSAjJcuHvzlkcckofsbmEIiVbUm6zYWTRzRg8QzAucgoJYzwLrH7R0dZ8Hrndd
    lPK7ZkB1L+E+Sxi6/LhzNq310peKBAX7PrMqU/m6/MHy60mOqiHQsjOq2PiA
X-ME-Proxy: <xmx:iC4daupil8yJEvvqBNa4gaBOeTIKGAV35S6IyQwL8CjsqPa3lwA5CA>
    <xmx:iC4dalSdWTL5tDIWibUUXuriDjvEmBia9gaBAXSGBgo01KT90e_2iQ>
    <xmx:iC4daqpH1svwNyw-SVZjIYiRdpV8FXhW8V2tc2W1Ot-maLgVwhcvaQ>
    <xmx:iC4dan1aIpskuri3VfXGVQ6MAQtAQ8WviEcAq4ohGtrVr5QiHk-3rg>
    <xmx:iC4danWBeZiF_IQLXFRdwD-m5_RPajPiUTl_GpGqB8Z_TPOm_-QMRuDW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:02:29 -0400 (EDT)
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
Subject: [PATCH 18/18] VFS: remove dentry_create()
Date: Mon,  1 Jun 2026 16:38:06 +1000
Message-ID: <20260601070042.249432-19-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22158-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: C5FC161AA07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

dentry_create() is no longer used and can be removed.
vfs_lookup_open() is a better interface.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c         | 80 ----------------------------------------------
 include/linux/fs.h |  2 --
 2 files changed, 82 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e4f3c0d00c8c..0ccf04056292 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5067,86 +5067,6 @@ inline struct dentry *start_creating_user_path(
 }
 EXPORT_SYMBOL(start_creating_user_path);
 
-/**
- * dentry_create - Create and open a file
- * @path: path to create
- * @flags: O\_ flags
- * @mode: mode bits for new file
- * @cred: credentials to use
- *
- * Caller must hold the parent directory's lock, and have prepared
- * a negative dentry, placed in @path->dentry, for the new file.
- *
- * Caller sets @path->mnt to the vfsmount of the filesystem where
- * the new file is to be created. The parent directory and the
- * negative dentry must reside on the same filesystem instance.
- *
- * On success, returns a ``struct file *``. Otherwise an ERR_PTR
- * is returned.
- */
-struct file *dentry_create(struct path *path, int flags, umode_t mode,
-			   const struct cred *cred)
-{
-	struct file *file __free(fput) = NULL;
-	struct dentry *dentry = path->dentry;
-	struct dentry *orig_dentry = dentry;
-	struct dentry *dir = dentry->d_parent;
-	struct inode *dir_inode = d_inode(dir);
-	struct mnt_idmap *idmap;
-	int error, create_error;
-
-	file = alloc_empty_file(flags, cred);
-	if (IS_ERR(file))
-		return file;
-
-	idmap = mnt_idmap(path->mnt);
-
-	if (dir_inode->i_op->atomic_open) {
-		path->dentry = dir;
-		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
-
-		create_error = may_o_create(idmap, path, dentry, mode);
-		if (create_error)
-			flags &= ~O_CREAT;
-
-		/* atomic_open will dput(dentry) on error */
-		dget(orig_dentry);
-		dentry = atomic_open(path, dentry, file, flags, mode);
-		error = PTR_ERR_OR_ZERO(dentry);
-
-		if (IS_ERR(dentry))
-			/* keep the original */
-			dentry = orig_dentry;
-		else
-			/* Drop the extra reference */
-			dput(orig_dentry);
-
-		if (unlikely(create_error) && error == -ENOENT)
-			error = create_error;
-
-		if (!error) {
-			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir->d_inode, dentry);
-			if (file->f_mode & FMODE_OPENED)
-				fsnotify_open(file);
-		}
-
-		path->dentry = dentry;
-
-	} else {
-		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
-		if (!error)
-			error = vfs_open(path, file);
-		if (!error)
-			file->f_mode |= FMODE_CREATED;
-	}
-	if (unlikely(error))
-		return ERR_PTR(error);
-
-	return no_free_ptr(file);
-}
-EXPORT_SYMBOL(dentry_create);
-
 /**
  * vfs_mknod - create device node or file
  * @idmap:		idmap of the mount the inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..8785302b0ae7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2472,8 +2472,6 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
-struct file *dentry_create(struct path *path, int flags, umode_t mode,
-			   const struct cred *cred);
 const struct path *backing_file_user_path(const struct file *f);
 
 #ifdef CONFIG_SECURITY
-- 
2.50.0.107.gf914562f5916.dirty


