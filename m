Return-Path: <linux-nfs+bounces-20133-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNIzKbRes2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20133-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:47:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C327BDFD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1AF2300899A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633213101DB;
	Fri, 13 Mar 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RNXQe8RC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wfskezN6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3E242D70;
	Fri, 13 Mar 2026 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362818; cv=none; b=A/rCK2j47kAz0WJNJrhjqgRgo7/heHCkd0Xr27qp6YXyqG6nxE2JQQIfJ7JNNhs7UqowpzVsk0UFRnicDfUI1RWPZBi9a56+JAp+74G+ikOUmuifNmrwChF4rSYwViUsUj1f/51rIyA//WPnjGbPrx38L3Ra7Hv5RmEAU8k00zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362818; c=relaxed/simple;
	bh=BjD01fjUfpiWAuDi8h8umH9WTPM2waEwnWOFXx5wFxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHbrYJ4UMnU2/QuAzYfg0np/eiIEBi74RxPdUYZzj6r+jcznLQUQsUxHZ6iuLuaBUe3ZCAML0qTRiSe+m2PUHeIOcN6TEJ2aq5ILDYvxFzXqTl9YdrD9nUd/Fw4dkEwylIEgETc9sua2IQlnHYADAhkEh9UhBXZ/SX37okHq/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RNXQe8RC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wfskezN6; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 605B01300BDB;
	Thu, 12 Mar 2026 20:46:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362815;
	 x=1773370015; bh=K3IStrNmQd52sbuvLJgTXGgXoqLBL9Wr3QWVkKkzQVI=; b=
	RNXQe8RCRsLKMGTZv3GRKZahOC0IxxlJic/ko0MFy4a1ctyXK6vvz4ReaSk7Wtb/
	mAzGCuXrdmdZBQIRLvL9TgyL2qlc45O0kQ3l8qXW16jE7P6d9LqJCqRvPWC/uzxz
	Fg4Z9KDdzbQTjvMOHVIfVhzYLGcWWMkbkuEXMLMZZKzxUaOV6SPZtD3+P7r4CdlO
	YReiac+iMDhQdyLzaO6kSMLbrOxlDborVcCeQAMrmsrVMTfxIzMeSF5US+w16WfM
	ACO2ucwH/a+sdYpvVApyX2BOUWYS4NgQgEXOKZ4Urg3/g1TPjzQe8VBcsJ455SzX
	9KAVhZnChtKP/WL+6dyBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362815; x=1773370015; bh=K
	3IStrNmQd52sbuvLJgTXGgXoqLBL9Wr3QWVkKkzQVI=; b=wfskezN6avTEhR19Y
	nyFK8EjU0/MMk1mTZsKRrgviM3fKXxJNJu1JVFZMcMVBW/OhFGdzQV2zxrvMHOyI
	+wsRPzWoNSHHCaB3Uz6Z2Z50+4HPTAToivoCuItoC7GdStbUhlwIos6CNfKYetOs
	dtWj4+DVfGt5fqQnqBjG1Dqg+KH1ydv5G4O84e2/iXhc9Ryvf0hXvivBdRiWWVUz
	ln4nRLs8aYjEr1bv8aqsemzU1pcoJrsa+DX022p8AWsPy7cwqUau5yZRIa7kTqSX
	KkLiJjVMjxGllDLHldeMf1HfZBS49/IiohaDFc6csqGAyWyuyBEkdFBLfaeltNSp
	jBt2A==
X-ME-Sender: <xms:fl6zafe3S7X84lJOJFdshQFEOSrbddVEHmr1mw6S46GpGR2i6woJ8A>
    <xme:fl6zaczFa49e0KK0S015j6JpoR_5P68FmUDqY6WEQHX1cWMiUDEH-T7HQAfY5J6od
    qM5cWDNETWONPUtRpmNWTVHJCOl1xZ2rv7QmzJHE25REqnBVQ>
X-ME-Received: <xmr:fl6zaVfYsIubTYkOgpCpYFaYitUZ5oYFrWfnd5ZTirmi7nP4J0c0z79jLMuEwIr_H465ON1BCgxcqIa4aTJ0nwCIZ9blq-QRFlXrRlcGC-hU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fl6zae4dK9r668Qiw8CvZFQjfZ31XTfKNmbrp9eUDoDMrazoXyD0fw>
    <xmx:fl6zaVaKGWkKJVt8deNozJ9QBXJAphfRuD5nuPx9CFBo8ryZkkpqgg>
    <xmx:fl6zaTzrXRucFOWhgAsf8iS1wX5cATadJaq7iOpt6RIngHxauV71uQ>
    <xmx:fl6zaSQ4lRJXRVAygVyvKtYoYqFXXoBXTgOtSlESq2KNF1VJOQLY9g>
    <xmx:f16zaVIP2rSOzehLw3_PK25GCy-IcS721ulaHNjDv3drFOKshm3Pavwn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:41 -0400 (EDT)
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
Subject: [PATCH 24/53] afs: use d_duplicate()
Date: Fri, 13 Mar 2026 08:12:11 +1100
Message-ID: <20260312214330.3885211-25-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20133-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 884C327BDFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to create a
whiteout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c195ee851191..b5c593f50079 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2047,6 +2047,8 @@ static void afs_rename_put(struct afs_operation *op)
 	if (op->rename.unblock)
 		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
 	store_release_wake_up(&op->dentry->d_fsdata, NULL);
+	if (op->rename.tmp)
+		d_lookup_done(op->rename.tmp);
 	dput(op->rename.tmp);
 }
 
@@ -2175,8 +2177,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty


