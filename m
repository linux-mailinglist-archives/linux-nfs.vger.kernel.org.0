Return-Path: <linux-nfs+bounces-23007-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WufqLwvZSmpkIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23007-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:22:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6F70B9D9
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=LerxUQnF;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="nB3Db/10";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23007-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23007-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3413012D09
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1C34DCC8;
	Sun,  5 Jul 2026 22:21:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC635F193
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290098; cv=none; b=Nz0c0/J+XEvRLWm+M7dizOuKJ492PL3xMq36iNkL4590L+G7EgP4KBT7cNfwkspffy4LBetlUwxXrj0+2xklp6/NrlGEck53AvRDv/tgDs2ISq4BCVKRsUvt0LItwkTybRxa1ni2q2PSSM1126EdeYRnHj83CzqIZZFaHk9nzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290098; c=relaxed/simple;
	bh=zqTW2wUsCFjUJQRKKXYm9THfldtbR14HrXXJtVOmzpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTL4IKPNLV4ZPQl6uBz8u+w2KgqBJyNFtieiNSlWau2VOM2D0b2fz5KxndtY0/qxK1dQymoEiefW8ht/TRlmvprJOxsl/V86Romjy4I2/zDcXeJ/O5GbY0kLqnZ9sBEutaSIWFehV5YCBPNs4vQ9BTVu+va6+Gh8B8YPSqlGsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LerxUQnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nB3Db/10; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56B191400012;
	Sun,  5 Jul 2026 18:21:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290096;
	 x=1783376496; bh=aV53em8KcHEl8ZpifZiXZingDnFy9s6/96/5C8/hyso=; b=
	LerxUQnFykArPGqnYOhdLjnvIHbuj6lAW7lvH331lBuHM0JnsfKxBix28CvVE9u1
	rf4J4XACUs7RXd6f1kqvxe3ONapgV7rUqifxlTRrCbEGFOcLpa24sWMDuPT07UzJ
	xkynWmBOvVbvnrH/zYEWbjaWXuTe7ny8XcBYH2tPdX8y27hfXoIMJWedcAvWKhpR
	2DHm654TusPeiKQGU1M2aRtt0cumfkGacMaggxB/1mpxAT0NtiqrlRgHbg1XSX5B
	J0Yw069PF4VGn/zKRe+Z+R1Ox0NM6PZiwU3K6ymV/vqujk1+7Fl3OaebZIZsp7h2
	wQaj02zgQrY0y9lila+x4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290096; x=1783376496; bh=a
	V53em8KcHEl8ZpifZiXZingDnFy9s6/96/5C8/hyso=; b=nB3Db/10RFqrQ/ejY
	u/sXdvvqqX+NBwJCivDX5nbVkVzzTB7DCbEz7UxtwbEPHrjz5CH6PAiteyoMUrYm
	c8vo0+GaxMIwrQWG4F0oTtZaeQ+LPGqGpHPPNv3XBcY+/Ys9BVRchdfeALep1KZE
	Y3PMVZc5U2MfMVFvPDzXiBpWXbDmDI7G/hCN62Xn/f6+YvMVbA25w8sWSfFXjo48
	2N5X2RY54A2gG5uLGbEW7y0NBtcGYetCH760YGe87PpUnDxtQ72ZSlG1gZF6rJHN
	EgXw+PLVLNoiY6rU6C93/4Tx0hGUAUi77QAbwG9QH3IZ8FshSsnZNkrIKZTzyazK
	MIPGQ==
X-ME-Sender: <xms:8NhKasCRQeFQdozKhT7hFYwDKKU83NEUNlPul8pzML5T-C4sG1tPGg>
    <xme:8NhKaiPQTqZ3mJKM5955x70qX3Sw0VW41u33CYKskLwnHRLc31ZMN1ATA5fCCjd9H
    p4lrbR0Y707kRv1EVCVJw5v93nPCMeSJVPFaDrGNc7aoZxT-Q>
