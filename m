Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C792505B71
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Apr 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbiDRPnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Apr 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiDRPmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Apr 2022 11:42:53 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FD34660
        for <linux-nfs@vger.kernel.org>; Mon, 18 Apr 2022 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294486; bh=At4+NxZXv0MZomzONJVkImtyKnD/GEtK+yc2Jid0QkM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hXeK59YACZjLWOMQj803iSWV8jcVcorn7ovF6z/xi2i1hEobn31g92tJ7/0IDu5ezosJW798gTNDu/iyp396QwqskaD238H1eOkp5u0iDOG4oVmQa/zKL1xcbXcDPKqdpU5YMz15Kpz98T48k9JPWzJ1pm5RQicLDnZ3vOxs4XlPJUuir0Czg0m0p7Vu6V0wapqfCOLKuaap1fmFxj8Lq+gMu9TvEL/L4lRBhHEi9d11lslHH00OR/Fdr3t2D6ZynphvG2RLmtZ+7t45vBXtBNS0Q1AnAd9AE3GDUHpfzOv5pNVWwuSCZvt2kUgby6S6vZUP8IxsPJr8OyLDvsCCWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294486; bh=THlOm56qqLM7jjy0oWlv79uA8dQtJmJQAV3MybDiqEI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=S79kxUiTvDUqzeDjNxwMfzaLdUwRmz59BgUKvVzePzbTT+FC7mEmmREnhK8Yl4P75jBPR2WmWooM78cHm3tOnc8Z5VYIwI0ia0DVUpOcG8sMiMG9woAQqhhD9Zpuc/oLjNE6SMIV/mCLspltUA96nQz1uBYKn83ffKLYJhKl1nTFRngpdx8QT1uucfTzfLwAEhQNw9Q2HLi3IbtVRpIhZK7fLDntMUnwjhrbf8UoNqChnqMfqftCSvztyNdlQrBft9SthGV78/FWFo07pWVgzd99PEHz23BqE7+j9LvpSFP+615o5dGNcIuM7cAHckSqN0PMYWbyYdlmy0RmrItD1w==
