Return-Path: <linux-nfs+bounces-20124-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM8zLKpes2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20124-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:47:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF027BDC4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34812303A5C2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0993090F5;
	Fri, 13 Mar 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HtGyc6qG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGZE7jMy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1C2D061D;
	Fri, 13 Mar 2026 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362664; cv=none; b=IVuVL5Wd6oJGXS98ZBuivtKeSPhb412/xY9vLOyfb37fqzhN8IcJ4170z3SKZNJcgova3CxVr4UxQNO/TUIEOqewdUw7GMtWSx1+vNV2B9bc9o8em3xiLEtPAKa86YrA+2mm0yqINgcawSOB6kxF1eXpcO2OICT8Ql5579uQAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362664; c=relaxed/simple;
	bh=9GrYZJTr1huYHX1gLb2iNf9op2Xtbz6nw85bt8JodAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWNNJmixYIijBQyxJ8ylORcCMW2eR/XbWkEPpItLiP+pU0xRg4n9qk0SIAxFEGdM5HswAw9LECouejOxYqYzBTg8eTqVgOIjrSeTrsOSzUc+X/MrLsNEAzcLp8mGJdMzujecaFXfcZBpnpjYdF27E58+B/Oefs0j5qLzUmc1iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HtGyc6qG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGZE7jMy; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 1C1651301B36;
	Thu, 12 Mar 2026 20:44:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 20:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362660;
	 x=1773369860; bh=EchxTXDSTALGT/SYRwTZVf/wCe3kGgvEe9z67tw1N/I=; b=
	HtGyc6qG86oz5kPvVFKloxRAiiPrdOpKU8L6wLUUYdjZZtzmK8nkkRoRc4Ob/zDE
	ygWeDDQ7jByf/H36cgdfqD2YT8xrlT5AnRfqLG6YYDduADlVEQcPZKFCOFEq7efp
	W0PV4tzGLYO7R7+Bi8QoTHgftdcdAbG2cmbRdSq7IiPJrej/xGh8Sis7vcSb5NUp
	8p9RKdBEfwd8U9POVkTHLrI8JD7f/jqhMlJETvpWzrtU+xKrqH6+DdkWl9BZAf3N
	0STPIxH4lQraZKks4fXTtb9nzvy+JFzG89W3Fsfemen70/tWjCFitTexXEMl+aF6
	MdwcnBbmpBgBWkwcmrlWrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362660; x=1773369860; bh=E
	chxTXDSTALGT/SYRwTZVf/wCe3kGgvEe9z67tw1N/I=; b=cGZE7jMy2SV9uoVbT
	q+IZzNuzXM+hYp7X/7RyEelmnM4UrPJGwKgU90XEnptRogSnhLgrodnjWWKRdW6V
	AQ2OpzAPnuid/OLVu+UcDPlHx8xARolg4F09VwR1VkrdXcXUZU3U5Q/ecPnnrOZf
	SYXSxRBpzCG7sc8smUlxY8lKJ6slf1JpRJFSI4EJH5Sn6FJIQ9W0S72D+0grR2eW
	eRAGsh4DDkSU9EgUFpYcUsAr3jEhGPLkD/lIXTiZxQR15ET1AfwNhG2Uyk8kFZEA
	eJf1QWHbL/Mhmx2NzRvIensmEAwQ5KJ9/ygKBb3mV2toMoGumq2oOmUfpqyuBCg1
	QIv+A==
X-ME-Sender: <xms:5F2zaVHI984ELvb6xSRaFU9eCeKsAQjeZVnzdbb6spa-5onhWibOxw>
    <xme:5F2zaUAed5wK-zCYjIohFxTpHOZodN1QK5v6gSu9aBbq6YkW49INvwK2H8WSlxuUj
    0AINAGwpWxmYYyrWgs6QEljfIuLf1lidnihAI7NxZBlett3>
X-ME-Received: <xmr:5F2zaeFAXsLgutzseRttIHJSIZrQBg4HQsn-pgvOFbN2jRZuZJQaVAifygamFXGvvWGzpvACE4zAmDQPT3U028PwiKjFjFm6UlAj5yjyJwko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:5F2zafLiDwJI8AsohNmCqUWhx66u5JznxXNAP9db1X9x-LHxraRvUQ>
    <xmx:5F2zaauU88YwyeOeYB86_WfHys66FW-d63rSeocswtoECd66SdtGHA>
    <xmx:5F2zaUpH9EvuwjTwbaCT-kN4TE4nurgxpwZqmfL5VKPrPKKsZvNp0w>
    <xmx:5F2zaWWtk05otDk_d1bqcAfIJnfbAsyYAIR11Xd5Jqwl9RmTh_ZPSw>
    <xmx:5F2zaZWxNVGF8w3Grc8V634dTGW1lFtEASW9xYbi3dSM4mcL6-JNsBIK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:07 -0400 (EDT)
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
Subject: [PATCH 33/53] ext4: use on-stack dentries in ext4_fc_replay_link_internal()
Date: Fri, 13 Mar 2026 08:12:20 +1100
Message-ID: <20260312214330.3885211-34-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20124-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 5AEF027BDC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

ext4_fc_replay_link_internal() uses two dentries to simply code-reuse
when replaying a "link" operation.  It does not need to interact with
the dcache and removes the dentries shortly after adding them.

They are passed to __ext4_link() which only performs read accesses on
these dentries and only uses the name and parent of dentry_inode (plus
checking a flag is unset) and only uses the inode of the parent.

So instead of allocating dentries and adding them to the dcache, allocat
two dentries on the stack, set up the required fields, and pass these to
__ext4_link().

This substantially simplifies the code and removes on of the few uses of
d_alloc() - preparing for its removal.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ext4/fast_commit.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2a5daf1d9667..e3593bb90a62 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1446,8 +1446,6 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 				struct inode *inode)
 {
 	struct inode *dir = NULL;
-	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
-	struct qstr qstr_dname = QSTR_INIT(darg->dname, darg->dname_len);
 	int ret = 0;
 
 	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
@@ -1457,28 +1455,14 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 		goto out;
 	}
 
-	dentry_dir = d_obtain_alias(dir);
-	if (IS_ERR(dentry_dir)) {
-		ext4_debug("Failed to obtain dentry");
-		dentry_dir = NULL;
-		goto out;
-	}
+	{
+		struct dentry dentry_dir = { .d_inode = dir };
+		const struct dentry dentry_inode = {
+			.d_parent = &dentry_dir,
+			.d_name = QSTR_LEN(darg->dname, darg->dname_len),
+		};
 
-	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
-	if (!dentry_inode) {
-		ext4_debug("Inode dentry not created.");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ihold(inode);
-	inc_nlink(inode);
-	ret = __ext4_link(dir, inode, dentry_inode);
-	if (ret) {
-		drop_nlink(inode);
-		iput(inode);
-	} else {
-		d_instantiate(dentry_inode, inode);
+		ret = __ext4_link(dir, inode, &dentry_inode);
 	}
 	/*
 	 * It's possible that link already existed since data blocks
@@ -1493,16 +1477,8 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 
 	ret = 0;
 out:
-	if (dentry_dir) {
-		d_drop(dentry_dir);
-		dput(dentry_dir);
-	} else if (dir) {
+	if (dir)
 		iput(dir);
-	}
-	if (dentry_inode) {
-		d_drop(dentry_inode);
-		dput(dentry_inode);
-	}
 
 	return ret;
 }
-- 
2.50.0.107.gf914562f5916.dirty


