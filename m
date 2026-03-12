Return-Path: <linux-nfs+bounces-20107-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMRtAYg4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20107-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:04:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C68627AB82
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E213227DAF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B223D3B6C02;
	Thu, 12 Mar 2026 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nvIfh2aV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xlwDjQbH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE0317142;
	Thu, 12 Mar 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352645; cv=none; b=oXWepgmAkobNzBgNGc3AwyYX3QtuZdemYA259c70/CvVW7xu1SL2M06XCC7ZBAjW18SodblLKusvWaCScZwZTP7tM2TlcE2ly4lMQrQDzQjr1xWg3qKgnaHNLIH9tEYq9ZJaKRthsWvhIP1PUduyY+nPMs593B24pvd/ZOqRu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352645; c=relaxed/simple;
	bh=sJlA18OTmCW0Nza7hJ61Fmatr582H1VHa/YPsfzcAXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAp3DHT5zd9or4OeJqxLovqN8obX6gLUBQOafethIyNs4JiP9sjDXl7zW8sUoLuNtImB8l54WyCA7QiMvANqQZZC/sxFXtnalJ9NLvJJCZ0DvKwpQmap2XPat+ovr1ACiI2wDg/osVesSWrk6fvOQ7VdK/EPwNvm1kdzxgyQ8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nvIfh2aV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xlwDjQbH; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 8380A1301B63;
	Thu, 12 Mar 2026 17:57:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 17:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352641;
	 x=1773359841; bh=TcDuCufZRxJixrcfGFygV+aETR7o0fZBVzJe26rF96E=; b=
	nvIfh2aV2uCnP5fbNBD0+p+cy5dGDLvwuz7s3Y2ug0pE9ASziUJZDIeLE56guz56
	/o5mTdgRuBry13nfhP1Q6ljFE8dK90mkT3TGfExLnEDQmbbJ4Dd5dIswurNNrHRG
	qGYhyGNzBYe1eg7Wv4tqzkAxFgmyldVz0qJd1mhHWbQli6lUFt9JSJiI5gyfnnfm
	57b4oV9ELFNsGFG3SMNAeCDK4TTz5aO3+SYbXmhxZKK0+IiiAUY8/N6+jkCPR+pd
	4dpuFNZj/O88RcKYROJtoFUZ9hP5f5ew2YzSgcaYhUFxonj7LcTlhEjqBbo59CfP
	1Bx00rDdV5Kc8MhWJ7JNLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352641; x=1773359841; bh=T
	cDuCufZRxJixrcfGFygV+aETR7o0fZBVzJe26rF96E=; b=xlwDjQbH9C1hyWYTk
	qKwHe5IPsQr+iN4dxQjz1i3OO4hnW9JvPTqO9DlXAuYx/EU4usiTZf+yBPoL8+fp
	v/v6ZaEjHOByIDbkNYrbdJWbNWeuewez+R4OXr/Xw9Qyo+x/FkLR79SrLLtJK3d3
	3mf0I+ElHTZ5v25Gr2YAJD3rYwupgT1B6fSTpAvQYmWkEZXCpYWUVl/GMo584Do+
	OCWpoJvv3lLzJ5rwqiPmcnhbTPLew/JpKRHjScaMdrDKoT/wZLzFfO4XO/ABZ5D/
	u0cy237zNWkEclRAhZkLsXOULDttuM2SX9t6Y/c5mpNLkRskDDrpctYmuSOGGgpj
	IdArg==
X-ME-Sender: <xms:wDazafdO_sWmGhWD6154c9XN-js9DNlJSejXhjsPLSLhzF2tW7ppPA>
    <xme:wDazae6WP7w6MULrdQaFCcRVtULw3Y7MWcWXAitpbINf0gpHinB9l76NFAp9R3ud6
    RB4dpzj87qnkxj_U4OdBaVw3In1ut-s--0rHPkEKyshYsCY>
X-ME-Received: <xmr:wDazaff2jYtQMUMv9jiPp3U3_pL_Qyu4MAGP1jAbw-8ts5m8XsCM-D0VpPenhsz9BGYuWjErsQG9g397hHc0xvCSqiukdGirvqWJ27D7kx7s>
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
X-ME-Proxy: <xmx:wDazaVAuQHn5C2dPy2Z6RtnXGYui5i3IkWQro_KarsGBRGti7OYaQA>
    <xmx:wDazabEf4uiVOaOx62aACayZTusJrh-zsFGKwToEWfSjuae36C7qtg>
    <xmx:wDazadjc9GxUmAxpfWyoSqBYdHbU04U8SCrZ2NeJ1FBeztiTngr6VQ>
    <xmx:wDazadvuGOVPBQxad0umw1vk5OPWk8rux78NWpwYaI80YZgoEPwTig>
    <xmx:wTazadWAt_VLN_gSlwcbgrDREjkhIl2uauPOa9jebByPwtSF2xeXUZZx>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:07 -0400 (EDT)
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
Subject: [PATCH 48/53] VFS: remove d_add()
Date: Fri, 13 Mar 2026 08:12:35 +1100
Message-ID: <20260312214330.3885211-49-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20107-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid]
X-Rspamd-Queue-Id: 8C68627AB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

d_add() has been supplanted by d_splice_alias(), d_make_persistent() and
others.  It is no longer used and can be discarded

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 19 -------------------
 include/linux/dcache.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 23f04fa05778..4ebbbcc5aec4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2979,25 +2979,6 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		spin_unlock(&inode->i_lock);
 }
 
-/**
- * d_add - add dentry to hash queues
- * @entry: dentry to add
- * @inode: The inode to attach to this dentry
- *
- * This adds the entry to the hash queues and initializes @inode.
- * The entry was actually filled in earlier during d_alloc().
- */
-
-void d_add(struct dentry *entry, struct inode *inode)
-{
-	if (inode) {
-		security_d_instantiate(entry, inode);
-		spin_lock(&inode->i_lock);
-	}
-	__d_add(entry, inode, NULL);
-}
-EXPORT_SYMBOL(d_add);
-
 struct dentry *d_make_persistent(struct dentry *dentry, struct inode *inode)
 {
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 18242f9598dc..31b4a831ecdb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -282,8 +282,6 @@ extern int path_has_submounts(const struct path *);
  */
 extern void d_rehash(struct dentry *);
  
-extern void d_add(struct dentry *, struct inode *);
-
 /* used for rename() and baskets */
 extern void d_move(struct dentry *, struct dentry *);
 extern void d_exchange(struct dentry *, struct dentry *);
-- 
2.50.0.107.gf914562f5916.dirty


