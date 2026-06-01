Return-Path: <linux-nfs+bounces-22156-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MgYLeAuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22156-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:04:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578761A9C5
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1BB83009177
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BCC382F1F;
	Mon,  1 Jun 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="m9E5Brxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dp9oN9dY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907B3491D0;
	Mon,  1 Jun 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297343; cv=none; b=BDBWXtsF4UxU1i0vm++GuTmzDj9ldrZ1nsZ/NohFpABT85TrOztWC5/cmojsBDy6SUwqLfx3+PTVl+MXtmrwsUdm/PEGPRT2tRMHWNzDIikEeYgCYnha0K2XO964BSM5Tzf10blOCHe8RN5jUbSbMYHLj/lNUUrkOSZ6TRhZBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297343; c=relaxed/simple;
	bh=P4KwkPt0fMoERo61EV1t//1o0ysqzdLyWxGs7RW9dNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHy95P6+0ZojhOj9RRcWhesbNAsG6tjMiZ8KFZupE4PCQNfblAe5oeFj8Bw8bmhYBAbinRfHh/u708S50GrqSqbG+ABWvzq/w7/NYIO1CjNJb1GbaLedyjvtfZJ1thoIAPgsHHxrlsGeG+XjlJIn04CySoveOYkzcmfuzEZ6Nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m9E5Brxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dp9oN9dY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE79C1400094;
	Mon,  1 Jun 2026 03:02:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 03:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297341;
	 x=1780383741; bh=ukA0waQZgFpOMFmIchLsDRcKXGnCYiu8mnELMKajGXg=; b=
	m9E5BrxwLfUhwWGUpvdnnB8COjK+vUQxBrBvVhAPnThz8TtU6CbuqzsZL9uMdffa
	On7og9wZFbMvJ3QuedWEQsvS1CHZblpVZGF3C7I4dejJ/jDcnk/irKc2huxVzVAW
	jqz9vVKY4GJ1JHT7vFu2euW7V1hnOn0iDrpGcRSIrb+i34BHVyWnuH6/JKGmM1v+
	bBPnno5NaRB+JSPSOUpNmFFafv9PKRYH2UftlwuBdtGrmdwI/UYm6ll0U2IN8hjr
	OMWQPSw8b0kFppZtlCrtro09z3+eXYYRUYYo4c2gGyvsD7iylcXRY6BAlJ54bvjF
	ZF3/KGpx2XdGtNwHazhegA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297341; x=1780383741; bh=u
	kA0waQZgFpOMFmIchLsDRcKXGnCYiu8mnELMKajGXg=; b=Dp9oN9dYFKwWcwhuq
	O0B9AfcUP/fn8AoYM8ry2HPDLqu3kHoaNb51RpfthesYU3bjXnNCmLoDpP05F77c
	EVxNLTEn77ctCXHe1bs4v9Z5T7vm8pnzvo1HPzemFEj3/4PIXpOwrlDrt9oSEcjL
	kYhINUXwoYJv9kNXHE7hjWT2wHRyUIUTTBvy08zLzVzhFQdMoBruLhS4JB1D5gdP
	IZ2DF4/6vcdL2mZG9W0tBuawlckaakoOUPJdFtLJz0Jodsdza1e69u+lI30k26Su
	qB3iKSAZaau6h8JJEwauvrrwgISaSTNxr8QHWIAJd9QfRBpYSKtLi9f9+wIWryKJ
	5e02A==
X-ME-Sender: <xms:fS4datILkzA3yHmsOk4gJIcouirss7KGVMMClDpVyAfhCOS913vGOQ>
    <xme:fS4dahXFRI9LkAWxXe9_tt8PhLafXKkY6ngWjHx7j8pJj_Zva7N7MbXEgv1WRyPyo
    myjhQTRLrlUmLKxPA-VrIP0cKAyqIPxvUwaJRu-JKXl01s>
X-ME-Received: <xmr:fS4dahSKLzgTtl_flb5ms23P5CUHAg4tqvOilbBorHpn-9Q1kVcAAYLSQDh3-OKlVM3LZ8aOYYvrc7UGRfH8TIZQK05zpDk>
X-ME-Proxy-Cause: dmFkZTEgR6diMCMa6EnVcELIeOICUwDytpzxRoaX3cppGZ//nuze5BoRZw0gMzCXMne/59
    vE98z0G4+0wLvGmAksx6DmNPRmhlbTRSsL31Q90ow1y+hV81ybtjEiSxrN+eJMnimzaaa8
    iTIw6wjyuaPJIJ7/97HrR7QqLnI8WarNP1FMcUV3UNh9YAOT0MGKFmFrBpXZarxVSdTiU/
    lYhFKBr2Er0WxMgmz5b6jWLF4SmkovwAtJLyqS5zFsEETE7toZaBw1+UOOQhvtbkbD013b
    OW+OKcY7U3RpwtifgS3tHBz6STC+GpEcOHZ+hW3mwfdkYsOMfz4OpvdP2ZU5NPTsf1Zcrg
    BCD90GFvFNoO3oqfCTgZ6//+Aha5/AMWmr4Tqwaqp1UsrwJBpvms9rTmZtIiUR8CtLRQWl
    TWF06HtINXOatFSPMYIHkyx4RoJGmzxQyVeXGi+hecSAsQyUk1AJTgKbuZTQHH6ijirjfl
    fcjQ+mNcFb5oejXXroaGBLh/ERC6NoZeZEgtm38haVQrbzVk3riS6CLVhlaa8bOoWuII4M
    KWqN9mEk8D5O/a7NyxdznSUQnEIG5XtOVInKob61nktUsDSzIqglgPvWfoSqygo3xQcuIi
    SVVj5kcjzXVw59lECdFyGYTAUCWQrOxltymOC5eZfEdN5n5Kjccy63q7btYw
