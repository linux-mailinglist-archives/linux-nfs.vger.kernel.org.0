Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C3545819
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jun 2022 01:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbiFIXKk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbiFIXKM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 19:10:12 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245514CA1C
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816209; bh=1sa/5A+Ae4N8zEc0Y+g5juYXI7isDX/sSeDwjxeV7Ro=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DtqWZx/bz9+OxSbt9LDEjGOdlCTpD4f2KbT44fQILbCSjv1xZCdZ9TBPyZCwi+2QYs8kyv7ZUxeBCgjLJ0qq9wgvKkU4I1Gf+zw31yTN1fafawMIO6sly88kGfANHMRN31f+DTI2BUPIZxRHlVBxT79vHiOtxQS5629ezkoEaEtUU8DxdpmIsTVvVORwwL5XcYxWVtW3APmXCYrFsy/DJy4WvVK2BjycrMJKtZDMIFOU2d5hW9vXqfIVyoVQZCVtwqyIjCTyLMM87l/aEmYO2TF7Tdcb9W8+ZE6MlqjNmPC15S2OnB1c2lbD+4o6IEoxfD+krSyUw82Z//7t95sYtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816209; bh=/JWGACxGT+O+s/CkYDF8pdUyeg/aeJW+K0IbbQaQYk7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VGOgGMo43IbYbjJDLxP05KOHxzrevIne0CiHCq4rZpAWbOLxdFcdgy5L/WX2sLvaHNvfGi5E+zGW7+xdP1we9gOfJOOdkUmBNVMvh+10oK9aMNBv9joYrZJg9PlLazKib2uOK5yOtjGCWvgJbaPE9jr2yygxXLHVTsnzwHLdKfmF1+iIrWhydxbSXo9DNbIkZEz1qmil/8xWHudQqLuEgu7czKLiAdRlP9k+80DlwO5buyq0rcyNp0enh9OnxefI7lOrcp9OuoFymg32zOz0cTQC5/KBXaQ/dzkPqPCRxvfY08xr0xSGLy9Yntq8z8K1wN2mTsKf94xHmoT0ZFrHog==
X-YMail-OSG: 6aWar8sVM1lQAYwyOBp3.GEccSMJJ1qWvl5zIOwK8SQ_jLhLQKco64MGT2tIWoc
 3v72TnmTZTS5edfst.2IRQa_ndeOgKzvs09dXT2Ez4X6Y6gxW00JHtOpc5HWwb40tcQ9TUGWX9Dr
 v1MX.ADcOybZfxLq5bslYCHvZwAg5_EMqn0BVqc3BK5.2.hSLCxEZBhHRlKOmVSyXqGdW3elvfLE
 IzQYG6obvZtOnwm4Cuq2Gm4IxzWJ97vyGx.IATmY1I1P8WfaivGvXkoru7n7cehpcj_qw9_WQdyX
 Rhei7wK59m9X0cDaC_jcQFr7ZREHSmvfHR_Jx1SfjHYwX7nqjtMoVh9VlV0o5QHiKax_ZMLwcEG2
 jWG9k0aDvig_CXtA6VMBgJyGlrXBlW185B.BbMmti9m5r6nEec3aRlfn4TxQSMJ53EcAMS1_6APn
 S6TB5yjcH3CGCYnOxm9Z1ZIyVq.Mp8Ta_oFuUDn5jATKO4S_7kR2g6RfYEPtgGo5VpxV9IJtjka7
 PvwzV6xqE7xVjczDu3ZBsLS.z6dKWFCdPWtv_MUQq3zmR6tyYfVuDcvip1SzmmaCL.RAx7jY2TFa
 EnBJ0m1ThNdxu1nPAOoqmDCjLAE_MVpn2FLQVIy0a74PRQvQ229BIHaZl9ejrBaHOBwpbcp8GDOO
 18cd.EjnOXWNIl1YqHEyURUGV9gm5FUIjbPFW8Mz3HX29pgKpavNd4vKs5vweCQJX7KfST5WnfNg
 xN_bM8G4rCLaDPbiJSCPG8YSUM4sIcvvVGnC1kkg3HHTNgcHMZ.X6sElg7hhz1Io6TwA3a3S09QR
 AsuYTLA77n1PgVpB4PdKq1Djve8ptCZs4n33EYjqZTs0ncuH3WWfcPJvFcBbdXQBDGRZ0nu_79Eb
 wLaHxsAxkWz5RxGkBTHTwAX8BsDmQCGtupKkF0SVbk9sSt1a0H5Vac4sgOV5KD.82FO7dfZ8PcoI
 HKFd5Hi8YrBXv8H8oK9z5xkP5Ha_WItO7v.mJZcvSquyBJX.1dUXluRlGaVk8s.Vj5v8CH2cl1xF
 iGmfvF0d.kuihAEZFQ01O.SOOvgCeU.B49UAfebpvlvfTKjwTw6xPAJc4uqjvyTaf4lwm.hbtqvb
 gkLto8XCiJiPj6yUXHm9.igOq9ml5BxNqb2ecunUipzBjKpBKizEgyUSDiW5MRAdGNO3.y0wBbHC
 GC9sdOhK7D0rGivmdHLEuB6lDvoE.PQT4xnVa7AHH.8.lAti3IzMIbzxdLL4SrmL1joNu68PCOBh
 1FGOXeUJQVKr0i0cKHl5oDdEe5RRzOllsLZf_hl_5z27XK5hMi3_lbJtumrlA1EnUb57L5Rvx1ai
 dLO2KMc.YMpnLhoB79Z8n3.5GTPrnYLCbXWsegyLfQkWdOZ3edkVOMbOyhKtUaGZjj_q7QgrTsq9
 1kDdfaLUAHxTeRYotgW7uoZWGK7Nex28Wfq6Z4HhCutPNS2NPJ7U9.If7T41HSfk1l1a3frcbKqC
 Kz7W06YK1svOgMmN0SX31p39C8fW3mikzwmuGnIxV4curpmBQFguRArrelLWCu4HAe7WA1xmAs88
 W.wgAufAxGdO_oc6pkhlsNubBkLNuAcgNvL6a..bRzguBxt1Ed.dgQHxxbvpRp_cGtVA4uigUBrU
 OdjCJq28OtNBFOAj.ktlDpK8O.Dx_03InOnWmyEJgcUxHQscietlmZAY4etMOiv9eNp2CURNHpUy
 wmFfe._5J3n6SJb1XzjicHaot5R6uPwkmuPWV076XYEj33DW5f0bv5JX6mgQoti_CsqELHkTJIkK
 AMX2uubgg.Y8qMMSiArmKK.TT7BywqTcAiQzgz1PyUCYmsUEsZl7G7cruBOhTdD_hnXfS.kY1K2s
 kJZV0q49vWsNeh2kvpN8LVd8FNT7ggSlXgKE__XekNKl7D_3gyUcBQMuQaUFRViOoOLKsFdFDskI
 oWJW1GDhS_TP9LXjcqTy1dR.npdqaLI39_oqho0ECFoxPOWkbtzDFSsWloQZAx5kwF2HtxJJN3K9
 YfO7tlB4UnicqYwy4s19Sbggn5o7dPYPLvS.aSsO9xtc4JwjDA3JX6P34pNFyU2AOgFd.1pBub.Y
 id3ARo1styJcJj3P_lu6PmAvM1jSNnGnprDV7quWs4kwrFrhOWGOzdSE3iONvzXWPwnQL3MXmbJ9
 gZCCY87qTbfulGAboXQQK37LOwqNB8wg4yCLe9GS2CtH8QLk4h_89wEoNeiVsgp6JbcsEm7gAPdZ
 ufWZxWO2CS37iqDCGXGJNMZoPBvJNLsXvq2s17IvDnILz0HtvtIVjGpn18_ZUtL3fhVh.ns1Gmpb
 7jayWtb3F8IGOC2TfQvP0qNOnxCUKhWFNsnh2cdefonaA18e1ZdUZiWfEVQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:10:09 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7z8w4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 62296d5a5fc11a6b88291aff65d8e04f;
          Thu, 09 Jun 2022 23:10:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v36 17/33] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu,  9 Jun 2022 16:01:30 -0700
Message-Id: <20220609230146.319210-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 512ad208d62a..3e42738df71a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2713,11 +2713,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2727,13 +2727,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2830,9 +2830,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	int err;
 	struct nfs4_acl *acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-	void *context = NULL;
-	int contextlen;
+	struct lsmcontext context = { };
 #endif
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -2893,7 +2891,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3320,8 +3318,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3342,10 +3339,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context) {
-		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
-		security_release_secctx(&scaff);
-	}
+	if (context.context)
+		security_release_secctx(&context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 5afd0148a1a5..ca2ed1909608 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -624,7 +624,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1500,7 +1500,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index b52c7c55a092..72df3d0cd233 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2428,9 +2428,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	memset(cp, 0, sizeof(*cp));
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
+						&cp->len);
+	}
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.35.1

