Return-Path: <linux-nfs+bounces-6534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DA97B652
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 01:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E79B25CB8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD8193094;
	Tue, 17 Sep 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hn/ISBsz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED95192D79
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617143; cv=none; b=GIVnSume2d33hT4fwzqu+YvcguaSYgddqXInCoIT3utlsw5T7NjRt+3LgUjo8GU6g8k7zu95ugvRxiOAnU1ZAL4N0z4VooTVvo3oDtToyubd+Yjyr0m4ZRhWM1TWw3clI8iQD9kfezbusreQBE1pf5lQBZP2Fy5a0CamL7VvKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617143; c=relaxed/simple;
	bh=ZJapXEMnEXjgBf06xr4rChcIXxCqKNBmTicTTIaZzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSUAGGq4025dAaHFJ+QN5RsGjHGpB0oj8B57LaMjecZ6N2JSnA9PZLE0GH73ZxAsm2TKqTeN+jm9aH06Ky58MFZDmyGB5sJmNz4X05b/qtea24XaVRQIbWkkkpArEGUQDxwCs3Qro7rQySl2WKxW9c5waMlifFxoX/e9OqGqmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hn/ISBsz; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617134; bh=HwhEZurlYPiZoyXWG+yVjdL1lvyaBQOOmbnCAkgpOgU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hn/ISBszt/ucqkndJ37AwhMFcS2RPrSLt3sUfJ114vhXf72zEBCMn1ehEth4NnvWiFXFdbX1iDXK56+iNqCU3xo72KZZD4ylDmp1Z6JQoJu/i3D2g+uzQ9yhi3ymAVaffNaEhN42kLsBVD4RoneCppEAuB8TPz4pVrNredQDqgnxoKJvL2ky8OU4FhViMgNHXuBhFGt7l2hL6eE9BlK/tlThHi4cZMXtCViQp49FrLTB6Nqdag1mlAqGHMbQI3EQF/n1Z0SkOGaD2S9iURhkE8nhmvbd7ZbjIbbAFlqSblxbWVAXULQ4ofxIm1/YoJThk/o4VRMqtaM15Ro+zTjsSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617134; bh=lISlh75gMieUPMDXvfvrMaj4OjKFG8pVzDeO6XmhFKy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CTniH1a1A/DnU5wi+pg/Z1XXzRFpmIPxHwRak7XPEo1GiVqvrJZK1FHqLfuduO3TYQYbspWyjktOh2IWSFgr7bZnolew7BjNzwFYZ7dzAuc5yxOP/hgw9gMTbr+B88QgMM9Z6YOHSM+jYjqip6mv7braUBYlwW6U0ZkjSHyw8z2pHmsvpcqSmOiEulflS4SIcUucXadvcgyF6s2kND9BVz3TERW9QAMiRFh/eFW5t0Gu/19r9iH51xKhsCiQbnhL6xCGiT5BUBufdt4kkki6mru7MAAakTJ3X53LBug2l35G7gXb7vv8rh2Tyjrk/MnH7BBCMEvSyAn0s/drX3K43Q==
