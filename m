Return-Path: <linux-nfs+bounces-7156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58199D1CE
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25FD1F24A07
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72391AD3E1;
	Mon, 14 Oct 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uXrEFiF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800681AC448
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919005; cv=none; b=TslMuIImSZX/ZRFAxCVRuUj/Zu60hjbD9WWh/DLhkZ3EB4wm44KsFyHnCviSuWz/0ba7hbsJWpvXo/pffVEI5Y9v3tU6vsR0JyZcz4jnNSr75+/EttIORe3RCEoOEV7cPF8lTxCTaTrPkebjUHOn2GaVx8iuEcgls4fkagSk/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919005; c=relaxed/simple;
	bh=HUumJWQSUaNDZCeF4RgqkLG4LRs1MoV8/m9sy5MSbhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJrtQ+C65ZHDgjwc/a62InLvPXxNRPuwzNrHCoasdqVdwabpgrBSHsVKWLVni7ceKfTd3YHEgWZbwiSC/Az7MtdW6OBmEOuO/mkKzoQMxSuRtlP1eCa0MA2528youNGMmdT242SH9VFs8N0icryVgJfEBn+BGelzHGQ8DQRMKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uXrEFiF2; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918996; bh=rich9NI95VqRyuq/AK+XiAj+clCh1m5ei3XEp1pQo84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uXrEFiF2KVx5Es9YpvvMThVXiub4EzjTys2MrN7AIPKNjsI/du+oyH+XycI3x/a/gxGaplYQCHDCLrSWVYdF4/oFwNRA9WvIGzXZVt2JBEc4UvmNENmg5QLspuYoSWRaSimf04kpvBu/N7VfWvzB4glNjSNNj7Ggn3upsdoSQ6MX8eRnhrTrUC63PAji9lP/rphgRgseqTixRHVlggYfbhV6+LEkRvdRq8I8wx/kWipKFz75gVYO+7bglV7sA6VKO9uIa1lWRwOKn5BC3vnLGPI9AjFDS4hd640vS9qBnbKx5xClvDp878IPh/+uPijcd05cIa++tCcEPae1umklDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918996; bh=LJifvuxdD18OBFc2uhTJzNCnD5tH3Ib7eDjBvF0r3kM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VF/K//LZcl7OsIWPH5rS+v2tNtWUSSz0dGobRucQXCPadTdGKEp83MR7JzABn87jfbVxrOk7m9aY/7+avjyvS7q3KaKEikQxiixiAc2HnPSwCnJK4/OmpjtXScfvQOsLRnHwi87Dy7M72sk+yApeO6vJ/q3UpuvETt9EW/NDosUUtkV+POQVjhiXoTfDYsqLrcWA2+07HajoGVurp5oi5p3LlOfpjELnDwMnTPSlCLU3gkN1d5JAnrmK33n10OzJHWGhveEJdjqFSQCKTE0q5NAkI88YhKhSDEuXu+c4Kbf0ev9EWVCtKLYjKj6YycSKKZTAr40HUUnpC4WT2+fFgw==
