Return-Path: <linux-nfs+bounces-22931-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9k4ZGZfBRWr7EgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22931-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05366F2D03
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=m1PmA62x;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=bARPj8ac;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22931-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22931-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBEA9302D1AD
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FF2C08BB;
	Thu,  2 Jul 2026 01:40:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF629B200
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956436; cv=none; b=dQqHZqPvCQmgjf+G4ojl5MhKpMkORL1h9oun2Qn+yytGHO0kOyyFcX5sTyOVRu1SjQwUr7tSHGvNbBsyogbLj01J4jGU3wQf825/dgMEbrRWsMMo27lFcHT6WpgcE/OYSH57vKtexYRY5xoh/lnCJ2F7A2tgfbH2TmrEu6Fa+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956436; c=relaxed/simple;
	bh=D0QOkmYGB4UzI6nkBOds8dJabdx9AmwarUBorTQg5qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzDHrXo5PnxVPVIk4AoMQewCR23WwcFUzO4wT5ZcE8dP2WxXzMUV4GFaXxWv0Ch24hKyPTVS9j4jTzwcTgKTYc3GPBMV4cUfA8W6205AqsPOr2n03LZKj5l631KW2F3gU6dXgSxW32r+/QfZelC5KNwqV66LgDzSn2jYrKBNmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m1PmA62x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bARPj8ac; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C773140011B;
	Wed,  1 Jul 2026 21:40:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 21:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956434;
	 x=1783042834; bh=8gvq+byj3+5wZS8tUsB8LG5Yy81W1ore8VeYOGwk6EI=; b=
	m1PmA62xLamt9NYnZhtm7Kte6UMIExm/4IGKoQxg+i+k8dSF+hPb7HRt7Qpj/xlh
	CMkCwxYf4HTOTarezF4l1I4s+otMpAmJTxJM2bUM2Lv3iZHxEr8nvwiYhBKgupdo
	0q7rOqJy+6DqQRVO+H2c2nC3w0o6Ts+kqg/1uZPrDJ+g6uT+/U/02T3VO6fi707D
	09vgYNTTK5S9db+R+CKgN/okG5OMaAMXXH7I7p6GWUZXEe2OyIA89O7Teg0oYhl7
	XW1qVoDW7HhnIzUYKXmd2w90IwSIjnO7pN0y1BFR8BsuCC8tVhbB6H4UtxGqWXbt
	dbsKILwqBBPp3DSc4rXDRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956434; x=1783042834; bh=8
	gvq+byj3+5wZS8tUsB8LG5Yy81W1ore8VeYOGwk6EI=; b=bARPj8acVqEtyk/MT
	jeGroRI3P7+LbzH9ajVM84wlaRm06C0vrFeO11HxlF9R7xqkzadCWEHFHI/TFzOE
	5AhBxVjNaS8ywSvu/5eJwy6yAU0E0LryXRDQft/VlXltj6v9fUPesNI7nY3l/hCP
	74uleCMx7mH2zT7TXGq1rmizToVCzD30pFqfwezYBF+VgKUtKMCtWzywQOiHChyS
	ZKGrKQdweMbi8FYfm6hy78L/DDZrJ0J99DCPL02rgw+1X98ZNOI2TBoSS2TnrZkh
	krKHXhwBHHh1PALcYGW1OZFRA3vTPYZZbJyR0Hfwb1y8ZJLR9G34xxjeUO4QJ06S
	pWVLg==
X-ME-Sender: <xms:ksFFauHGUwTTAJnkVBQbD02HiiI6w0SpIErPLyMh33edNqaS6kelaw>
    <xme:ksFFajAVN4mvcTdClHMBUoTW8wnciw05Az5NwZyhFCy2r72-WZpZgmdN-cJt3VOca
    z0Czwm34Ar_TlB-qs77JmQHpHEA5RNytd5LOChTP6WfNfWNKw>
