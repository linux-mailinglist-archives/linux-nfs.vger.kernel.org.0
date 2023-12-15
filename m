Return-Path: <linux-nfs+bounces-659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204381539A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 23:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E4286D58
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA8A13B148;
	Fri, 15 Dec 2023 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sVo+2tTQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51018EA2
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679370; bh=ijG5KPhLf8WT9NPh/OPeKCb8y6uCh4mFGx52DZt41Xw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sVo+2tTQ9ZU/YywgcLnwVdW7tbsVuhWTZUsJnzTBvYQhZBW9MDHgXQDdeYkGx25McXhVBTebIdUXLoP/hFvUNi1pO5mwtRtvxmcNh7oWLHvztnJYqa9o37T6FYAJXci3ImvAeGweY7MMM9IXh3pj43qRaJhaMj8fKbTiC/em4Yo/2tPrkBwRwJxQH1PQAjJGBBAYvqW82iN5d3ckona1zruu3S//JhMjqFl3V+pB5l2HqeNw+u8UZ0q9rXXAqC8H08FHuYy1Qlt3hWsTIzPomyL9ILIT+yRpBS3Ex/u/AvfwJHexTxzhn43B27H3g3/by6AtdBR1/xwkKJsiaVAezw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679370; bh=n1hH47rWY9fgnuQ/rz4Sv5DTPAPyyO3vRCiHHcVesHU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Peo3mDFvjl7iEq5fQQ3A1FoORcw4KsEhDrkb4vcs1WRidJL0N2iZ0NvHzil7v3sa72CEz0Ic83Pvkfq2YVUHRkg7FPYe6YHzars83frips2xdt6CXv+7UUXhosUo5OCNs8nCcQQHQfN0cdmnBZRfX9OEYqepDhLYrq3IavrQn4FnX44oi9wznqYWyFErvddV/4gDlv638ysL5pcf9MV63Mazu/V54z+0q0IwQINb+eLvIcBnFDrcMWen1bFS4jxibArX0IYWYIw8voMTANC5cdYE8HJerlcETlfobkuehbNbbdSwwvsoeuycvud60AuhZLptHwKYutl94kBzcmI3xA==
X-YMail-OSG: OUAxtq8VM1nN_jBvRUPGfj4Ygg1sHkG551Je8uio1spMIuN1W.BOGm7G5iQvCVG
 08Gbha7YCzyM1ezfvemA3mzZejxatEuvdfxiH2XklWCvzMsgT9dMnXXZ_KzVadeRNB6NXbs4YvUc
 919GZc8IkYKQHkwWE9LKfqrvjOhI18wOXJup664b3M4Lm6n0FPq15Z39MsUpIdvU299QGbiMGU_t
 lBIsSBhgrGYmAKC2rfbsVkKPTw_4DzN4ddQf4qwvbXT60CaviIBBGXP7j7pdGbEJ1L232tVKdG3U
 .W_MxY3HOZKq52V7DveaEnzlqIAinUZAtgYe94Mi7BG7qBcZrrjwiDbQ0PB2hHK93tciFpyPG00I
 KJFd8Y0lyYMnQS53tDz0yNsIiJ1dx52H0Wd5snHefb2uXNNQGf3U66ZaNqBDyXw4PwZroTWkzaeZ
 8a0yELOyVBoewY38Z3gZjwr_6vhof3WGAcGcx4yoCEa6a.h.pG.wRaIMAloorbGKJ_egMEDKAyB5
 DpVzQKZH2D.uiM9dFAdKePaNcHBrRg2o6MOkQUFair9z7wXPVzSf3HUxNB9OJO3pwS3rXqRPKffd
 1PjE0URlNE2b5W.PMYI6CZRj7qEHazIkUUysaE60kGgU5bDiahxDilYWqbi5KZBo16c8jpjt2jye
 3BQ2Rqgv5AI5Bgo.HX0YGaAhSzX6wnlygqDtQRpbCgDTq4v8mIFl05avOpasYn8A6BX5DpwMkJW8
 dn2pXc56Mu2a6Ezpd6bF2rEb0uFuC_exbUTb_CPpqf0IiGaPD14Z6GLDG37.Lbk4QikgI453CPk1
 5hy.h8VIipGsFM6pgZ04igLGrYHPvtf0G4y_UWeDO3UfeTJlVGSVQn2.hUSE2GxKZ2lzSoKS3at9
 avzRQBiceShB1S7eKWMH64tHTQeZQH7j.VoweRptdp5yMc0bRBphe1tPcJmJqXF0UPKJckqIiACn
 kn6YNp5t.1Ob2JLV2LUeXZ.8H5HgyBW1on0a_ZysnFkK.LOuMTTnvQP.TVElBL9AMSDav.RjIsyD
 8orC7i7YHarwWpO2Z1sENvcfPp6i4.Orn3NnQHsLrthapFBERJtuC4DqJJ.H3ZValpg0jf0jIO7h
 c4otp7HHhNfbovB3b8KDHWB4_SAgz88naG5jFJQka3Rgts627boFx31Y0C.Wn9XNg2Onj28dVc2A
 lgz5fJWLnrCosyXYYCwxANt2m8czuHeSBY0cGplAlZg0qjoFnUmglPdBDTp5salR0vPdrBOA_pyK
 gPf.AShcwTMIbg7Q3z5NMeyhSlIPSCUrPXGYIyEmmB_hSrx8oZA1TeVfsFS0w2GQmqePgBGM7pjU
 xB_2VwhrkW_b1vrTLTPt9wGkFS6wQ2elS3n6zC8HkFpcpL57WB1yw3GvCTLtNpNVNiFnMaVGfXZr
 3Mq3fSzR_ctLp.OMAlPgGV0xDW4LbdbHudLYVvzinABBZYVnvhpl6naUWROZgw.APNZbj9nDHVTx
 PrdfE.p5MpCVVO324RWqW0fo8t_9hRBotct3ww2pmcV_ege9.rTCMlOk96qYwpLPhavQ1LpmaJy0
 gdBFmTOLbG9taQ8mSHPBwv3vCU0HPWrB7gwEarAdSMviGAPpGjcYBeR.1SPFd9bwLGp7VJVyLydH
 .Lsz9fqr.Jn9jJUc9IZWF6sTm.LQEEQ5nyL8BtKVWLn8mHwnyuHrXxSdGLdhzE6y7xGb50G9o2BG
 XVURd5AzrtM4AGiyMVgop0pgTcWyz.V1lNU_UvKQBb0pBPBRJlnES20GMC.4qE7K9mq1WdZqW0kW
 3fD8RtBm5SmdD4qxkP9Cn7gGZEvjOnbOb4Blirph9SUI2_jYo5WHmA8HJAWLdwWM1sA8Tv.49r_e
 CKBtqPiFPHTqEO2uq_IaF8PQ2l2.LdhK.GvxRQniJY4RtyhfI58db46iXlomOYbBMTCei1GBIOk7
 jjX4XoKpWopf7m6FhdQEYV3DInl2g7H5DRE8mcK3e2g_urZzGN9Y5xA4.FRnAc7290ZCTERDjMl2
 yIkldk0XdM1K22TYWIoBMcf.1dVgFj1PRegFaa.L5n4W0z85PZ8OjuleevBFVSs4kK9R1GYwjXlX
 Y1S6s6d6C61gBNibAvHoc6jsC1Y98rQaLZ4dpOYb4BH2a78GjJPXOGhW0i7CRIX08QDiZQUrtqTy
 H.WGSPSldKJkJ64ht2giwCmH6JCeIB3WRAsjuqDnrWQtOWygHa.5Im3NJ64JwaxUq2SSv8Ha0u6_
 yDTnvjI3p9YXp0Ut5n668uXc8op8PvUSTLkvm7XqNE_uVHYEGMGT_OtbyTjLJB9.Ri8uQeAgLMAq
 q6BA.S3rXIyE60eIzkzwMwO0zv7uiBg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 80a7ca31-8c66-42a1-9e3d-01cace7e99be
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:29:30 +0000
Received: by hermes--production-gq1-6949d6d8f9-nsbdm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d22b1f6ad07bda71c6e1d3c51ac27d9d;
          Fri, 15 Dec 2023 22:29:23 +0000 (UTC)
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
	Chuck Lever <chuck.lever@oracle.com>,
	linux-integrity@vger.kernel.org,
	netdev@vger.kernel.org,
	audit@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH v39 16/42] LSM: Ensure the correct LSM context releaser
