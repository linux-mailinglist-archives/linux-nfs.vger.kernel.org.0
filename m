Return-Path: <linux-nfs+bounces-7404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B19AD6A1
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7569B1C22B95
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B351FAC36;
	Wed, 23 Oct 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bJa7AJnr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic307-8.consmr.mail.bf2.yahoo.com (sonic307-8.consmr.mail.bf2.yahoo.com [74.6.134.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4841EF925
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718631; cv=none; b=rT9F7eCGknkIFq3NYOFgmhKQr8dsslCXvxvWGHU/bRS+8B30Et+Eve0QpRBoWeJfORTaQ0Srqg+EDlB797KyDqHj6l0DsAAQHSQNyP5SzT5ewaFGkpNhhwBeIM+sp5aPU6g2spA55GfcaJ7fXQ20ZaO/nosBUjVHE8C6GE0Eyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718631; c=relaxed/simple;
	bh=Sup8gk0Jh9dp2tp0MS3GDtUxMfc7JJz0W6FXIbQqBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvKZcub+cg2ZC3G19eZv+Q7JaBJMeDsTsDBaSfwVG62YF9qEcqkGQAtC1KWlhQV9TssrwG/GiAkk7puv+YGUwdR+PHX50TwIUR171IdHDMfY5oyStxkyVIjt5KLRVQrAxaKYzkivC8DzxjdmpvrbCPwbukC28OmMmNJBzYKGZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bJa7AJnr; arc=none smtp.client-ip=74.6.134.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718627; bh=3aGNvorbrJQqUlvZprczBEHswF8znlJbxyXOeuCfEmI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bJa7AJnrffVyloCsT8u/qij63QPc6BSUwHcYKTrczeTMjUXPHTHuP6shYuFoOxKxFUwZR3HDc/V7fD1vauHrxKRLOzjawCV14U88uaFocagbMiaT2zowWWXhfGxPeCTp3CWG8IKQf3b9gnaVE3l/4eCg48Ev6qc7ajxospBIogA0koayxAwGizypcFnFlrB0RHfxeDqvfLs98kUdDfnhlTEFj/wIJUFmS4j+mq6ydcNNeRO5qEv4d/uZDO4yK6VhGyAQqeVGL+pTJ5vBX6IwGFVd6S6TsCeU15NTkvQGqB3SgGgQ0Hu3cOhkhRgmpJcaiIFiZZkBhXqQ9yxRMe26Vw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718627; bh=cP6HoVGuYJbYaK54knQHpRlie56YRTrdCQJZh6j5PZH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s+Ysv6HFNi0jsmdyzAw3HjJ9B3eEIkzBLffMGM5NBVV+y5a+aU1zckjLAIRUDOJVEn7fatMJtP+7gnm1DKs1AfCVgmMnruGPmVM2Dv+v5PcricCvPiZ4cAY9v68dxRpCCb2JQTbs34ok7cj7uZT3rwMzJpQoQbETFTLqtVfkWk12YlbiCTcoQkmntpeR7As3LIQUt4gjw6O9jPq4RXNCd0910Ch0MwfUyEFW1f1dV4rsyPisFknmzqnj/t3I696XnsAM2PRXIiI+Jprs3IjtMxOoDRe3BUCB6nnBdnj3rmDktPMGNxntcTN7iR7Ert89PQK3P/oBNVLn/7Ydg2sx0g==
X-YMail-OSG: rMKaiQ8VM1mF3D0Q77wRlza1iij_wJRglWPL5RJbYMngyqc2.moBZvK1ylcv3gQ
 fysSizy23Phn7OnY9iDDxTth91j.VMlj7bdsErmzphLbt2KdifhTp5ofTgV2KeEdOM25UOLg9ZIl
 kXvyD2i4P43C7GHtpgFumIj.C2iby1cfIAwcvuCh8Y3BblgllULgEKErAQNM6ooLQwnP1Rd7Wpe8
 sK8LGzy5LGM_7GYDEkSPk3fU2ozta3weeWHMUaJFrgggTN0NJyP.McSqXwI4MZVS0FW429H85m4W
 vPPiHTARxsJd51QmKszyYbtUaUd51QuI1nsfqyYOfPcilN.x4kAI.b6y0pWPP22IWWvAIh_Wf1il
 UMG8lCkKeD9nTOT3MoA4Zyr2A6v0OpFKoCIf0okfiATJWC48EOBdrC3.mqE4ZmqS0T3ExfCnzoDs
 wkEnBt0WKybabMBnYGAH43rkQJbHZJxKpE8BZa2o8.U2Mpl3DNEgSGE9R1iFQGPBF81EkFThyWQu
 u6SetXa6KJHE9qMlLH84ART2EWzQmbeQXVHL5dQo6txcNyClExeoIk2t0XMgeEl19ACLnRlXiP4J
 xaTT2IiUt1EzJ2w1bRLQiz41RslcAqjRpSrThVBucYkpQhOtn1Pye3MAa3gLeHV6pztqw59w5y27
 g1bFJ2y3t5URwBpQTy92fKKals2HRP1eTfzzfTzuC_3kPm.i0JXBkvwwBY02KEfoj558vqxRTmom
 wjDVd45HR54Fs68gVip4ZrX3OuYFzkF2GHgNAHaS_PI0nZnAPxz_CV3dLy285DYGpL.JM5fbu_t3
 SLRD3fIWYCSvr8vkqthURfv5bkSZ1nhhLGToRvebCZME1roOnIYqtgO7rbC6PQVcHaxeouwEfhKP
 s1X2XRKtBEaExBt96gg8dkRB_kHRW7UoW0ks45.ih5LEEjNFTb67HyW4.uzo0wEQGRgZvIEWK53d
 HA6rdX6ble8bqRIowV3cNhKLggsXpGpi14ksWTJNv0Twoqb7PlJIFSg0MnNNfMKf6QW4_kN8RzeA
 Hs266ki1NM0u4yVxlXECkbJ5hg0hguCq5p7ouvmVgUdzveT0jQ1TJj4YBvWrOkXZE_tB8xRTUHwd
 Ms4NvUpV4d8cU.ESEb7xp_KsfOXm_WQThVJZVLLbiAflew_CB0de0oLMGldeNBw9QBTVvt78TdoQ
 309cpZ_v2joVkc6S9ollgYaZhz7vsp297GE0Qb.yPfOG7sQoR5ChDFmgmmgM6_J5mkxGyGvoMMSK
 gKQ9XTcE29v.o4lVj0F50tavgOfv1FI1TFnLcfmErwax7lRNfRB5D.xnOzESjiSK_euqIUTpGfo.
 aTvRiCGqmK2uhe2daTLi3DSGnwTkuDqEeC1C.rNwsNCaIWwGsN_cZR459u877giGrJu8le5fXTbR
 fwPMky9_cTU6u6uM1jJ8zKoedaeufVZCL9dn3V0ANWG6m9vHM4BMtNOeZBIqbGNziEi7XjAsoVhV
 AJA9SkSYAr3pnSK3leKcIQql0LC57Zi.MPU6iRmX4QW_IceMok3rIdq8OmSXZddBXhumR7qEyl0h
 JzcLgy5PfEGUX9kU.PpZOXcQOukq6P_a3BxYWhGaHhlaU7xT50epKST5Fi5AkO3lEdnm5rIrjD4r
 tBIzvJrhMdFcHU1CS_caCt4wokp3cGSYUEDHgpuO3nEI_sYa7jinxgHk_Ev1h.vt67hlWafJ1xzW
 QOu0uT5lIhsxONSGF1ymDdmNiE4Iwn0wiLpLD8IfBZozcLebdTrX1oxw4dq1pun90xJJzw99Mwfr
 S7BwGtBUFDSuptgyJ.H0y8yJglBaeB9SN8M1clhY9njZHiYhiZt1O5jFQJab45hTaLJ90YYzYv0M
 e1uE66KY.u0GvdagfURyC6Us3NUywrcoj71yl51sct4RPkO2dIcydYVLd2is4AD4TGA9jsUAs3nj
 _MovYCUwXfmvO3t8yaiwvXG_10Zo1Jcab4D3t211Xgq._ZolBYf_KYai6_nvhp5AfmN_PKaDliA6
 iH.9nUBXaFKR5ENFCRzjKtuqnZ84Hf4GbVsNosVTB.CKLsDVOTcjGa47bfqY5bKrwG3gCWRlWRHu
 4._oi_MmtwjqrfpSa2Qp.2KYyl6CaEnUr1DxGT.wjP5lNekTCmRhFC9Jsu_hp63hg2k15DZQm1sh
 2YQJF_wh_wj.cc6oin6Ku7pA4FhX5mTPCAaWIcMIJPR2D.jOzr1NRu8BR6yY675cr0gncw.kDp2m
 FDwRtqqYIqdq8HFk22lHwIJ9L0AetvPNizLQrAIqCuPArSl.gmWmH6rkN3Ks9p14m_pTqhGbxyZg
 ZO_S5tBpp50l_RooLOni.srrB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: db6fdd30-de6b-4b5e-8649-08f948fd5c07
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Oct 2024 21:23:47 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d261940d1cdfc655543cc442dda3a810;
          Wed, 23 Oct 2024 21:23:42 +0000 (UTC)
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
	selinux@vger.kernel.org,
	mic@digikod.net,
	ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
Date: Wed, 23 Oct 2024 14:21:57 -0700
Message-ID: <20241023212158.18718-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023212158.18718-1-casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the (secctx,seclen) pointer pair with a single lsm_context
pointer to allow return of the LSM identifier along with the context
and context length. This allows security_release_secctx() to know how
to release the context. Callers have been modified to use or save the
returned data from the new structure.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
---
 fs/ceph/super.h               |  3 +--
 fs/ceph/xattr.c               | 16 ++++++----------
 fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
 fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      | 26 +++-----------------------
 security/security.c           |  9 ++++-----
 security/selinux/hooks.c      |  9 +++++----
 8 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 2508aa8950b7..c9fad8c825dd 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1133,8 +1133,7 @@ struct ceph_acl_sec_ctx {
 	void *acl;
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	void *sec_ctx;
-	u32 sec_ctxlen;
+	struct lsm_context lsmctx;
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
 	struct ceph_fscrypt_auth *fscrypt_auth;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f7996770cc2c..0b9e1f385d31 100644
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
 
@@ -1432,8 +1431,9 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	ceph_pagelist_encode_32(pagelist, name_len);
 	ceph_pagelist_append(pagelist, name, name_len);
 
-	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
-	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
+	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
+			     as_ctx->lsmctx.len);
 
 	err = 0;
 out:
@@ -1446,16 +1446,12 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 {
-#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	struct lsm_context scaff; /* scaffolding */
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
index 54104dd48af7..eea4d0d27ce1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -466,29 +466,29 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
-	void *ctx = NULL, *ptr;
-	u32 ctxlen, total_len = sizeof(*header);
+	struct lsm_context lsmctx = { };
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
@@ -501,19 +501,20 @@ static int get_security_context(struct dentry *entry, umode_t mode,
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
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76776d716744..0b116ef3a752 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -114,6 +114,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context shim;
 	int err;
 
 	if (label == NULL)
@@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	label->label = NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, NULL,
-				(void **)&label->label, &label->len);
-	if (err == 0)
-		return label;
+				&dentry->d_name, NULL, &shim);
+	if (err)
+		return NULL;
 
-	return NULL;
+	label->label = shim.context;
+	label->len = shim.len;
+	return label;
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsm_context scaff; /* scaffolding */
+	struct lsm_context shim;
 
 	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
+		shim.context = label->label;
+		shim.len = label->len;
+		shim.id = LSM_ID_UNDEF;
+		security_release_secctx(&shim);
 	}
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 69e1076448c6..e2f1ce37c41e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -83,7 +83,7 @@ LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
 LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
 	 int mode, const struct qstr *name, const char **xattr_name,
-	 void **ctx, u32 *ctxlen)
+	 struct lsm_context *cp)
 LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
 	 struct qstr *name, const struct cred *old, struct cred *new)
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 7d0adc1833ab..3ad59666e56c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -237,25 +237,6 @@ struct lsm_context {
 	int	id;		/* Identifies the module */
 };
 
