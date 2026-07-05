Return-Path: <linux-nfs+bounces-23009-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h9JdCAHZSmphIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23009-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557770B9CE
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=dZ38iZrr;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=SISWW+yG;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23009-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23009-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 046B530028EC
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C3253958;
	Sun,  5 Jul 2026 22:21:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22086370D54
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290107; cv=none; b=TJ1xB+ydLh168GpHaBLCrd4hM0E8QVyCPi8ABlQTEhQEC/BPJOcUjQKvGL9PVosxEmJsxhzibtAeMeTmdD9JYd8LKfUkYDftrcph9v2Dpb+Nzju4UnhwgN+Ltdnnmnrkxo7lna0NeWpgslTL+hdED2yp0n4Yp76k36OOrjJ4EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290107; c=relaxed/simple;
	bh=+f5ZpAfNtOM1JmFOQvDMgvbva9LUoyp5IEPND69BFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcHZRffExPgiA83s+3Ocqmk2T7EV1w/2RXtZg3CJyR9Q4CyrgppZXo3FPjT4xiGDzQP9z/uwN9W9hcAviBpCpNBtBW1GdOY0Lhl00ga320Ccq3NPkMwmQt83wJ2xlaY7XusDEPjCmbBtu4HI0eiRZr/p3KQ2NUhTc2yWtzqcvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dZ38iZrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SISWW+yG; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 28806EC0125;
	Sun,  5 Jul 2026 18:21:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290105;
	 x=1783376505; bh=xaR1DS2olm/uFq+hEKflfkq6ybV9XWOnUNLpMT54Uz4=; b=
	dZ38iZrrgIQmHOGaOGbskw+UcVk7d079ni31GUPMVzUIcQYF6Gg8w2Q6KRqEEAz6
	y9IxLB8fXyFpSMDTvAm8kzeHKgbTXds/oU64ix9D2hd247Gc7PcRP1uqog5y8Drt
	eQiU6I8cVpYWxkyTlarTgAKKQjq7X9qBm9ePNdFbEcpYbzl11bzIK4ejcHvm967U
	q7d6J9lAsoKH+rHZlGVveYi+dPyJxk/rW++c/tSHqsoVbwcI+KR9CcVhnvhlLLLg
	1LfYI3mzvlL+JGQlodarNiNycNtkRJzriK4V2sSZ7a+nJgJauBtSsLibbc5cRce0
	mcErekfWVR5cgumMAgFfHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290105; x=1783376505; bh=x
	aR1DS2olm/uFq+hEKflfkq6ybV9XWOnUNLpMT54Uz4=; b=SISWW+yGjYV599fA6
	vdSU4T0o7En+WzGAhXnRTABjcTxGnpAKVZiBitceo5t82QAmgAbOry/CO4nA5yc5
	dn6IYvuj1b4fufOwBaxbgv/edCYVvtCrfFYrorJrzy2l5hbJZjkTyuyO5tUsYwd6
	dB0bDtWnWzzj7aZqw68VVzDNetcYLWmAeXhTGQ1/BON7XmdD9vFJuYPOIbDE0NwW
	bYwy5n1AL6/BhJYVItG5cmb1wc89Er3MMC5yV7zXLk1Y/IX2+pxcTCw94Krw1c3d
	Xx+IVb3BG2vFd72dwYc9wovz5dmgDNj4zDawJLknEBRFHGm9AQNSj1Mbq3KZ1gr7
	ye08Q==
X-ME-Sender: <xms:-dhKagzxFQYEQ57ZFzJ4iWkNJ8MgYh0pF8h6aGcNV_ysRk4Sra-pOA>
    <xme:-dhKan-raeSE-lFaOP8wL2y8mtwO2_5k5sXMcRWsCmiXMyKTgo9nsz7iFaD2znTwb
    cSY72nyqiIIiuuk_NF2Hj_uMKeKPRBHXHEcZtQWz9CuO7Y8XA>
