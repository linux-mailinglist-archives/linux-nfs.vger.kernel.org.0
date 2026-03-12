Return-Path: <linux-nfs+bounces-20099-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA5LCv83s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20099-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:02:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFD27AA93
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B6532157E0
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E338B135;
	Thu, 12 Mar 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LvUkteWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJNskYCq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82838C2C0;
	Thu, 12 Mar 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352508; cv=none; b=nVA4uhkf8lAaJqxbKAXSpFy8bcyQW/OhW4DXqC/GoJFL3QANkYaUouXHorbLpP+dMcWyokZhunOLerWG062i6JzhzD4HrkY6cM+4AMZSaZ2cLpXqpYuF2lNyRA7fnjh8mluR6d+SAQheLUU595p18Phc2tM9omwsJwK70nrqt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352508; c=relaxed/simple;
	bh=9VTSF8yUpjoy7Ucs3aGsu4bxlj0Czeu92BoI1xPbgH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMgT/GzU8MuU8qwcSS8EbXz9lhBv8mXmoTn7RtEjMriMXrIGWJWlOUCoyPXb6v7uip6a7+ivkPWosmxlcEZKO7hEWg077QidMJAK5hR3JRQ/4Jp5hncH58RfffOg+IkJv553UlS/LTX86gSzEBM3JIazKGqAhW/2LpUvZVUVlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LvUkteWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJNskYCq; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A5B1B1301B6A;
	Thu, 12 Mar 2026 17:55:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352505;
	 x=1773359705; bh=QdLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=
	LvUkteWZCDaoWYqvI6Uisnfitx8+ggZ7C+jDVARmw4MfgDHjnDypqJJX1nPL95Es
	Nag0d95y4bOlXv5m+pKizu4jWh5ahcynJTeDGkIUolBj+IgzzhsyXjFo2bfH0Qyv
	tKaQT582rw+TPUHzjlFD/YzofmzYyhPIuVAyhZa+ANuqDH7cXjyaGIOgEiIAmPMj
	/yBD02o3rX20ddAj2X9Lja60A73KqNH7Vbumy6bJPWqkV/J7oJhkcQE+7e0oY9oj
	8yrxJYAMSoJ2oQnH4ii8XAtCwFXq0JdtQ+OZyBx9LBztC94estrJlQ7Fb2RpHNci
	j9HTBYX57sNFqJtdD257YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352505; x=1773359705; bh=Q
	dLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=FJNskYCqOEZkh+b+X
	kjQKFHwDK4nlkiMOH79i49kx6oyszytp/7cRmbQdR4TG6i+WX1zSfAfDFSj2Y1NX
	urfJRQbAe2/ZivP8ZlFzYw5Xx4Tjt0gBM+SYtqpX6Kgsv306S8wBnJ3NPxRIo8Gr
	U5NJ5syIF6Ijl8lBWd3BsfXtGZ4Xp0xg+1uBM5qufDdgQAu95mr5nsWl6MMtoXlQ
	/0yyYgynJbthg1j1IiLBfYq1sU6SKAay8XiDekf9/sJ9Swz/so6Zcq4L7c2DgnYV
	ED/qOoO5zm9sFslZ6prlPbvaBfLftMXMK7/uaBYc2tOu/H1h5F+TOPuSFUXn/JDI
	t0ykw==
X-ME-Sender: <xms:ODazaQF7k1KATwaGFlcBZZKpfc2WG5qJMk5fnlfxm1Vi7B8CBF9F0A>
    <xme:ODazadD_2IL7856JUXB5PVFIBNMwA3rDwgll_qpc4ZhOz7e-JQ0NuRoov0eB42WUc
    EF3bvsNaNg3qYNH_6PwXS9evSOT0CwL1GdwzFrQraqer4PE>
X-ME-Received: <xmr:ODazaVPZS9YqF9ZefzQt107DROar1zD2G1yJvDbPvT3o3mATZ6mSjon75F5jB5LVrojnzHvcAo4afzSenxq3zbhqdyMRDGucrx4hX3BDj38C>
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
X-ME-Proxy: <xmx:ODazafj5iHEVaQbQL9xUSPUswOF968qjB-7fYOVT8Wqivk1HLaeLDA>
    <xmx:OTazab1bv4yDY87VbPr_S6wN9LMoF8mSMxvCKipOcZJol4AgbiLq4A>
    <xmx:OTazaRplVN--MsA_JdAYXWXr-dyaNK_CIRfy2b-VOFGs-cHK8Mzl1A>
    <xmx:OTazaY3AxBB1DDvGyksBA06N9SqB_ZPRuIzdc1Nf4sBn6Jnxpg8YxA>
    <xmx:OTazaQQzPhe-KJWsJjAclLfJeMdfP4VJ_ZU2q5xz2RTb5aOEmQxLEFQB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:54:50 -0400 (EDT)
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
Subject: [PATCH 40/53] gfs2: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:27 +1100
Message-ID: <20260312214330.3885211-41-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20099-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 80EFD27AA93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in gfs2, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/gfs2/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..9997fbc1084c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -988,10 +988,9 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	int error;
 
 	inode = gfs2_lookupi(dir, &dentry->d_name, 0);
-	if (inode == NULL) {
-		d_add(dentry, NULL);
-		return NULL;
-	}
+	if (inode == NULL)
+		return d_splice_alias(NULL, dentry);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.50.0.107.gf914562f5916.dirty