Date: Fri, 15 Dec 2023 14:16:10 -0800
Message-ID: <20231215221636.105680-17-casey@schaufler-ca.com>
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

Add a new lsmcontext data structure to hold all the information
about a "security context", including the string, its size and
which LSM allocated the string. The allocation information is
necessary because LSMs have different policies regarding the
lifecycle of these strings. SELinux allocates and destroys
them on each use, whereas Smack provides a pointer to an entry
in a list that never goes away.

Update security_release_secctx() to use the lsmcontext instead
of a (char *, len) pair. Change its callers to do likewise.
The LSMs supporting this hook have had comments added to
remind the developer that there is more work to be done.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: linux-nfs@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c                | 24 ++++++-------
 fs/ceph/xattr.c                         |  6 +++-
 fs/nfs/nfs4proc.c                       |  8 +++--
 fs/nfsd/nfs4xdr.c                       |  8 +++--
 include/linux/lsm_hook_defs.h           |  2 +-
 include/linux/security.h                | 35 +++++++++++++++++--
 include/net/scm.h                       | 11 +++---
 kernel/audit.c                          | 34 ++++++++++---------
 kernel/auditsc.c                        | 23 +++++++------
 net/ipv4/ip_sockglue.c                  | 10 +++---
 net/netfilter/nf_conntrack_netlink.c    | 10 +++---
 net/netfilter/nf_conntrack_standalone.c |  9 +++--
 net/netfilter/nfnetlink_queue.c         | 13 ++++---
 net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++--------------
 net/netlabel/netlabel_user.c            | 11 +++---
 security/apparmor/include/secid.h       |  2 +-
 security/apparmor/secid.c               | 11 ++++--
 security/security.c                     |  8 ++---
 security/selinux/hooks.c                | 11 ++++--
 19 files changed, 170 insertions(+), 111 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..58bdb5b75131 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2920,8 +2920,7 @@ static void binder_transaction(struct binder_proc *proc,
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	ktime_t t_start_time = ktime_get();
-	char *secctx = NULL;
-	u32 secctx_sz = 0;
+	struct lsmcontext lsmctx;
 	struct list_head sgc_head;
 	struct list_head pf_head;
 	const void __user *user_buffer = (const void __user *)
@@ -3200,7 +3199,8 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &secid);
-		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
+		ret = security_secid_to_secctx(secid, &lsmctx.context,
+					       &lsmctx.len);
 		if (ret) {
 			binder_txn_error("%d:%d failed to get security context\n",
 				thread->pid, proc->pid);
@@ -3209,7 +3209,7 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_get_secctx_failed;
 		}
