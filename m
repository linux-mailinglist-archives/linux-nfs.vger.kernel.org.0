Return-Path: <linux-nfs+bounces-20098-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KbFNkI2s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20098-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:55:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531EE27A71E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB55306A3A3
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939D38B7DA;
	Thu, 12 Mar 2026 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="R9VPv/zi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvCNqQrx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E602317142;
	Thu, 12 Mar 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352489; cv=none; b=H1jtjsANCG6WnO1Nqx7BUxuWKWZ4wV5mmh9DrW4UejjDTT9NcGptdvFLryTgpRmnUKQsE9fCflJH3ySecpKNAJRBzMAjxzM1syrXtXbE7HAjbGz8JrnpNbooJ92B6czZ9rhzw0PJgrXSsYELWVCbR+PMSsX5Vt/P+DxqouNrFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352489; c=relaxed/simple;
	bh=F0lJe9mu/33crn7zFR7KnLT88WZWwFKdTtxGMeD90wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5JuLTdaCNfHMqfkxdOFSif9F7TaYcAfDkT+F0EoULo0UKlKF3kjlvsy32qiGRHYqtzqXuJfYAC1GJec8K7d6k7uXQfEFALK+9e6pZUoOFn5CcOM1ZfLZWgAOKgbFcrqUe9JYDeBIwJhXAO4rC6tcOMqcbwHTLhsAR4ZuZJxMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=R9VPv/zi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvCNqQrx; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 897D11301BB1;
	Thu, 12 Mar 2026 17:54:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352486;
	 x=1773359686; bh=fpyBzrNDFKyBNYiy64/Yla5qtyKgmTDryIXyDQiUsjs=; b=
	R9VPv/ziHvarZw/AQGr9s/6SlcupzBGjtLFg1jEyRvdzFV/RJz3QlbiVW9PogxcB
	uq19ftZqv/w/QB+pWd/PtWQzykeuu9rN81RyybCP7p3uOes5ycCdcxkqVLcaFgPt
	GbQUYu/U5zZS8o5E7pQfGKiz957WUj9u86OrYOiA2bVJEDZlUx7NES0TytyApQGj
	x/jLnyCWW18lBbJSw9b8gm5gl/mwwM9pz1Dw/lA9mL8IRMxgFcmDqjLK7IMbs3Gc
	bPfTT5o+RFQFgP29SGUNKI8B7dY5Gskl7wM8hscfVf6RYD+N5EHvFqkJI112v06w
	cZ0Y3KvOZIJXTgIefJVRXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352486; x=1773359686; bh=f
	pyBzrNDFKyBNYiy64/Yla5qtyKgmTDryIXyDQiUsjs=; b=lvCNqQrxDQEkh9EE9
	DHdnoLQKJXZuHP0lw6gbA/RNYrUbKF152er2Ht3nW70QAjga1J49zCLwHjK2p/Y7
	BJswoCBt0LZR+bUq+QMqYPbhP8R3Xp09DwafNs5xNgE3kD5ZV0k+BJq98zKU9Zqj
	sFQJ2d+d7F/KRlK06Vfv/0SRfilvI/OTiBSxO0HngUIpIhxrNM9wM/PFIIuR7uOL
	15ONu6WzjQxb92eSo1if9CPu6HIkyIhlPYQFlroJS4Yn9zoLdn+2uv3griNSBuSn
	VQ+9fPyb/vhGnCvTBIdeahqB7kgmyUz0Xfp3NYe+xhSZqP+PK8CIlW8j2sDwrak8
	c88vA==
X-ME-Sender: <xms:JTazaaLTXPY0lW_r5GxWLpYSTzZ5XIG-MUtCmLGSJalAt0Jxt-kyJw>
    <xme:JTazaV1ioHfFOkoiSkUr_kki-xWQBmOgK0GpLQQ7JwYno7HKD4ZqE1m0UTqHQY5i2
    BikshymDZavbsnTX2xSE1OYswjqxBYqIrl1x3oSfq7smMuCiQ>
X-ME-Received: <xmr:JTazaVx9t1HsoGNgk8X-449EYfPcde2N9cnjcQzToEYKYavNbdKMFm75TaYUFpRbM_tgRnvf4IFotsd1JHwWkuMEGOEvbTp0lKedo3rUiPKc>
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
X-ME-Proxy: <xmx:JTazac3nCbojWLHfcxWBM7ihJmqwG17cby5TrKLcC_09xB10S5Rc8Q>
    <xmx:JTazaW79rTcZoSvXrQoLretwFpAtB_DfWpj5iEv7u5-3O75zoLz2zw>
    <xmx:JTazaXdDYJlOMSReScUwwg6IU3z-cDWKKve-4kemj4-Cof71M6Nm-g>
    <xmx:JTazaSb8VZWu5_vRWHgPSmkV8kGIrlJa9-c-i9_vxto0G-p2SRPELA>
    <xmx:JjazaaU3cuTt1axgUaJnB0tCd7dxg9-0mSMffoYD0j9ht90DvG8qbNQg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:54:32 -0400 (EDT)
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
Subject: [PATCH 39/53] ecryptfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:26 +1100
Message-ID: <20260312214330.3885211-40-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20098-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email,brown.name:replyto,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 531EE27A71E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in ecryptfs, but as
it is planned to remove d_add(), change to use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ecryptfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 8ab014db3e03..beb9e2c8b8b3 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -352,8 +352,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 
 	if (!lower_inode) {
 		/* We want to add because we couldn't find in lower */
-		d_add(dentry, NULL);
-		return NULL;
+		return d_splice_alias(NULL, dentry);
 	}
 	inode = __ecryptfs_get_inode(lower_inode, dentry->d_sb);
 	if (IS_ERR(inode)) {
-- 
2.50.0.107.gf914562f5916.dirty


