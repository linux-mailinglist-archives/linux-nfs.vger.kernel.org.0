Return-Path: <linux-nfs+bounces-20091-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJVZAHo2s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20091-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:56:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD827A7B2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5012E3099418
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B983822AA;
	Thu, 12 Mar 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gWllsYQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1QbTSibC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63B336EF8;
	Thu, 12 Mar 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352094; cv=none; b=dFfUGgp2vU5IXFec/6mc7sUlogsHMdOqStNj9N1sf/IfGlgoF6IxHt0muhiuLq95iYcH086DcWPEY1/51izuscDG4KjHNY737dg/nlU+6KKU+SVPZ97xC9JZgQWyTgXfj+hfT5RA16JVHhCxnIbTwTLKvnY+Fm6EHn8lEbsYi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352094; c=relaxed/simple;
	bh=3R9MICHq0tfiVHVQzMt10rueJlsSKnW7TiNT7x+P6Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRB55/CPSsELgKm7mCRcn6Dgug5WXxb13pnhr1l4yeYFhBT34M/ybEE9TobfbfNIgcEyX4ajKd/jNloVvjDE24s4PbRIcLq3NnMQTOCqJjlaUAdY6YE2F4dumpPO3LJrUk2OW2EQhdzGyWZhKWt9Xrwpoj7flS7fxEmLDbYi5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gWllsYQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1QbTSibC; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8543F1301B73;
	Thu, 12 Mar 2026 17:48:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352090;
	 x=1773359290; bh=MvjNqMKuVfQXHETrd+SGIKnCs3zts7xUVvm6x+LJmMI=; b=
	gWllsYQz3mEA2jMLnm1iwaOv8Tt2H4rwH82GHyjMfv6YepkAwC/O+UlfXVfbC3Gh
	ueXZPPOdpP3xulQmdZxxRVEkFxYyxx1ToDvVC63ek4y3nTDYVvkpfStMyiWXmkRd
	fkV9Df1xtegee+SYwTvZ8ujcV1aIlaL/awlKX+BcG0Qy+E7hBOfTsK1E2FpVwfZb
	Vw3yFQe7/OT8j6qNNCNsEA/sLbaT6S6m75UO8zkReU+Ny1GbWgEtJhfqf6Uy/dYX
	f6TIaZrP86TA/nECvJCJGfBvL9fVuJt+rupymlKEQmgPDG1sUGlgOyjvy4Q7yJGg
	N49aWqF3TFatF7EmhXk2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352090; x=1773359290; bh=M
	vjNqMKuVfQXHETrd+SGIKnCs3zts7xUVvm6x+LJmMI=; b=1QbTSibCpARDuoZ6a
	qBXGjBjG605a1kHrNXvGK2EDNgsNPebEmS0LCdfNycqiJW6y0XS72nIolK0QQgb3
	avki+yt5b3Qw4JQ5Aiu5A0r9FpQyj53k7GLhjZjlDieFxsRZhCYDzg/XlL36uRAz
	xHyrzP+wM7hlc8pcCvwvMYp8CZN7trtMnqEYqlMPs//4+h82amOGnS6lWFiXkTCr
	uH4ivBpDr4UYvERMqaIkvGkFoY5bBABprE0gB8RiuuaAyw17fvhlnIQvyWkqA0ag
	/3wU+iBXcux3YEyHDjuwWxUXZCSejGgN90VfAIrEWw8qHqZlW0e+7y9VpWl90OSn
	VpvHA==
X-ME-Sender: <xms:mTSzaTMq5K60rU6cQKTE4ltFtN0CJcOAU6zQzi5FuWd3zaaUn8RVIQ>
    <xme:mTSzaRqEsiyGu_hKT-Fp2oH51ktCB8pg4nqZq6zxhvYljhmAyjh5J9f9dIMGkeGv2
    XhGgZfdjmaVokbdcWDzjqGbrjfWU0eZqx_S6nQbxd1mtn9bwA>
X-ME-Received: <xmr:mTSzadWo-7RKkvLyBkFudwvdVKVHK4isFSTvkGvotGQXacqyRVCvVfvu1NEU9OE_VDIArw0nEtiNv8ybgnlfLu1_gela1Nklf26-X-ak6hPh>
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
X-ME-Proxy: <xmx:mTSzaVIgqz51Nm5JsM_w7hIEuFEq9JdQ8WgB1rAT7sGtr91W5_9HsA>
    <xmx:mTSzaQ-MtvnKnY3GHEDxVW_5M8jtI1V_aFkLJg1Rag302qusRR447Q>
    <xmx:mTSzaQSklQHpcX-ckFXWIpQpzolsE76loXqaTnlY_baq1jY3gl55Ww>
    <xmx:mTSzaS_GyjBaWwliRP4yLwwkikJ21AjNWue41eWkCymfbB5MYkDNWQ>
    <xmx:mjSzaSwzj3T804JPxGf9ZWy1K_G4E3_ytYG6PGglCn7sLvYucJECySvG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:56 -0400 (EDT)
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
Subject: [PATCH 13/53] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
Date: Fri, 13 Mar 2026 08:12:00 +1100
Message-ID: <20260312214330.3885211-14-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20091-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 08DD827A7B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

NFS uses the results of readdir to prime the dcache.  Using
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
 fs/nfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ffba4de3df01..4b73ec59bbcc 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -750,15 +750,14 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		if (filename.len == 2 && filename.name[1] == '.')
 			return;
 	}
-	filename.hash = full_name_hash(parent, filename.name, filename.len);
 
-	dentry = d_lookup(parent, &filename);
+	dentry = try_lookup_noperm(&filename, parent);
 again:
-	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename);
-		if (IS_ERR(dentry))
-			return;
-	}
+	if (!dentry)
+		dentry = d_alloc_noblock(parent, &filename);
+	if (IS_ERR(dentry))
+		return;
+
 	if (!d_in_lookup(dentry)) {
 		/* Is there a mountpoint here? If so, just exit */
 		if (!nfs_fsid_equal(&NFS_SB(dentry->d_sb)->fsid,
-- 
2.50.0.107.gf914562f5916.dirty