-		added_size = ALIGN(secctx_sz, sizeof(u64));
+		added_size = ALIGN(lsmctx.len, sizeof(u64));
 		extra_buffers_size += added_size;
 		if (extra_buffers_size < added_size) {
 			binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
@@ -3243,23 +3243,23 @@ static void binder_transaction(struct binder_proc *proc,
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
-	if (secctx) {
+	if (lsmctx.context) {
 		int err;
 		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
 				    ALIGN(tr->offsets_size, sizeof(void *)) +
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
-				    ALIGN(secctx_sz, sizeof(u64));
+				    ALIGN(lsmctx.len, sizeof(u64));
 
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
-						  secctx, secctx_sz);
+						  lsmctx.context, lsmctx.len);
 		if (err) {
 			t->security_ctx = 0;
 			WARN_ON(1);
 		}
-		security_release_secctx(secctx, secctx_sz);
-		secctx = NULL;
+		security_release_secctx(&lsmctx);
+		lsmctx.context = NULL;
 	}
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
@@ -3303,7 +3303,7 @@ static void binder_transaction(struct binder_proc *proc,
 	off_end_offset = off_start_offset + tr->offsets_size;
 	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
 	sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
-		ALIGN(secctx_sz, sizeof(u64));
+		ALIGN(lsmctx.len, sizeof(u64));
 	off_min = 0;
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
@@ -3682,8 +3682,8 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
 err_binder_alloc_buf_failed:
 err_bad_extra_size:
-	if (secctx)
-		security_release_secctx(secctx, secctx_sz);
+	if (lsmctx.context)
+		security_release_secctx(&lsmctx);
 err_get_secctx_failed:
 	kfree(tcomplete);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e066a556eccb..113956d386c0 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1446,12 +1446,16 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 {
+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+	struct lsmcontext scaff; /* scaffolding */
+#endif
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	posix_acl_release(as_ctx->acl);
 	posix_acl_release(as_ctx->default_acl);
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
+	security_release_secctx(&scaff);
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
 	kfree(as_ctx->fscrypt_auth);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8a943fffaad5..6ea99e2aabf3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -138,8 +138,12 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	if (label)
-		security_release_secctx(label->label, label->len);
+	struct lsmcontext scaff; /* scaffolding */
+
+	if (label) {
+		lsmcontext_init(&scaff, label->label, label->len, 0);
+		security_release_secctx(&scaff);
+	}
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ec4ed6206df1..9cade754356a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3627,8 +3627,12 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (args.context)
-		security_release_secctx(args.context, args.contextlen);
+	if (args.context) {
+		struct lsmcontext scaff; /* scaffolding */
+
+		lsmcontext_init(&scaff, args.context, args.contextlen, 0);
+		security_release_secctx(&scaff);
+	}
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(args.acl);
 	if (tempfh) {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fe9c1d89dc66..c5e5a32f5e07 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -278,7 +278,7 @@ LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
 	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
+LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsmcontext *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
diff --git a/include/linux/security.h b/include/linux/security.h
index 67ecf8588c90..9712056d71a0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -148,6 +148,37 @@ struct lsmblob_scaffold {
 	u32 secid;
 };
 
+/*
+ * A "security context" is the text representation of
+ * the information used by LSMs.
+ * This structure contains the string, its length, and which LSM
+ * it is useful for.
+ */
+struct lsmcontext {
+	char	*context;	/* Provided by the module */
+	u32	len;
+	int	id;		/* Identifies the module */
+};
+
+/**
+ * lsmcontext_init - initialize an lsmcontext structure.
+ * @cp: Pointer to the context to initialize
+ * @context: Initial context, or NULL
+ * @size: Size of context, or 0
+ * @id: Which LSM provided the context
+ *
+ * Fill in the lsmcontext from the provided information.
+ * This is a scaffolding function that will be removed when
+ * lsmcontext integration is complete.
+ */
+static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
+				   u32 size, int id)
+{
+	cp->id = id;
+	cp->context = context;
+	cp->len = size;
+}
+
 /*
  * Data exported by the security modules
  */
@@ -535,7 +566,7 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 			       u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
-void security_release_secctx(char *secdata, u32 seclen);
+void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
@@ -1475,7 +1506,7 @@ static inline int security_secctx_to_secid(const char *secdata,
 	return -EOPNOTSUPP;
 }
 
-static inline void security_release_secctx(char *secdata, u32 seclen)
+static inline void security_release_secctx(struct lsmcontext *cp)
 {
 }
 
diff --git a/include/net/scm.h b/include/net/scm.h
index e8c76b4be2fe..6e1add51d4c2 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -93,16 +93,17 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 #ifdef CONFIG_SECURITY_NETWORK
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 {
-	char *secdata;
-	u32 seclen;
+	struct lsmcontext ctx;
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		err = security_secid_to_secctx(scm->secid, &ctx.context,
+					       &ctx.len);
 
 		if (!err) {
-			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
-			security_release_secctx(secdata, seclen);
+			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, ctx.len,
+				 ctx.context);
+			security_release_secctx(&ctx);
 		}
 	}
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 54dfe339e341..47cfb6b20c3c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1209,8 +1209,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
 	struct audit_sig_info   *sig_data;
-	char			*ctx = NULL;
-	u32			len;
+	struct lsmcontext	lsmctx;
 
 	err = audit_netlink_ok(skb, msg_type);
 	if (err)
@@ -1458,30 +1457,34 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		kfree(new);
 		break;
 	}
-	case AUDIT_SIGNAL_INFO:
-		len = 0;
+	case AUDIT_SIGNAL_INFO: {
+		size_t sig_data_size;
+
 		if (lsmblob_is_set(&audit_sig_lsm)) {
-			err = security_lsmblob_to_secctx(&audit_sig_lsm, &ctx,
-							 &len);
+			err = security_lsmblob_to_secctx(&audit_sig_lsm,
+							 &lsmctx.context,
+							 &lsmctx.len);
 			if (err)
 				return err;
 		}
-		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
+		sig_data_size = struct_size(sig_data, ctx, lsmctx.len);
+		sig_data = kmalloc(sig_data_size, GFP_KERNEL);
 		if (!sig_data) {
 			if (lsmblob_is_set(&audit_sig_lsm))
-				security_release_secctx(ctx, len);
+				security_release_secctx(&lsmctx);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
-			memcpy(sig_data->ctx, ctx, len);
-			security_release_secctx(ctx, len);
+			memcpy(sig_data->ctx, lsmctx.context, lsmctx.len);
+			security_release_secctx(&lsmctx);
 		}
 		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
-				 sig_data, struct_size(sig_data, ctx, len));
+				 sig_data, sig_data_size);
 		kfree(sig_data);
 		break;
