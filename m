Return-Path: <linux-nfs+bounces-20092-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7MCA83s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20092-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:58:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4B27A8C8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A45432C0D31
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5538B7DA;
	Thu, 12 Mar 2026 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ulio8jdR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1ILUza9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4730EF6C;
	Thu, 12 Mar 2026 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352110; cv=none; b=ONlEJ+wLTMXQlxwLaNrFundbbgx4gyUTIteK8im7wGdB9hXeCZYxjyKHvRKp0hnoAM8wqEbhP2Btm91TDCS2ZliGHamAGdjjK1eK3fBIcp8tJpq/Hr/hSQiyFNBlaV39h406ZmClJF3JxVUUs9BuZ/i09gzExWRR8Qq+aFDOUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352110; c=relaxed/simple;
	bh=G5V5crDVyLe8/maI9lfcZXKb10I7/mjupt819D+stws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td69b2YNfxvJBipUpN71vWj5ngfW1ucdhSd64Y2FICYMM3ZqNBBGRfw9ZmUaoeiOlVD7QPyqf/t3/M888I7QQ88gaSuR8beS0WkR68z04iRh8ZmVf50DnmyGabf1QWPKxkGdtm1fdPqkOKC4196Cle6RqhFUQCtEQX40PWw71zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ulio8jdR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1ILUza9; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id E04541301B7D;
	Thu, 12 Mar 2026 17:48:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352107;
	 x=1773359307; bh=KmjblPgjMtNsKFHT5qnV9lxupCTmEj8C0v6XyHf7K7k=; b=
	Ulio8jdRV17YOr50t+t7boNaHOeF2wTQGOHtn+dNIoN5vKNfDyK0CD44CgXabKUK
	TV6nXN2knVpB++dAh4V5AAO9193CaTSvg7SQYb2sKyBBRHlJR2LidDplCTZEANqT
	vmfQ21wRbawPzNwJbwUvM+LB20U4hwnVaghMWWb2/YIpQqO+6cYfq3X0KzeCr1oi
	FJSDAmeGC9yvUXg0iUtYAJxZee59kb6/VwJuNxNGDE8ysKU1uxaXQjerR3m/1UF6
	69fvZaLM9UVgD6sUjJm72z0yVSaXyyECAxCx2ODjn5Z8fqrU1RbyBsGwdzuxZIna
	WS+V65cIpf2Vv5kJeBkFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352107; x=1773359307; bh=K
	mjblPgjMtNsKFHT5qnV9lxupCTmEj8C0v6XyHf7K7k=; b=V1ILUza9NLQSxawiL
	eF0WlKAetuUAGiKullHxP7XEcjOGX0pSDLHT+d3ZxLUsukHA9enGP//FKvRTQqU/
	IQAZbK9m1MrlRmvhragai8VPzskTiPUPw5NyPV93/lE9PPi0U7yTePGgPZuNDe8E
	2KtvNIzplE7kIb4ZMNiFpnwQr67l2ZluVdaeE0+q7D672SbupcGOiQ4VPzXZuHU1
	39+IR54k8h/yleEScI5O9sAqsimUETjsmYBMojccLsdfnvm6TOqgD0tMeq8OULl7
	WdGrqgiD5VcVeh2H65t+c0B7nLPTaIdBrH6JiUsORtvwHWzELLSJEDuM/Y+JdCLT
	Rq27g==
X-ME-Sender: <xms:qzSzaWje6cDYVZTL6oRga944PHze4WztxNBkg-UWzbipV-sJXmrErw>
    <xme:qzSzaavc4w9W9aG6YIyVleJhpfHtCfo2YaBfvj31McqpbgK24kIWlsdRER60iBLDT
    WDFgT3pNbtScSHtleoPoy3PM7RzP0I_ombeH2mkYew7rWln>
X-ME-Received: <xmr:qzSzaZKkPCr5kGbM69aIAfYhsnh2jweVgWwOC-VwnzZ8IDsS7pApMX3BhrbhSlbECWFcszM3_um6AAvnkECHXQOg7rRHFCn97G-ztlgW88Lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:qzSzacsdvoW2RMAUGHvilYc3L1sBOgLXw_1Y-TSRnvvTYhGpZ3n9ug>
    <xmx:qzSzaZQuE-abwLWUtQGwg-Qi3bAAab2Sek4mKMqqlZKVZAqQSCH2kA>
    <xmx:qzSzaaVUpgfhBKqEz-fvy3vGigsuIsmeH9eHDIyvlkt1FwYUswK3Lw>
    <xmx:qzSzabygAjfC1YXbKloop-JFYJQjQzYu2bcVRaIZmFPzF_lLy_bAOw>
    <xmx:qzSzaY83DT5TSxCCpVbf_7WrM7PG0uoHAsKdRRw9tEKJa_AkpPR85Sf0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:48:14 -0400 (EDT)
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
Subject: [PATCH 14/53] nfs: use d_alloc_noblock() in silly-rename
Date: Fri, 13 Mar 2026 08:12:01 +1100
Message-ID: <20260312214330.3885211-15-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20092-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 8DA4B27A8C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with
future locking changes) use d_alloc_noblock() to find a dentry for an
unused name, and then open-code the rest of lookup_slow() to see if it
is free on the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/unlink.c | 56 +++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 43ea897943c0..f112c13d97a1 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -445,7 +445,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	static unsigned int sillycounter;
 	unsigned char silly[SILLYNAME_LEN + 1];
 	unsigned long long fileid;
-	struct dentry *sdentry;
+	struct dentry *sdentry, *old;
+	struct qstr qsilly;
 	struct inode *inode = d_inode(dentry);
 	struct rpc_task *task;
 	int            error = -EBUSY;
@@ -462,26 +463,41 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
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
+	dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
+		 dentry, silly);
+	qsilly = QSTR(silly);
+	sdentry = try_lookup_noperm(&qsilly, dentry->d_parent);
+	if (!sdentry)
+		sdentry = d_alloc_noblock(dentry->d_parent, &qsilly);
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


