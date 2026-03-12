Return-Path: <linux-nfs+bounces-20090-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN41EQc2s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20090-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:54:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF227A66C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9559432B45D7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01738B7DA;
	Thu, 12 Mar 2026 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="c/pw77uh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVii9L11"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2830EF6C;
	Thu, 12 Mar 2026 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352076; cv=none; b=XkgLZvMmrJMFq6Hj4r2qklfFl+isML3Ymfc4zkPcv39U1OGVAjZ14BThItlxL9gK4oKQa4ZS+O7sf627Q/NSl/V4Dzz6AcptjZ2Bcyr2zjIg9Bn0ShxVSr/rH85u0n48UFEvolB3ZLhrfK3h6msms16X/3SWZzkUuWHsGKz7ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352076; c=relaxed/simple;
	bh=IanQ1s1cSo/azMNMbUJmvnmkKanVhMZGZpDAk8gG8A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH7zQQKLiGbq/iRMxy7BEZfvonqBLOEpNNLRfD/xJyn0kYXAybn78EcO7aH9JfkMpiY+dbnk/b+OE8rz67cGAemrEODNhbwS52G/1ygc50dm1RcJGFlGW0x672tRgG3jZ/EnNWDAbfZpRjbgCfuEHjB3LJluEQUgNcr3VqI6FPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=c/pw77uh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MVii9L11; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 3C2BB1301B70;
	Thu, 12 Mar 2026 17:47:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 17:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352073;
	 x=1773359273; bh=W/Ak1KPwTmCaYgI05wA4foboiqmq4A6jkZq9iOG+AdU=; b=
	c/pw77uhzQwtu+x2rfy8YAQ8ODHIH6TqF5gjkDP3PnFVgS1yE39XzRUPiB7FP2sc
	RbT2SpGQkTPfjMjryKRQmCrUB49ETvDmOW/QLdaS3hsyuXpnCKPp4KpaG/88uh2b
	ZXJ9+VfUjmAlAqwi0KyMt/q9CW2hdecgqwGPYM6ENHXeNa2d3fgGwlvb8qBCnbPl
	x8pPfpV5ACsdJEY+vFgnJ5ttUL/vZ5lzs0FJW0pNjeM98B1mNj3S1TLDNNkpQ85G
	mrIMwkNyGULMNnaoWm3wi2W8zO4ZyGTiZJ5fNsPnxumyHNOH7BM2cdOc/C+ceQbo
	7ROxYdy3UdkLgEgWoNY5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352073; x=1773359273; bh=W
	/Ak1KPwTmCaYgI05wA4foboiqmq4A6jkZq9iOG+AdU=; b=MVii9L11GlwWtMhzZ
	n7iyDbPToR7JKb8T+MC59sZyBmXHZlJqZHj7ZQZrD1S9ZmYRwTLXpkBTfH/AH0ql
	XbK/noTmtQpNxvag+selT8UbNrzr/8IJl3kNxMvGZTLR+moT9KOT8al3IGiwNRoX
	j8ioh/jBUoLeJqAxmuqIyXvmtjLlIL56VrRHOV7H7mbB6T8HJiTueMd0tykadvXM
	ZaBajRtT7ugnSgBwWXivnDrJCmaH1qiDVbS3t+bJW+z4Vbk9MiVqyz7miWcV9qju
	MqrU8tjGSX+VM6REOR8up7aRz4q4674wBNNCUAlZBuJh49XTJzmrGGb3vo1RiPrw
	yZczg==
X-ME-Sender: <xms:iDSzadf1MovIDDvvqQ6m703oltGBhRnngp3beiLGJSJZjewqpRJxtA>
    <xme:iDSzaU7kFxhIoJWxE1RTDf2t8oqexnxdhjkbXG5N5FUMS8uwy6w-AM73SOEtbiuBF
    uOE7IwJJi0kM5W5JqOt7ALX4wYtbeJh1HFlYN-92h_1c4Q>
X-ME-Received: <xmr:iDSzadcoq5CrRqaaWti1CkFPSfX6M4RqKzQeN0yflSVg43UjwueDpXwh5Ys-4gY0lPdS2gJL-7qQvNFXh932_SMPRpiOg_iMtCeNxLYNWhUq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:iDSzabCq_RvYJXtjKj-mxXj8cgaSwK2kgE6I7mhCH7RkS1KGGqql6Q>
    <xmx:iDSzaZFUzlkcAnxW7y-rWbMhjamfWq-Vptqs2x39yx-7jXjO5-Yr2Q>
    <xmx:iDSzaTigiLe8tZx1JISL5ztxucDTqZ8xpdT2bkQm4n8qOh17tO6pbw>
    <xmx:iDSzabteC8QKWKodA79F8ezpVRGSzyCRtk90G-w-YL6UtlIT-rMcpg>
    <xmx:iTSzaXvLLx8QlN8PNoj_x62VFUWwQFufxUedui_IHwRwfAfxnUhgOhIG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:39 -0400 (EDT)
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
Subject: [PATCH 12/53] nfs: don't d_drop() before d_splice_alias() in atomic_create.
Date: Fri, 13 Mar 2026 08:11:59 +1100
Message-ID: <20260312214330.3885211-13-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20090-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C6CF227A66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

When atomic_create fails with -ENOENT we currently d_drop() the dentry
and then re-add it (d_splice_alias()) with a NULL inode.
This drop-and-re-add will not work with proposed locking changes.

As d_splice_alias() now supports hashed dentries, we don't need the
d_drop() until it is determined that some other error has occurred.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f92ea11aea44..ffba4de3df01 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2179,7 +2179,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 		put_nfs_open_context(ctx);
-		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
@@ -2188,7 +2187,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
 			d_splice_alias(NULL, dentry);
-			break;
+			goto out;
 		case -EISDIR:
 		case -ENOTDIR:
 			goto no_open;
@@ -2200,6 +2199,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		default:
 			break;
 		}
+		d_drop(dentry);
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
-- 
2.50.0.107.gf914562f5916.dirty


