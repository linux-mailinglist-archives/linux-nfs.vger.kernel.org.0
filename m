Return-Path: <linux-nfs+bounces-23008-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PL+RCg/ZSmplIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23008-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:22:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FB70B9DE
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=TrKmSVhz;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Jf2VRRG2;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23008-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23008-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465913013A78
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC334DCC8;
	Sun,  5 Jul 2026 22:21:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE47253958
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290102; cv=none; b=X3HrNmqq6uJyKgcvmg0PAB1liJ0PnAJTq2lz7hfcqpVQm169c/THQOHr73gmhOsqv5YF5nltuf7Wpd0QgAAbBEbALh1kIvSrFG7YL4D7XptZ9OzhXL8pZ3iSBeIt84eqdXs/BE3G2Fh+gLPzClBwkRAsAYkir5KzMhkZny7gmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290102; c=relaxed/simple;
	bh=jGkvZz0XH4mFrfKsKhgCyFwrbdsIyGWv6uRJ043pMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWiGttQWHalAm8Nm7fX0EP10fldbl1n4p3R3Q6PAEUZJ3gR+rX+jBxUES7a5mTycIWD/OMbMi+e1DJUzjoETLyw8CjVFHy4cc1XIIITuXPlbCXl3eO1L6+Pd1NxT3FCCekjrSTXQR5ejHIdmech5kR753YYbjTkYTz8A4kV5iz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TrKmSVhz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jf2VRRG2; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9A741400045;
	Sun,  5 Jul 2026 18:21:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290100;
	 x=1783376500; bh=i+e07rAos8cSwXgCKO2JBPiDCpM8QrvSVko9MhD8ihA=; b=
	TrKmSVhznrgUj4o+KxBUzn10qlqpGNX9+YRERYZaSiL4IwC+0eiGzXGut9jkrSXg
	YHFjr1YxSA0Aq4ewy22ropgAQ9if7+tghDDRfeY8N7LBvJB3XPgoLXrrkvUStEZN
	7DmpZpgmE4KxwGIH3pvqPWL+bNg/vo5fir02Wb+BKv/IjT54WfFtlZm6NntH4Oyd
	e9v7IbFvmAyrRsOD/GHENr/8ypA7r3RuJ6lqAoTAXURlCuNqDQXkacWg8sg1IUgx
	qsjT5LCBqQFY2fhIgdZqb1r+doQYDM0RFz7EdDao4p/wmPFgQHfS05hqHgCzTtqo
	m3UXDuH3+7pTANnOXJ9LUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290100; x=1783376500; bh=i
	+e07rAos8cSwXgCKO2JBPiDCpM8QrvSVko9MhD8ihA=; b=Jf2VRRG2LoRncjS1J
	KqA9yO+9vwc75TccwAA/Ab1/PLyX61IBc+MKbsRFbvB1gzjlkKtqwXBMrIvS379X
	WTVIOM5e42wYpzIzuEDVqrAYtk4M7rVOJ9RXQPAEqy2OjYQXfyz4OlvKrUPWl6Yu
	wuPaA+ASQi1dm2Gf4Ld9C2jr+SnOfOTUWQuRubKrBRKsztlen+U1K/w/cLm5n/fu
	YaHeLIofhCvcDMfwqNIA3YjqRmgR/7eXF1yvR6XVyOWD8MEuKXX272s4bFun9Y0L
	F5yBalKP2aUeTyq0IwBiqLUw/V+msTwQnDdxjqD0uPeRruyUk03g6tqIzXXdMLiG
	CcNQw==
X-ME-Sender: <xms:9NhKark6DkcLRlzyPWI-U6GSJuBzcVIWMoZl5eTk5I-G-v1gG4yo7g>
    <xme:9NhKaih4zpEH0zWSLP8lXL0PY2o3w08nKuFXpi6O8QwWWWTLasJgK09fTcOaOJnpA
    n5WLbWKjyCkMxzutACNDfx9G36lubNaDf0xLFtZRHWn3FDFSo0>
