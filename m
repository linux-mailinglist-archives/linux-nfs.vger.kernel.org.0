Return-Path: <linux-nfs+bounces-20121-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DRSB/Bds2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20121-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:44:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14327BBA4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F1530B8E73
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261922FDC53;
	Fri, 13 Mar 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WX7c3DKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKoMfHHk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D7275B18;
	Fri, 13 Mar 2026 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362613; cv=none; b=M4XTur3tottSfeLtpJV1SjJDBLyfoHVdfAbb24sRUtOmuhabn+owWNxhENHIeBA6DhRpWwW0SOojVoh2M89aQIzmYllvyNPCyhMl4s22C2wiGBHaA2LPql4ESwxtyMgKYXYzoDdezAIB2xZ7BO2/yF+rC4t16uCUeXvwQaUDvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362613; c=relaxed/simple;
	bh=H53rHtuIKkJV2K/5nZ4HjRth0TKSPLKyiXBZ0GjJYsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1NnYPP6DexDEQQ78g5W3Yvs3HD69c5MXHh97N1+Q+KZYVer+d2ThAlUM3ep6/1yi3UQllt4XJRmFR0y4mURSUz6KLrZ+/KP7zJzB15b6HJHqgfJ0kjRi8ayYWdqi1Puajud0gix9iYLaQtfPdkYrtSGDD6+5C+oU1SpG8yntrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WX7c3DKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TKoMfHHk; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id DDA261301B24;
	Thu, 12 Mar 2026 20:43:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362608;
	 x=1773369808; bh=8aHffWYVzxlbvh037JlVhR8ERE/IxGWBZRv5qHj7bJk=; b=
	WX7c3DKPx+tVVhFVjUW8//0VWvS4las6XMedU6aTYpr242woaOIcqjdZZVJ4yVnC
	P88WJrijdCqh71ZQjfLl+xhjGoQMg/F8wZ7GNOHUOS+3PK7l64Z9RcJfHzu3EJx+
	9kiGTP3jc4KeZly7RqBISMFoHeUWIhyiLSOgatDGNqU+ils1tsCxI9p7zB3O39nq
	cROINYPyREvgD1SKVCYqH32NWAcedBFxE+Wuyiva088VcFlPPudW1EKncv3fsuaA
	BShtlQMTfihkHb/wYJyVBjIX251wX3ueq3TmnmoWiRxo/NGW66kYiWp2sylnh++s
	bFkFlicATpGbeU9QOA95Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362608; x=1773369808; bh=8
	aHffWYVzxlbvh037JlVhR8ERE/IxGWBZRv5qHj7bJk=; b=TKoMfHHkIQcef4oL9
	WCvsrpW+mTxjtA3eu9J9hQdlSACakLolIy62RydRB3PnAitR2M2UBSxOg6u41jAQ
	orR8E5pfwsu4X5hri4xNT6JK2donC1MWsL/u0WbE7rRdrQQpndWHCmOLcrn85w5q
	SI+HqYSuDNwoKNY/0GBR6Pi4KU3xLzz6Q+JVFC40HVtSP3UyiF03OUmeTa8dDPt6
	DcuHCt92Cd2YJ7SYU+vMYMh3KnIdv8pfwE/90UpO7I3xohC3Jy56VaPbigBQF9ob
	6qBILVQxLXuHVd9mMl4KuNfCKXc+3cO+4irgJurxJUSavrvBRuwB40RYu4N6E0i6
	RGNjg==
X-ME-Sender: <xms:sF2zafwU5O7EET5F6K-aQw7jkWz_ixnHMn4V0xMGQaiLTVepCp0tRw>
    <xme:sF2zae02wD0x5bh-9IIDWH0SxbeC0VpY18ApLPS8IXDYBqpRjLeeJzPqp01_9lfY7
    8Jv0uyAVrBjp1-Aj-tSe7O8R_xxkSMDF1paMjxYStXEtm2zyrM>
X-ME-Received: <xmr:sF2zaQ5u5MiWf_c7DuHg5fbpvIKQer-qUWUomzqvDd3cFUmdR7Z_2wQrinuTZ7IkyU0CpPNKTH5Q0vb0CvuRdpmuwc7ZgXvaIhhtyMu5Yb9C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sF2zaZf3Per3LZEdp2WRei0ix5aAERTBM0In42j2nkjtAIqVFKBUPA>
    <xmx:sF2zacZtEAEXc0iiBzy42igNRtM_Pt7PbdtzWmXxrPKB5Q8Y4_JQgw>
    <xmx:sF2zaTF4c7hbyoPU2SzpbJB5q6gWv9QUr2hNyV-ZxscAn7v4SDrPRA>
    <xmx:sF2zad0qxF5Ms1PY3l5bG_FSgiwxJyCVizNYRzREyDx2EYRsA7FshQ>
    <xmx:sF2zacNj0BpnAMzEYFy9m-DUQPdAneviKyB1uWslBDL8eNGoPKzEt0nM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:15 -0400 (EDT)
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
Subject: [PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME handling in ceph_fill_trace()
Date: Fri, 13 Mar 2026 08:12:23 +1100
Message-ID: <20260312214330.3885211-37-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20121-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,dname.name:url,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: AE14327BBA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

When performing a get_name export_operation, ceph sends a LOOKUPNAME op
to the server.  When it gets a reply it tries to look up the name
locally and if the name exists in the dcache with the wrong inode, it
discards the result and tries again.

If it doesn't find the name in the dcache it will allocate a new dentry
and never make any use of it.  The dentry is never instantiated and is
assigned to ->r_dentry which is then freed by post-op cleanup.

As this is a waste, and as there is a plan to remove d_alloc(), this
code is discarded.

Also try_lookup_noperm() is used in place of full_name_hash() and
d_lookup(), and QSTR_LEN() is used to initialise dname.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/inode.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 59f9f6948bb2..0982fbda2a82 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -15,6 +15,7 @@
 #include <linux/sort.h>
 #include <linux/iversion.h>
 #include <linux/fscrypt.h>
+#include <linux/namei.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -1623,33 +1624,17 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				ceph_fname_free_buffer(parent_dir, &oname);
 				goto done;
 			}
-			dname.name = oname.name;
-			dname.len = oname.len;
-			dname.hash = full_name_hash(parent, dname.name, dname.len);
+			dname = QSTR_LEN(oname.name, oname.len);
 			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
-			dn = d_lookup(parent, &dname);
+			dn = try_lookup_noperm(&dname, parent);
 			doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
 			      parent, dname.len, dname.name, dn);
-
-			if (!dn) {
-				dn = d_alloc(parent, &dname);
-				doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-				      dname.len, dname.name, dn);
-				if (!dn) {
-					dput(parent);
-					ceph_fname_free_buffer(parent_dir, &oname);
-					err = -ENOMEM;
-					goto done;
-				}
-				if (is_nokey) {
-					spin_lock(&dn->d_lock);
-					dn->d_flags |= DCACHE_NOKEY_NAME;
-					spin_unlock(&dn->d_lock);
-				}
-				err = 0;
-			} else if (d_really_is_positive(dn) &&
+			if (IS_ERR(dn))
+				/* should be impossible */
+				dn = NULL;
+			if (dn && d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
 				doutc(cl, " dn %p points to wrong inode %p\n",
-- 
2.50.0.107.gf914562f5916.dirty


