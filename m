Return-Path: <linux-nfs+bounces-7154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014099D198
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E216C1F2468D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365A1CFEA2;
	Mon, 14 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AnwpwClr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08271C32FE
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918908; cv=none; b=qQciCW5BQfpphSXgpzdQ3R3Sw6+5TUOTwUOG1uhtd2PM9lRPWLc6yOlVHINnF6C0SCElPCroVlwa/aIdoEQMChu9259TmFFIvb3wQfQKbriOooNCFORbzw7ZypTUd09kNnANCElad+OVzXwPI8hAQIvKvrH2kDT5TJCd6WhVeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918908; c=relaxed/simple;
	bh=K+VmdhpCUdytTi8DRHz8Ar8BXNcPqnkXTLuH0kUYKvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBX/VTpCb0Ndw2aOH+NPmRiItFUHmdOkEeQC5eAbflJV4+5ZRtO0VDRGTMFdg0LPlxEWkwqjbJNymwyQoUUuHyxbi32Y1RkNixu5aPtqmoW7z99YbpERfdFJjMz4Xg6i4xOn1MPttzs6hfKcrnKbpiMLmpxe7W79xMXLT+BSPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AnwpwClr; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918906; bh=bHv1UO7IMwvV06D+Xx0bjVVo9VkCj8df8TY8GRx7WvY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AnwpwClrX0QITEdbEATnwICi9svtdZmyMPpCOV0dtz1dgqOww/11ReP7TOESMaznIlByJFV77oVHAZhSjqN3or1uPM5q0xGtEF2l1mZJ4Sf/KjmOqzljKT7fR/b970eUcuv5ccLBRel8BmHVXXty2xxYpzoPPH2ZgNA0srTHqlhNTJXKpcOVqZZGscBOxF3+0BTSJnO97GRdSP4A0BtJXmVq16nbaenrw1KGfjLROA59TO+9HQz5KvOh1UyhbbXLWvxg+2Ioh7DnRhVsKqGHLK9lFHvL7NEV7PglpvaWeaiN1tCAnJln8L57sd2dZ84iS0ueN/cnAQm6fdnY+ACVAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918906; bh=uryQrzzfqkXuekHCcNroMy++Mp5mDKnbc8kmutQWKM9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mhMalrZciQej/YBEnoJfURxa1TpyoJlGtsf0hONo4ZV1/9QnlDEhKx/9YLTkyNGYsQirzrg9qD+Q+28qaK2MJpTy9TFCsZkS0RhNhvNKy4+2hDfv5VYODS6So3TyolG3dzubU11g95qqciYd/DafUA2ATDFzZntIQ44SijHD8n5Pzcm4OKCPTanp31ghbOOKe+SiM3yGU6dGhX3illgBTxCn2rB3xLrsMA2QFoQiM1nLBNuunmr3AmA8Hpp82/a6XLVRuhND2igL/pIrD5BD99BC5Mj0YAVSsX8crLCY+Rg+3VHTe9/lWxPBtlEmjPyOOzh+amYvZkeshzQ6cPWcGA==
