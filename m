Return-Path: <linux-nfs+bounces-20106-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK9bNEk5s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20106-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:08:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1B27ACD1
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62172321DD1D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0B3AE1B0;
	Thu, 12 Mar 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BW9wEqW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpUIJhtE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715A381B18;
	Thu, 12 Mar 2026 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352627; cv=none; b=NkZva2mG1ggAJj2Q+tahvr1n7UBw16z1d51I+fZnYwVMQTzWLO89h+6AIy1yF/8T0TNBRQNExaFWHICrFUSzQ0xyDe4cUmpmNfyYGWch9LPLrQvY0tFliyuSVeNfZPK/1p2+KyrGVJuJaR2z+Aecn+LpPBpfP6190kpJFhAL99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352627; c=relaxed/simple;
	bh=rTMUv2NqZ3FGQqb+0wk8UIV1lhSxIjtP4stcYt3+MG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ7rqaFSf9+kcoKJz4ToayKXF7b8UyGOYxqTLvHobWB2uHhBDEUsf7s2gTRUNVemUVLvRlpuO/H5LjBL2yR8d40Wcwznqf1orobXDn2RyLwd+XDdtWyLZ1ASDvAYY8td5IR/OuEah/H5c9o6UH28ddVPHzcwuj1eldcY7QVcZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BW9wEqW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpUIJhtE; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 8997E1300F6C;
	Thu, 12 Mar 2026 17:57:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 17:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352624;
	 x=1773359824; bh=4l/tn7wsmdY2E32uQtjREu4g7D5gEVnge4bbDSwghlw=; b=
	BW9wEqW3sDh/FtKsI2oZym4cN8gfqO7PI+1QZkzeYlyvzzvl6g5EeSeOVu2oQtk6
	PwPCa0pocxA0zzebqej9hV8+MTj4mW3U1OzGT1coekfj64HMKjiyXojEgdUSfnKR
	Df6eFbO4K8hWvuP6o0waZ4SVFdfPcjZ7D+C0sJjdqiTmUTmlwI+pXNafNv00dWc+
	O0BVOVD6z9gx+eoRdkYV7FRCKsnyeYvYtoaEJmptNiWxetbag5RW+Ctd2uja0vfe
	v/0ZReqHwz02Av+es2ehMtnHwBvblWlCyOd+zaOQ8hfvOrqwfKTb6BsB9u6fjrkN
	H6TNzQH7wj5p2FUyypeOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352624; x=1773359824; bh=4
	l/tn7wsmdY2E32uQtjREu4g7D5gEVnge4bbDSwghlw=; b=dpUIJhtEj1cBj3j9H
	unyZT0sMz9m0PJa4w9ml8U0zTMyPTdFWoMrhP+PqHlnb46PZTAI4xBzf/94OZ8au
	HMMYdpzclow79eg8cITbo/HF3XL3lV3pJvLrnH+UHhYGWNABwaDUEiiSyBi+p058
	AIT72AIiSjFv8C24PGRRqioFgMW/bXDjAmwY1r7O83Dgv8bls44ABJ3Gy3mhaPVZ
	p5sA4LBrZzneMleY4pIfAQbq2VSFXST6n79auOxftmCpBxOkbEmLk++Su9Eqt6tE
	9xo9Ukyjllk9zko/7dVAbA5+W8pX2MGic1YtvXJIew/ovNUl8pHZGrIke+e8ed4X
	zHmhQ==
X-ME-Sender: <xms:rzazafHgq5kkJNLQXJ5MsMZvA5C7KDN9tUQQwQNXLndrPr-KUTr36A>
    <xme:rzazaWBaxSyrDQlnqQ7fCszhaC7GOWJXr034oAZHf9f5Ln_XAnrlsy8lJHZqhtcCa
    24RJDo5YwjWbYzhkh95fWMs6HGsmK17CJ_FCEE3A2bRWLgAE-E>
X-ME-Received: <xmr:rzazaYGaMqtlyBo5Byt15BG5PspFOkSK_oM_1CAORCyOKtV1Z5vCxW9Wv0QrAIBd0dvvztUHaL61rYcyjKGMWRqFwlWMac7pDS4ZI1dvlQHE>
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
X-ME-Proxy: <xmx:rzazaRLMf0xCbH9DskN6cbfxaFyHjsXPa01ypMC44vm_7j42GQo-XQ>
    <xmx:rzazaUuXjK3pWNOdt_IrXzDfMiNIFLihdDLGV0rzQsKjCfilR3Fziw>
    <xmx:rzazaWol9h7ePjrj3Za7I73W-xCiRO1lEYFki_qD-TJ6bQYulpiMtg>
    <xmx:rzazaQUBcFkXeR7RUWU1cUXNQ1HJd2AgmIhU03afXZwQTCNgbw326Q>
    <xmx:sDazaWf3sZUuzWbO4fKYzxinLNZ9SCRYKi3Wbk1TTyoldl1UNbQP0RC5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:56:51 -0400 (EDT)
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
Subject: [PATCH 47/53] VFS: make d_alloc() local to VFS.
Date: Fri, 13 Mar 2026 08:12:34 +1100
Message-ID: <20260312214330.3885211-48-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20106-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 66A1B27ACD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

d_alloc() is not useful.  d_alloc_name() is a better interface for
those cases where it is safe to allocate a dentry without
synchronisation with the VFS, and d_alloc_parallel() or
d_alloc_noblock() shoudl be used when synchronisation is needed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 8 ++++++++
 fs/dcache.c                           | 1 -
 fs/internal.h                         | 1 +
 include/linux/dcache.h                | 1 -
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 6a507c508ccf..4712403fd98e 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1381,3 +1381,11 @@ longer available.  Use start_renaming() or similar.
 
 d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
 from an internal table when needed.
+
+---
+
+**mandatory**
+
+d_alloc() is no longer exported as its use can be racy.  Use d_alloc_name()
+when object creation is controlled separately from standard filesystem interface,
+and d_alloc_parallel() or d_alloc_noblock() when standard interfaces can be used.
diff --git a/fs/dcache.c b/fs/dcache.c
index 9a6139013367..23f04fa05778 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1830,7 +1830,6 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 
 	return dentry;
 }
-EXPORT_SYMBOL(d_alloc);
 
 /**
  * d_duplicate: duplicate a dentry for combined atomic operation
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..9c637e2d18ef 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -223,6 +223,7 @@ bool sync_lazytime(struct inode *inode);
 /*
  * dcache.c
  */
+struct dentry *d_alloc(struct dentry * parent, const struct qstr *name);
 extern int d_set_mounted(struct dentry *dentry);
 extern long prune_dcache_sb(struct super_block *sb, struct shrink_control *sc);
 extern struct dentry *d_alloc_cursor(struct dentry *);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3b12577ddfbb..18242f9598dc 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -242,7 +242,6 @@ extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
 
 /* allocate/de-allocate */
-extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
-- 
2.50.0.107.gf914562f5916.dirty


