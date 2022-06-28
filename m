Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB8755C5C6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiF1BIF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 21:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiF1BHW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 21:07:22 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FEF205EB
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378440; bh=FN94LEWzwUDDYtALZrFGtv3Fq1k9e81NgNZU/g6SJyc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MANiyw22EhfLWbwhyqCW4KjrClAoFR8epQ/SBuw94qw/oQf6cVgxRhBC1NwswLY5Vz3qsLgY/yXu/tqE0DCetJMu2JdEuE/LWEhi30HHcFrxdlef0w48CoY2Da81ze/KHJp8OhAq/mb4wbdueUi3eIcpxUB3p+M7I7o8rYXnjsHJivvYpWw/4JlsZt/sRJHECz66NE54hzHubw1CIF0cXhgyXpXqB+gHK+bdKgMBGt/vNLgOWDMqW+Ec9VInCInZyOmgnYcljBNmSC6pXDMChPahg6WPAuzmK0aU2JyWGk5yPe8bAkuaPHxBm1b9Wl2xAA9xEigSUWZ6nMky9xp/Pg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378440; bh=PYmmTdTxxHW7kUJqiEbzlTal8wzsRZE9Hh+8i/+6owp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=J8fZ7WJCb9Je4gkOv0PZMV4s4iIZLTQb49M7ir5EFhWYdtYQbSxdbNofOqFyc57CPTzQTuGfmZmU2McCpIvVea5IKqyZ2ItCIuF6n01j9yhoXtz4X41cNbosyryui1iPqjTsVTHTZiDQSDKN3LNMI+TFlMpNtOGSem2QRjlG2UZBj0ABpRnpiy45r5VLkRxxI1igJgeNvEsZPTzKYekx6nh9SYQNu475jViBx5ZSzyLrEDcxKR7s8euOqF2ws6l7gzOmvlaipPph16jx8TaaDkaB7F7x5JWllTSB9pp7m1InZIBc/6c6/rAfUqg59SfbsCsQuOhpUY3IKjpcsqycsA==
X-YMail-OSG: 4qknKVYVM1lxC1E1LYGsrZ3EESCczJB2g4cY1QZQ0kOTanuzq4onJeFYSUgCBF3
 dtmeZntkAWW_JPWYDE3oGeqyg27g2l99ffTr51lsYRNJ44JCctaMyxTdoTtKxYNR7EyjOnkoEHU6
 vEqnZGKv7cn11HqDCapAcK82W1atxCV0uWAfr7cAcvNpYPZietC7lpJo6pCEZsRu3hhCPzm393gB
 QzWvIEhNK4XOXZk4yR_FAxNyMVGr.JT4BtoRgVFkML84NMhudvzmQ84Kxg9Cl0kSH7Y0hLCZ8mIw
 zIkoa5.nqfOmaAYZ5mSFDdeFq6BznNnwmObtlt_i43sCp_l1AIldRFt01AYoGk.PBavGXNlHkHPX
 QDhHhWQxZZyPaoQSUKSUW8oQVO5wWJVgqORIP1EEK0_.8COBKdXBfqeGEr7Bnt.5IuFK6WKjlP9l
 cVC1S0Xzt9QAQZgoFwU3L53ocOYbGI8XH5zK4HW1Ei4BG4mZs8ty3C3JxxfLlkmUFXB8P8lZSdDN
 HQZd.gnR_w8As8uIcWv6WaD2sbtdNgRpV.LZZ._lsqOnxY7f5zUIWeBlRhwTwK5Bi9GNIS7uTzUW
 f5OPqnd4aDk.JQ50YQtN5SBfYx7bvzGEL9FN_otkqjmsM.zK_bqHyo94_Kqr.90G5wm6NDdOgclS
 8YDVm7Jvd9KpZuDhcpjdW0p2AXv8bO99xxdsRefQ4VdyZEuwoSCAUA9jhlTrqV2ijxZ8mqcqeTii
 FW0BGSz699U_45L62R4P_vibO5vfTB.O6mm..Q_quFAqJ9w7TYNBw1_KUWmwAo6Ib1_bD_0yXKKQ
 jww9t4JlOnxqc62lZx2k6PqzE6qbU6xPNCmFRJ77PzP7ufUTd.HiZcr_mE3Do128Z0J1jBDZ49wd
 F0OTWltgVC9AToWv9lyyEQtnmZn.Y2.o7FqzoCvpXcV4Ien69FKA1KVitWEI9gCdOAqsbZjEy3XO
 WIHBwikZ027xzhKv8vzt9X9vCmGHF6uk2YPasRpKfGC4ZN47gB76ufJRgaL6IDhdXtxD3NNbft4U
 YDFV_GscZbxhaeBikDF6kGxgACX0GlxLpz2TDKrCjv2alWxJTLvvXjaMozeAMfEHsT5zwsd0ED6a
 DzJ3NU81LxS9CgEjL2efSpcDejQ3FGP6szTXTLlE7EMEXm7YkfrjxJaXRg2WSFnYVEgzIYw.1t8G
 NY0uF58dhv0N2bXHR3gGFzlQBOjsLeInTPi98ZH0jvlQaS5jzmnck6azBUjMzd4zoEtk7vpe8Wwl
 3GJ7NXZMAbxj0iE1BdiJerYsCZ9ZBlRZB2LGo351_4hPyLH_FZwTPs0Crv8mEbhq18zawP62K.LX
 wz9NJdklHngrAr150Q2KWnIzRHBWY_UBdXT5G0SdYxEHs77B.BaGq3NbF_pWhevfX6BjGdr4kaH8
 HmOnm3K_eqLok_8b3FTj4AWAdaYfPzRWdVhf0cPYxJjaOP.NaZLefvzH5i7zR_3nji.J4FQ6nYQp
 KzOjNHUeC0.5vMz8LhcqaM01WqQE._StF9DB395FO1ne7E78GW.lf_ur0Sou70Gyx6LZR2B6Qh8Y
 nmUzv1YxBnX8hP.x6k1mH2xrqRPM0SmI7vlnAxMi05DQFmZhjRic7jUoQ0501rxfL_b6fuZ6FS7j
 x1qKs5dKDkW6LK3D3deM7UTNBIn.PSytJonQxXG8XPulOOM1SLYi.HQHnx8AzYQ1hl5cWT6G4iJg
 YPm3L1S1AC2CaEp93CwaH8PrgVOMLYXPUp3zLqTMcrMnDqvuHhpkr3WO0OflEwYJiqjae1NMMRKD
 OnAb7x2khsPBykTzmmjd.FJzryOeiJO4i7tHVLXJSR4LnfwdP_MurWwRclqjSJQezV.Wths6vZSH
 L9PB3laaHPzxUYk68K8Zr4T_m3mTZ1AxixymvJS6KzxHk3DEwXtjp0Vyq2N2dvOtvoWVUpWEePrH
 IhSYNf_McPc4nJtqKpoPiJ6G_kX_zBMQ1B56cWbQLR.jHsAB1PrVHPt36raAt_OuRwr.C_PRNNp0
 HAXPLAZgOdmij0Qt4FDQqkpvsFGLsQCpi7s774x3zuxxnLQBkZs3lir_l_qdIZc9YHIQBevESJ.8
 n4RhAab08WWM305VuthNurZC2CIqMFPaIl.7l9uJBKzFdQp6poCWYggCByhF8UD39AbIH25zLJo3
 tevf7MazrKB_v2GxAywSJcmgc.oZeGriKgZ5cq60qg5yDsNXGdHULFrGwyR7uTJXxOkmBSTbeMk9
 YDoBx.rXqV6A02.DR8hP0Eo3J2d9icYcIkIug5khMnK5TrGjkOFMFa70-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:07:20 +0000
Received: by hermes--production-ne1-7459d5c5c9-fdkvw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b15a6d5cfb14c238c7aa5ef58eb279b;
          Tue, 28 Jun 2022 01:07:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v37 17/33] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 27 Jun 2022 17:55:55 -0700
Message-Id: <20220628005611.13106-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
index 512ad208d62a..3e42738df71a 100644
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
index 5afd0148a1a5..ca2ed1909608 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -624,7 +624,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1500,7 +1500,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index b52c7c55a092..72df3d0cd233 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2428,9 +2428,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.36.1

