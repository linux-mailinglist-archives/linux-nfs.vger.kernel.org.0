Return-Path: <linux-nfs+bounces-6535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD37B97B653
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 01:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26AF1C21378
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 23:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFF193406;
	Tue, 17 Sep 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UcPml4XE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808F192D84
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617143; cv=none; b=t9lKWZAoGJnSiy/UURrXeHc58NO8Vq0SwtmMOGM6b/xpCK/hidDZwg8GY1AombQyOb6+yOs9RYyigMhBcTohWUPHx0TpI0kQvHsEDm3ZxIKZg2Nq6JOoWax+8t2MCQZ+bm2GByy5SsRsbCyC6cHZa/Yvx96O+I7+pV9kIbzGVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617143; c=relaxed/simple;
	bh=TvMfGpuNmuHfE6/XkTQaEHZLIHs+wYB3vWh5QXj2QUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtntmWn1zOjwbN4HTe2guR8WyXFOjjHHNv3uh8Ldbxy1FRom2CYanpenuCP1XZNw3xBo5Mtrc2Dkckis4i7TAn8F+TBYi5hB7hYzl+FRifm1mkC4V3rNuR3p+38Ptpj7WfGWlVFDoH675j+yrBmJZXu0Z9/ozg1YXmbkyj5Ym/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UcPml4XE; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617134; bh=MNpQztIp64MFTCT2V7aLKEPsQbqe9BTTTPEOJA6EgLs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UcPml4XEKr59mWLjC48z/7ui4XHqmnekvV6DMswQr5xEKlomIMV709fAwRY3Suv16Rl+tALCTcsbRTm2umzBNstPELI48fs/e9hVkK8+B2hhBmpjO1gB+tNMLgPQ4S104Cbfdr+ZM+w59BKzjlUb3Oqil9VeKZ1uaVVr5yfeYeZUlmxyL/zXdS1NE5ZOQXjzfubg36MIeWuV7zIIZ+Zx/T7WrS05Q1vMmwPJl3QNXCTOJwrzVP1B/LsI+H7atZz5N8dXz+hiotsiiAXT/wVPtIEpCt3ZOnAzbd4D9CUKwTUaZ1PynACyRcQazHyjDk+Czl48QB/4Y1zzQm+IBCXBPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617134; bh=SSMiXYDF57h8sm5CGiu+cA3P8GObemjt5P4BjT0dFw6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZJspLEPzht7NXYPDGobEY0NkyNb8/78dwMlme9DpFxHkD53YF6FOhGDbb77z4AFFy783CQvaw37Cd6bvPqgaPgc/FiIgUJSUlRhENJp6vj+eNrd3/LMb0cI4LyBTlNllBSSz/dOGKWTa+M0jtlTpbSMg1ABlzhr1oatgqthzS6P3zaxiAlkDBU2siYFRaQD/z764Rb/tNQU5QrNw9li5Z/roxjA3Zw2QTO+YPq/gsHduLA/QqbHuZN3evsg7S/i86LAyeJE5KX8Dx/3V6IRTEdQELPw9iK0eAznkfTfVyZO58lu7hW1p1qXO50WhFR/3iAH5j/aQLxIHYgEpo9rWNA==
