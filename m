Return-Path: <linux-nfs+bounces-20087-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM6QIJg1s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20087-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:52:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D727A5DD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BE133047AD8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2343BADB0;
	Thu, 12 Mar 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BC76xmpQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCxT41qh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B83AB290;
	Thu, 12 Mar 2026 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352025; cv=none; b=AiHdKlFcgFpHiJn5Riv3lIMPrWpyAeXkDOPFI/ymfd53g7kAP9r5EpiNjsgEwQa48FUm+b8Xuk5NeILc983pdX+T2LvoSxN7eg1Dx1gXJISlp8UbWo1Xel+QUTRByen5zFq3z3zUm4Xx8cXVe2TfTsZPaD68sjnjcFnT3eTuWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352025; c=relaxed/simple;
	bh=8EFW4rG6MnNKfSYvHr+5gwbSRTR3ykiIKyTe8AdjEDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMK7oq8b28Y+ii2PkFHvi+zAPlC3miOwjsCTIEIkVSsw7BpjsYfnXIlUYUaM3eqTriIMZwO74QT88Dh4mFA7owOguqSVI0xeadXun3/TU34ozmYcHIDzjY7U7fL2rsxk7iVKWLfbjSCOCgZ45NmN8h02aFLP3VLzNBdXFl0i58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BC76xmpQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCxT41qh; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 6586A1301B5F;
	Thu, 12 Mar 2026 17:47:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 17:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352021;
	 x=1773359221; bh=d9RhJ2BuLywXUJ/fvnCHaZYNU2thzEny+uIpuniq6ls=; b=
	BC76xmpQzBJ/5FWzgYwZ3exEB8Y9YxPHLjPvprCTetgklTOlLNdancD8t5ymMjZa
	3NCix1LQtbhZKIJmxEJsx5VOEAsW8ee1C/VOGvYvKaDXzSQ7qm1PJWuggVq+7sOX
	RwRQfVuH121ZKNqX5D/PIfCsH/R6iyJhKA8S1o7+T0+6YM48RxlHwDogpHijdGHt
	SS6wqZBT0lkrQfBq4MLO1x3tvt0osH1t+pfpDHUUXYF4La5ohqB0DxS7k64FuKq4
	/2t1hr7mfNYFsZZJGtj09uj4rOGEZYTnz7ENVdeRFWwkjiYo7XhaQ7N6ktWdp3BC
	HDT8R38jU0q4FXwFBawbLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352021; x=1773359221; bh=d
	9RhJ2BuLywXUJ/fvnCHaZYNU2thzEny+uIpuniq6ls=; b=DCxT41qhRsolTCr8S
	fmLfxVTn2usDZk1YalfS014uow6ZmLtFeCiClbu0uY1EqfEce3yq0r6X15MS9F9O
	f5KaXSo+ceu5kK+S14baxhrU7tWh8UL4DUJ+ZQfKlkyWEz7zM0VrHY42SKCSlbIk
	z+JPxA1n9EmcTefXq5hlS4p7dFYZ5qD2phNVpZqECjx0aLzOZWjwX/Je2vdTQJeE
	cDuagD/6uB7HJqWOXrwp3hGm29I2LG09xT8ITuzo532E7DZV63YmHP8I6C6p3yMQ
	qGGHEUDjoK0CXP0n28Zz3w6DZ6cRwngVDUDiVADWPhnRp98AFT0MsQ5OH3LvviFd
	CNZRg==
X-ME-Sender: <xms:VDSzaXYLPrtcK0bs2zJdBCtohptPfrtuCjH8-lbNYxX2oxUhPVzkOQ>
    <xme:VDSzaaGfHfMxGyn5kMEamz8ctprxVPhX4vDmo-L4eAGQuGMr3ud_9JZvlg7amgeo2
    65r_7f8MN9XVTajYp7iCuBZ_MWXiFP8hFwfdMOtM_AmvEViqA>
