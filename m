Return-Path: <linux-nfs+bounces-20105-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOJ7HOI4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20105-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:06:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074027AC43
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192823206997
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70043AD516;
	Thu, 12 Mar 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="We4QHEc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJKk8gs7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412F317142;
	Thu, 12 Mar 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352610; cv=none; b=IOW8MaDXJhNTCwtsMpSK9RKDR8LzLp+z17tSoNVTNjanjxdKjxVFKQVJRUZ4WYRXnGmC3zbLwkct8Qu+M7h+Fa1BqRS5GtrP5GcTS48s0XeL8IIje0OT/xBbPkU7zRDuCDQRMbnUdLzMUwTaY5ZHsd/Lj/HKpoPVUUEjrOE09zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352610; c=relaxed/simple;
	bh=qepEFLlJxKxGECKoKiRMdWLTH8oH6zcVxSk9a5QLego=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS1tOE3ovHZXKv5rUL//k6YlMqkarbRu/nB8dlePF/KWZeO8i2sdHpS6Qio4SQUWfqkHJ2TWPG0bW4M8GzeK5MGtcdpW+Nit/xSdrVC7zvBdmPCjTG48pfwJIQsht8qOb8y/C9MwqpI7mmC1Gn0FAHO8pzw35eXboNc+TVoqZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=We4QHEc5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJKk8gs7; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6A68B1301B63;
	Thu, 12 Mar 2026 17:56:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352607;
	 x=1773359807; bh=Gqr5GRMgf06YnKH/0CimKgertEevcw92OqmrRngbywk=; b=
	We4QHEc5TNY1r6emZ7SsqEkPBAFl7fjcHi6srpfWQ1jfp9RJyRfEF8fnUh1L1DCn
	NUV0TnodOWGmPyjahfVZyst7SyBFImTOBbu5reeCNuxZa9HRPVB4nYbPa9eKOqKj
	CPhvVoePIv8KrFKC9jWx48sJ90oGywC9Kg3zkO5a5jeQQfPK+hJjBscSS6duK7Cb
	4Pu+8L4kIn61BbJxZZaydewbyuURl9IDnc5JFrYPrp1xqGiRHGGd6dO+zw/46d9v
	FWLsgwMkK6Rw70z4NcymA80fUToAHDfDhkXCxQcBYAwiDj6lNIFttjsKy3vYkGwg
	nbi7TF6fILEzY76fZqID3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352607; x=1773359807; bh=G
	qr5GRMgf06YnKH/0CimKgertEevcw92OqmrRngbywk=; b=dJKk8gs7CF4KRCcfh
	89WVjnhITgi2+635oEUJk+087w20YQpJyBQQRSv6sMvRFBFpbSYz45v1LYD7YSEF
	k5RjCZgWsz/jDYeuZ1/RmyGF7eTyz8EUQ+zX4XOys/kG00CKqN3XP/Hhwoh55q5p
	PBoqLjFiU/UtroUW0Z+Eqx5GO4FSz7jp/i1vGOgYuK+F9VG42MXubrcWhALXIcE/
	03DnMHBjvq88RBcy+yoHWGYj8PbashFFwXz6e3vWCTpBOCgBfX3IhkxEH5nO4Y9U
	amCTP9WGxg1h6I4qU4J31S/WBH+GxRhVgrevtJSzFc1T2ODHmcXC3fIdvp2qeyWc
	4WATg==
X-ME-Sender: <xms:njazaWHTeLwg8HFl0eA-5175x08ulAqe44OEWYVyZBi0tuviIsckbg>
    <xme:njazaRA0Gb8bLbbZ9PJYj159RKvRaGZ4v-UGOqWLi4qeNBwgib7eptgGNmDT5JQbh
    j4bUDfd43Lze2YmvWr37Ap-O2blTssUYeE45z-APsjUOf_NYg>
X-ME-Received: <xmr:njazaXFqupynSv3iJKROA_1PIcuCNVCJR58MarljHJa-n4AFWIy4hpgslbt0aUpA9O88AXCbtynh63xcfrCrff1QWeCn3AVMkLl-cXqG_bPh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:njazaUL1ZPkYP9m1Bss-8Z85nXjbKoxnUD45JY7Ncb6h-0YY5_dprw>
    <xmx:njazabtAYMZYIiUJrxC0Gq4Kdum3PlXDqo6uWSqH4VuY2ZK1iX5qaQ>
    <xmx:njazaRrqjy7qTKaR0gG5Bwk8ilP-5nJFlXzEsHNcBJwz-m13ycXebA>
    <xmx:njazafXf3hYs30lOiL2kY4FsGcyxLQU9S38eTyi4B5Yclzc2og7KCQ>
    <xmx:nzazaRcM0XCwpxCRO4D6QGB9oMdD2WOwOSwdrSIdgmftsWaYF_OtH-uO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:56:33 -0400 (EDT)
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
Subject: [PATCH 46/53] Remove references to d_add() in documentation and comments.
Date: Fri, 13 Mar 2026 08:12:33 +1100
Message-ID: <20260312214330.3885211-47-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20105-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,brown.name:email,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0074027AC43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

