Return-Path: <linux-nfs+bounces-23291-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ziPVKGCEVGpmmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23291-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155D747811
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=bAe17O3B;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=mAMcPsjU;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23291-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23291-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FB55301E751
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081C3815F9;
	Mon, 13 Jul 2026 06:23:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C361DC3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923797; cv=none; b=GjayVYbztbUlAS16KThC3PYA/hn3WtbaRdgpRhsSJAuTC/9O/GV2zC7L/m6MI4Wo1Uy0iOqTkD1Z5dtL2CL5NDyE+e03Gv1J6ou7azdRi5fOq7jLnFy+0Vt4nZDLCY2KOH4/SefEtYZvLOrTnfXAWCqklk0Hy1H8qoADJ9Vv7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923797; c=relaxed/simple;
	bh=QVh4yw88URVf6DIa6SAd9c1IIUgnCWIuWtdaC3jkrCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSF4/YTJx/7uH9ymcUrron9PTfOc8sYOCINSiwNPPUwu46MIDraj9L+i8Yv/40rBJvh28RXtro0efwdvyWCbYPxqsYqUZsxU4A4AscJnMgXOhfKwZLpEJZVAuR66BoxG7f9uI+LEI8IfViU5aER3VzV+TQra5cjyNg2CHniOWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bAe17O3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mAMcPsjU; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A9B61D00056;
	Mon, 13 Jul 2026 02:23:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923795;
	 x=1784010195; bh=rNOOiY7792MdWTphiyu/Z7cdlpVdkgweARt4fbbWkVA=; b=
	bAe17O3B90UrikH4dKamERH4W474kyGLObL9cQnYlO4cIHlc4+l8yn2oU5skAZed
	ABnCUoFd1yOavDBzKMzQn1NKQnO2/VqaizvSJzaFOKvqNx0fkOwJlw4VPkamU3Dc
	SIM+mIQ4JDL70niBMJyiFbiBaAeZ826ej7yc4rwu1th0nlwX73Mmtg1ELVeDTJRg
	ugmYUQmiQwO8ftg/zZOZxp6rtZwBbZx6UaLVDoVORY5090OSZQS1lBeQBnH46vjl
	YZ9s/PZm/KtWMN1lY8oNdqkOd4vewnCi0sL+8H/aOQQZVEwp4Aop4KpxIXwEW9km
	AGNLW+/4qwqu2zVD7XxhLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923795; x=1784010195; bh=r
	NOOiY7792MdWTphiyu/Z7cdlpVdkgweARt4fbbWkVA=; b=mAMcPsjUu7NN/K5qY
	Ryd5YCycrEQKtIR5xR4R7EYGzE3DjU+YQkeiHyjpLGahzlI/ahnt3IPVUYmqTMRz
	aNRlhC1utxEbrkKY2W2Q33hLz3GdAkt+afweDiEz3N36CDSSvOeRFcqivKR8iyH2
	ABU3p0gFRfl8LlxUyvvb08nc/cqd1P7tlomvkGcjB8BAMOXxhG/8d+sP+lBPNWYC
	92bfjWMWDr8eg688cfZ3jXJT0kj2bNtnc+suToR4Q3TOK8W0V8DYG19TmPGb8MO5
	IMBahaffErQtOx+xkZygqgdQtJNDQkXfzt+2Th9rDgL4REdvEycF0McYUE+So4A7
	TuuGg==
X-ME-Sender: <xms:U4RUaoonrnJNJD1i1w-sNTuhyHV-33mSGGBqLqn2Irvy7u8ZJIPRpg>
    <xme:U4RUaiUTVmITN4115NLkIMNZvHSX6gye1YsIhvItoxRNJKpfpDUGcZNv820xFc7Xx
    -yN5g4Mj6Pv51PZcdfEKtnfG0Uz4veZ5uz8IOYikzxo5jc9hA>