-/**
- * lsmcontext_init - initialize an lsmcontext structure.
- * @cp: Pointer to the context to initialize
- * @context: Initial context, or NULL
- * @size: Size of context, or 0
- * @id: Which LSM provided the context
- *
- * Fill in the lsmcontext from the provided information.
- * This is a scaffolding function that will be removed when
- * lsm_context integration is complete.
- */
-static inline void lsmcontext_init(struct lsm_context *cp, char *context,
-				   u32 size, int id)
-{
-	cp->id = id;
-	cp->context = context;
-	cp->len = size;
-}
-
 /*
  * Values used in the task_security_ops calls
  */
@@ -409,8 +390,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen);
+				  const char **xattr_name,
+				  struct lsm_context *lsmcxt);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -883,8 +864,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
 						 const char **xattr_name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *lsmcxt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 4ca3c9e28b6f..1d57e4e1bceb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1734,8 +1734,7 @@ void security_inode_free(struct inode *inode)
  * @mode: mode used to determine resource type
  * @name: name of the last path component
  * @xattr_name: name of the security/LSM xattr
- * @ctx: pointer to the resulting LSM context
- * @ctxlen: length of @ctx
+ * @lsmctx: pointer to the resulting LSM context
  *
  * Compute a context for a dentry as the inode is not yet available since NFSv4
  * has no label backed by an EA anyway.  It is important to note that
@@ -1745,11 +1744,11 @@ void security_inode_free(struct inode *inode)
  */
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
+				  const char **xattr_name,
+				  struct lsm_context *lsmctx)
 {
 	return call_int_hook(dentry_init_security, dentry, mode, name,
-			     xattr_name, ctx, ctxlen);
+			     xattr_name, lsmctx);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ce5e45abd8d3..79776a5e651d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2869,8 +2869,8 @@ static void selinux_inode_free_security(struct inode *inode)
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
-					const char **xattr_name, void **ctx,
-					u32 *ctxlen)
+					const char **xattr_name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2885,8 +2885,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
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
2.46.0


