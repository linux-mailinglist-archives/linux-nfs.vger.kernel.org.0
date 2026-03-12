Return-Path: <linux-nfs+bounces-20134-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPYIHzpgs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20134-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:54:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D830227C0BB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E76312CC21
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38C30DD1B;
	Fri, 13 Mar 2026 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IpsMpfFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8JHmFu5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31BF30DEB0;
	Fri, 13 Mar 2026 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362835; cv=none; b=eEcBY9TJEMMMD64rfm8DVo687SZ7mFxIOdvpwvIp1lRrWN/opoTu8A+Jmh8PfbL//otUF1LTnQBLN2JaVWc/LFdTHckOWxmcBhsdgThtz2T8t/SDDMNC3P4oZfjWOzz10jrfEfzpBoHNAnhbau5qO8bUsSQ17vZexSeAKz7If7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362835; c=relaxed/simple;
	bh=M+pj1aweERiV90n0rYRzeVYYR+PmCvz+3Vh3CZXEIx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBZxbhUO8AjX20oxV2/TQgwYeXtw2PYIEuxRAA+WyOHthZCyzozhYbQ3NqOHuL0A8x7exwvHO1uUzx/3hu3ImSyIXce0spUTqujw9HNcan7+s4Ibw/XasPDDv1HMgK93jTlTSfqJHYJocRIinBOScJFYtCxunqiXsrKyLVG30Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IpsMpfFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8JHmFu5; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id B9F1C1301B6E;
	Thu, 12 Mar 2026 20:47:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 20:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362832;
	 x=1773370032; bh=Qz44r/cI/H+P66r7rjgQTu2SyU7wjlJxbU1IwzedCr8=; b=
	IpsMpfFevA+mEhkdruCUf1Vu9FEmLzrEWAtb4IDHjustVcc660x5nQzIEH+zM7+n
	F7xem84KPhj9hWFRzoN31Jzl2kLAcLz5C41k8KF8DDc2o4mfWEEH6308fDzSejrk
	AorOd82znIkjc2rhRbi8CcLttXgvES5I5n9aRJa1sym6k9LnaGvmiOPtg4JaoClH
	E0GZdfUMmErgqYA2F+MxWkHZOVdGxA5gC99x4eWzvtHdwM3bSZVia7h1wLflwgGX
	KQHLoziyxbJHp75VC9zMqgFzhJDRW4bSOVnZITlnR83AmG4HdVrOomHAmHpQJLkD
	HBP2qOLbjyiF5zP3BpxzQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362832; x=1773370032; bh=Q
	z44r/cI/H+P66r7rjgQTu2SyU7wjlJxbU1IwzedCr8=; b=G8JHmFu5KQLBpNeDN
	zld/gBCZXli4GS4wIem/PbJqdIIhih3tiaKE/N90l8FUrwJW8+gU2YeDvGTUBthJ
	rkgMGcdPlD1fIWMo1biHaQo9/WLjEYSr4vVAu27PxvDXdpU++7hfY7L//0Jwh1vH
	tzV6BPqgVS3EsG8sXh4xhvpy93GmQMFAKAaTw03Y5NAL6DAPPg5Wqs5sjjStPu0f
	cLxuKrZDYNCr9qnEHNk94ODc/hUxWL67t8Fh7zQzN0r9Wm/zV2Yq30KwIEHJu9yc
	t/JWWAUZfgxJ26ZwGO6uIfjpuQTO8vMuyP8XPTU8suyyC2YPRzT8hE/YRgFJTBwT
	ND/vQ==
X-ME-Sender: <xms:j16zaYNqiENq37Q88rVFgJaCOvTJoUm1h2SEBH6kM7EqWOTDRHmc2A>
    <xme:j16zaYoZ3REtyM9VfSMjEIDxBMUKaiHvdWMBpAfpNKCvDvCxoo2Qze54PpjQVZobJ
    WRkvp_JemW5lzrlTb4vGsMKrrdw7teaVORNkzNbZ_AH4lnd0A>
X-ME-Received: <xmr:j16zaWO7xjK010jo-nA47C_4dYeAJwZ_N6uvslo1KsUNxaUr2oh3YspcqtKGGcTzoVpio9l4SKeKi4FzhdaorN2yMS4jRgR7n5YPp67PZbLn>
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
X-ME-Proxy: <xmx:j16zaUzYdGgFWNlQYTElED9rnjSSFh5w-f45gvQomTKe5mqutsfuIw>
    <xmx:j16zaf3nVk-q_uhqBESJnPqXZCkqcke1PsMYuH1SmSZD0xMezqCrmA>
    <xmx:j16zaTRtsoaSs1r-htZVOscRdBLq7DVWFnEqHhe2Q1hzILsaqY_XHQ>
    <xmx:j16zaQcOUgemLNPo4bCCmDOXDChgryenKb1HF8fIilO_1ferY7gLGw>
    <xmx:kF6zaedyr8sLQAReYz8TwH3TKulUCUC0YXzRK_d6K-utN3FzIFWDtrCh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:58 -0400 (EDT)
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
Subject: [PATCH 23/53] afs: lookup_atsys to drop and reclaim lock.
Date: Fri, 13 Mar 2026 08:12:10 +1100
Message-ID: <20260312214330.3885211-24-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20134-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: D830227C0BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

If afs is asked to lookup a name ending with @sys, it needs to look up
a different name for which is allocates a dentry with
d_alloc_parallel().
This is done while the parent lock is held which will be a problem in
a future patch where the ordering of the parent lock and
d_alloc_parallel() locking is reversed.

There is no actual need to hold the lock while d_alloc_parallel() is
called, so with this patch we drop the lock and reclaim it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1e472768e1f1..c195ee851191 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -908,12 +908,14 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       unsigned int flags)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
 	struct dentry *ret;
 	char *buf, *p, *name;
+	struct qstr nm;
 	int len, i;
 
 	_enter("");
@@ -933,6 +935,13 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/* Calling d_alloc_parallel() while holding parent locked is undesirable.
+	 * We don't really need the lock any more.
+	 */
+	if (flags & LOOKUP_SHARED)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -942,7 +951,10 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		nm = QSTR(buf);
+		ret = try_lookup_noperm(&nm, dentry->d_parent);
+		if (!ret)
+			ret = d_alloc_parallel(dentry->d_parent, &nm);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -953,6 +965,10 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	if (flags & LOOKUP_SHARED)
+		inode_lock_shared(dir);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
@@ -998,7 +1014,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry);
+		return afs_lookup_atsys(dir, dentry, flags);
 
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
-- 
2.50.0.107.gf914562f5916.dirty