+	}
 	case AUDIT_TTY_GET: {
 		struct audit_tty_status s;
 		unsigned int t;
@@ -2164,24 +2167,23 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	struct lsmcontext ctx;
 	struct lsmblob blob;
-	char *ctx = NULL;
-	unsigned len;
 	int error;
 
 	security_current_getlsmblob_subj(&blob);
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_lsmblob_to_secctx(&blob, &ctx, &len);
+	error = security_lsmblob_to_secctx(&blob, &ctx.context, &ctx.len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
 		return 0;
 	}
 
-	audit_log_format(ab, " subj=%s", ctx);
-	security_release_secctx(ctx, len);
+	audit_log_format(ab, " subj=%s", ctx.context);
+	security_release_secctx(&ctx);
 	return 0;
 
 error_path:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bfe2ee3ccbe6..2874255f5f25 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1098,8 +1098,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 char *comm)
 {
 	struct audit_buffer *ab;
-	char *ctx = NULL;
-	u32 len;
+	struct lsmcontext ctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1110,12 +1109,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_lsmblob_to_secctx(blob, &ctx, &len)) {
+		if (security_lsmblob_to_secctx(blob, &ctx.context, &ctx.len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			security_release_secctx(ctx, len);
+			audit_log_format(ab, " obj=%s", ctx.context);
+			security_release_secctx(&ctx);
 		}
 	}
 	audit_log_format(ab, " ocomm=");
@@ -1371,6 +1370,7 @@ static void audit_log_time(struct audit_context *context, struct audit_buffer **
 
 static void show_special(struct audit_context *context, int *call_panic)
 {
+	struct lsmcontext lsmcxt;
 	struct audit_buffer *ab;
 	int i;
 
@@ -1401,7 +1401,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
-				security_release_secctx(ctx, len);
+				lsmcontext_init(&lsmcxt, ctx, len, 0);
+				security_release_secctx(&lsmcxt);
 			}
 		}
 		if (context->ipc.has_perm) {
@@ -1560,15 +1561,15 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
 	if (lsmblob_is_set(&n->oblob)) {
-		char *ctx = NULL;
-		u32 len;
+		struct lsmcontext ctx;
 
-		if (security_lsmblob_to_secctx(&n->oblob, &ctx, &len)) {
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx.context,
+					       &ctx.len)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			security_release_secctx(ctx, len);
+			audit_log_format(ab, " obj=%s", ctx.context);
+			security_release_secctx(&ctx);
 		}
 	}
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2efc53526a38..3bf8ff9d4434 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,20 +130,20 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
-	char *secdata;
-	u32 seclen, secid;
+	struct lsmcontext ctx;
+	u32 secid;
 	int err;
 
 	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	err = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
 	if (err)
 		return;
 
-	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
-	security_release_secctx(secdata, seclen);
+	put_cmsg(msg, SOL_IP, SCM_SECURITY, ctx.len, ctx.context);
+	security_release_secctx(&ctx);
 }
 
 static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index fb0ae15e96df..3e79b339a1bc 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -357,10 +357,10 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct,
 static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 {
 	struct nlattr *nest_secctx;
-	int len, ret;
-	char *secctx;
+	struct lsmcontext ctx;
+	int ret;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
 	if (ret)
 		return 0;
 
@@ -369,13 +369,13 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	if (!nest_secctx)
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
+	if (nla_put_string(skb, CTA_SECCTX_NAME, ctx.context))
 		goto nla_put_failure;
 	nla_nest_end(skb, nest_secctx);
 
 	ret = 0;
 nla_put_failure:
-	security_release_secctx(secctx, len);
+	security_release_secctx(&ctx);
 	return ret;
 }
 #else
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 0ee98ce5b816..23949d233375 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -175,17 +175,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 {
+	struct lsmcontext ctx;
 	int ret;
-	u32 len;
-	char *secctx;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
 	if (ret)
 		return;
 
-	seq_printf(s, "secctx=%s ", secctx);
+	seq_printf(s, "secctx=%s ", ctx.context);
 
-	security_release_secctx(secctx, len);
+	security_release_secctx(&ctx);
 }
 #else
 static inline void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 171d1f52d3dd..8b4c5c08daa7 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -408,6 +408,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info ctinfo = 0;
 	const struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
