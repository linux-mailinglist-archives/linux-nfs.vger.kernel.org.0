Return-Path: <linux-nfs+bounces-20100-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H6sOTc4s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20100-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:03:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53627AB0A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8973E3051182
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E83AB290;
	Thu, 12 Mar 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H9EUTHF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgyMS/w/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDC38B135;
	Thu, 12 Mar 2026 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352525; cv=none; b=XjDOosGqDATTbwwZwuuABMOFiZM5uRcKqwZ8aiyQXuR0D8KRYSFjRXGtBy8bA20YX0O80GmkTH4X08uQ928MI5KTBrOQaUORYM4+qugXQHTx/5L48cPn4DCtdRmyoQTmsvw6RDFzCc0l2+v79rHhSsvKu3/upARsDEs7xIW1u4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352525; c=relaxed/simple;
	bh=LfNbjqer1Kv+ypM57v2HBgD2IirhDRkKCBZt5umc0Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb+vGx7I0a2DIrDKe9YZmVxo9Gd7Ya4ZaxsCHFSdNqZSYltvuzlW+Qz+7HFsusoqBi4BVZK43z+/cl0/yYbAnsdP6Z33RkCyS9wwVAdF94GZAJoHtDRohf0ZJxGOluLAM54hoQbMtWSjeIRXwQF6cX4gSUJOGuShHPvrLCL3oZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H9EUTHF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mgyMS/w/; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id B10021301BB1;
	Thu, 12 Mar 2026 17:55:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Mar 2026 17:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352522;
	 x=1773359722; bh=3if7F0C5AAC1JbkpbjSMCxjLy6rTA44JQ48V382ux68=; b=
	H9EUTHF4r4ntt850sUfeaQwtq1wg4xsapXTK+Bmbed5aBY6rGmecjBhkdb50KJJw
	yozmTs8rF52SI0/+6uErAmNlGCje+eaAeWizSuONzzKl6bXgUCbXrhvC50Ypb7Af
	BuGa9IVDBtnD0iI8cWgMLPEUvMmEROZjn+AsiwMbv31vHNMtLCOR4d07pF0F4Lhg
	SNbbwsak0t8uJDaZE9lEde5l/a/YGjv6Xm4eNNckpbnB0IlGBxn/KhnzKdHNNzFZ
	knquaTl2pgOiMYO5E3YdT59XdMgZ0B1OMFY55kq1VrLl65vHBs54fKiIaiYZmgZO
	fqr3ecAc7MP8Ib5llOeGMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352522; x=1773359722; bh=3
	if7F0C5AAC1JbkpbjSMCxjLy6rTA44JQ48V382ux68=; b=mgyMS/w//zLJozQuG
	iBMTVjEfl0NOrr7Zw66UNwTwbYxizmZhVHmA+lAQV7/jBPswUdXTZ/qZkmNM0DbI
	hKs8be9mTKQLa70XyuohH5vgJkcJ1Lf8CHfRHjX7K138+x0nvdCHx2JEpJOh8Q9K
	b7tWB+BgUW+qbsdIbWL49y0BSSPZZBWkUT/0NROD3UXKrVMw/3e1jvhZvGmRDQPf
	rIucBRKYZcMMA5TWkb9RLF9azs/HYd20sSGyOiiSqcmLp07MuJSg0uO1QiHA+HDc
	kRdsREoMdkfSJ28UBPTNkNY1lteIgQBwopJWj/nyyb32cXnM/7f4uBkmUlEFoI/+
	ZjyBQ==
X-ME-Sender: <xms:SjazachlAWJOSN8lEQ87olBQ4THW8YdF9RlFWlc9v1XRyDGCmGTfvg>
    <xme:SjazaesTvDYRW7k5iGIwjm9wIQkza8VuF4_UiMEvTBY5e4FYpn8LFq750dz1l4Dbi
    5jkSM07bgIUuiPmW8hzI3cpP5dADZ3FHZwwfkLfWGcWx44OaA>
X-ME-Received: <xmr:SjazabB8Fiq6DqmKllIMxsq_KLyOsejW5MZSugEFwbVXYgw_6r5d_7imDhHWM-mTZXu0THro99dT64wYsu4Hzq_iSBjowV-xxI_6AyXiDiTE>
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
X-ME-Proxy: <xmx:SjazaRVUEVbr5DICwZBK751qOvfjCumW4QjiWYsKS2grgUvd77XOSg>
    <xmx:SjazaZIyen0EDW-Ii1W8JpDgpqmir2JNlPjLTK8IUePBHyms0uCV8Q>
    <xmx:SjazaaUMF9hRGxMFgBbvbfSm7iXGN_MPHRezxnabrg7dw7H8WZk0EQ>
    <xmx:SjazaSR3lRAk_iK5JZ_cuPeri7l3gQKqEqg_Vuzki0vn4_fQDAwXYw>
    <xmx:SjazaXyIFx6sW7VqeUJx3htwVItRXiIok1LvXEF8SiWSLKfBtXaSuRZS>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:09 -0400 (EDT)
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
Subject: [PATCH 41/53] libfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:28 +1100
Message-ID: <20260312214330.3885211-42-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20100-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: ED53627AB0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in libfs, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/libfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 63b4fb082435..75f44341f98b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -79,8 +79,7 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		return NULL;
 
-	d_add(dentry, NULL);
-	return NULL;
+	return d_splice_alias(NULL, dentry);
 }
 EXPORT_SYMBOL(simple_lookup);
 
-- 
2.50.0.107.gf914562f5916.dirty


