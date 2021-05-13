Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680F37FF0B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEMU2Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 16:28:16 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:42264
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232878AbhEMU2P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 16:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937625; bh=P5D/d4FetoqKR1xuxXxJ25hFtYH2q58sA8g/exgkI64=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=skXm1oQPxqXWMJuBDhgdYetwG4MgRjSio+5dRZfR/ka60gsHD6kW2menC+avuK8Vg3ypqKp1S6eLrxdKy8pXcuVNDMiTCB7KrjtgksOo+EyW49GOvbnIS0AF/2B3xs2wTyEmVrUmRki5iSTucqgk2fKDbT7gbvk2ieUywsTpm3h0YDBa1MGVD8BMsdArpAQg/A9QD37UpTyiqxcC9FWxmcai8utoVu83MR3y3MlyZEVDtKTVxAHxhX41Wywp11sDsus+PiZ5I1umV5GsgGOdRQ7szZJox9IrMPtwNRGq2nol6uSWgp9B2kGKL2msD5Wi/WPMuH2bT+t/YX41AhIlZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937625; bh=BF9UVptCLTtpmgP5gOCk+ZnUu5+80Eb40IYFD0kXakl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KMtbYLPeLCtm8ed/LKSgcPAux1KtiuldsLBuOwHbFUJRweI6vkHwsNsNARohzc/bMgbwJmrUJgtsi6xehWFdKKpd24vXsWiamTgO6NCXNufET31Q8sahn2+vG/QvkyIx3W8o2w+FSW1tWIZTAW+iM9GMc+EeunSV5dUcGYl/goFDPGPXnWNQxCQ7dIpo2nh4VtVcCoS5YS9Rw0ZLV9soggQ5u3szncXTxGIwd1h/uIIOC4wgq5srBn71Q+VIy3nU6tP8rVE1B1Xt9BROF2MGE4rdeQ3A2e41Ju2Rriu57faWaMju8yynNt0H8oXp5xCWhQINFxpVGC0HWMlJJKrvSg==
X-YMail-OSG: 1BRcKAMVM1krIsa2VjLgorlbIlR_VPRlwZdRtU4kF6oH.jPDxrtiIhY_a.yX510
 tF7bcq27llOv8ZnvVsahedVMka6D6m5vfTHlTS48UCsG8MqMs6wYCJx5ABLRGuYA06sgZvd32f37
 UOTw36J_8XljOYrgE89mbzG9cOj9PkERlZHe_F4fjIRK3Zz1qGkwWKJcVMqYLHz7rqDRJ9UUuD34
 En.HxSEcizdV29vcV1GTsUJYjSGG_ITcudcVLSBTEOKFFd9cJYweJwNoNgoX8_TWktNkCSjMuY7o
 O2zCCssqo5Hg4bKN5gHAolYJlxu7wNjhJc3hfdJqpPfOMPSFrytmM4LjkhToJm1d6RlsaQOicmOI
 IXaIjJQzwImcVQoeULtviP1.PRNxBHWLHUuNCscDJD0xVcm._ZwpmS9g8iUiU8jzzqI8XJuMhYph
 dItu7xg.j9oludbPsLb6GlWaKjjpbqH2Y8S4_dh4N.jZeZuflvdS657G6Za_3gCjNzAMxbYfl1lC
 Lcg_xlJlysUEorlBVfGOnrLzMu_ZDA799q_Wv4SL2mXayk73YlWZiRcuHsJu6rF0i313u7uQMZP2
 b30_LbCfoCdfuTLwUfSv5Dmzz_FtBPwKn0_Tw98Uis87MbjF48YkzmA5S06uYQRzcqi1B.zct8oM
 rOsW1vBP2XmQPdCAQZJ5D.rppYQnst2pBIaiYBdPXcILFy01aldHh7sHY_GwXU55DxphFiXctG3w
 qBocOwuzl4UFfxXIVGvD3UNmkBRDXc2Q3gn.AjUR.bwBBi765Vkr4wBITWcJiykLE4xhYGkZ03lK
 J2chiajwbHTm_OsNbUFAWLKYqhPoNUDEWaIFjIPgjsOdpS4zmIGspXh4ewYdyfeg.2gGr4jQmxuX
 cgtJ04C7VyG.V9557u.WSwRgbbynRyto6.5gwLj1PIX_zb0011MTSaUq2UuoPbH.YAzEizauOAi3
 U9od_yk2PKslQ1E8FeRfoguervztaLuMOTHwGDugj3nXAv2adPeiduwX0u7E9OV8xhWVx0znROsn
 sBuEQH99ZJott32_kezDeY5jvArYvI.JYvUC.LBXMrZ26UAqDmLbyEsWKBeg9RGI26GTeAWGAGD5
 edSH0E0Hbbve7dcjrxgABHhwY69tBvvLs8fVwBKQi5O7Xkof2ZlAJD45Xh4rDBvZK0zs4kHhhAi6
 hB6xvvJs3PU.SWwyyz44GPUaCD0ox35ydRlRI6A7QPAJqGpiXqmFOtTtEKS7OCwwU97fwf99LiyV
 kbK.w7DVvF6z3HHJB68aFYs4ZqHOsMqiIoa_pyx3H.AFKKlDY64gR5GGQED8pqJW8ViNN1rzg1wF
 0w9qBPs4qV_lta0xavEmUaXVxujxWrzJltRhJP5Refu0q0xXudsXRJ9akEE7seWhyCL20jlaTWu4
 N2glHLD3okod_6HeTOLe0A6xAAwy4RRjOlgzFoM80ThHNC4dT2GbKeVxM4V8ud9bgC1JfdsBUCJe
 H0HRY71gbJqbfCPgozkJ_bFEmXUQglpdCapFiaXZc8eHS4BZDlHdpgxX03btqI_.LGDsKV6axWx5
 v9TgGN_gnDtRvudfeAnskPANiLhnBa7GybyFSYUnC3stOB9vnZkwJwPU9fyIk1TItLKVfHvtTYaf
 5KALc82VYp1R8CNShTbh2Ty4sPdgPNeBNxZuayOWgAZp5uAFGpFGUh4vv8lDhCLFZBd5C4HtXkY8
 _GE1chCNsPIfDe36H1DDnJjhtyJ9WIG7KTntIJYvU.LJoi5m7ub1PuAlj1yaJ04WFB3ZY8Ytf7DQ
 f.Pc.qjng5HElKvSPsKR8WQrcShlnyG3tDBTCdKw4AIIJbUt8iAhR4Hq0XaSCN5713GQvzpYHHs6
 lIB4W33NLCUIDs6QhEfKMw8GH3cQodWcLTSPZ2B_diZXkWxHW09MhBIl7K1D8PsNb0EM9qnrA0V7
 RG_npy4tGUhIbEh7kI19r9LB15ZSTxRe777x8q8Aher2Jh9nGvqpSpLCE72TxyeVlR5zFBU07bRl
 xrKFE1KYQedpb_Y3j9kfYQ2YKCiP00vBxz5jnurvd7pDC5xsjdXOINWsXEx6lZY5T85CcDSTJSZL
 XmRM5dxbYZMxHRmE8350rVKnsUAzPj1FvKQQShC.sEw9VO809yBPcaIdWjC9nbSFpWs8x4W3xG2S
 JLghPtJLDQbARz1ByMmeLVZQk80..0JQatacAqi4TRKZrqA_AEo9l2BUHtZS8CieWD3df8Z2YlR5
 VEWZYGdkAnc2cF2BaRi.hbwUQkjYwEGPdKZ88RScpxR2mBw2UYQotFu7.le7OzIpCI3AW8CVFO39
 hA50P7BaqXAaKNK0Zu9J747UMBiJCcopnX__b8eJy3ABzfyxEYK_xx_QdHCyUaKu4SDegJM31dZT
 8vMTac9InuFdsKXBCVFwIhGCFLUbC.tgexGXGuUR5xAa4ns5H8j6vyO2BmtXggGiNQYB6zrtntOD
 IqQ70sl2CaCJgCU.K1g6kciGDe7E5JdFt49Qf0phQO8xwCPbcCjt9E.f6jSxLua6c6DbC.qdfseE
 MSnchXLn_xKsQWRszAHTnQLGsv3BQP9wz8gimdWmJvC4fymVi1_MjxNP_uJBXmHd810pPQcC1qd9
 7x7xWUCw5BeeCcOtyn0j80k0Aton.iFJdAOvgHjxIte7m0ou6DEj0PHKB9Zlw45UWs7IZjsqMuq.
 g8BLAucNzu_dDLqFZzgWIFIc39oQgHIOqYsGIZqA8tUWtVkSueNcue_BWNeCj0V2CyREg5uYTcDW
 TAaEh.SHZC7Ah8hUvCQUhiKjUIUxGvNu7no9UEMReTifbNLjUcadvjVKxQkZgUAHELe92Kmmmg0I
 29wYMLn.Kc3VjLQ1urLMfPq7DPkLD7_ew9duSTYOJwI2b.RGwZKI52r970VqtyaR4CFcgO2.HY90
 n6HEZEUoLqOwK7i3RfuB1cEDxc8w1FOMx5JNZWBzyEznxXbvZIuCBe.Hv6Z8hTOdIHADXQamfWPP
 nTbcjPUJCyHi1xBd8hRCtXKkHtfcbHpMzOab4wBkgHAm4OQEbw.fo3HYBh8fs6qln_E_uEH1bxXB
 ZHoM16zH5H_vB4zbUv1uNmDMGajcfKLAdSrBw0S8ggOs349zqNF4.YfgiT91wNE6u8p0.xlvc9I.
 1CEK.kS0smhn4kv6BMT_4Wb5N4xm9rNZyXr9_VqD6URZzLT7kq1A4BXSJEPoTlGzlEz2xDMKYzT1
 lLdzWETCf1Nz_pJJv5tiTfr9GGUuAOrVCdYR8XlrIitbd8_JbQauCj7BBnWtzaeA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:27:05 +0000
Received: by kubenode543.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2c0666088a933fc7b7e1010f34978f24;
          Thu, 13 May 2021 20:27:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v26 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu, 13 May 2021 13:07:59 -0700
Message-Id: <20210513200807.15910-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 089ec4b61ef1..fc7ba114c298 100644
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
index 666bd85e142b..0129400ff6e9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -585,7 +585,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1461,7 +1461,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 5bb41ca1fa9f..1e441c3491b5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2395,9 +2395,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

