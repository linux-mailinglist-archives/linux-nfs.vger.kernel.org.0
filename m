Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7C4F8A0A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 00:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiDGVd0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiDGVdE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 17:33:04 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDECDCAB3
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367060; bh=gNdjBc24xDqZgOxdQ7npdvwhFNCq7/GRKYiJAZ+Tksg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jGSjPg9wRxSitOcWw7AlB0SBkmtNFfz2J9g+GM84lCqgC/qWBnFLG9VZKniVRM6bXv9CXS7EAUrcIZwtNXO3ysyApG1NmXm1521NxlxsNiDWKG8G+aWktPLJD6k2ruDKPWpkpj+UMmTgwL75De7tatI/adqtu6daWh6Iif9mioagdZdGEfKBknuW3wQvlPRFx37xkJGdP1YinY+L1y5/5YRt3ZxtWME34OgU1132rv2jJp4JVMQZP1KbKCk/IWQnlNF3EHQWkyrnElKYKI7EoYHy3b3Q8/OXv56diqoFzFUP4DaI5Ju7FGkySk3FgRtEVMPr4ZgMCRMGnWJSBuqGtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367060; bh=zlWDj+2r0MerznCgPwMwY1DK8855d2UnDD7qH8V4rIG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UAVcYsaBq6je7kQ7AMAuLhKRRXG40IKiDoyBRlq+CocRknRLy+22hymTvOrYjFyPpBYHUGv3yfbxCtx8veIRaOoPaZ4+vIIbdAz4lqHG7aPWfBQA3/oP5CQFKD2MOLVcWkX8EwoJmQ5L9tdw5zE4XiqOiqbR35K2+VHJLjJXiFV12xg3NlHPXnVU6Ag5uZvT8o0mjGUPCubtgQ4A1RIC/DVlViB7eRMmOEJLOjO1yi/GjBAA2sWDIdjJ7WXlSqklcFCAU79qUJGE7t/tSLWZVu4fvYLO4TlDj9cJrRQv+kMC2PhaXivowSg4F2zZ+ca96eZJo0XzjBmutDGdggo8SQ==
X-YMail-OSG: CS86PWgVM1mw9FnzO2_f.JDji91TA2FpNeioD67ne7bHGP.1Cv9g1sVIp9e9Es8
 k8OTUxjN7ewjEhsO9nAIHy21e0MutUemKhVD0ksR.4nu2f0QSxdbegioHIe2wW.eFWUwcMMYipRO
 Ps1Bp00qSKBnbRZtZiKsRK0AIU194gK4sWTSSy8PRqi1NwV4dbAKUrgWzoE0m0CnQiUSTRqhdEmT
 WKJdjJojJHVo2GyxN.58fiXl15Gf9uht3TzxNK3OXVcCZIKC_Ibiu.3wJ59T8EW8SOuNDSEvteww
 HHkBi5vDyjYW6ECumyp34YgmkXrA0jUzBgK.ii6Hg3gqWfk_uJP6zpObgZjt3MS_oqw_b3wFrOMt
 leNugzLYBoZidCO3ozxnzc1cSQn29Q5n50AcBVORbxZj4ZO_yZ2wKqbxarTRHkDotmOWok9FbEyx
 QvDA76ml4T5TbC_u2lWHOs8HAIBrJsSL8z1J2Gq5V2tEUdkAYUo.a5bCTv8H.xPEYla0XIYih5KC
 vZOTtEBQUQLM4j5YpdYehueA7uwlXFBaObPzZoYsnO1k8Xcuh.fXyikKvHwIpgmEViHX859in.yT
 OTAXcNNY9.VIJeXGRR5T17l04yHH9FM3i6ejieYMRG5s6Fftg_eio_QOyn3Rdq8.IM4QarJlxD9F
 _FCp05RI7ZnUWG7tW0XKfHGqIan3OotxIKA5NfWEKB4J2nfcZcXzIDC2MCXrKudslVY90wQmUEzH
 8HasAiAxYsOMteeheNV7JqPG_jr2cIQ3nFhDRHY7DyFQGTgFzu8kQdFHJ0zbNjwU1E.zN_yI6vWY
 OsBy3j2WngzK72mV_NbJb7KPYTMnrJvejmMxBj0VTBkUt4ikIGLCWwEkMEDUn1iHwA5yrAEsootH
 F_bDFCHc6WoWji9nqlY7IH4xtO.B3O.GQgTk7fTW4TEzGA12g5fYF0BIQ6h1Jd._qippkTg3NnFG
 MGhlPMAY2c54tMv8xvbQiXxrnrgzqjogqGYFOvAy_dtl6scrTJve3xVBCx82fHlx9mz3HD4pJI6w
 .GDaqrx0MLnEp.ZXBuLpaVK2J34sS5cfF6CtL3ssNAMeXruci4v9h15PoHJ.zaqGrgnVbVNhPhKA
 4.A7wNkJn8072krqqePSHdMaGPGJFXVLhH0STe0iry0vKDPoZfvLyuJuCeqYvmqogYMt29OjYlCK
 L3r03mMdI_zFo0VdKaq.fxay2f53HItCfsOCKvZt6OcYNec_6Pak2ozp35D3E2teehJv1kT3LvQJ
 iLH0XHI26MncAcEPfJSL6t_btksYCVkZEo5mSG6ZuoAAJPktjmkuKI1PfBcI1flCLV2LziDBZqGq
 OWYJgQdum2fcHAhHaJuphh.fiwl2rSURUZtKEkH43DdxdmFdlFR42Es2p9KhZ0v2b.RK_ZV4cm.F
 NIbYmzaIsHyrqVaQPkgt6ZfAQV7lY4fP34HED_O8beVZnauQb6lwEkgDJwzD7V.Nm.FoABoSsA44
 dymPhG5w0sh4JGPLcNlUTYy2n9Rz8ZCXBN7xTjIuqCQMMEFA3xgl1xbqg0.7QMB2M5OlYTYyTlxu
 yG2GhmPmly8QzHCPc43OW.Z0E4KhrwtSh87bOfGxO5cQ3LCLrA.VYCP28CsKPtOkNL0lLMuXsyQ1
 Qi4vQyFSlk5qYcXhEyy6MTNRPCPjF73vEpqXmdA3.S4g_hlQaJ2tKXyJv_glQrh9X3QNAy5W8YSU
 cZJAn815OEp_he66VZYY4qRaeTD_FOLjOrsqrDIBHhDw6ajSCdWtMIx0CYEbJXk.zkTzjHCGwJoJ
 qEeetHqoxoakCNVrxhGvPkv9cJeUYcaiJhCw5DXiFpbdw4RM.6v9T6w_gIVcPHy9DuQiEdWWPG8d
 nrTFEvd3jbtmF5qZg0Iw.GPi0trl987KJjIPszTTIr29w19v55SoZsZfK0.82z3mDQ4a0lggQe4m
 0sAe8UaCTO1YJsWag8a_9WX1Luex.b9YWrNaD9GWzDtCYSCLtV2uybav56iZnx3CbFoTsTVY75fc
 PFdaiTWAtLx3rSPO16XuqxxtqTv_vmY4iKSDKDHsc9Xq.5wBm07axJymJBN5QsJB7lifP9xJmYSl
 nDr82oD8.6UTWS7NGhBci6X3usnt2ldUyhBgGHAWeaYZqN7I6wwOW6110mLkXhTUq38YIByQMei4
 xa2jlsqig1LM.o3HkP02rRhw1w8SSW_J1pMdG3VGjniN2ms2zjaUEz7DnGEnjw3S41nQR3PkqVYE
 3TdZvwwEQ9tIxh6yJt1akV8shOOIV5BdcXqTKXTWmnFqPM7ChrOezyrBoyUsljTbg8LrRjx8Bb8J
 ubyfwjZ4ujQZNng.f2Nxs9yompO9P6w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:31:00 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c3ff6cebaa6b68d3aee0bdab632d6ae4;
          Thu, 07 Apr 2022 21:30:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v34 17/29] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu,  7 Apr 2022 14:22:18 -0700
Message-Id: <20220407212230.12893-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 77388b5ece56..b1505fbfb2e9 100644
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
index 9a6a53f7d8d8..9933a6e28ad2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -604,7 +604,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1479,7 +1479,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 50bdb6cd61f6..02b931df277a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2434,9 +2434,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

