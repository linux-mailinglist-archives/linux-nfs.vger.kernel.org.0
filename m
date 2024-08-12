Return-Path: <linux-nfs+bounces-5306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F594E59F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94721F21F40
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 04:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED63D2AF0A;
	Mon, 12 Aug 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ukOwvS8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R7yF26hp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ukOwvS8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R7yF26hp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856380C
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723435599; cv=none; b=qEgY/4UanrnOJ5aJCuxNesAXv6XkDcCNsIfY/MH3YiFkbbKpgwX8k12YbPMP7ECanqdZyfHlIQBAsZkyfDENMeYdBBN9U+n6y89ztL3VBSVl+Ub8b28PP26P7dtVyBBRBqH4TnMdLlqjgEkaIoCoooSWQyQkGsggiUd/aEA0xrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723435599; c=relaxed/simple;
	bh=j/bu3Q++3GmdiY6fi1xwJpCx7ZcE2cMBh3s68qKeaE4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=O3NAKaUeA5BsnFCmvyD7bmBcMeGOhSG1yhx03kDCVgCv1wjaWsDW1WyPy+RCNbpci78Eiv2NDbOKZFlO0pSBPlcAN7DDk8QAgkpobcLt/zITxtgOKWxUUmQKlGMddxTlbgRKmcfbtmVjIaY2P0WL4UbzAAIeI2V2AwsXtGZfu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ukOwvS8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R7yF26hp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ukOwvS8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R7yF26hp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6054920205;
	Mon, 12 Aug 2024 04:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723435590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CZhuvpclt90pmpoeJIPzajClQqph/b/ol+PIX8tebus=;
	b=ukOwvS8xb2eNajeWpOFRUI6nb+Wi+9uEw6DMDbFLPs4t+u8qFH17QTQPAhetmgyYnJQpHf
	2G+X4o05jQ3fV6Z9+wmhxLkIFNnl9b9+aQW/Zg1rtu4VEl353HdMuGAJfQPxgelZ48GINN
	SU4Rd/PZvn8tnuxmO24Gbyi1zr+xBzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723435590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CZhuvpclt90pmpoeJIPzajClQqph/b/ol+PIX8tebus=;
	b=R7yF26hp/GE4zvNvOxjLXZH4t9SGRsfj0SW0MdfLbhHZOp57xvWqMEns3kj9g6uzc7Rm5q
	YoiZLI/LWeoacmBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ukOwvS8x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R7yF26hp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723435590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CZhuvpclt90pmpoeJIPzajClQqph/b/ol+PIX8tebus=;
	b=ukOwvS8xb2eNajeWpOFRUI6nb+Wi+9uEw6DMDbFLPs4t+u8qFH17QTQPAhetmgyYnJQpHf
	2G+X4o05jQ3fV6Z9+wmhxLkIFNnl9b9+aQW/Zg1rtu4VEl353HdMuGAJfQPxgelZ48GINN
	SU4Rd/PZvn8tnuxmO24Gbyi1zr+xBzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723435590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CZhuvpclt90pmpoeJIPzajClQqph/b/ol+PIX8tebus=;
	b=R7yF26hp/GE4zvNvOxjLXZH4t9SGRsfj0SW0MdfLbhHZOp57xvWqMEns3kj9g6uzc7Rm5q
	YoiZLI/LWeoacmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CE3413957;
	Mon, 12 Aug 2024 04:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ljqvNESKuWYQWQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 12 Aug 2024 04:06:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SQUASH: nfsd: move error choice for incorrect object types to
 version-specific code.
Date: Mon, 12 Aug 2024 14:06:25 +1000
Message-id: <172343558582.6062.9756574878881138559@noble.neil.brown.name>
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 6054920205
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO


[This should be squashed into the existing patch for the same name,
with this commit message used instead of the current one.  It addresses
the pynfs failures that Jeff found]

If an NFS operation expects a particular sort of object (file, dir, link,
etc) but gets a file handle for a different sort of object, it must
return an error.  The actual error varies among NFS version in non-trivial
ways.

For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
INVAL is suitable.

For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
was found when not expected.  This take precedence over NOTDIR.

For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
preference to EINVAL when none of the specific error codes apply.

