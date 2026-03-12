Return-Path: <linux-nfs+bounces-20127-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH84FGBes2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20127-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:46:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1361A27BCB1
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1996A3070991
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD830E82D;
	Fri, 13 Mar 2026 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gZ+8j40U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zzfvAvPP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DE3093B5;
	Fri, 13 Mar 2026 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362715; cv=none; b=QS3yD+xZLaE7/TTP7OlHesNNXJq2byHHesBC/Ibg5fq91w9zPx3FDNS17oo5GorrytrL34Qir1pzC5vVEB5s4EmRXaMFzUVCkgUn81fKjy27CQCVrf1VbABjeYF7nWu431U9qtwQcolw5zhRxBP6WRcvCG/FCPClAsieapeHHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362715; c=relaxed/simple;
	bh=f18OcmtFFvcADSvzQSJbfW5cw/pwFr0vZirs7YULIMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y477s2gl/oxvy1cQcGqagqNEcbCvdWX/Eq7jS5n+bn1vvpXD+Pk5LJnOv54Bcj7VkY/eD6suhLU+MvU6Tx3v/bbHKASwjVGcbc/dY8tk5HSmtBtQGscp/TFKCyC/KBwoj3kVGyLCnBywp601xMkFcZZsY7cr+EgMIMtZTbWFqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gZ+8j40U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zzfvAvPP; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 4ED741301B42;
	Thu, 12 Mar 2026 20:45:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 20:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362712;
	 x=1773369912; bh=WEn/ifGqMa6Ax93LDCMof9WVE/J3cBfFQIVVntI4FSU=; b=
	gZ+8j40UJfd35YHLEn8GltXBxrkHPPJuG8UzNQ3aeCppl0Bx/G/7pz2k7GhTJmjj
	mMkAf0dDw+XbG44/22ZHnC0JRrXwzH8q+b82+ON+NK+C1ecJu5I0G6cz+Vt/yust
	YtInsQcWto7IBJEOT8YxmPsZCQpX3QkE4fAQTc0qcS4tV0zoArACYwrCYiAcYuR2
	IU3IwRQR4aA2y5hgvfqRNgHlsCxk0iBegjLC050ZkP1ZyWpg+OZEQdX1QuP/ytZl
	/kpi2YCwgiIZQX+OdMfzYWmhsrdWZfMNXzIpSMtOnpwWF/EVPknBbGGcynUfDN8U
	DaCcDEvlgv1AfZcLYJmQlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362712; x=1773369912; bh=W
	En/ifGqMa6Ax93LDCMof9WVE/J3cBfFQIVVntI4FSU=; b=zzfvAvPPEd2RUPFHZ
	l0AGY0rUFybvZ//8GerfoYDoJ/RiOp618aTFUWOlyRcqPbjs+TwRL0gLxxsIgn9B
	9D19+ZiWTLY6YmJghBQ0EtLyi32bLsLapT86+x3V0Oyr4WcdSP8ViASeFCxFlipW
	+h2cuSFfiKsYtmGkwNjMFh5Wks22+oCYAhUFbfGjj9uat3x3i2ZjM/1YiaEpE+e8
	nv5myRHW2Ieskf5HzoPTOIZ08+j8wF95yGOTtnv4tZUYVtQggkg0IQjwJNs9fLnp
	cK+VOUlhixrvzRekBrrG3Sdeah9seF20NJJD+piNW3SbCTgj0k1feZCLF4BxGTMl
	+rclw==
X-ME-Sender: <xms:F16zad072LGVm4nNLtXOrAE0R4MHeFys17F8aeOgTGGFFsxEqmoKvw>
    <xme:F16zadwY6MqKqvxEVnzjXXhu7yGKdN8mP1ZYLTT82CbpvlqHQLwBO6PUewUXY56Z4
    w_T6uLZaMp1MNL1uJYJMMEsjNPZEnmlMzDtz_GAFuTpukfY5IY>
X-ME-Received: <xmr:F16zaU0dcVnke18uj6A9ullyKRr_uxRR96urzCzwQghQnjqU3W37o55JhZUAG9djAg834APpoywNrQ9x-erMjL6ihxt3rxm9oYrK8MIg3Qtx>
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
X-ME-Proxy: <xmx:F16zae7EsCLuKwBwXpUVK-Wp3nq9hST10o2DtFm4ZdVUHUDoH0CyuA>
    <xmx:F16zafc0zBIwpnROPq_jVe_3OyVNu6Wd_Kvb5bA0x0ZLMd_ZIBFK6g>
    <xmx:F16zaabPROXdG8W7YqgtteFTEoudtOzuCKNyVM0SFp6wLn5_edfCfA>
    <xmx:F16zaZFkMG282SjUNBy4FH7U4gLvxD_T1KDRXugWgu8krhv9pGNr4A>
    <xmx:GF6zaeGFHDmk1taakt1v2R44Go7b4oaB3SIGvOOEo_CQeTBJb9IsLDae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:58 -0400 (EDT)
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
Subject: [PATCH 30/53] configfs: remove d_add() calls before configfs_attach_group()
Date: Fri, 13 Mar 2026 08:12:17 +1100
Message-ID: <20260312214330.3885211-31-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20127-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1361A27BCB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

These d_add() calls cannot be necessary.  The inode given is NULL so all
they do is attach the dentry to the hash table.

If configfs_attach_group() fails, then d_drop() is called so the dentry
will be detached.
If configfs_attach_group() succeeds, then
 configfs_attach_group -> configfs_attach_item ->configfs_create_dir
must have succeeded, so d_instantiate() will have been called and the
dentry hashed there.

So the only effect is that the dentry will be hashed-negative for a
short period which will allow a lookup to find nothing without waiting
for the directory i_rwsem.  I can find no indication that this might be
important.

Adding a dentry as negative, and then later making it positive is an
unusual pattern and appears to be unnecessary, so it is best avoided.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/configfs/dir.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 362b6ff9b908..c82eca0b5d73 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -706,8 +706,6 @@ static int create_default_group(struct config_group *parent_group,
 	ret = -ENOMEM;
 	child = d_alloc_name(parent, group->cg_item.ci_name);
 	if (child) {
-		d_add(child, NULL);
-
 		ret = configfs_attach_group(&parent_group->cg_item,
 					    &group->cg_item, child, frag);
 		if (!ret) {
@@ -1904,8 +1902,6 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	err = -ENOMEM;
 	dentry = d_alloc_name(root, group->cg_item.ci_name);
 	if (dentry) {
-		d_add(dentry, NULL);
-
 		err = configfs_dirent_exists(dentry);
 		if (!err)
 			err = configfs_attach_group(sd->s_element,
-- 
2.50.0.107.gf914562f5916.dirty


