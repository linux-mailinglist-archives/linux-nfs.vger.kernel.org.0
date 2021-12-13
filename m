Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E2473920
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 00:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbhLMX7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 18:59:25 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:35430
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242149AbhLMX7Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 18:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439964; bh=7aljRJZOQnxiiyHnbK9ZxaikfmtFhGou1fAGhswXEYg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XL/Fntuct5OnQEcqyey9uxeb2AAsPmTIeNpotLpAyfZMnVSvmUbRH9EbrzAt1pG99xzRW6jCot5OKyAEQvh8pMPHkd82BNCI+awXPw2NbDqi2QwYz5qe6gH2Xxy/H6hiusEa3zkblbh1HWqDde8Gb3L3uECC/SgV0VRK1N6nxcsWNWu2DmsW1O4sy0QvwaLxVhqJ9Suo+3OAXgls93Sjk8FKvpue6y3AaQGkblrfDU5Psl6mq9ABD9UAEbviHg1+mUUBUFVVQmeEGZUd03l/r2Es+GzPu3dXnXoPJw54XH2ZEnuA8JCuMLMyA/dSZb2TG+Lyct8pytIX46XzjklxHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439964; bh=OJb3oQujEHudylx0PQavH7jpX9Vcky+B3oP0slc6k9f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PgbZPERcwgvdnSuYAjedj76GRqF6VKQtcF6vq+/OdHoPACa21zQc6JCdPa2o5pFyW31ijgtR5nJIsSbxuoIphF05mut4g4UmUkEJaOqfQfuOY4eo0kBXEZsn/AFscZMOeOZ2jBMX8tpGNX1Q51/1KK6rK21aMFnpAL4rquOoXlUaKqeitGpQ3ssCX7JdhTZ9B6WWju1INXCkCOpcnGZ/bgsCetOF4J2temModSS40a3bCDYoQHMCsefwtABXHiJRKvlXoFBNEKVZkBQ74qwxiaH/txDCm2Hrn5PnUjmXOl3LTAKnDvrlNa7G/FeLJBUotLdnd1pFwJRpGy/DthOc0g==
X-YMail-OSG: KP969SUVM1k3J.h_dKxei1ZrcqE7ao3ac7.ZzSVXJgBlFIggNAfAFpNYRmgHUrX
 JDLVRkAaQWudgNkDydZ7O5XxOVEGKf1wPkzEm5_t5M.ERhmhDYaoKI1FtGH0v4iP4pYiWnffxGR7
 dAXKDln8vl9RPsPrGD7wnWMdGJk.GurBLjOPWUadcJZkt1nksfBaMa1pSGUuyGAMzg3hkObYw1Na
 lBzGmwWYhYezQA2E6I5HeiM5.9AfSVLiaUlELXrMEyelybcF6M5D2OgJ0hkcvkCXG2QUaLzMvoUM
 114fWQfCmaCnGWOVRKqNyajFxJ7d7HuwSLhVdoHmSjsBeTC0H0atfohxXmbhOJjvmVx_4XLnOQEJ
 wvBxyRaiqlPcTOKv74H_xo7Z1YsZs5D8xajNCS5V9asfNvZv6mTaA7VKNEMt94mG6DfUJpmIJW2C
 2k_AC930OHJXkuQtItGJVLaaJ6CfOhBD1GQsFbtswkbFLBXcuyKUig7eHGQZ.V8N4EzasDZ.FrdL
 jUsHIyIcYu9O0.CzIO38IiyFjiRrUyqGz9_AcCdoxXepRQqwhVrhKHbsYjgCeDE6ebsz09f.KWzb
 9U6fItHWIicA2CBK8Ss.t6G6vgfc1UyJSTkChVyKO5jA3N3w9m6kaA_SIK_OSQpDgHG472u19pw4
 nel6AI8rOC9uZJ8rJvDGiJ1xTJYmih9xm8POPjQFVkjUrwCm5WP6G9tz5Z_JUD27XI0tqZHoYb8p
 M3aLr3V.2bPZmXSWXhnUSBIpzSF953dlMX7Wwm6k3TAipKdglO5ul8TosHPs0j5VE3P3_0vfB6WJ
 lY5C3gFdKMNR8VLtqVeQ5CAoJxBAQlZ2Xu_eUWXK3eDOGtQ4J3MHsGvBE9gHarp5CnqHWp_BJKcd
 sPsb6llakWvaj9RT7OpRUEpLJ_tzd_hvwmIS2wZW1Caf4JuzLapIwwWj8VGtqJfBUiuQO6MsWJjF
 s8fHP9gOKVV0tz9RfsiXooMQJ7aZqk_Wiq.q.GZ.cg_ImLkDoHA17pfLT8sqqCIa_aUU0x48BWgR
 pxqq7zGloyLv_RKh18mjLS1hyG6XJqwwodIRrwRsnSpeftsaej9bE.mIFPrJywmLRjgAGS6JrK.A
 BGzp1ovdj6TJ1o6z8GHOjZBZcK61qggabiYUy.4PlUJNXyMal_v.WYoUrltpFNinxaYKwgCfeVkA
 VuLFO.AVWcaub2FiPKGzVRSE1qxX9eMfUFyqlVhXF9aEREaEj2F183cMFBAwOnfR6nldzAcnyvHY
 i2SJXxK_YXqBPwAuBUW4oEZWlztjN40TGVZnP95sKaHxtjh05_bvT4J4Fun2NUtoz06MCffjZ1Ed
 Bmj4QSPeeS.jtK9bfhY5f7f70NOPTTUfdHeKHBR5WVocKbYQayko.CaQgTMHFPGIVg7v9BYsYPHo
 UYwdXW3y00ml1svhdGKCO2mvB27eNrQxaGbXmpVoj1jw8olEn8zNPEgV1r.tHzMgWfS9CF3jdi21
 zOHDXHrEwIyAEwgBuMZUwLwgkpckL2wLx9tuZ465JwOedOt7pasGKku5XYTey6yoj0wNQtsE2teq
 VwOATQwLHsCEAVIc.Cv__p3o6TYDTFXpisLTtRyQsJfTDn8nAhJLXdyVAuJXoLVJuK21uWdbZka8
 U006PFXjB3yrKcsf4Iht16z56Z0Z4h_Y5.f5bMRMM.ENtP6RFG7VvAqKhl.tAbVHqXSawjdolccw
 qgnhNxAAl4tmWMpairaLxyU0rEd.MIxiRHyHocDDsb_OXxpUe2jysS4phAbhVg3C9quSb7LW9RSy
 kYHJFFrOaGQIWqSgeqe3C3jZGw5O5nhnp1Vy4RQ6SKKNdD5OInsjNbSOkFVB_kNPXIG_3ML2e2u_
 F_wV3_BamTdxPHLKSyzacapS_wSMa9Wn2acs1mnlyyG9oYA8sNyee4vUyVs4NQzPMGkDJlgOjme0
 U2hWJbCcMSHBNWCHaXQiAzGpyZOFG1q3AJP0EQ_b4_Xg180XOzSE_Wo3UBbbJLJa0R.LwAMFmoqF
 6FO16Y.4IBj89YvuLf0Kf4MBs9FPdDF42k9qhbF3j_yIR4kBFSMUs35vtf3ztQNY2G6ecZeTJCMs
 QjnHy2CX8DIBw9ubZM4dvZxbwnq9Xc.CQ3VtFrbMfGQ6mL9IP6WPav4Q.sAzto1Z5jpZ6NItfJnj
 KwdYCs4UkvwVZ84uBGkIFmRHRKEPlFH.HG6H9vQp.MzJwk7c99gaxZ6Dt_.oNCP6ZpBk0GsuXNZa
 KCTUkKVcOCe.yiatY7NJy6V7vEyPH3RZEfyGxUHUzIecw
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:59:24 +0000
Received: by kubenode530.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0dc0dbe9111101f136bd150c68ae8268;
          Mon, 13 Dec 2021 23:59:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v31 17/28] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 13 Dec 2021 15:40:23 -0800
Message-Id: <20211213234034.111891-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index f96da9ac116a..4aa412e0bfac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2724,11 +2724,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2738,13 +2738,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2841,9 +2841,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2901,7 +2899,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3321,8 +3319,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3343,10 +3340,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index 3c66edb31e14..e29d2894928d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -605,7 +605,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1487,7 +1487,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index dc0d4ae44a64..1b9e1189d74b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2418,9 +2418,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

