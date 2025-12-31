Return-Path: <linux-nfs+bounces-17371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8325CEB0A6
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A95301B81D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84578257851;
	Wed, 31 Dec 2025 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqKCB45D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9402E22AA
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147735; cv=none; b=lW3IGoyLcUDh2l0qQ48xnwex+tgUUiOdzCLDfDxK+kYvHR8c+AlmHmmfe/pPjBWIdDQwfyGffGeRUQAFsxlmLCT0Jod10NhUMVAPF+gVrGGQ0OrkBpAYZeZdtzfuNHylNL4HEoPPGdO3XZFlWUhofgT/cS9kbnl+bkKIvAxVvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147735; c=relaxed/simple;
	bh=VCfD2JibYb6Cp2562cntWYHLDErpiuK4p/zRu7AKbhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBZV/va6p1xzPwdhKncn21O7qoyqCoWsnDC9TKeiB74GgS091sJSwMxrwewZxdq+Tf5dOAlDkfPpLu/5R+e4nRWb4cnUmPr1oEOoqYHJWsESRIQd5qb+8y1NeNOTHkU1pFf4+B0l8Lu/G73n36c0dgluwzljvXH4eNKe6hY7OkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqKCB45D; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso12345893b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147733; x=1767752533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzOSstUx8vcD33PI39CSCZYHFc5KXl+2lc+4W3n8GZc=;
        b=aqKCB45D+moYTmU0pXtY9Eo9jERcucvMn1nm980a/aiY6bSAqAHD1TKhtp9mNOXSdi
         StCJzUd7u86nzfopiE/oSkjUuy9xd1GolhL+ckiMotSyyA21iWsHK5pk4lwFtXijgzjz
         BP6USOSQUU9aBOUCrCDqsqGaDziFEDZjKH2j/2WHaKISzlgLCaJGTu9FvrR2SUwudGUi
         238G7aXvl3t54MrYn1L/lwe6QKhWOODXRTk6WgS5hS7nbhKLX36Lt87NAtnriuII2rZz
         LC0lKIwDzDmqo/6jdKhfygB0aHNMUkSAYEI+AiB5WjSrvEnhdbhyju8Fss8bsnsMFH7j
         tlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147733; x=1767752533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzOSstUx8vcD33PI39CSCZYHFc5KXl+2lc+4W3n8GZc=;
        b=b2bCJlZdaD4PbK3HMJ+PFCcTPUb/Kf8SMV2ANsThmw0Q+iR4tAv2vZGfCgneW5HFc2
         bem0tDdj9eC2WDQh1bIwyitVJOpJBc9Py+D+9j8/1l4zOpLRPKdS14xSgJOFs7KNLyTs
         bz/H/cYt15925TQlgG6HCDEuf/KJ8jax6SEuUkPAy9aU2L8d1IMytx8iMmlCf8BhOZH5
         Ncd4hQzJLoGYHEMeGDljBWAX4oHPzRYn9EzV89z8Mt5C2DQXs/+NGobcTH9elHiH0KWM
         iiDddlQqylFywGjx+ENMOmsjofDMV/nti3sB/MZ7ezW2YpW++3yd/HkUt/0vQkRe7+v1
         Wd2A==
X-Gm-Message-State: AOJu0YzqZiAjOlyG2h0pEpRt/YGHBAqnIrvpAHIV+HwuOqgDihA1Okmo
	hVtFQ3XWdUtr7yFc4AURL2OpWWSBcOIYxtcuy/kD9UzMs0KPQZ68dpqwMXdjrbQ=
X-Gm-Gg: AY/fxX4PX1xR/pJxoTGBoWAXwp0+fAV/L0NCXrAEfVMAeCXyQ3nV03u6q7xiYBNIqog
	+qGHLY9TaGvjLcakTsQwVv2UbdQY6SfjyG+dV6bENk1o2yrR78be+gSV7O9HmYFKM/UUNvxJWJ+
	HTrKTsxtKES7Lyu1KYy+nebShLlQBd+Z9QlJ2AacC/N/sjYlOzgmoHRI6qh/NvjgI4BxqyWekDG
	uz5oDDk5Xn9uPqajzdSBoEPsK7tXpR3iFqEAeayhvVQJax5UzfYLuPGylhToAVEb0BEbyPrNa36
	HT5jjB5E8IJ5XiqQoMPployx+iWRkT01B3/hbabx6xB198wtw1P9cKqY2D4IHwizmhyJnYz9cAo
	VF1+9HdOcttuRWOxjbuiWnxdkz3ZRWMgvKYygyELKvU5kChsp+dtZVuF/yJZKaocrT8z3ShVHOv
	tSBvoCziPKL9gGXN0mPnIrByC2FUOik2Lsq0spRhIe1c4GeOr1YodbX1l4
