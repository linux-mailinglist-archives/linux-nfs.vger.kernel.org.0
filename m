Return-Path: <linux-nfs+bounces-22150-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH6SOYYwHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22150-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120B61AB7B
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BFC308EB92
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC02E382398;
	Mon,  1 Jun 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="rFWwQat0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V509vnXj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8B35C180;
	Mon,  1 Jun 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297312; cv=none; b=Y4bYrAiaIhoUMEVqI35tbdW3OlTvB62N/UlK3YABdrVLhVfWFWI+Qiho4dazg2SsqkbKnq+9pydfG1Sw0XXIyYOTsbm3QRSeLpVNowx9lQxaKlnJ9oynLi1ZVJ5u9toI/gu8mvEDlk9E1DwoW46Jv2VIKRTAPAQ8ua8jgMRX/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297312; c=relaxed/simple;
	bh=WdEMOzcsDChipQldHx7oLl3JxEQOvDhlD+JF5fLHDDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAtJNdlFtVkDhxK9kVoHfL6SAGftStWeb2NuKim3EruKXxfq62NCBog0FmGmE5Ds+hciNWwVYHVHO1djEJ0rHBhAnJQyYs+fz1secCGUP/PGXMZe3ON2dZONltm4nOIvg1ZpEy4VvTCYbCOvUrKl+Pd+TDQqdEdpepkvGqpjrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=rFWwQat0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V509vnXj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B42EBEC01CA;
	Mon,  1 Jun 2026 03:01:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 03:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297310;
	 x=1780383710; bh=KbuELhquSMglCIc7yfH+vCmCpoV49ZOEp1JXA1a2Uxk=; b=
	rFWwQat0zZU5Nlqu9haVDD6aoQVOc7KdKS4eRw6XRKZkGQWr1hypjCePmG68KHig
	uTIzbaTTCo/u4wadFBMuibOdsbPjte9xmFcf0mh0PgrnRu/0LXcOeG106L9zzO9E
	fw5yKeudVT3b4ERKoyqDni1Qlf2powVlQDl5nEvS1SLBFY8+kF6G1/Gym+wLANAR
	x4+9e6qg6BpqSefA6HFoTZLAMoTbSb6sMBzwUX5nQ4omcffCxkO66Jr9G7yNLGlK
	5y/yQyurOu6CImVAkCHKS8n3hf59Cst8Hg+R02KiclyIARZxhi0JAPSKZEOW7AYr
	Vnm+3WBl5NHQO45Sc0NEyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297310; x=1780383710; bh=K
	buELhquSMglCIc7yfH+vCmCpoV49ZOEp1JXA1a2Uxk=; b=V509vnXjNOKmTE1zG
	uNyyswEu9CnRmgg53vtLEIsQrMjQc5SNmE0zvHabOEYCLKvdnludHofdOqwoGDMU
	L9bdN455q5tkdSn/D/08Tp1qZVLa3mwr8pGvmKp6LlyYpPH3yKzXjpk7ZDoLfRLz
	GIH2V78ZylGA/oLYYf4LkNeKGhK5W8uCDsHnG4epoc9X5ISta+pgY6EluLLxC1ri
	YJ1TBrA0ANUsZANbpWD/64OXSrmZFJfuvBllkDEUxRF3yw93N0riOTVPLtzivkUu
	F3MsB9eqQF9FESy0FinfhhkInKTvvfISCuRpZOaIEfA8NeGBIGAhAWAwz+gTDwIk
	AQpuA==
X-ME-Sender: <xms:Xi4dagBes6P1d6zygb49kCuY3RoBm5jQVStIPSffKU8X4u_zHcNaFw>
    <xme:Xi4daiPITQvCh23oS-S0Dda2w7JiQAoDlu9nuZsYJm7e9zruty5NEQJOPV9n1z5zS
    Rht1_N-Ry9pE1LZxC57ih64X4fGomwoZlIt-M4pGssopnC0KA>
