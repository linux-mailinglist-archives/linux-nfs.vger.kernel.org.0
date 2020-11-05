Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E362A747A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 02:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgKEBGz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 20:06:55 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:37653
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731030AbgKEBGz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 20:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538413; bh=rFlwxWqRy/hE+Xzj8bNN203Dmx3KT5uCE0FOskaKHT0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=a1d8SdnNZYru5rXfG2Z1cpt7NY2gU5ZtGyehVDh2MjTcp8FuMZm7S/e06r2ldi4nAt+KLcA0cwxqNfjkSfQbglD1SZcmGZno5R9v/5lepmju0oK3GZ9Y50nsG4amfFhVEHNkZe3FUlzmX8HU6xda5qNOogsLzwioQ+CxjC/vFiBiaeI9o2KatwlijmBkaUe9N8cz3tttrH8iRslQzNt6/OC3Zwn0ECpbaswkZrvq7OmfEmDevO93Cyyz3yM0u8/rckbC4k4SeLeFIeYBdtS14nB31UA0nj5OuaxMIFl44pQjAsIacoeKRiXiwUyV1ZCAufVcfZamPGY5QsDU2ZxsOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538413; bh=GNr5o7JahmpKikHLt93btXAUHG/JadK4c6VYSaxbcb/=; h=From:To:Subject:Date; b=JSe+/7OsFMraN4+W7X1jZzfY5IfT3lFxkjK1I4UXU/nAsd/aL1K/+qljMQ5cFJsSTpSWvnFZAUNtl/nt4585gdsvIolGc02oKyIVhbFFnmtCioQbgqv2En2Fc5QO7oiDBJ93RtXcLzp/c1rnc478SpU/GXs9/+J/fGGifdvwFi6ykglfaB/30I0FUd/RDtQ1XqW2/EUAX9GpDgDlKDY7V0JgMh5567NgeYcwIorJHl/iiiBUk3ahmr/mnVIP0OP07UNL/Gj4Y2UpqOcDoGPKrbcFR5J7ylKXVVEzu6UDB8eCThuk6cjbJNq4rbvyEVGoL3kRDql7wKUue3Sg6fyQPQ==
X-YMail-OSG: 3jJ_VdEVM1lxSqD1rE4e6z8wa6C8cfumMl79N6zzjYfkRNEz8pbG3HkRSqt8o._
 aHlpZvaCTbKhtUuy7StcXvj9IjP1XTcWotUjuVD7UjuEeCtayfm5Ktsyi6b4BvGdX_O_jLMZY2Ef
 mpBPEXqrY9Uu8VLOiRQP3H8txZB6LI3I9aXLTIqQ0hRAfnxvrrsoiIqCUr1mQiV97.HIwLP4S2AK
 vbAoDQgjIRQKcWkpNqBCMomHXO04tnlNchVRqFd50bKiRY_8g71r4GnXSbt6ghN7e28bhBRf6qWI
 cB7dLbPLbjN9FQcWeMktNXMq4VRnKdqmjHxe8u9QaAehM_tpR8Rmt9qPHV_UNCXyIoq7Cx30LFhH
 1GYz5K04YklSYYLWgJpzQZB2MjpTy0K5sJix2OWAICSgneytZ5.DHNVbUa5R5wvAfomB_OM4.MV.
 Ya_vjosvR3kMNHuN2CVkAIfC3GbVmoM3JEsFiotjLs_L3AcP9ry8VOi6oztEBZbYPTnO64fvVCds
 t2vG_rzdaJwD.6pNcUzrhuNVP0mhpfT90d24LIuRzI3JAVlxbafctPYeIB_4UXYJJt7PiHAB5qFC
 8HjzankrLV53ZHr2916qOGjGjNj6BiMSFcb_WLsasLjiclbgkc9XotpEff4lae9rvrSsxv.4AEFZ
 V8dmYYNME_rdjALIHShtdGcu4DUOHO7gcUaFmvD_fiyyzvP1t21czZ2cjtu_NuLiLawHyfy6SK6u
 SqlSMF9JHhtb3uDj3HASlXYSkX__pd9TDHQnV5u_yhs5U44VFWN3xcZWpyqxa.P48rm8zzVVzvmI
 UDZ3jTVFX9y43QJIYGgPAJ_LWaf7nYM1X0JeHKYU9NMVqcPLzZedpMsV1IaTWLwrZGnl8y4TRnC6
 iqYrhr8g4KVMyxesvIuMEivp2gtcLHkCkuXiDkHCsdibhATkfeaR8UeFl.mIy9ANlxcvYox9pVx8
 r.cCLeUV2zqaASGJw1F8M50anEvCQWqBcMgNZKP4NFK.lTaPupyGEZVe_EyQxYQW9mJmph3TGCZU
 KSi6FBJgJ7Phv8RknypXr_s6fmZM3AOf4otNq4PKHPDJAaRGdtyBE5q3UAwz3rtLmDHjLR28bwRb
 kpqmumUxxd_awXEtGsgkHcuadyVRPSYZruqIuaFqVUH4ghTadJhZPbLCQ0J_QC3ICNqGZYTILfuM
 DO7ARRkkqTAPuE0Tv0PXordueMZIQUquvX7Qc5zabrvgXpUekqiOFFosBbKgxLRPEluRJfFyWAzx
 hjVN0ACkyobZm7KnHGzEtlfH3Zm5VwmcIqR9tPa33NVSEq6HfwYxQajz0SQu4YFVqF7g9Mnjs0M9
 NImMc22MyP9mipKz54qYTCu3G9GFo7o9ShMFcTsWCi5uCd8FuhdZaGITBYjKFRT3iIaKDYAeNN2Y
 OK6_dYtnydeu.FzNSfr24j_JYOiyHDyzn.XPQreCtrZQ_flCUnVRQ8tWrI.aymEVtmHNAmfKb4pV
 R8wnWu7Al4l0E_L5cNho1tD41VCWieRVnlPpAJptpTcdI4fWWt0pl5JXSR_xsVN4zeM5ECt7zqn2
 Kja1JS5PYZNAnKZk1aSG6b5mRA_QsgMjENKNlGKznVYwAwjpkitBfkhHBGX0.4irvgsOsxglvAk9
 wzZVJdkw2NNNAi8m37JNlM1nXIm6YPprQ5CNBZYzBan5rlAXFgJHXhumpDMEFmj.K18XMx.qrsgh
 3ul6BUjvnB989QviD5jXsvx_bmwLm4tLq6VkdVo5kmttzly_6BzeUs7NWvK7s42qifTrazLyWtii
 eWs4NVFhlzcEyREBn2MRjxJ13ohmslvNYhCY5uunF3MDvRoOMkR__cxFlIWWmDnd01B93JOw3ipE
 d8.NMZToR2aQ7zqMcDnjdSwecm9b89E1AVDzSZSKzQzrW6OB_nn_URx2iwhfE_IG27ljjd45MSfL
 67NDRtvVoHoWTq9ntMLEzA3_KmWhsgNlEdAFmIr6fdsJLtf4ACAtiKPo4IYEE_iVPm58yuI_v2Yu
 TBUYemSkmUssMYl4xL8do0.aWy5b3DVdLOiB_O_1qiDPNVD814rkjRewHTXMgcszNrcHrcArj2lF
 XzUr70DnXW1Ythuyz.uSIw3X3KOqKIrtUh6kcJ36sahKE.mIJda3yrkBuRMJbs2uxrgq.m4RvHZw
 cuj2ttcB7LPqnIsriZoctWwHhVGiuBM6mkn058jRMKUuJ1yVvmahbUJGass16Pa95fyraVEZT7G5
 jLxlRpu1RsThzBea3sZ3hFpyG3fZi9uRYgapdIPrVRCLDahVe8RxmlGii54ilbv1jNfmR82bPguF
 Bn_1pAMtIyzcWb1B.Y83k10rVfhgIWio3AvNJU767QOE7H7UO_kuu8Kcdy_CuQfonbZFkcOP2i3v
 bm5Tcj6yFyqizgkF8GwwXi0vkVXSk8YuwvBeSdr2oakd4_G7rULxjAzbH_mspHSbNLJOIjxGOJKl
 FCiuDtHymDxrB2mlR3KzRR_w21JJn87nVJiPsHGmVWUjxZV25Xu3C4ZFpDJT4OaIk7yeXWZAczn4
 NheI3aqa7UaoR4o6g_lG93qZfrKnJSLkkEnZS_2xLbT6RNeePxCxolKmkWdTt2JJt9RhiOn98RCG
 fpY7XndBHd2hMy.JRN3UO5XnHOE68Scrl155s7nXne3o20wdWdnQ_4pFW6CwQjpEYV8_IxpTYUOH
 6UlORI4DpACCRpFk8ANpXxgCgRMdaNbWZSFqkxPlNViWidfLx2dA1VQSvcMMtsKCXmLSwE2xw38a
 Z2D.FdiMX6D5gyzHYuf7n3bLWIdEWmJSd5.L6PjP.ImSkiM9TxGMcsmsImfjRG3dHahRGDLUtmAB
 .TN.Sddh0DAuTzwWGhK2pgom6EOjpZd.cMSQWw9JhkG9f640Lrp.kqfCjq_pJeayqeqOlH8BP9jG
 N3byDqORKGKx2PH7G6RnChBOhIK_BH16PgFdbg0.M2EmKJn7vsBvUeULDctJOVoLFIioTexpConP
 2qdvDm5M4xwigkR7SySl7cLfIO_BTz4MWKhNorbNgo8Bg0CTADdJdqLA708fcfB7HZ8sQPrRMftN
 iX5L_5JcmssloZYer6FVOdF.CwvjezO7Gl2m9G7xerbWHXYrcCABPwZvoP5C2roE9lP7vqJ6Hz6i
 7ppH7o_KK_elowzylHexw5McsgLnKEWkiUL.wrRvjGOIzn7.zih.oQJ2QCAfRmfbzKVvhCTjb3Q3
 ElvUWg1uaBpCv3scKNvahOPjB6UuHOwjbID1rhbfLV4oufgphGLqytKRc_GAQS6eZxll4KHQllOc
 P_qr1K4O13DA5mHewU.m7ZKwQ398Ll4QCyB__1HEzNuPFGGamtcn3kSXy7EIj0UpYHomMPxH3KDp
 e.Jasebr6nn7LCJiOqaZLlUdbJyzV9k4emDT1_ZV4RoRIMWKjU.dK.6N9KV9svytug206SE4NlDd
 axcIFhsZGIS8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:06:53 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1448427b61f01d52f59ffdd0cb44fc24;
          Thu, 05 Nov 2020 01:06:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v22 15/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed,  4 Nov 2020 16:49:16 -0800
Message-Id: <20201105004924.11651-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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
index 4ae7e156ea87..3092568d5ed3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2600,11 +2600,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2614,13 +2614,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2717,9 +2717,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2777,7 +2775,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3207,8 +3205,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3229,10 +3226,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index c86c9870b352..20486380c176 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -566,7 +566,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1413,7 +1413,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 007f23797de1..6c8debdfd629 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2281,9 +2281,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.24.1

