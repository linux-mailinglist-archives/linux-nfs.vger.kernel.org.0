Return-Path: <linux-nfs+bounces-20120-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOjuILRds2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20120-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:43:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088027BB22
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2FEF30B3BCC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25F2FC874;
	Fri, 13 Mar 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="evZBO/FT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tlm7pJXg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364832FAC14;
	Fri, 13 Mar 2026 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362597; cv=none; b=PvaOmLI8BRbnyCx7ZfNvAF8Os1ShAyT3wYdX6XBchBiyRLa1V8L1C/FNP4WDqVRG6lkX76xIE2/qCWHBK+p6yzE1rPMatqTePDXRz6ebMojopR4/Jph/B5mtK5ml+mlTLpEj4kZeEt9rQQFuT+dJ6pNR4a+39Jctv3/uwEv947Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362597; c=relaxed/simple;
	bh=V1LusLfhIYS279k6+gPTO3CAtyNEfgSX9UJqBDT2m6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9Y+fhHPOc9+2oA1nUHi6kMTNCnLpKPy7BGdEMS4JuF3uzQgx6Q1Pf9m6FfMbj1OKYuuQmZtnGWW/6QOOE5vn867VNqd0x0sORkgXtTn6xErJ2TKyb0FA2HZ+/y3HiVnJmcfRYXq3tkYUCg6xZbi2W39HiH74yLbhyCzb5GfZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=evZBO/FT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tlm7pJXg; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1863C1301B1D;
	Thu, 12 Mar 2026 20:43:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362590;
	 x=1773369790; bh=mtJ/saZCLiCxFDNQljniHYoFSU4uzdwtWsgXO8zNDIk=; b=
	evZBO/FT5uLkrmbp/p/bKHGn86ivpuWIB8uwzomHLGU6kH6lhmmlCRwiDJoWV39q
	TXhehd3v184kz2tKDZFnYt3nMYpGYs0FHIDP5P1WpT7DuL/s4rQw/xsDTsgE9QLg
	/164043xlTxtGbkRkgPLxopa5nRZXLGdKExiyrVeEWQB7Z6SjppifuMa+H+nAnt/
	Y9UIllgVcpdMC3ryQir69hasMs4sAzed4op96lB/0i6WUn6Uhf0fVcGFEXiSJozk
	InAA9BqTgm3htPeeddGMpXgGFTZior38m4S57df0DQ4nN26Wz6Bnup7omFSZuA/V
	bXDsxk1oRwy+oBWG8yzDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362590; x=1773369790; bh=m
	tJ/saZCLiCxFDNQljniHYoFSU4uzdwtWsgXO8zNDIk=; b=tlm7pJXgvMRnwrzqw
	361ob53tdiymOgQgABOTedImHhfzfyXrgBfCei5K7ic4kOntEU7/s+f5sGh5Urct
	yi6RhxZa9AKNdjteFK4EVVHFzPhf0rBHY7+D36NQKzOYqyDZTXwjWo75g7RIoUOt
	+1Y24Dtef108V7gC/hPAOKuoKHxLQb6ez/GO9OthDEETcJ7ke8mp144qJcMLu188
	7QoX5KdxhtTAeNLGhB9EFu+7bHr1B8GbxO8xT5UwDkDbvUE6Kv/LXlywzoVIfx8H
	5/sPhbm9H87cFjM4xoYFeNlJ51RwpxBUAAY7/b3qCojyfoXALXgP5SiZxeMBLz3U
	TvcfA==
X-ME-Sender: <xms:nV2zaf-NnCpb3HI-jpnIeaMEX78RNQjZehsLTDQASvyJLmVZkQdgfg>
    <xme:nV2zafZJ7mvrmpO-gcToxfMKwcMc5Q_rFX10NZl8_LR-rje39CCVNCfpHij589i8x
    F8Ot_R8pRFhAt1hFRsQ_wy6CVw51XS3cVTIlX1zcPm_ZZvJPw>
