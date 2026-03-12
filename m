Return-Path: <linux-nfs+bounces-20101-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EDcEFw4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20101-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:04:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A8A27AB5E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700C3325AB5B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9593B5832;
	Thu, 12 Mar 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QWDEme8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uCftpOHJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B343AD517;
	Thu, 12 Mar 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352542; cv=none; b=bILxFQWpy904ehiuOFumsvOjqfzL4O0hszfW0KB7fwCDVRUruED4/kmYk6RZ7MayYODxb07s12bk/RjKVtSr5J9atYS6v1bFIlUrHtLMUqvm4KPrrSEC17Y4F43HD8OSs35MVsH6TIFNGC1M0tkOg7Dz0fakFYmNFJLJOs0KSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352542; c=relaxed/simple;
	bh=vh2aDCEgfp3FPB4dEbyu1s2jF3bkIa2ejltwYp1QTPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEa+yq5QiIpQrCfnC16/LoVNYuek7YDbWT9wdUqYgKmlvES8kHTY7bJXOB3SXFJTubP/9OJqNfjCMaV7+Mq2DHFUN0RPGgd/nTHJ3hkZS3YIZ6EIAuyTDJH5QakqALhjnCyk/fuX4QCZR4aYVKOQCGVRHY1QtzWGRu0ZqPDiCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QWDEme8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uCftpOHJ; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id CDE231301BB9;
	Thu, 12 Mar 2026 17:55:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352539;
	 x=1773359739; bh=7EkI+1dYSsaNPhaQL4RFoi/L2xXEeUvFR4/hMXQ6Tv8=; b=
	QWDEme8qECmbVrBBbWwkEiohStbLaNDmXHMhulBhyoA2EG4o9Klb1AYQqUq0RNC5
	nnDBs7m1PE9pcBUM4WeYuhcvjHqs2D1sE3ayPHMrX+/DMifhX2vb081xbm0s9sZH
	mib0fDRiW0EL75WUrBvfmIo4P6lq0ic+WO0ZWZ8D8u+hNI7/c8FRPA77w+chdZzE
	UNDIwkYV33dYEKHCTqgO3B6LmvhzAMLUTNWy7hxZ7MgeWCKtOCauLjv6EqU11gPw
	tc5/24EPJ5Rau0RWMcN9eJrYwG62vPk+uinTSI6AUMf/cUl/7nrsHyBW2HJN+hJ/
	KjRxJq02GMx1+LsJkMOlHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352539; x=1773359739; bh=7
	EkI+1dYSsaNPhaQL4RFoi/L2xXEeUvFR4/hMXQ6Tv8=; b=uCftpOHJU6GQPgjyP
	BqLIbZVvlgXlUB00MfOPgAaUi6FoFzPi9wFTBubNPoKakH+qqHCAOZOlPS/LAOUy
	2/3De6yOkuPvYWRD68s+R8O8NOgbqOF81JlMqBfjjNF1p0HfN7PxORtuutOGgl9h
	uZ1t6widneeTd+8IGNXM/3F5qx8YOdgd4tNglwZJ+Rzk/id4c6PbCQxG8mGaTQ5U
	tKJ0yapFVfywZIR6KJRe0o9D6eR1gitNNNnyItQ78W5P9/nxAFKWWaudljMP03sa
	j2NvKpJYMrCX1uXLOSrf6IaPTyPZe2mcHof6Yt4e2dWNk77qwKbPdbVaRlkN4WxB
	0dF8g==
X-ME-Sender: <xms:WzazaZi4hKudtguizjeyiXfodZw7Us9Z5TlrZIfUJ3BK76SDx9ljhw>
    <xme:WzazaRvjGdhLe-FsYCIbBqkhtkSj8mSAyqrsSIdUzQPO4gl2UF_sP4tPTLASWEile
    1rpmDjjs_Lcc8KvGYCmEn7GXlMvc4ES8AD67HcaujvX8UF_>
X-ME-Received: <xmr:WzazaUICRgJIkDTfpPnwiHMg1l1HCv9bk1S7kn4_pqjnYMXSyuJoKCwK7Ig8EM5d20TRJxl2MPYdV3TvOmA5o7e_y0p52XvN7x3Qj4ix1xAS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WzazabshJ-q_9wgV6KgTAqXTmtx-b1AsTy2w3f7q6pCvLcT4_skiHA>
    <xmx:WzazacR7k8GqjyOEzAUJqIcIRh_zTSch0uWR1cjLR0IRJXvMjo7PsQ>
    <xmx:WzazaRVS4Io-MY8lFU9j0xRoGXrLk7Z0raOKVZ0SsKRmQKPTmSLB-A>
    <xmx:WzazaWwppvOs-RxpcSIPxRmcmuSyBX1k0cC_WAmlITduW1bS83gNiA>
    <xmx:Wzazaf_E-7jZSi11Dz83gTvIASs6ravc4L_sRo9bzrYz1jx1268FZeht>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:26 -0400 (EDT)
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
Subject: [PATCH 42/53] fuse: don't d_drop() before d_splice_alias()
Date: Fri, 13 Mar 2026 08:12:29 +1100
Message-ID: <20260312214330.3885211-43-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20101-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid]
X-Rspamd-Queue-Id: B9A8A27AB5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

create_new_entry() is used to finalise the creation of various
objects (mknod, mkdir, symlink etc).

It currently uses d_drop() which will be a problem for a proposed
new locking scheme.

d_splice_alias() now works on hashed dentries so the d_drop() isn't
needed.  Drop it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12..a659877b520a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1020,7 +1020,6 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	}
 	kfree(forget);
 
-	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
 		return d;
-- 
2.50.0.107.gf914562f5916.dirty


