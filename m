Return-Path: <linux-nfs+bounces-20104-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPi5Aes4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20104-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:06:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBB27AC53
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D95A93089894
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8192317142;
	Thu, 12 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BjVQ7Tij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpiNzHFW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E742BCF5D;
	Thu, 12 Mar 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352594; cv=none; b=lAFoLy4LHkA0PqKJY4cC0t0309GFAWPAmyb3nVjPOqRXUKJmuL76855sq/D3Ck9Q+tsBbIOJ4OD3WgkuSG12v7NWlgPHi0teuH1qN+33uVO5pz+2gG5k97/2mxt6rJ9frvDwjFiOWsW1V/YVFkBrBT51gS4miJtteKBJ9LA/+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352594; c=relaxed/simple;
	bh=Ry03XapnV8ZPqRwD/otU1U6sq93iLJCjUmdAQ3JSF0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKI8N9HQvQFeI9jGLO+Rrc7tmWB+q8atmJ7L8sq3DkL40T+JqDNjwatgVyoTgdx2mEESTb2ENXtUPxk63o3685bwMoboWzV4cgCIDl7lmkn07+RmNtgfAg/EdilFIpjZlHstC3HcPa8kknPeg2vL25aFST7AYtO+MQhwdv9434c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BjVQ7Tij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpiNzHFW; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 84D321301BBF;
	Thu, 12 Mar 2026 17:56:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 17:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352590;
	 x=1773359790; bh=V1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=
	BjVQ7Tij/z0cXHesrQNauBD40mf05TL+Wj6m1LoIvu1L/NzpAqGZ5cLMMYGVnhHH
	5qpQy4Dpm9bq8Pb3bQ7SLoPEAN90xLCEzbpDBw32FsuGAR+9EIQaGhiqQ98SwOaT
	QOjIC4JQ26O0nUw/gfHxixp9O2LeLOAfcv7ko1la8I/jwje3ZAcm/+yUWtQegekd
	SEaAK9AahEsg1k6Lo05tjFqkn7nUv2p2kEM2DQJCJhauy4winthpmj9pCKsDjw+g
	LbL1Ut73HTaiBOaqfNeCA2hdtVcLqDwM9vhFb2A/Gp+vNDKEnvCIcGUBnuRQC5w4
	c1vlq/YTLJZHkxtZdNo3ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352590; x=1773359790; bh=V
	1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=YpiNzHFW7/D9ZPSMi
	cZJKUNBZwgvwypUiNaP/NJM1ssRQhwagO51x7MSYiJEweucl/LQJMa2SKCpn9TMY
	zKHk3Y1z+6lpK6TbV+SLBojRbVgzqxTumBjH8yjZlwb/Pw05pMeeuDj3VQASKNMH
	JI1m/tgCDLltyQqPzDgUlE9fDYaQup9pOGAFgK5F8pGZ2h+PJQKg0JYnhCf6Anpd
	cMP+lNg8R98vHR1s3CC4zCU3o+z2qTy8ZvFno6N0EEpF2DC7MXEjoQhGkqR0/QDv
	RkF1A/8dkZ52tjjo3Ye102S9dNRb2q+2o8wsWe6EZ9KjKj0zQND+rl+xPCwoT4um
	OVbAw==
X-ME-Sender: <xms:jTazac6FLGNVN6mYXBnDf9SGBJ-5AaLarvcOU8zCdKM-rgD0nm37qA>
    <xme:jTazaXkaZi6_Q0Jm-lBvOu9zaiUvR22nAfEL3fp-sBQlrI8G_kmh7gL0ayaRInKRk
    XZIxzM9PotaAMQ3cBeWj4acBkT0vf9SDWm_3_E5WG_nMyTpIg>
X-ME-Received: <xmr:jTazaSbbRo76-Cc2ogkQrvL-OPYQ5JCvn2bqCYzr6nvGNZAfbGpbGDH8PFUEvXXPdJaMLQJOCbVZDerV-oar65urrK5fVyegZAnq-kIPqB6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jTazaVOQT9zD4viTQ4xyy0f0WkaSFD_ev8WbCWz_uPQ12WavoQ_H4Q>
    <xmx:jTazafiMQd2syhHGHNy8Myu4LisMaLIGGQkEyIGzYQ1rYsquHpExpA>
    <xmx:jTazaRMuOIUcjmRzCMyCCRij3jggwxOGlKVoNhuEHX6MGQkKuIhy1w>
    <xmx:jTazafqGIcE8OMyW4BiXoDHDYQOqT2BRlWtBkIn0WX7qznzvPQMgOA>
    <xmx:jjazaRA3wD6VQKs5bEA6Zod3_QakbUuuwwdoM7KaYYhvXHRdFmZWbWeV>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:56:17 -0400 (EDT)
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
Subject: [PATCH 45/53] efivarfs: use d_alloc_name()
Date: Fri, 13 Mar 2026 08:12:32 +1100
Message-ID: <20260312214330.3885211-46-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20104-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,q.name:url]
X-Rspamd-Queue-Id: 1CBBB27AC53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

efivarfs() is one of the few remaining users of d_alloc().
Other similar filesystems use d_alloc_name() in the same circumstances.
Now that d_alloc_name() supports ->d_hash (providing that it never
fails), change efivarfs to use that.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/efivarfs/super.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 1c5224cf183e..232d9757804c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -189,26 +189,6 @@ static const struct dentry_operations efivarfs_d_ops = {
 	.d_hash = efivarfs_d_hash,
 };
 
-static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
-{
-	struct dentry *d;
-	struct qstr q;
-	int err;
-
-	q.name = name;
-	q.len = strlen(name);
-
-	err = efivarfs_d_hash(parent, &q);
-	if (err)
-		return ERR_PTR(err);
-
-	d = d_alloc(parent, &q);
-	if (d)
-		return d;
-
-	return ERR_PTR(-ENOMEM);
-}
-
 bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 				  efi_guid_t *vendor, void *data)
 {
@@ -263,9 +243,9 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	memcpy(entry->var.VariableName, name16, name_size);
 	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
 
-	dentry = efivarfs_alloc_dentry(root, name);
-	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
+	dentry = d_alloc_name(root, name);
+	if (!dentry) {
+		err = -ENOMEM;
 		goto fail_inode;
 	}
 
-- 
2.50.0.107.gf914562f5916.dirty


