Return-Path: <linux-nfs+bounces-20096-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKgbMHs2s2nlTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20096-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:56:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D927A7BB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5597432DF366
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9738B135;
	Thu, 12 Mar 2026 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Xccu7BqG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/gQSpd7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC523EABA;
	Thu, 12 Mar 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352180; cv=none; b=C+JJbN82Aq2/Mo8uSRp1VlV3M8prVPz9dQrDfcHC0Eh3QmYtGmiuovvDs1frFCFWt+pCiSqR2QLWLhLO9s/sghBdnYHHCeHqZEOyF7nd/mNLvJ/BED7bEhiT5P0vxbCknNp3lLQDZoq2O0yCv56ODhoD06lVLePJkIBBS+3yR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352180; c=relaxed/simple;
	bh=VGwEZOS2xQR90lck3nphx6g+AoqwByQSrwXBkPz1zDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h01DaeBqiqlI2sC8CTmRD0Rk+kQGJSKp2Iw/L+lSblJXgJNNj4LONBW+TRkM7nVIp4SSdoj/t5c3A/Ga8zruLg5NhwfeQC38JYzjosGv37v3nDP+phdKu1sdnQ483W2ukkzETA/BVNFD3bGGt9IH9JdBveVHjd2Cq4l88H+fC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Xccu7BqG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/gQSpd7; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 304841301B9C;
	Thu, 12 Mar 2026 17:49:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352177;
	 x=1773359377; bh=puUX/onZj/vaXC+2Vk95PLkQLCVwPSvUkX77dKofgTQ=; b=
	Xccu7BqGG8E2NDVZg/N4GFdwY2oD8s3CZ2ec6I8noK+y1khNNKwdQa3qSaE8p3ck
	0l50JSAYQMZ5XRGqZ6Bm/NAd13BsbRhSkEdg7tqZU6lqcf02dFEy2EcSjKuts/ie
	93Y1uP4EFwJeTb8r7VZMByZxlZdqGEPpizVdBZMUA2mImhfkLWcTIYnNYeFDeLsv
	5FU2zkjTsrw3bSzl+CIzFJGHS1tbUaCwV+5sD1boXsVdn68Nb5W86QGVNW3kz1dO
	ZBA29VXiDgjJht9QJK+RFCH9oZopsofcKUpnEEHU0+MgBQGEzMOp4Bq2C4HkdvRc
	lnP0iuRl+qvkLgnss8CbMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352177; x=1773359377; bh=p
	uUX/onZj/vaXC+2Vk95PLkQLCVwPSvUkX77dKofgTQ=; b=m/gQSpd72bOeZbbIs
	bt9p9HVZaVD6pf8ZLbR/liTkCv6KLk37Bwr8ICPhs7HK1JpcdmbvRz230O5ZCVWm
	bL1vRCv8aa/Xm/OpaO3WA7ztqdqawHLsbn96Qsi2daFjSCddFwzLvvwz4NQtqelr
	jJiohG5ZcJotwPQPUQg4NyRCl/Tlv1u4/GXgV4jKWFBH0UUA+Mqw1kR51FO2ihPR
	sv9Bl9N1dEqbD5ZMaW3p4mZ8SyUtMM0xpWUs4C7GXuaqyzfvyS/u1YLmjyB5CADx
	iwjOJR50j2ZM6njft50LG+J5rhWP3t9qo6Wg405WgsbPq6uZnUmaMgGVQl7jGsRk
	+xLJA==
X-ME-Sender: <xms:7zSzaRVK2ld2mjFEAplQJYa3xj2B5fXBRT5y0o0EdVsnun8GWGj7QA>
    <xme:7zSzabR2Lv5FmbF1j0P4TzJuP00xer94lt3X-Grr0Tb7TbVDJgf4Jx5IwpC9MwnwJ
    P4t_lKZRwAwLN1n9mgh-b1sfmG9SoeU2JQMiLlb4i48l8ScJA>
X-ME-Received: <xmr:7zSzaUUi1znV28haYsZWa146WyJbSjqBMqzMN7HUYQ0_ezVgi0z1HHys1ytelS5qeuiqw3N9ZonF1PHm-rXrsrwIwgZ4NLTmc8x48k7FJUbX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7zSzaYayN_tA3ZkrIRtpJ_g6qClkPs2v_4yuR5WOe7mTaUdMhUxu9Q>
    <xmx:7zSzaa_u1VUCAlV12vbpEUyTKc2zx_hwL4IwQMPrbjyh4r_ouPPtxQ>
    <xmx:7zSzaf4y5PLi3r_Ggqqc4UxN7B9yxtAOERfWRtN6w0IgVtlfwvZ05Q>
    <xmx:7zSzaQnBblIZERJYN1PXUQ5V96-8KEp8KPLi_5CcVcuQa04y7G941w>
    <xmx:8TSzaZmH5TF4DiiBHGfn2CzS1n4UuyybOJqjIgTLw_TmHyJHXgibp5sQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:49:22 -0400 (EDT)
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
Subject: [PATCH 18/53] shmem: use d_duplicate()
Date: Fri, 13 Mar 2026 08:12:05 +1100
Message-ID: <20260312214330.3885211-19-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20096-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,brown.name:email,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 282D927A7BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to create a
whiteout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..6b39a59355d7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4030,11 +4030,12 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	struct dentry *whiteout;
 	int error;
 
-	whiteout = d_alloc(old_dentry->d_parent, &old_dentry->d_name);
+	whiteout = d_duplicate(old_dentry);
 	if (!whiteout)
 		return -ENOMEM;
 	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	d_lookup_done(whiteout);
 	dput(whiteout);
 	return error;
 }
-- 
2.50.0.107.gf914562f5916.dirty


