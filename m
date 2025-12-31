Return-Path: <linux-nfs+bounces-17374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D3CEB0B2
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657E0301896D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214682E22AB;
	Wed, 31 Dec 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihvQEgMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909223C4F3
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147742; cv=none; b=UBvKZx2dFypVBL9aRdHEkCQYfZVrtzSTuCnB7WND1szwndVn7QusFanb90HqCn/K9kYXeVrkDlzohC246aHjZTRQWJBxhGbsN0eP8KZGeLy3V5Z4sQzfsT4tt07rsbVQz8bh3T+sYNipIrvWTxDMNNGqNl2U1ICCRO+KWpaQqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147742; c=relaxed/simple;
	bh=Vqxh+LwFV8piBplUCD3A4FgVP3O6sxi7mS1pPNER4WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEdqFuU7KyNg8iQ2qtCsFryGrqtMv7l/61KbKRGMaHbNTHlLkTU3wrXrQmvfbk8/n3I1h2Bsr/cZWESnGdsS5206BmwqNRK2m9+q04duGKR41epb9bnmPnITQ7HnsPzRn9gOCRF5Md4s+UDY81jUCDG97A1n3bXBZ0xbvqQtNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihvQEgMI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so4960675b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147739; x=1767752539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9ghf+BYCdEhj+udgKtxbYrArO7CF+vqtLnvR1yBPB0=;
        b=ihvQEgMIKy/lf19ho8jz843fR1hxjHGZpd9OJois0k41FYZUuzaZZKgECDPUXIiWWl
         xaUVCYBJePx1/z5fWtKx64JEmyJe1TYVKfgxwwWh+HjXPIZWhuELDEmyp1mN1S4Y/zo5
         yUYW16fOR1Y7X/Swoi8dnbUO+0sIYUF0PUaZVs/D54b8oO5xqav91/zpYiJn2y4yGhZu
         Vg32e7kyWlngOBp/WA9v3jTmdbeWe2E7o3h0zSV84LK9oN5hLFQXe2vnmd3FzxRTjfgU
         CxXpBuOn+UIlBT5jJX6vMkjIywwILMIDHSFXjrS+77xcWTlbb7cBSBq4rDbY7NJGs56h
         pz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147739; x=1767752539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9ghf+BYCdEhj+udgKtxbYrArO7CF+vqtLnvR1yBPB0=;
        b=P6ox8nlRPyex9OkPEu5bwi9oifAGQO5pfU1iFMADZ0Hm2nLh3Hpv1kaeOvpo4e/Ux7
         ZDllnmPzGgYgSlhhUlxrLRNsl6W8xclGJ2nJ6oPBNNcxUpDZvc5YJqpAxpM8uRk3/W2M
         cO+CbWG5qx7DGbNW+gL84NpdSdsuFzIZbqw5DywWKwa3DsgKr1jzvs1DvEl6NalXr4QR
         4WMTQCINF26Ne9fUBERasaVWRqArjAdDIUAl0cfiTDxiF+0m2hzQvyn1UqbQhxZ+TpHr
         Iumh7/H8lDUrKU2GdRNeCHINJSTxqXIhNoqBXyLUaWBpLGWn4RsHEhxYa9w8cWhO9gGY
         jwhA==
X-Gm-Message-State: AOJu0YxXM3Bai97H43QKpsF8kaQ13/1+7TEhF4tm2TNiyZpegiyApLW/
	ZhLxXU0IGFYWpUWUlpGHw+rmKF76ROhJxV22YZDR+boJzFVSobagiLc4cawniGc=
X-Gm-Gg: AY/fxX61G08EPEJ0O9SiIA8GJeZgfVPmQ9elKjXhPr8PHZqdV2Wy6gmQdtcRPGX7YAz
	ZkiZMmIReJD+cnQW/+4J5yhc1JeGH2PCLFBRY6xR2fX0+7RCqk9IwDnAnEw5pIuUa1h8Fp87tWl
	ZgtOww5FBdDv2zfZoBPeV8NY6T3gXip4uKpMhKS1apSu8Rhy/6NtqiyPyGI0WiPpe1IJ/8MUXIm
	rxziabaf3S0Zm4xA+5WsducDCLg7j3OSVOfznKnm8UzkbUNEzIHrFcABX5cxibYgsnf9MMYVIHV
	9nnxLHiQypzH9H9EB6pOAbMp04AgXvpQZ/bddBJ83stewQPO2qfKLshsz7aZmHFtBfzrhGvG1+0
	XhIgS09yF9akfIXpUb/mfDZm2TvpftG9SH8aERc4rJcndfwQIAcogJDouwGxOSIUHMfh/sd1eB2
	RVNOQwJGZvHZWIhZPA08G7GLFyDz58d625JqZT1/qjqy7KYc2ZQr5FvHwG
