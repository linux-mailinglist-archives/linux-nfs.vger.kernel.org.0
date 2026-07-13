Return-Path: <linux-nfs+bounces-23286-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y59oEUCEVGpXmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23286-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:22:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D088F7477EB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=fSSVcJX3;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=lGoxCuma;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23286-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23286-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E37F3009153
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC235F165;
	Mon, 13 Jul 2026 06:22:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEC361640
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:22:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923772; cv=none; b=DnGHjogetuIIoEIPYQJjBa+q1DoFVJCI+fU7ZfTPRSPo6AAn0eHk2UR026M7jde4YdzSSGHx1cfQMAPCXOj43YNcVRcRlSwtMPKqPdzt6+5CI+CDfep5AFY1dzTiyAioYlkbh8+LltuC8fRVcpqBolSHuH8kx26xMooPbGZ3TCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923772; c=relaxed/simple;
	bh=PENPdn35KOsLoYppXMzCWozitH7h+PhQMr9ETRgvXkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duA9tmHUWYFjlS9STInkc4XICniMrw414atpW+056qoN8uSel6z6PPSaUl1Jop7rRrLb2u8g4RLSw0Ql/EPYibp2R4nwm27YbO46dHRTUooO7GxJjwNznmanfVlB3Mi68fjmOHlE3WRIjPIRmx52u7/h5KIBKILgy365R33KhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fSSVcJX3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGoxCuma; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6011E7A0048;
	Mon, 13 Jul 2026 02:22:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 02:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923770;
	 x=1784010170; bh=TX0Ubr76VvWbOnrE/T+PJfCfc/2aovQz5W7O1FNE2Xc=; b=
	fSSVcJX3bC1dgiyvfxugxFo1SteFm2CVgXUkjN4kP8bLlWxCXYm4JaQdzVTI3Oz9
	HYJ4MR6rHDY1Cb0jHOeBO3y1ndq0w0AhI5I2z9uPrgg6/bbOd+nkM2bNLfRaYYIo
	MfdOwojZ0fW2/LtdY4tRZea0yrpLA10uEXVOX0PdJ9tRoMfEM0H5UuZ9tu0NZSqS
	RbNPu1A4L0GFIrZ3U9IgYNHWn+zmZCu+pYFtF2C8JLVFr48Ff7V0U6LGyANLIGAy
	jhcJHlnjC0WdFkS8NRZaKNyXkrwE9vPRlP6AewlvMa+ImBU6jxYVEBKY3z/QxaXW
	5YODBc2Sthk0nENgiI5ayw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923770; x=1784010170; bh=T
	X0Ubr76VvWbOnrE/T+PJfCfc/2aovQz5W7O1FNE2Xc=; b=lGoxCuma9vyn0ZHMn
	xTuVOCetxptcTpF3mQkQEe5wvtsVJiG1qnJhp3BGN5cHmR0SK1mg48UPIF0RLLRO
	vneBH5juFyJN1fqQ5yHp8iGUnT7B0Qj4fniOz8Gs8D4mTGZvj8BK2UJCjlXeweLm
	VaFNL+1uElC/WcxtlUYLBxAE+TNnbzzB90cGUzWgAhsV3AAsyk0bhe6cR2DpHP94
	bGxB+G5vm+t7cUw/tGUVhzy5MTuBfTFbPTWLspsIuVsK6aECb/KWdRqOZigBj7au
	ufzYmxCzQ4t9opTuxMRkJVNVRNFQcy6s2I1L7Is1xpargJH/54f2Rha59fn2xCI/
	QiMIw==
X-ME-Sender: <xms:OoRUaqS0M7tkeZPTYD3iRsp_KlWer2r9ioAMbq3pxagYbvJcITBOoA>
    <xme:OoRUajeD8N_1AaNMKYWYkB-1fWVPHu6gs8SQbm7-bWwuTnKHYq1l2MsdwxYiaX3Po
    bT0-kudn61XA97nUki8aFIkm7WWBP4qRRUph3cIOI0lZsPMyw>
X-ME-Received: <xmr:OoRUahqjwmCYth1cxf9DwGRoZrtONW7VcAMRKm81Qfky10KPgTYmisXdw198nuJLMN2QJPNuG3bE1y9fOmvOYa0EfYBUXnc>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzit
    alAoL4BzDZcktjPU1rtmiYnMJGOe8fANZvDqC5n6Dr/EXAKteEBdTZZQQjdSW9S+L7auiv
    KlUOhTrj5zIfwBfCBiiLh+F+5JPxj9Mmd8Js42/lOUkcmEd954wHRCZ7XqU4yjkr7xHimt
    Z5e9ZKCz0POQUd7/HsMNBnvazUqWMHaubUY/cxWT55wC/5PiY6dZCDnyvfOW9B14WYW2qh
    pMmjyMG/WvMpejcQ2b409jNfLPnEYDkpQLxUqVsPufCNUF0b1WTfyM11ljV+xNMuCq0Pxp
    QgZYYM+MHgBp4dnfOGrIxGGCELDO1gvrfX5vI1OByplMKr9iDKs8kkBkmPlA
X-ME-Proxy: <xmx:OoRUas89Tt2a2rb04zk4q885xL4PQU9m-K9fQSeQL2Cnk0PWs31GfA>
    <xmx:OoRUalcaImmXBoF4qt_Doj0CeRPaJocyYk3eR-bpwrA5rxXVqRW-lA>
    <xmx:OoRUauJ_k7BvubuX29ZS64Fm-rth80nQKqoikBtPjkjRS21TJA3cjw>
    <xmx:OoRUatj1EqIP3kL3Y4zn4wO6p_YIbzqtHLPXbMWig7GI8AHbBZDmpQ>
    <xmx:OoRUarw6anmr7qG8tfcJoGlSy0BofRvDnHdl0les_dI7q_CkN_ZvYOLi>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/17] nfsd: replace fh_fill_both_attrs() with fh_fill_post_noop()
Date: Mon, 13 Jul 2026 16:15:26 +1000
Message-ID: <20260713062219.6399-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23286-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D088F7477EB

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 23 +++++++---------
 fs/nfsd/nfsfh.c    | 69 +++++++++++++++++++++++-----------------------
 fs/nfsd/nfsfh.h    | 14 +++++++++-
 3 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9a8c1e37cc0f..3e5c1fdde57b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -285,8 +285,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				if (status == nfs_ok)
 					status = fh_compose(resfhp, exp,
 							    child, fhp);
-				if (status == nfs_ok)
-					status = fh_fill_both_attrs(fhp);
+				fh_fill_post_noop(fhp);
 				open->op_truncate =
 					(iap->ia_valid & ATTR_SIZE) &&
 					!iap->ia_size;
@@ -357,9 +356,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
 		 */
-		status = fh_fill_both_attrs(fhp);
-		if (status != nfs_ok)
-			goto out;
+		fh_fill_post_noop(fhp);
 
 		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 		if (status != nfs_ok)
@@ -406,9 +403,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	status = fh_fill_pre_attrs(fhp);
-	if (status != nfs_ok)
-		goto out;
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -494,6 +488,9 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	fh_init(*resfh, NFS4_FHSIZE);
 	open->op_truncate = false;
 
+	status = fh_fill_pre_attrs_unlocked(current_fh);
+	if (status)
+		goto out;
 	if (open->op_create) {
 		/* FIXME: check session persistence and pnfs flags.
 		 * The nfsv4.1 spec requires the following semantics:
@@ -525,11 +522,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
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


