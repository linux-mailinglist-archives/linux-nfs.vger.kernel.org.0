Return-Path: <linux-nfs+bounces-661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AB8153AD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 23:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BF1C20E8D
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC7418EA7;
	Fri, 15 Dec 2023 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mhkm/OUf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390318EBD
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679557; bh=KFKWiTph33t2gPpx3h/moCpllvvhkv3otlJUUDDSqTQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Mhkm/OUf2fQjwomCcnoqyU/GGEOLbKnfr9hdb2SpuVcaB/FbocqJAsdcIZOmOrRULr8zAEsLQo7fNWpikybtyZMtFHzUgOLIO2GrNWRgohAvquA6nGGZWeOwf8E/sBBPEj2zYglBgJIr6sPb5NRFiPJAm6Se6DTuP1SESTMqYhyxubQm+Uc1eFNUBEoEfFr4l9JxyXHinuYVcNO0Aw1jU/KRMJ8mmmslpvi0rzt6MbLN43/sxHAPasM6wSWtS0Sv3ldSmHVZEpUWhPgiESRIpaviCHodKzZo3TDBmlJUdfRhh0dO7yy7/+Jd2TZaHwbdPDkb+Cpk6V8dsJK2HaKq3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679557; bh=kvtU4Ke5VWfygsu/rdD5fKMDduGb2OkPpnL+dTzge4h=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XulfTWarUdfPIvt2Z9SC3Yhqd+sDIL8muWuiS1c3RO5KYO2VCpz9RgqT6I/jAoFhIKOWqVa6E9hJBEfdoUQqAtygEGSPn1mSsikdHgwpbopfw2ClXF8RlUHADUJqFrhemSh20056E+PtDbK7Uia2PTMpkZuuqyDz/PuvP1UowCbwJb/EdF1vbw1x7Hgpr1pl/ne61js+Yk6uU9PUlVf2q9ZbtS1M3ycImlQ4J+s2e2DF/WYGD2QnOIjkWfveHgh7DLAPkdyyd9t9JdEbNdbZygQkBDQ6bxNxt1EqPp+hdjZY8IHXGwsJFIdZBER6Y9AyoaVEQmFA8jhep2aogc4EGw==
X-YMail-OSG: uJYSCEUVM1mX7vphcRMEWTrfZmpymynG2BFN9EAYws_cBSLXypIYkRa.yCz_0bO
 4FFv_yMJQ02CXNPp5qmJcPhKfqPOpJzFGDGST37TTcltpIOfnm94HeJKW9._1Yjp5CA017QJ.3ta
 s.k0N4h3mCOAP9h6VM7P_p1XjJAJ13VeiuFjM7IMJVE2BLA5uoQa24PYZPbqZ0d717g599qBg6iC
 _3uC5NLrxrZRjVPC4tjmOy3x8dyXU7X7AdtLQzgyfmln5Gy.itwm92UyvRc4j9vGdMYWBNK6wioi
 d27cYrXWSkZVNOTKuA4a_3xniiqdnLeLlfrOT3p1DVrxs0rB1WzT3uOXqM0BoK.HxNPZ27w_rFQZ
 YCo9IRg1ax1wGgKHHXt86T.RbmM5mjNuSSX1wF7gAIbpjm03zQLJlRv4Wq0ZMYS.V7hlc03lJsPm
 dLks5lFxUSGmR7X2yMrMW5cCBxZ.f0xHQMl.lsC_OGB23qGaWMrk0vkM3FHoFTFp7ZuIKXY0VaPW
 QAEV7P4TApztvDpxAKLlS8WUOQNtLfFuNeXB8xtxVaan_..yKFLcRfgsH2b85ByyLjxmtJ2BVkGv
 ydpLXBM47WSauvdOMuHUaIo3cZ3FHOpH6YH8at2UWaAqECIcV7FhKxffb40QSMH_gUAsXbaoOE1G
 TVmYpacs87axbVhYs6VI.ZzXma2ZY5XGpStQVs2rVCSJTwT.GcFJ4IBRcaVwxDjVlku1tAib9N2L
 s0KScAaFeAdYgtPTDjrC4m3W1BDK5KBcqEccAmOgnX0fDcvPTC2_M5O01PgVzqFam.3CFw2c48A5
 OgxcL5f6MY2tgg3j5JxlBD4R57URgenCB40o4YZCCerf4iZIks3qQt2if7wNmDS_CdZLNwZhk5ek
 ZSnOI7DMlvAV1I.gefj2tp211ftm4ezRcbWL0fK69cckoNEyKd.6sc430hQAu5B0Di3zhMKHc.Xb
 w.D4ldL63L9dDZwepabmqEgG7gO0ZsZ7H1YyDuHS6vbUSO9r0F0gsXbbrxeSb0hFxgJN_A0b_3zh
 9wTyVDUaIwzw_8eQvNO84SYXhXj4F1qlvZrHCAC6MFqBJK4_rxB92ITMM.9fBgZWd9dpYGmaLW4P
 67cOyQsHAiFNUYcqRmcoxvt.sYFg5z2JphZEBT3BzUzC8zwYaHz.ue6gJ1FEiiF1FciFnl8IdCjH
 bK2ZZGMXtQGJY4E.y2UojDGzc2A.47NXSLFdXc7lGw.DJFanqm8zqUJk08Ov71rUAVrVsUGk_Q.K
 rgcA8XYCuw38o.AN4KLDebD4TQix1R9CSc5gIXoIOrEZT.CvpWdLZmzvEb7_vym4hcvZElkdST3k
 2WY3tnPRxBxlJ3czWLQqpAnDMnue8GtKP9eJ2yjG6x_7Pn2_r3um4r.sFlAo6D3qDVKTPlK.Q2qX
 TaJ8sPTGtWK8deaFDUU2dql_eKoxST1sIufPCmhfD0qP6UZOkYKkWdADnYZJnkHaj8h2kF82W1ch
 G7Oxq4P838zHcAt4O4VlDP5k6sDI3tV78lc19NwTMC1TvKCJ5y7AhtwubvlmrPXjGx8RWnbuhX9o
 n_c_QLFLQQiOArytbvWhufR.ZVfW8PYM4JqwxpUhfpwiXpyGM.GI2h9JeOoDOFO_5jrqmalG.emU
 Pnme9LKiN6dYqKGeMLU09sidz7iNmfTbxbq7Lol7zAiaGe8roT8LKhGiocY7rvrzKEu1M_1_1T2F
 UbJNanskASMRWULcr9NZ8ocJqKzMYju4LlN2yP7Q1XShxKOgM4GF8CDXcHGJijoPH7lKSunOxNVy
 l0hy6T_0AHIwomr7pZRKsBLwxRc3aBLbsuvqwRe9lsRHyHl.h68hii6lqkojbDHhAJr9ML6hBRXy
 FH8Lts32gaDbwka9Z6OC_LcLEq4xTac4rbn_.k0bEA24rDTirkKAWsLo5jxnSffPZVQ2bFtqspkF
 Ffo8_6U8qi9IBbYoOOH8ed0Uk4H93uJGy2xY499JzYh8dKHSl5Ue4kp4zSKlUlRtSwYnsSFbx038
 1ycSWFTkfAzcJbnLlAyNxAg9eS2OjPZ.mxu8S1D6.Hiv3OiMxAypWozwCG5h6MlnQkkcWwwfochz
 6lgwoXmO3Ox0se9qxf8cSWxOtUMXnSmY1ILINwjcafr9WCjO43ZFmGTppnYwGW2TTRHbjLPDeD1T
 OpcoO27xfAb8eCgVIX.gli16mOOq6QAwWG6F8ugVGvIo_BiUxGFLnrzn.PwjLmNk2yoR7l_9Wltj
 ykCQoUG4tpVrBCzlF_gp2aNiBETPp6Jy.4jY7dTyhXTPOSONeN.02NwRaUxhzmhgfHCOY83VCICR
 iQXWoH394KfFrAJe8dzOWh6lGBDe3bRg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bfca283d-322e-4c88-9b88-c2713d6bb7cf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:32:37 +0000
