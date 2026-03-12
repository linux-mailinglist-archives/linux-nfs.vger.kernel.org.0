Return-Path: <linux-nfs+bounces-20108-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBHXFNw5s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20108-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:10:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC227ADAB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 457E730A6B21
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1D3B2FF6;
	Thu, 12 Mar 2026 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H/xdszBd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIuUs5vU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE1317142;
	Thu, 12 Mar 2026 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352661; cv=none; b=A9Yzkqj8U+sMzn9UMBBHBaK1Tt9M7PZQQ9+RkYe3OcHE5O3qKo5qx/J4hdPpQDd+aJHzOWAjXFik1zONXjnr+co2WBcd6zR4i7nogsw2RmTlvZ4EVal3FWUkWWKR9tJVW8v5S8zq+P8bFpWQMFnDkfgjRvOwHKRmgvb82zaviw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352661; c=relaxed/simple;
	bh=IvIgaj6RGP4Mope0MBBjyMqWcWrdMOteV8lrKz+ETTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKXCvKH/LvA/nVvYYieTbByeWLVMCni3oXPyUyz0qEtHfVLPKRV5YH/UzYC42+gnw/hpBUPBOXvea0QLMddEzpxRQ+DPgMeHWJg1TcUscQ754ZeyuDmaFSgtDuHEsjMK2jezbv1SpJm4ARYtMfLTX3q3mYFhopZtuCamIbNB3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H/xdszBd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIuUs5vU; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A5ED31301B5F;
	Thu, 12 Mar 2026 17:57:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352658;
	 x=1773359858; bh=WHdWWLZAUXsN0K/gS8foO1rQ+cBpiHFflrFfn6k5mho=; b=
	H/xdszBdpajXQlqvP2h9f8bRrmPuJ0E3HbSIi1+FvDbmXu5Tffa39rTheWtfGwZR
	07K9XTAAEu7QaoJDNNdeV8FPwp7VsZ05tBCbGNERpgIPXvnUh4Dh11eHvup8m6vs
	E5AWfQHX37M7Oed9OovK3Y5b84TTp6vRaxqOKav5UXzJr4jRcIi0QkXwPhN4kZYV
	LZoFa/W1oz8zPHi+tqAL3COCNVGwcsFSYb9+rQJTG37CHQI159wRjqpP0tBXNsNq
	WKVSfQ7Vrk7fhCT55o9UbvASICeM8pa8jCAA7V/OugQhNLLKoEUUVDh26eeB6pU0
	w+PQtmIUZsNeWl/pHFJh2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352658; x=1773359858; bh=W
	HdWWLZAUXsN0K/gS8foO1rQ+cBpiHFflrFfn6k5mho=; b=UIuUs5vUUmD7NwmW0
	yb8NDgNHItXo1Ks/l/WxZ+fc3iPeAPnbXAz/dyah4o+3nxPXgyyTjMIsM+QVnZP+
	YrT1OE6Q7kMuq0FQpMmfD5M3YNYv+ja9g16SXRCe54Y8qn2v2Rv3Fx3JjasZy4Wg
	UEOHHaKmxENT6dRF9frTgZLL7RQ62rZhSzqZV+3ehBY2yK051jf/wLAtOKbzZxck
	oOCPIJW9D0oqj7rnHP94IfAhWhex0ZcyYxBDYhqGoYVxAV21pRS44vfgPWtBBbbw
	4XQOqgI+qyun3wABEJ24wxhbpqXk5pq7ME0lbxnSNrBtvCLwBnmyKv5pz1oNHiw7
	QHz7Q==
X-ME-Sender: <xms:0jazaSy8bXpWpPsaPX1E6VAPF25eFtNUoJuhfM6E6DvIgBXZeDvK6Q>
    <xme:0jazaV2G0RNn_BRqnE2PE-VjHdIf6JJIiteQEz6hIGZfeZfr65GcDPKsQiMmLA3Hy
    eBNoXKsoiKkvNl0paA5xRLSNO8N3TZuVLesMTJo84VjvJS_-g>
X-ME-Received: <xmr:0jazab7g4darHFJA-SCIA5F6MXzidX8T9V3YZD16QZt-SsfFkLX5Ub_x5kNHV7EtiTMQYwU_2nhZAmFQd5V_j1v79PJAWdXX3WHLUpxf8sBX>
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
X-ME-Proxy: <xmx:0jazaYfsce6kv1VLx4j5HYSDkDJDWLXIzfT4KuG2qT7lIXautdNOdQ>
    <xmx:0jazafZXf2ZbWmY1gwph635TbUyC-MTdZ1P4qT982CsVse9m1MpE-w>
    <xmx:0jazaaFOVBMAmCt30GIJBXbAW3DqDj5BUiJ1cbQx9CzarA2KS1okjA>
    <xmx:0jazaY0YaOBPy7S5FOPpP5VNijeMTySTyB5LHakGXV8VuIzZWSbT_w>
    <xmx:0jazafMd78AdCgo3Yq2WUdF6y1n7vTQFPDeto_tswQS3a4MdLzMaJVae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:25 -0400 (EDT)
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
Subject: [PATCH 49/53] VFS: remove d_rehash()
Date: Fri, 13 Mar 2026 08:12:36 +1100
Message-ID: <20260312214330.3885211-50-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20108-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 85AC227ADAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

d_rehash() is no longer used.  Is existence implies that it might be
safe to unhash and rehash ad dentry, and with proposed locking changes
that will no longer be the case.
So remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++++++
 fs/dcache.c                           | 15 ---------------
 include/linux/dcache.h                |  5 -----
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 4712403fd98e..154a38cd7801 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1389,3 +1389,10 @@ from an internal table when needed.
 d_alloc() is no longer exported as its use can be racy.  Use d_alloc_name()
 when object creation is controlled separately from standard filesystem interface,
 and d_alloc_parallel() or d_alloc_noblock() when standard interfaces can be used.
+
+---
+**mandatory**
+
+d_rehash() is gone. It should never be needed.  Only unhash a dentry if
+you really don't want it.
+
diff --git a/fs/dcache.c b/fs/dcache.c
index 4ebbbcc5aec4..abb96ad8e015 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2627,21 +2627,6 @@ static void __d_rehash(struct dentry *entry)
 	hlist_bl_unlock(b);
 }
 
-/**
- * d_rehash - add an entry back to the hash
- * @entry: dentry to add to the hash
- *
- * Adds a dentry to the hash according to its name.
- */
- 
-void d_rehash(struct dentry * entry)
-{
-	spin_lock(&entry->d_lock);
-	__d_rehash(entry);
-	spin_unlock(&entry->d_lock);
-}
-EXPORT_SYMBOL(d_rehash);
-
 #define PAR_LOOKUP_WQ_BITS	8
 #define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
 static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 31b4a831ecdb..eb1a59b6fca7 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -277,11 +277,6 @@ extern struct dentry *d_find_alias_rcu(struct inode *);
 /* test whether we have any submounts in a subdir tree */
 extern int path_has_submounts(const struct path *);
 
-/*
- * This adds the entry to the hash queues.
- */
-extern void d_rehash(struct dentry *);
- 
 /* used for rename() and baskets */
 extern void d_move(struct dentry *, struct dentry *);
 extern void d_exchange(struct dentry *, struct dentry *);
-- 
2.50.0.107.gf914562f5916.dirty