X-YMail-OSG: YHFW6mEVM1l7bPE7uLBwUL6PPgVUoFy8h56zPwmDXRuN7ps87H_lxvojNJ__K.G
 Qi1_zF.yDD9aKPBavvoP1wcTqq0_PI8N6ttl_H4_CjGwSd_2zPHyvgeWewVRncNTUz3ks8UEqrzg
 qyKfhgeyq6IJKpdng0Daz4qfyoH52BWWfRXghUFCCl1YK8ZMjwQr5eBnI3jPVtBZf.dgukFIxyJw
 Y8zRRF8hgYLPzF_lnRvdM2NLksLDPsnnq1vSoBThaRjQbpsYRaZlxyL.VD4kqXzm3wZ976F0VCQ2
 z5jqyh45mMne6FB4C453eMgBO3HjmMf42ls7F8uwTXCoMzhH68c8SqJ7LDAZN0cmcYexitCdt7d_
 prf.8rbqeNJa5.BPJpMqnFClu7cMvEU2019yKGmh.m1FoHc6XT9HtuW9pX2SfHQACUzobnlyu6eS
 6rPsFYz.m9fbIgXdO8YZPs4xefH108dSMdMkgkNafFo0H.M8maAZLg_E71XWgmH4_vhv7VB.NRJw
 fNZPaslPLa66heVSXieyiJLV4gojmnLoVmiop3DrQV_xlC0_d45l4v67RuySgkklK5NQaQZIy6o0
 hJZSGB3UfZNFpv9kw7wvAN.ioutNpEhjC2v6IsuUlBftUGzT8x5GE_csH4O25KMs38gbqtMqm2EQ
 BytGIhjV40y7SD58AFg9sxbwzZUPOfW6fgpmpjQ7_BTJNshHOA8kyJkhpUhK5WZi56hQ_rEyDtqT
 h48jTE.Qv2iOsn267t4hoYyT0Hg45l1mO.91VPQct4MUKx3fxAsLWNM1lHVpgxaHrTj23yKoI.EG
 c8d9opqQEy4R_6BU7WjHIxUq8dOs9Ifhc1QEInMYJw9PUGdgi8hLAvz4JFZlQrlhmL.Rc8n6xpOS
 fV4XkG5yXNdOVehMdCN7w_Ra2U6DQ.6b5AWIJhQQJgCy5TT30dT2RSn6fpziK6.npjP0QX5n6YdX
 YzWjRklIrBQA33rmIpV.vhwFbqEzwZ1sp_5mUpYZk27YHkf34HnptRAj_cmE32_cDX2onHQnUxuF
 sXk_OnTcxuEaIr0BC49wAeCpNSR.14Eg5wHQILucLg1kOoknK5ptDLCOIRVqzZQo4j.4KCzFaJ3O
 MKtBtEeDzTYlud77yNi01LnvyvewaV3oNrDZC0INO.5BT0nANmO9X9cYFPyN6xZMq44WoNNC3Plo
 ByuedVV79ZKRzP6Z.nqFSezYGoAeBionHPH_J0FuR6JjRSgBnjw2RzmfTUPI9VCyv4VUxxYNi8jo
 v1C82SkAXr9muQwncHrXvVdRH6jO84wwVZRY4xKd4LI1NSojcKbKXVByO3vi75ahYnFiVTpkZpQo
 BP1pCbPvzWd3TvtSSNvb2gQ3c0SxcylVC72kDRIqKuqNr_5neACAPW0eDGG0U01sA90IHtQV6Ki0
 FRMwfFgh.8vIQSPPvlxcsuBVIlhVdB_NSHjHwrji_7j236VwCyyVNrGSv17hpToiqwt.Nd4cgv.8
 ASCsoujjZM8h8RjWSSF1t_eerzcFzEIPc5otlD1FHW4LN4mO7WRhnZUDGtikr6O.WFMQ9Wymbpqv
 6x4aEXiNwB0RaXGXPmNFOras6jES.1ezwgXDYTajNbRjyif75WYBHwyIz2bWX8yqnDS1FDIoxTDF
 VT62vMKYJwSlspKDuaJsF2MunlqI8ftPWhZnixp8h4x72BQI3bbOogsAG3fwfuVVE1zIGAzILu93
 gOZWuB2iVSj_ldkPtA_phu_PS0SyZwerpj_u4Sm9jNm84t7flR6i1KaNO0drAqFJWe9JPnSJwCRb
 GVfBIr.OJCABIZLeOFri7Gw1JlPz4eZIiNZ2a79.D7e2kt_pCU3lW4SBuQ1LBqppjnuXM7h5ymfM
 SCHiO_FZE9eKiA8dM_7SQxeatQFDoUoyw1KVYEzSCFnJhckj1GZgvM0AYARjU_jMk8zQg88_CfkC
 a2OeNd0xhIzjAuzwpN3IuMGsFCzxOL2Oh8TWMZ6bc6ciPzp2afRXllFWTEyoCtGBFLaEI1v_McT8
 LU0gqC90OGTE9oO4PvearxHAXQQfMYqSlsFEYmOyJxpaeiusk_.U7NRmZjJQn16Ms7sW4KFwmoLI
 I_KHC5BjXxklpKtzX.1AkPKdo4wCyNAH4cV5X9ukQCf7lI6I8ScZ3n3zNonEd0PQ1K4J9WU2LCJZ
 CXfEdVaEhBnNtiDgjkMJ8m.wLcNQ8eMSE6bUO__fGktA3wDNUip7E3y92wVd2ItePYTCQEPgnVpj
 U7hScIi2ikN32JqUjJ3_.AbbW4kX.0MljB8n2EN6kcku_xIm0R3ojDv3Rt451W54ipYYEovssml3
 wIBW954k91QZ_uyB.FK_CP5KyugolCc0i8FWRP5Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a18b1d7b-3996-4d23-b591-483c8b327bcd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Sep 2024 23:52:14 +0000
