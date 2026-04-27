Return-Path: <linux-nfs+bounces-21132-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC4AEzfa7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21132-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73546C742
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EE383002F72
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAB36074F;
	Mon, 27 Apr 2026 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="r6/kzYCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ngs6EhWZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA35E92B;
	Mon, 27 Apr 2026 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261103; cv=none; b=Wd5WyW6WfXcVY7MBk9vZN8Mf3hjEwqB56/yFgMJdNEbDU7qPq10rs2BfW6NPF2BbBFoJisvOuyQgf5V1FbkIB6O3xLPm1Sz9TWhlMhHTyAxUj0z7MCQteNJRmPrgHDviJakvpBHbsi28ThhSNiL6trGhn/0Fdp6NTF0sKzn/ZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261103; c=relaxed/simple;
	bh=WZ7UveSYOpovothb9tiW51mp2dtPIr+PjSBgGKNYxBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfelDsM/xlqvUAn+aEJ3SdkF4ZzNPnlVsOgd8gsL8/CJNvsjoWv4TM2RcM9NHAZqvzZ6E03iELPcMMEVI98uZekK5SQ+oRlIjnFc7SoWjB+yx9Yug2G3Wr4uIX8BprIg6T2xCvpu14r/c+sxm3o/WFXBWdA2KGGJg2SszaZu180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=r6/kzYCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ngs6EhWZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BFA70EC033E;
	Sun, 26 Apr 2026 23:38:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 26 Apr 2026 23:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261101;
	 x=1777347501; bh=qNsDUPxIIaAA/63Z6to/nWQPQowfPrhVEFZuvx5A43o=; b=
	r6/kzYCFAquTeO1wlwvjKxCsUOW7TMSQNtGPG6AKh+5TIpty1dMOfRoHnPowMVBY
	6LAJ4LRW5MJ1493OfTwiRePIZtXCe+4ozcHOecAA3SIKwkeVLSHMotLxccE55y8C
	QlDES/TEsl3lT1DhRBAHEEQv63ehnD0wYi3lE5nWCwr9Nt+qBhq4cX8VpGrei2LK
	GEM/Ee/3szdPdqRpJAQ3foU63YchCNm2YDdA6METDQ61tG+4/C9HGuiUsSoir9mH
	aAvlD30rL0vXFetx6uaGWsydkRtLKCfKOs24HjwaZa06teNd1CHMi93ZpjnNVJvW
	qeu1GUOXC64DdKyj56AA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261101; x=1777347501; bh=q
	NsDUPxIIaAA/63Z6to/nWQPQowfPrhVEFZuvx5A43o=; b=ngs6EhWZRkMODM3Mn
	13raWoG8isivHcdEpXwKHK0vh223CHClFEwU3f/H85d/o84sT8v2/5UdbrI6HYW8
	y4vTyjut55NSo+JNFUSspcNSpUf5dM+hZezAIezhxCLJAJVxa2J917R4CjfM5lPD
	ct2jG8UoN5ELrk5jwNpS/UHMfSmwB5eXJ2Yg6UPVNlWMjDdsGHxMVSS3wuVw7bZp
	V+icccTGFs3WzMNjcYmfa1MKr87cauI2Jkl6TizcXjigBU7qSq8MDGUyyiCGMG2n
	rES4ZDapwky7qXfPbuC9Zwn6brsk0hkKZtFs4KYbtYSdKNzq1PDpxDpuM3iwXz+z
	wLvaQ==
X-ME-Sender: <xms:LdruaRGyBlO9sh2EVucfNPAH26-7mqppOHTIoKt7aCswyEW1542GGg>
    <xme:LdruaRDwJmarrBUjnjEq0fcsyRro9S_NSA-zqEk58T4s1iZxIcwp5NqNpVJKZrGhf
    eSTRf3gk4_YNR12BCVQhoB-JECIqp3ktOiTQgC4hVxUePY-UXM>
