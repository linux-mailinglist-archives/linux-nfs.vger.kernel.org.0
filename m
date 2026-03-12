Return-Path: <linux-nfs+bounces-20109-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DetCaM4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20109-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:05:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0627ABB8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8D732BC55E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABC38B135;
	Thu, 12 Mar 2026 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OmN1n9vT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUkArunM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B042BCF5D;
	Thu, 12 Mar 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352678; cv=none; b=qBIltq5UX5vO9nZOn2gmYzGn/ReD2cgw59u4Vw4fHcA8+hZay8I4EYmlokrZ/2mLspp+/h7Ykkz34K1j+Y3HXMAlPu7uUg7adk2iVtwBaGZMpCqYscjIP8YBZwNmobTjHFPIaKG13Snn4JUKdY73PqK+fm6uN7k+0rv7UhKo/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352678; c=relaxed/simple;
	bh=zhOU+CUP9BDiz+mBL+6rvvcpWUBlfL5f4sGMgdReybg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0kjDlRtdbszzPn1/xSM1cebsxNm22qesVOsVqmakIKi2BnyPXHDAeCbgWdUGsbLz42tcMiMirfv8pPb0H+kacIGCGH7Pi8rTmcd+zhILhBTbsmryMG42kkCHMY/W1x0zTuQfkQROsSafkgDPHFmvBQqPGcmDlqG2KL0qEXIXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OmN1n9vT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUkArunM; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 9E9601300F6C;
	Thu, 12 Mar 2026 17:57:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 17:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352675;
	 x=1773359875; bh=tG1sAZ33EfRbToxRaM5utlCqwlH2sGHBZL6Q+fSZ/kg=; b=
	OmN1n9vTcFKpHoHUGImFy0CQZvz9KEtReJX8p0OX7kUzjl9V1nlaH0yIJxxNJ5o5
	oET4VMjoMdSHj7IP5T4w/Rg6YRHXE0F+yv/zv6JIVNaEu04OcGt8i2Z31ixKUARE
	DgWSGk08+PgsvbboVZfumYegJ49ceyganU4rmEo80NNQt8dBC4CP9Wg3fGyUFm/H
	JqPNMalfP80ve+bbpg9QT7R10mOUfPal3L+Ic8nXjpuv3ShR8ZVXFaW54uMweLe0
	Uq9Qii9ZXDmV3HkZ8LfHyMvZo42uRI7668NHYPRCfw63wFbH2Rx07hB+CGfTU/+0
	5h1RkHy0wyR2U7RjIeMU+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352675; x=1773359875; bh=t
	G1sAZ33EfRbToxRaM5utlCqwlH2sGHBZL6Q+fSZ/kg=; b=DUkArunM0luViPOSC
	jYYHJCnZBtZFu1yArXIwY0hvu6BErdZBDdHUc16HB0A4qYJKkcPzwpLxrDs9bVos
	bzYgAA+8UttTRhFKZ0bpoi8CaHHQoxiV1ip3XmTGLLS3OhflYcg/lSPRa3aw9Esw
	9Dby830jyY6S1LECOhApUa2X7BsIoOuRyilaw6sD+gyYb3+jHWgRcHxC9iAw/Z2u
	IRdPeUpUN5OYAHfWgBBL/r028pjWmk4Ha2AjbAGHczLxiNwGIUOrONuduvNIGDUf
	DAhRMe7hKq4+w9i2cCgr2MKWCq0AYV+anj+y7k2zwww+ByYy121ZFJq9XFjo8x6e
	Ofj3w==
X-ME-Sender: <xms:4jazaeFn5-5ZjBYkhGw6hC20rPqHC-eoU5MGnd0AAZ-I6bLvJ9ELCg>
    <xme:4jazaTAb5hcSgkknkeWENiMzD0gJfSYjyQXXByW8kZl3-XtihuGn7S-WhHyf9t_DZ
    W5RFB22BmI8VxOSTUeMxFjSuzsbFQ0lX7QdTDENtegi8SjeDQ>
X-ME-Received: <xmr:4jazaTPB-I988aMIRhAYzbmhIdiFT34StuynorRC9fmZ45TsXPyLi-7rrLHrfLGp3j1X2aItdBJIN23x4LtanxXAQN3pBDJgtRAcTrG66GIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4zazaVj0-tqVWhDOqcWRHbmE5sTiu5G-_3jkKNnvE-EBbnuhNpaNxg>
    <xmx:4zazaZ02uemv5SlntkWgkuepkyXHF8GDbc1lqqSCc-aqTpQp9BetEg>
    <xmx:4zazaXrW2_YS0Q0DIZy_BeDgcsnjcbvGRVUzdNgVYU-TpIFIV4rvkQ>
    <xmx:4zazaW1GzIlqYt011d9e3OM1PzStUWJLIQpdtToNWeDDvTiQufyyBQ>
    <xmx:4zazadRhJAD24D_AyMwEqRBB2ZN0piXoDW7SGjuVeK14jeJI3r62dA4J>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:42 -0400 (EDT)
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
Subject: [PATCH 50/53] VFS: remove lookup_one() and lookup_noperm()
Date: Fri, 13 Mar 2026 08:12:37 +1100
Message-ID: <20260312214330.3885211-51-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20109-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,qname.name:url]
X-Rspamd-Queue-Id: 9AC0627ABB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