X-Google-Smtp-Source: AGHT+IHrfCoeBfgJKfKeQbEuhQOH43wXPDz5tlfwZpk/GuwXo88r/IDm2gkOiA1wvC1RFI62wmrKGQ==
X-Received: by 2002:aa7:9309:0:b0:7e8:3fcb:bc41 with SMTP id d2e1a72fcca58-7ff547df601mr29819235b3a.22.1767147739421;
        Tue, 30 Dec 2025 18:22:19 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:19 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 07/17] Add support for POSIX draft ACLs for file creation
Date: Tue, 30 Dec 2025 18:21:09 -0800
Message-ID: <20251231022119.1714-8-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

For NFSv4.2 file object creation, a client may specify POSIX
draft ACLs for the file object.  This patch adds support to
handle these POSIX draft ACLs.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4proc.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr4.h     |  4 ++++
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71e9749375c1..a172bd253086 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -91,6 +91,10 @@ check_attr_support(struct nfsd4_compound_state *cstate, u32 *bmval,
 		return nfserr_attrnotsupp;
 	if ((bmval[0] & FATTR4_WORD0_ACL) && !IS_POSIXACL(d_inode(dentry)))
 		return nfserr_attrnotsupp;
+	if ((bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
+					FATTR4_WORD2_POSIX_ACCESS_ACL)) &&
+					!IS_POSIXACL(d_inode(dentry)))
+		return nfserr_attrnotsupp;
 	if ((bmval[2] & FATTR4_WORD2_SECURITY_LABEL) &&
 			!(exp->ex_flags & NFSEXP_SECURITY_LABEL))
 		return nfserr_attrnotsupp;
@@ -265,8 +269,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	if (is_create_with_attrs(open))
-		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+	if (open->op_acl) {
+		if (open->op_dpacl || open->op_pacl)
+			return nfserr_inval;
+		if (is_create_with_attrs(open))
+			nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+	} else if (is_create_with_attrs(open)) {
+		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
+		attrs.na_dpacl = open->op_dpacl;
+		attrs.na_pacl = open->op_pacl;
+		open->op_dpacl = NULL;
+		open->op_pacl = NULL;
+	}
 
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
@@ -379,6 +393,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
+	if (attrs.na_dpaclerr)
+		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+	if (attrs.na_paclerr)
+		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
 	nfsd_attrs_free(&attrs);
@@ -546,8 +564,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	open->op_rqstp = rqstp;
 
 	/* This check required by spec. */
-	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
-		return nfserr_inval;
+	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL) {
+		status = nfserr_inval;
+		goto out_err;
+	}
 
 	open->op_created = false;
 	/*
@@ -556,8 +576,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	if (nfsd4_has_session(cstate) &&
 	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags) &&
-	    open->op_claim_type != NFS4_OPEN_CLAIM_PREVIOUS)
-		return nfserr_grace;
+	    open->op_claim_type != NFS4_OPEN_CLAIM_PREVIOUS) {
+		status = nfserr_grace;
+		goto out_err;
+	}
 
 	if (nfsd4_has_session(cstate))
 		copy_clientid(&open->op_clientid, cstate->session);
@@ -644,6 +666,9 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+out_err:
+	posix_acl_release(open->op_dpacl);
+	posix_acl_release(open->op_pacl);
 	return status;
 }
 
@@ -784,6 +809,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &create->cr_iattr,
 		.na_seclabel	= &create->cr_label,
+		.na_dpacl	= create->cr_dpacl,
+		.na_pacl	= create->cr_pacl,
 	};
 	struct svc_fh resfh;
 	__be32 status;
@@ -793,13 +820,20 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
 	if (status)
-		return status;
+		goto out_aftermask;
 
 	status = check_attr_support(cstate, create->cr_bmval, nfsd_attrmask);
 	if (status)
-		return status;
+		goto out_aftermask;
 
-	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
+	if (create->cr_acl) {
+		if (create->cr_dpacl || create->cr_pacl) {
+			status = nfserr_inval;
+			goto out_aftermask;
+		}
+		status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl,
+								&attrs);
+	}
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -860,12 +894,17 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 	if (attrs.na_aclerr)
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
+	if (attrs.na_dpaclerr)
+		create->cr_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+	if (attrs.na_paclerr)
+		create->cr_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
 out:
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index eebbcc579c31..1ec6365c977d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -245,6 +245,8 @@ struct nfsd4_create {
 	int		cr_umask;           /* request */
 	struct nfsd4_change_info  cr_cinfo; /* response */
 	struct nfs4_acl *cr_acl;
+	struct posix_acl *cr_dpacl;
+	struct posix_acl *cr_pacl;
 	struct xdr_netobj cr_label;
 };
 #define cr_datalen	u.link.datalen
@@ -397,6 +399,8 @@ struct nfsd4_open {
 	struct nfs4_ol_stateid *op_stp;	    /* used during processing */
 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
 	struct nfs4_acl *op_acl;
+	struct posix_acl *op_dpacl;
+	struct posix_acl *op_pacl;
 	struct xdr_netobj op_label;
 	struct svc_rqst *op_rqstp;
 };
-- 
2.49.0