Received: by hermes--production-gq1-5d95dc458-vkwd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b3a84955471b9061a763fb967f12395;
          Tue, 17 Sep 2024 23:52:10 +0000 (UTC)
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
Subject: [PATCH 3/5] LSM: lsm_context in security_dentry_init_security
Date: Tue, 17 Sep 2024 16:52:00 -0700
Message-ID: <20240917235202.32578-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917235202.32578-1-casey@schaufler-ca.com>
References: <20240917235202.32578-1-casey@schaufler-ca.com>
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
index 6e817bf1337c..0a6f61e247a7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1135,8 +1135,7 @@ struct ceph_acl_sec_ctx {
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
index 2b0d4781f394..6f95cd92e089 100644
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
index 4cb97ef41350..83e420bbcba6 100644
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
index b4914a11c3c2..056ddc876cb5 100644
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
index 5902a9beca1f..93911f3133ab 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -353,13 +353,15 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
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
index 18888588a642..293307042c20 100644
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
@@ -6246,7 +6241,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, {buf, buflen, -1} };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6274,7 +6269,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return label.len;
+	return label.lsmctx.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
@@ -6351,7 +6346,8 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0,
+				    {(char *)buf, buflen, -1}};
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 7704a4509676..db86b9cea716 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1162,7 +1162,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->lsmctx.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1194,8 +1194,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
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
@@ -4280,11 +4281,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
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
@@ -4292,10 +4293,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
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
index 8090952b989e..6b671f4ada03 100644
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
index f9df88091c6d..002cf1bff00a 100644
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
index 94bcb4c69a9c..c9c4845da3a6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -225,25 +225,6 @@ struct lsm_context {
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
@@ -397,8 +378,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -863,8 +844,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
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
index 5a739279ed49..020e7a89de16 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1631,8 +1631,7 @@ void security_inode_free(struct inode *inode)
  * @mode: mode used to determine resource type
  * @name: name of the last path component
  * @xattr_name: name of the security/LSM xattr
- * @ctx: pointer to the resulting LSM context
- * @ctxlen: length of @ctx
+ * @lsmctx: pointer to the resulting LSM context
  *
  * Compute a context for a dentry as the inode is not yet available since NFSv4
  * has no label backed by an EA anyway.  It is important to note that
@@ -1642,11 +1641,11 @@ void security_inode_free(struct inode *inode)
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
index 159837b4ee41..e56403659164 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2871,8 +2871,8 @@ static void selinux_inode_free_security(struct inode *inode)
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
-					const char **xattr_name, void **ctx,
-					u32 *ctxlen)
+					const char **xattr_name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2887,8 +2887,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
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