Received: by hermes--production-gq1-6949d6d8f9-ghhkt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e3e0e17187ae06698f220367a4c91416;
          Fri, 15 Dec 2023 22:32:35 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net,
	ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v39 20/42] LSM: Use lsmcontext in security_dentry_init_security
Date: Fri, 15 Dec 2023 14:16:14 -0800
Message-ID: <20231215221636.105680-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the (secctx,seclen) pointer pair with a single
lsmcontext pointer to allow return of the LSM identifier
along with the context and context length. This allows
security_release_secctx() to know how to release the
context. Callers have been modified to use or save the
returned data from the new structure.

Special care is taken in the NFS code, which uses the
same data structure for its own copied labels as it does
for the data which comes from security_dentry_init_security().
In the case of copied labels the data has to be freed, not
released.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
---
 fs/ceph/super.h               |  3 +--
 fs/ceph/xattr.c               | 19 ++++++-------------
 fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
 fs/nfs/dir.c                  |  2 +-
 fs/nfs/inode.c                | 17 ++++++++++-------
 fs/nfs/internal.h             |  8 +++++---
 fs/nfs/nfs4proc.c             | 22 +++++++++-------------
 fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/nfs4.h          |  8 ++++----
 include/linux/nfs_fs.h        |  2 +-
 include/linux/security.h      |  7 +++----
 security/security.c           |  9 ++++-----
 security/selinux/hooks.c      |  9 +++++----
 14 files changed, 80 insertions(+), 85 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fe0f64a0acb2..d503cc7478b7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1133,8 +1133,7 @@ struct ceph_acl_sec_ctx {
 	void *acl;
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	void *sec_ctx;
-	u32 sec_ctxlen;
+	struct lsmcontext lsmctx;
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
 	struct ceph_fscrypt_auth *fscrypt_auth;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 113956d386c0..4c767a20ac4c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1383,8 +1383,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	int err;
 
 	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
-					    &name, &as_ctx->sec_ctx,
-					    &as_ctx->sec_ctxlen);
+					    &name, &as_ctx->lsmctx);
 	if (err < 0) {
 		WARN_ON_ONCE(err != -EOPNOTSUPP);
 		err = 0; /* do nothing */
@@ -1409,7 +1408,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	 */
 	name_len = strlen(name);
 	err = ceph_pagelist_reserve(pagelist,
-				    4 * 2 + name_len + as_ctx->sec_ctxlen);
+				    4 * 2 + name_len + as_ctx->lsmctx.len);
 	if (err)
 		goto out;
 
