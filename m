Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032FA5030DE
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Apr 2022 01:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355014AbiDOVaM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Apr 2022 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355123AbiDOV3w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Apr 2022 17:29:52 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72CE29E7
        for <linux-nfs@vger.kernel.org>; Fri, 15 Apr 2022 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057990; bh=gNdjBc24xDqZgOxdQ7npdvwhFNCq7/GRKYiJAZ+Tksg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Y83C/0ITuXGQfhT23q8pf2Df/qlj+knwBhAs5K0rhQMEU9Co/pPSo84OGTgPFhPBkwn/TP79zxqnX1FnQqeY/wjmeY7U5d9Ydkzrhmpxz2hFJV1bHHymduwWfgOkH1xm5yAYN44lEU404syjGyVLdCiYn8IbemFVacD6QyMhFG5GUQNxAZHLdmwjyoQz5nyCWgZUn/Fe9Dx5smEX4KQjkCcyx22Z/IMCmit0Bu94FksfsLIm6O/SRfClkeNc9AYwlQF/q9il182uPalnhAjjOTcUKCyBUNHWWCVL7Z1DcSo4Iq4psUr8ePqx+hV8RXrNXJPl3Tr+y/ngkDOfBMPf6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057990; bh=pJacvqWXPk8iFnG9ooP2mNLO1xAoc5tWEEtuqNkcVkq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fegvoG9avFbpL3SoafYyWZ2qt5iLEbyEjsRpjyIVzpdXVntnlyrOxt6a88HFofsuGPc7QPdVoJbuwvUUWvY+ru4df9OeKFJei+C9qGm3qKNEY2k8OFonrnR8/UKcbawTvQh9SsdGoVxhB6OYRgDv1Z2EyHltLKhJlxVuJK02pEAQGX7NVt4r7nwNfraoPXBtl3eMNOK7rVwW0fjVHVzuytig0DQhfSlkaO8n9pughUGAjWoNqLlKPJGWrb4IbXNT5r/YUbdPW2ci3V/P7WrVBWz/eLbxNLQfLUXijo+NUp3xl+20nuTMMQiciqDmAymZA62VpgqSDHwSMmih/SGnUw==