X-ME-Proxy: <xmx:fS4dapBINKcaNVgXjOINJkNGaIYcz67y5wQV7c_OuR1tLF8gDxI4XQ>
    <xmx:fS4dagKJguZdyjeMI_coThUXcFFKdfdb47Z3DOIDFCENCYV76rIWnA>
    <xmx:fS4dasD0aG1IeqGw_3Zxo67Fc0I8uwuNLPOgY-dJHLHnh8UjSVadOA>
    <xmx:fS4datvQX9JjlIlgYwedL-Krx2TETdJEMg7AL_FVg57ahPvbTE426g>
    <xmx:fS4dahNeHr9ttLNLdohTUduGzi-_uA7TWNbXPj5tH2FBk1ILENvuZDoJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:02:18 -0400 (EDT)
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
Subject: [PATCH 16/18] nfsd: switch nfsd4_create_file() to use vfs_lookup_open()
Date: Mon,  1 Jun 2026 16:38:04 +1000
Message-ID: <20260601070042.249432-17-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22156-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9578761A9C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

Currently nfsd4_create_file() performs a lookup via start_creating() and
then if that reports a negative dentry it uses dentry_create() to create
the file.
dentry_create() will use ->atomic_open if available.  Part of the point
of supporting atomic_open is to avoid needing a separate lookup.
->atomic_open can do lookup, create, open all in one operation.  So
doing a lookup before dentry_create() is not optimal.

So change to use vfs_lookup_open() which combines lookup, create, and open,
either by using atomic_open or by calling the individual functions (but
not both).

This means that we don't need to lock that parent
(start_creating/end_creating).
We also don't need to get write-access (fh_want_write/fh_drop_write)
except in the unusual case of a read-only creating open.

Also we only set O_EXCL in the NFS4_CREATE_GUARDED case.  This the an
NFS protocol option which requests the server to take full
responsibility for atomic-create.  For NFS4_CREATE_EXCLUSIVE and
NFS4_CREATE_EXCLUSIVE4_1 the NFS protocol takes responsibilty for
exclusive create by providing a verifier to store with the file, and
using O_EXCL would interfere with this.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 59 ++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5bd19e5d9e34..61ecd4123817 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -219,14 +219,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.na_seclabel	= &open->op_label,
 	};
 	int oflags = O_CREAT | O_LARGEFILE;
-	struct dentry *parent, *child = ERR_PTR(-EINVAL);
-	struct path path = {
+	struct dentry *child = ERR_PTR(-EINVAL);
+	struct path parent = {
 		.mnt = fhp->fh_export->ex_path.mnt,
+		.dentry = fhp->fh_dentry,
 	};
 	__u32 v_mtime, v_atime;
-	struct inode *inode;
 	__be32 status;
-	int host_err;
 
 	if (isdotent(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -236,10 +235,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (status != nfs_ok)
 		return status;
-	parent = fhp->fh_dentry;
-	inode = d_inode(parent);
 
-	if (!IS_POSIXACL(inode))
+	if (!IS_POSIXACL(d_inode(parent.dentry)))
 		iap->ia_mode &= ~current_umask();
 
 	if (!is_create_with_attrs(open)) {
@@ -287,9 +284,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_sec = v_atime;
 		iap->ia_mtime.tv_nsec = 0;
 		iap->ia_atime.tv_nsec = 0;
-
-		oflags |= O_EXCL;
 	}
+	/* Only ask the fs to provide exclusive-create if we aren't using
+	 * the NFS verifier to do it outselves.
+	 */
+	if (open->op_createmode == NFS4_CREATE_GUARDED)
+		oflags |= O_EXCL;
 
 	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
 	case NFS4_SHARE_ACCESS_WRITE:
@@ -302,33 +302,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		oflags |= O_RDONLY;
 	}
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
-
-	child = start_creating(&nop_mnt_idmap, parent,
-			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		goto out_write;
-	}
-	path.dentry = child;
-
-	if (d_really_is_negative(child)) {
-		open->op_filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-					      current_cred());
-		child = path.dentry;
-
-		if (IS_ERR(open->op_filp)) {
-			end_creating(child);
-			status = nfserrno(PTR_ERR(open->op_filp));
-			open->op_filp = NULL;
-			goto out_write;
-		}
-
-		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+	open->op_filp = vfs_lookup_open(&parent,
+					&QSTR_LEN(open->op_fname,
+						  open->op_fnamelen),
+					oflags,
+					open->op_iattr.ia_mode);
+	if (IS_ERR(open->op_filp)) {
+		status = nfserrno(PTR_ERR(open->op_filp));
+		open->op_filp = NULL;
+		goto out;
 	}
-	end_creating(child);
+	child = open->op_filp->f_path.dentry;
+	open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	fh_drop_write(fhp);
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
@@ -397,10 +382,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	nfsd_attrs_free(&attrs);
 	return status;
-
-out_write:
-	fh_drop_write(fhp);
-	goto out;
 }
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


