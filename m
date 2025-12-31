Return-Path: <linux-nfs+bounces-17384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEECEB0CA
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A656F30222EC
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8223C4F3;
	Wed, 31 Dec 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr9QOlgJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839A2D7D27
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147765; cv=none; b=AHk+G6PQYWVPuTdwP3zImSbDbL/A57UFns8nK+JbUtfdvEhclyuNJ3Lx4j5L2bttMO7XMA2FLBHS7Dh3GWxNqw4hHgYdklmDDqlwOcOJ++xIZFuOcewAt4Rr4bFw60RAXDNUWOrnp7LB0JffSgTeMwQX3xMNf+CP3bAAaPILzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147765; c=relaxed/simple;
	bh=gV4FClh8NNSF/sBw+1NWCJut//d+cXyfPxCBwyIpMcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rapDlp7yg1QE/Hl6qAXC7evA9Mm/hmx5NEKvqxLhNkz5IlNPYbM++8pW5/1RI66csjG4dMNPdAD7oc78Mex7o8gScs68eo1Z74Jx1wlYMPJ0i6dFTs1HmnicOpVOAyxVUcSou10zdu82wjX4mzNxcN/ixV0p8yN2j2Zbn9jOvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr9QOlgJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so7035524b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147763; x=1767752563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9rHdvKvx1Tk+w8rUY6CHbKwXE7Sd0b7w0L+YhGVjkE=;
        b=Mr9QOlgJ4ZqQVD0nWzMWEIsqJEeEFgnEwuURpBq4As87ad4II6wAR2nLESuS5RH39F
         +HTi+xfpveZn0krNHUqvDEOKkSb7Fjr2lC2TqRvOXifJ0IU5uEI2vlT5gsx/x3rUCcX+
         TJjTS/K5KT2iJEQrctHModuZiwt6iLunrlrzgddfO+xYzR4LyACPfUvsUhQMtUePJ7f6
         r8C2k+RCDF3aezwTy1F0NavmbYyUQ21zE65DTHgN03+rkCV4LqaDIDM54j4Lj4FqV9Zb
         ZDwetYnad7CeLngM0STTov7K4jdRxxDX46AaqFD5MmiRgamgTBzgGk+ZctLI1/J3muAO
         uPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147763; x=1767752563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9rHdvKvx1Tk+w8rUY6CHbKwXE7Sd0b7w0L+YhGVjkE=;
        b=UKt/aiV/iABA4N5CB+UBedpusc0+s0iRkliTfZBLDi+n3Jj6cn4LkGItef3YsKbOVK
         TrmZfkZh6IjBOLgf70pWT3rk+9CrNh6Jh0aUiouu62msGVdSzI21I3LqBTaQHw5vj00U
         zFZBnpAz0RtkeVIyFjHHebQ5ljAd6VQ+liUdAD9Ov3sEIQRzOXrSud9AnUr6Tkc9fbU9
         4uQNHKZl8a6x31HeCi6jepTUuNrWyEKfajqYZn5khB3vSReF9zdLjk3s/8KevfTCSS2l
         dZqeGrPTV7hWxSzvCLayQJFkQx+lONMXWXBGQ4uXl8e6z7JtIx+7BPRh2mXe5rJyK07I
         FooQ==
X-Gm-Message-State: AOJu0YwHnNv7cThMxYoxSfTdPwKf2qC8GSYDb7/0MzbfPZps6x9fc9y+
	qg9YJ4naFiTaVw0zrwQYwm0ZqgZ+KzXtX5sdgSO9qxHzx5ddAAnXba5rUcxrJWFUPw==