@@ -1429,11 +1428,9 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 		as_ctx->pagelist = pagelist;
 	}
 
-	ceph_pagelist_encode_32(pagelist, name_len);
-	ceph_pagelist_append(pagelist, name, name_len);
-
-	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
-	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
+	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
+			     as_ctx->lsmctx.len);
 
 	err = 0;
 out:
@@ -1446,16 +1443,12 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 {
-#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-#endif
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	posix_acl_release(as_ctx->acl);
 	posix_acl_release(as_ctx->default_acl);
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
-	security_release_secctx(&scaff);
+	security_release_secctx(&as_ctx->lsmctx);
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
 	kfree(as_ctx->fscrypt_auth);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..ee24797842df 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -462,29 +462,29 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
-	void *ctx = NULL, *ptr;
-	u32 ctxlen, total_len = sizeof(*header);
+	struct lsmcontext lsmctx = { };
+	void *ptr;
+	u32 total_len = sizeof(*header);
 	int err, nr_ctx = 0;
-	const char *name;
+	const char *name = NULL;
 	size_t namelen;
 
 	err = security_dentry_init_security(entry, mode, &entry->d_name,
-					    &name, &ctx, &ctxlen);
-	if (err) {
-		if (err != -EOPNOTSUPP)
-			goto out_err;
-		/* No LSM is supporting this security hook. Ignore error */
-		ctxlen = 0;
-		ctx = NULL;
-	}
+					    &name, &lsmctx);
+
+	/* If no LSM is supporting this security hook ignore error */
+	if (err && err != -EOPNOTSUPP)
+		goto out_err;
 
-	if (ctxlen) {
+	if (lsmctx.len) {
 		nr_ctx = 1;
 		namelen = strlen(name) + 1;
 		err = -EIO;
-		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 || ctxlen > S32_MAX))
+		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 ||
+		    lsmctx.len > S32_MAX))
 			goto out_err;