These are no longer used, so remove them.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++
 fs/ecryptfs/inode.c                   |  2 +-
 fs/namei.c                            | 61 ++-------------------------
 include/linux/namei.h                 |  2 -
 4 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 154a38cd7801..7e83bd3c5a12 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1396,3 +1396,10 @@ and d_alloc_parallel() or d_alloc_noblock() when standard interfaces can be used
 d_rehash() is gone. It should never be needed.  Only unhash a dentry if
 you really don't want it.
 
+---
+
+** mandatory**
+
+lookup_one() and lookup_noperm() are no longer available.  Use
+start_creating() or similar instead.
+
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index beb9e2c8b8b3..a7a596d51d67 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -414,7 +414,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 
 	lower_dentry = lookup_noperm_unlocked(&qname, lower_dir_dentry);
 	if (IS_ERR(lower_dentry)) {
-		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm() returned "
+		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm_unlocked() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
 				PTR_ERR(lower_dentry),
 				qname.name);
diff --git a/fs/namei.c b/fs/namei.c
index eed388ee8a30..cb80490a869f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3148,59 +3148,6 @@ struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 }
 EXPORT_SYMBOL(try_lookup_noperm);
 
-/**
- * lookup_noperm - filesystem helper to lookup single pathname component
- * @name:	qstr storing pathname component to lookup
- * @base:	base directory to lookup from
- *
- * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.  It does no permission checking.
- *
- * The caller must hold base->i_rwsem.
- */
-struct dentry *lookup_noperm(struct qstr *name, struct dentry *base)
-{
-	struct dentry *dentry;
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
-
-	err = lookup_noperm_common(name, base);
-	if (err)
-		return ERR_PTR(err);
-
-	dentry = lookup_dcache(name, base, 0);
-	return dentry ? dentry : __lookup_slow(name, base, 0);
-}
-EXPORT_SYMBOL(lookup_noperm);
-
-/**
- * lookup_one - lookup single pathname component
- * @idmap:	idmap of the mount the lookup is performed from
- * @name:	qstr holding pathname component to lookup
- * @base:	base directory to lookup from
- *
- * This can be used for in-kernel filesystem clients such as file servers.
- *
- * The caller must hold base->i_rwsem.
- */
-struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *name,
-			  struct dentry *base)
-{
-	struct dentry *dentry;
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
-
-	err = lookup_one_common(idmap, name, base);
-	if (err)
-		return ERR_PTR(err);
-
-	dentry = lookup_dcache(name, base, 0);
-	return dentry ? dentry : __lookup_slow(name, base, 0);
-}
-EXPORT_SYMBOL(lookup_one);
-
 /**
  * lookup_one_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
@@ -3209,8 +3156,8 @@ EXPORT_SYMBOL(lookup_one);
  *
  * This can be used for in-kernel filesystem clients such as file servers.
  *
- * Unlike lookup_one, it should be called without the parent
- * i_rwsem held, and will take the i_rwsem itself if necessary.
+ * It should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.
  *
  * Returns: - A dentry, possibly negative, or
  *	    - same errors as try_lookup_noperm() or
@@ -3322,8 +3269,8 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code. It does no permission checking.
  *
- * Unlike lookup_noperm(), it should be called without the parent
- * i_rwsem held, and will take the i_rwsem itself if necessary.
+ * This should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.
  *
  * Unlike try_lookup_noperm() it *does* revalidate the dentry if it already
  * existed.
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b3346a513d8f..cb79e84c718d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -74,10 +74,8 @@ int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_noperm(struct qstr *, struct dentry *);
-extern struct dentry *lookup_noperm(struct qstr *, struct dentry *);
 extern struct dentry *lookup_noperm_unlocked(struct qstr *, struct dentry *);
 extern struct dentry *lookup_noperm_positive_unlocked(struct qstr *, struct dentry *);
-struct dentry *lookup_one(struct mnt_idmap *, struct qstr *, struct dentry *);
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   struct qstr *name, struct dentry *base);
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
-- 
2.50.0.107.gf914562f5916.dirty


