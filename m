Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8004D561A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344590AbiCJX4C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Mar 2022 18:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345021AbiCJX4B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Mar 2022 18:56:01 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD319F443
        for <linux-nfs@vger.kernel.org>; Thu, 10 Mar 2022 15:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956492; bh=C3V8aXlfNRwUKUxTH37n2MPW6TsksKc2X8ONpGDE+4I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=G2O9gybgWL9Ysj7GFXwfEWnJRMYEJ8DxTJyygdjr3I9efA2s00bw17YAuXm3xV/4utifKAI0Jeo4soK3DEeFo4ErsztJKHrB2eDplBNy+2SMuJPGdNZApCFYLWN7g1GkCGh/5tVNAy9+V5pBjUnQ1EoxRSBSmULJ4wd+9DFJjZASzRzDj+UO4M/RazRkmwQdEq/ABFI5oQ/WN+Nz9wfTUWrmJuggOS1PYQpzYwRf/cmYgQvjOS51RYE8HfbsSvVRTr1hsRavcoUm72kDsa6QrtXqR14G8fo18EoTZJejWPqbQLLWHCvsuERBfsZ82WWGpCiI8krxFUwVr9OxLxVbYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956492; bh=3vip0HdfIWshHXaepKYG7HLgUUcQ8kt9xnmoOXdKMXu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CEzZ2SxwNel+GpBQos8bfIElP//pUqC7fI6iEkr0ZIjHr4j/3Dq41p4ml+U5m+f3BoDIh6jnICinDwvOtRyh9nMjXmt2fvrgdm/K5XWEVEn1qgu1wJY9v88DhL5hEuTMOpCJKBGlcmGk4Fn2J4zWNqwSnB8ttWv6kWYx4X/9ZR5CBB9s/LVr4g+1syafvYw0P/vXA8BFNHJMsZealzJfLZRNURLtYK51SvzXL+7psqOP/nC16GMg7tQ70HO6boK4cN0SpcRSEABctWzW56qkz2kueGBgM3NuzCf1EyTWIDpeVW4XK3grZmiFuYUpOP9io96YJjrJMoOA52Jc3P6NvQ==