X-ME-Received: <xmr:Xi4davMuqu7KXe39CGxjSutuiclQSs-TS7pJH3exdnHAzUEzSxJPKfSbIhiGtPi_ukouCW5mFOOJA0PkMSmEe5lRd3y6LOQ>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrHA
    0lTDvgLwAgRRrwEDu5+5PH01ovwRswGIylxRGZQuJwIsvVrmwJehk4nkVpfJM0ZFP33L7x
    d+DmbuAECsTChGEyyIbzhrdre3v58Ich+1gckNAdm/GhgcZEJ0L4Kl4pzxblMYLWkZStpO
    WuX9Uzcl0SEz5haoiZ2+5WTCjdgYfMrgJmCljaE2elMr3wnLqLPV8Hd4uef68Eg9LpN++b
    nZp8ldWOCB9o2iU4/Uv9C/Sf3y4ElXXAuH+i7tcGGPEVFchOjvEBXhf+2HNFQgT384Riv7
    y5zJWauDm34YY+L/rcUw9uKghwkTWEP8eRnhGjHF43D2F5vfStWXtt0+PJ+w
X-ME-Proxy: <xmx:Xi4daimT9n2WwJde2UlfgZhlpw2NIS4msh5-S1xv2Sy7rLKQHieKPA>
    <xmx:Xi4daltR5FhAfB1wAPL9NmmHdTm57ra1FLhrHI5Au1D6sdjWwB4mVg>
    <xmx:Xi4datqA_bNRL6woAFhbnIfsR625bMYOEFStP0lwhcXQRLuqTtEOyw>
    <xmx:Xi4darcj3fY-y27X-msLrvMjSDh0BhnSmvDWqUMHLA0vzx66QDD3qQ>
    <xmx:Xi4daimmq2pGKCxFwn9-QhMBU6L51Lir99zFSQt43qVT5a7sVXXfzL3R>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 10/18] nfsd: in nfsd4_create_file() let VFS report if file was created.
Date: Mon,  1 Jun 2026 16:37:58 +1000
Message-ID: <20260601070042.249432-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22150-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 8120B61AB7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

nfsd4_create_file() currently assumes that if a lookup failed but then a
create succeeds, then the "create" created the file.  With atomic_open
this may not be the case - some other actor might have created the file
between the lookup and the create.

So we move the call to nfsd4_vfs_create() earlier and set ->op_created
based on that.  Then use "!  ->op_created" to trigger nfserr_exist
handling.

The switch statement is split up into two if() statements.
First we check for the possibility of a successful exclusive
create and set ->op_create to true if appropriate.
Then we check for NFS4_CREATE_UNCHECKED to decide if a
pre-existing file means an error or success.

This allows us to combine the two fh_compose() calls to one place.

With this rearrangement we now repeat the setattr when an exclusive
create is repeated.  This should be both rare and harmless, and it
simplifies the code.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 75 ++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3446f9b43bf8..bce64e2061d7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -337,58 +337,49 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	if (d_really_is_positive(child)) {
-		/* NFSv4 protocol requires change attributes even though
-		 * no change happened.
-		 */
-		fh_fill_post_noop(fhp);
-
-		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (d_really_is_negative(child)) {
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
 
-			/*
-			 * In NFSv4, we don't want to truncate the file
-			 * now. This would be wrong if the OPEN fails for
-			 * some other reason. Furthermore, if the size is
-			 * nonzero, we should ignore it according to spec!
-			 */
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
-			status = nfserr_exist;
-			break;
-		}
+	if (!open->op_created &&
+	    nfsd4_create_is_exclusive(open->op_createmode) &&
+	    inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+	    inode_get_atime_sec(d_inode(child)) == v_atime &&
+	    d_inode(child)->i_size == 0)
+		open->op_created = true;
+
+	if (!open->op_created &&
+	    open->op_createmode == NFS4_CREATE_UNCHECKED) {
+		/* NFSv4 protocol requires change attributes
+		 * even though no change happened.
+		 */
+		fh_fill_post_noop(fhp);
+
+		/*
+		 * In NFSv4, we don't want to truncate the file
+		 * now. This would be wrong if the OPEN fails for
+		 * some other reason. Furthermore, if the size is
+		 * nonzero, we should ignore it according to spec!
+		 */
+		open->op_truncate = (d_is_reg(child) &&
+				     (iap->ia_valid & ATTR_SIZE) &&
+				     !iap->ia_size);
 		goto out;
 	}
 
-	status = nfsd4_vfs_create(fhp, &child, open);
-	if (status != nfs_ok)
+	if (!open->op_created) {
+		status = nfserr_exist;
 		goto out;
-	open->op_created = true;
+	}
 	fh_fill_post_attrs(fhp);
 
-	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
-	if (status != nfs_ok)
-		goto out;
-
-set_attr:
 	if (is_create_with_attrs(open)) {
 		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
-- 
2.50.0.107.gf914562f5916.dirty