X-ME-Received: <xmr:9NhKardzgFJ23mcY_G94A0_1WlZP7f4yLRsuTm9vWLUp8WP_keo_SrUnoa-wXooKC2MxgVecB79r7wP7vPa6fvhfRbC4TJI>
X-ME-Proxy-Cause: dmFkZTGDNA7WB0pb5ZPMshx4pScUdKXfHb7VTa7xbOJn4ZLoZvs+FLUT18DTgGuVKUkbLS
    d/3vGL0pIMJ4s0r7JQHdnVfMUpqyEvmomMpb7PR/9bKDk2Mppoo4Xc7QpZHfQZ2YQC2nIg
    Xyf67bpvXR/bVfBxz7kAPu+a5Mr7AmO1WAs4flb35PHnJrkVDuKv7GaZl8ayaT3Dhwp8vk
    gYfflj7OnmJTr/EnQZJbw1EbPh0lXfJfBsl695e3K2ePfLj8Hip7Srpehm2Vd5zinGJNzg
    2CGackhzKQ9oxMmyNV70BNOG80t+AxEonBy1BL993On7VUle0IqaoB9Iwn4YF+W666DpQy
    dx+Vb5i9FgX5T4yp25dTdDYIjKM4c3FYp3B2CJTNYXIL73U8gu+JBH7rXO5zPCj6YoaIZI
    mYubMC37iJ1BLuykthweRvfAeafkwgX6e02P+FdXG3ZiESYFLf6jNqao5lgM3n1WtNb73k
    MGb0L5e4xmteqp9KJrfbQe3Pp+HPOlvm8Bqvr+paYvy5zmfelvzFHV4alTTsof4t8pVsu/
    VJFPJ/sb6IeJbAFcfP+b/p0U6uleSguyBRbZn3r3cqkxaQAF4+QZko1tBuKdNGMrhbf4SK
    TGMb5R1PxEDWXCj5ZD4F4LVdMX/N0hlesuNCIcjO0+WL7bFxhWoC9PcMuyYw
X-ME-Proxy: <xmx:9NhKaqgeSctNyU6uUtigJux7hN5JgFSpyF7ydRO08NSi9W-IGplytg>
    <xmx:9NhKarzMAplxsAKCNCXWXy_tg2-cse80s3wkBN01a4ZvJb6gLEdavw>
    <xmx:9NhKauMyov4NZ7Z5MMcaePkRQLLPAVEVf89xsCBMkpqTCK_FN_HyJA>
    <xmx:9NhKakUTFPapLt2hdQaSuj2cs_yIPjj4xeHA5abvWS5K99_qIZddww>
    <xmx:9NhKahFNLBBzUuKG5vFP1SZBIcv8gEPb9RMRuN9F0gWTZxyZSmEBeS0e>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:38 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/14] nfsd: separate out VFS-specific from from nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:45 +1000
Message-ID: <20260705222032.1240057-14-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23008-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B43FB70B9DE

From: NeilBrown <neil@brown.name>

All the code in nfsd4_create_file() that is VFS manipulation, with now
NFS-specific knowledge, has been localised.  Now we split that out into
a separate function: do_lookup_open().

It is planned to provide a vfs_lookup_open() in vfs code which provides
this functionality.  This will share more code with the syscall open
path, and make it easier to modify locking at the VFS level.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 108 ++++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 10323c620b71..643cf4302db5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -201,6 +201,47 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
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
+	int error = 0;
+
+	error = mnt_want_write(parent->mnt);
+
+	if (error)
+		return ERR_PTR(error);
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
+		 * open the file so that, unless it is O_RDONLY, we
+		 * have write-access to the fs for setattr below.
+		 */
+		filp = dentry_open(&path, oflags, current_cred());
+	} else if (!(oflags & O_CREAT)) {
+		filp = ERR_PTR(-ENOENT);
+	} else {
+		filp = dentry_create(&path, oflags, mode, current_cred());
+		child = path.dentry;
+	}
+	end_creating(child);
+out:
+	mnt_drop_write(parent->mnt);
+	return filp;
+}
+
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -218,14 +259,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
-	int host_err;
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -235,10 +275,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (status != nfs_ok)
 		return status;
-	parent = fhp->fh_dentry;
-	inode = d_inode(parent);
 
-	if (!IS_POSIXACL(inode))
+	if (!IS_POSIXACL(d_inode(parent.dentry)))
 		iap->ia_mode &= ~current_umask();
 
 	/*
@@ -303,53 +341,23 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-
-	host_err = fh_want_write(fhp);
-	if (host_err) {
-		status = nfserrno(host_err);
-		goto out;
-	}
-
-	child = start_creating(&nop_mnt_idmap, parent,
-			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		fh_drop_write(fhp);
+	if (create_status)
+		oflags &= ~O_CREAT;
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
-		 * open the file so that, unless it is O_RDONLY, we
-		 * have write-access to the fs for setattr below.
-		 * Also we can be sure that op_filp->f_path.dentry is valid.
-		 */
-		open->op_filp = dentry_open(&path, oflags, current_cred());
-		if (IS_ERR(open->op_filp)) {
-			status = nfserrno(PTR_ERR(open->op_filp));
-			open->op_filp = NULL;
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
-	fh_drop_write(fhp);
-	if (status != nfs_ok)
-		goto out;
 
 	child = open->op_filp->f_path.dentry;
+	open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


