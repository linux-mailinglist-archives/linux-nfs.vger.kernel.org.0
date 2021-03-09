Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AA33298B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 16:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhCIPCP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 10:02:15 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:39611
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231812AbhCIPBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 10:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302108; bh=NzMMPOz4GfYxl1ySMgxdQg3V6bU65MO5j3F0eCJwaqs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eLwjMesusHWBg2mhJeBkKrRe506yK0qjXNZ0WaRThnjC7v8WOoifuxMExS15HfjxYAyQaDupJ/tEKdVrCvDHqsVm20RmVvTkz+r3lKS8IXQTacQGYAoXfGnSle2t5GOsqsYwXWEaSF5bkowWpJbG3oRR8Wi6LgNceOE+5lhuhqsBe4Zn6Oy597Yp/5mIGhjWxWV+nta/SvjNmVOhX54RhMFVhSvVcrjsUsF5RAYJKZD2baX3w/9iUJwnhQHBGB+8s5khIaKlzmiLAbGfaCs8qFvjQ6+I2Pk7uVSlGbWDhW37cFcloNQKIAf4/YS1zYakJjakfQfKnYNRiQ2tlRrGAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302108; bh=87v8sRtHwup1IL96dSLvCm7u265ney/iTdgLtB450G1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aJwVY957V1wHg3I1kJvE0U+oTvLQS+vmzZLnYT0uXyfCHMU+VgPP90hG9DViUQA5EQLCz8+eW7CC5gx6sbmSHZqYC/108DrguHKdz+haLZpUWWTuM4TR4P2jEIQh23MOJhhFCx+DOCwstBkbd9iT6iOuVmo6ffJ/Zl21Rb/wRgUemFXrhDoV1C0T37tsBCFCols2D24ml2dctsSmKYWujE4WlagWVWDiVdK5QoaxbnaSZnP+TDFTJkJAbj8vp59x/N/0NL5iNiO2jcBEnqhbHqlPuQxuJ+RULLj0L5BwDXOYu0/LseixrL6yP6LxtDDDBLreAB+BwLjJtEZ8UzR++A==
X-YMail-OSG: k8hO8t8VM1m2YcyDdjIGAQCknW13EKjfpCHvoVFLv75X8YLXxNwLZhcLI1oOxXV
 FLxwVQMWpuZWV8iuuWA5CFqvCFuTkGI50W2594m_4_Wpl_45ViwBXoQAXmf48GNhsAkUzdjg9klD
 atGSsVgC6sdECiO0UiWp_9NFpwbgjx7jiBext9vXkl29fzO9UCTeH_kF8yfA4N1ap3JF9n1eoa06
 dlSqNzsobplQWjWai8UaOI3cfJrsSGSdtFnwi.Rki6v1GomLdMT3wnL0LANY01GT6Xv8NzvDddWz
 IUQd_vl.4z2zqWXRe2QbonNivqO2j1.xVR88Pk3bPN4WV6gMJzx55tzBayrEG3RYKEOh6wDI1X3I
 Gn4yzv74eCFT5xlq3xLtHwIQVq43gQMisvFCAPiTSmnlhiZ8C5p0hCQAy.E8IQfCjU.K8y8oN9DS
 jMCEn3YBP2SMoWp5EFX4snWbdMIbFKEOhpg9isn4sg9lC0TysL463XfdSUH8W8_E2PhGUk3QAECA
 PdY5LlRHS4_hQiIE1RD1yFFf8uDFCwl_8RtygiRfdXs9km7wJrpwS0jxiTrAzEOYrn8RWVTMUojp
 FQFEYfPODSbjS6KJ3Ibu08dmRyjGvOPgwszVprfqmg6pQaFB9jXlfnV4q2OZ4hMrAa5hO1tydccD
 Bm7etG.pt16EolyGaiXMh021gbnah6omvqSP1iiXneIfXhVe09bTmGtUxjS.vXMoF5wQN1647e5P
 2z_X.MYd2TvaJ0SKcs328J82x.WRnKC7Rc9t7eaH47tjRwydaAizrGwrBfAVpW7ty73CBluO18MR
 cOUJAsT67jiX6DNjBLoiFumERQnUlHZKkHNsdeFKHOe9UFnvpaTYg6AOWc6.OJMm1OBZ3HbAq8q4
 pDzft5ARy7zq6PCOgHiPVoBpx9_1zf2pb2_iQUCt2YC5GGYMcxJdLOsK74XfuUE5tWdHdSWCkxbV
 NzTZczo1DDi8NVZ4Po20hjOTN1M.wWQY_CnFKPYKPAz9m7ien3xDM3skZqKlszx6GDdb7hW4HtSk
 4m9tgJQe0FqVsm.z4KCfII0OJ4DnOswIY2WWjN9zKhaeHZJ5VpPscaI7OJEOggNekRqCXWuhKL21
 _tKtfxIQ_t5lwH2pRcC6SSmSxecVxnAEAa8z32ZlhqY5EhqwjZvC5C.Ah9Vlp5FULttixYgXJRdf
 ..Gz9TWFX5haXc.mC8OBnMAVZmE9FMD.IS9DqKOAT_bAf33Gd_xAQhAjky2yruJyQf_xBTOocobp
 raQE5tiBUMU7dqpEWN_XJuHiR6xlRA6veJTfp7o0KBN8SNKszUt_YEs05U0bsCuzs9_y8qI5CWJs
 xDdl1cAIldEDx9wuhm_FCq5VCmIe0g89_nV.napzTnfmnYTIXgT049WG8jeDAVGRPcAk_MAA3jQJ
 fWrRlVClk5_2xMdTRjuIx0XroqlRPiAWrVqwse34_3R8ZZr6F6NZSMFzvqVqCts9lcE.Hh4wBZ_.
 pVDIhgR3.nBJj0KRcEGG_temDrdHsT8lvMPfCaLf7Kk_W3YCIRexn8sMe9nKNmcnsjdzx8aAhjJj
 53PpnWi_n3KFFus2yIcO3tKJvA1NhKGKfJHJFCE3YY4wb3Sx4xt_SLRAfW2arrurBHK8B_Mv.xjd
 G.mm6.QvwCKA08aT1DvTz3TNAPaPGbAca.9Te2qnADlb8OS2xhdz7OKbYx5nlAVfFcuvGvt1Dqjd
 hpaCe0yXuD3q5pyapvc6y1nX2k3lty4l21yG39SQYaiVVCEDeSPSyBwEd1_FJoQg4lrHNI6f3Jng
 DHgxTa3ctNUmhxIAzp.nM1NIiELAPEv4fgZRuFdf4Q1zy7Inzdk_XekYqdBuPDMbXsdRZcZempXr
 rEPna3BUajP8c4xDnhyjlJyJ1SnVihOaQVYLUlYVLWFdQ0JL2PIocr1SqmM3LlTbZ1nw8iqSzfzk
 uWlCfw8aAhTI29XJxFX95q.j1igb4gsMScSZcSteQ6PDpcuK3ZyJ.k5NJD7a4Y8p6RQ4DP2abSAD
 7uZpp49OY_8SFsVloiwyhPXblcOsFNSPpd6dN6FBpUQOKcRy2qzcinsfCUqobapK0rDKUHj.oq_J
 vlNwTBFn5PnjhpsqM.f1ZvAyGvCdOVWc_QmyLyEC6GFNgdU5xji.fUKWY_bK8r4X3xxfm1vPhrGg
 jUjrNMFdS5r7xfCMD4TzKoj4kAUQ2NB7DEaA.oE_JQOK1192i5k52w7kq_ieRb6dSUe98ESp4ds7
 eB52kFFtti39Dxp7XcV.nPteNye2iUeYhxrtI5oyVyFLaIYt6_Rx7BSfmQNo1oI8qP.t3uTEWcji
 yhGrUvYZdn4a7dWmzcevHEyrv8Fch7jKRVKgbtP6.os4URkBrfQdewAzxR_DXUiXPBvJhkbOha2o
 w0ySCp0fZVl0DtpBBYH28GmnnebJT0VXQIyP0xKYD2EmAGXMWeywnD4oLtfXay0N9fUh_X_BEOY6
 nnTSVwHNHYh4mZwo7sHQIIeYJWJnzbaJxHIuK0qOVNtwVdM1.c2XDH4iGaiqvrE8ZL8228H2_EMy
 cM9XnwzpQ0dClV1FP.yV6i0mMa0yVo65skX4x1kCeY.wALpfXrwZfuHS0dZ8bVRh1qKjGVU1kyr4
 DtQuW6647IPufXh6dWr7FlYhKukDIYntHl0SsYjGRNXqdX7pUSrxk9v509jlV9xJ.fKw5.Ddlv0D
 gBbLcbyJ.jYENiWw_cFdAkLqPpNT5SMTY3bUKDdlDWtqhnylEFITMnDMxTWlexijV5D.ZaSUgQDN
 YVPz8TSgCT4YlaudHQ.7XrstfH5gcwW.qZ08EDbFH1hsIndM3tR77ta2hQEKftIyWXShjd1HrCuj
 1E3PrC6Gypb_hlgrkc_cpRQDi.SlZqxDDlkooMfjBkWQY1TVek_SNgMf3S9DKzFsG8m4wJrUKCm_
 nHWHfpR3cvbtAC9sWqklazodPGwb_f7zj8LVM6r0Zhb2Ez_fBP20Lhi1fZV_y6OKTL_JsYy9wopD
 MP8o2sMU6cPVMe1uZqKAk6SdKu6OzOUdYtCBmcHlsYRoXbcElvG56799Dz0BLJgFgQnP80dRjgNJ
 FrqRB4lhhgY3L0UkpFhoL2Dmhr5yBUeNK0IR1I90VghOo_EMJp3iAEHXNNDCm1Grh8PUEVzry9aw
 QaBLb_8FQ9lnUAEJOrV5UdwCgfSA81yGJsCa7OXejzkBrzJGdNPT53DYKxdIl6g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:01:48 +0000
Received: by smtp410.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 479e650a839dca9718bcfa95be4a5aaa;
          Tue, 09 Mar 2021 15:01:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v25 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Tue,  9 Mar 2021 06:42:35 -0800
Message-Id: <20210309144243.12519-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index afccc4f257d0..a796268ec757 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2727,11 +2727,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2741,13 +2741,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2844,9 +2844,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2904,7 +2902,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3324,8 +3322,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3346,10 +3343,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index d0e1b6ba330d..9dcc910036f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -582,7 +582,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1442,7 +1442,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 73fb5c6c4cf8..b88f916e0698 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2337,9 +2337,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.29.2