X-YMail-OSG: ufkWR7wVM1n7OFEt.pWhiGRlSa88oZ5wh5LJ3zGwE23j4wzdpLB34OZNa6YOms0
 g..BUGMZGdpxyN8IDqWowjOuAHIM527Za2T34KZt78L4syj5seunfqtRpqjxDDg2NZnbcLScVDOv
 rNBCxvzlnaC6HIEI7BP9vG5UOjt7HC6jBVUYFhIk2s9dJRkIkE8HsoTfjmU5nbQaa9pTv.C8ZYP5
 jLT1jcWI2e21n0hyExpXlRryUs4Khp6d6cKDZ99Kzt23lLZMs0xYwFO7l39aQNqqrV4vrt6W15gl
 Oqetm3Q520uG.e.7LHtJRPGqAnf8B9BYfEy05hOyxkWZ2eRZhsvcPSIxBfcT3Bi3EQcVVa9_OrAo
 fTvA9ZlowqqIWs4wa7Ct_i6Ru3VrdFWlTBZ.evYbvPlrMURuh6dtKUfAIRi0F_vAtCILG_beCcLN
 0kpIdEvMjLpJsNlg7GOUFEOvWnnJe02SfbnHyw9wXC40oEVbZMtbj21oz24Vy8OdE1GW2YQ2VfNP
 lk8cqgZyUXZOcKN5vsDsV8OQG9DvqQuwf31GAGulyYM7I2.SBlDmrzEdNifiWb1bEes_OWmlpdWA
 k8l0jnnNrffxiY21cWa940r7z4TVWqprFGTtN2v2gHE2oJkW_3tR1CAtrr6BTZ_hKLMklNM3oYqY
 lRcwBykzrPMwlwNv9MrX_2p1VuVGDMaPVjci2LgDjUUlZb9AVKIkimMeMdd2RtPZcDf7sAwY.kOq
 EyPRg0YqkPScouJqSm0y2xta7A6gQnrLYSm4NQ7WlmodlzPoS0wILtsjEVPSQO9i6q5buxbiLrxN
 mnOTTxK1HauMbXimIxhn3aVzOZZErk5KBkHzOZ.Ayn8pSc2w.TpJkFR8BWZI6zE5bVlox2gHZaNZ
 3OY5BR1t9C6W_uU7z91zJKTXv5l.UI.9htkQm8mBngYCSbdTB9aOv4o6ieKbWLqGVbF_tSl29xPE
 buDckv.R6iOhI.hjdszgIbfVmLxCPAkUlVAgYiKCSARJCfNOL2vIWqxtWLNl8GiE7o7mkjIFYS4g
 ctqAZX4IyrLzktTuMmMOflpMEZ5m7_22OjQBO5a0np2cnH6RjNIlQ.7JWBa.boq2xVULMZjpZXR3
 bc2xRbeHDb3SXNGqOt85KgFWhBheMDXakVx6.KYTNt4C0uyLvw6eSTEDvveBKio3JlUXx.MzJ267
 4z65xhkLcgtC3RST_WbQ0C1D3163qkrAVXImYumEDUnebTP2Jg2vnKNwnCWqItJ77K4Yx7N0ZTt0
 zRe3I7keXi8YQNEUu7XaTCgVp0jGUJrxBzs9zS_PoylNKMNXE7pfmskPojcuywJRKdzasYs7Yudk
 nbMEX3TfHxlkXYH1QRcrdvo4AEUPPQC0zRbN6ZYslanvC711nhuTowdUKvs1HflqItYCuazQk271
 cJMqXnYU4sXTkfw64.bApcCB9AEtZRQoxZ2XVnQhAw41Tz.2k4k3JR..TlyT5lWZL79SCe5FR5J2
 fpcEZrc7vt6wApJ0A59Rs0I_nlzpJrhgJ6iW1ZO.TJ0mRN7nLjNxT53nGcZjLrdVjS2eDwhZUoLj
 WmhmJCV03qASl5_1l0fYHWycmwqMV9uP45CpXaTW5m2_tWU7HqDtseq3.HXSpspX531Eb_JTY8Ho
 fc8LaMNeJpZRo7M6IP4MzPZl5G.ZVAWMt.Akyc20.QBwI5b6yA6D7DLj7jA4bEplqRPkJ5RcfVMd
 SMBWtJR6iM0931NvVCcSKHLPT42RTHuwEbtulv21hKeO5vrh2KI47_urCstOmR.8QDCieUJZ8fiZ
 3Sa90v4dR7VtPl7OfPK3k4EbGM.XcKZn6N1OnB3_cA3HdYa8_KqiosKBLk5Ycxv_O4WT3faLig5d
 YuwfagfP0sqohS9mpdbVby7KVBnyV0HGoT5KEPIKnGVP65l1_plUFKx8JvTGAXmLBzdL8PrdJbcU
 mjFrFNIMJE8JJoVZO5LEGjI4TaffPIOUqqTtMPtF2kdzHVSWcPYrbllg1KfL6Qn2QO8LNvdv4INx
 rTwMVMpwMLEHrj5YdZo2viWiQ.vMHebunv1Ikf6LVV6igII3waB6oyV5DXgb1IMonQAuzfDeFiZX
 8rzbUOQ3bsiRT9FPdvNF07AUSh8nuC3up.SxJmuBMFdEm96B7Rd_WyUqr21VqMtdsyXNv7JGsVQt
 AbK54ChIcQ6LVAJP6BmvgG624cG6mA_CO8fs6OD378qN.Vlrj_e_wD7GZTD.HR703CxkEu7iojQG
 mufYvn.Gm6sfZ41gUXJhNthMG4VEzsshQohWyYOpdLRPTKqv1dcLqDFiFlHr4HJdEaJ3X4hZdqYA
 QZUeaCX.QByRq5_o7eJhJqHzVfkjWGuVdE6k8ghalTuubx1as492gb4tmWA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:08:06 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID 2afd461de5a55bc64b17c8606f02f3b8;
          Mon, 18 Apr 2022 15:08:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v35 17/29] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 18 Apr 2022 07:59:33 -0700
Message-Id: <20220418145945.38797-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 945b21f6ffa4..dc66f3f48456 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -622,7 +622,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1498,7 +1498,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 91e9c8341a55..64073d807240 100644
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