X-Google-Smtp-Source: AGHT+IF4utqBOpPYPNEY7g3mel/fWCR/+0hslrlCUmLPl/lieKbVV6jgdJZbDCHsYrvMkpRmkX/NMg==
X-Received: by 2002:a05:6a00:2a0c:b0:7f7:1cce:d7b4 with SMTP id d2e1a72fcca58-7ff657a1000mr30533279b3a.1.1767147732798;
        Tue, 30 Dec 2025 18:22:12 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:12 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 04/17] Add support for encoding/decoding POSIX draft ACLs
Date: Tue, 30 Dec 2025 18:21:06 -0800
Message-ID: <20251231022119.1714-5-rick.macklem@gmail.com>
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

This patch adds encoding/decoding of the new attributes described
by the internet draft "POSIX Draft ACL support for Network
File System Version 4, Minor Version 2".

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4xdr.c | 292 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 287 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5065727204b9..5f996b3a4ce4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -43,6 +43,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/xattr.h>
 #include <linux/vmalloc.h>
+#include <linux/nfsacl.h>
 
 #include <uapi/linux/xattr.h>
 
@@ -377,16 +378,123 @@ nfsd4_decode_security_label(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsacl4_posix_xdrtotag(struct xdr_stream *xdr, u32 *tag)
+{
+	u32 type;
+
+	if (xdr_stream_decode_u32(xdr, &type) < 0)
+		return nfserr_bad_xdr;
+	switch(type) {
+	case POSIXACE4_TAG_USER_OBJ:
+		*tag = ACL_USER_OBJ;
+		break;
+	case POSIXACE4_TAG_GROUP_OBJ:
+		*tag = ACL_GROUP_OBJ;
+		break;
+	case POSIXACE4_TAG_USER:
+		*tag = ACL_USER;
+		break;
+	case POSIXACE4_TAG_GROUP:
+		*tag = ACL_GROUP;
+		break;
+	case POSIXACE4_TAG_MASK:
+		*tag = ACL_MASK;
+		break;
+	case POSIXACE4_TAG_OTHER:
+		*tag = ACL_OTHER;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_decode_posixace4(struct nfsd4_compoundargs *argp,
+			struct posix_acl_entry *ace)
+{
+	u32 val;
+	__be32 *p, status;
+
+	status = nfsacl4_posix_xdrtotag(argp->xdr, &val);
+	if (status != nfs_ok)
+		return status;
+	ace->e_tag = val;
+	if (xdr_stream_decode_u32(argp->xdr, &val) < 0)
+		return nfserr_bad_xdr;
+	if (val & ~S_IRWXO)
+		return nfserr_bad_xdr;
+	ace->e_perm = val;
+
+	if (xdr_stream_decode_u32(argp->xdr, &val) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, val);
+	if (!p)
+		return nfserr_bad_xdr;
+	switch(ace->e_tag) {
+	case ACL_USER:
+		status = nfsd_map_name_to_uid(argp->rqstp,
+				(char *)p, val, &ace->e_uid);
+		break;
+	case ACL_GROUP:
+		status = nfsd_map_name_to_gid(argp->rqstp,
+				(char *)p, val, &ace->e_gid);
+	}
+
+	return status;
+}
+
+static noinline __be32
+nfsd4_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
+{
+	struct posix_acl_entry *ace;
+	__be32 status;
+	u32 count;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+
+	if (count > xdr_stream_remaining(argp->xdr) / 16)
+		/*
+		 * Even with 4-byte names there wouldn't be
+		 * space for that many aces; something fishy is
+		 * going on:
+		 */
+		return nfserr_fbig;
+
+	*acl = posix_acl_alloc(count, GFP_NOFS);
+	if (*acl == NULL)
+		return nfserr_resource;
+
+	(*acl)->a_count = count;
+	for (ace = (*acl)->a_entries; ace < (*acl)->a_entries + count; ace++) {
+		status = nfsd4_decode_posixace4(argp, ace);
+		if (status) {
+			posix_acl_release(*acl);
+			*acl = NULL;
+			return status;
+		}
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		    struct iattr *iattr, struct nfs4_acl **acl,
-		    struct xdr_netobj *label, int *umask)
+		    struct xdr_netobj *label, int *umask,
+		    struct posix_acl **dpaclp, struct posix_acl **paclp)
 {
 	unsigned int starting_pos;
 	u32 attrlist4_count;
 	__be32 *p, status;
 
 	iattr->ia_valid = 0;
+	if (dpaclp)
+		*dpaclp = NULL;
+	if (paclp)
+		*paclp = NULL;
 	status = nfsd4_decode_bitmap4(argp, bmval, bmlen);
 	if (status)
 		return nfserr_bad_xdr;
@@ -542,6 +650,28 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
 				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
+	if (bmval[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) {
+		struct posix_acl *dpacl;
+
+		status = nfsd4_decode_posix_acl(argp, &dpacl);
+		if (status)
+			return status;
+		if (dpaclp)
+			*dpaclp = dpacl;
+		else
+			posix_acl_release(dpacl);
+	}
+	if (bmval[2] & FATTR4_WORD2_POSIX_ACCESS_ACL) {
+		struct posix_acl *pacl;
+
+		status = nfsd4_decode_posix_acl(argp, &pacl);
+		if (status)
+			return status;
+		if (paclp)
+			*paclp = pacl;
+		else
+			posix_acl_release(pacl);
+	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */
 	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
@@ -849,7 +979,8 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	status = nfsd4_decode_fattr4(argp, create->cr_bmval,
 				    ARRAY_SIZE(create->cr_bmval),
 				    &create->cr_iattr, &create->cr_acl,
-				    &create->cr_label, &create->cr_umask);
+				    &create->cr_label, &create->cr_umask,
+				    NULL, NULL);
 	if (status)
 		return status;
 
@@ -1000,7 +1131,8 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 		status = nfsd4_decode_fattr4(argp, open->op_bmval,
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
-					     &open->op_label, &open->op_umask);
+					     &open->op_label, &open->op_umask,
+					     NULL, NULL);
 		if (status)
 			return status;
 		break;
@@ -1018,7 +1150,8 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 		status = nfsd4_decode_fattr4(argp, open->op_bmval,
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
-					     &open->op_label, &open->op_umask);
+					     &open->op_label, &open->op_umask,
+					     NULL, NULL);
 		if (status)
 			return status;
 		break;
@@ -1345,7 +1478,8 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	return nfsd4_decode_fattr4(argp, setattr->sa_bmval,
 				   ARRAY_SIZE(setattr->sa_bmval),
 				   &setattr->sa_iattr, &setattr->sa_acl,
-				   &setattr->sa_label, NULL);
+				   &setattr->sa_label, NULL, &setattr->sa_dpacl,
+				   &setattr->sa_pacl);
 }
 
 static __be32
@@ -2930,6 +3064,8 @@ struct nfsd4_fattr_args {
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	struct lsm_context	context;
 #endif
+	struct posix_acl	*dpacl;
+	struct posix_acl	*pacl;
 	u32			rdattr_err;
 	bool			contextsupport;
 	bool			ignore_crossmnt;
@@ -3470,6 +3606,128 @@ static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+
+	return nfsd4_encode_uint32_t(xdr, ACL_MODEL_POSIX_DRAFT);
+}
+
+static __be32 nfsd4_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+
+	return nfsd4_encode_uint32_t(xdr, ACL_SCOPE_FILE_SYSTEM);
+}
+
+static int nfsacl4_posix_tagtotype(u32 tag)
+{
+	int type;
+
+	switch(tag) {
+	case ACL_USER_OBJ:
+		type = POSIXACE4_TAG_USER_OBJ;
+		break;
+	case ACL_GROUP_OBJ:
+		type = POSIXACE4_TAG_GROUP_OBJ;
+		break;
+	case ACL_USER:
+		type = POSIXACE4_TAG_USER;
+		break;
+	case ACL_GROUP:
+		type = POSIXACE4_TAG_GROUP;
+		break;
+	case ACL_MASK:
+		type = POSIXACE4_TAG_MASK;
+		break;
+	case ACL_OTHER:
+		type = POSIXACE4_TAG_OTHER;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return type;
+}
+
+static __be32 xdr_nfs4ace_stream_encode(struct xdr_stream *xdr,
+				struct svc_rqst *rqstp,
+				struct posix_acl_entry *acep)
+{
+	__be32 status;
+	int type;
+
+	type = nfsacl4_posix_tagtotype(acep->e_tag);
+	if (type < 0)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, type) != XDR_UNIT)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, acep->e_perm) != XDR_UNIT)
+		return nfserr_resource;
+	switch(acep->e_tag) {
+	case ACL_USER_OBJ:
+	case ACL_GROUP_OBJ:
+	case ACL_MASK:
+	case ACL_OTHER:
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		break;
+	case ACL_USER:
+		status = nfsd4_encode_user(xdr, rqstp, acep->e_uid);
+		if (status != nfs_ok)
+			return status;
+		break;
+	case ACL_GROUP:
+		status = nfsd4_encode_group(xdr, rqstp, acep->e_gid);
+		if (status != nfs_ok)
+			return status;
+		break;
+	default:
+		return nfserr_resource;
+	}
+	return nfs_ok;
+}
+
+static __be32 encode_stream_posixacl(struct xdr_stream *xdr,
+				struct posix_acl *acl,
+				struct svc_rqst *rqstp)
+{
+	__be32 status;
+	int cnt;
+
+	if (acl == NULL) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+	if (acl->a_count > NFS_ACL_MAX_ENTRIES)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, acl->a_count) != XDR_UNIT)
+		return nfserr_resource;
+
+	for (cnt = 0; cnt < acl->a_count; cnt++) {
+		status = xdr_nfs4ace_stream_encode(xdr, rqstp,
+						&acl->a_entries[cnt]);
+		if (status != nfs_ok)
+			return status;
+	}
+
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_posix_default_acl(struct xdr_stream *xdr,
+				      const struct nfsd4_fattr_args *args)
+{
+
+	return encode_stream_posixacl(xdr, args->dpacl, args->rqstp);
+}
+
+static __be32 nfsd4_encode_fattr4_posix_access_acl(struct xdr_stream *xdr,
+				      const struct nfsd4_fattr_args *args)
+{
+
+	return encode_stream_posixacl(xdr, args->pacl, args->rqstp);
+}
+
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
 	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
