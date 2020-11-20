Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49DD2BB6FC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgKTUb6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:31:58 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:37090
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731284AbgKTUb5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904316; bh=d9qjmRxQpH8SFhboWp6UhmW+qc4RaLALjgtGk/qje80=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=R4bpq7JCL7qXKAxORxbjMv+BR12HEAk5AnT061PC6p4Vm4JoZcDfPGTI+NPb8c4ibGaD9q4e32j3KIlvRmTZzpr2wugDjxX/Xe0sjUesX7IK3TmosxQYS5cdLGIvlQY8yeqkdZ7jpV1+4k/0aaiLYkW5G+X3R6VbQfhSJ/j3TpsYZ5sNPo28wVKTIYEYrPiYheuTTTN5fNgZjeMvL9KDCGXm0GF4G/IlALlidhcgnU5xwDrz2TKFJPhMNtqsyEP04TsCPzUHgnCjaMNMblpS5QJPBYNd5jcN2eu5+mjKAQj19Z8ETYzsrdvUPeJRS50M6XCrF8ne88kEqhzlfkrKVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904316; bh=FNKerAmDCJR5/GgTsnuTczNqYxp7Xktj0s2i9RtQSS8=; h=From:To:Subject:Date:From:Subject; b=KTRljfEabFwWpT3NEi2pnD7fS9Hy+MYIkCiSiZ+MS1kuGwFy6emu7+r2HjVYLSoKAzU7f4qV/bCa3bivMM7YOQBynWujBsE3gXJKpRJNkKCJNhs/EU2GQqOkb5Dhj5f4pvowkKxVIDY3HrsjQbKZC88ZwJawLxAp2aVtn2QqtIUlc/EtvA0eE9d/UKXeBFGQ7eYO776CgKTyImShI9/m6ahvkBsBnG1W5LMc9SVgvrnS3bhI+ssxRsc7EqcXxs3pWwQtH9DGFa95JxLZWZQWA9LhXd02QLWkrGG7MNlzL1+Wr7nrzB1BGVL2G3Ok8E1eJJMQ/PwhI2nzKDCmSA3QCw==
X-YMail-OSG: aw2k8_EVM1mjkq_LMVkDeawCxJeTa5Jx1T4wnMwi.cHf75Am7Kh.MXlKPF4kYGf
 BeVsa.oLV1.XgSvqRhap9nJoVXrsOCLu15bKWMpiRbskJxBJix6VfXJo0IlgYidaOW3ZnJgNXT7z
 XEqG0t0qWDcVlvpS4lrGfk.G4wKw0r81BIHtqIPhXb7d3cE0BLe5xXWak3H_SUrnn0KvMqe.LZdm
 w9N6CDOaU5WNBB4lbv0A2KS0W2f9AKVkJqZrQu.JN2md635qGDqXyxMhdYh9ln5uvs_oh3IHAfvv
 Smpl2LxExmZHUF3hK5aK1x5462ucSpFRM9xB9lK5cdvPSep5Pmuo37gEGZPnHu3OKk8yY9Mv0sQR
 G62_WP88BkSPuBfipydWNTkZXuQb0h2ZQbNzBgr.epY4TzMh1Wn0X2vUdn7LBcm90d.CVLEXEhLl
 j_t.OXhSiekM9cEz.DeuuQ8vMlaFF9AJzTX2wH_1PaSjmNLg7tMjVLB.su8yZJKN7NVwI8.tbReF
 PCjvlTZJjctxNZRBJZSHTq7oGDnLRWfd6CDYbs_LSqioPQ5HF08BQOGF0n6f4IuQtI7KgZg3eNQB
 71xBG19BxRB1I65iauxtNAxrboj2VuPRWAzZJ5.XR8Z9nLOFKgtkJ9egIw2tSBp80JTQg8rd8xvG
 UQxBqv5_lB97EJneejFePZbl_hHJQVsMNve8cKdVH8S2019OdKxTxMM600WDUa9IIUjYN8TEp3K0
 5_Sxxps2uecxpzZ6YokKn4GPn7YasaUoYlISmladwFxTwDcsYHppIaiXi2z0Yb89yO3OXC0JFxri
 npHvyifrw_5RNs4Gof6m1PPXMwr3NwK.crlHuC5MusJwgke3fPeMglwGSKatsx.kqs..T6zHMHTF
 fxTbKmwznIgKYNZsAa_ALtDihafG.L4DkqJat.wFaVURTwcwmhoktDHzVzjgha68YfnH8q4.xiv4
 dpkA6mduA59SZZETbB34.Z5wBmiAxH18RK5pJ7TGRQ3Fjr5E7mdVDqVkdhMPPixYDU_QuYdG77gg
 qEFQ5sFglO8JNoPdvd3aL8MmjNWBEkldgLnZQSKepwIe58JFm1cYJWJIoZV0WIBi8loLoZw90efy
 4gti8.5vfowpx5pp3nTZNMwRuIpcTv7WSI3v07Oc4X01iwLKC0SJ.ERNiL4uosYzt5oKAIK99uRo
 gFZN5bBgj.6FTKm5RgLRXgH0.PMn49wfyKMjSrOAAgF5hokYl1zOYuBOKzR38o.D.3N0cSwiXnU1
 ZfInFbDjjqDZr9WtmXpjI.Tgv7xKWBqQbN1l.k9T8H2a75B0WnoKxqfPUVsNFQ_6i3ZwmQYCU5s8
 .VhBzVBXLXHVaDAn.dXSPQ5AZuzVJYi.Tz7qFKeH_zVh197hS8Z4T1.rkbE0Q4lNghXkBtlkhebT
 geJGfRtLeSUsIs5s8oU5dgq3O1rHuUV8WUiSFCGKaLUXB44f2x7BOEqhVCjEMuXPQ2BiCVvbZqFA
 yNH92Uat4GqBrcJ4NCxvFfZ1DJKaEZDtO.3NuaSu5xPVbhdDY2F6mBhyPJYsNfw01RAwH5OmEB48
 NnXWWSRavLfQSY3gAEfQ6n6e6pzK8x3A3TELp_s.k2gFhMpwMI1GBp97P7UyyC8g3E_DfckUvwjm
 gbbHJvArYUPtTp8WvAibsoMBCwwywrL_6Em732EJs8GbBtUnAJ9zkVfIGEboORJRltObBKBwNAto
 4El.7MFfsrdhudlHfyh64s7tJTS6df5dNRoUfUO61qqN86cu2F2Z4MkTNhAIZ5BLiuJPVWBMa2zm
 c7Te8QjXSSQCkb9MsvFKda0Z50kpeO4_Fl0z6rD4M9iYdc.JLY32erW8uFhgYLWuNGhuerp5DW6w
 cGmNh32jG5WzQNjEN1ihg5dFak1AWsOFrpUaRSFg3XUurWGoZnFz4tZsf4Zjm5MCuPFQR_TLQN.n
 oj0HEgPGuUK51wpFBjZ4HxxeIUN2.x.Rb2FzG7RPic39WGAHBG2XYx8F61B0LWK8t8lUCI.s3y_Y
 qVoq_7zBv.oqeZrTEJzNIPfU8Ar7lHMzEWPgyjvsCm7OdSHcCLUJ1ir8MfHBUdhuBSjEXCYy7oCf
 bJ6E6aWfvwE6.f2wyzZA7H4xsJ0Q8pz9M1W6CZ.nS0C_i8RKD_4qms5P3bMGaLQtv5Z_olt5SbAa
 wDYTpt7tkIAezzLhsqGE9BNSB53FyXIo9UqpOw2NgQk8ixyclq9PlyRPGmTffzWQsUS4Lw0Csnze
 3g9rre7oI2S9Q.SEDW.7Ksql6ZG8F5BuSZ0ufwkeXWZ9uecY_o9gaSH9.iewPh4yXMS5L.XZRi5U
 WgFP0ePTUHkGWhslg3xlJbljV7V56Gr9KScCRiafzM7d5AhE.yuTrLp_BEixwaLKdFmz4_MSf4d9
 _QAwS2vQ69rZ.d4l694RHiHclZWmJ.zaADN.c7upzGWbKL7kwsYfUm3nwrRrHXptbqm4X3h7eKvD
 .VnhUKq_AzXpf8v_Lowxou2DcdseTp8FWkqdK2aO1rt3HQKoik0YqTtiOdALJpc3TyVItOhH16vt
 Nd9pdtD2QRshPIwcslm8IdkWv2AZ5nm9nJtoVodIqwoSfllXn4N6gcKIy50_R5NcjQ2iWUsrVMhk
 uKLC0DISs2dYiGPd7pTu9pNxFFxe0ZKAbCswyGy9przkXAp8YsjUIggzl1tpfVAGXi6XGWBWw.Zg
 yRkRWgfEI8l7Q3QzNqAROEr.S2domBePUgOTEzAqIIAKuWGqGQGYXgnfSPZrtWS.vrGpt6CeO7VK
 .kkAVYMF7GwiqVVQFBYNL09Gp3y1JPLgJV7u31H.fEyPkDA7kyEunXegGNQ_ADzxBiHljk7LemIJ
 OG3knaw3Zcly2kiOOojGXa1Aizs.w7B1hIDQNa165GTUXHnN3YB62eGKnggaUm3QSQfXquHV4nuR
 3pA1DCpQU_VvljpVwkDteYRf1DIevZGLC6hMT09tCdrbIhcuGbWjB7ShY7HLXKPFaRpyr8mBclaD
 iNI1HX0HVkl5TZDtHJOpKAXF4AwZTvnDrGd4wnQOvakduCp55y5pPqXL.Mg6bp9bEygby2RONVrd
 Yr6twCAHIGbGTb38QwfBY8jk8IaVXi_iN8inD8pxcxJyyNDbtdYshFjxjPsQFGyOP8J0P_w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:31:56 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b88463ba9175d4b4904dbefa430c1109;
          Fri, 20 Nov 2020 20:31:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v23 15/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Fri, 20 Nov 2020 12:14:59 -0800
Message-Id: <20201120201507.11993-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
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
index ab5d2c9770f1..31c983a252b9 100644
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