X-Gm-Gg: AY/fxX6TesQY9Fn5KoF2V/8iwKEOUYtS0TwM6nMm+EA7bZlVTRl4WUCnm10s8oF3Y8V
	7Wx2wU7yzB8FJ0vF6YdMm+qCDPlvQ7uVcHHi/34rA23L7bF/hPPBZJxGnKkJDO4vecndqayw8rl
	u6W1BbyrU9/IvCnmKjhdMsRk0iRf2SVXg83RHb47PlmtQATKeH2Q50mUhJaKFKIAmqSY4+LvB7C
	SLIaWlMAwxj5CQxZhiQcsFCalVd8cpDNf6n/M58V12perp6PXXrnxsD42BZiKm7HjtGpeAXk9/n
	AjA78KVoDMb6u9r7B+EcZT9zzg/xOeessFdcho6KHN5sUue5aT8DiZADlfOCRzqH8W/dSfzxJ2S
	r2aNjAxMEL3OUsD+AWURjAMzvW/vq0PWQ6JBgSFaLUYmL4tAxcT6OK2byvEAogij00BZJqw3osq
	FJkl5r/mxx2jrfy96T28mf1lFwbJDjNjN4dcN2baxRDXr6QSAk6gRkI0hu
X-Google-Smtp-Source: AGHT+IEP3bbnop2pmNOCn5uaGXUBvEpaw98A2cuKdi5Yw48nV9s+6ALYz712+Sgg5ORwfziB6HLObA==
X-Received: by 2002:a05:6a00:3492:b0:7e8:4471:8db with SMTP id d2e1a72fcca58-7ff66e5c4e3mr29331835b3a.60.1767147762953;
        Tue, 30 Dec 2025 18:22:42 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:42 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 17/17] Change a bunch of function prefixes to nfsd42_
Date: Tue, 30 Dec 2025 18:21:19 -0800
Message-ID: <20251231022119.1714-18-rick.macklem@gmail.com>
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

No semantics change.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/acl.h      |  2 +-
 fs/nfsd/nfs4acl.c  |  2 +-
 fs/nfsd/nfs4proc.c |  4 ++--
 fs/nfsd/nfs4xdr.c  | 36 ++++++++++++++++++------------------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 7e061fee2eea..85a90ee37405 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -47,7 +47,7 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
 
 int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct nfs4_acl **acl);
-int nfsd4_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
+int nfsd42_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct posix_acl **pacl_ret, struct posix_acl **dpacl_ret);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 84bef41848ca..e4bcb2874a4d 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -177,7 +177,7 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 }
 
 int
-nfsd4_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
+nfsd42_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct posix_acl **pacl_ret, struct posix_acl **dpacl_ret)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ae5c1f5b714d..073e9707f41d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1205,7 +1205,7 @@ vet_deleg_attrs(struct nfsd4_setattr *setattr, struct nfs4_delegation *dp)
  * Set the Access and/or Default ACL of a file.
  */
 static __be32
