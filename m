Return-Path: <linux-nfs+bounces-19048-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BhVKiyLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19048-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096E1630E2
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 001B8300B19C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D672D7D47;
	Thu, 19 Feb 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ZLKufK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704851DE3B5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539241; cv=none; b=IoMTExIrLEWbtGY++hj8j7fMe0Q+u4dCs8X/SG2sU5gtqOvvKE+5Ho2lBCECq0YjImmyfPsN6nHUEft7SbYvXIc431uRmbFdceZAVKt/N1U5Nn63l5Up7xmezcLgN278T5jVIt34wJL1/XVqYhaiMhgk7Pm4NxI1RHUroPCpQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539241; c=relaxed/simple;
	bh=TBigmVJnLHGhacOXJU78jWl/EEqfmex3ptoK/3FXQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmHgi668z3WkgwsVGjqdJE98d8V8oeSeulps98SiwgcuWD0hIIgb8XnJKOzTspMtdOQBCJyKPiVqwH87lhtXC5YKyV1/ShE1762fN9o5sYRc5KnLN77jZttOQbTzljlc+NZVPHCSojyhBzzPQdyHY3NW28iQ69zE7Csd065m9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ZLKufK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD97C2BC86;
	Thu, 19 Feb 2026 22:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539241;
	bh=TBigmVJnLHGhacOXJU78jWl/EEqfmex3ptoK/3FXQwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5ZLKufKZZd3MxAD3/9f2ybSr3mKI6nCS+fr+zFHky5pGPNFyI8lRywUkL58BIQE3
	 dqklPcU+2Y9OVs8HGwjqcb4p6tI1AlZl7TVrvJVtZVTK4Nvqe3hC8JUWpId3vScsCa
	 j3sEYoFHD2F1TGjo8d6tex7kw9rY2tu90588F0Dx68PsJX0FECGcPSDsbKa0eRNzg/
	 A200z9ToddKNVC/4pTqiXCebia2ONXb6t2vgRk7vrmm+CxkzgVHwsEsh6veb9STcZH
	 Wa0FVZjfp+SzvuuLodMlUvxZnc+KnXVZYdlJPV3tJqnJQ4nlWjEj2GX9AebAA5+dU+
	 3Sft4wk1GdMqw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 05/11] NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
Date: Thu, 19 Feb 2026 17:13:46 -0500
Message-ID: <20260219221352.40554-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19048-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 9096E1630E2
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Allow NFSD's 4.1 reexport of a 4.2 mount to perform SETACL by passing
thru nfs4_acl that was decoded from 4.1 client directly to 4.2
client.

Update nfsd4_decode_acl() to save the ACL's payload off to an xdr_buf
in the nfs4_acl. But only do the work to decode that ACL payload into
pages stored in the nfs4_acl, via nfsd4_decode_nfs4_acl_passthru(), if
the exported filesystem supports nfs4_acl passthru (like NFSv4 client
does).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/nfs4proc.c | 27 +++++++++++++++++++++------
 fs/nfsd/nfs4xdr.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/xdr4.h     |  2 ++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9a21e94a4215..796954a24cde 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1219,6 +1219,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	bool save_no_wcc, deleg_attrs;
 	struct nfs4_stid *st = NULL;
+	struct dentry *dentry;
 	struct inode *inode;
 	__be32 status = nfs_ok;
 	int err;
@@ -1276,12 +1277,14 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	inode = cstate->current_fh.fh_dentry->d_inode;
-	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
-				   setattr->sa_acl, &attrs);
-
-	if (status)
-		goto out;
+	dentry = cstate->current_fh.fh_dentry;
+	inode = dentry->d_inode;
+	if (IS_POSIXACL(inode)) {
+		status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
+					   setattr->sa_acl, &attrs);
+		if (status)
+			goto out;
+	}
 	save_no_wcc = cstate->current_fh.fh_no_wcc;
 	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