X-YMail-OSG: PjiI3z4VM1lDQy1_qkAqfZw0aQe2txnsei_yB7idHvq3SRDsjusSVAKXkRR_2IW
 4DH8pY7kC9iPqnKEnh_409WSyKCD1UDUd9XJqKrgb9COOKggEypinafxN7QfwrkqglNM3uXI8ncl
 Im4SAwemauBsLvVQjC1iQ0wR0ukWOkKoK8D5utTeM6suq_TYbBqnK0SEO6nMl83KsElLANWqcQmF
 PJAbBs61tkV1Voyr_VbvV4f0JmhfawrD9RFqptxiLxGBaQ1FdeOnltGiqKKp27Ipw6YLIKlQxqRU
 mQFPjdKgpyYkNo1gG.cpf9qHKQ9rkdcMbmXaZ1wIZrg4gtUlh7fqrj6dCnFRjA.2uAG1R4ecmhpi
 3LjFbU8O646NsaQKOzm2jF8Dm8txPXUnmot5iC5Cm6qbVQWCjcTDF5KU1c_qqBEGr_3Vrl0L6HKd
 QIV7OXM0YtPLA1eQdy9WV6__WusJw0rz13ji2.FkS4HoOB3loDRDwNB74jNtkAujE19v2aDf3XnR
 3laQRdX_otpwi9P90uy0An1bzzOKt7po0ov1as3FJlwroFhgUs3eJGqJM7yp2OtCjlMosp24IVmH
 1COYffCKB9Jk7fri.3LDk3td8VDFvwGYX5mblu0kjKI9d1eM3eUL7VSBL5K6lkGqcieOvV6gJ7l7
 LS2kSGVIzMEXi7UNoGj48nDF2OwrmsB8Ch32n6gcuDJhm_taAEGY_fV8u0WQshI9FN1sFjJHH1z2
 iCfUDpaJTpEiI.hGXzb.QWUQDc3scXw4v5AADzJcLBJeZAl3biM_9K5nx5jwJWET_sZOH_jeyhsy
 wGimvYxE2ykE7PyECVgmdw9ZNGIdHZDZtJMtUcNZBiTTJOKePXZl.1PjqGp.2AqIlUOZtV7AIxxm
 VVuBYbqzLZvPEusHBhOF7c8Md5JsALyh3lErhFqPvNJ_97xBaQXDQIQRJYZ3q7ym.eMUgPgFpxlc
 Yi6svVbz6vUBeB61mPoxevbpUVnDJGlICioGT45Fm2VnDQZyEwxGPovVOOdN9uoRTldES2XM7LXP
 mzTXnX3WjFGsKrKqW4EJKWIILIuhAEx71Dyd60aR_nJSRsiZJUapBWNfHhXIlVLwdmJa_uyUyNmM
 P9Ky5xw7m_WHBCIrWGaIM7rb_Sswdw8O4ptrDLGHcDQdxZnXXML7_M_Bx2NS5WM3HR.u6aKn5exa
 W79bBLDFaO7i7GLDdd4s7WAAOGSXBFtX10Ipi.BJkTuOcFwl7.w_TnT6bS5t_m0ILnuPJT8fOIi_
 2NAUNsX0Q1x_RtmuBZQy9IkdinlbGPWLt2CBGCkcxQtebKisI2hG_hNzLWY1VvE2Qm34ddm37N4z
 qMxCWlId35q9Capjpo3AQ8sgrUKir00Mq.Ih2v360a_Uc.NRCnnRim98g7q_6OignaeqijNsAGyq
 0dhWdIQ3tO8CiE44Lsqy.D1jDInIsTphnTMFpAtWcGmiorecsUTOdJ0xp1xaPp7J65S1QSd_Y1kP
 8hor8Oaw2JfOKSYyKdY_GZ_k_.E..PalE9bSGwTBbjF136YBtWC76KH.5oT8pLofqwa2hEJLI1vI
 Uw8jTwb9uRn0EHnHXuWn5xPSwGJq5H2uKu9e8LhPhqbm8USYJpWDw3QeNXhRNq6hJ4yUaIE9ZKqK
 7S9Bpiv7JsywAH71gc275nD_4j8FkcWm0VtN4ewNPPGsK9342rkZ_FE2FQQIdkW8kmsBc.VrfMoY
 rcwRO_DT42yR1zRL.tLG5jEvL5NLTCgxMn07PAJTpm8bGA0kPZawKFQuujsWAch9mRA0Gh.DwN_x
 .Xyp6fA5xdA_yzxeUsdSqyfd6PdbW.O3l0B8xIYKJybz_c9K3yCa2UZ39Uyq3bsTAPxgYAaeoyW2
 Jpjhp15QMIh_GUyoxZ8utpMyjVW8Z8vbVsNMpYU8bKxD3sznTXysZajTzwkfQSgsSFJwRVzMByss
 TLsc6hMQZz2g6qx_DREwSEuIp0e1mjdyzme.1bm83sbJca_LcrW.Img_SWSGedq1Zc80FqL2x2bT
 81VijF8I.QkOswk8sT3.hcyfuqyRdm4WLP_4z7FjxbA.sGC3G.R3Fi8ptkcJYosZhceCLOkydUIu
 Y8GbuUwTl1ddMY_ixQVY3vF.9_4Ew93fZCfFexXnazl6v3had.HCd9d5wHPWZdvqyhVF8zqM.VLK
 Kdq8F6kuJyiVv5LJGlU6LM53q2iW38dUHRNDxfhlShk6biypSbRh9RYbZ36L7coF3QVAapaoumQG
 9Cbk2mh8bDRMy_py1C3OlQlyQG6WzTah324uUSQNa5lnttjE4Qq8wjyB8Vi_TVSJbf8Q_tCYr357
 eCocGmW2t95xAqkNdauxxZFpD9lhBghMgdZdhUdM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0366572a-28d2-41bb-b886-5bf0c27a477b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Sep 2024 23:52:14 +0000
Received: by hermes--production-gq1-5d95dc458-vkwd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b3a84955471b9061a763fb967f12395;
          Tue, 17 Sep 2024 23:52:08 +0000 (UTC)
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
Subject: [PATCH 2/5] LSM: Use lsm_context in security_inode_getsecctx
Date: Tue, 17 Sep 2024 16:51:59 -0700
Message-ID: <20240917235202.32578-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917235202.32578-1-casey@schaufler-ca.com>
References: <20240917235202.32578-1-casey@schaufler-ca.com>
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
 fs/nfsd/nfs4xdr.c             | 25 +++++++++----------------
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 security/security.c           | 12 ++++++------
 security/selinux/hooks.c      | 10 ++++++----
 security/smack/smack_lsm.c    |  7 ++++---
 6 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c797cd7b2148..97d9875246fe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2835,11 +2835,11 @@ static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqst
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
 
@@ -2849,13 +2849,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2938,8 +2938,7 @@ struct nfsd4_fattr_args {
 	struct nfs4_acl		*acl;
 	u64			size;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	void			*context;
-	int			contextlen;
+	struct lsm_context	context;
 #endif
 	u32			rdattr_err;
 	bool			contextsupport;
@@ -3394,8 +3393,7 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_security_label(xdr, args->rqstp,
-					   args->context, args->contextlen);
+	return nfsd4_encode_security_label(xdr, args->rqstp, &args->context);
 }
 #endif
 
@@ -3617,12 +3615,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.contextsupport = false;
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	args.context = NULL;
 	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
 	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&args.context, &args.contextlen);
+						       &args.context);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
@@ -3659,12 +3656,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
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
index 95c7640919ba..8090952b989e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -300,8 +300,8 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
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
index 2604ea16cd6d..94bcb4c69a9c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -576,7 +576,7 @@ void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
@@ -1564,7 +1564,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 58f5fe1eb6c0..5a739279ed49 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4312,17 +4312,17 @@ EXPORT_SYMBOL(security_inode_setsecctx);
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
index 01e44a14d3d4..159837b4ee41 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6687,14 +6687,16 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0);
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
index e85efe894ac3..b443859948e9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4918,12 +4918,13 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0);
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