X-YMail-OSG: Y2vpp38VM1n3lzNPGaC4HipnQdb8hGW4phksNCCcETNdGBGEAAk6glNUy2.xPpl
 87ga.DDWl.2EUE9jrJ6H3ScVweaswVAYSWYSfsD6nSIKP9u3jt9dVdC3KXYFrMG87J5Lpemd68DV
 qJz77hP.WupFCc7eDNHJ0TDrerMKGJPyen1yq1.tr.SiaJ6FEUMvkwK0BhvrH0bgRDK9VoIgLPdY
 ztNKgrkZ7MmEgKBXsBEXvApdLC20agg0SiSi1MZPPf9Xo9arsh2jhiZ.2bCjZhCtA8QnpRfu0oou
 d8Ak7wy3qMktVF9tqM16ZYEDEBsrw9sJO3dwHqYluEO.YTDzWSNSWtB5DKf_6wp0QJlO2ZSMM8c6
 bYty2xzID6Z2lFOp9k4qmvFlaA8wqB6juiY_kDrJLk3vBz1IBboKJgO3kDuftjG3O_KX0TGG1H85
 Gl7yilzgoK9YIoEF_Oprge3jvGMqvwehUkVPqv_jNRneMkm1FFjupvruX4J00LcbzNfWb2OQSpGz
 3jNhx3JBsLJhg82Xg.inpV9bUmYi8cjmDku9x58wpZh9AmlhuhB_FqUoj2sAeJROhyo1pgGytQNw
 3aUb3MdcvUsF1Vy19K3tK02VjBnlOzpt51rLs8shbr5myBY.oWiVCjAOHnTTFS31UBGtuDA0OCNT
 cF2sEPK9kx.pae1tFkIc4qigGtHbH_3fvrQodQR4I62rUrxXDk3CmfglQrvKvu2BhwSg_tWM7cZA
 jDfMNg.HXjDVt9uVSUK.8stsaZ4Pg9NzdWxFk7DdZiTrnxP29sf6WI3PR5sCC391nHXltRQ7mV8V
 jFOezQi2mhSvRZpvGzIktfWuHQLc8_Jyqp9dPfPSAREug7WIK4_aPCfMkYUGiI1OplT3dDU2OzJW
 P4xo4p3vkeRCdX6GEoUfo5pF6tUfJdz.5Y_i8UoPfjO6kM0Dq_6EHjtWwhXydabIaOWGeHRWTfJU
 HXivTapR0BZYV.bype2LQgloFNdma9GalqLJtsA2ZWoPYV1Tq1Hd6Ix6vuAS.dyTfQfrAgBX4v77
 UOgYByoLPWIKlhpqfcZXEfDeueXH6H08CEDjwtUF2OiJaPkDmY5CLDWyvgOE0U.D.OwIUwMmaX8U
 QCPJDXKZaSgtd5T1to6dQ8fUOElDigx5M8doRqvokcbMmBB1X1kukvjh95vd_LXXMYe14VkzDvbp
 D_KWouag8_D51Ac9ExQCD8aGIHLSP6uxbsG53PzeI6rauUS9JXI5uYbd9dAPGC9NZLTfT7H3FwjV
 sSHQ9cdoJhVl0uTQVyeNqOmLb6XFFFFXgCNuomk_.BKqGKfsCYzTdzpuviVsdhDGR3kLI8ssZjS3
 vZzxdUhEYc5q2DQWG.fjJRw51SxJXxDhxnvrQKM9GYEyUqXlaBUANHxGaF2vmzVSPMQeqC891qkP
 olivykJaTCQHjei3uf5gXw6DmLMg3tQNi3_gDJ1V8jqntApUbGSBosfwtErlun4r.J5zob1amKf4
 IIX7enudLMtadwL6Brv.Xf7dD.44N5QtTICm4JVRg.wwRpvXZKskQ3DLUV6f0R0dfKJgRv4WFz0w
 y3cehzssv0kz8X0H_ATVwJMFd5GZJsi5qR4FrW5f0_ApC33rYfz0O2pBbdZI2ACaHWCgvjpei40b
 Mou.i6Yz8ezANKIxg3CsjBfTePcFLafjEMYhXv4c.jC_yaOvt0eHlIEswhSRw_lJ3oJ_L8Hik0ql
 OSlm5i7c8VzpF1mvjmmP1CnKbO6g10LZ.EseExqB77oU0RRL7yUaxNH97XeRM0eOLTUFfIdXgZFE
 h7b5NlzkPaG0r98Wi.ds8qvTDIrSENLU0ob_JkFgEC7JHI2.KlBLV0y5a_5Pi1tCAI1PFjm9MIY6
 zqHiN8QizjmCVqoAKLzR5IVVEeejpjKpr1bhrZ_hkXw0PKzNnTB.KUMP7bgVYuE5l0Y1KvfC775j
 .y8esdEnhJJ0qLr5KU2vOz01PkE3zqj2tWPoKulci5VaYAF0m9yfDGxMQNsJ9VBHfOeo_MOBbbl9
 xmbK0TuQm8N4mOWGfYskbEmAzWu7YZUlvmPcmSrRjRdtgZtaiw392XAiFqcafK.2t9HYekDOJ7oP
 ndWPXmyYXITOrAGFLmaNgX4SKxFcoPJ9OJyhnYgkMoojDma5R6MgRnnupd2utjn58rEVQ.PzqS6f
 lnk44dinQ_ZQgjLcI.BM_rM20XfCDKzH6ERhbr7lpeJ7cDN1pBmoj1LyBpg3GKfomsHaCqbFqJZf
 xkI0wdAbJwBhXuynAQ6MdT1saekpvEqdaPaRIh62l8tkEt5i55y.L
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:54:52 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8cf1c259c50308b34237c785a039407c;
          Thu, 10 Mar 2022 23:54:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v33 17/29] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu, 10 Mar 2022 15:46:20 -0800
Message-Id: <20220310234632.16194-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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
index 1bb26971f825..65db769a8584 100644
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