X-ME-Received: <xmr:VDSzaVCrxd00LhfUp8j7wh00JZkGGCRs0NeiUYwlY0rOj2uVjLCCfhx2jew45WoX3SaIKDApk5cGTV-i_5mtndNGCoGovB0ufEaJTBZelNrh>
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
X-ME-Proxy: <xmx:VDSzabGwTA4CyLcXH0u6YYWqIejt2rnCCD49CKiQEsFjZWCS6iBiSA>
    <xmx:VDSzaYJeygJdr4jLGgDpOItYaEGvi9lW7E6L5fZdeQ_bJQAsoCQDnQ>
    <xmx:VDSzafuQHWpbo8GPLQkHsckyDbYZP-k7hiTFg20qbB1rZHTG5aOMjA>
    <xmx:VDSzaVqVRHdjut9ARknHxg73nOefF0dcf_4GTtHFCO3WI4xTl4ojxw>
    <xmx:VTSzabkEE-r_qI7J47jQxmsh9q_ZUY65iFqroveMaPY5PhnGzMBWvloT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:46:47 -0400 (EDT)
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
Subject: [PATCH 09/53] nfs: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
Date: Fri, 13 Mar 2026 08:11:56 +1100
Message-ID: <20260312214330.3885211-10-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20087-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AA7D727A5DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

It is important that two non-create NFS "open"s of a negative dentry
don't race.  They both have only a shared lock on i_rwsem and so could
run concurrently, but they might both try to call d_splice_alias() at
the same time which is confusing at best.

nfs_atomic_open() currently avoids this by discarding the negative
dentry and creating a new one using d_alloc_parallel().  Only one thread
can successfully get the d_in_lookup() dentry, the other will wait for
the first to finish, and can use the result of that first lookup.

A proposed locking change inverts the order between i_rwsem and
d_alloc_parallel() so it will not be safe to call d_alloc_parallel()
while holding i_rwsem - even shared.

We can achieve the same effect by causing ->d_revalidate to invalidate a
negative dentry when LOOKUP_OPEN is set.  Doing this is consistent with
the "close to open" caching semantics of NFS which requires the server
to be queried whenever opening a file - cached information must not be
trusted.

With this change to ->d_revaliate (implemented in nfs_neg_need_reval) we
can be sure that we have exclusive access to any dentry that reaches
nfs_atomic_open().  Either O_CREAT was requested and so the parent is
locked exclusively, or the dentry will have DCACHE_PAR_LOOKUP set.

This means that the d_drop() and d_alloc_parallel() calls in
nfs_atomic_lookup() are no longer needed to provide exclusion

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 52e7656195ec..3033cc5ce12f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1657,6 +1657,13 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 {
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
+	if (flags & LOOKUP_OPEN)
+		/* close-to-open semantics require we go to server
+		 * on each open.  By invalidating the dentry we
+		 * also ensure nfs_atomic_open() always has exclusive
+		 * access to the dentry.
+		 */
+		return 0;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
 	/* Case insensitive server? Revalidate negative dentries */
@@ -2112,7 +2119,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	unsigned long dir_verifier;
-	bool switched = false;
 	int created = 0;
 	int err;
 
@@ -2157,17 +2163,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		attr.ia_size = 0;
 	}
 
-	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry)) {
-		d_drop(dentry);
-		switched = true;
-		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		if (unlikely(!d_in_lookup(dentry)))
-			return finish_no_open(file, dentry);
-	}
-
 	ctx = create_nfs_open_context(dentry, open_flags, file);
 	err = PTR_ERR(ctx);
 	if (IS_ERR(ctx))
@@ -2210,10 +2205,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-	if (unlikely(switched)) {
-		d_lookup_done(dentry);
-		dput(dentry);
-	}
 	return err;
 
 no_open:
@@ -2236,13 +2227,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			res = ERR_PTR(-EOPENSTALE);
 		}
 	}
-	if (switched) {
-		d_lookup_done(dentry);
-		if (!res)
-			res = dentry;
-		else
-			dput(dentry);
-	}
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.50.0.107.gf914562f5916.dirty


