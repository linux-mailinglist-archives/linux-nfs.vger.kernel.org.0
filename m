Return-Path: <linux-nfs+bounces-20083-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFcHIB80s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20083-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:46:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83F27A2F8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6000B303CED9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3C375AA8;
	Thu, 12 Mar 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pPGvE0/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFIhTwRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58B30EF6C;
	Thu, 12 Mar 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351956; cv=none; b=hDgSxF/zUi9e36nnS0IRCZ11O+mK2bB42EGxYkB1i+k1Z9ItSeEseQb6kEk7XUJBOUHhd7JZ4vQwOPwa+aPuPlpSZl5OBF54ESZCPNUE6kdAC70RdbpqF8l8iMPd/jWY/qDYGAYxSB6J7tUMT36iPe3jFP2YjRy2StIJEsrSU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351956; c=relaxed/simple;
	bh=NP4fxbAgK/sTDH/N09RZdgSyoNWhHFPeHmiXu7XZLn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8dNWYLAHl6HOkHNaIC4xro3CPqXG+E00U2bIkSTHeVdVn4ulMr7OMCm76zJ0v/SiKjA7e7TDTl3wpqfrYY2zNvBNKFsL5iw5KrSKWFFjf7hqnDu6eQ5MWaGWzKF5AZ6JQvZjtP5EWb4eOIlW2B8vT6RAEeCulYr0bnQ+RQGveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pPGvE0/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFIhTwRQ; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 3580F1301B45;
	Thu, 12 Mar 2026 17:45:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773351953;
	 x=1773359153; bh=pOd6V7aKWFyKrN4KTkaFsGguAEcn5SSc/x2IfH39lBE=; b=
	pPGvE0/wze36tWU9meYWm71B5TEuwgjRl7cD7NY/VsCrs2UOu2H4cZhD6kfNHK43
	Gr8Z3X40uCciBPHCc3eRyAxd0EHgpM0FWGMKdxp/Lit40UuawYIoChKd4ytFu+bO
	CTK+mieDXDcRAN+U05ePX8ZprftdvXdJsHYS8r3C+1MTsutJNW0FqPdRKSFiYaFT
	Pqawe5NhNacvc0OkXGvVXjEQqAlmMwvgk3rU83qWlvWjsWS/ZnyYUGpZ/usSmSdc
	AGeM7LfKykjTRzE1phaKDqaKG02WaJ0E/+KnLi17wRz8EFCnEX16D9eXuio1p71E
	oCnNMDE2YXOHhTwDCTQM5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773351953; x=1773359153; bh=p
	Od6V7aKWFyKrN4KTkaFsGguAEcn5SSc/x2IfH39lBE=; b=eFIhTwRQmdA0/ycbp
	8k0ZJ7O9a3vmHkwPo0UDJPa38tcW6T9LKWyKQHfAjkADzC3U71y4B7rTKoW0jIaf
	tsM6beiXSWuOpcbEyCcfhU2jv/1y/Kts15nH7ihQoxLpfH0I6VRBmHfyeRReNVo4
	b0/JsGh7FRaLG/C/GLScSrCB7cbwYMNlzSOG6FyDcYRBiotzXpc70QmG2mbiCaDH
	YTYQtO5R/TPsIHwSTrhlkKSrP8toQTjRONGsz3tAKHk5XSLxx7gESTZIV43TxO1L
	PBtIW4sJGXH9emjdJB3Qa/nCukQmQopIL/3vXMQ6YMNKVJ66Fqn16mg5BqQSUbEA
	ifZ5g==
X-ME-Sender: <xms:EDSzaVNDpiKJZENgVCA9I7YA4AvZbh9Eig9y4odQ4tT6DzFb5X87Vw>
    <xme:EDSzabr2acKAdgi0PXr6sS7dhoZQ1HixNusyuIep139v-c0erV2Zbg84iRsLCsK5j
    P7eNa0G3T2ukatA2Q3nEy90nNbL_LjTeRxiyi0JYsUypLyS>
X-ME-Received: <xmr:EDSzafU2k7Cj1roPxCD7G4WaMiN2VyYitSNjVtMUHwH4XlOI311cbTOrSMhTuuitDHgkXXgRSeU8fQMEZCDDXoDO9THYMmxK5vNuLJD3zqC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:EDSzafJjY03e1TTET2wNpUPIFnPBeekp1nninvOZGR5e0R_dfbWpQw>
    <xmx:EDSzaS8XbeIyQbWH1HSJ7n09lU73R9fvaJ-S-FJbhzkfDYlUKwmmPA>
    <xmx:EDSzaaSgzRn3mzNTP16XuwLz5QkATEDsqLmG9OTSsg4aJl7k0RreFg>
    <xmx:EDSzaU8WGXEOtnGn1GT5KScmwI5mRmdixCtotI_6lnlSm7a1vZ8A7w>
    <xmx:ETSzaUxjyZcpCVYGlJmzQ0FVQrX9q4d1eZSsMh64o1Ud163Rr7jyjJIu>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:45:39 -0400 (EDT)
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
Subject: [PATCH 05/53] VFS: introduce d_alloc_noblock()
Date: Fri, 13 Mar 2026 08:11:52 +1100
Message-ID: <20260312214330.3885211-6-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20083-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4F83F27A2F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_noblock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 82 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c80406bfa0d8..f4d7d200bc46 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2661,8 +2661,16 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+};
+
+static inline
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2745,7 +2753,18 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		d_wait_lookup(dentry);
+		if (d_in_lookup(dentry))
+			switch (how) {
+			case ALLOC_PARA_FAIL:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				dput(dentry);
+				return ERR_PTR(-EWOULDBLOCK);
+			case ALLOC_PARA_WAIT:
+				d_wait_lookup(dentry);
+				/* ... and continue */
+			}
+
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2774,8 +2793,65 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_noblock() - find or allocate a new dentry
+ * @parent - dentry of the parent
+ * @name   - name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_noblock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM or %-EWOULDBLOCK.
+ */
+struct dentry *d_alloc_noblock(struct dentry *parent,
+					struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+}
+EXPORT_SYMBOL(d_alloc_noblock);
+
 /*
  * - Unhash the dentry
  * - Retrieve and clear the waitqueue head in dentry
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c6440c626a0f..3cb70b3398f0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -245,6 +245,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty


