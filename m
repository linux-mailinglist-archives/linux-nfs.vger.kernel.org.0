Return-Path: <linux-nfs+bounces-22997-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gx+tNMjYSmpPIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22997-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:20:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FA70B9A0
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=aAZCu8At;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Kiq8aPfU;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22997-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22997-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4956D300FB50
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5DA371043;
	Sun,  5 Jul 2026 22:20:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F5370D54
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290054; cv=none; b=b5ad8a9RBdFU8iJGXm49GISTUI5fheZ3aTgsDHg7ncwQ/flbk7l2AB1TouqKHNS92E1TrOj920xamMRw19Xbg7lk9Ls1YX8MBQe4cJ/BWwiBVCTG6yomrHHLZ53gmxuLzRLNAMPlSa/l414d//eLiFj6KcyRUoKFBkAyoTEeWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290054; c=relaxed/simple;
	bh=ikH+FoPimeFeLVFw1jrWG3ngTaiOO6B15CGa3o5I/3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq9oDlaKzJFxeyM5C5C3mHSc05TG3sT6Mv4P87GpbZ0J7XXNYfuCtfOvNk5SG7hANdBEIISe7suBtnmMAgiRa7VNP3KB+wpshVXnHWVvKZw8k1tVSHBRij86bPnBOkNdWSm/mFliOKTUyFSf0AhoFoHx8PR429mhl+hsrWvRY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aAZCu8At; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kiq8aPfU; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D258140009C;
	Sun,  5 Jul 2026 18:20:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290052;
	 x=1783376452; bh=SJgXZULDUnu7koUXXMoa7o7/WezgyNU28NrBOKtxOKQ=; b=
	aAZCu8AtTtDpz17LrVetsPvmWEta521c1ihMnoaOpV8Agi4B/zF0h6LQ4i5WFcsa
	jo89Zrwm9e8wYuNGuDmSaKlGK/GNThZm6q9s49kHL2xYzBEHJ1eYW8aHxB1nhkcL
	3bu9/IGyHQV1gRe0CnNzz6sq1ZDcHZNHAtVdkFlkGVycaf5fepoenz3tfv6FFctY
	nCCwxJco4ae2d13bdZpK3tl9lUgQpmW4AfODz8sYUYfa/VTFVOvk2+TWFNv8NxZq
	/42VRkctNqWtMaui2looRF1om/pJy10vCoUS+ZnIu5rfQJzj34WRDtE3KTyHKprD
	VhHr54oMjpT/7f6ybNiByA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290052; x=1783376452; bh=S
	JgXZULDUnu7koUXXMoa7o7/WezgyNU28NrBOKtxOKQ=; b=Kiq8aPfUrHReFerIw
	wZi46es4peIJF7TNylSOr647QykNGbLVnRTiSOnxmTVxyzXOgi/ZFtt8ckLThX2d
	1+l4yvJ8B5KIHdq1m1eQGEtIzDjxX+YCANWX6YzBC66HtSky38F+J7MOhKvi/Jnp
	4cYCg89Ts6uDPy1vakpgq/9MdeznbrgCKDkIRQvkLqcK1FQlGvNA01BDZI3okWta
	T7OcjyHu3MNJ12dxBBSi9+BOrFzR/eeVLbNL540IEtfNQnr3qCQfFDquojzaZWEp
	2xiHdGdjKuNCAc0tiSFpPvTjSIsvpRpyP9VvHgAo64WGUaVEcvsKXWoP4l0NRJwn
	i+mWw==
X-ME-Sender: <xms:xNhKauivrAV-dlPQ5L4x0jkwq2-8Z7ef-gVW_9SQUUzQ9tfGWqA0TA>
    <xme:xNhKaiuX4uGffg_Llg2DNW7Pb2cPO1EY_MNH9ZzSrNXCp8FtKAiyjrliNCW23psUX
    TSGyj2oyQeUYVelSYNwzuDC0Ip6wjT7SLHC1xu-0lcuOyg0tg>
X-ME-Received: <xmr:xNhKav5Zsq_c464deMy6kCHJPYt3Xd6ZlOYeHKREXzo2OX8HhKOQIIVfvNlYhpqLtKM0bp0ve9TKXsWMEgrOAAOnZ_72PKE>
X-ME-Proxy-Cause: dmFkZTFZJXoQAEa6EVyxe0xX/V6UdMe9NPP6v+PyemDKlVUA4/RobLCeToDc20yEIhELXW
    j859AdlcZPCOx7+eJUr6ttPMkh3fSbVHFfsOzOpUhDK+wlO91NCRvvk6uCh7dD/So3b2Ot
    hjoHnvmaUlFqSu/kng1MxYOM19vG4ohCcZGp04T97QU48SfoGXAVlOoQI6xw2Y1dXX7Ot1
    rU74wFwLDrYdO2+cFX1IiocZKI0l43xX8by6mEQdRgKEykZqfQDQoHQ7Mfli1YNuzu4MAg
    xS4bZMGCmrHdIEFCg5eLgxffkaAY8NVePZwKbt3Apovf1osgv9E1xvxEXwchJq5xIKiJtl
    4F+ZRoyLi2exMxNw+Qn3EmgAFFjFRAk0mqHLowLpj2cL2Edz7lPMAVoCshYsF/y8oFfCFY
    f52M1amAdF/ttzne6WWwXDlGDBfsOAZJRQT1uso6RZm9jWgjtl94vBAZ1nBcSpER9lRYUW
    lAB/f2CsR/f6fuvp3+xjWbL5L7ZBfE9MA7LKFt9uSdMpplZl3NrB+5HGNdTRsqi5QR51sS
    jdWmHhNCBi6IWy9iEiWuZVSpiR7m68s3THn1Drv9YEZnb2N47VsKSCtLc5qr0qxfUKAa0z
    +GfwYitvHDbovWqYqth2SsqlvrO1ifqM20mvnxcT2Xo/IGSWMe0YgV4b+2ww
X-ME-Proxy: <xmx:xNhKauP03yn8rAmlDWNxwedNOy4X9aq9l4cJ76FgUwZ-rX9BX9WLJg>
    <xmx:xNhKatsFGQw2RIwGA92T0j0ebnUt8ARe4DMiE9-5G_B7xQlYOQTIWA>
    <xmx:xNhKahZf_oA_zvJFMHBrsi3d3B6Jz0820BQOLOGe693BzQ_GVeBDFg>
    <xmx:xNhKavy2DEBg44WOkJ4Z8gcc_lkoE_-D9YDbBtEj6YJbyWcxEY_77w>
    <xmx:xNhKagBz8ChYE6sJRY-QSDTDZiA5SZj28T1bHunPfO3k0iHe5ZQli7jB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:20:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/14] nfsd: replace fh_fill_both_attrs() with fh_fill_post_noop()
Date: Mon,  6 Jul 2026 08:19:34 +1000
Message-ID: <20260705222032.1240057-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705222032.1240057-1-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22997-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 661FA70B9A0

From: NeilBrown <neil@brown.name>

fh_fill_both_attrs() is only needed for open/create and is used in the
case when the target already existed so no creating happens.

As part of refactoring this code it is changed to call
fh_fill_pre_attrs() once early on (so errors only need to be caught in
one place) and then to use a new fh_fill_post_noop() when it is
determined that no creation happened.

fh_fill_pre_attrs() now stores the attrs (which it had to get all of
anyway)_ in ->fh_post_attr.  fh_fill_post_noop() simply marks them as
valid.  fh_fill_post_attrs() replaces them.

This change involves moving fh_fill_pre_attrs() out of the inode_lock on
the directory.  This means that we cannot provide "atomic" wcc data so a
new fh_fill_pre_attrs_unlocked() is provided which marks the attrs as
non-atomic.

This is unfortunate but inevitable if we are ever to allow concurrent
updates in a directory (which can significantly improve performance in
some cases).  To get atomic pre/post attributes we will need to be able
to ask the fs to provide them, or to request a lease on the directory
for the duration of an operation.

Note that we haven't provided pre/post attrs on WRITE requests for a
long time for exactly this reason - we cannot lock the file to get them.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 20 ++++++--------
 fs/nfsd/nfsfh.c    | 69 +++++++++++++++++++++++-----------------------
 fs/nfsd/nfsfh.h    | 14 +++++++++-
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f8afc356809e..a93132323b66 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -327,9 +327,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
 		 */
