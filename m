Return-Path: <linux-nfs+bounces-23299-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /xXuC5aEVGpzmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23299-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB529747839
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="V/2cigmX";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=EofkiYaW;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23299-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23299-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A443008D1F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B637F75B;
	Mon, 13 Jul 2026 06:23:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28A35F165
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923836; cv=none; b=FqajcmjWihYrS4Tk+rpnAuhfNhg23uOufQuQdb/wmvmVvg/EwfsOr77sgmdY4wahUQySAB9PHl+HTxtUzoIyeg8uvdsf/8iP0aLTAGUMpSIKPlsFXFpGyG1kxPeM6dscbPH2zgEuUEtholx9LuQZkaYQYEzMN0xuDcJiAMuKBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923836; c=relaxed/simple;
	bh=55/spOOOavDD5IHgzinx0W/+n0YGmWWUWNNUJpOidms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhaTULvZhVwzfauecT5VTKRpvH6w45EzpLv1vGdqHJpn94IPg1DyPV1kRfF/bLYtVcMsWARCO+yrlx4cK+zeAT01NTo9u6zjQLynQVYnVSFCsp8OacSH5N+n9xJqp4VbwsTQcrRY8GfHOXNJFnmnzTTnP9w6GQ3sa/gyFeYw//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V/2cigmX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EofkiYaW; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F31741D00056;
	Mon, 13 Jul 2026 02:23:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923833;
	 x=1784010233; bh=8SzWu0ASGoPhjGRTs8sjBWz10mBU94BT3J7BnidJO1g=; b=
	V/2cigmXG8+csgUU0eThwxsyjRBBO91HbYslBiAp39KqOgkSh35h7cpEb36FKA0n
	f01vbiRMlMX13VPEXZh7pFejnMJzq4R65g4f+rewPnotu5aI5eRjqFuxbD/TotDl
	HxV1NQN5zIQWSSPvHuH55TxZKD/F6TVMSRL/I7NlocUDE+vFNy8iirytOCvbQzN0
	WB0o2Pm1MxEOf0oFrMjAxIOGx5EyM3pD9tfoMreWzJSWSyhXaMWd2LStzt+hVj68
	9U+z8R5FWioeOJKsRdZb9R60JWYgL3wOsH3kGYQFf5czhXnkiKtHwUrLm+ZW3x5n
	RlLGFHuXGtgRp0fm+AYlVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923833; x=1784010233; bh=8
	SzWu0ASGoPhjGRTs8sjBWz10mBU94BT3J7BnidJO1g=; b=EofkiYaWLi/KTlzxR
	fFXIRoWd0VRy7BuiN5sp/Dt6Tos5ZbjoHrjxZthHurc6fcHblpuh8wcfSRso9uuT
	LR8UbUs/wwn8CQSdcoUsS5KX1kS6V+PbeTqy2Qr999fZqFCl67OdUPpBPrxaEkqx
	sPKQtCgRNMTJUU14q9lTiJaao/F3Z8Vmd6A4GVtK7MhnB4cb+IkC9rEEqaULGYwL
	WAj/F1B3/TS2aTNoq2DQRK9dU1wWbdLyfgnRV8D9wNQY+K4WvF3x2j+YjIufOLrV
	MyZ9+ZEw/XxX/v1evgzft6+z8blL5eBKNbprQo6Oe9eJml6Xgz2G/jp2p7f/O0oU
	U4F2Q==
X-ME-Sender: <xms:eYRUak2W7GhT6-OA4fhTH-TIQH7eH1FkvAH8dp56Qo-ruuz_Rwltpg>
    <xme:eYRUaixuMogpmvYJNXiAvBYsZAT5ORqVoEIjiUl89svjK7rJVyvgUlRhQ5R6Skcrk
    9whpP0OcyAfRhsPOXC0Ljt6-4k0acWN-t7aU1dOnWjA8Q03dg>