X-ME-Received: <xmr:LdruaZxJwrWAKvGXTTE191ubFQFMvqRhvREsaTA6BDKZ5z0ySZg73Lo9wegIs9Z3wKDUl9RC9iOGeUdcNroHNUHfugxiwmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:LdruaSAb1LI-u2OQmK3Mll_nHTso5KzYNwYHqsWLz3crzu_-QA1Olw>
    <xmx:LdruaSBszcCNezjAQUMkdCHn9RN0DDrh_cXxm0YZY5lM8LbL_4_3QA>
    <xmx:Ldruad5gNnZJY-SXv_HpZowQHRpJmMzimuAWm3gvpk2oBttBF_Nzvg>
    <xmx:Ldruae1xjZxOvK-ZVWFy4pGXwH4QK2sw2F2tB_CjXCMr2uB28hX5gQ>
    <xmx:LdruaclT4d_9hqfPPOC3KFrN5wz3RHbR3vNG0gKFDoawvVnM_w_HZwvy>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:38:17 -0400 (EDT)
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
Subject: [PATCH v2 18/19] nfs: use d_alloc_noblock() in silly-rename
Date: Mon, 27 Apr 2026 13:29:51 +1000
Message-ID: <20260427033527.773006-19-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 4C73546C742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21132-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with
future locking changes) use d_alloc_noblock() to find a dentry for an
unused name, and then open-code the rest of lookup_slow() to see if it
is free on the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/unlink.c | 51 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 43ea897943c0..1ac9bd2a63b2 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -445,7 +445,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	static unsigned int sillycounter;
 	unsigned char silly[SILLYNAME_LEN + 1];
 	unsigned long long fileid;
-	struct dentry *sdentry;
+	struct dentry *sdentry, *old;
 	struct inode *inode = d_inode(dentry);
 	struct rpc_task *task;
 	int            error = -EBUSY;
@@ -462,26 +462,37 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
 	fileid = NFS_FILEID(d_inode(dentry));
 
-	sdentry = NULL;
-	do {
+newname:
+	sillycounter++;
+	scnprintf(silly, sizeof(silly),
+		  SILLYNAME_PREFIX "%0*llx%0*x",
+		  SILLYNAME_FILEID_LEN, fileid,
+		  SILLYNAME_COUNTER_LEN, sillycounter);
+
+	dfprintk(VFS, "NFS: trying to rename %pd to %s\n", dentry, silly);
+	sdentry = d_alloc_noblock(dentry->d_parent, &QSTR(silly));
+	if (sdentry == ERR_PTR(-EWOULDBLOCK))
+		/* Name currently being looked up */
+		goto newname;
+	/*
+	 * N.B. Better to return EBUSY here ... it could be
+	 * dangerous to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
+	if (d_is_positive(sdentry)) {
 		dput(sdentry);
-		sillycounter++;
-		scnprintf(silly, sizeof(silly),
-			  SILLYNAME_PREFIX "%0*llx%0*x",
-			  SILLYNAME_FILEID_LEN, fileid,
-			  SILLYNAME_COUNTER_LEN, sillycounter);
-
-		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
-				dentry, silly);
-
-		sdentry = lookup_noperm(&QSTR(silly), dentry->d_parent);
-		/*
-		 * N.B. Better to return EBUSY here ... it could be
-		 * dangerous to delete the file while it's in use.
-		 */
-		if (IS_ERR(sdentry))
-			goto out;
-	} while (d_inode(sdentry) != NULL); /* need negative lookup */
+		goto newname;
+	}
+	/* This name isn't known locally - check on server */
+	old = dir->i_op->lookup(dir, sdentry, 0);
+	d_lookup_done(sdentry);
+	if (old || d_is_positive(sdentry)) {
+		if (!IS_ERR(old))
+			dput(old);
+		dput(sdentry);
+		goto newname;
+	}
 
 	ihold(inode);
 
-- 
2.50.0.107.gf914562f5916.dirty