X-YMail-OSG: tVQgn74VM1mpqMr3JRXDkj5RTmwZe4nj6zHuHuNBLR9UrH_npXajnFiWOQSZJ_I
 FqpYAvB6jYjcUgDUNOnooNNyUgVm89uXWyOrg69EQ7vTcT6SoRDLtcNmQmrmiy.IQH.mmoh1hOp_
 ZJtTVucWX99KgFJO30FACApKfOtnHav5xYCEO_9jK2nwSXxgNzmXyKuSBeZon.SGOmXwadHqhxxY
 3l41VNyUZTeDMqfYZelsdSBIqSdM1KvtZ6uqthT_rFl5SC1IRUNincL6voHLoxN3EZtWSenYKB9C
 QU9lLBW25LKPG.geXAv8FzRniDHyeg6OXKnnwutX_O7TMCMs4iZGXYRzXMxS3zs5q_3oN8XFoTXy
 yuUgvAlviHedvofhKce1Mrh7SdmKfzqRee7eLzD6PzUhk5FE5m4drKHdaFXlHUoKbYAloSCB36Xd
 nk8EncSJZ.TGsuSZxZEk_gBYOwZapPu9J2asRf9R0AcUAkaHjkF4cjn0OPBiGUiZsN_oC56fqBZo
 5zLIvPn9AUdhDujh04wqRwOPav8iAIRyHJZWHeTsRd4sM_rq_dwfoYVrAF4jxbtn7kzaamdFDvlx
 Ioo1NFRgcge.EFmb5uPORjserk6Vb7mbNAqHXaQ7eSVhc4uBBwsg2s7RUPGID2qwAdqkUu6QQZJ3
 Q3gaIm6rQ.LEpTgZHX7EBXrQas5fnt0SbXjidibZby6dbyrd1ofusYWvsgEKolf5RneFHBK9TEt0
 6vRN4CnriRUM2TfV9rjq4bNFCnrepnKvBdqUNpXZpjksasuxYN1.4exGbsHQK2X2M85WLWi.dVmO
 CwvzxQahLulAdTo4QBBXwoS1XUJuUqSUTRpeIEDBLR2Xs_hV6MtBtPpGJuN.IGAijzq_r0xJLlzp
 f2c_RjWM403I2hjiLA8W..oCbIJW_14upgdjzkJPskV_6Iu25GusAyh3s.pcm803mka3XqxgM3gV
 ARqKdIGsz8MFlVhwJp7y196tJsek16o6EGbWtppI9ud5zDVjGpoQAr9t2GaeQh2xs6rsqjV1qK_p
 fd6sPCBP2.1O8WHfQGfFJubB7U09FmNiK5gbuij9K26sxYQ.nMKVlZn0zqt1sBlEnTACwqqpdrFi
 Op0HuDSuIAvCV0l.FMf4pxLurODjnhpqbnwv4WkBWYN6e9iUJp0Da.F7mdOiEIsRhsYUqmjeYK.A
 MTVKbDuGpYiSjwDuVOcz_m7sJ4e0O9hMBJ9AnckXOwlUkVIP_MiVAeAn5BqZmGUZTifac0KItyGa
 LOxfjlJxfJP.C_Y0dKuNOSTlItkd6lZ0rx.Wxzpw4G_MifsIVDUtrDTMHfPRH0XZzKUqUBa9XhuE
 4ADXot366RxsBEXRsR9HjmMlPjhf50IAM4lePZ8EDsSsiHMIk.P9UZwcESCd4exUkZlO5uSpPJP9
 tvLhO0YSqDrWCHgPLfQMu6HAnPdSr0DCM1WvqUxInKUOWXCeaghmQRIYVLHWU7k5.pEZ1mA26mdX
 voJpoKLKZ5uyZeZKGAIohsUXS2IJiJIuRx9jfFJ4TIOK2SNpQ4_UrH7xoJ9PWuWs2H_pFqk1NDrc
 S6h1pdXP.j3N.UZoVJc_G.f5eK9Y2cXbm.w39g2rD79e3r0uHggc770hOGEt6koNkc5eHtqIQFX3
 .ZSMdTvaDvuPgxNjcps_PBobkER5i_Fw6t.HwIz4nK7wBghke4.LcmcDlQzx_H502jLXlwOsS8YS
 3a44BXNTRgWY8RTv3W6fX_zmdyPp2vH33OFzMzijdNVNjaXjGC5gWPjXT2UAvefj4sEbGdDZKQdo
 bRh9Ckb_AmMRE5VHXta1AJWYnUkdEnkmn.nscQaPB17YwyjZHqDTJauQbuokDXx78CfI4pBZDg2t
 GBMUqiEs_n0g2F83ho7ygbtRcduvQNOOa46qcOCLy6zq_5gQevyzb_0OuYuAvbJzcPE.NA3tNiJY
 OqyuDhIlpRpZg4X41mXtepgLGvzoOfdDhHTm1zMfn2qJ26WbQSRQunMiLmMtv8N0FbZzjK_CJUpL
 cNhGNReEXBmzn9ZJ1bx.lp0BlPiH.xAo68s8c7QpcbyykFs8owREakMdTojUUay3lPglu9ODJNel
 xstYN2QbcfyU9y0zeoXlGQbvREOkEdU.a25MZp3krizEjt_V6Khevtp0dQnGua8xObknjqb2YXa4
 eReRLcTqrbRrKQkxZiiEwEZRumvPNmUDsoVPCpp_fA4nUeyO8mLHHbD2m5b8h2AOLT.ALovXXruY
 ak4RgCd28J.z6L8HhlyZBqVx8FifxExioln2UuMFiR60Nra.6YfS6mCDzaKSRmBTBpaopYTQv2G7
 8ZMPG1GhHFtlmE7h7lzqES8Tm4Zm3JV6RSxEGRN4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9387055b-7561-4f4a-bf09-95d4bce60f66
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 15:15:06 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c392927ea0eb898578ed262d71f570d;
          Mon, 14 Oct 2024 15:15:00 +0000 (UTC)
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
Subject: [PATCH v2 3/6] LSM: Use lsm_context in security_inode_getsecctx
Date: Mon, 14 Oct 2024 08:14:47 -0700
Message-ID: <20241014151450.73674-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014151450.73674-1-casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey@schaufler-ca.com>
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


