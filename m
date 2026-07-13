Return-Path: <linux-nfs+bounces-23300-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c6tcK5iEVGp0mwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23300-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C8574783C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=JDf1R+XK;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=X24J8oSc;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23300-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23300-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E8A3008A43
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8287361DC3;
	Mon, 13 Jul 2026 06:24:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE435F165
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923840; cv=none; b=Birz+7yKaYZD/NmgM2O8D9MbyptVaWP7AkBYgp9FKT5vskSBeTYTne8Rcik4QhwlA0OHyUm7mwRYjeLlc4YAXYQiIAa0IbldMxfxofGpg7S6+epPGiskPa7UVMo6/5eEsPLMFINY0MFqwqHkG98+84QMfvX7p9HpDpXFYICL8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923840; c=relaxed/simple;
	bh=LstOm4/B2kI3R8ObauUhUIUqz1L2iXyPxiaTAK6vfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGMSKxraIN8Goa68U6F1Fuze9eDiBX0eYTGe956cRga8UZciNqXq0QupfPqyMKlzLalvi7aJamzZebvRvvS+Byrx5N3lkpFItxWr6uKjfpopSViL4KxFEh2GhWi2Z6Fulgz83FK/h/aZLKSrUBj1WE2ShJp682EGyKQ5QtF3YGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JDf1R+XK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X24J8oSc; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B829E7A005D;
	Mon, 13 Jul 2026 02:23:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923838;
	 x=1784010238; bh=upWLU7VcM20azzQF70lPvVKbJSD3/Tuh+GEXuyoIZOI=; b=
	JDf1R+XKsuGJT0CAHARxe3OkwCP63j/OVgU7AR+uW4G7euyFACEdkWPnAeYnvVUv
	gFJ/otLik/S556XEhtQO0z9LPH+eE3d1DpUq83QCNGl5CN8Q/ASjHVvZjGOjvClL
	sQNzeBxbn93CEutp/628SMDX2KNcS5R4b7P0Nfjfcv7JItk/L/4e2b2EkdGYOhtS
	YW6aSYsPR04NcWJvkM1skDWGn9J4DOoILKdWklnuw1K78GTjJ5qyoxysFLsvQLMW
	AmpbUtDTPdQHZyvJFSF+glKX9fQvY+0ozpJNE2QQWQj7Hd9G8043JtQUY0cffypt
	2A0/wZlfcV3G8Chg4OcVYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923838; x=1784010238; bh=u
	pWLU7VcM20azzQF70lPvVKbJSD3/Tuh+GEXuyoIZOI=; b=X24J8oScbdppkjGlO
	0IzAkA60h30g/oW1Mcyakv1m2zf/hWwUi0n4t42UZLwTAz2zKPUm/kGNoC/xwxHx
	XzPyk91bWkR0DAXQ79sEsbETRK8T+8Wzave/FVMu3XF2VbL/AYx1Xco2mzZguJ8O
	k7Tmaqqwc04WSd/LOMhqc0axtifOQBQEUXHDnI1xJ/KBgiIRfIDpZ5MBtkjSMoCn
	zVPZIoL2B2MZiAyAq+W8w+ms/Gl2hJZzmsIoJqZyHT2q7bA3ZrNaPx+5SxkmbFTE
	uVJWR+ggBANr3otOiEKYlo9rvEz4R7c8k1Z7AJ6K4ECPBzqvzYCqvXpijypZtmiG
	b1RcQ==
X-ME-Sender: <xms:foRUaqj0_yTnLD8raRxcYflLcras6b7lUlqzvpjesFvH8WRx1gH5Kw>
    <xme:foRUautcG-mtzw1MF1KOubjJt3b6pAAB2zSa0YRxDIhZmIuLnkO-AuAYn0ncII329
    wMWi5oDri8bvOfNUVrYHaqMr4l3MHiH9ruXxjqKQHN7Whl8iQ>