X-ME-Received: <xmr:ksFFah-AgFpd3mqvVfSw-eCbEPcQwcvb9SlJdbkTnF1IVmKDLhZRu4SWTo9YllMWnz4h-nMtR3APBjKNLIg-XHG4MuDAzq8>
X-ME-Proxy-Cause: dmFkZTGxxG3WYOxUHoAfQ/lPCCBtpuI/S7RhXZdDZo5R/zg8oB5VVkJeqNXv4+5JHOpq5a
    +KGMHLUceWZQbXPkcZMChswAkz7oDBNzn2AAW712K9zA+2pVUC0R25sTJVNA5GxxGZFPf1
    pbUOYpi4dQLmAi8WqifnbcWGv9caFABP7KC0vD8MdlGlpjn5roAZxmnOAYWdGQbArFc5Hb
    UEMPfmUhw7JKuGB/UeLW6QzhMn9rUFgblOXzq7GYDHlxGkjfNMCQ4PJDU4+12b6NAKgXbl
    Rg1mGujmSEJHxyDH3iqFB1G6ofNBMwYgggnhxc3EKZatNVAxTrXJlSKPeBcpJnvqZuoCOU
    XfaAkGEQ9wdE4VHXxqKik6FxSNGwRQspdO0u95ACU2LohNmf/Z0x+dyrAF3guarTzpw/An
    YCcR+++B4ytX1qp85szQi2CzgNt/fiFZzzK53axtjNphonjIcmz8ix9f0wTCTTUTdXla9Z
    /eHses9G8sIhaezfp5M8+qqiLipZFoM7NT0iahMKQ01b3fZJhKfkkoNCpAesv/wqkEtDf3
    v/oBjp/tU3k9P50BYmrabvwBWnO/yAR8YwKgP05RbfkCP9Hgktoyxg0GThbIxiCzz0mg3B
    R9dGsAG9ldwqkm2Kepaf49CTd3VAdoIPCS20KiXXeu8H31unRLqEambRxZ3Q
X-ME-Proxy: <xmx:ksFFavDWU974itS52E5736UzgRHAxrPEO_OWVN-8HFRDN09osu-BEw>
    <xmx:ksFFamTzg6hmCTJMbtdVCwSEor_ChTHz_zJXKwa_dhmm3LzLe3_MBw>
    <xmx:ksFFamuYOvQwLW1lfMUwml6G67NIC8bHUmAm68t8IWdY6GrYxFD1-Q>
    <xmx:ksFFai1-j_zl1vNq7zoDleqeTqroLuQa-yFuPNbzsBXLocRE30h-GA>
    <xmx:ksFFaoPkRB85yw_KqL-ZSxXjP-IMhoKD5jDnVGsV1XtPjFiazUQ4R_6k>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 05/10] nfsd: in nfsd4_create_file() let VFS report if file was created.
Date: Thu,  2 Jul 2026 11:34:24 +1000
Message-ID: <20260702014000.3397240-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22931-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D05366F2D03

From: NeilBrown <neil@brown.name>

nfsd4_create_file() currently assumes that if a lookup failed but then a
create succeeds, then the "create" operation actually created the file.
With atomic_open this may not be the case - some other actor might have
created the file between the lookup and the create.

So we move the call to nfsd4_vfs_create() earlier and set ->op_created
based on that.  Then use "!  ->op_created" to trigger nfserr_exist
handling.

The switch statement is split up into two if() statements.
First we check for the possibility of a successful exclusive
create and set ->op_create to true if appropriate.
Then we check for NFS4_CREATE_UNCHECKED to decide if a
pre-existing file means an error or success.

This allows us to combine the two fh_compose() calls to one place.

Also move the clearing of ATTR_SIZE for a newly created file down to a
point where we know we have actually created the file.

With this rearrangement we now repeat the setattr when an exclusive
create is repeated.  This should be both rare and harmless, and it
simplifies the code.

The above requires changing dentry_create() to reliably set
FMODE_CREATED when the file was actually created.  Previously it only
sets this flag when atomic_open is used.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c         |  2 ++
 fs/nfsd/nfs4proc.c | 63 ++++++++++++++++++----------------------------
 2 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..e0a62198fc60 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5073,6 +5073,8 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 		if (!error)
 			error = vfs_open(path, file);
+		if (!error)
+			file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(error))
 		return ERR_PTR(error);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5b7f0314776f..cbb549ca6567 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -333,22 +333,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
 		if (status != nfs_ok)
 			goto out;
-	}
-
-	if (d_really_is_positive(child)) {
-		/* NFSv4 protocol requires change attributes even though
-		 * no change happened.
-		 */
-		fh_fill_post_noop(fhp);
 
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
@@ -356,41 +364,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 * some other reason. Furthermore, if the size is
 			 * nonzero, we should ignore it according to spec!
 			 */
-			open->op_truncate = (iap->ia_valid & ATTR_SIZE) &&
-						!iap->ia_size;
-			break;
-		case NFS4_CREATE_GUARDED:
+			open->op_truncate = (d_is_reg(child) &&
+					     (iap->ia_valid & ATTR_SIZE) &&
+					     !iap->ia_size);
+		} else
 			status = nfserr_exist;
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
 	if (is_create_with_attrs(open)) {
 		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
-- 
2.50.0.107.gf914562f5916.dirty