X-YMail-OSG: fP1H1MkVM1mdRQa90M0bBgIzXRWS48HYr.0bb5ZVisRcHkbksXsEzuuMKhRe4vz
 wz0ehuiEoHj4aLOEtk8sumXImBNCCDjSpfACOOFMkxpQMHc0IE0_qbpJcbwI_4OAjej1Ohw1tenI
 Poo.H.TFTZxybIgnQQ5WWgJW7boxzNDOxm4_IcvRJTDx037DH9NbkXQSB2RcBdH_eQhUniPX1Ufo
 1b6n1D5Fwygh2RZJFAb27vyB.Sns.rpf9ps5aSdLisOWTVFOtduyzv6zZCNrBlWh23GLisl57oVu
 n2gmHdN40fg26LRr2t2Gj0dR5sDBFnKze1Xlq129c4m524BQ6GS8CRVBVPjZIXwuHkPH237TOEhb
 NHI7UY4WTTCu5ZvnRneZGrueE_a5c2EmwGqhTe8JQp6BPIDwOtS1LEXatYr9xD_VfZjnL9Tbz5Vx
 PERgq7.r88egGsEJFycdkUPzLzw.dYDrpLylz60PHDarwwuQTnokCbsAqKm_uUkkECijxBf8_qKx
 3G0XXUArd88K1hSzQNUCeQX_.MDOm._CxqW53uBfUP4dRRPchlbQQm0hQ03oiCrxbEZ75Racby.4
 HdqNkZPDWnwkP_e0W4o2LN.d52zRI6dBmfP64EFENoQzd7eDBl5rayLp2OnM_vbUbULdHrvWmWRk
 uN3FnbeRis6DXDinCYChbu6A7f1Friu3uQRLTzC3GLecW0ZgdYkcdpWDJqlieGTsE5mVK2w.UxyW
 BNwFbBLVI5uf.5PC8MBubh79Z_CyGggXRRndwcmuGxQ2MB_82wKfPPAQiuyvnCuyUJAB0M4wyjxX
 5ODVnjzZguXzvY_LtBQAV5KuU3xk_QlNnoZnyIjFthM43E7XLtVWiwrwyYQNbSpBvGV0rgQ2tKma
 dCiiZnotBPrp4bePbUy0YNNqa5._DSO_0WmzmX1miwtbA8U9a3hDhEAnA9JFj6q6BqQfO5wwK36o
 dG9fZhH.Zi_P5bkIXTkteKJjR2b9ZOCEq8HiHHpJ_1oQrx9ISXyq5j1sJkn1_IfUTEnN9GE0LwSH
 eUdadb3YUTrtOoqsilkT5JdJFX4cIJ.WgrHrKvA8t0yg89G5CMezwj.Lh.CiT66bd3tCfV9uLYmK
 13.0ZhSWEypi.4w29DgermnFqRjwlDIW6K8f_cbnFqFVEm.qKonKz13ogxXKoTum6610K7O21Yom
 pS80yGap9kXxxcC7gMMsn7pAYK8zbXUH8N6UDvFnakTuHg.mSrZYqUkxunWi_t76yRiSHywn0KIA
 b6l35cDRiQ0KhgdV0nF4Ay70UFatCHCTDP8d4gCZNM87SGyOUjOIULsUsVtqw3q4svwZnmWxsYQk
 tQ70qBc2kIG4rDy88V3qEGWOQ.O2YYY.V2HMV.uJ28kGPRqpVcS9G7Xbkr_gQcJPH10Guso.sfLp
 rsPiHwDHUGpmkkcMpFhvOorn8E9NvIKXaj6okOuN3Pw5RAL.zh0WZkfisKz99GahrS0EJHAcgwJv
 OaA0pgzdNAu902Gz7Wm8YpFegCVMW0HiP_REPdzvHBNXIaP_ZL_2I.pvJc63wT8n00YJEmcM.VP2
 iJuVJ.F6RG6A7HM1REBd.rcQgAsaTqsfroXSrBJ2._Du6V9yVUsLEOgwJmBcPqtsG2P5R6OlRgSh
 blh5hu1VMh1FMKFL2Fbcusg1WR29yfBYpODreef7IstKCPSJP.vlP6P935fWBVmVvXQQXIkCzZCr
 lNg8XyW0Rfzl1roRs2LeHEwApJ67p3c79B8YgsYj3EpM6l.us4fOYh2bZs9gnIhWaYb08aJ_P4CV
 qNDA2InIYEgy6UXmJ8JfITyFgjhIZUmShH44IANooCI1yNadskMuXwzXaOznQ_lRyB23ZkzGA0vX
 FdTAvhPpLzkw9wxcfy9.xdVALPNL9I.GeAyk3iN3hc9G1gGYpu1z3ZmRPcwmtMTVMSPNyjt9vIMd
 cuDDSO2PmanIboHqsQNU_C2A3kDlJSb4LODR_HsMTzNyTcXSJvRg5Q0SgSh.vbn1ckMrww2Xsm1B
 CoHD1NBbP0rDt6qNaFtdrqZyEqheqo1U8p21O5zy6cPOt_XjxpCsu5QfguZl.u7g31HR_qqv_Azv
 BvfnIf2jAloOJNEj3brcANtmA8XAADu8RJwuf5f4kxfwm68croDPleGia4gBdzMAEuOwTFuY5h0e
 lLa4jJXvvNONrDcQX_taAk8gEgjVKRbzc6kG5Y8jBpxCDUe3EcgWZ_fBz6KVddUZ0d2jDQsDvWc0
 xum0lj1kzhT6scp2uustMX44hqsNMp3a8_L4cFubEYPfmIiH33MtcTLT3Wj6ZKYli0OFubg2drgi
 fGvckJZ3kysKTGZPTwipbym4ZZRsAWjMyAH2b7cAPjcJP9HDcHKMdJfOH3U4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:26:30 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-8bhqd (VZM Hermes SMTP Server) with ESMTPA ID 6a671e6207f140a4363de0fabf2a4e74;
          Fri, 15 Apr 2022 21:26:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v34 17/29] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Fri, 15 Apr 2022 14:17:49 -0700
Message-Id: <20220415211801.12667-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

