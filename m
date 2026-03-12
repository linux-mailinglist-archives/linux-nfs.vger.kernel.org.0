Return-Path: <linux-nfs+bounces-20135-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDqcGU1gs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20135-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:54:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C127C0D7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73225314A2CB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA3311942;
	Fri, 13 Mar 2026 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HmxnQzsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlXvAtNG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB27242D70;
	Fri, 13 Mar 2026 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362853; cv=none; b=u1PzZDm1xsrNA+kEJM8/bzgI+7MvMUbAgDWd0UidQmDXv/RTrxSYeTy3lwfo0O/u49McMEhmvLN7g3ASOk7wYFo/IAbqe3MROGgbvJPeCCuTNFz2SRAxGRnBPU9bi65+Q0SGEJWyyRnXejS9X3r6BcwYor9CKwbDyp2DUUHj38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362853; c=relaxed/simple;
	bh=LjRfbo8WCUGSLHVLwMlqwZIIRrZr5rl1vIhEtLVay24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA70zJORXFzwjF0+Sqi+pwT8dcXor4lp5Sj6VVGAoS/CmKFySci2mh88cctQIog0xaYvN0NE2wtgI3oA4Wwg/A/Bihdq47YXY8mfkt4lGbnYtorirU11tnKuOF79TiKGE9oP6Co5VPO3g3im7tOxJTgqg11v71dWzuu8MTicOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HmxnQzsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlXvAtNG; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 2E9171301B70;
	Thu, 12 Mar 2026 20:47:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362850;
	 x=1773370050; bh=xGOrm2m9mt9eD9zeGh+FgoHjVnxN1Npoe+4KJW4hbgM=; b=
	HmxnQzsEnZP/3l1ULThI1EtrBcCNolH2f3MeN7w4c7RJaHXm+vKCYNwg9f3DJff1
	He4j2oJck+izrAriM0w1WckxI1d50V6JuDB7luBVfoFucpQwFSyRdFlrMACyav88
	z3F62CiYUIe4w38nrZqPSz/x+Uca/8LPpSTqUVrbC2vf+MdaV+bpTyFrg05XUAtB
	B3M7AUCtRd1OANkg0nNQSSStmbmlAdin/TrJ/Y1X0zb8u3+Svl2yvFwiJGX2S+lf
	Yy8oXSi9SqkCgzJiCJL/7BIDxye786uTWcG1xdHO/ONL3+Cme4YJHQkRJmw4TH6e
	0pqhq1WLr0M0qhxdeh3x9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362850; x=1773370050; bh=x
	GOrm2m9mt9eD9zeGh+FgoHjVnxN1Npoe+4KJW4hbgM=; b=OlXvAtNGHI5ULo/6q
	P/Vj6urZdgs1H9LmeFtWV92pQiyGGsFsQLzw2hqtOML7WuKq6gzXZmMNfTa/b4aH
	MvZmVk13SFwaVAzxGcqjAzAFz5AEJjlQaa261ykzd4mSt7ZkX/lX8B/uYUiaeyEP
	z6UO2DmP5pMfz7Jp/O81kXT+Y3S2m7AH0ogPR58xpqGpBpKCeeIdF7cHIPa3hoav
	MXBVERHJZmLvfmcOJ+U4kOuXPqmtq103L804YDCQoS21cXOg8POrnxQA8jH3Ju5z
	g57pDN5L/F62MOFgw62EHoRcXWNPOfLKHcdo0MDyH6W7fyzS1k0rTYgkJiYfEtQa
	1uMfQ==
X-ME-Sender: <xms:oV6zaboT-8MhlvM6Xz475HB1hg9zMLtSOgTqPR4LXlyPmi2A-yYENA>
    <xme:oV6zaZU8txd4XB7OgYvS_4IurhNMF6pE-B7Ip4wQ8Cjia3fu29M4HmhqqryPfwqpY
    awSk1H5tgruQnRHG6Ispz2CDUFNr8kBgkKLrYS3NqFbBukO0g>
X-ME-Received: <xmr:oV6zaTS3IL8EXj6uvTxrGHWZMDecySB0TBa-eiGz9EKMlHJSAGr-lqcwLLZlUbuXn1S6-6sfFom87H5hl0ccaRyrNVjLrabYKBHrPprD68FZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:oV6zacWY73xxMFOQDOXLtIbs5LR2ejohsnXf5jbS1BTrOfSzgG3SXg>
    <xmx:oV6zaQYnGcXiD-IEvcua5KtoNksLYQSzx1iaFo7C64VL8updGP4uCg>
    <xmx:oV6zaS-Jfz98K5xpk5Rrx3AwPZe-wK78qyWo8PeAg-8QdUpaAOJiEA>
    <xmx:oV6zaX776T6u4_e_FxlnZGE2g7fK8_GaMUQScUWS_oHZYqMFyRyrqA>
    <xmx:ol6zaT3J8BxyEi7B82ISNITOYfoZ0-enmJ3d10BRhSoJHvRNpAleM6dD>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:47:16 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 22/53] afs: use d_alloc_nonblock in afs_sillyrename()
Date: Fri, 13 Mar 2026 08:12:09 +1100
Message-ID: <20260312214330.3885211-23-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20135-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]
X-Rspamd-Queue-Id: C75C127C0D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with future
locking changes) use d_alloc_noblock() to find a dentry for an
unused name, and use an open-coded lookup_slow() to see if it is free on
the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir_silly.c | 51 ++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 982bb6ec15f0..699143b21cdd 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -112,7 +112,9 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 		    struct dentry *dentry, struct key *key)
 {
 	static unsigned int sillycounter;
-	struct dentry *sdentry = NULL;
+	struct dentry *sdentry = NULL, *old;
+	struct inode *dir = dentry->d_parent->d_inode;
+	struct qstr qsilly;
 	unsigned char silly[16];
 	int ret = -EBUSY;
 
@@ -122,23 +124,38 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
 		return -EBUSY;
 
-	sdentry = NULL;
-	do {
-		dput(sdentry);
-		sillycounter++;
-
-		/* Create a silly name.  Note that the ".__afs" prefix is
-		 * understood by the salvager and must not be changed.
-		 */
-		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
-		sdentry = lookup_noperm(&QSTR(silly), dentry->d_parent);
+newname:
+	sillycounter++;
 
-		/* N.B. Better to return EBUSY here ... it could be dangerous
-		 * to delete the file while it's in use.
-		 */
-		if (IS_ERR(sdentry))
-			goto out;
-	} while (!d_is_negative(sdentry));
+	/* Create a silly name.  Note that the ".__afs" prefix is
+	 * understood by the salvager and must not be changed.
+	 */
+	scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
+	qsilly = QSTR(silly);
+	sdentry = try_lookup_noperm(&qsilly, dentry->d_parent);
+	if (!sdentry)
+		sdentry = d_alloc_noblock(dentry->d_parent, &qsilly);
+	if (sdentry == ERR_PTR(-EWOULDBLOCK))
+		/* try another name */
+		goto newname;
+	/* N.B. Better to return EBUSY here ... it could be dangerous
+	 * to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
+	if (d_is_positive(sdentry)) {
+		dput(sdentry);
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
 
 	ihold(&vnode->netfs.inode);
 
-- 
2.50.0.107.gf914562f5916.dirty