X-ME-Received: <xmr:nV2zaYGPAoTTcGmEks6mZrihRO7DEzSJQTLVP_2o9xNxWYeVqZvQjDfXGA3yqw1n6XZ5fGvyGTUhxFiRqIqqc-pGG5s2HTIOOgdySI1Z0kbM>
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
X-ME-Proxy: <xmx:nV2zaY7faWbXQHLIpd0SYafA-iMAWHAFfnW2ShinVhLAUGrEfx07iA>
    <xmx:nV2zaZvgDZlHyejqPasp60C6LyxeD80AFwab7f1aj4miUyVx-K4aCA>
    <xmx:nV2zaaBryqgkdrCkCXjeDM2uqFf7SAUNres7R_12QlIkQ3RduF7YvQ>
    <xmx:nV2zaZvraRlGVqoe9uMDqj0rk0wlwP-X2N2IrOVEi5yN04lSuh4s-Q>
    <xmx:nl2zadJN25sW9Jik8_kJDmuvga-QlrXGx2xisz4qYzgk4C1wnxRkBwfU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:42:56 -0400 (EDT)
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
Subject: [PATCH 37/53] cephfs: Use d_alloc_noblock() in ceph_readdir_prepopulate()
Date: Fri, 13 Mar 2026 08:12:24 +1100
Message-ID: <20260312214330.3885211-38-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20120-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,brown.name:email,brown.name:replyto,dname.name:url,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0088027BB22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

cephfs uses the results of readdir to prime the dcache.  Using d_alloc()
is no longer safe, even with an exclusive lock on the parent, as
d_alloc_parallel() will be allowed to run unlocked.  The safe interface
is d_alloc_noblock().  In the rare case that this blocks because there
is a concurrent lookup for the same name there is little cost in not
completing the allocating in the directory code.

It it still possible to create an inode at this point so we do that even
when there is no dentry.

So change to use d_alloc_noblock() and handle -EWOULDBLOCK.  Also use
QSTR_LEN() to initialise dname, and try_lookup_noperm instead of
full_name_hash() and d_lookup().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/inode.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 0982fbda2a82..8557b207d337 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2011,9 +2011,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
-		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		dname = QSTR_LEN(rde->name, rde->name_len);
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -2029,20 +2027,24 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		}
 
 retry_lookup:
-		dn = d_lookup(parent, &dname);
+		dn = try_lookup_noperm(&dname, parent);
 		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
 		      parent, dname.len, dname.name, dn);
-
-		if (!dn) {
-			dn = d_alloc(parent, &dname);
-			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+		if (IS_ERR(dn)) {
+			err = PTR_ERR(dn);
+			goto out;
+		} else if (!dn) {
+			dn = d_alloc_noblock(parent, &dname);
+			doutc(cl, "d_alloc_noblock %p '%.*s' = %p\n", parent,
 			      dname.len, dname.name, dn);
-			if (!dn) {
-				doutc(cl, "d_alloc badness\n");
-				err = -ENOMEM;
+			if (dn == ERR_PTR(-EWOULDBLOCK)) {
+				/* Just handle the inode info */
+				dn = NULL;
+			} else if (IS_ERR(dn)) {
+				doutc(cl, "d_alloc_noblock badness\n");
+				err = PTR_ERR(dn);
 				goto out;
-			}
-			if (rde->is_nokey) {
+			} else if (rde->is_nokey) {
 				spin_lock(&dn->d_lock);
 				dn->d_flags |= DCACHE_NOKEY_NAME;
 				spin_unlock(&dn->d_lock);
@@ -2069,7 +2071,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		}
 
 		/* inode */
-		if (d_really_is_positive(dn)) {
+		if (dn && d_really_is_positive(dn)) {
 			in = d_inode(dn);
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
@@ -2087,21 +2089,22 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		if (ret < 0) {
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
-			if (d_really_is_negative(dn)) {
+			if (!dn || d_really_is_negative(dn)) {
 				if (inode_state_read_once(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
 				iput(in);
 			}
-			d_drop(dn);
+			if (dn)
+				d_drop(dn);
 			err = ret;
 			goto next_item;
 		}
 		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 
-		if (d_really_is_negative(dn)) {
+		if (d_in_lookup(dn) || d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
 				doutc(cl, " skip splicing dn %p to inode %p"
 				      " (security xattr deadlock)\n", dn, in);
-- 
2.50.0.107.gf914562f5916.dirty