-		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen + ctxlen);
+		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen +
+					    lsmctx.len);
 	}
 
 	err = -ENOMEM;
@@ -497,19 +497,20 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	ptr += sizeof(*header);
 	if (nr_ctx) {
 		fctx = ptr;
-		fctx->size = ctxlen;
+		fctx->size = lsmctx.len;
 		ptr += sizeof(*fctx);
 
 		strcpy(ptr, name);
 		ptr += namelen;
 
-		memcpy(ptr, ctx, ctxlen);
+		memcpy(ptr, lsmctx.context, lsmctx.len);
 	}
 	ext->size = total_len;
 	ext->value = header;
 	err = 0;
 out_err:
-	kfree(ctx);
+	if (nr_ctx)
+		security_release_secctx(&lsmctx);
 	return err;
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 13dffe4201e6..c56a7caea6d3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -807,7 +807,7 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 	int ret;
 
 	if (entry->fattr->label)
-		entry->fattr->label->len = NFS4_MAXLABELLEN;
+		entry->fattr->label->lsmctx.len = NFS4_MAXLABELLEN;
 	ret = xdr_decode(desc, entry, stream);
 	if (ret || !desc->plus)
 		return ret;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..ddd8f7bae5de 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -357,14 +357,15 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, fattr->label->label,
-				fattr->label->len);
+		error = security_inode_notifysecctx(inode,
+						fattr->label->lsmctx.context,
+						fattr->label->lsmctx.len);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
 					__func__,
-					(char *)fattr->label->label,
-					fattr->label->len, error);
+					(char *)fattr->label->lsmctx.context,
+					fattr->label->lsmctx.len, error);
 		nfs_clear_label_invalid(inode);
 	}
 }
@@ -380,12 +381,14 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 	if (label == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	label->label = kzalloc(NFS4_MAXLABELLEN, flags);
-	if (label->label == NULL) {
+	label->lsmctx.context = kzalloc(NFS4_MAXLABELLEN, flags);
+	if (label->lsmctx.context == NULL) {
 		kfree(label);
 		return ERR_PTR(-ENOMEM);
 	}
-	label->len = NFS4_MAXLABELLEN;
+	label->lsmctx.len = NFS4_MAXLABELLEN;
+	/* Use an invalid LSM ID as this should never be "released". */
+	label->lsmctx.id = LSM_ID_UNDEF;
 
 	return label;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9c9cf764f600..1bc7cdf52f04 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -346,13 +346,15 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 	if (!dst || !src)
 		return NULL;
 
-	if (src->len > NFS4_MAXLABELLEN)
+	if (src->lsmctx.len > NFS4_MAXLABELLEN)
 		return NULL;
 
 	dst->lfs = src->lfs;
 	dst->pi = src->pi;
-	dst->len = src->len;
-	memcpy(dst->label, src->label, src->len);
+	/* Use an invalid LSM ID as lsmctx should never be "released" */
+	dst->lsmctx.id = LSM_ID_UNDEF;
+	dst->lsmctx.len = src->lsmctx.len;
+	memcpy(dst->lsmctx.context, src->lsmctx.context, src->lsmctx.len);
 
 	return dst;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6ea99e2aabf3..79626ce7cecd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -124,12 +124,11 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 
 	label->lfs = 0;
 	label->pi = 0;
-	label->len = 0;
-	label->label = NULL;
+	label->lsmctx.len = 0;
+	label->lsmctx.context = NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, NULL,
-				(void **)&label->label, &label->len);
+				&dentry->d_name, NULL, &label->lsmctx);
 	if (err == 0)
 		return label;
 