X-ME-Received: <xmr:-dhKasJ56bQ8bJdy3AwC29XOGVzVUla_eIIU47molQNUoOIRtcAqQ9qHOxCc9yuTNFY4R6-fDukrJZ4t-XSltZmfhFkfR-Y>
X-ME-Proxy-Cause: dmFkZTGDNA7WB0pb5ZPMshx4pScUdKXfHb7VTa7xbOJn4ZLoZvs+FLUT18DTgGuVKUkbLS
    d/3vGL0pIMJ4s0r7JQHdnVfMUpqyEvmomMpb7PR/9bKDk2Mppoo4Xc7QpZHfQZ2YQC2nIg
    Xyf67bpvXR/bVfBxz7kAPu+a5Mr7AmO1WAs4flb35PHnJrkVDuKv7GaZl8ayaT3Dhwp8vk
    gYfflj7OnmJTr/EnQZJbw1EbPh0lXfJfBsl695e3K2ePfLj8Hip7Srpehm2Vd5zinGJNzg
    2CGackhzKQ9oxMmyNV70BNOG80t+AxEonBy1BL993On7VUle0IqaoB9Iwn4YF+W666DpGS
    9HdrDAas5s8cqBuRK1DVVg5Z+1rplZHtp14x/6yEjrAXVtTbispf79LJzL2g/QymnIrm+F
    RMXOJEhh1Hiqc6RLw9U9KGG6gclwYYNAAZzGdG5jV3TzHGAgmPKUoVbhUJ6mEy7DQ12Ag6
    0H/GkSmGzACQND9yCnm+y3zn1Lqgi2uuGFYwqjNJCB/w6fyWBilFz7U33hvcgw8cJ8Xy0I
    JEsK7ZohVTWDNO+X7Rm4iu6wC0IB5MbPNk6N2pKQ/KHQ2yUZIv+z0dX5qxzj2M1wb0c6Z8
    VxflDZ0/fiw21Rre99FLP7u0AhaFQN3OPfVyNNgsihjnItt0buisER/aIMeA
X-ME-Proxy: <xmx:-dhKaleTkikagMhcpFcOrhgMSjyDG84m_HrsnZzxtq79-deu_cxgvA>
    <xmx:-dhKaj-1chCZ_sBipJpXurvoWwaQviByyb2Qtvv1rbkrbAGdIwATvw>
    <xmx:-dhKaqrk8VZz9pW7crv33qbYA46NJMT70K_xeYYMK0iuyoyfaA1jiA>
    <xmx:-dhKagCPL59bDhJI-WnyhIAXzYXn9t__YpZ8wtRrnyHr4q-EVwZ21A>
    <xmx:-dhKaiQJZZFaAx2gxEdaLab3cFhThCWCRH3Eot052Imxmv4o4Mv5RSdZ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/14] nfsd: use do_lookup_open() for non-creating open requests too.
Date: Mon,  6 Jul 2026 08:19:46 +1000
Message-ID: <20260705222032.1240057-15-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23009-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1557770B9CE

From: NeilBrown <neil@brown.name>

Now that we have do_lookup_open() for creating open requests, we can use
it for non-creating too as do_lookup_open() is already able to do that.

This means that when exporting NFS, the lookup and open can be combined
using ->atomic_open.

The resulting simplification allows fh_fill_pre_attrs_unlocked() to be
moved into nfsd4_open_file() (renamed from nfsd4_create_file()) so it is
closer to fh_full_post_attrs and fh_fill_post_noop calls.

As ->op_create_mode isn't defined when op_create is zero, we need a
local create_mode which is -1 (illegal value) when op_create is zero.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 106 ++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 643cf4302db5..b244ff8f4e4a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -243,29 +243,30 @@ static struct file *do_lookup_open(struct path *parent,
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
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -276,14 +277,22 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		return status;
 
+	status = fh_fill_pre_attrs_unlocked(fhp);
+	if (status)
+		return status;
+
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
@@ -318,7 +327,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v_mtime = 0;
 	v_atime = 0;
-	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+	if (nfsd4_create_is_exclusive(createmode)) {
 		u32 *verifier = (u32 *)open->op_verf.data;
 
 		/*
@@ -340,9 +349,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_nsec = 0;
 	}
 
-	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-	if (create_status)
-		oflags &= ~O_CREAT;
+	if (oflags & O_CREAT) {
+		create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+		if (create_status)
+			oflags &= ~O_CREAT;
+	}
 	open->op_filp = do_lookup_open(&parent,
 				       &QSTR_LEN(open->op_fname,
 						 open->op_fnamelen),
@@ -364,14 +375,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -474,46 +486,34 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
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
 	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);
-- 
2.50.0.107.gf914562f5916.dirty


