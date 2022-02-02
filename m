Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067654A7C80
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 01:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbiBCANN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 19:13:13 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:41107
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348372AbiBCANJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 19:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847188; bh=mhX/VBeW0lVGdMxFK2mQQuDfWQxxDoChypEujsb8qRw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=feNXvHdiYkhkplp3/Gw+eQZATI084WCoOfRBoUZEdvZwdPaCMmpXk3ceAge8BdDX4mfppPzltp9bi52jY0TFhwt4cl7rfSNVKzX5egiejx1jMbSGXSYb4QpbiN1ZsK/vibPbhyPYhJfZuN9KHpS+NVISBPT/xNdJ8zu32mwhf91WDJSUcTP2pfd3tcX2BxV8HUvqqUzPbBgAGKbDkAyhdZNouFKlHaIeChOJk4DZpgo0SpQl3b8S3AlIhZ68BCL70qnkTyqDB592hN1iumvvnfg25c5cm+UiuPpZ5f4DNTWpBngCWUpKEpgwVZ1AMYnb1GmNDzkD53SbBSx/q0mTCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847188; bh=r9SzrBljv72NJrqBADS7VSqK3WhopGtY2ltSCGBMb31=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Za4WC27T69ox4znVlAOM8cKtrbyuN719f8UGrjKZIeXPvVBNWp9DsWsTQEGScsTGaCLErJlU6V9+j3Ph8XxcK2ZOO9Ao8jadu7WcxEsoUS03NIyiglqSp4R5+0S1c4f8aRP2LTkO65iakhlHh7kHmvSToOGG8hpl7bNafYxdWv/OahIFWmwxCEm0pRYrnVDUgj2dzjtH8pKxN5lPrLCgKsif7kfuLLx70YjoSMiP+dNWXk1RlzE0dOp5s2KAcIfYBTywJam2hjd3FuOIfDc3zc1K+sF+9JK7bErjv8teXxf2V/xSfL33x3aw6boF7XYKC4vnofgCUKbwvjqA/f2jaA==
X-YMail-OSG: j233Q3IVM1lBunzWVszbLWqiiveKFLN5.xMfOLuOWlGuVTNyuDujHlVU7BCUPF4
 I_INXX3Ec1YarRHvfwsz1OLQs8GNG7M.x2HSJM.oDiauU7WmubKBItuNrbmt68ZaMcqsDWObiS12
 4kAzb_JC2wxMkW1FKY_fW7uW2gClSWvrBh6Tv.P0Y4sGj6_dJs3ZLEF0X2rK8NIvBCFN_ON1C8LX
 mIaXywvNVbPUoZuNbCrLvIn0r.m0VjLOUeLejCmW940S1KAmD34fb92qXAMu4M_xKaLbbdIKWMAd
 KOx9iIdV2yZGDze6LMHmQTJadN5lV8DnHMFCZocK82AhB.7mfOnOycSwx1xsnBE41awk79OpapzQ
 rOLFmgvtHxLeJN1td2gq62n_quq3wNTln5TmC79H3gRAV6ihT7x4BlXWz0JMX90V4VU.116Tz7Gy
 cbZAu5ogA.TMH93HJQNmeAVx8dhp201V5RWxUQNCNkzwe.16klKn2ARdZ7NYZb6hwM2G_AiRp269
 K6uWYx3.9SZySL2Pkdy5_1IlR0kKjft1llXljqfdLgupsg2eioxeKR1iX4qpp8al9yo.3_Mn.BoE
 fhpwXay9zqdCv7efQ._diUSMNDSvvGhjr4GTuAXew_7bxwA7jEQCw.HXiV0EsQ6AhivqGh6qu_Ef
 v_mBocGYwtFh6sCHZGbnWbCE5NnwZRtgKYq_bA8Pcu.3bs00OIx9J1KM3LLN7fulGeSKcTER6aG6
 BQPwp0.ZjP79FVM0TIfMANbCcFqM4JJnaBasDxuuUQDdGCq394OmRdrwWbEiAPhiA0SFG6yzRwuz
 9w85ZN3G2o.07I0GkqF_Lprp7m0IRTnLFQWtBRRTWyxz2Iqs_yAATtRBknZxN45f4VnBNw3TIcAF
 n0vZIKu.nIbvjsbVcO7fV2qleKUYCt1fKa37p.UvH_bLp_fiEvSN_q4aTwiA4p2mIx1TCuMSLqH1
 Cv2yeZ_UMuPy0ZgHKEYu9_GvUyPjaKzMcYLUAV9tac2uYMQFKNxo9tbwoI0OLL4f3RvhUIOqk7bf
 5vxRbCi69s4io2dE6aS2GFAW3I34RignBPTesRsZhWb2KhPurmUZYFACwoMCtP4Bz.9gcNLkYYTe
 BzZWfY_qXOmazarHAQ3o9vnGVq4Co10qhIlu0fFzhfLzDxmXnE7kG_yYKQh__yNxyaQ9Sso1we6n
 GgNHRuLKTm.BX7UHeAfF5Ddp39tlX12kgC0q7lSgfrzuWQ6SF9mQY6hqTO.y0df706zQD95z2u56
 1RNvppIt0LBlz.YNbKHKCPU0ST6zYk9mHXU8Du5Sju8I0yWaA2dibH5slGmSqy1u1waVOfhpivDR
 EQHnQ9MLnp2aBIys44zP9giM_dbbw12Y09a564z4dzZBpTZEmSHsCmUdfqJFbXDFs7RSCyrvhadT
 WnXS4woug.bOf63zyiHeLAjUgh9plIhKJbdihUKgVMy9kZq.h5ppW7uCHnTFjohYBEDnNCDHoLpU
 Cdzgw2x1FrXdsW_V79iWFH4pCmNUZ8ZbHxcvGgEdPgiei5Mo2pALyuVzeWpbE5bvI.1BGt94MKpY
 jqhjMiEFDRnb6NVyBsq5OUVQa12e2MsFARcK9zFclwV0aThYj2DKUhyUZ72e2uHjYK6QOfu7jaL9
 SkX8HI5AbFrgSToR36V4eKpTh7j7mBc4khtYaTMDbYRXBh_lhNKiFTDMOPOu255S.jt2hmlSbiUz
 1EGCJXVzy0C2kghR55j3q6b_IlY_8VZ1r8.4L4Khk0RJE1wulfDz0wTuuSsGtUbQMKgpEm8Nia6g
 0I4kB.8WxYV9w8YKDvM8lSQO66JH6icVMDV9FXLQM72iIKe2wYrvLCwqG0enSb7oUKTYwrGH1tqB
 0WwQZ.BkovEMctxaMLGszdeSwOcwi.061ymQ67rrCTNla_ESWCaUOeyaZHaTBxcJSXOGRDw8KNut
 e6BTp5nJ9M86Ng8QS4KGwS_wa.ECbeH7NPjpPKYEXu0VaVxsJk1ImI0I7f.a0jnS5OUtiTFtw6xY
 n74KFvgHqFlKSONWNPY28n9JSvxh3CC6EidZuIqILD2LLrThV_2Phpxz6Zrn3.1cgocBTXlqUIYY
 X5LIC2P7PBPM6kmaimpZy6spGhNj8kLsXGbGGtRw6T8A8GY8tqrlhOorlL655Sdqj_BqcjL7Maii
 dYTpHB9bjjlOOg.esSn3g5baGoOKPK7l2Y09f5snqH9.TvlbLXxzlggTQIZ8mYW963g0KXjcX8.t
 BfEK2FTGarmwggL95.LXHE3WUEkBdU_gPcGRz0dMTTNrOoItfpUA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:13:08 +0000
Received: by kubenode539.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b85f0384c0ae4c0e2c35d3e6082c3b09;
          Thu, 03 Feb 2022 00:13:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v32 17/28] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed,  2 Feb 2022 15:53:12 -0800
Message-Id: <20220202235323.23929-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fedc4b0292d6..4b77e6a13e78 100644
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
@@ -2890,7 +2888,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3310,8 +3308,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3332,10 +3329,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index 79554e5adb4c..e2939418789f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -603,7 +603,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1478,7 +1478,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index d56fcb794ff4..c9459c4754f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2421,9 +2421,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.31.1

