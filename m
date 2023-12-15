Return-Path: <linux-nfs+bounces-660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B048153AC
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 23:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233081C24577
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9745BF2;
	Fri, 15 Dec 2023 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UvO00vVv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808318EBF
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679465; bh=rCo1n5NulVLUwl0INHBYB1LidebEAHUCa4+pCaV/mX8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UvO00vVvoGXmk4B9dJE6E/3uUWznN0mjPpcVgIUzCWcR/CPXHhF4Ctjh9gIE8zEq0DTMXLaCh1+Vb+cWlGNSQLZl3AoJpClHUVlTNyx+Afm3pbR4Jf/m+IP0awqnCMvYLKKuoOEndo26QL3GQbQ4b1z/uyP/zXHwm8/LdKW43GYeQCBNW59jh1UGVoAQg+Coj7xmfdJemN5Vi+tcXQeQrX/vvsPvj1UbuqUsu2yEQs6mexI7rubq5iCw0HbjGta9eYXExnC18m8Y1Ieedf5tBS88lOasHpf0kVaNBYXDTbqxsIDTTIzr9puPe5LhIvZW/U4e5RYeJvEPzbraKpXOnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679465; bh=2139v8sAj7176eErxK+u02Zn0Dqi4BnPGxmfbZsxQYz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Yx1bNV3YphYRW0Y0G+qK+s1iYwPDBtwQJf8LOawkByVhG3hrvGg7zVEWaxHMhyQRelpkChKfMV8pNlBhdp4RKjPsDkMCFV1zAYCR8p0Bbg/n6u+LsJ8ofRPXWpcztq0pzntH4NBXRDcmZv3SSud5Z8uBSlwP5TJvdbmc9+rECSnDKhT1WoGRNWpk1/iIOLJWG3S7rlApx1lHAMsyepp6xOaOTG8Di0Tcf7B7dcoqhiqqhfjNDFiRez32POuvcnwU0D1PxMUt8yeiX7wOetYFP7PoNJVkEzGm9uC16FHYxfpqlXqaiaLgOScTFclfLHM3+vRRURe7eTsiZwxJZUTAhQ==
X-YMail-OSG: OuTCzF8VM1neUYExZposEVH3Rd5CRFWDvGYvm4mjLMpUgDTaDnZJT.Rohg8qvg8
 9bkTwSvyQ1hZ9G9xsAkU733bFZXZypPB4KkEmcCG8uV6hQnxO1GnsR3065u12S0dyqYSqCIphBaf
 dqlTn.0gAlRIeEomao6YRqKsQ.6ICuvv0ieGKRO.Svtem1SkEh6iPrY2zpLTPCYI9tvW1XbRmncL
 bKnIN197c6mhKPKl7XubCpE90mJPrnHmGhYUC_b3xDkDmTlsL1.RA2gzT7r1tpVh9wB.YNBpN2D1
 .ALwoDTU4I0yBw3tih9BertkmPiP03jZ5gdLgv4Qyodyv269w.mb3c5HPWh0mL74TywlOENZqoEK
 gKkVjmcKfw.FVm1b6d3zqfXspc7vPHS3u2yiYgY2wubIXUdxI0NH4SMTFbbJJk.MjCu4NyskcKYE
 ggTkTwbvZ3l.aG9R2c5o.Dk.GIGahACKGW90CaYx5lvCAWPhzKTpzmDvD64TjIfOVJ.GBUkeYRBm
 gcEly2bqWL5nrWBB6X341a8w2tCPqYibbrXX7emxGm1..J.IoRaawQINXpcj9WfjCVf8_jfc9_50
 h6rxxUhnW7db1tZLHJCFonk3hwJFceQQTHDZ4A0Os9cGySSkF0nJTpGf4eIYRCBrg0ng0sF9rcp.
 fUoeFShiArvd2nlH0l3pO5I.PvFRbKiaclB7Xj6OKFk9quxqMXG_Vddce83wVL9H2TvPNP7yn3EL
 sNXAHUrciubObrMYjj4D81adFq0032rWw9Hr42FRT7KT6DRN2Kcj1B4c4wmge_vvz.3THlKXTqmc
 9QQvbVx_fToLympzSzRJHQjNACn6cA8xSuASd_kkRAZbOcapOBSSDw..B1iYL272F_GOGXlQ8oDZ
 nA47XjgCSStNduGdLwtg5xLsEYOfEi3cuf8iIk6D_Q33cuw_L.7hxrH526fxk0cOoTDYJuboQdWx
 BgsX1Q27cNcCUWL2Q8NPd1Of7uRPfHApho_JrzJwjPCp.GKWnR89.UhlZKab06cVItIHvq.bv2Em
 P4zazS_Om1FcK11JrLzYp1pUUVWdp3Zw75TSTBhEL_nxpaGDZj1BMHHCIs.EuIdPmI_.uRsB8bHF
 zXmRaKLmHgx8PAQceFx9QUSUvsTOxZKLbzRERmNzIs0i79nvw5W2LpTyCjcqDp0S4Pwkrq3ggjN3
 w2SAFysSsHjhn7hjDUzZ2stBL8P59dQkBqF_lOht0IJp2JHOqkXLkCEtNd04UpI.C.NWlMHjDBX5
 lzvqAkkG_5bMq5oK0k0V8yF9ssl645sSB4X1d0drgWKFZn7s8rE2aqLRFKlXL7NKrWN5Owku1xIM
 wOWBhYhc1s_g0CNvAlzOfol2abiE8BKfL5a4dquM08TRMx01CKl_P5XFU3ivWo3eWoe8S_cUxnuS
 VuLRmKjlKkuGPhK5gZhasnsqE_IKJiCAd4dUr2LQPrtIL5nHEpWR.DenrTXTDkYgj00z60LGpeB6
 cK9wigPbLjOM8Eu5O0cP.P_lG_oITY8u8mR7nMdhDj9im7J_rRzsOXnZP6FUu0xeW4xE2TVKEjeB
 epdnYT3tnzEQxnd.8CmSI7wBlxNQmGR7EEplL_DvmQVc39rg_EnHkiGOTIUoIvzbwYfW8GYRMXXP
 SeQDcS6E70kJnmcUAmuujvQt0UHyi1I73I7E9I8EbD5fi0sx0x.0uvZ0I.9O0P_sejGFEDMiSK7n
 Z5VOf6z3XnRDayIZxmOeyR.pipDqeyuB2nkexrsPiz1ruNSEnodel8zPyPtqSMcaOWA2O5.hZCa0
 .9UbS6VVZ21GE7MG8vKDapfQ0Snobv00Ct3j9hgwaY6ng6O8Dyp8vgrTL8wULojQiRPG.RADyvno
 UXMUytfBWKSMuTIbvMbHAu7bCwjv.qAh1pD2HQ.JTfURoHyfwqDgpPlwyzTQCjKUmN1CjtbDEwGF
 PW9xg3a9aEBWNKk0oS5Xf7PKK3TxPg05R8fs94NwU7HmimobszDFS5VgzkeiQ5QwngAHhLX6jQJ9
 Vb0YVOvCbsbGbbPR_J.Q1O9.9ehIO6JU6BwkCcEGRPQxmDzm.jHnDJ5Yh2oy8X0k4P_6sqFZjfLp
 SITfS99yJJiphZUvnjtoV6Mlrxmk.8qTcO84Ax3SBtDeG4MS.lthK9m3Cu1Rw7yfspqiOj5mlJyP
 xFJG1VoHpx_eRWpcKgY3vFWkDKfyL2Sg80HLHWpnoQJKGv9O3i75wAIhhcQv5xT3LtI5J1MJ9soX
 FeG0_JrbwOVk2AEWWfiuk68V6ET.69DWkocQhYoC7PBJUrliukP624moXnowIWM2kM7mfxTz65XA
 tVrIAWnf23PtBXPx6OgsefxqLN_ZtwQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 32c05da9-b477-41b8-935e-97f829c9bca1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:31:05 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f41d5d0227d5bac936de484a6531ff5;
          Fri, 15 Dec 2023 22:31:02 +0000 (UTC)
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
	mic@digikod.net,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v39 19/42] LSM: Use lsmcontext in security_inode_getsecctx
