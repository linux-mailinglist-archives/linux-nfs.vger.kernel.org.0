Return-Path: <linux-nfs+bounces-20128-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPb/L1pfs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20128-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:50:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD727BFA8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE57130CEAAB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0030EF7B;
	Fri, 13 Mar 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Xigasop1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvytbuZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33330AAD0;
	Fri, 13 Mar 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362733; cv=none; b=SsBWdKSMKj01oCDwANocY9afieHdnxydEx8Xi9df8GPu+bVRNu5Agx4LjF1XBU12JyhYnzY4sEdmu91FwPF/JY7mguvQrrSU9ZOqAL0rT5GSfyBhWH0T5FGNAVuZjuqeNzVam3l+IGsPQKYHYpKk01/yLO2awNJ5IQ0nQ47Fxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362733; c=relaxed/simple;
	bh=5YfDw7LrlOQhF52b/60zX5HsaX+8xwtDUhWoOG5zh3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmCub0XhHbzM6Kfmo1YsY+Jlh+jICp0LJUw8Yt+J+9vBf6RgvcQYuS7GLePYmPKdDlw3glj3Rg2fnz3Qlvdlnzexg+hn2q0PNxbvkZNyiEOTSaOTa+UwEhwwRJhQvcAOz3+RWqCgJW2deK1UJuFuULbOUaZZvfS7Vna6wKr4Lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Xigasop1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvytbuZD; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 723A11301B47;
	Thu, 12 Mar 2026 20:45:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 20:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362729;
	 x=1773369929; bh=R05x33rqt4D3Op1mihSzRwcI3EKvb6TFzzswayv/Ksw=; b=
	Xigasop1MFc1BQXQk0iq0PfuDE5mE+cILrPFMrDYi2HMs5dOR7m3kR60PFE0o//D
	aw2w/JFsCcl4UMgrADlcOW7LnhmzPFw08CFCSey71EXkDmErCHEi+jV1cGpk00Ts
	tEFSho7APavmIZUF0dMzV9Gkq78RsEPr1fAJ1JQVkbh4z/t24eBjVMJ2iQ2FDZ9Y
	7ketqCAapUiVN1O9T16DVsGZ/8cXOCWKejAqG2k6NgW2cxG45qPNMJl9IPFen5V/
	orYVj3SFsDH2EOV0JHX6QCoGsJzMb8M4NMZohb+vDl7P5TEDtUi5kJP2hvJVYvqh
	F12YY7eWyASDT/+ROxjrlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362729; x=1773369929; bh=R
	05x33rqt4D3Op1mihSzRwcI3EKvb6TFzzswayv/Ksw=; b=FvytbuZDDevI4Y9VG
	JVZqSJMtkrWNxz48lVJmr/EpHNXAk7GWlVs1oWlFVkAQTUVnGKy2Dbd3N857jru0
	c2IoXqdFdnReDa6d8K2oodMGlOj8GCefMCv+cRaC7IjCCbbuTZklNYoL8xRuYr0F
	g2vk1l3mBLBWqC3Ym8bfh90KxjjC66/YiXzk0siKTVi0/DIYZnRN2EJqa02yyRpS
	vEs5fDDK5GYYr0uCIn0BmwwcOxDjkV0BR9kEP0Sn1Tx7ezF6Af3gnhuCMP4Z3sz8
	vaPSeIjskEaJHNN6PGjenL/R1IF5oAuSRIvL/OBiCSQpf8gBGcD8V3ZV2/2ls1h/
	Ycpqg==
X-ME-Sender: <xms:KF6zaaoXWyZZvhY17htT7zTbbZ-fm8CiLEK9cz49vqGCyRAGAG2lTQ>
    <xme:KF6zacWJYv-sR5VYxTujowgTH2C6epaXN-cWDG2hNB5WXffMCREy4Gd0UroqlHUIx
    8IWlVwgW2p9hrl5l1KAYxi1GmZGEUf2actXDGLN7gPn6aIT>