X-ME-Received: <xmr:8NhKapZrlSGOM0zT_UmIjtkO2KXLMF4ivfCi-IK1lc-ZnW2cva1ZEvf8igwDIqGEWexUMJm1KoX4AieFTOCBcEO5tBiaO2Q>
X-ME-Proxy-Cause: dmFkZTF0YcQ5/RatK2cyJlbfE7M9CwaOcSZuP/T/fJ8+XInZaqxHj7aGc2JZlfqxkZ1Qnb
    5pIxU9QzoakZc0IdtOoXKKnpZniKDX0JG+ndb/siPWPBdeP7+Bn5gaTvUxk3c9pDZEOccS
    ZUVnOEXCnNTf4W4kowKgP8JF/eZsbX7BzvByipTtOkrknQQGU91k5ndYz5iApF6SjSjw6P
    Qhi8feNcqKNEbdG0PK5/c4f6xkxJb3xixST9Ou1zT9lF7x0QDR4JasUarp/Jc+/HH1cd2X
    yinvfhvJbnjnUmHJDnMFbUX2AFkaKnzRa+mYJX7LzsktGmf3G5fUjTJc2x4Ao2IjCyM7VC
    KIjYPnDTTgmYCliqSxL7DAgvFqaehBGkb7z29bOYbe15kpPWn8YO6p6z6eAbbcfu6HhUN+
    UiXJOnIv0pw9GQNTUDNZs+pvDMmred0lkUS7HZyWnZNkakhxnPFlOG+AGWrm4sJGj8Nfg9
    DvG+76ZRb7Y3iG2tEg5MDjecl0uytZvvSe/Y7bXcPuncFkn6tPFC4PiVYs/uVYFL7HyV7x
    k0oukuxdrwbcMRT+FmOAaGA/JCDJNEbLBW0UIUPqvpKBobQ6GirQDqgTBWS3RllY+UFaSv
    KAtg8kQ/Y4GEldFm9nqzFmhvmpIqMIuJesMKqdFCk62s1/OhEcn7/PgRM/cg
X-ME-Proxy: <xmx:8NhKapsCfbFqEzQ7V0Q_nYEDHWuwDnPEaqd1HfjlywB2rSUM81mYUg>
    <xmx:8NhKajMt6xk8Gf2iGUetbdy4F6rIosGD9OyketmMWQHzrzHb0yaZoQ>
    <xmx:8NhKao4v8sctbRu_m392JjzSJJJBuxv95Ivwru8qfh0ggSk9EH98kw>
    <xmx:8NhKahRKyMGIkhRTdJh1EWreJM0uIdouEwH0D6CxG--MW9Y_e8uy5A>
    <xmx:8NhKatgS6cGeUDOUhsIpHJn5gZUgYGfrwCgQy76qVDQuReXYxaShKQ3L>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:34 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/14] nfsd: reduce want-write range in nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:44 +1000
Message-ID: <20260705222032.1240057-13-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23007-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12C6F70B9D9

From: NeilBrown <neil@brown.name>

nfsd4_create_file() needs write access to the mount for two purposes:

1/ to create/open the file.
2/ to set attributes on the newly created file.

Normally a file being created would be open for write, and once we have
an active open we have the write access needed for a setattr.
However if a file were created but opened read-only then the setattr
wouldn't necessarily have write access to the mount.

Currently this is all handled by holding the write access across the
open and the setattr.  A subsequent patch will necessarily change how
write access is gained for the open.  So we reduce the range for the
first want_write, and add another one only if setattr is needed on a
read-only open.

Also we need to ensure that we actually do open the file which
previously we didn't if it already existed.  So we add a call to
dentry_open() in that case.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7bb476311195..10323c620b71 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -307,21 +307,23 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	host_err = fh_want_write(fhp);
 	if (host_err) {
 		status = nfserrno(host_err);
-		goto out_free;
+		goto out;
 	}
 
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
+		fh_drop_write(fhp);
 		goto out;
 	}
 	path.dentry = child;
 
 	if (d_really_is_positive(child)) {
 		/*
-		 * open the file so that we consistently have a valid
-		 * op_filp.
+		 * open the file so that, unless it is O_RDONLY, we
+		 * have write-access to the fs for setattr below.
+		 * Also we can be sure that op_filp->f_path.dentry is valid.
 		 */
 		open->op_filp = dentry_open(&path, oflags, current_cred());
 		if (IS_ERR(open->op_filp)) {
@@ -343,6 +345,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 	}
 	end_creating(child);
+	fh_drop_write(fhp);
 	if (status != nfs_ok)
 		goto out;
 
@@ -386,7 +389,24 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
 
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+	if (((oflags & O_ACCMODE) == O_RDONLY)) {
+		/*
+		 * We will need write access to set the attrs,
+		 * but a successful open won't have provided
+		 * that.
+		 */
+		int host_err = fh_want_write(fhp);
+		if (host_err) {
+			status = nfserrno(host_err);
+		} else {
+			status = nfsd_create_setattr(rqstp, fhp,
+						     resfhp, &attrs);
+			fh_drop_write(fhp);
+		}
+	} else {
+		status = nfsd_create_setattr(rqstp, fhp,
+					     resfhp, &attrs);
+	}
 
 	if (attrs.na_labelerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -397,8 +417,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_paclerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
-	fh_drop_write(fhp);
-out_free:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.50.0.107.gf914562f5916.dirty