@@ -1292,6 +1295,18 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserrno(attrs.na_dpaclerr);
 	if (!status)
 		status = nfserrno(attrs.na_paclerr);
+	if (!status && !IS_POSIXACL(inode) && setattr->sa_acl &&
+	    exportfs_may_passthru_nfs4acl(dentry->d_sb->s_export_op)) {
+		const struct export_operations *ops = dentry->d_sb->s_export_op;
+		if (likely(ops->setacl)) {
+			status = nfsd4_decode_nfs4_acl_passthru(rqstp->rq_argp,
+					setattr->sa_bmval, &setattr->sa_acl);
+			if (status)
+				goto out;
+			status = nfserrno(ops->setacl(inode, setattr->sa_acl));
+		} else
+			status = nfserr_attrnotsupp;
+	}
 out:
 	fh_drop_write(&cstate->current_fh);
 out_err:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cacdd6285e90..f14c2fb45142 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -287,6 +287,45 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 	return status == -EBADMSG ? nfserr_bad_xdr : nfs_ok;
 }
 
+__be32 nfsd4_decode_nfs4_acl_passthru(struct nfsd4_compoundargs *argp,
+				      u32 *bmval, struct nfs4_acl **acl)
+{
+	u32 acl_len = (*acl)->payload.len;
+	unsigned int pgbase, num_pages;
+	struct xdr_stream xdr;
+	__be32 status = nfs_ok;
+	void *p;
+
+	xdr_init_decode(&xdr, &(*acl)->payload,
+			(*acl)->payload.head[0].iov_base, NULL);
+
+	p = xdr_inline_decode(&xdr, acl_len);
+	if (p == NULL) {
+		status = nfserr_bad_xdr;
+		goto out;
+	}
+
+	pgbase = (unsigned long)p & ~PAGE_MASK;
+	num_pages = DIV_ROUND_UP(pgbase + acl_len, PAGE_SIZE);
+
+	*acl = svcxdr_tmpalloc(argp, (sizeof(struct nfs4_acl) +
+				      num_pages * sizeof(struct page *)));
+	if (*acl == NULL) {
+		status = nfserr_jukebox;
+		goto out;
+	}
+
+	(*acl)->type = NFS4ACL_ACL;
+	(*acl)->len = acl_len;
+	(*acl)->pgbase = pgbase;
+
+	for (int i = 0; i < num_pages; i++)
+		(*acl)->pages[i] = virt_to_page(p + (i << PAGE_SHIFT));
+out:
+	xdr_finish_decode(&xdr);
+	return status;
+}
+
 static __be32
 nfsd4_decode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 		     struct nfs4_ace *ace)
@@ -325,7 +364,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 		 u32 acl_len)
 {
 
-	struct xdr_buf payload;
+	struct xdr_buf payload, saved_payload;
 	struct xdr_stream xdr;
 	struct nfs4_ace *ace;
 	__be32 status = nfs_ok;
@@ -333,6 +372,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 
 	if (!xdr_stream_subsegment(argp->xdr, &payload, acl_len))
 		return nfserr_bad_xdr;
+	memcpy(&saved_payload, &payload, sizeof(struct xdr_buf));
 
 	xdr_init_decode(&xdr, &payload, payload.head[0].iov_base, NULL);
 
@@ -356,6 +396,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 		status = nfserr_jukebox;
 		goto out;
 	}
+	memcpy(&(*acl)->payload, &saved_payload, sizeof(struct xdr_buf));
 
 	(*acl)->naces = count;
 	for (ace = (*acl)->aces; ace < (*acl)->aces + count; ace++) {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..d3561ce76a12 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1011,6 +1011,8 @@ extern __be32 nfsd4_test_stateid(struct svc_rqst *rqstp,
 extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *);
 extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
+__be32 nfsd4_decode_nfs4_acl_passthru(struct nfsd4_compoundargs *,
+		u32 *bmval, struct nfs4_acl **acl);
 
 enum nfsd4_op_flags {
 	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
-- 
2.44.0


