Return-Path: <linux-nfs+bounces-7403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD59AD697
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7001F24829
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0591FF7A8;
	Wed, 23 Oct 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hiP81NE6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-9.consmr.mail.bf2.yahoo.com (sonic306-9.consmr.mail.bf2.yahoo.com [74.6.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AF1FF020
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718540; cv=none; b=o75LueWZTYFmiOaal+PdlPDGofRTs+NLfaDf6xJZz2FI+Bc338GkvufppEdtql1UXTmZ5gXjw3/l/uBBX1GKSHh1PebE901boX0M+BJVctKxPX4a/Gm/mOyGEcy54DkyFCNy+f+GKZFKLmeM1YW0AbkKvMi2rCj/sk6VOtizEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718540; c=relaxed/simple;
	bh=K+VmdhpCUdytTi8DRHz8Ar8BXNcPqnkXTLuH0kUYKvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foaIFurgaHF95US5C55tNR5kf2gxJc/j3BeMbCAkr36IN2kAXJfQ04x9h0B1dBEr/zb6lIodXL9ZZkUOvEt4v97RJSQ34zFNULM7DgehF13Xe3FjfBJdf10Q2U9CGL8cNMidXcYAYr8qRJNnLdjp0juddKsAdow68HrblPEtSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hiP81NE6; arc=none smtp.client-ip=74.6.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718531; bh=bHv1UO7IMwvV06D+Xx0bjVVo9VkCj8df8TY8GRx7WvY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hiP81NE6SrxUIkz4toQvrZncIE0iBfMjmEuWXLEx5zTDOiQ2kw0tGEzyK/vQZ+TQrcZYtLGaQWzaStZCjGBbUDQEHcC+f9YsZlA/syXa1SKvDHm3/NnU2JNMrQ7BB6xQts0TymTL683mRQQ6DybTR6vIfVsHB0Y8NeuVZb0ZLtR93pQTxgRMij4zMkNXVG4uq0S7cxLaUVEb3+ZkJ4tY+YXemQV1DeZOcuuLyDsE8UF0AaTIeQOma7q/4GILsHlt7qs4PzzJqCqeAAIszQRfFhHkXiALsv46GX8ZDZuIqBIvd+MsrJNx760MMVABlCna/G7R9qG/Wl3TW9e1FTT1BA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718531; bh=Fsvel/4O5ZDHyADk92whCGECzGNMWVRvOCFW3yM9AZs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NGpIwlff4P+0xSYP3Nlqxs1coe8zKqzA1YY0xB8+IIBxkf+CEI2dcrayL4l4xCSvO1iHbkBn0fib3i1vZAEW76Wr0P46HN0P9+r0LNy4Ubxq1SY/sVuq8kD+4ZcjHze7WCGt3n6/6KFmT61hlI/rC5wjil3TURO37TSfWO+7srbSTwP1zRaChlvmYUpJbWZRYkbcck15FH+eN07RtdjdhCVw7lh94cf6+SCu2BYMrcnofWkv/o88+M64AG/+AsRyYgs3ZUs6z+pRKvgvIu7ovQu4sdL8QuBcM1nrtQG3PZi7ij5ko8A6gh4jjE6tBfMDNnu1x0DaAa5rJR4hZA6/yw==
X-YMail-OSG: Klnj0vMVM1lkYgT6wJziQAeareGLgfi_G2PJNgmw42ed._92cIEvbSNMEgxgkWs
 F2tVNsq9FUrTPSqGs6xk9YFkjwhojXR0Jma0GlxXZ_j1W9CvN4LAdrXh7pfqXXxEeZyXJpIOcuWF
 CUg96iJZF2zHqfeQ_OzxgRfBcstZ7A7l432s3zFut4uNwadStIr7ibD53RJYwPi_VofpSEtCQ12L
 g_RZAxcxssTQj42pfJecb714WublIyoPgAQvWqjC2oqedZg26X7RTU5vMDOoxNBC9kPBa4uTIiii
 yQpDLJzWQVBQYvL_QDOSJy3FfKNFzpCDCfA4r_zObdFrpakTpkruXcJN_Cofysq7w9l13wIUGagG
 ctNa7X3DuknX7d8UNKiTkbyVErr3bG2KTqie6_IHQu8Um5n.BS8nHSceHiLtwttJfYajhTc9uIvK
 aUVxnnHWLaocKDgphskJxJ6.Of5JFOy33TWRsWogd.BUYqDOQC6fqgRZ9UXitYkleIdUh89av8.o
 e29gYJTP0ymVZqWOg4an5lWPFisEQm3aOWSjMKc45hx0xJIqQ6z7GXkhtiDC8yciMZ0VeUopbWmV
 mlsyLr0hRkQFYecmDrDDMXAfwnhhATbQAdEALNzxVPHhzbu7DaBc0xmN2xLA8gHmdMqEBwf6LfoU
 X.WuwhbDZRVbL2NEKajx1XLL1iihtFdVuJfMA.radOkZag3g7ZRPkIq0atC6nTIhp1kCf6QCo72K
 t_HlTDmI_yySPS_n1RyGc51fPbR1Mufx6hPJupelxYfo2vNVHmrLd9aHtY8_2PMtJpte6YN440km
 BSDyKGuX5Urmsqioj9qZ6OI1KFDtONfzAZY0K2ZUUT0gJ5sLh0yAj8_YJWxo.lKf3XzHaIMjo5w2
 5NJFrJtPMOv9MncCajBkeQ6r67ilieEgXxeknf1YnmXKrWL7JeJkuJ19MZJ0vDVz3JG.9c3x19jT
 quzFiNiWvHMamYDpMjwurW_ewQOYI.pl62PICcIau7rinImKz6VfqGF0YtX0KCLPHXNNP0OcDfZz
 B5cLyQ..H.ei.kBqR3aGwYltxbjc5xaIZZLcu7qJmF4JVgXLkUM3q6VYILLon52EyX2jsvqVzowK
 qw9gpxOEkm3qB.trzuj3k3ZxubchMNSeqjIpzRthSxGjC1gqyNM2MDAsGn2FxWUm6OsMlYR6oDEd
 iRaIELmb4hYL59yHv__fZan9jqInq4WrtqwJalLnIJY.RQp.OtF_YbAaJZbn_gsJ66QYfKlQMmJK
 MhOi9cbmgsDBUkidrWWncp3MPcrJXjHylGpZ6ltDCdO1Gsp.IUcSKXGGEFd2oyeEEf7RPAvMCoKq
 8bTrwC6KRCKWSM3kRp1dGLyVN13QVxER_.305HJ2WYCM2AGA3oIi2v4DvMvcOL.jKyQkM8uZfHSo
 VBfuV2zcXkHY_uKBhVuBjaCiKuBmGvZ3FfhIbrfsxpUtjonzyD51uo0EFbWZ4wYdmbQQltq3z4ha
 qdrwtwYlWAYDA6ppnp.8SntowpiTuAWMz_wtehDdSuY9gBlqqRR1fjSQAYPtgX2ZOEXa3UUbVOFm
 mvltW_WmBGxDk.YWY8.G3y36M_tV7DowAZXXwoucywIALJjD73xgRM6J8jkFEib1yjO4rSpli7J4
 f.8j8Z2JL2dY.HY2fzkQmymtLMAq0fkVe1w2tad7ugiGJukZpur82L_cYg6ttS52DjfYQZ0FzhwS
 7GzYn41sfiWToosc6jr9RcN19iH.r87yFD9JNuT6V9LCQ997YirIFx5bp2Uc0J00JixLkPKCgj1w
 8Qm3O1R9ZCGulJPPISWd9TF.5dIhs57Bp3a7Pc_h1hmtt9uL.Xadddi0NT2ciaQWSQDNlJs08VVT
 sp1lQaebpozOfub1HW4OGF1bcAdS8QlY4TmRn6dbnyzIdNFLm.FwKh2KK1kugVZbxO1NVAuYyIAH
 4qgppb8Jp5bU3VQX6k3h3k6cdTv7doaLlZH9loPiSiInWOHv.yrZ24f1TLN3ss70XNVfAysoQDVl
 z37eMHYIR8101.lw3Myq5y_3UcPSKRWePF18lO3BIIP9NQPPK57o4_2wyHk287QW3bzsCRLQdpHQ
 MVxmYYSP21evzyLDAQ_.FUVA7JRKzOMZDTaCXN6yb6Gb5n45QJsEU8V3iOQhNI894zWnyyHHylYH
 .dDRWeZGlx7AbB9MFO1oeVd7B4h7VvU9l9zI2VwhrjSXntKk0f2eH1OIfp_LjsLEdTxKEqYoOoQ6
 kRf1TJ5bVk.cJkzfUOjPo2V2oE7Sad8g9sZkOieGq09Tswsw40DlJFOu7BZI57cz5Xam455YpY5V
 3PykhGfbgyihlvVOvrtm5qJjC6G.XMQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0d0faeb1-d71f-4c26-9e3e-b78883624e4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Oct 2024 21:22:11 +0000
Received: by hermes--production-gq1-5dd4b47f46-5xsmt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a7972f72a0226c80fd86fd6bd5371c9;
          Wed, 23 Oct 2024 21:22:07 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/5] LSM: Use lsm_context in security_inode_getsecctx
Date: Wed, 23 Oct 2024 14:21:56 -0700
Message-ID: <20241023212158.18718-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023212158.18718-1-casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_inode_getsecctx() interface to fill a lsm_context
structure instead of data and length pointers.  This provides
the information about which LSM created the context so that
security_release_secctx() can use the correct hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/nfs4xdr.c             | 26 ++++++++++----------------
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 security/security.c           | 12 ++++++------
 security/selinux/hooks.c      | 10 ++++++----
 security/smack/smack_lsm.c    |  7 ++++---
 6 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 537ad363d70a..93faa238b979 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2827,11 +2827,11 @@ static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqst
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    const struct lsm_context *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2841,13 +2841,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 	 */
 	*p++ = cpu_to_be32(0); /* lfs */
 	*p++ = cpu_to_be32(0); /* pi */
-	p = xdr_encode_opaque(p, context, len);
+	p = xdr_encode_opaque(p, context->context, context->len);
 	return 0;
 }
 #else
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsm_context *context)
 { return 0; }
 #endif
 
