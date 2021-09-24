Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA3417AB6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347986AbhIXSPV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 14:15:21 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:34644
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347989AbhIXSPU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 14:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507227; bh=zEv9ZIGZNCgU32WKXmg75kwhAe5o64GekUqwpBi6s6c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Nnq7COk5VXfvRcKo9iX1mtkbsisA5fheSitAH29NUToGqmeLRrwRpoFlIgjebMehsyDYNbMXi/bvCpDmM+uFx5qeVTFm27fyrtHh6AWQf1gCw3xRci8wKEVw9sMuGfXmxWgETA+sjO19ug2ryf1DUTGS/YiMoTXR35vZqpKH90ijqAcnhI2L6WhyiX7LV7O3xlHfiUSP0EdRWuh772tFGm3+17m6/Gwi6/xphaPgtSFdu/T3iT5qzXtHDKhzmF6jhX+3ghgPJUFXIi/E0yL1Sd0wfduJanYF/cmAbJR4fERsxCC7f1F2Ccmo2ryrQoNphOx7vB9XFaQRt+CbNaBbPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507227; bh=sBBkJYsX49MXv/0T7Cy1bQxKXOk6A17s6MVwiw9b7oK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oy2c0VLGRLYK9AqSwswmmvNImt1y8nIZhlTi8tdxTKJjaCJ7cFwlL6G/PdLXcFONnEsSHUJM+u9oof1Dt+kj+hoEiYUElOsJvOvKLFcEpP9sKH2daicd1oHx8lMik4JT4qCzdnsPQVh5WpVDC6+uscQXUjwiS1SmCP7RBQL2ks2L6w0nb39Cpr2z3u5xh0ojoq+Tfc0TcRYUeqbAAjj3vh1orDcrYQtIkowQ5Kbv08mdf554xTSQM/asUk+QtsIJOLuGgjipoItsqLiIetv6rBd417+JRj7tq7hDgIxcewjW/nrT7faWHeZxB5nO1s4gpLN9xfWcmtQZDAuVq3MjQw==
X-YMail-OSG: IPEa74AVM1mXMYUjB2jhUF1m_rAOekINZPervGxnpygmZjbC__20Kz7II5WX5z8
 qbkNUWB2aYBh5U5j1o9oeXoX8QIPzv5tIHjb2QZLGBcSY_bQw0h99UKcGuu3lk.7vtU26CjYlDWb
 KuYXWY2HcIAaUsphitG1zKyr3utE3ZEF1O2sOkGV_00Sdzp._Y1mCOCBd60pMyu_LFIJGV0SyrMw
 .MOvhZX.2NzfGnYnuW8osXCX83sIg1AxytPUUht64bmUVB1ktGL5igjbIxTs_ZAoZs835LiOeC.A
 oNPPowzCllFO9Y.GqYEQwCefH1L2pJqVprwyb.q053yuz.tXZxIAfANxHMBmXRFVROd64oXd76cp
 vAUjYo6FG09HB0hWnT8eS.YxjH5zi1ZLiDszxkRGDWy0xQab6k.u4Ao4Cg_fRvY6eVLRYwCMY0L_
 CBE1u7Eu0UgLjc1aMynzVVySontTRgWFcLycKxagHet9tFugULCqX2uTd6da.JEpqASMd93zUFk7
 SKjAzb0KCTvhOKMdmi5dVxwmYydQdQmqHCFvnY7rLdBo0vxq5tscOmjCDjyHQi_t2dWAI36BkeQs
 na6jYsegD3apGxPdutjmuEMUTvRp75XiX8Wcg5.8U_kWdbUuyPjTi_JI0ENPTexDwYRn6sYpvEXk
 WzDN.Vu1HwSK07AqWRXJI_LDMOztqOY6Xy05q9AwxEPGTsnTX_6nATEwLT2ompaL6NXKTcp6vBW.
 hYy1uUgG3zTABOOHM8mfez8o_WtmpnH8_J5f3nXFXn4deCKyka6lp1gsrn7625H.qqGlyjfpu6ET
 hc7mSk38QhssGTZVrVakEtKbTNnGnkjcmhrKz4T5LW1sCEtNApRC51hNxk3peM7fR2mm3xf8c7jH
 vK_MOJwmFjZTm3Fu9Y.Gqj1k7Zd0O.YxihAARHZDIRjuxHMqq77Igbejraw.qJ_sfmbJZKmBonGv
 WndQnhW2te0ZGT7xfU2We7Tet8PO.ndX8Wnj43aMhzy9.9kT9R.o56COZ.J3uGP8gm4bghgWNCoe
 UfgTkdY39GuYecSxN3IU8gCWEfc0DCM0wHQp6yIbIJTq4YgSzlKYJFxORMIOB9nHOc_f1VgEKT4l
 TUCEIWGLHfavJyucEtLg2paZTDi0Qv.CNDzwrPgUIPWo7UH7WJcV57MsPxGPx9jCazGgWDxPEqGy
 5dd4B0nG_UCsqkR9MUKCNKUEwfPmKdGqQdSrUXf9Oe4Z7q3bIjJa0RrBNkP_fcqj8Fk6XdWLl0lT
 tpqA7rT16VWVFuYr6JufcwfbpKg3TLvN8ldnaSxDu3ZWVKbscTgaAima43Tsy45DeMwP0oz0ngT8
 gsGyUoIH0iQGXBf0rsAVq2ktdfAF1jqfClRsDrx.87wsu8SQLz_ZWJVq5CuoWtUS4Cke_5j_.hQJ
 zZ1AA2ORs.Z5DUwc9hSDfA2qCU7JuZ0pg8nhw7HN9D_2uk4dkpaCZG_QZYZDIt7Ri2YRt5yERRmx
 m9ByRxFuyZmDP_4PDSIa6GjY3LcwtTJXmHVnLAL7lwjRjp9hu9xmRX6_6ASLNHd3iTZAVGimAy3z
 drJ2tjIUtd.xQfx5ZJ.byaPVpg43iMriBGXjpv6DTVoeoxKOla7zGGJgt.9wYt490rjbMMyAgl_9
 s36CBzOwlnLFnVvYE9qxbQdjV4ry.buxyi2cJTZNkPuBdKw_ztlZWNXj__l.CGtJLBCXAXQbMgZT
 Hh_SPJbiETMggsVS496OtEUaCSKz_ylLSJbgK7RsH.fmEknerPHVpXv2DMCFHVthhxJfSiCN6d9z
 1S8XMo3cWGZ.X_JZcLLUoVf.8dQipi81_mIy2oxl9RrjZ0ykRfbP0BbHXuIEwuoyxxjZ.sljjLjP
 .K2Ey74p2NZCaBgAGfE7EioNRY64Ay06jtJfzu6XE5SjeR1ad_KkRnvnFoS9qYFKLtU5_TE6BSw5
 X96uQ2yM_6F6mUa8m0C3mselRNeM_1g_ab_vyoICo6F0oSHdMSpNEutS0r5Nn.fjTAhP1y5pKicv
 jjGGPanhn34K5ry29moBSt0rdoU_MWlA.HpTE_eLQmGX5PTP5XVRjG6C7Vanm96Cg3gvnT2OmotS
 pOeC99YeIBHerPMTIySOugXW7UWjR8.Q30a_ESYR1EzcI79rUk92wMXVgInp.QAQVzCSa3pzfbL0
 Y63lvM.o6yOum1X3oQBV6kgk2I_aigxX9ouVAxHeREXXlfK7DYpCukVohfawXJ5FF_eIcEXK3xm.
 uRwr9WT4hlyhr8c.R0WWHblXcVnA_K3Jzh8ZzScBcstXHhL0xi1sqGgZBQViy2isWBN1MOn.Mr5U
 oIrdj4yrGHidmARUxwcISg9LRD6mGj54.eQhPOocUU9KdK2jaTkK0SwM5D9I5tETKbRLLSk3aaXE
 Gc6P2CsUr.Ak8
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:13:47 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e8ecf35fa5d45e1219effba6365c6f5b;
          Fri, 24 Sep 2021 18:13:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v29 17/28] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Fri, 24 Sep 2021 10:54:30 -0700
Message-Id: <20210924175441.7943-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
index eed281367895..e5fd1711bf8b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -586,7 +586,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1462,7 +1462,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index f8d306b0dfb8..a61477c6b0f6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2398,9 +2398,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

