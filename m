Return-Path: <linux-nfs+bounces-20122-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMv1Oihes2k3VgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20122-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:45:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73027BC11
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77AC630CD725
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E0309F1D;
	Fri, 13 Mar 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HjfBkdDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJg/U+At"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF12D061D;
	Fri, 13 Mar 2026 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362630; cv=none; b=TxRNNri5BEe2cjo/cfLJIcXZyi5BGCu7XGMNj+gNvQ0EMX+/clSHuDsgrMzT1h3yxwPwSPjeProiiVOAW7E4MHU3IzsPRXI4nZDLa7aS2PNCHr7/fhwpHSxVuLk6A4NUlJ6MH0Ah3EIRb1i6bvrhrumb2A9G4euGE+34SqM9fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362630; c=relaxed/simple;
	bh=7wDBnpi78RtIzlHMeriwbRIS5fGE4CmYZL1MvSiLxm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grU/b4NKOM14d3M08cWZGn9O7qLXXaB9VYT7DhcBMxDN3GG/P6vYpfCo/+PJnlvwXG+pwHhtP7tssjOwIMNhcNfrzjyMQxvJSuzXnlNdmrkIhpJCfy6T6y2RYVZJC0IPcG9QpVz1Aqr04P2sHntfU7aBGvV/gEXmMS31dcCmXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HjfBkdDo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJg/U+At; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 7B8D91301B2A;
	Thu, 12 Mar 2026 20:43:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 20:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362626;
	 x=1773369826; bh=hkrbz7rqb+Pf2fLQdUTn4dR7TTJgxGfMaCdEXnGBb3Y=; b=
	HjfBkdDoAYwQQJLASCTx4N7D2Oi1gBPTlgkcYOo+WwQly3gu8BxcWETej8E7Y+vC
	7v0fubBGopf7L6qgpale0ldkZ1B3u5NVTNvg1/TUjoqYZU5l0RND/fCU926UE1Cf
	dU52J1R3IvMMwiwCn7OkqthnAbmNeQY0wfFveismXYFlK1lQkp1m9AISmvS7p8Ph
	2303a7f6K5Jlx6zDz19ofnGSqPmwovGDcXYodslmNv0d7WdUJtB9eTYsL8UW0U11
	0GUIOw1bNhAiMgqZY0i4MGRQ55IZgV8SiwsyP0fNcsShifYyYJOt+wEA1ov7f0eD
	PdnJa8hSTogxexnc9oafsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362626; x=1773369826; bh=h
	krbz7rqb+Pf2fLQdUTn4dR7TTJgxGfMaCdEXnGBb3Y=; b=OJg/U+At7OucCvylK
	iUzd6DL7jCUcyjQlX78GwqJ/I6vv5ihkeS435nBM5355zdePzGM36LT4OexR0MRH
	4lFKw8lzT25lxABE9ocUZMJqYrflNdpOeF742itP/1xqaMnbimOGJbINuPn3DCB6
	78lFrxBVAc+TEEOa/aL4peQFYcNfkDvkayfMDVZVCJTVMXnAR+QqmP+X6jPGUX48
	4eQs5VFQkcGcKjiIlmezH2hMkyivHCkm6/sZZuVlnduqKbI9sW3ivQ1XUkRrPQMs
	UX4u0qKhx023bdinP+vM4JzLq51NNl99ZTh37MUoQxcyxT2cDqefqczEqOVUaQb9
	MTpFg==
X-ME-Sender: <xms:wV2zaV802bTgJpgWGm7m58j8ialKu0Zt4maKIV9i4YHWWaGwICxAlw>
    <xme:wV2zadZgu2XwPg_o3YWrT5Anv88yZ7bnYqGCtV0_V4WJBvt4XpxYLozwCXYSJ1Dru
    hY-DVUIj8R6Y0RkLBQtcBmkmR5oFpyZ9WR_a_sQSkuqNx6Z4w>
X-ME-Received: <xmr:wV2zaeGMYnl9QYZx90hgpCUlWxvQ1rd8mBQO5-ss5KhrcVNyC2PIGpsH8rtolKGh19qOuChHoIrcz0o2s-anm5mlsN-kYi6yfy57pp24OHOP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wV2zaW4BbfLTb9uqAjy_X2cVeXfLP5nvICabjW1EC5wZ_-63JqfrEA>
    <xmx:wV2zafuMUoHnM_LxJ0SjB2wIbOy3qY0O87D6n9Ur7x1RFFWg_aJHtw>
    <xmx:wV2zaYAQZmmbH-UHw-cQ8jEX7A7Z38PfFVmYuiTDjpSLuYRJQdmsCw>
    <xmx:wV2zafteUDDwcmQNw5yQwNwpG9lEyX5qJBk0f8Bik16DaVWpZokoMA>
    <xmx:wl2zaTKap7N99sDnE0QEkre4DOsyOIg54jMHgmGQWKBxlmwTU7TXbmgm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:32 -0400 (EDT)
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
Subject: [PATCH 35/53] cephfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:22 +1100
Message-ID: <20260312214330.3885211-36-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20122-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7C73027BC11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in tracefs, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/dir.c   | 5 ++---
 fs/ceph/inode.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea9..c7dac71b55bd 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -769,7 +769,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				d_add(dentry, NULL);
+				d_splice_alias(NULL, dentry);
 			}
 		}
 	}
@@ -840,9 +840,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			spin_unlock(&ci->i_ceph_lock);
 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
-			d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
-			return NULL;
+			return d_splice_alias(NULL, dentry);
 		}
 		spin_unlock(&ci->i_ceph_lock);
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d76f9a79dc0c..59f9f6948bb2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1773,7 +1773,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				d_delete(dn);
 			} else if (have_lease) {
 				if (d_unhashed(dn))
-					d_add(dn, NULL);
+					d_splice_alias(NULL, dn);
 			}
 
 			if (!d_unhashed(dn) && have_lease)
-- 
2.50.0.107.gf914562f5916.dirty


