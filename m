Return-Path: <linux-nfs+bounces-22144-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNqSJGIwHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22144-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:10:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AABD61AB57
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67603046504
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55746380FFA;
	Mon,  1 Jun 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Iy+oubfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBkNDf0g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426B3803FD;
	Mon,  1 Jun 2026 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297281; cv=none; b=Ghy8tjzVqJ5kfKJ0ssMrU5bn8BUoOQRecpCdSjkW+KD+yRtq4Yz86tjl1rpCuNFv/KjytPH3fSuLxcBuSCDrPGIJ+yrUlnFfY1HYk/lTqA5JQBw6y4Ki+6ScUcXogJ+CqFyHbXXmzDzjI5iBtdp0ydDLuUQRO1snVvcSHTWDBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297281; c=relaxed/simple;
	bh=vzAnzmkf9RRzUI/3s7X84NSAL5vbKM8mRBmLGsk13x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i66Jh4wXjdhRCCpZ/PsINnZAsYRI/lDZxUO4upOnOcAlIkED+ciYeOPxR+W+JiAnYXm1XOjy0XjfMVrLIkVuJ9BxNx4ORzOypzMuW312bqqWA33PGRETI3LbDmp4TOnDN2noaj0/B712BH48PwM39TjytftyWOOK3FhX1rjABeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Iy+oubfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBkNDf0g; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F0D8EC020D;
	Mon,  1 Jun 2026 03:01:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 03:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297279;
	 x=1780383679; bh=RldziyTR8Ox6+Sc1JrCA7D+WNb7qt/CM7rHJFkwpNSw=; b=
	Iy+oubfWSi2fk2KckEy5wUFV1wnlcgGan1nqoE2Cu+mtAXlAzJnFL9soFUQAwm+z
	JijhJU2VDSDDUinQawgPGK4K+HiLoKSNIvD/+Gj65ZH2kJHjw270s0wcxYXFxljG
	dD293Bl/R4VL24hkAn8UZJOjgXU58GfwmtbtqicuSg7dLs79e5mN7jUs9kxdc9Mk
	0dj7mzmvg8TB5ppsEXjBK1dLXSPSwRaSCu7A5bv67SglDLUR7T3lE6tezIsHvRnU
	Y+AdiknOvgpAVurJESwmxOB4ApNZEb/WlXU73PXvVc4HNtXe99uhVW8NUbN3FITm
	fMuXcoacc3MnmupqH8Fy/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297279; x=1780383679; bh=R
	ldziyTR8Ox6+Sc1JrCA7D+WNb7qt/CM7rHJFkwpNSw=; b=kBkNDf0gRaejXasz7
	Ykc4GAktyoSawC7eQ5cOigyZVClAE7I1IoHrReaCT41vqrEss4bVT8n44poMZ5Jc
	anNdFPpwCDSGaRn48ok76J4dQ/qQPxM6u37vRq6PFTb71EC2ElOTLgnuOMqt/sCn
	shThEbxecy1l5AxLtK70nmHAHtrQjRf6aoNFpYLTn4aGuBHFloRzxisClDI7C6m6
	bTmyC7akfRRyOOQ8Wwqtac4iyBk4cbq1XLgy0YYLBTFDTFSb4h7s5KdC8dqTyeLI
	QfXDooxh4A0pHwr1s+/hA7noTrRZTBfLH2DL6qy6n7EWahszF5azM5boBjJTp+55
	/yskA==
X-ME-Sender: <xms:Py4daoZFeiWC2kh_pZSFP8duI2zp2s5C9qEI3I1D4frSEzXDZN_aHQ>
    <xme:Py4darkOgN1Bt8M8WucfjDEjpnkCPU9u09p2Q9BLa7LKJ32qdYtlsmtjPve7MDp9k
    GJ8damu8l6uQq4JU60cVa9rxuObD_6Gb4RKcVXT42gbP2yBCA>