@@ -2930,8 +2930,7 @@ struct nfsd4_fattr_args {
 	struct nfs4_acl		*acl;
 	u64			size;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	void			*context;
-	int			contextlen;
+	struct lsm_context	context;
 #endif
 	u32			rdattr_err;
 	bool			contextsupport;
@@ -3386,8 +3385,7 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_security_label(xdr, args->rqstp,
-					   args->context, args->contextlen);
+	return nfsd4_encode_security_label(xdr, args->rqstp, &args->context);
 }
 #endif
 
@@ -3538,7 +3536,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.ignore_crossmnt = (ignore_crossmnt != 0);
 	args.acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	args.context = NULL;
+	args.context.context = NULL;
 #endif
 
 	/*
@@ -3616,7 +3614,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&args.context, &args.contextlen);
+						&args.context);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
@@ -3653,12 +3651,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (args.context) {
-		struct lsm_context scaff; /* scaffolding */
-
-		lsmcontext_init(&scaff, args.context, args.contextlen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (args.context.context)
+		security_release_secctx(&args.context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(args.acl);
 	if (tempfh) {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 01e5a8e09bba..69e1076448c6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -303,8 +303,8 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
-	 u32 *ctxlen)
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode,
+	 struct lsm_context *cp)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 64e8b18e6ea5..7d0adc1833ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -591,7 +591,7 @@ void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
@@ -1591,7 +1591,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 914d8c8beea7..4ca3c9e28b6f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4431,17 +4431,17 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 /**
  * security_inode_getsecctx() - Get the security label of an inode
  * @inode: inode
- * @ctx: secctx
- * @ctxlen: length of secctx
+ * @cp: security context
  *
- * On success, returns 0 and fills out @ctx and @ctxlen with the security
- * context for the given @inode.
+ * On success, returns 0 and fills out @cp with the security context
+ * for the given @inode.
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return call_int_hook(inode_getsecctx, inode, ctx, ctxlen);
+	memset(cp, 0, sizeof(*cp));
+	return call_int_hook(inode_getsecctx, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 692735eb04aa..ce5e45abd8d3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6678,14 +6678,16 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0, NULL);
 }
 
-static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
-	int len = 0;
+	int len;
 	len = selinux_inode_getsecurity(&nop_mnt_idmap, inode,
-					XATTR_SELINUX_SUFFIX, ctx, true);
+					XATTR_SELINUX_SUFFIX,
+					(void **)&cp->context, true);
 	if (len < 0)
 		return len;
-	*ctxlen = len;
+	cp->len = len;
+	cp->id = LSM_ID_SELINUX;
 	return 0;
 }
 #ifdef CONFIG_KEYS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d52163d3dd64..c9ec4d93fb13 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4899,12 +4899,13 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0, NULL);
 }
 
-static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*ctx = skp->smk_known;
-	*ctxlen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
+	cp->id = LSM_ID_SMACK;
 	return 0;
 }
 
-- 
2.46.0