It is planned to remove d_add(), so remove all references in
documentation and comments.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/nfs/exporting.rst | 10 ++--------
 Documentation/filesystems/vfs.rst           |  4 ++--
 fs/afs/dir.c                                |  5 +++--
 fs/dcache.c                                 |  2 +-
 fs/ocfs2/namei.c                            |  2 +-
 fs/xfs/xfs_iops.c                           |  6 +++---
 6 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index a01d9b9b5bc3..ccaacdc72576 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -101,14 +101,8 @@ Filesystem Issues
 For a filesystem to be exportable it must:
 
    1. provide the filehandle fragment routines described below.
-   2. make sure that d_splice_alias is used rather than d_add
-      when ->lookup finds an inode for a given parent and name.
-
-      If inode is NULL, d_splice_alias(inode, dentry) is equivalent to::
-
-		d_add(dentry, inode), NULL
-
-      Similarly, d_splice_alias(ERR_PTR(err), dentry) = ERR_PTR(err)
+   2. Use d_splice_alias() when ->lookup finds an inode for a given 
+      parent and name.
 
       Typically the ->lookup routine will simply end with a::
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index d8df0a84cdba..26dec777ca5c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -460,7 +460,7 @@ otherwise noted.
 ``lookup``
 	called when the VFS needs to look up an inode in a parent
 	directory.  The name to look for is found in the dentry.  This
-	method must call d_add() to insert the found inode into the
+	method must call d_splice_alias() to insert the found inode into the
 	dentry.  The "i_count" field in the inode structure should be
 	incremented.  If the named inode does not exist a NULL inode
 	should be inserted into the dentry (this is called a negative
@@ -1433,7 +1433,7 @@ manipulate dentries:
 	d_iput() method is called).  If there are other references, then
 	d_drop() is called instead
 
-``d_add``
+``d_splice_alias``
 	add a dentry to its parents hash list and then calls
 	d_instantiate()
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b5c593f50079..f259ca2da383 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -960,8 +960,9 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 		dput(ret);
 	}
 
-	/* We don't want to d_add() the @sys dentry here as we don't want to
-	 * the cached dentry to hide changes to the sysnames list.
+	/* We don't want to d_splice_alias() the @sys dentry here as we
+	 * don't want to the cached dentry to hide changes to the
+	 * sysnames list.
 	 */
 	ret = NULL;
 out_s:
diff --git a/fs/dcache.c b/fs/dcache.c
index c48337d95f9a..9a6139013367 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3323,7 +3323,7 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @dentry must be negative and may be in-lookup or unhashed or hashed.
  *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
- * place of the given dentry and return it, else simply d_add the inode
+ * place of the given dentry and return it, else simply __d_add the inode
  * to the dentry and return NULL.
  *
  * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 268b79339a51..0d3116142bd7 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -172,7 +172,7 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
 		ocfs2_dentry_attach_gen(dentry);
 
 bail_unlock:
-	/* Don't drop the cluster lock until *after* the d_add --
+	/* Don't drop the cluster lock until *after* the d_splice_alias --
 	 * unlink on another node will message us to remove that
 	 * dentry under this lock so otherwise we can race this with
 	 * the downconvert thread and have a stale dentry. */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ec19d3ec7cf0..2641061ba1db 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -356,9 +356,9 @@ xfs_vn_ci_lookup(
 		if (unlikely(error != -ENOENT))
 			return ERR_PTR(error);
 		/*
-		 * call d_add(dentry, NULL) here when d_drop_negative_children
-		 * is called in xfs_vn_mknod (ie. allow negative dentries
-		 * with CI filesystems).
+		 * call d_splice_alias(NULL, dentry) here when
+		 * d_drop_negative_children is called in xfs_vn_mknod
+		 * (ie.  allow negative dentries with CI filesystems).
 		 */
 		return NULL;
 	}
-- 
2.50.0.107.gf914562f5916.dirty


