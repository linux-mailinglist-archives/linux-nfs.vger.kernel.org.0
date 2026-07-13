Return-Path: <linux-nfs+bounces-23290-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7woBFWEVGpfmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23290-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6320747801
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="j/bwCth4";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=RG8VIoaT;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23290-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23290-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5158930098B1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077723624C9;
	Mon, 13 Jul 2026 06:23:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6A361DC3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923793; cv=none; b=c5/cdxdL7BtYPTv6E+jVZ2BZmC79gYd2PFKiqK9hU9nnsju81ldSCXqtJeoBSol1UN5Xvdebh4k9kDCiD39v89ADRLrPL0uSt9V3ccNmO3+/FMnqF2wh1FrQKHLspK9tRYbrdjm04wZtLkzzDQXLwn+ZR0SL5Y7oPnmiIQFSp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923793; c=relaxed/simple;
	bh=q8cWGmcVmv4ifL8VHfsJ1YT4YsonHClP6fcyiC7Jxao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ/ZhUf89mp2LVryU/fzR8LpVycLUajvha5mfnlE0HLDjGnmAJASSlTZuQ2W8SP5F5cl6fCIo7AlIgxhZtJj145yICVmjcnIW5Lnxd/xPplJ8MDaROs4UMjC6915+zsqIzCU9Brhy2GtemQrqupSNpS5/4hnV4t7XdL6kK61c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=j/bwCth4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RG8VIoaT; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 79CA61D00059;
	Mon, 13 Jul 2026 02:23:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923790;
	 x=1784010190; bh=pGbpuI2PAo6ox6Ex2sz2z9lWuA26O4CuCI7/CbUSKu8=; b=
	j/bwCth4pU1Lpi31OBysUQGGfI0KQqxfBQ9uE2KZmpSVMto0KMrQUuX2bDwBxih7
	nXpPAejUySOgfjHmnYjl9bUrhAEgFfl/QOFfpDSIfeQuXhvCab1qt1YuMzH/gRmx
	4zBFf3omE29dlAeO4IWi908n7r9pKXiNDHgwsC1gjnnlmvVMic/8odCYUS0Ppl5R
	IbyMOhIss1Quqv9dwgpXFzcPeJ4LFdmaooIkih8YNTd67NMl+IVEf5KHs5/ECefQ
	ao4qKEggQJZYdIhifnyq9eh9PBsDfu1WnflQUS3LT6mcBBqdFpLec2QDYn6HWNaw
	ybb6t5LylabPwFXGLGJejg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923790; x=1784010190; bh=p
	GbpuI2PAo6ox6Ex2sz2z9lWuA26O4CuCI7/CbUSKu8=; b=RG8VIoaTFcK3Bc6MR
	wdSqyfMJx6SH6fNkIRRPKvUuLiIKLs4sEdilducXcpHs0bOG43+iqI6lGH1bMb5l
	Gq7EjHp75tZnVY4qKqJZTTqkAbR/NFUMSORJY6xzzSYypHWEtypyzZklWbo4Vnx1
	tXDijTH65epInnzBNwdxa0zA8owfdwnXtcjAZyVouWSQ9hd6Y7fU4E/f8u+E6j2f
	vJZkHcZ56YgbkoaojGBbHSE/OajEAeG35U5YanTLgB0yySsJWZ/sBModa3Kt0xAV
	H+D97jCG1RQ9neaAKQTYkS6vC9RoJFoWqAmej0ZcgqNhuxz65UQS2Qn6Tz1EhXVu
	zvC6A==
X-ME-Sender: <xms:ToRUahqTT5a9lWTQVX5kgsmHyqV_PeVzY2B0Ji0Jt5hlqxzSadmKjw>
    <xme:ToRUanU_dJ0OB5syFEFNNbzxPtyTzifXOC3fWxgGrWooTRS_aSdZdkhyJbCJl0aI1
    uzhHQ3mYLam8OtUWj_s9oBf93XcuYeb_ZrJ5QmYd3mPfrQDSg>
X-ME-Received: <xmr:ToRUaoB9IborqqDZHy218mAXoZkPPxTmMHbwyZVqBbF5dFiDbo06E15WsWEH2oFskti1i8snvtLIuzMDHqFLCwJbYcz1XvY>
X-ME-Proxy-Cause: dmFkZTFfIeczxMyuVCuGJGpAVwQh0zZkbaIeOkLaWK7ryTOVtlJ/6pjps0fHW8awC4AtOE
    ibA9cJp3YfD4rECMNgH3UEcFeYIV9RiwoJPXCSJPficUXiZ3kx6j+xoVOfF/pjyAazIJfq
    4qIe5Dh0SS9ayBH/GbR8unfi9PobUSUVm2+zivY/3iIyghi3JSOCnHxybSBgxtc7kv7Fv2
    6meQ6+c4fJ8plU+oi/L+xxftvyA1H7EMfGykjoiDfYJxKmmKPVJNDF/B6BNwq6jmHq1VTM
    3syOeuoJTUYvPV1MvMCVGru8xGzpu5HrLRyRj0g5ngPOJNIxiicgEEdmhQcKZa6/fp7dmn
    m1D7o+rF8B/p6eMdcT0hbMPCAhMN8trp6kwF57EEYF9qKywlI0sE2cwXl1iSrsfhRKUFdh
    EbcbOTSR81MSFsLLO+5anKR3LQ4jrNWHfFs0hhITalMZa01aumkryoqme60J/LeF5J7Ee9
    uttmA9gXmPqNlP67GheS8O61LX1XOqHP55LgQ/grRKrnO3ejzCedT0kw2o5Btv/ScFQPK0
    azDdySKuAhF+sYn/M3/q3IMmVQKk8RdA7QIm1iK9HCU5J9cIQvOpH0sE/prlxk391strmD
    nowgUl1tAk/X/tlINA1Fb30nHdoEde22uLH4XCJeBJdR71wuv7uld1bHdQVg