When nfsd_mode_check() finds a symlink where it expected a directory it
needs to return an error code that can be converted to NOTDIR for v2 or
v3 but will be SYMLINK for v4.  It must be different from the error
code returns when it finds a symlink but expects a regular file - that
must be converted to EINVAL or SYMLINK.

So we introduce an internal error code nfserr_symlink_not_dir which each
version converts as appropriate.

nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
error if the object is the wrong time.  For v4.0 we use nfserr_symlink
for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
To handle this difference we introduce an internal status code
nfserr_wrong_type_open.

As a result of these changes, nfsd_mode_check() doesn't need an rqstp
arg any more.

Note that NFSv4 operations are actually performed in the xdr code(!!!)
so to the only place that we can map the status code successfully is in
nfsd4_encode_operation().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4proc.c | 21 +--------------------
 fs/nfsd/nfs4xdr.c  | 26 ++++++++++++++++++++++++++
 fs/nfsd/nfsd.h     |  6 ++++++
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e355085e443..e010d627d545 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -168,7 +168,7 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
 		return nfserr_isdir;
 	if (S_ISLNK(mode))
 		return nfserr_symlink;
-	return nfserr_wrong_type;
+	return nfserr_wrong_type_open;
 }
=20
 static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cs=
tate, struct nfsd4_open *open, struct svc_fh *resfh)
@@ -179,23 +179,6 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd=
4_compound_state *cstate
 			&resfh->fh_handle);
 }
=20
-static __be32 nfsd4_map_status(__be32 status, u32 minor)
-{
-	switch (status) {
-	case nfs_ok:
-		break;
-	case nfserr_wrong_type:
-		/* RFC 8881 - 15.1.2.9 */
-		if (minor =3D=3D 0)
-			status =3D nfserr_inval;
-		break;
-	case nfserr_symlink_not_dir:
-		status =3D nfserr_symlink;
-		break;
-	}
-	return status;
-}
-
 static inline bool nfsd4_create_is_exclusive(int createmode)
 {
 	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
@@ -2815,8 +2798,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			nfsd4_encode_replay(resp->xdr, op);
 			status =3D op->status =3D op->replay->rp_status;
 		} else {
-			op->status =3D nfsd4_map_status(op->status,
-						      cstate->minorversion);
 			nfsd4_encode_operation(resp, op);
 			status =3D op->status;
 		}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42b41d55d4ed..a0c1fc19aea4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5729,6 +5729,30 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres =
*resp, u32 respsize)
 	return nfserr_rep_too_big;
 }
=20
+static __be32 nfsd4_map_status(__be32 status, u32 minor)
+{
+	switch (status) {
+	case nfs_ok:
+		break;
+	case nfserr_wrong_type:
+		/* RFC 8881 - 15.1.2.9 */
+		if (minor =3D=3D 0)
+			status =3D nfserr_inval;
+		break;
+	case nfserr_wrong_type_open:
+		/* RFC 7530 - 16.16.6 */
+		if (minor =3D=3D 0)
+			status =3D nfserr_symlink;
+		else
+			status =3D nfserr_wrong_type;
+		break;
+	case nfserr_symlink_not_dir:
+		status =3D nfserr_symlink;
+		break;
+	}
+	return status;
+}
+
 void
 nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 {
@@ -5796,6 +5820,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, =
struct nfsd4_op *op)
 						so->so_replay.rp_buf, len);
 	}
 status:
+	op->status =3D nfsd4_map_status(op->status,
+				      resp->cstate.minorversion);
 	*p =3D op->status;
 release:
 	if (opdesc && opdesc->op_release)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4ccbf014a2c7..b4503e698ffd 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -359,6 +359,12 @@ enum {
  */
 	NFSERR_SYMLINK_NOT_DIR,
 #define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
+
+/* non-{reg,dir,symlink} found by open - handled differently
+ * in v4.0 than v4.1.
+ */
+	NFSERR_WRONG_TYPE_OPEN,
+#define	nfserr_wrong_type_open	cpu_to_be32(NFSERR_WRONG_TYPE_OPEN)
 };
=20
 /* Check for dir entries '.' and '..' */
--=20
2.44.0


