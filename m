Return-Path: <linux-nfs+bounces-20094-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE2ADDo3s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20094-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:59:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA427A91F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E7C4302759C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E033AD516;
	Thu, 12 Mar 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gaAhEBPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYzTveHy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF33BADAD;
	Thu, 12 Mar 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352147; cv=none; b=a9IDmBvzeGV9zHLK7Xc9H5yQNuqdeFkzvUXdUQbVy2/gjzlKw5pzzwrDWU7UGcqvUYSfPTtxXpkM4UxNc0ONfIKz27/LG5EFMOtFaMhnY1Z8yDWnMlnjLWOTl2qtWGtjTNfxSnOxBm3qWhOb19gqryNh/MqQvD16lYmuf7XFqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352147; c=relaxed/simple;
	bh=jSjdU8vngGbZtY+U9vRSrxvzSHttQ2w3RWSdr52436U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfHvSpwHeYPVKUBhhYk8aVKXGHaLMRThZVX7qfR7bTjWe7/VUnYXbt4FegO1DcIvGCGj/JuUofolMguY6Qtd9chm9cSzZPT3W4HrqMpfwKn4D6O3o3AVXVzq3DKtcayd0t9rCLzz5nYcveVKp73L51XgM8Nrox5FHbdQyvXmamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gaAhEBPA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYzTveHy; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id DEB981301B8E;
	Thu, 12 Mar 2026 17:49:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352141;
	 x=1773359341; bh=YL+J72s4jM/IFD83vUlKIIKhuJuEonEWtkSdhku4yoI=; b=
	gaAhEBPAdZ3kN0WV16+ugt1A/74DzdGxG8GEh+e+EQn0LxokiH00tux1d8sBHRcY
	Vg+7f+AOVRuHjhznqBd0sk41zkY9Vx4MFt96H29HY4RyG9/tLfLooU+qOjqy3Ip7
	IH8RP4puRqDzsWiVR9OJNaF5F8IkaIv8EKzwUABlX5z0SXc9f3oqyE6HyxoBMDDS
	pc/vRkKXd+xwK5xh2M7mb3cTBfa30Q4hfYmSYHp47InunZ8s/qXNmlFjFULmHD7w
	3+DbNHr3E7SKmihSlBhgNVVkp2v/H1cc12RtWmoaSN4ONlLZ4DcnjXpDPs4R6LkU
	ns6xJKqBdYIvZ4hcjjUj7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352141; x=1773359341; bh=Y
	L+J72s4jM/IFD83vUlKIIKhuJuEonEWtkSdhku4yoI=; b=PYzTveHy9RbMJRFOG
	+aOYTisnLh1GssROIXjKgytZ4YxU9i+aq6o6xyI+wA2qQQ3phZD+7w9a+2oxR9sd
	MeqUQsL4Pikanpl6RF2Vlolwt8nVrrSGXImQw1AiavtrMeOHQp80gmJWpbwF2FLc
	nH2rodwDYZ8UVeQnQ/vcXJ7K/d1UnY3kPRC6+afOMbKrlwwk46kzWD211KuXsuNA
	OuNxbhRGhgyAjKWcJHaW4LaMvWUKu+JboX31okwJgjFqztHXyiMO5KvAJdk0mEfr
	nvn4Mqxg7kmCNIR8KgMyimzGJdQGOGVz0Rta8y6idYVjE7mud+m4qGXXI8tSbQc7
	PLcCw==
X-ME-Sender: <xms:zTSzaVmwZixCGdoX2erYF0lP235WWzGm_ytqUU29xWcEeK7L0VW-wQ>
    <xme:zTSzaUjG04C-wM5lql7c8WfFKDjRHXkGA04C2snp0wQn_m27cVZPK_uDtD9jQYXU-
    iK7vr13E-btv_v6m9oHI9tCXM4q9Zw7H-3yQldyhMRQJcTA>
X-ME-Received: <xmr:zTSzaWsqAk9yDmJdbanEpvmBeyBlj7d_0-LcKSmgHHotctU1rSIGew6MWReJM1dGsftssvq89mEj9JIvBq67daOHoQnwV4TX_7ghL9A09Cwh>
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
X-ME-Proxy: <xmx:zTSzaTARJTYpvXl42P8fW7lTXo4Lj2wXGnHid5oDSRvhe_yZolChkw>
    <xmx:zTSzaZWOsXczAf9XJmzQY_cdxcxLTv20bO6dyIAvbZru0n0FgBFW6Q>
    <xmx:zTSzaRIbQrG4Do27wKl9Wfg5Nj0cHKP-bxR-i9E9XHdvomQxuGhoBw>
    <xmx:zTSzaSULGNWJZjGpBUM3QAt6gABNWwr6kRRnFzPn2VEFH0VbT_nXjQ>
    <xmx:zTSzaczB9cOVBaPVl5IKIF-TP6DKqW7SwY2Aj9X3Uh4e-1ZgrGKRQC_t>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:48:48 -0400 (EDT)
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
Subject: [PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
Date: Fri, 13 Mar 2026 08:12:03 +1100
Message-ID: <20260312214330.3885211-17-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20094-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,brown.name:email,brown.name:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60FA427A91F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

When performing an "impure" readdir, ovl needs to perform a lookup on some
of the names that it found.
With proposed locking changes it will not be possible to perform this
lookup (in particular, not safe to wait for d_alloc_parallel()) while
holding a lock on the directory.

ovl doesn't really need the lock at this point.  It has already iterated
the directory and has cached a list of the contents.  It now needs to
gather extra information about some contents.  It can do this without
the lock.

After gathering that info it needs to retake the lock for API
correctness.  After doing this it must check IS_DEADDIR() again to
ensure readdir always returns -ENOENT on a removed directory.

Note that while ->iterate_shared is called with a shared lock, ovl uses
WRAP_DIR_ITER() so an exclusive lock is held and so we drop and retake
that exclusive lock.

As the directory is no longer locked in ovl_cache_update() we need
dget_parent() to get a reference to the parent.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1dcc75b3a90f..d5123b37921c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -568,13 +568,12 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 			goto get;
 		}
 		if (p->len == 2) {
-			/* we shall not be moved */
-			this = dget(dir->d_parent);
+			this = dget_parent(dir);
 			goto get;
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
+	this = lookup_one_unlocked(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
@@ -666,11 +665,12 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	if (err)
 		return err;
 
+	inode_unlock(path->dentry->d_inode);
 	list_for_each_entry_safe(p, n, list, l_node) {
 		if (!name_is_dot_dotdot(p->name, p->len)) {
 			err = ovl_cache_update(path, p, true);
 			if (err)
-				return err;
+				break;
 		}
 		if (p->ino == p->real_ino) {
 			list_del(&p->l_node);
@@ -680,14 +680,19 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 			struct rb_node *parent = NULL;
 
 			if (WARN_ON(ovl_cache_entry_find_link(p->name, p->len,
-							      &newp, &parent)))
-				return -EIO;
+							      &newp, &parent))) {
+				err = -EIO;
+				break;
+			}
 
 			rb_link_node(&p->node, parent, newp);
 			rb_insert_color(&p->node, root);
 		}
 	}
-	return 0;
+	inode_lock(path->dentry->d_inode);
+	if (IS_DEADDIR(path->dentry->d_inode))
+		err = -ENOENT;
+	return err;
 }
 
 static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
-- 
2.50.0.107.gf914562f5916.dirty


