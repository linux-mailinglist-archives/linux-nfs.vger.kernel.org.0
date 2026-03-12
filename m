Return-Path: <linux-nfs+bounces-20130-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCN9M+Zfs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20130-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:52:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEE27C05B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92A931B7D49
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F630DEBA;
	Fri, 13 Mar 2026 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gKwSPNrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBx8/it3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC5285C8B;
	Fri, 13 Mar 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362767; cv=none; b=i28lY795jQCO2UpEXNGDXcYzxLLVUE5AiW012alI9lqS7/A+pPz/M0+ogv2ZGjlHQ2Q3vAVwPW+WZVE3pWkx9sEzOd4/DV9ZQ/IWX/QF9o2GY2e9DHt+sydDx5jjhtJQsu4eljeZcS5wXGu1vxQU9OtQyWTSs4HKHNzKtkPVhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362767; c=relaxed/simple;
	bh=rzAkLHyrQaOfugKPiq7TWkHZcHs6kmsMMapDc7O/Ysg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBEbrdJhrVrIE7phvT5Cq/HI92JgYXUhW25rhrz0ToauXVCnrPcKqAfecn7jfI+d5RjqR2tkvyzbjL2P6NzQLThiZDdgVjoqF6ss7BdYeajhhYhBF00WYC5V72C+nCHEwNblkfR//ab5bJAYPNHTeP1JvGjv4/PK1bfGOuShrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gKwSPNrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBx8/it3; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C57AE1301B4C;
	Thu, 12 Mar 2026 20:46:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362763;
	 x=1773369963; bh=PvJJgAoi6+6/iAinwR5eAmiVL7AkcVBlOABk7/2rYco=; b=
	gKwSPNrDp/Lh0K2AdmDPuP81x/xKJYynieIS613cuyIap5TJBGt5zoBJQkcnLx+P
	wIIpre2IzG82z5AyDZagtjjr4EtLFHuY+3ew5fDab1/yIPB/uUEieMSrkA3SAGQh
	0hw7ulI7fDK+6bhU0r4qO4EEemUcLLydcBXxhaWveI05xHIYigrT2kv6HGB22iDl
	Pm7Z70iYJsrxhQm/lNa8SebZsdmRrivu1M2XBRDOdTP/LlqHocEGRvESnBiNX92B
	JLUzL7W8K2qPLuHSJfmCX21NPVd1NhNhOrW+1abIUaEPZHtwCQuWsFmoxcxpcZoQ
	s9OP3WR1HmclPU7UtiAU5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362763; x=1773369963; bh=P
	vJJgAoi6+6/iAinwR5eAmiVL7AkcVBlOABk7/2rYco=; b=lBx8/it30WvLfM1Ut
	4V40yFC8YMQTxuozALmQF1Kz8GrZRjYHh0SEma52k1oUapkTo/R08AT0F53b9/VY
	xdwzYS7PxHPQqsugkTC7WGac+zdsWTTGVKW6btlA+rILgtb5JxhC04Vy/65L2Xdv
	gVJcdhH41QdzdnSyemJSUkWvzFljqohC48EoOSDQD2TO/gvb0ZljX3XBCb38KUN/
	K+Vr6CN7cP5atIEEGvmRRks84tlmL3uGXzUXmKCpw01j5H5hJwsVnCDxu6xxFoYd
	SqpnoXrKs1sjPLo+NcbXGxHzrmCTuu76BPw50bfweWvA1mDAr7hV9ogvlDfmv7zI
	1xFmw==
X-ME-Sender: <xms:S16zaUATOTAdUJHvPn1j8hALIFcGRTY7CqUc16mh-7kpVKdUNqbudA>
    <xme:S16zaaNsN6WULJMEZEYNHEfjGUNLg3TOo3eaDKIpm1RTVN3yGVRWZAvSMGgaIa2it
    zCE8_z9EZtPihlV_knN9gyoauJDoLEX_bOdCZHU5Lxo9MKjdNc>
X-ME-Received: <xmr:S16zaSrByZrWq7H4eUim4f3MNHov96sAFzfyid3OWyvok-ilizmXdhDBXHbVUd_PivqzLTCOghaD0LUru-wo-Mt2CSaRzfWYgxwjiDiN0QJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:S16zaYPao2XJJDUhQdklcQ-SsDGTxjCkGZDxZQnFX_-wWOM18mzM3g>
    <xmx:S16zaezYESx1jpjLQkq2IsSCH2hcX8BGl2KDNnw-JHk3TIaPIkf8aw>
    <xmx:S16zaR3sP_vaX_rkdTjpttWUBD6HoQ2X8iZG1g7atODF1WCyli2TtA>
    <xmx:S16zadTuHaCPpH1HtOdIocFwfnH-uWVUynbgpiYtByM0WOqO3X63lg>
    <xmx:S16zaSPV1vYMjAglL0pfAPcfhz6A-1ky5mxg6OKIh6zA3xacPhk5bBc3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:45:50 -0400 (EDT)
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
Subject: [PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
Date: Fri, 13 Mar 2026 08:12:14 +1100
Message-ID: <20260312214330.3885211-28-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20130-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EAEE27C05B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

atomic_open can be called with a hashed-negative dentry or an in-lookup
dentry.  Rather than d_drop() and d_add() we can use d_splice_alias()
which keeps the dentry hashed - important for proposed locking changes.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cecbc0cce5c5..361a20987927 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -439,8 +439,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 			goto out_err;
 		}
 
-	d_drop(direntry);
-	d_add(direntry, newinode);
+	d_splice_alias(newinode, direntry);
 
 out:
 	free_dentry_path(page);
-- 
2.50.0.107.gf914562f5916.dirty