X-YMail-OSG: ZVA_4GUVM1nTsr9HJQBq..0x2.vCHaqHKAxC6l0PA5ZcfRrfF1uX_6AC2x1OWIE
 MKtBhoVKvWZik439lF7lPZJMXYofebZrwkd4LKyaCTzrfEwI8LrzTwHMOA0aoU2sxseqtQB_D2qt
 8mTN5mHFmeGLSbfDKsaodgqGqSGsuP0eafID2WfZ1nk0nRJPtPuqZSn_RokhODgxkFBqDfzfoOrn
 G07MBIeUMakJCW_c.yfDvJ.royGwE.7y7nCnecCZQBhc_Laiar4Lq40oqyfdagCcHCnsds5mVEnS
 Bpb_u6jgpZLdAB_rSMiPQ9RSD0mrkrMAd9DMoh6FJH5xkJFKOjlf3.16q8ZWLPtgzIjOrJMqe2GC
 q4nKyIbmhDLrykb4JYCXJ1PoTD6uao9TJ3d9GSqd0Y5yrpBrM7tJu_zglu76h0JGA8tiCKjcWAEF
 59f18CPeIE3woC7FR1EISMOFE0xZr2IZ_eL.utbyYyv2ObhmhafJWJFHJ55q7xy9bOxckDPYXwXh
 g8U1STbvjVQxTwoY1Eo4tC0oLDn05kvjG1WRLtVeE7JT7ClOQ_yf8eW9MJOc46UwP3mGZsuLjvlG
 s_jNUSzuxZyOa0772W8Gl.LGlbNgQHMC507BrqsAOZwm378VG95lEwSDcIqxigWuwns11sMlJPcX
 KAH_uH0Z0rHx3y6FRE_J1rbzmnnQ52wSrhLX3JghGrm3pRnOg1njyTOZx5728P9Idartebo6JijE
 26HJDVOUW66ZHuj3I.vternXPn1BFl5vTvYzwVIKiXIE4PLDja9vVy9hA0OCg9pIR_Tv05b9yrS6
 UNIv.wYhQF0dlG8lDVA6meVMkc5S95lcdrYSY6TR_X4g0.GxC0iQp0JP0AAvIliFWSM3SjwAVGWe
 Zluimi6ugOENIw.GaDkDCBWJwXuOFqVyK9m6E.BJao49RFq8PlQZTZcWdMMDSX2ff9iP35Bc99zN
 5TUxInazUX_feE8QJKUNRsD8mHzFhbV1N4X2IfGHLj5w4Rl93XUHFXCyjiyhOkNy.Ac4HxYdDaWj
 j1f1ZSIopCLs2FuBioM3iBsx5mAsGIV9BGOiWjTXyR._zpd.Uhr7Nq2iL96TUPbKjlYjBHz8gCeD
 alRFDVx1nRV1XoyyYLsAxPrTeL1rzJ1DZd5YFj3Ivml87nmAGAhMzlTkS8jRnwIdpOxd64eZzg_Z
 V8SVfafz_l1ecW4V7YYufR4y.65wlGPJN8jOOPw1G940oTtcTgb8cidWD78e7uuJHYQx_3MYjZmd
 EhQKTO3eMlcpXKffF40q5WRIsVoKTqSaSyt5uFfgYsxGwToz53QC_65zS74uGM5SCmyyVMbpNdML
 LLMHssa9oV1jGo59IihCXykN6x7cRco6UhEJspTIWFAtgWYV5nsUfJzzGf5PhL8B1i1KMCqD9YpE
 bFD.ViFgsLzoRauHKI6Ixneg3vN8r_hQ84MC2DMd1o9riIhoA5BYIpuEOY7uJULS5Vie.0eHZAn5
 6fCWwCuqDolz3UKzJGGMDwdTl7TQReEZszl51AXdeucQ7QXBMbwEoBcnOQskgymmSMh1Ja9z8wqb
 dkl7ajGdUEdZ55zygbc0Dri8HrGTLMpPyiDPQs99I1fYM4OBCJveCtS3XdZlAIOZE_RjhJaqyPRi
 vBFQV_xkdUGsKjEYa8EhvRa8hbgABGTPJhrjWlA_zFTI574M9oXQPMDvcq6XGOuDlUwD6CSS_sRD
 mGuL0fSejqTnc5Oasne4lgxkvWIWZeZKk99ycwWHs5gstE0cb60fjxQvsxJwLCocXXCo7Y6Pswj9
 FS2BkGFsRSnKrBRX7CIpdCxVIHgQMLIZERPXUjYefpLic2SUIryHg7..5ItqBEx.9JrwcyI1hkU6
 XuIaY2Iq.vVd2dll9IGsj6gFmNZCbzRZluSlHoXypZ7AqxLrNdtA44XjcMW6jVFnYIM_rmHw_Ys9
 cmTIgyyrjaTK3AXWwoJbobTHHkHfidtWQHq_xnk2_fm3j1H96A8MuaC4SgeJCfRkUShIYrx_feqd
 14fMS.HPmtctllBmsODjikufECb4rdANCu6RUPhWsk9t6GRP072vYG78C0SKbXk0.BoTyX2InFJz
 U4QBbFfsfHfhFfySOocc1k4uu7PQPSa59Z.BAXEzCsPZcgEsbul2sQgGHwA.d9lZ738QYadjOH3H
 x5CryX_EXccvGfxsweOVoSU_bURsH3xqrT4jhRVkIblpPWbcefFy5M.P1vR7PXsr.SgZKfUw2xiq
 mtWE2ybC4Uw6FnrcxxpQF945iH_N9GxF92SNozwE7lhJvrIHNJ3Dswk_hrbkk0TH8IEjh92EW5Rb
 Q62TU00lBybWUZoBxCQMJS_nB3Kszvgc9vVita.vm
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0be80206-6059-4897-98d4-208635396b78
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 15:16:36 +0000
Received: by hermes--production-gq1-5d95dc458-4hqnr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8dd3ed09a3dd7dbd0509b276d789cdef;
          Mon, 14 Oct 2024 15:16:34 +0000 (UTC)
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
Subject: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
Date: Mon, 14 Oct 2024 08:14:48 -0700
Message-ID: <20241014151450.73674-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014151450.73674-1-casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey@schaufler-ca.com>
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

Special care is taken in the NFS code, which uses the same data structure
for its own copied labels as it does for the data which comes from
security_dentry_init_security().  In the case of copied labels the data
has to be freed, not released.

The scaffolding funtion lsmcontext_init() is no longer needed and is
removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
---
 fs/ceph/super.h               |  3 +--
 fs/ceph/xattr.c               | 16 ++++++----------
 fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
 fs/nfs/dir.c                  |  2 +-
 fs/nfs/inode.c                | 17 ++++++++++-------
 fs/nfs/internal.h             |  8 +++++---
 fs/nfs/nfs4proc.c             | 22 +++++++++-------------
 fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/nfs4.h          |  8 ++++----
 include/linux/nfs_fs.h        |  2 +-
 include/linux/security.h      | 26 +++-----------------------
 security/security.c           |  9 ++++-----
 security/selinux/hooks.c      |  9 +++++----
 14 files changed, 80 insertions(+), 101 deletions(-)

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
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d8..1813ad9e9320 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -809,7 +809,7 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 	int ret;
 
 	if (entry->fattr->label)
-		entry->fattr->label->len = NFS4_MAXLABELLEN;
+		entry->fattr->label->lsmctx.len = NFS4_MAXLABELLEN;
 	ret = xdr_decode(desc, entry, stream);
 	if (ret || !desc->plus)
 		return ret;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..d00a6304133a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -358,14 +358,15 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
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
@@ -381,12 +382,14 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
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
index 430733e3eff2..96477a57f65a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -355,13 +355,15 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
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
index 76776d716744..b07d01f390dc 100644
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
-	struct lsm_context scaff; /* scaffolding */
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
@@ -6259,7 +6254,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, {buf, buflen, -1} };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6287,7 +6282,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return label.len;
+	return label.lsmctx.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
@@ -6364,7 +6359,8 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0,
+				    {(char *)buf, buflen, -1}};
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..61a2b0e61c66 100644
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
@@ -4272,11 +4273,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
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
@@ -4284,10 +4285,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
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
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d7430d9f218..22032b0f6022 100644
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
+	struct lsm_context	lsmctx;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 039898d70954..47652d217d05 100644
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


