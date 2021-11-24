Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB945B1A5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 03:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhKXCFa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 21:05:30 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36851
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236590AbhKXCFa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 21:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719341; bh=OHIUENr10+7RRA/KKA9Hs4E8hg8/mB4XUM7qW32AhuY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uaIrEQv/EOt02QeIHXcT0YJarSwAzX/0130gAI6KXlBQ2h8bzcIhTt+69+oSg6ygNwS2W4uQRkjU7fNUckQbDIHwqwq1I9IBf3eSeTJD4H3z0coSv0sRbqpea4q29p6C1JmcxJdea4rFT4Q0Jf+/HZ9wpScXsjsYc3CvNkbfYWAKrO7TcwMyOC1AOwX9+CXQK9mxWeW+IdDFRwIj0ZUKUmyCaZ3eVr7n4TtLe07fLUe9Y/OW0g51JLLMtZMqMeJuZnVLoQQbqRk4Z+cMlk8dhFJavNMWCUOGRJiN+gxZS/lu4uoTBJx0x78j5O7NvOkbP1w1z6fPALxNwhG2ECcyFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719341; bh=xX1jeZ9UhyP4Ggdt7wOmIp4tFrei6yagfluje3kqPyG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IruuJXSoLNXRZBFIr9GQl7p5ZJurAmdpwtoDBmf2Pj12HevyJlFabtKU5M3vhI+zu0BTkJR0XcE951fB/CSJT/2qrl5i3lU2qurQT1hps4tQQjF5scV/fkLXJ9wIf1MwUdK81+xde/HNSZl9ih5xGs4W/JtrJvi2a/sbYzXqrxpqZrzkZngVnC3yH9V26wyo+CtRQdljhJkHJwYe9z2FFWsJuimFaVS9IXbygA5utvQlS8X6QBIejEDYFgXfRUELG5jbcrEZN7l2IDJePpc2GOOjMjOrXTYdmAnbt0ubIB6nGww7wPflWMkaQzElvQpI50whm4CWKacnpSgV3f5JOw==
X-YMail-OSG: RzU8nKoVM1mVCOyyOEE2nZTWQODZBkIoUIUkFL14e5EmGYgX_fTSgy2Oipyw3X.
 D05nFcVRMrlPq1ySHPGBH0fWBUtAhSmPM2YBKu82DY_Ppr2y5vBLPC2_N.dpkaWCumCUzZQw9mKt
 5Nn2tpmnQjCai59l6Lae3m8U4sk0E5IQ4NrI7VWUog007rCizg8cI4c8NeJVfTNVvK9w9b2Eq8SW
 YZn_X6Dyz7SSZt0Otq1AsOcHS6KuLiVSuScTJKaklwvkqsq.RcwxIMuhM5LYmkLWjfSnYHGkG4GO
 7HfXgsOi1W1WOKtpclqLxYR5CYyyYRf7Nlp_w3gTCFV9EchNDNkyXkr0XzFIO9zzNTdWKbgdELb6
 7yg7Kn3XXaDzbIxCkmHQdXgxOMUld_HqnZYP_TyU4583uWgftM7Sk31MQqktRcDu7AxWpMhJw90f
 RxqZNldoR7pYYkNSd.Tv1Fd2E.hpSm5jjWMGQz1KEMSznxDF6azUW_dbxp1zoEP5OkE8Y1vyz05o
 uDXejf7bA3qjj70Wt9tK31LRa6RI8sP5pS.MoklzOT4ZYwy6QRzH1ETR5RXKToD4y_STX3a7wRIs
 liV9Fn29uuiaDKOTkoOwmQL_d2QLfD7dAMHW61Vbyip_l..YTmz0IPtYNmTWK6FELqsOk8jaDlTq
 0e4_2AENVKwekaQENeLUfrkRb76ogVN.32Fbinzb8bUJr9tz6WTWY0vP_ag8FkmeQEU9q.T1Q211
 gAPTA8mPs6Fwq2exCq8DG.9VPFHN8BTHctXMnGjU2ucY5ez6gYL8wQvoWsIfnMuq9nKPsK5kEy5v
 YdaqiUL08fI9tjK63f5a_Xs1Cc6RVGldjcaLWSIG_lETmhNN7VbvWGnwLWDrLqYEJ2pEVQzPVtTA
 mazLiZXoATrMX8y771FccwZ52igHnWqDIq8C30HXe5BQohmCJ8lxP1YIMuJzgjrIPZ.HB_AEch7Z
 dwT6Owcqt1GC9CVsDZX7DPmeNDU3Lmy9TPryZMFOhVJXiqqcN0ocVGyRtf1ycaWL9aa0BVRpkpSm
 s9ABVa8oAdUHwwTkQubsi5KzDasST._oHrZW0GRYwu5kQCSK54bcgzawpsnHAKhC9ozWXLzLChzy
 qWWS7NaaRcOIzcaeuK.OLRXzwP8iecSB05n1coFwHIZ0V.j8rHjjy9G2m25fTrCYYSVL2lS2D7fV
 4YSVtb3Lyp.X.MGlt.lJh_RCwzgKub...dX5_q9.WNvaGz5REVUmo7Mxu5sZzhOgReKfROgI51wb
 IHnsqcP4U_CuC2fqZ5QpNqVWXtnJHBQ4mf7KwdUCN51knW8V9AmeJb87BwaPeYCfj4FUZK6V0euU
 sj3Wh.NEp2qIpd6TJzfGR7rWX_PoTlB.V5K2BXCgbcUBJogMymnbHlWgouISqAlQdijhs0.Gcedf
 nYJM.mRD6i.zk2tfdoGCPYtLQ9GqNWNn3NNaTDvgjmON7TnQ52FV0veAmqGRYiqy3lsvs9ksssN1
 r1yMDrZgMotHoRWY0TVP5Fu.a.nbGkvX7fOeOBfpZPejpMpD.gQcU60.2B6srXhbOw2lj1iCWMJu
 zerZvwkNAyI3l.sAxamBc22S0lCsb5SyIVDN4AAuIb5jc1wZr_p4mrNs5hMgtrAqdvlO42PVrf8q
 JI.0vCC8KawsAhtaGkyIBf0Ig4ESngXKyk3C.EvFCruLHaZShVCKlhVpKYosWNjXRKW_wJ61Wdpm
 x7jmZvzSCfSvFCBnkCCHogH6ke3snvdZpAHfaYJSl524FGd7KUrARdu4vHJVCMH8xWrvba8PXw1c
 KrzGRKTkY0M1ON2jTWQum9iEo2jfHjXv9ilJXGfygSpDuL1q_hH6Bz0Era6qPXBN3RcnSekA.j3c
 dysAavGEI3.jj0aUjZYAprj4JpggZGAsOXWlsgVFzwkJS_6dfwTt3B.SLx_Um3VI.d87BCvCKbbd
 tz7eE4BrZt83.8w7lICopxZzS8bxwuu0Ty5S8pYkX2GqRn6qJQTX1HboAi1wF8t0HeaY1mBJBYrP
 pWG8PskZ8o7BYJMDPIITfWaq.x8FE63K_1VYX_xyZ2bPr_JD6Gy4DPjvbgDr2b_pE4tyxloCdVSw
 XhAtO2UAH3F_0WNmFTwZY66uWOhgYU5lXACR1m3mRo4Zgp1LFYvtPekdiBnscVPhQJfhtyeDZcx9
 nd9Y1fnRjCAPUT4BcCBrYbuBrgePRpKgCLqx8BLBYM0kYKeiu2zi92tEn36dqIw5rKSo3wdIFtWl
 IdeYW8YUmkaqubvpuIiULj0DOwnIzQ6Y1yvheYufEWJoQJiyOXwa_AQ0InYF9qZ2r23CzgCTEbbs
 olzefMptkB7B7hYin.lI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:02:21 +0000
Received: by kubenode524.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID afc246db926b33130748a9cce0475ef5;
          Wed, 24 Nov 2021 02:02:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v30 17/28] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Tue, 23 Nov 2021 17:43:21 -0800
Message-Id: <20211124014332.36128-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
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
index 89d50a7785d8..25e592b6ffd9 100644
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
index 7d9a45bc5bdb..a35618740b19 100644
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
index 989103ec9533..e776f71d126c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2399,9 +2399,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

