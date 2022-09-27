Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6D5ECDCE
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Sep 2022 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiI0UHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Sep 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiI0UGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Sep 2022 16:06:54 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE81E3F47
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309160; bh=U0iTEr2KRh4MCaN30bnEVY+EiD1eYa7zRt8gmzPXIqE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZSGkxkTXEBLbphuhMrort2QZ0aN0rX4X/g8bCrzqFOg57HP6dmNmxahCKQxoQNqOT4yZmniYA8pQg12cPZVXLJ5ywzAWUWwu2b0L2RBsyNBTgkaHRi3B7aKjaVFXRiKgGco37b6DMqkQ5fxtCo33aYylJ7Wooop2zX02BjoDMirlsGEOhLykxOF+dwMBEmaB6/mezpipIDmnGWcgu40Y7EFPYbfHma0YzylQ5X/q9Cbqs+iYjo9t90Kjb6wfARzDt4utV9yxCoUDU5lPEQzGqEY2p9zDn9tqxPDzrUNIFY+qhImJhvMLBERa6+XS0N3vwFqALdW9b4X76y9RZJbPZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309160; bh=mUmcTURU2sVdBFhDA+/jjmsWgEQhOz36vPEkVO4CD0D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GHe7mgqtQLqAjw0c9667PCLiC+tvi3VhSuEzW2QtrvF5CNX/04/hDji9KW6cv+dJhOTqM1HZXWK6ZJe8s3JLfPHYyfKwGY0ydDOFqAUJ5H5AgwcihvaOIUnWK94ao16/OgtLnmNV2Fq/MBrjCYphUuIQ1Lde/TF8Gmko8F5LTDczR5kr+w+Qi/voCzhy0yF/W0TMj8F7taVX8aGaQAC+zQB3DrP5y7QCe97zOsgVOwWigU8eNTy00ycKCxdIDfl2Mbg2EOETkwWPNpqE+1jhcA2zZs2nOybV5lFD5hBf/u/BVT2K1BOqDknM+IcjOUSoVh2fEVOKkNCUhDYxtm+00A==
X-YMail-OSG: sSpgQmgVM1nsq3Ca0Y5AZwCThumSZjKfDo8t21KurnDIPtwxfxIOqP7aCrnYgYA
 NK8A6c0b45h7odRSqP5G3EIZw5tWX8RuYjk90lyFFJD7wK2Bv0Lv6o1hm3FE75hf86H1TUC6bUNv
 8DAGhdPmNJoHex71VwsWOAIVuT2nw8UoIMiFC4Kmb29_jqgu9Zk_7A3XibbPaMPNzNYESp4g_yP0
 tssXhZPIDHiCUtfxYVOiWk1ts3akNV21EV813r625Bcf3crBROXVStdZP18ip5gy2bf084bpyuLB
 IEw8BCxNaK9fAfBs7yo1UFnsLEdYSeG1qSs1QoJcI5l5Gbk3vtPcns5tGQ6cT7mB43YSG4WO_HYy
 4o9SDLeQfXyr_JzkWLZEYlS7iuaEmmZwAr9SPgBRLPHdZxRPMvy5E1A8FT69.x.st3pBkkj9e17f
 0oJXFIDWCaqmdjMxdYt3PE4zzvBlaQbr9Qy6zmojkPNkjs.4hep3Qqx2Gt9T0Bi6pSwResfKLHUn
 HlajICg0gMiJgt9KH51WXmHJ3KAEm80oWGnxdnE0I4l_djEo8LqS54t4WQxI0ExEi2HktsJbA1FG
 4XTAqlI.xHRqms4MeWozkm37jjzlkUMBDQ.bAqt8Ef1XAZfTfTjF3HHpvizQgbclZdimw0omXTcL
 uWoDT7kcvP0bpYirL4PiaSemB1YgZl5DU5.LPJUerxKvpRDUYb5ogCQTaTEugWTOnkZpDwWdlALb
 tqouaRMbxYYmo6n9qSzeu04rjaq4RP7BNMslFsQw.oHEo9jQGRB_JpekxixSVKqVmRJTmJXWCDHp
 cb0JNq0AwhKcmmYPSh7T35Ty2RR9Iv88ARaLl4be673bBDUwtLT8iiVodyQ0pOBdepqKU4H.BsqH
 lfiS5S0vwvpwfaiwLE_7rL1Nd8uTAvZvs4nGRvvKKqRbXQ8f_kYPfuch7ED81vIBecw5H7eDa_xJ
 uNZU.dp6f84_eRDU0iTTRfQ0mr6y049Un4jOD7RqeTAqLT7ZtcTqs90Xg38QE4PpDz0TnUpSBfXD
 csim.3KDnb765NIh6W6ShvyIPPwHn3XjX0WuJTVNm4IJaI_QXwNNSmKNWd1B5QUnB_8paaitS1Rf
 8qaS.3oG6m1CYLKkPpr.O11.ScBQdY4K1q.iY85Qy4UPwJ4t1HnyHlFt2O7NCQe5DITcdL8IyzmD
 cBnqTUUyb9gJjrqcItLuQ_kAhvEucbi.2UxKYYb0Cx0Yo0qOFlhvmmzLvGcqVWZJS0AGTw5flMqK
 RihPyzqOH0fFhgly0GGpA1x0MLpunnyCDfZ9YnqoENsPRINCC4aPh2y7aGN8dCOqb.5.mtS0zRa0
 xOIHqrQx20CUIsGWjbBBCTqlGwVeLQktltrrNuqENcibesxUR__Xb2xXBr_yr0H3k1zPdnvp9iZ7
 G3WaSFmx_tRBVhoHAbeV8SDCaaOWPSlGz0.19lhb3j2vJ_5Q9UAuAsu1IpnvcMKpMR79DAcHB36J
 2jWIOM4oX0b.s7AzGTXMI2QSsAtZw9kJ7gRRYcZMO9YTfQMX5y66d5UKuLVIIJo0OIabRL2lXM56
 n1WsL_bOrQ_MX7cO5n_6r5XMqZTWJRFMvlCsXqc5J66FXjAxcOJ0NMX6BXBP1VB8TBHSgW52vj5t
 TI5pM0GA6a6fVaPT24miVqytmGc5GX8Sj6_aD0HFZs06VrUm2Pd6k9yXZS6paPon1fZb0X.ZkHn2
 maAFqPT4l5QnURLdJ9TzXqX8NjL5gCrS9zeUW5vLdwIIQaEw81vuBKLq_I.m.LzXD87LE1zMOkjU
 H_3pUKbj.Gr6YIsFRQZEm7u2v4xas1FTT476bZ1lfQFGTdavSUR0IgHCXej4x3qOrRx0eigEOHWO
 IBttzoBvm7YcnxvnjxhxL_lY3NIC5n2LR5yYd6Z7jruSgW.AqHI1XfmjsDE7Q2R2Ho0RXqP5Vzk7
 LAPSZwwxoQC9dL.65vjIbpIpQQpyESdDkFfDW5r_Bun3GpHI.sfwq4yIO2VjHX1LPOuW.NTU5naO
 3IRhQ_K22FbaEs71E9uKmPlkdSXZjYn88rmodTM2JgoQthraqLt7ZsKMcpbY5NU9XTg3Sgp2RFYV
 yQ8CfBgRmSTjxIpIWXncTpR04jeIW4VYO.nf5838_XMFif5ptLO_IXVD_fCh9Uze2a1cSwjf9GVH
 hjOU.J.kOnFrIC9DNruA3hrBMr9I6lBfOYWpqIu6PTwPXWliGgqet3s8Q2a7BQJ2AZrXkvdnMbnQ
 BKFiMUmVEntjBuGLwyCPK9vg2KM3JD.gblu1IJU7MhANK7I_FPU9CU4AeXqSN7A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:06:00 +0000
Received: by hermes--production-gq1-7dfd88c84d-h7f6x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f8e196d1098f8fc47a5a474327d019a8;
          Tue, 27 Sep 2022 20:05:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v38 23/39] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Tue, 27 Sep 2022 12:54:05 -0700
Message-Id: <20220927195421.14713-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 4a96e06f4827..515ea278a200 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2732,11 +2732,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2746,13 +2746,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2848,9 +2848,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2911,7 +2909,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3337,8 +3335,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3358,10 +3355,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index bb548f71a824..be935b8d7df5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -642,7 +642,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1525,7 +1525,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index cae35e5767ec..d57554ce386a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2412,9 +2412,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.37.3