+	struct lsmcontext scaff; /* scaffolding */
 	char *secdata = NULL;
 	u32 seclen = 0;
 	ktime_t tstamp;
@@ -651,8 +652,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen)
-		security_release_secctx(secdata, seclen);
+	if (seclen) {
+		lsmcontext_init(&scaff, secdata, seclen, 0);
+		security_release_secctx(&scaff);
+	}
 	return skb;
 
 nla_put_failure:
@@ -660,8 +663,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen)
-		security_release_secctx(secdata, seclen);
+	if (seclen) {
+		lsmcontext_init(&scaff, secdata, seclen, 0);
+		security_release_secctx(&scaff);
+	}
 	return NULL;
 }
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7bac13ae07a3..464105080245 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -374,8 +374,7 @@ int netlbl_unlhsh_add(struct net *net,
 	struct net_device *dev;
 	struct netlbl_unlhsh_iface *iface;
 	struct audit_buffer *audit_buf = NULL;
-	char *secctx = NULL;
-	u32 secctx_len;
+	struct lsmcontext ctx;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -438,11 +437,10 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
-					     &secctx,
-					     &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+		if (security_secid_to_secctx(secid, &ctx.context,
+					     &ctx.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
+			security_release_secctx(&ctx);
 		}
 		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -473,8 +471,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct netlbl_unlhsh_addr4 *entry;
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
-	char *secctx;
-	u32 secctx_len;
+	struct lsmcontext ctx;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -494,10 +491,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+		    security_secid_to_secctx(entry->secid, &ctx.context,
+					     &ctx.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
+			security_release_secctx(&ctx);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -534,8 +531,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct netlbl_unlhsh_addr6 *entry;
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
-	char *secctx;
-	u32 secctx_len;
+	struct lsmcontext ctx;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -554,10 +550,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+		    security_secid_to_secctx(entry->secid, &ctx.context,
+					     &ctx.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
+			security_release_secctx(&ctx);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -1069,10 +1065,9 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	int ret_val = -ENOMEM;
 	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
 	struct net_device *dev;
+	struct lsmcontext ctx;
 	void *data;
 	u32 secid;
-	char *secctx;
-	u32 secctx_len;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
 			  NLBL_UNLABEL_A_SECCTX,
-			  secctx_len,
-			  secctx);
-	security_release_secctx(secctx, secctx_len);
+			  ctx.len,
+			  ctx.context);
+	security_release_secctx(&ctx);
 	if (ret_val != 0)
 		goto list_cb_failure;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 6cd1fcb3902b..b9289a22b363 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,8 +84,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	char *secctx;
-	u32 secctx_len;
+	struct lsmcontext ctx;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -99,10 +98,10 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsmblob_is_set(&audit_info->blob) &&
-	    security_lsmblob_to_secctx(&audit_info->blob, &secctx,
-				       &secctx_len) == 0) {
-		audit_log_format(audit_buf, " subj=%s", secctx);
-		security_release_secctx(secctx, secctx_len);
+	    security_lsmblob_to_secctx(&audit_info->blob, &ctx.context,
+				       &ctx.len) == 0) {
+		audit_log_format(audit_buf, " subj=%s", ctx.context);
+		security_release_secctx(&ctx);
 	}
 
 	return audit_buf;
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 816a425e2023..e47c37c1beda 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -29,7 +29,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
-void apparmor_release_secctx(char *secdata, u32 seclen);
+void apparmor_release_secctx(struct lsmcontext *cp);
 
 
 int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index a7c6f5061882..e9f655f54a42 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -139,9 +139,16 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 	return 0;
 }
 