X-ME-Received: <xmr:eYRUamvLx00ZNJ1vV1qoA11cpuKvZQlcGkDUmIgW2LBhfGGq3CCNPi_aMHqYkPBt-SerqQXwtycOnkNm3QDA-ajJ-GOkzFU>
X-ME-Proxy-Cause: dmFkZTFtDrmIs/wB2nalipIzZyXjKm32drMIM57REPM+F3mlcdTa3nvyfyNC/do65p4vuI
    VJ3aDsPKPwDCRnkbcKlOxCRkv3z0O2arwDzxMiRn2wmm3lBLLYJXmwaLn1GVUHG1LGPyzf
    22D/ip0hxH2D9Y5DAH0pRhEJ0hqqGJalm3T60A9sy43s8NSXx6aHF/YLkFcSIiQ/PzgK5C
    FKD/CLBXR7bW2u9X3Sm3ZTgiK/L3EdCoYOlxVi+dOXVbo+b1n5n3UsHnBNTSN4R/Quf30s
    n4OlsbCQw9P0eaF3qRab6eGafOoUIbuCiYpsAjuaLwLjEOXXNqroSAlEv+qmLixD2YUZAC
    oOLG5AYTbfFVzxKEU9JjzCoMhogWai4/nmr7JCbbcTn4IpyKD0oLcWvRRDtZaJlzFbMQfG
    FIAqB351zfvV8YJWPzOYQ0XSlCSbhTr1cgj5Slp1asOad6/ktoJhpUoVLsu6zoR0AMMuhG
    mvALXrhHDEAP7KQxZ2DLsgB+HLDTbyC7kFq7o+zg7/jqYj4VZ1VcxJp6EnCwc6Wfj/5DYo
    TqLboFw8fJQpJHMwGxmCXWimpyunmKs+K5Hf6wwf7FBEsJ2V1BBEod8QOgjLtGqwOAgM/a
    o07lW3VGuSKgc8HWDTzZoL5xn4A/QEpMUzC+sIKbaOHkPDCHuQjjUGTM4IqQ
X-ME-Proxy: <xmx:eYRUakwuZdMDXuarcsVY33mM1kZb9JdkaEnMWsu92vHOwbX4JW2Wjg>
    <xmx:eYRUapDNMuYOWfHGLtNJfT3ahicMHbPTu_KeBWG-2DBIyLJ7ovKZUw>
    <xmx:eYRUaicFQZgbrQILjyAxFjfhJYyXQJdO4uezHC37d8EGLTX3FChw8A>
    <xmx:eYRUajmyTN5sYh8hiOee56PoXJfp3_laXw-HEQZTOsMNrnZ0WdP5ag>
    <xmx:eYRUaqVpJZWyu9jlXncrFmfXrKsO1fP3t_3wS28aST3Oi_5wp2Qbl9hW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:51 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 16/17] nfsd: separate out VFS-specific code from nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:39 +1000
Message-ID: <20260713062219.6399-17-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23299-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB529747839

From: NeilBrown <neil@brown.name>

All the code in nfsd4_create_file() that is VFS manipulation, with now
NFS-specific knowledge, has been localised.  Now we split that out into
a separate function: do_lookup_open().