Date: Fri, 15 Dec 2023 14:16:13 -0800
Message-ID: <20231215221636.105680-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_inode_getsecctx() interface to fill
a lsmcontext structure instead of data and length pointers.
This provides the information about which LSM created the
context so that security_release_secctx() can use the
correct hook.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
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
index 9cade754356a..d81a32c5929c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2805,11 +2805,11 @@ static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqst
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    const struct lsmcontext *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2819,13 +2819,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
+			    struct lsmcontext *context)
 { return 0; }
 #endif
 
@@ -2908,8 +2908,7 @@ struct nfsd4_fattr_args {
 	struct nfs4_acl		*acl;
 	u64			size;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	void			*context;
-	int			contextlen;
+	struct lsmcontext	context;
 #endif
 	u32			rdattr_err;
 	bool			contextsupport;
@@ -3364,8 +3363,7 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_security_label(xdr, args->rqstp,
-					   args->context, args->contextlen);
+	return nfsd4_encode_security_label(xdr, args->rqstp, &args->context);
 }
 #endif
 
@@ -3587,12 +3585,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.contextsupport = false;
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	args.context = NULL;
 	if ((u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
 	     u.attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&args.context, &args.contextlen);
+						       &args.context);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
@@ -3627,12 +3624,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (args.context) {
-		struct lsmcontext scaff; /* scaffolding */
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
index 339a4559daf8..f2bbce7fb28e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -281,8 +281,8 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsmcontext *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
-	 u32 *ctxlen)
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode,
+	 struct lsmcontext *cp)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 2a0615a62125..dbbfbcfbb299 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -569,7 +569,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
@@ -1520,7 +1520,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index e070a6cd4089..e1487979603e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4317,17 +4317,17 @@ EXPORT_SYMBOL(security_inode_setsecctx);
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
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	memset(cp, 0, sizeof(*cp));
+	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d138aa692abd..1e97b703f252 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6654,14 +6654,16 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0);
 }
 
-static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int selinux_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
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
index 1fdd4233a9b3..a58e2c14f120 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4895,12 +4895,13 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 				     ctx, ctxlen, 0);
 }
 
-static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int smack_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
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
2.41.0