-		status = fh_fill_both_attrs(fhp);
-		if (status != nfs_ok)
-			goto out;
+		fh_fill_post_noop(fhp);
 
 		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 		if (status != nfs_ok)
@@ -376,9 +374,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	status = fh_fill_pre_attrs(fhp);
-	if (status != nfs_ok)
-		goto out;
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -464,6 +459,9 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	fh_init(*resfh, NFS4_FHSIZE);
 	open->op_truncate = false;
 
+	status = fh_fill_pre_attrs_unlocked(current_fh);
+	if (status)
+		goto out;
 	if (open->op_create) {
 		/* FIXME: check session persistence and pnfs flags.
 		 * The nfsv4.1 spec requires the following semantics:
@@ -495,11 +493,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
-		if (status == nfs_ok)
-			/* NFSv4 protocol requires change attributes even though
-			 * no change happened.
-			 */
-			status = fh_fill_both_attrs(current_fh);
+		/*
+		 * NFSv4 protocol requires change attributes even though
+		 * no change happened.
+		 */
+		fh_fill_post_noop(current_fh);
 	}
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8b1a95e1d058..26980bbb195f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -780,34 +780,53 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
 
-/**
- * fh_fill_pre_attrs - Fill in pre-op attributes
- * @fhp: file handle to be updated
- *
- */
-__be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
+static __be32 __must_check __fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct kstat stat;
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return nfs_ok;
 
-	err = fh_getattr(fhp, &stat);
+	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err)
 		return err;
 
 	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
+		fhp->fh_pre_change = fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr);
 
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
+	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
+	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
+	fhp->fh_pre_size  = fhp->fh_post_attr.size;
 	fhp->fh_pre_saved = true;
 	return nfs_ok;
 }
 
+/**
+ * fh_fill_pre_attrs - Fill in pre-op attributes
+ * @fhp: file handle to be updated
+ *
+ * Post-op attrs are filled and pre-op attrs are copied
+ * from there.  The post-op attrs can later be replaced by
+ * fh_fill_post_attrs() or activated by fh_fill_post_noop().
+ *
+ * The inode must be locked.
+ *
+ * Returns: error from vfs_getattr() which must be checked.
+ */
+__be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
+{
+	lockdep_assert_held_write(&fhp->fh_dentry->d_inode->i_rwsem);
+	return __fh_fill_pre_attrs(fhp);
+}
+
+__be32 __must_check fh_fill_pre_attrs_unlocked(struct svc_fh *fhp)
+{
+	fhp->fh_no_atomic_attr = true;
+	return __fh_fill_pre_attrs(fhp);
+}
+
 /**
  * fh_fill_post_attrs - Fill in post-op attributes
  * @fhp: file handle to be updated
@@ -824,6 +843,9 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
+	if (!fhp->fh_no_atomic_attr)
+		lockdep_assert_held_write(&fhp->fh_dentry->d_inode->i_rwsem);
+
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err)
 		return err;
@@ -835,29 +857,6 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	return nfs_ok;
 }
 
-/**
- * fh_fill_both_attrs - Fill pre-op and post-op attributes
- * @fhp: file handle to be updated
- *
- * This is used when the directory wasn't changed, but wcc attributes
- * are needed anyway.
- */
-__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp)
-{
-	__be32 err;
-
-	err = fh_fill_post_attrs(fhp);
-	if (err)
-		return err;
-
-	fhp->fh_pre_change = fhp->fh_post_change;
-	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
-	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
-	fhp->fh_pre_size = fhp->fh_post_attr.size;
-	fhp->fh_pre_saved = true;
-	return nfs_ok;
-}
-
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index cdeb5eea65a8..ab15b59ac7b3 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -337,6 +337,18 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 
 u64 nfsd4_change_attribute(const struct kstat *stat);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
+__be32 __must_check fh_fill_pre_attrs_unlocked(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
-__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
+
+/**
+ * fh_fill_post_noop - Copy pre attrs to post attrs
+ * @fhp: file handle to be updated
+ *
+ * This is used when the directory wasn't changed, but wcc attributes
+ * are needed anyway.
+ */
+static inline void fh_fill_post_noop(struct svc_fh *fhp)
+{
+	fhp->fh_post_saved = true;
+}
 #endif /* _LINUX_NFSD_NFSFH_H */
-- 
2.50.0.107.gf914562f5916.dirty