@@ -3573,6 +3831,10 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
+	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
+	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4_acl_trueform_scope,
+	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4_posix_default_acl,
+	[FATTR4_POSIX_ACCESS_ACL]	= nfsd4_encode_fattr4_posix_access_acl,
 };
 
 /*
@@ -3610,6 +3872,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.dentry = dentry;
 	args.ignore_crossmnt = (ignore_crossmnt != 0);
 	args.acl = NULL;
+	args.pacl = NULL;
+	args.dpacl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	args.context.context = NULL;
 #endif
@@ -3699,6 +3963,20 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			goto out_nfserr;
 	}
 
+	if (attrmask[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
+					FATTR4_WORD2_POSIX_ACCESS_ACL)) {
+		err = nfsd4_get_posix_acl(rqstp, dentry, &args.pacl,
+					&args.dpacl);
+		if (err == -EOPNOTSUPP)
+			attrmask[2] &= ~(FATTR4_WORD2_POSIX_DEFAULT_ACL |
+						FATTR4_WORD2_POSIX_ACCESS_ACL);
+		else if (err == -EINVAL) {
+			status = nfserr_attrnotsupp;
+			goto out;
+		} else if (err != 0)
+			goto out_nfserr;
+	}
+
 	args.contextsupport = false;
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
@@ -3747,6 +4025,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		security_release_secctx(&args.context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(args.acl);
+	if (args.pacl)
+		posix_acl_release(args.pacl);
+	if (args.dpacl)
+		posix_acl_release(args.dpacl);
 	if (tempfh) {
 		fh_put(tempfh);
 		kfree(tempfh);
-- 
2.49.0


