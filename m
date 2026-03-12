Return-Path: <linux-nfs+bounces-20123-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPFfD/Jds2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20123-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:44:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A427BBAE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443BD30804C5
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95A3093B5;
	Fri, 13 Mar 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eCvS91w+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOKUtq/0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430928690;
	Fri, 13 Mar 2026 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362647; cv=none; b=Tv7EOj2vf/pP6n7Z4RcMZA6cUWKb+4CoAFN0SQdWSEZ9biGeVJ6oI47Hv/CMJlH4T3DRPLAmN8FHvX3SyJ1G54qBOb8tc0Vz8Cqsy1zfOZl3Rod+LHsXDSc9MbKL2ThMzFgAcVouig1MJzjyIbNrAVib3Lo6xzqoikj7w/T9xYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362647; c=relaxed/simple;
	bh=HQ/V/boL1lWC2FAVdkM1ZhJgQQuIPa3WWx+sWxg3L+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfqI0IIrVIuq3S3kKYYSYM3mUUbusTXyavQropREz/+//u9kyWVM9lvw1SEuiVSdGZMFCemjzAwdghdray1GeFWuJcF27jT8kZH2JigPpOgSkaXhDnCle9svMihf9INPIu4y3UK/Wt1S7SqivcPNt8OjnScS2O68heJi9SvnFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eCvS91w+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOKUtq/0; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 9997B1301B2F;
	Thu, 12 Mar 2026 20:44:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362643;
	 x=1773369843; bh=j63R+vGSqFIeC0SCj0jcb9BcsciO20wok4YExEEnIuU=; b=
	eCvS91w+DhWkcI9jjJdNUADcxRGhElzytgMJasgIzKJtuooXaIh3KKja0pUFfX6O
	fgYAReRrX9HpVO7F12hftQ0cSIl24yo01gvuoWwgQ+0LBkoLFsR05RvwjsbQ/xGe
	TARIB8LZx92xUD+U+XYJVZBaPlMp/mwNUr6o9DINS6+42ydzcFDjycZgH68WWE6o
	C3GjVtvxBt81M8NGL0of9lLYsOHaaCljR0612e0zlQfV27RuAQZNtF61tH98aa3Y
	SztxAesntkfAUiZ3e07BF5twMFIeG7LcYeif3ZUiOH9o5O91dPmpaZ9mcvHyC7F5
	pzd5Q75S3kEWTz9D7gVIYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362643; x=1773369843; bh=j
	63R+vGSqFIeC0SCj0jcb9BcsciO20wok4YExEEnIuU=; b=VOKUtq/0Ox3dCym8N
	La/hchRjt+rNU/iyTLG4kwEHuMKD4y3a/JkwzJH9LuB11f5JIetBBVHMt9ViJypU
	UjyLlnUHckM8bh9QjAY4Jyd/C7N5jwudw1JHDUa9iXFd7am+GANyEnLlgi/obehc
	ULSfiEhaSLtneM7w7UNW2TpbgbwcaZ5Y83VVFAz+dm25dDXamEX/5/azTn0wR4rH
	T5eikG9cF+xC+X5DUfa2srcny2SiEQpjWf7Wv50KDnPD1IC+BRLh5gtaUkd0Xqxn
	q7lCrpBBSd1OGWFQIKyOZeBKLnQT8rrdPD3KtmKkTnMRm+b0/M3MehJ+STL1Wogh
	t4YJw==
X-ME-Sender: <xms:012zaShtjFWHYv9HOGnqTxWKzw1vnA7StjckJwiN2A5XojBB-F9JCA>
    <xme:012zact3Dt6TPh_zjEgrQwDsyr4DDxrfYJ6cn9riTs_e14ePaC1C59ywk8575wtIx
    oCoyXSmpvc2QJ7FHiKkN9vyQBEYv-8vxOZoFw9Pf5SKSJTBfw>
X-ME-Received: <xmr:012zaRBDZsBNJH0PilDgngT1D_tzQ8ozHN_bDcdw-FMo3b04ruKTCh0syXRWeolXCoApwXWT2_5U1Kk96nnuomeQn0TR05_drdDWBLwveY1h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:012zafUKwyL0OuJClu15Puc2ys4KgwTiMGJwcET4JsKEaucWrW0l3Q>
    <xmx:012zafJP8iVeo9UK7ccWbWNQm9a4nXPYhx2VbUK7ny3vfppuOu7x9A>
    <xmx:012zaYXOH9KU6qbd-du9diTet8tT6m4DrmZSp1YTRJNc9aQpNYykwQ>
    <xmx:012zaYRD_17YWDi-EKB18x17U_SFvVAUAN1Enot0fJD4HVRO11zFbw>
    <xmx:012zaYIlDd2v2et1x5yz_VJ7tc4OmMkzO-PwjDx9T6vNixAjsjCKsyLB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:49 -0400 (EDT)
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
Subject: [PATCH 34/53] tracefs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:21 +1100
Message-ID: <20260312214330.3885211-35-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20123-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: AA8A427BBAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in tracefs, but as
it is planned to remove d_add(), change to use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8e5ac464b328..c30567b5331e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -393,8 +393,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 };
 
 /**
@@ -424,8 +423,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	dentry->d_fsdata = get_ei(ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)
-- 
2.50.0.107.gf914562f5916.dirty


