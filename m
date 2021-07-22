Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042D03D1B39
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 03:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhGVA0W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jul 2021 20:26:22 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:34476
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhGVA0V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jul 2021 20:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916017; bh=ADonezOyML6n8js9H3OmQ6Hkog2RHBUahaYJXHI29uM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LKMRCM8nQcXUHzodcIzwQK9I2h6CktPQevO6xTxOUUm5lSntSyvMrgCfcKrxJVlPiPHGu/Fdx4ef4kejVmCBk4QNZRfT7LdwTkKvxps9Fz7PWq7PJUKjsI7WYohjJvlFnleYirWB04f+dcbqszqy8aHJcVHGoGiN2DUYMLlVinBpPr4GRXkA7w2ZzQ2tgv+sEpNXaD0iQkAZeY+ZQzvYGRsglR3oRfk+o6QY/Pelci7oDPpaHsc5rAgDgNPNmzIW6ULzicYzXJXiK0Ra1g4Oj8TZ9HazIR/lEc/UHYCsdhMpm6/bTPfBoo4IBzkMs49pgBQ9u1t5OErQDGui52sgkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916017; bh=n7QP1BTXPZOSS3Jg2ox2mdhqrlMuCZZq1XLAa4ZteiW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=do+vNnvrvJxS411MnnQYcut+ii6sNaSmL3ptAXJUIs8ExA3lfuGfizgBuz7o5XFMJaLS3ZlhD9OWzgWIiD7sX8wXv+l9ZOvXnw5Qmnq6Em7wHHl42ujmq4U2Y1YzOcz3Dp+IAilq4GoBtsMSN/g+mMivp27ou9SUDC+LK6ha+UPyOmd+hRPsYhTySuJYcrKyMx3TfwN4Sh21KDm2FG/vK2OBqF2Aw9oCa1C754D8D2wAsZ3T4NkuBX4iIGQvy2tBU7xEPRyUA2s9ZwZyT2GgqdQVxlwdDi51+scjSXpc1p0etsJh5bqsEy6ieZz3/lc2nCDn3KQQKNInq6k2YBHUdg==
X-YMail-OSG: CC6kAJ8VM1neS98A10xlTg_D5mOB_48KT4oY1tun1CAPeZvZwOFVk00N_hhDlgf
 mPCd1QNO2uIqCX_2GacECYd6_WjOPWienct4vSZ222OjB0SBDyDWjI_0ZVr1s8TGiKREc5XFsZvZ
 O_uVZZxeZ.0LUgGk1qJ8DzA6h.4XPQWqFHQ_F4zRjpnj.O9Bb.a...BylP05xYeJBTEjOokvwQIG
 onplFbf.1HKYK3qB_OUrVibNhNkO8Lqk.dNNlkIDXF.ItYjIS2uHQDCjEHPlGnGp2YKKjuHiFiMr
 lOVS2mw0AGJFWVkwCKq9GtRWcYGCDZSQYlCWfbkAQr1J3b8iEa3BtvLF2H96W6WoIaSWau6szeR0
 2I6G8KfsERHBsmBYfCBAOyWFd0RIwbcRnxH9FjdADAkuUB.3z0hQ9lZG7LSjSqDjAOg0ByvWiHki
 lAJVv8.dRCrOOn.ke3F4mLWosZOm5_OzGE3iAtDmDdNFKcW02xdhQU64TIcNidH6RNRD9qniN0WE
 Yn9vAtgxjqPdWUX26_8LvVAhAuN0e_UWlGB57btzsc4xk1OOXTrVlyYUkBLDFl_Hmwn4qO7oI2X1
 bp9HS3ATIRd5DlOy2SXA.6bmaAVF84G510vLk8Jlbh_SLCPF7jeLWmqY3NGlw4L6LpIwBeYtginW
 CX4P2_0om1RKeZdS9_5Cn347qJWlERbFNMAVOClnJNqUJp7dCd1eVXV_CtjlBYXVywAq3qs.WzCX
 VREnV.cDekLroNlar9FRRbzbLPrcy17NjsGdZuJe_qA1HTaENYvAczjDf8xAMwp7.YAYL7ek1t7u
 yoQaNw32XMy5mC9j7ucES_odKkh.GXBZVJ9iG7JpqdgbmIR8kPzTPFD2dF5fJP7khFZ2usa1nIh1
 549wExJsJx37yGIQ09dVA8MmFsTlUZMudb7_80D.B_GxT1XDyfH4YejpufO__JCdqX520jjbI4Ug
 6ABrdTANjFFUAM6cJ4tchqit73kmvI6eWWIjRUjs5SdrnYY6LV6xgpyUD7y19QUfqSeH3ayUJeAD
 TbxqnV_6Gu0xpXI9b2sQnC9v67QQ_FBdLt63BK2pA4VrT0f8gY.ZTg6z62CNEtMyg_GYv66uaZzZ
 kPLShGmZx0xmVrUkF3dWcoPyIdoZAmUOG2urrRzG9jqD2xA8xCigm1.gHySOghQTwqlbWZPVRbXH
 Ghb8cAnzQoJ_kHlJC.61zKyDjWvuoAZuDZew8uZb15.MGLoKTE66Zj51yF_CPg6I_l6Ar5uGUGdB
 y.uhBfHc289hbjwbd.RPHAIesjs4GkBEYtIBGkPnLegVu1_eMy5CzGRjuIVrERcrVb7zEE3169DD
 yHtOx1yFwChkG2vv1HDjhWvmg_.CfiuJgsG_W1ppyeYcoDpB1RGgBrU1e_vHKQB8FfNE2X7Ql179
 laHAohzYqxB4F_RqUCum3g06l7_bQCCYA3kEdbk2i61w5egvQvgRBiaL6gtWhHNebNvmfAFN6ezd
 87H7KriiQX1Gx7xzD_LcStjUfMXdlQbW47o9tcEVcNWtIL0nXEtAJNVzFkqXNN.oBJemD19pSYN9
 _z2kaqqq1AyHr4lhY0wHm4fVl1sBqtECHruVmQUbZTcdoXygsy4nz6iMMA7yMwRZzo97JeuWTGb.
 Z2VdQS8Sf3Oz4osgFP3wfkfIJ9IKQW6htdQsx9hwgBhG8DtWNg9LY3497suj6r7X5qMQ6TC3pwAn
 kNC398lqgiI8iexCallFM9fx9ezsc.Yd41LR27DKbL9J2rLu1iQPp8tn_cDqndIXv89HK4fM27v_
 ATnWrdEugeAqQTvPS5X_Bhx1yzY6sdlTfnvCwSlj.Ok3oPaAAJlLirVcFkS8S1QTPX3x1hQ_LYhL
 nNXxaCQET.MUBW1mNwuHS4OWFhuNTjqSxuxNE4ET1BQQVOVexagpaHt1pvm7a7qy1qqOdE8AAsV6
 snDWbiYwc7WnRcUmrv3AaRRVz53Iu0yDFjPZr0yXgnwVthGYqRE8TjbXST25alFNeQlZ3Ucmq2zl
 DKicuYYUucykXbQooyGyadV.WHtPURwAlKMMBdjGW3CDUZLH.CBQuX1rdtaznSskNK.TwEHUf.8_
 aXtY65ycQdXvaEQv1uOkfX0kPpX5.Y9sjJrD1wzAuGr9.sxoz5YEf5e_G.RGj8ml8bKzMH3lFnWh
 SWvptB_KJhX83sxS0tjSzrfVPYHm7wtN1iPIycloAEYJXIAHhLU8G6d7dYxrJo8p3_ga1Xity_d_
 fTx3XGY.03sM6e4cWYrspEs_ZpnJ6bqNoZjLLal.ibh8TqqV2PrV67OVawzvuVk38.sJWnczXGum
 CqnhuAfwc8yr8ogjiI6Sq0Dl2uHUyDmuL6w_jVnO7vndAanJw5eBZ0hgUP0lnt2OpvZVjeaVQB6H
 w3McSDBvrjT7uu85WRxy.HNDYQUOIqGkCvZwXgdsQiJPBNoBgMsnSd8rB93nRciM7jSt5G6BwV94
 n5O7w7bB3MNKQw_Gp6P8cv5lwMdcrufujdpwQ0FPV67ftZ7tfcCTNYWONJOlbJmHSxOMknsE7Eo0
 0nX9o6HaOZbttN1ogCZaub9qI4Ym15IklNG2fVSf_n64NUVCAqEqZCRzs2Jt4DJBtCBB3Zm_F_s9
 KBAh_MqPn9ff6UwexG.5b8LAtOYJIu0Dis7lrLdEvKcgS4b1OqMX1kFlueqCxqTBaCQgQCg_eNw9
 .hwJxcDkMvF5MfFvzvJ5rlp7flzxESYP_MbmM6wGn5GSFwKpIphYOjzdmdWrtSFa.tfJo2KDNhJK
 3_J.u1y3ig9hRQIJMveAQtqWGpTfM6LogMwdhxtWMNSCWOyAx2ftXcaIOe5LfXExUQnUnY4vDeLU
 yJ4SktWCU7frjje3z4DXHjsKsINx_wvklO22rQOhXZ9McVUObDihyAxC7_jSTHa90xfWRLlKH.81
 l.I8jkQNqeo4NZwXM.l9jsQrhOyHJWi7r2Ob_TCKdqrFnBOHdFlaEhFu7cb.P2QS45Xzp8gSEMf3
 rAPYbOagvpwMb2Dt0Zn1ytQP1GghnemmlXasmN3wwe3ebNOFNt8V.Kf17rvZslm8Smwyjv0lmnL3
 E.vGontUKdpVSF1zdVLYGe.LS74jukwPVCyysFG9niqhqPYeZfj_KLMnFev3i9Znpq5NRNk9Ca0S
 F8XTuK5SvGG2g7JNmyH3JIK_UEDAjV7_WLH8Bhrx.pMkl37IK8Rel7jYJLvQsoJc7VRBnxzWvYc6
 lfgUqp5mFhV4BtHJo0a5t3G3uLZqasOgktLZ_bkscqswH1CWGV7FYKbqUFkk1KQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:06:57 +0000
Received: by kubenode577.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 66311a3188bd5bff0fcd3bd712d8dae4;
          Thu, 22 Jul 2021 01:06:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v28 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed, 21 Jul 2021 17:47:50 -0700
Message-Id: <20210722004758.12371-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index b19bd9e1d583..3e9743118fb9 100644
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
index 713e0340a0d4..13ded9c55344 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2397,9 +2397,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