X-ME-Proxy: <xmx:ToRUaj3f8Oz4luBU46kEOeG3eV2BdraYEyax853kWn6F3Z84HMBaRw>
    <xmx:ToRUai2q0WOAB5vPX98GpfXZJHSDXFgkG3zBc5rPvLZi_HqSgPgWzg>
    <xmx:ToRUagAC1lUEYU6gjX9QSDBS4I4TcIXt7guTRTUmlD51LrtLXlBVIw>
    <xmx:ToRUap5Q87fXW69mxibNzDI62MKZufRiAhGs1ByrUrgIer08zJWQ2A>
    <xmx:ToRUarKIasZM8iJbNx2TjMGQv3PocHCc0lYEDIFwZ3fyi_tjGtjJlOeh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/17] nfsd: in nfsd4_create_file() let VFS report if file was created.
Date: Mon, 13 Jul 2026 16:15:30 +1000
Message-ID: <20260713062219.6399-8-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23290-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6320747801

From: NeilBrown <neil@brown.name>

nfsd4_create_file() currently assumes that if a lookup failed but then a
create succeeds, then the "create" operation actually created the file.
With atomic_open this may not be the case - some other actor might have
created the file between the lookup and the create.

So we move the call to nfsd4_vfs_create() earlier and set ->op_created
based on the FMODE_CREATED flag that it set.  Then use "!  ->op_created"
to trigger nfserr_exist handling.

The switch statement is split up into two if() statements.
First we check for the possibility of a successful exclusive
create and set ->op_create to true if appropriate.
Then we check for NFS4_CREATE_UNCHECKED to decide if a
pre-existing file means an error or success.

This allows us to combine the two fh_compose() calls to one place.

A subtle difference here is that we now must only pass O_EXCL to
dentry_create() for NFS4_CREATE_GUARDED.  For the EXCLUSIVE create modes
we want a successful open even if the file already exists.  We then
check the verifier after the open succeeded to see if it was exclusive.

The above requires changing dentry_create() to reliably set
FMODE_CREATED when the file was actually created.  Previously it only
sets this flag when atomic_open is used.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c         |  2 ++
 fs/nfsd/nfs4proc.c | 69 ++++++++++++++++++++--------------------------
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 19ce43c9a6e6..9af1d5bc89fc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5077,6 +5077,8 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 		if (!error)
 			error = vfs_open(path, file);
+		if (!error)
+			file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(error))
 		return ERR_PTR(error);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ec3e31376da4..83ad690a4948 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -210,7 +210,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
 	int oflags;
 
 	oflags = O_CREAT | O_LARGEFILE;
-	if (nfsd4_create_is_exclusive(open->op_createmode))
+	/*
+	 * For the EXCLUSIVE modes we do our own uniqueness tests
+	 * so don't want O_EXCL.
+	 */
+	if (open->op_createmode == NFS4_CREATE_GUARDED)
 		oflags |= O_EXCL;
 
 	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
@@ -362,22 +366,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
 		if (status != nfs_ok)
 			goto out;
-	}
 
-	if (d_really_is_positive(child)) {
-		/* NFSv4 protocol requires change attributes even though
-		 * no change happened.
-		 */
-		fh_fill_post_noop(fhp);
-
-		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+		status = nfsd4_vfs_create(fhp, &child, open);
 		if (status != nfs_ok)
 			goto out;
+		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+	}
 
-		switch (open->op_createmode) {
-		case NFS4_CREATE_UNCHECKED:
-			if (!d_is_reg(child))
-				break;
+	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (status != nfs_ok)
+		goto out;
+
+	if (!open->op_created &&
+	    nfsd4_create_is_exclusive(open->op_createmode) &&
+	    inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+	    inode_get_atime_sec(d_inode(child)) == v_atime &&
+	    d_inode(child)->i_size == 0)
+		open->op_created = true;
+
+	if (!open->op_created) {
+		if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
+			/* NFSv4 protocol requires change attributes
+			 * even though no change happened.
+			 */
+			fh_fill_post_noop(fhp);
 
 			/*
 			 * In NFSv4, we don't want to truncate the file
@@ -385,41 +397,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 * some other reason. Furthermore, if the size is
 			 * nonzero, we should ignore it according to spec!
 			 */
-			open->op_truncate = (iap->ia_valid & ATTR_SIZE) &&
-						!iap->ia_size;
-			break;
-		case NFS4_CREATE_GUARDED:
-			status = nfserr_exist;
-			break;
-		case NFS4_CREATE_EXCLUSIVE:
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
-			    inode_get_atime_sec(d_inode(child)) == v_atime &&
-			    d_inode(child)->i_size == 0) {
-				open->op_created = true;
-				goto set_attr;
-			}
+			open->op_truncate = (d_is_reg(child) &&
+					     (iap->ia_valid & ATTR_SIZE) &&
+					     !iap->ia_size);
+		} else
 			status = nfserr_exist;
-			break;
-		}
 		goto out;
 	}
-
-	status = nfsd4_vfs_create(fhp, &child, open);
-	if (status != nfs_ok)
-		goto out;
-	open->op_created = true;
+	/* file was created */
 	fh_fill_post_attrs(fhp);
 
-	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
-	if (status != nfs_ok)
-		goto out;
-
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
 
-set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 	if (attrs.na_labelerr)
-- 
2.50.0.107.gf914562f5916.dirty