-nfsd4_proc_setacl(struct svc_rqst *rqstp, svc_fh *fh, struct inode *inode,
+nfsd42_proc_setacl(struct svc_rqst *rqstp, svc_fh *fh, struct inode *inode,
 		struct posix_acl *dpacl, struct posix_acl *pacl)
 {
 	int error = 0;
@@ -1319,7 +1319,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
 	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status && (setattr->sa_dpacl != NULL || setattr->sa_pacl != NULL))
-		status = nfsd4_proc_setacl(rqstp, &cstate->current_fh, inode,
+		status = nfsd42_proc_setacl(rqstp, &cstate->current_fh, inode,
 					setattr->sa_dpacl, setattr->sa_pacl);
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 72530203e985..453c0317c171 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -379,7 +379,7 @@ nfsd4_decode_security_label(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsacl4_posix_xdrtotag(struct xdr_stream *xdr, u32 *tag)
+nfsacl42_posix_xdrtotag(struct xdr_stream *xdr, u32 *tag)
 {
 	u32 type;
 
@@ -411,13 +411,13 @@ nfsacl4_posix_xdrtotag(struct xdr_stream *xdr, u32 *tag)
 }
 
 static __be32
-nfsd4_decode_posixace4(struct nfsd4_compoundargs *argp,
+nfsd42_decode_posixace4(struct nfsd4_compoundargs *argp,
 			struct posix_acl_entry *ace)
 {
 	u32 val;
 	__be32 *p, status;
 
-	status = nfsacl4_posix_xdrtotag(argp->xdr, &val);
+	status = nfsacl42_posix_xdrtotag(argp->xdr, &val);
 	if (status != nfs_ok)
 		return status;
 	ace->e_tag = val;
@@ -452,7 +452,7 @@ nfsd4_decode_posixace4(struct nfsd4_compoundargs *argp,
 }
 
 static noinline __be32
-nfsd4_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
+nfsd42_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 {
 	struct posix_acl_entry *ace;
 	__be32 status;
@@ -475,7 +475,7 @@ nfsd4_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 
 	(*acl)->a_count = count;
 	for (ace = (*acl)->a_entries; ace < (*acl)->a_entries + count; ace++) {
-		status = nfsd4_decode_posixace4(argp, ace);
+		status = nfsd42_decode_posixace4(argp, ace);
 		if (status) {
 			posix_acl_release(*acl);
 			*acl = NULL;
@@ -669,7 +669,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 	if (bmval[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) {
 		struct posix_acl *dpacl;
 
-		status = nfsd4_decode_posix_acl(argp, &dpacl);
+		status = nfsd42_decode_posix_acl(argp, &dpacl);
 		if (status)
 			return status;
 		if (dpaclp)
@@ -680,7 +680,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 	if (bmval[2] & FATTR4_WORD2_POSIX_ACCESS_ACL) {
 		struct posix_acl *pacl;
 
-		status = nfsd4_decode_posix_acl(argp, &pacl);
+		status = nfsd42_decode_posix_acl(argp, &pacl);
 		if (status)
 			return status;
 		if (paclp)
@@ -3622,7 +3622,7 @@ static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
+static __be32 nfsd42_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
 					const struct nfsd4_fattr_args *args)
 {
 	u32 trueform;
@@ -3633,14 +3633,14 @@ static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, trueform);
 }
 
-static __be32 nfsd4_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
+static __be32 nfsd42_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
 					const struct nfsd4_fattr_args *args)
 {
 
 	return nfsd4_encode_uint32_t(xdr, ACL_SCOPE_FILE_SYSTEM);
 }
 
-static int nfsacl4_posix_tagtotype(u32 tag)
+static int nfsacl42_posix_tagtotype(u32 tag)
 {
 	int type;
 
@@ -3676,7 +3676,7 @@ static __be32 xdr_nfs4ace_stream_encode(struct xdr_stream *xdr,
 	__be32 status;
 	int type;
 
-	type = nfsacl4_posix_tagtotype(acep->e_tag);
+	type = nfsacl42_posix_tagtotype(acep->e_tag);
 	if (type < 0)
 		return nfserr_resource;
 	if (xdr_stream_encode_u32(xdr, type) != XDR_UNIT)
@@ -3734,14 +3734,14 @@ static __be32 encode_stream_posixacl(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_encode_fattr4_posix_default_acl(struct xdr_stream *xdr,
+static __be32 nfsd42_encode_fattr4_posix_default_acl(struct xdr_stream *xdr,
 				      const struct nfsd4_fattr_args *args)
 {
 
 	return encode_stream_posixacl(xdr, args->dpacl, args->rqstp);
 }
 
-static __be32 nfsd4_encode_fattr4_posix_access_acl(struct xdr_stream *xdr,
+static __be32 nfsd42_encode_fattr4_posix_access_acl(struct xdr_stream *xdr,
 				      const struct nfsd4_fattr_args *args)
 {
 
@@ -3851,10 +3851,10 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
-	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
-	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4_acl_trueform_scope,
-	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4_posix_default_acl,
-	[FATTR4_POSIX_ACCESS_ACL]	= nfsd4_encode_fattr4_posix_access_acl,
+	[FATTR4_ACL_TRUEFORM]		= nfsd42_encode_fattr4_acl_trueform,
+	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd42_encode_fattr4_acl_trueform_scope,
+	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd42_encode_fattr4_posix_default_acl,
+	[FATTR4_POSIX_ACCESS_ACL]	= nfsd42_encode_fattr4_posix_access_acl,
 };
 
 /*
@@ -3985,7 +3985,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 	if (attrmask[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
 					FATTR4_WORD2_POSIX_ACCESS_ACL)) {
-		err = nfsd4_get_posix_acl(rqstp, dentry, &args.pacl,
+		err = nfsd42_get_posix_acl(rqstp, dentry, &args.pacl,
 					&args.dpacl);
 		if (err == -EOPNOTSUPP)
 			attrmask[2] &= ~(FATTR4_WORD2_POSIX_DEFAULT_ACL |
-- 
2.49.0