X-ME-Received: <xmr:foRUar4MiZFqIIXR94z6AKBE8fie6aNOdtScS5iPmf1y0_uG_DKCfJM7ulB3bGsXLWYW9GHBR5AyE7GVx18IdJIZAg_271A>
X-ME-Proxy-Cause: dmFkZTEZB/Kbgph/UP+qlRun0nbKeFX2X/79iTN2dqaSsx/s4vwTngk08Ly5MOqpQNgv+k
    CvuEnOGFE0d6Ev3uXjO6b4oysisaasspM7JTzT6meQcgCVImGZiIOsOPRJOwgQC86kMFRj
    lyOi5olcj5Md2Szvw6Zlspslnw25Wy4KBGmGF/EqVYDqMTHhjJMFdcRqo9oxC2g/yR1fQp
    Z7I/dsqPlPjX1oBTZb4S78ele8cr/9kae0rQPXCj0X/9Zm6b0UB/039FfFdWLRTxQlVexZ
    YfhdHbsjogzRhQd5xB8YZ26QTIU3yW+3ERF7FRscMY/Sr7rlpF51DuHkVdM7rjMRBeMXtW
    aJ8q2D2FZemYI5ZZ5w6mt6XKuXuyzJplZfGggh3qHkmBWDBr96xVCAFeZaoDDf5gZx1R05
    z+PENesWqsR+pBflu8J2sxNdzke78yaUyNxUZydG5iJTq2pG0G0hIhdPPERusdXztPcd9i
    JgrOk+/0cANSU+vXoKE/LYJHnTOtjnyl1jCa+aQ7Z3nh1VSmUKZoh8NKfn8O0+FPz+UsII
    afNecqAdkPZQuwo4maVgHWtY/fQM7oVuN8Z6i9W5BjNcyZPSG01icqE2r/koycrC+4VBjo
    oU+enLht/buNZmDsmX5NVZF6+AoAOqsoHHUPOuICNItp4DyAcYtztIeC4snA
X-ME-Proxy: <xmx:foRUaqOQ4n_tnwSgfgHR0Qs5aLW5DhY_2wstzkFot-lhJH-xEa0rfQ>
    <xmx:foRUapvWIxjKa6V6aypjNabk5lp_udRuuZqQ8zunjNeiGhBJx0w8VQ>
    <xmx:foRUatbAJUoLz-57JPo1BoHtQFHwT3vN-9FHliR5M3qq8Zi1JHmlVw>
    <xmx:foRUarzVo-QAovAd7EDobzyMilV7rmEtYn3xxqskxZjeznpZHuW3iQ>
    <xmx:foRUasAngboWNtiu8GQa70ZC5iIulnb3BfPzdh8e2U-Nse9DyAOg21vI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:56 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 17/17] nfsd: use do_lookup_open() for non-creating open requests too.
Date: Mon, 13 Jul 2026 16:15:40 +1000
Message-ID: <20260713062219.6399-18-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-23300-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09C8574783C

From: NeilBrown <neil@brown.name>

Now that we have do_lookup_open() for creating open requests, we can use
it for non-creating too as do_lookup_open() is already able to do that.

This prepares for switching to vfs_lookup_open() once the VFS provides
that.  This will ensure consistent code and fs-interaction with VFS open().

The resulting simplification allows fh_fill_pre_attrs_unlocked() to be
moved into nfsd4_open_file() (renamed from nfsd4_create_file()) so it is
closer to fh_full_post_attrs and fh_fill_post_noop calls.

As ->op_create_mode isn't defined when op_create is zero, we need a
local create_mode which is -1 (illegal value) when op_create is zero.

The non-create path now doesn't use nfsd_lookup().  As mount-point
crossing including nfsd_check_access() is already included for existing
names, this does not lose us anything.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 108 ++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6a4bddfc92cc..68fa3c7c987f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -241,29 +241,30 @@ static struct file *do_lookup_open(struct path *parent,
 }
 
 /*
- * Implement NFSv4's unchecked, guarded, and exclusive create
- * semantics for regular files. Open state for this new file is
- * subsequently fabricated in nfsd4_process_open2().
- *
+ * Implement NFSv4's open semantics for regular files.
+ * Both create (unchecked, guarded, and exclusive) and non-create.
+ * Open state for this new file is subsequently fabricated in
+ * nfsd4_process_open2().
  * Upon return, caller must release @fhp and @resfhp.
  */
 static __be32
-nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  struct svc_fh *resfhp, struct nfsd4_open *open)
+nfsd4_open_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		struct svc_fh *resfhp, struct nfsd4_open *open)
 {
 	struct iattr *iap = &open->op_iattr;
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
 		.na_seclabel	= &open->op_label,
 	};
-	int oflags = O_CREAT | O_LARGEFILE;
+	int oflags = O_LARGEFILE;
 	struct dentry *child = ERR_PTR(-EINVAL);
 	struct path parent = {
 		.mnt = fhp->fh_export->ex_path.mnt,
 		.dentry = fhp->fh_dentry,
 	};
 	__u32 v_mtime, v_atime;
-	__be32 status, create_status;
+	int createmode = -1;
+	__be32 status, create_status = 0;
 	int want_write_err;
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
@@ -275,6 +276,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		return status;
 
