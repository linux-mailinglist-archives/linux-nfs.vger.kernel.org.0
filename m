Return-Path: <linux-nfs+bounces-20089-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OplLbw0s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20089-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:48:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4E27A46B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D03F0304306E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238738B7B3;
	Thu, 12 Mar 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iPWOSxqZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="unIU//e+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02961336EF8;
	Thu, 12 Mar 2026 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352059; cv=none; b=YH9JNGPeQAeQBIho8lm9PcgTFR87oBFJXrrb2UBZ3SZbOWdKajD+6tu29LL1bf+W0KhvSRoegDanMV37veeol59O9kQ1gkWcDAXoUKtGBZ7TVJIo1jLCfMh2K2IuJqKHnRJisFsi7YCg/3MZqvX2QQWBjWh6wgchn4gVUbuihGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352059; c=relaxed/simple;
	bh=3A3SQ2VrQvZNknUQ5qdDFG9Sap0OVcD2kF3Ips9VUVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf8K1xxIKwnr2U6SON7ElK95Cv9tAujFGZy4ARNUD9GD95BTAD1iSZDYvhPUNcK1LPG/ob4s+vtjp8Ok8n7ed97ycdWZyRsf9zzlzj8H6wmGTJidIXnn5kWhuvmK1HY2laAfx7te09f2qxEA5A84d0sUM8TsHAvQnFUxXxosGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iPWOSxqZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=unIU//e+; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id E848C1301B68;
	Thu, 12 Mar 2026 17:47:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352055;
	 x=1773359255; bh=IQfPF8qsPDD4y8gX0swga1hVwNgQjqyWwNEjHrIDNRM=; b=
	iPWOSxqZlSqyPdU6zTigaodUHhIuXMhwcY2p486hgesZ4N7bhchW/j7ATJHN9FBW
	oKMrqPBlqBMt3lkYCgSSFCKYXJmW9ODmThws66AtdxwYimzVfOz9cBugmFraUhdV
	YoO+Tg3MdlfJnhcIN9JfefQc+OGsJZ24NInAWQKWdb3ofc6nEyQw44fO+K1AQ1pL
	PckIAJ6PEuGLH3OUpr4l+1OppEhqfHtePP18EAfy8H3V1DfBdKsDc1LWDBmYxKsc
	1007QHUZL97zu3IXO53mSATagMEzl3Qlsr521UnNLtczRjXcqKEV2fA3ORrfY0a3
	MpOs5Xw5kf4wMfV1RUUcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352055; x=1773359255; bh=I
	QfPF8qsPDD4y8gX0swga1hVwNgQjqyWwNEjHrIDNRM=; b=unIU//e+8gYENP4K1
	FVVmPPrZh+cW9to8xynIOLL2gjLoSBNBWQceiEYqrtNCGzla1+3dWZUcITjMgi/X
	uuL46Ngko2u2uNp1O1vKehEFbTUjc4NkhiutBEF1BzxX5CZ/RVgo9uua3IfTb1U4
	NGa3YLqzHArKaIKtpRK98PwLIBxeoOcWX+A+OTTeQa5687EfcLW0m0JQ4OCHV0qj
	k505GHZtj/bSahn2aOVVCe3jQhaIxFFRjMcooWaTHAaqasI9A/H+N3+vQ1i3PxZy
	LueNtc+7viQ3EYAT0DTVcQn6YEP2Q1GLKATntEhtaDEKcbXPcerB8IzWARCsLvWM
	IvM2Q==
X-ME-Sender: <xms:dzSzadR1MAsZAitEgQpRqkE1Ohgad2kzGcH263o1t7TXTRgxjdqYeQ>
    <xme:dzSzaaddjVsxxqrJg6cd61V4ey9u8NiPzMREsyhWiuAlorEYRpPofNSDIMwtQieXj
    imi6hPyKXjSImt3TlbHBCxZzDmVo8J_ehFyBdBFkz1_tFAlXQ>
X-ME-Received: <xmr:dzSzad73mhvPgvYL751N9h1IuqZDC9qCfyFWvhd2UO8UNcD9DN87JGATxBceAdvuqD6UcBlC44Ws0fF9LuFEhaLI_3yzuN6FXCQu9kMzkMg6>
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
X-ME-Proxy: <xmx:dzSzaSfdzbvlo8FTUtQUSZHaX9m1SDibKD-faF9-7T1qyLf0BGRfRw>
    <xmx:dzSzacBQhEFOtMEi4Yv-yULYFv_4Nk0yU79ngB4PUfLkpukgxYwauw>
    <xmx:dzSzaWFpFURMotSUNpKLQepIDtDYxPIhrb9wtRHKaYgRNylCCa9-YA>
    <xmx:dzSzachcP-QQRCqfvyqvZXN2FVihxCh2TfPpAiVTFvwqP43nNdJpFg>
    <xmx:dzSzaUsQ6Hj2-q3E5VjcI00qQ9mNWzPtWkKoAtnPKz8E6T1iivMLl0S0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:22 -0400 (EDT)
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
Subject: [PATCH 11/53] nfs: don't d_drop() before d_splice_alias()
Date: Fri, 13 Mar 2026 08:11:58 +1100
Message-ID: <20260312214330.3885211-12-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20089-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86E4E27A46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

nfs_add_or_obtain() is used, often via nfs_instantiate(), to attach a
newly created inode to the appropriate dentry - or to provide an
alternate dentry.
It has to drop the dentry first, which is problematic for proposed
locking changes.

As d_splice_alias() now works with hashed dentries, the d_drop() is no
longer needed.

However we still d_drop() on error as the status of the name is
uncertain.

nfs_open_and_get_state() is only used for files so we should be able to
use d_instantiate().  However as that depends on the server for
correctness, it is safer to stay with the current code pattern and use
d_splice_alias() there too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c      | 3 +--
 fs/nfs/nfs4proc.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a188b09c9a54..f92ea11aea44 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2330,8 +2330,6 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	struct dentry *d;
 	int error;
 
-	d_drop(dentry);
-
 	if (fhandle->size == 0) {
 		error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
 					       fhandle, fattr);
@@ -2352,6 +2350,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	dput(parent);
 	return d;
 out_error:
+	d_drop(dentry);
 	d = ERR_PTR(error);
 	goto out;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..a4ee0c0b4567 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3099,7 +3099,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	nfs_set_verifier(dentry, dir_verifier);
 	if (d_really_is_negative(dentry)) {
 		struct dentry *alias;
-		d_drop(dentry);
 		alias = d_splice_alias(igrab(state->inode), dentry);
 		/* d_splice_alias() can't fail here - it's a non-directory */
 		if (alias) {
-- 
2.50.0.107.gf914562f5916.dirty