X-ME-Received: <xmr:Py4daug8x-ahPX1d790DOTpKDXB7dTf6G05kFf7xsMe0AIrwnQx8eEaEWFLjV4j7LlZ6MstyQLNSxIjKC4tbRiHPwU_JiFg>
X-ME-Proxy-Cause: dmFkZTERmdzuoRFytfcMQkm1vrixEKMv3PSznumYsbvRhXL8o95h0F+CUCxGpLguCyaxOX
    PskdnIHYux9P70EE80ontQKnYE9bPFro571a5L3dvkEf4cTuPWsG085A1Tk3bO8+Lgr68B
    xE06xdFkNT4zClSVy3kKptjg9gPonscPTUfHP1xYJIUrUpQdLeyLwm0ln0S+tMMgilnq18
    Sl6x7UAgg7vEkdY+60c0UtoiuBlpXwnUVhJf9ro19MClg60IJvd5kemVYWWOrslUn1wxJW
    uKtUPjshxJBn7Yr2UsLn4dt+Q7gSQ9DFp90ggr4kEnQTcroaNd92XJq2QxCk2n/usZ3RDo
    49kUT4hl3Zmb9EGg+nj5dzXxnS2dGO35cPOXYBkHIbNUl0RCHxxAj/2H6cg6ctPOwtKdRl
    q3zhxDjII6Q9BTnORxriFI21mO/5RkKaViXqEcwoy7EbfKou3FXDb0hNJHZ5DGRjo7dwkp
    L3N+ZEiAtyAZfnLtqPLjBSYmqy443G91ZM+pzWleNLwAegbHNQm0HupQ0wi8BENJ+Ds4Hu
    q195JpmMoZrq/Fp7M5pUm56IarvvFM3D3pen4f9l93EaKhf+2+uvI4mkc/vjAfox4L4wmt
    IgQP2pxdRZAdLb38eET+IJHxBXk4A53gOSgpl/6xkDBFg6dC7ZVcET4Upc7Q
X-ME-Proxy: <xmx:Py4datTk5fvdPtriiAgGntoDWcDO0dAyS8KraEOXgBmQWIVlCF7AXg>
    <xmx:Py4davYpN4_1mcmzu2N2cBZ1IF3f-YTNBh5ER-NhKe-6-vbDel36Xg>
    <xmx:Py4daqS03IPjQwIKg4HTAQWqyUqOM9tfjs0n7k_qQA0YwpPc0mCBGQ>
    <xmx:Py4dau9cP_6G4J_r0cHC2JBHp8btdt5GsKIXectS8sTrdXOQVUvm5A>
    <xmx:Py4daiakPHZK3_NnyRae9QARaN-eyU1BrqBVb0MNRuVAD7YyPAxV-tcH>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:16 -0400 (EDT)
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
Subject: [PATCH 04/18] VFS: add vfs_lookup_open()
Date: Mon,  1 Jun 2026 16:37:52 +1000
Message-ID: <20260601070042.249432-5-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-22144-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 2AABD61AB57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

vfs_lookup_open() is a limited version of lookup_open() which is
exported for nfsd to use - to replace dentry_create().

It is limited in that no filename is given (thus no auditing) and no
LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
the open flags.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 54 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 18a43c24d7f1..db3fddbccd21 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4571,6 +4571,60 @@ static struct dentry *lookup_open(const struct path *path, struct file *file,
 	goto out;
 }
 
+/**
+ * vfs_lookup_open - open and possibly create a regular file
+ * @parent: directory to contain file
+ * @last: final component of file name
+ * @open_flag: O_flags
+ * @mode: initial permissions for file
+ *
+ * Open a file after lookup and/or create.  This provides similar
+ * functionality open_last_lookups() for in-kernel users, particularly
+ * nfsd.
+ * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
+ *
+ * Returns: the opened struct file, or an error.
+ */
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode)
+{
+	struct file *file __free(fput) = NULL;
+	unsigned int lookup_flags = LOOKUP_OPEN;
+	struct dentry *dentry;
+	int error = 0;
+
+	error = lookup_noperm_common(last, parent->dentry);
+	if (error)
+		return ERR_PTR(error);
+
+	file = alloc_empty_file(open_flag, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	if (open_flag & O_CREAT) {
+		lookup_flags |= LOOKUP_CREATE;
+		if (open_flag & O_EXCL)
+			lookup_flags |= LOOKUP_EXCL;
+	}
+	dentry = lookup_open(parent, file, last, lookup_flags, NULL,
+			     open_flag, S_IFREG | mode);
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	if (d_really_is_negative(dentry)) {
+		error = -ENOENT;
+	} else if (!(file->f_mode & FMODE_OPENED)) {
+		struct path path = {.mnt = parent->mnt, .dentry = dentry };
+
+		error = vfs_open(&path, file);
+	}
+	dput(dentry);
+
+	if (error)
+		return ERR_PTR(error);
+	return no_free_ptr(file);
+}
+
 static inline bool trailing_slashes(struct nameidata *nd)
 {
 	return (bool)nd->last.name[nd->last.len];
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 2ad6dd9987b9..8c048c97a7f7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -103,6 +103,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode);
+
 /* end_creating - finish action started with start_creating
  * @child: dentry returned by start_creating() or vfs_mkdir()
  *
-- 
2.50.0.107.gf914562f5916.dirty