+	status = fh_fill_pre_attrs_unlocked(fhp);
+	if (status)
+		return status;
+
 	if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
 		/*
 		 * If name is already in dcache we need to check for mountpoints
@@ -307,11 +312,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(d_inode(parent.dentry)))
 		iap->ia_mode &= ~current_umask();
 
+	if (open->op_create) {
+		createmode = open->op_createmode;
+		oflags |= O_CREAT;
+	}
 	/*
 	 * For the EXCLUSIVE modes we do our own uniqueness tests
 	 * so don't want O_EXCL.
 	 */
-	if (open->op_createmode == NFS4_CREATE_GUARDED)
+	if (createmode == NFS4_CREATE_GUARDED)
 		oflags |= O_EXCL;
 
 	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
@@ -346,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v_mtime = 0;
 	v_atime = 0;
-	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+	if (nfsd4_create_is_exclusive(createmode)) {
 		u32 *verifier = (u32 *)open->op_verf.data;
 
 		/*
@@ -368,11 +377,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_nsec = 0;
 	}
 
-	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-	if (create_status)
-		/* Might still succeed if no create is needed */
-		oflags &= ~O_CREAT;
-
+	if (oflags & O_CREAT) {
+		create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+		if (create_status)
+			oflags &= ~O_CREAT;
+	}
 	open->op_filp = do_lookup_open(&parent,
 				       &QSTR_LEN(open->op_fname,
 						 open->op_fnamelen),
@@ -394,14 +403,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 
 	if (!open->op_created &&
-	    nfsd4_create_is_exclusive(open->op_createmode) &&
+	    nfsd4_create_is_exclusive(createmode) &&
 	    inode_get_mtime_sec(d_inode(child)) == v_mtime &&
 	    inode_get_atime_sec(d_inode(child)) == v_atime &&
 	    d_inode(child)->i_size == 0)
 		open->op_created = true;
 
 	if (!open->op_created) {
-		if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
+		if (open->op_create == NFS4_OPEN_NOCREATE ||
+		    createmode == NFS4_CREATE_UNCHECKED) {
 			/* NFSv4 protocol requires change attributes
 			 * even though no change happened.
 			 */
@@ -496,46 +506,34 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	fh_init(*resfh, NFS4_FHSIZE);
 	open->op_truncate = false;
 
-	status = fh_fill_pre_attrs_unlocked(current_fh);
-	if (status)
-		goto out;
-	if (open->op_create) {
-		/* FIXME: check session persistence and pnfs flags.
-		 * The nfsv4.1 spec requires the following semantics:
-		 *
-		 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
-		 * Reply Cache  | server |                 |
-		 * -------------+--------+-----------------+--------------------
-		 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
-		 *              |        |                 | (SHOULD)
-		 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
-		 *              |        |                 | (SHOULD NOT)
-		 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
-		 * yes          | no     | GUARDED4        | GUARDED4
-		 * yes          | yes    | GUARDED4        | GUARDED4
-		 */
+	/* FIXME: check session persistence and pnfs flags.
+	 * The nfsv4.1 spec requires the following semantics:
+	 *
+	 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
+	 * Reply Cache  | server |                 |
+	 * -------------+--------+-----------------+--------------------
+	 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
+	 *              |        |                 | (SHOULD)
+	 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
+	 *              |        |                 | (SHOULD NOT)
+	 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
+	 * yes          | no     | GUARDED4        | GUARDED4
+	 * yes          | yes    | GUARDED4        | GUARDED4
+	 */
 
-		current->fs->umask = open->op_umask;
-		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
-		current->fs->umask = 0;
+	current->fs->umask = open->op_umask;
+	status = nfsd4_open_file(rqstp, current_fh, *resfh, open);
+	current->fs->umask = 0;
 
-		/*
-		 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
-		 * use the returned bitmask to indicate which attributes
-		 * we used to store the verifier:
-		 */
-		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
-			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
-						FATTR4_WORD1_TIME_MODIFY);
-	} else {
-		status = nfsd_lookup(rqstp, current_fh,
-				     open->op_fname, open->op_fnamelen, *resfh);
-		/*
-		 * NFSv4 protocol requires change attributes even though
-		 * no change happened.
-		 */
-		fh_fill_post_noop(current_fh);
-	}
+	/*
+	 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
+	 * use the returned bitmask to indicate which attributes
+	 * we used to store the verifier:
+	 */
+	if (open->op_create &&
+	    nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
+		open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
+				      FATTR4_WORD1_TIME_MODIFY);
 	if (status)
 		goto out;
 	status = nfserrno(nfsd_check_obj_isreg((*resfh)->fh_dentry));
-- 
2.50.0.107.gf914562f5916.dirty