-void apparmor_release_secctx(char *secdata, u32 seclen)
+void apparmor_release_secctx(struct lsmcontext *cp)
 {
-	kfree(secdata);
+	/*
+	 * stacking scaffolding:
+	 * When it is possible for more than one LSM to provide a
+	 * release hook, do this check:
+	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
+	 */
+
+	kfree(cp->context);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 1cbd45310f63..063a209ac17f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4250,14 +4250,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 /**
  * security_release_secctx() - Free a secctx buffer
- * @secdata: secctx
- * @seclen: length of secctx
+ * @cp: the security context
  *
  * Release the security context.
  */
-void security_release_secctx(char *secdata, u32 seclen)
+void security_release_secctx(struct lsmcontext *cp)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	call_void_hook(release_secctx, cp);
+	memset(cp, 0, sizeof(*cp));
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1bc28f5f6870..1a428a6964a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6588,9 +6588,16 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 				       secid, GFP_KERNEL);
 }
 
-static void selinux_release_secctx(char *secdata, u32 seclen)
+static void selinux_release_secctx(struct lsmcontext *cp)
 {
-	kfree(secdata);
+	/*
+	 * stacking scaffolding:
+	 * When it is possible for more than one LSM to provide a
+	 * release hook, do this check:
+	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
+	 */
+
+	kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
-- 
2.41.0