X-ME-Received: <xmr:U4RUanC_uDjyqcLUPzWmeKSAkcsAe4TFSZYZqH8W02eIjVDOboaJiW-kr2GV-YgzJTyqi4uYlMZG6ycgGSKEvs-YxYxmGc4>
X-ME-Proxy-Cause: dmFkZTFfIeczxMyuVCuGJGpAVwQh0zZkbaIeOkLaWK7ryTOVtlJ/6pjps0fHW8awC4AtOE
    ibA9cJp3YfD4rECMNgH3UEcFeYIV9RiwoJPXCSJPficUXiZ3kx6j+xoVOfF/pjyAazIJfq
    4qIe5Dh0SS9ayBH/GbR8unfi9PobUSUVm2+zivY/3iIyghi3JSOCnHxybSBgxtc7kv7Fv2
    6meQ6+c4fJ8plU+oi/L+xxftvyA1H7EMfGykjoiDfYJxKmmKPVJNDF/B6BNwq6jmHq1VTM
    3syOeuoJTUYvPV1MvMCVGru8xGzpu5HrLRyRj0g5ngPOJNIxiicgEEdmhQcKZa6/fp7dRy
    v2ENQRwDAz28daHN12KUsRZlijkm8Nc0F4gDFmKke24oC7JVzjaSPocDNaU+8jjyNd39vQ
    3YIkkDJKCatQzWSa+HmHjUlG7pC2Mp4Q+bm5gx13cT8fnpcQ53o2aic5kkeU3tB21tdB26
    izQUsrI6VdLE1emzvzndra2Vs727711nNVJN5A8kGtFuq8+BkOiSlNwKa13hUkRNTKyrN5
    XZme4BhRm/ae7weEUWDASmaBzZ9KOz5f/QxrQNjuS//2U9s7K1CeEKP+PonT5FNVMUhTLm
    0gLkSmQ77GuQePGZtHRec6c2X4wHfwCEdvdnjD6m8geyWbM+X1Gp9dh2ppQA
X-ME-Proxy: <xmx:U4RUam2S1aHV6TyxptcM54Spzkw23p3h7nDdum_81C2xrl8DiOP2-Q>
    <xmx:U4RUap0Vb7Kk-9LNgDg7hWkhlZ7W4FrwWsukLo4jEvNxUHDes9RUWw>
    <xmx:U4RUarBgo2iP93WU6MNh6bwh91nLHgQZa7oUrNTLJmoe4D4RzazUzA>
    <xmx:U4RUao7Btibj56ugJIfuo8nLAmWJd1VWG7-VmUg7DiaZ8Ge2_xu-xg>
    <xmx:U4RUaiIJtRiDTZsHX618MjbG5BGrkCnTjlmeaorlXoiavsBdM9MHgqHq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/17] nfsd: nfsd4_create_file(): Move NFSD_MAY_CREATE check earlier
Date: Mon, 13 Jul 2026 16:15:31 +1000
Message-ID: <20260713062219.6399-9-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23291-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1155D747811

From: NeilBrown <neil@brown.name>

We only need NFS_MAY_CREATE check if the file doesn't exist, but it is
nfsd-specific code as it needs to check NFSEXP_READONLY and I want that
to be separate from vfs-specific code, which eventually all be provided
by the VFS.

So move that check earlier, but hold the error status until needed.

The if/else chain here looks a bit clumsy, but it will make a later
patch cleaner.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 83ad690a4948..33c112eda4c4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -260,7 +260,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry *parent, *child = ERR_PTR(-EINVAL);
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
-	__be32 status;
+	__be32 status, create_status;
 	int host_err;
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
@@ -349,6 +349,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_nsec = 0;
 	}
 
+	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+
 	host_err = fh_want_write(fhp);
 	if (host_err) {
 		status = nfserrno(host_err);
@@ -362,16 +364,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (d_really_is_negative(child)) {
-		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (status != nfs_ok)
-			goto out;
-
+	if (d_really_is_positive(child)) {
+		/* No creation needed */
+	} else if (create_status) {
+		status = create_status;
+	} else {
 		status = nfsd4_vfs_create(fhp, &child, open);
-		if (status != nfs_ok)
-			goto out;
-		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+		if (status == nfs_ok)
+			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
+	if (status != nfs_ok)
+		goto out;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