It is planned to provide a vfs_lookup_open() in vfs code which provides
this functionality.  This will share more code with the syscall open
path, and make it easier to modify locking at the VFS level.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 118 ++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 54 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ffeda7214d66..6a4bddfc92cc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -195,6 +195,51 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 		createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
+static struct file *do_lookup_open(struct path *parent,
+				   struct qstr *name,
+				   unsigned int oflags,
+				   umode_t mode)
+{
+	struct file *filp = NULL;
+	struct path path;
+	struct dentry *child;
+	int want_write_error = 0;
+
+	want_write_error = mnt_want_write(parent->mnt);
+
+	child = start_creating(&nop_mnt_idmap, parent->dentry, name);
+	if (IS_ERR(child)) {
+		filp = ERR_CAST(child);
+		goto out;
+	}
+	path.mnt = parent->mnt;
+	path.dentry = child;
+
+	if (d_really_is_positive(child)) {
+		/*
+		 * open the file so that we consistently have a valid
+		 * op_filp and consequently a valid ->f_path.dentry.
+		 */
+		int err = nfsd_check_obj_isreg(child);
+		if (err)
+			filp = ERR_PTR(err);
+		else
+			filp = dentry_open(&path, oflags, current_cred());
+	} else if (!(oflags & O_CREAT)) {
+		filp = ERR_PTR(-ENOENT);
+	} else if (want_write_error) {
+		filp = ERR_PTR(want_write_error);
+	} else {
+		filp = dentry_create(&path, oflags, mode, current_cred());
+		child = path.dentry;
+	}
+	end_creating(child);
+out:
+	if (!want_write_error)
+		mnt_drop_write(parent->mnt);
+	return filp;
+}
+
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -212,12 +257,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 	__be32 status, create_status;
 	int want_write_err;
 
@@ -229,8 +274,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (status != nfs_ok)
 		return status;
-	parent = fhp->fh_dentry;
-	inode = d_inode(parent);
 
 	if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
 		/*
@@ -238,7 +281,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 */
 		child = try_lookup_noperm(&QSTR_LEN(open->op_fname,
 						    open->op_fnamelen),
-					  parent);
+					  parent.dentry);
 		if (child && !IS_ERR(child) && d_is_reg(child) &&
 		    unlikely(nfsd_mountpoint(child, fhp->fh_export))) {
 			struct svc_export *exp = exp_get(fhp->fh_export);
@@ -261,7 +304,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			dput(child);
 	}
 
-	if (!IS_POSIXACL(inode))
+	if (!IS_POSIXACL(d_inode(parent.dentry)))
 		iap->ia_mode &= ~current_umask();
 
 	/*
@@ -326,58 +369,25 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-
-	want_write_err = fh_want_write(fhp);
-	if (want_write_err)
+	if (create_status)
 		/* Might still succeed if no create is needed */
-		create_status = nfserrno(want_write_err);
-
-	child = start_creating(&nop_mnt_idmap, parent,
-			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		if (!want_write_err)
-			fh_drop_write(fhp);
+		oflags &= ~O_CREAT;
+
+	open->op_filp = do_lookup_open(&parent,
+				       &QSTR_LEN(open->op_fname,
+						 open->op_fnamelen),
+				       oflags,
+				       open->op_iattr.ia_mode);
+	if (IS_ERR(open->op_filp)) {
+		status = nfserrno(PTR_ERR(open->op_filp));
+		open->op_filp = NULL;
+		if (status == NFSERR_NOENT && create_status)
+			status = create_status;
 		goto out;
 	}
-	path.dentry = child;
-
-	if (d_really_is_positive(child)) {
-		/*
-		 * open the file so that we consistently have a valid
-		 * op_filp and consequently a valid ->f_path.dentry.
-		 */
-
-		status = nfserrno(nfsd_check_obj_isreg(child));
-		if (!status) {
-			open->op_filp = dentry_open(&path, oflags,
-						    current_cred());
-			if (IS_ERR(open->op_filp)) {
-				status = nfserrno(PTR_ERR(open->op_filp));
-				open->op_filp = NULL;
-			}
-		}
-	} else if (create_status) {
-		status = create_status;
-	} else {
-		open->op_filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-					      current_cred());
-		child = path.dentry;
-
-		if (IS_ERR(open->op_filp)) {
-			status = nfserrno(PTR_ERR(open->op_filp));
-			open->op_filp = NULL;
-		} else {
-			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
-		}
-	}
-	end_creating(child);
-	if (!want_write_err)
-		fh_drop_write(fhp);
-	if (status != nfs_ok)
-		goto out;
 
 	child = open->op_filp->f_path.dentry;
+	open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