X-ME-Received: <xmr:KF6zaaS0qRJy-k5JF-BgDVTm2ja4gMdS4iod8uhA844UKEHrZelDgpUDvzhU8J1K2bLmTfoC0ItOki9ZteHCgRVNq2MI7NsQsAkoGsr4g3V5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KF6zaXUhNuWqMfOt-q70hBBhYgBzxQMIedAXB23XfOhHI8JFpA0CSw>
    <xmx:KF6zafZ5LywNiNZDFY_G05X1qY4SJi5n3Ozd5CPSA_E1FksrMGHqCA>
    <xmx:KF6zaV95xMcxOp7quDaX0mMEYp0Wor0o8Ltj81Bg-KhFqYDM43mTrQ>
    <xmx:KF6zae5fT0BJZzWHa3X9lFqgt9O5rUax6R5oBVr3uScE3ddRI8zGnw>
    <xmx:KV6zaUli0x3NBlCHJrCPno_ViJshrj1ZG14uzpnRZbcLeJpZod6RSQsK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:45:15 -0400 (EDT)
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
Subject: [PATCH 29/53] exfat: simplify exfat_lookup()
Date: Fri, 13 Mar 2026 08:12:16 +1100
Message-ID: <20260312214330.3885211-30-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20128-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19DD727BFA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

1/ exfat_d_anon_disconn() serves no purpose.
  It is only called (on alias) when
         alias->d_parent == dentry->d_parent
  and in that case IS_ROOT(dentry) will return false, so the whole
  function will return false.
  So we can remove it.

2/ When an alias for the inode is found in the same parent
  it is always sufficient to d_move() the alias to the new
  name.  This will keep just one dentry around when there are multiple
  effective names, and it will always show the most recently used name,
  which appears to be the intention.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/exfat/namei.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 670116ae9ec8..e04cda7425da 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -711,11 +711,6 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 	return 0;
 }
 
-static int exfat_d_anon_disconn(struct dentry *dentry)
-{
-	return IS_ROOT(dentry) && (dentry->d_flags & DCACHE_DISCONNECTED);
-}
-
 static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
@@ -750,32 +745,15 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	 * Checking "alias->d_parent == dentry->d_parent" to make sure
 	 * FS is not corrupted (especially double linked dir).
 	 */
-	if (alias && alias->d_parent == dentry->d_parent &&
-			!exfat_d_anon_disconn(alias)) {
-
+	if (alias && alias->d_parent == dentry->d_parent) {
 		/*
-		 * Unhashed alias is able to exist because of revalidate()
-		 * called by lookup_fast. You can easily make this status
-		 * by calling create and lookup concurrently
-		 * In such case, we reuse an alias instead of new dentry
+		 * As EXFAT does not support hard-links this must
+		 * be an alternate name for the same file,
+		 * possibly longname vs 8.3 alias.
+		 * Rather than allocating a new dentry, use the old
+		 * one but keep the most recently used name.
 		 */
-		if (d_unhashed(alias)) {
-			WARN_ON(alias->d_name.hash_len !=
-				dentry->d_name.hash_len);
-			exfat_info(sb, "rehashed a dentry(%p) in read lookup",
-				   alias);
-			d_drop(dentry);
-			d_rehash(alias);
-		} else if (!S_ISDIR(i_mode)) {
-			/*
-			 * This inode has non anonymous-DCACHE_DISCONNECTED
-			 * dentry. This means, the user did ->lookup() by an
-			 * another name (longname vs 8.3 alias of it) in past.
-			 *
-			 * Switch to new one for reason of locality if possible.
-			 */
-			d_move(alias, dentry);
-		}
+		d_move(alias, dentry);
 		iput(inode);
 		mutex_unlock(&EXFAT_SB(sb)->s_lock);
 		return alias;
-- 
2.50.0.107.gf914562f5916.dirty