@@ -138,12 +137,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	if (label)
+		security_release_secctx(&label->lsmctx);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
@@ -6155,7 +6150,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, {buf, buflen, -1} };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6183,7 +6178,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return label.len;
+	return label.lsmctx.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
@@ -6260,7 +6255,8 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0,
+				    {(char *)buf, buflen, -1}};
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..fe6d184ff169 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1154,7 +1154,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->lsmctx.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1186,8 +1186,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (label && (bmval[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		*p++ = cpu_to_be32(label->lfs);
 		*p++ = cpu_to_be32(label->pi);
-		*p++ = cpu_to_be32(label->len);
-		p = xdr_encode_opaque_fixed(p, label->label, label->len);
+		*p++ = cpu_to_be32(label->lsmctx.len);
+		p = xdr_encode_opaque_fixed(p, label->lsmctx.context,
+					    label->lsmctx.len);
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		*p++ = cpu_to_be32(iap->ia_mode & S_IALLUGO);
@@ -4236,11 +4237,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		bitmap[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (len < NFS4_MAXLABELLEN) {
-			if (label && label->len) {
-				if (label->len < len)
+			if (label && label->lsmctx.len) {
+				if (label->lsmctx.len < len)
 					return -ERANGE;
-				memcpy(label->label, p, len);
-				label->len = len;
+				memcpy(label->lsmctx.context, p, len);
+				label->lsmctx.len = len;
 				label->pi = pi;
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
@@ -4248,10 +4249,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
-		if (label && label->label)
+		if (label && label->lsmctx.context)
 			dprintk("%s: label=%.*s, len=%d, PI=%d, LFS=%d\n",
-				__func__, label->len, (char *)label->label,
-				label->len, label->pi, label->lfs);
+				__func__, label->lsmctx.len,
+				(char *)label->lsmctx.context,
+				label->lsmctx.len, label->pi, label->lfs);
 	}
 	return status;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f2bbce7fb28e..741bbf5df0af 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -83,7 +83,7 @@ LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
 LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
 	 int mode, const struct qstr *name, const char **xattr_name,
-	 void **ctx, u32 *ctxlen)
+	 struct lsmcontext *cp)
 LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
 	 struct qstr *name, const struct cred *old, struct cred *new)
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index c11c4db34639..04e4afc8deb5 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/uidgid.h>
+#include <linux/security.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
 
@@ -44,10 +45,9 @@ struct nfs4_acl {
 #define NFS4_MAXLABELLEN	2048
 
 struct nfs4_label {
-	uint32_t	lfs;
-	uint32_t	pi;
-	u32		len;
-	char	*label;
+	uint32_t		lfs;
+	uint32_t		pi;
+	struct lsmcontext	lsmctx;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 279262057a92..c314fb43547f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
 {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	if (label) {
-		kfree(label->label);
+		kfree(label->lsmctx.context);
 		kfree(label);
 	}
 #endif
diff --git a/include/linux/security.h b/include/linux/security.h
index dbbfbcfbb299..35604f43d4ff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -404,8 +404,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen);
+				  const char **xattr_name,
+				  struct lsmcontext *lsmcxt);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -855,8 +855,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
 						 const char **xattr_name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *lsmcxt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index e1487979603e..cea3c1b614a1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1666,8 +1666,7 @@ void security_inode_free(struct inode *inode)
  * @mode: mode used to determine resource type
  * @name: name of the last path component
  * @xattr_name: name of the security/LSM xattr
- * @ctx: pointer to the resulting LSM context
- * @ctxlen: length of @ctx
+ * @lsmctx: pointer to the resulting LSM context
  *
  * Compute a context for a dentry as the inode is not yet available since NFSv4
  * has no label backed by an EA anyway.  It is important to note that
@@ -1677,8 +1676,8 @@ void security_inode_free(struct inode *inode)
  */
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
+				  const char **xattr_name,
+				  struct lsmcontext *lsmctx)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1689,7 +1688,7 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
 			     list) {
 		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
+						   xattr_name, lsmctx);
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1e97b703f252..ed4237223959 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2859,8 +2859,8 @@ static void selinux_inode_free_security(struct inode *inode)
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
-					const char **xattr_name, void **ctx,
-					u32 *ctxlen)
+					const char **xattr_name,
+					struct lsmcontext *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2875,8 +2875,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (xattr_name)
 		*xattr_name = XATTR_NAME_SELINUX;
 
-	return security_sid_to_context(newsid, (char **)ctx,
-				       ctxlen);
+	cp->id = LSM_ID_SELINUX;
+	return security_sid_to_context(newsid, (char **)cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.41.0


