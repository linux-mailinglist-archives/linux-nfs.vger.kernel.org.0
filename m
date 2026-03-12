Return-Path: <linux-nfs+bounces-20102-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIj3CLQ2s2nlTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20102-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:57:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4AA27A816
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D10073048935
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24613AF668;
	Thu, 12 Mar 2026 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V8DLV4wc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4sXEIXuX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F381B18;
	Thu, 12 Mar 2026 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352559; cv=none; b=qZHKE4HgzTd5o7iT3GzB4MPTb1Dot86DO1qcf3JH7NzQq33Y/ZzBdmgP5aAmAzf4WfhFG5sFY5l44W58SFF+QvZ4IGgmH8iJXzcCZ0fmhWbT8+gPtZIq+Y/w7cxy+01XnSgQnrRGMDnt2sk9jYyDuhpKVd4rhGL7LpYEPjAHAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352559; c=relaxed/simple;
	bh=FOzJwtw0hHbMUJM8s+KVybcLkR+QYGVmqbEOpwq9XZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAX5th8uMb9k9QHZTsXXPwlULS4r8A98ckxTLCqPvWFieuccGh5MJet6nkkxgruy8tFsZKvuphrCFg2z6oyu+nFmliIwRMY+lXY/0ZlyfLsQO15hD8wCfeDbsfz0Gon5QqDEKAYuqq0Ap9xINyHEzxzg2M5Clcpti9tcSCR4wPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V8DLV4wc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4sXEIXuX; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 0347F1301BBC;
	Thu, 12 Mar 2026 17:55:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352556;
	 x=1773359756; bh=I6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=
	V8DLV4wcDGzhYebZPH4WK6E6cnXp1js2ckOETA/mb3gtKYUj8AtiU53pW8X5+uwx
	xh/Uo66CpTtUtZ4jmkXHAQhGC4g6P4sRJXtaWRNrdNLwnuZ5n5RNAsWDL4ky8tBQ
	w/VWSQ8ARbp+TTDBFg1VsxOtUfZiPyg4tlmEPKgESKCF4WIdXQ7cNpBcnaZg18/r
	NbDqlQl08OCTnlmB7CBOXZ+sKDVWJoDSNdAUKfQorFSUOlBf2VJ63I8JUboZYz4y
	sYVGOC28gblJ6pAGHKCTtDhMiB3lAojFXsfrVjP9t/rpcJ8NBgxsTkxpogTSS/Jk
	NyUn2RHykhm1Zeb6v7POLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352556; x=1773359756; bh=I
	6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=4sXEIXuXZzpHdzsHY
	PI2r+pAeLO3D1p9t181hTerhmfrg1ujOX7AFVzgJlZAcUkevJbGyuacKaowYC42F
	kdrHTycOi5y9e88M4rq8+FOkXdbfBVGkRwOttka4u9t3gG9suHxbCZlzQ4HZf/fX
	cMzdXresl/Tkvk+CBFO67YH8oWWSjLVZfiA8dtQvrx+Pl1/0kBZJlHs++PpApXtf
	RkpDy4SrMA7h42gvYoK3MPokpoC5AnexXDVLyOxJsVhsRP4aCVl63NbiK/xmBzYP
	UsHcxRBRy/yDgJXHMafRUDiKl/NYzkWF4nJppx9bDb/T5j5kpS9zlYtGSAwheDR+
	c8bMg==
X-ME-Sender: <xms:bDazaZrV28pidytb2CYdFve-dYh4A17kCWOK2uAL1o4fmx--K3xe7g>
    <xme:bDazafUIGe5MYqXQD20ERLM0fjljLJS1qLyRBTW1m1z7XOTTBabu4SUJ7K4f5F3ag
    UlNbuIMnuD6VD0QNIHGQEP5HYfEuFFkMrQuosAE9lik0RuvSg>
X-ME-Received: <xmr:bDazaRT84owQtzmu1E0sWlHYeRbIptXgWxDzjLQfhyeWsMzpDUz0FxZfOYGz-by_i908pb9VVQdmsTc4utEjIGAT_GSE4xivjUQziUP-OuUx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bDazaSUsCGEjzBteuH5vkHe0hneFVXDir_IRGQ5mVK1VCyydF7QpDw>
    <xmx:bDazaeYmeBRieWGQHtvJip14aHkEz2FCB_NvPB9keh2Yshf6AzVEDw>
    <xmx:bDazaY-7VYc2D1GPJaWbiimtqzocm9ZyVp3WLpcNsYY3sAaV8eu4Ug>
    <xmx:bDazaV6u3_amBzfCr8zxdPKXl0rmxXcDwGlJnKOJ4bx25fBZdOe-8Q>
    <xmx:bDazaR3pE1IGQUmm0mhqqjDrKLG1FXrx_IG_1fXiekIIHnyGeXtkG-Ex>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:43 -0400 (EDT)
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
Subject: [PATCH 43/53] fuse: Use d_alloc_noblock() in fuse_direntplus_link()
Date: Fri, 13 Mar 2026 08:12:30 +1100
Message-ID: <20260312214330.3885211-44-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20102-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,brown.name:email,brown.name:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C4AA27A816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

fuse uses the results of readdir to prime the dcache.  Using
d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
in that case is pointless as the lookup will add info to the dcache and
there is no value in the readdir waiting to see if it should add the
info too.

Also this call to d_alloc_parallel() is made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So change to use d_alloc_noblock(), and use try_lookup_noperm() rather
than full_name_hash and d_lookup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/readdir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index f588252891af..400a1a24f659 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/namei.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -192,14 +193,18 @@ static int fuse_direntplus_link(struct file *file,
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
 
-	name.hash = full_name_hash(parent, name.name, name.len);
-	dentry = d_lookup(parent, &name);
+	dentry = try_lookup_noperm(&name, parent);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+		dentry = d_alloc_noblock(parent, &name);
+	}
+	if (IS_ERR(dentry)) {
+		if (PTR_ERR(dentry) == -EWOULDBLOCK)
+			/* harmless */
+			return 0;
+		return PTR_ERR(dentry);
 	}
+
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
-- 
2.50.0.107.gf914562f5916.dirty


