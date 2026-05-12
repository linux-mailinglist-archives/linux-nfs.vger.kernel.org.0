Return-Path: <linux-nfs+bounces-21523-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMmDGH1SA2qn4gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21523-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:17:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FA5247E3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 660063028E8B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A73B83EF;
	Tue, 12 May 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqbqmk+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3E3C98A4;
	Tue, 12 May 2026 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602379; cv=none; b=Fq2ZDswYHjkcLiwrPLk+ExdPl2W6ueixyNhkQFg46UWeMnkho7R+ruTG8IZBc8REiKFXxBmnH5mrjnKEuoLdYsWs0KV97BubJnx7vOG7pF7fHypPgJlDiCmOvDcei0Err6PqmowyoPU/thOdXom+jlI5L1UdGirrg0pRs8ZVq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602379; c=relaxed/simple;
	bh=rx1LcxvNKyp7HnoQpHH4ldwjpFp4oFQIx7TuemoUvTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqTOBrq7cX/D31M897tyI5tFLu1GLg3Mhasl9MTBgmemyNzpnPh/WHLBsLgEqQ9HYomkIA2dStG6el8dk0iO0iA4hhr3/xruShjyT3nk2p1staG3eeQ8lgljwJD66M5L33nvcNTDCr2eDaUV4UZIfLsWiYEYgH/4h1yv/y7R7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqbqmk+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12516C2BCFA;
	Tue, 12 May 2026 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602378;
	bh=rx1LcxvNKyp7HnoQpHH4ldwjpFp4oFQIx7TuemoUvTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eqbqmk+n/+ygaMoUxJs0+xLGwkxAIvBMCsxY5vnmEip0EIAaHc2S4z/8fre1cvlXw
	 sBaSqqASh7aZaIHaW6EMloNjXvtp4cAM5HqnZ3IH4Wbh/GcRXsCOVE2YLcwAL6gdr0
	 V5WvSWkr2OYjvQtYfckUKvVt2dsbIbZ5hEID5tFiKtBOc9LLGudoNRvjCEOBlNCd3V
	 3BYwYulfTQkH5cEnyw4SLZhXHgdKvRlP3hwEhxE6iTf6FXHUL2UJzi4SMNajfGssFX
	 fdasYhzFj4t+odHUg7j1WyjvnDJyS+e6O23x5dZ7N/hqG+0Q6acuIPJWHhp1XxYDm3
	 kPCYnEsS93XLQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 12 May 2026 12:12:43 -0400
Subject: [PATCH 2/4] nfs: remove nfs_compat_user_ino64() and deprecate
 enable_ino64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nfsino-v1-2-284720522f4c@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
In-Reply-To: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rx1LcxvNKyp7HnoQpHH4ldwjpFp4oFQIx7TuemoUvTM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqA1GHOfW0DyIMM0PsS6TAu/d4itmK/nx1ffAz4
 GbWtJ+ZEmOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagNRhwAKCRAADmhBGVaC
 FftSD/4ybbP94oK6QYIn7566Zcv6Fjugu0YT7virUrXynuI0xIxKmiH5TE6PjS38PqC8yT8Y+ex
 gIZvTI/m4Ip9M2a7nH5LzbqS4dYV+raTkMWX/W/PwGyFjAvO+njaDqcat2gu9XZTGm7f4qsn/Du
 utvE6zqKZDTtESdVnoOFc2B/BTfKCFQxc7jvXP8uawv16Nux9LZm/iBN0P3+f7UCdJEf8c9dcQe
 bv2JcsXuwO1BKJ6vSULvVf4MpkisKxYmsJC0YJrwJcJWcDhDtR6Sg99CxCinAqYDc36haXFz0do
 lfb7eSvL1aUFWQftXUUMi0DPI2hhmmxEmnQCIQyxL0zrpb7STRDfo2Au3l1seCkP8fLuUJykn9d
 HHtZoOAWBeYppKtu/qp0NJ9ZVanrrvntSO4s3DdbXEreu6mONg13dN5UGZNkB5R6suVESrHQbTN
 jW540sOyqNF0VOPEqTzrIfv+BJEiyc5jvMmqttEl6D7HEo+LA650sy76nWail1Oeg9ruzZ3J2IP
 k8IQp4a1W+mmHsBf3MIvqCHHqqhjuvBRzcDQ1XTz1k/RjoK2eUoNlCyBwZ2SCgxuo1/Ht/mnMPg
 SBWmmCzEZ4KePeaFvDzCF7ZSaNFgStg/fr0KrzWDpRCiqBJ8jd26GFlVkVhuZxO2vLAPMVc2n1D
 hGhFh8uiG34PH7Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 179FA5247E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21523-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Now that inode->i_ino stores the full 64-bit NFS fileid, the
nfs_compat_user_ino64() function is no longer needed.
generic_fillattr() already copies inode->i_ino into stat->ino, so the
explicit override in nfs_getattr() is also redundant.

Also remove the now-unused nfs_fileid_to_ino_t() and
nfs_fattr_to_ino_t() helper functions that were used to XOR-fold
64-bit fileids into the old unsigned long i_ino.

Keep the enable_ino64 module parameter as a deprecated stub that
accepts but ignores the value, logging a notice when set. This avoids
breaking existing configurations that pass nfs.enable_ino64 on the
kernel command line or in modprobe.d.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ----
 fs/nfs/dir.c                                    |  2 +-
 fs/nfs/inode.c                                  | 50 +++++++------------------
 include/linux/nfs_fs.h                          | 10 -----
 4 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..1e75cfb81d9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4308,13 +4308,6 @@ Kernel parameters
 			Only applies if the softerr mount option is enabled,
 			and the specified value is >= 0.
 
-	nfs.enable_ino64=
-			[NFS] enable 64-bit inode numbers.
-			If zero, the NFS client will fake up a 32-bit inode
-			number for the readdir() and stat() syscalls instead
-			of returning the full 64-bit number.
-			The default is to return 64-bit inode numbers.
-
 	nfs.idmap_cache_timeout=
 			[NFS] set the maximum lifetime for idmapper cache
 			entries.
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5f8c3ea0bce3..659e39b1562b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1106,7 +1106,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 
 		ent = &array->array[i];
 		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
-		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
+		    ent->ino, ent->d_type)) {
 			desc->eob = true;
 			break;
 		}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index dd9e378c36fb..a21ed1c7f89d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -57,21 +57,23 @@
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-#define NFS_64_BIT_INODE_NUMBERS_ENABLED	1
+static bool enable_ino64;
 
-/* Default is to see 64-bit inode numbers */
-static bool enable_ino64 = NFS_64_BIT_INODE_NUMBERS_ENABLED;
+static int param_set_enable_ino64(const char *val, const struct kernel_param *kp)
+{
+	pr_notice("enable_ino64 is deprecated and has no effect\n");
+	return 0;
+}
+
+static const struct kernel_param_ops param_ops_enable_ino64 = {
+	.set = param_set_enable_ino64,
+	.get = param_get_bool,
+};
 
 static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct kmem_cache * nfs_inode_cachep;
 
-static inline u64
-nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
-{
-	return fattr->fileid;
-}
-
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
 	if (unlikely(nfs_current_task_exiting()))
@@ -83,29 +85,6 @@ int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 }
 EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
-/**
- * nfs_compat_user_ino64 - returns the user-visible inode number
- * @fileid: 64-bit fileid
- *
- * This function returns a 32-bit inode number if the boot parameter
- * nfs.enable_ino64 is zero.
- */
-u64 nfs_compat_user_ino64(u64 fileid)
-{
-#ifdef CONFIG_COMPAT
-	compat_ulong_t ino;
-#else	
-	unsigned long ino;
-#endif
-
-	if (enable_ino64)
-		return fileid;
-	ino = fileid;
-	if (sizeof(ino) < sizeof(fileid))
-		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
-	return ino;
-}
-
 int nfs_drop_inode(struct inode *inode)
 {
 	return NFS_STALE(inode) || inode_generic_drop(inode);
@@ -418,7 +397,7 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
 	    !(fattr->valid & NFS_ATTR_FATTR_TYPE))
 		return NULL;
 
-	hash = nfs_fattr_to_ino_t(fattr);
+	hash = fattr->fileid;
 	inode = ilookup5(sb, hash, nfs_find_actor, &desc);
 
 	dprintk("%s: returning %p\n", __func__, inode);
@@ -466,7 +445,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) == 0)
 		goto out_no_inode;
 
-	hash = nfs_fattr_to_ino_t(fattr);
+	hash = fattr->fileid;
 
 	inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc);
 	if (inode == NULL) {
@@ -1061,7 +1040,6 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
 	stat->change_cookie = inode_peek_iversion_raw(inode);
 	stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (server->change_attr_type != NFS4_CHANGE_TYPE_IS_UNDEFINED)
@@ -2793,7 +2771,7 @@ static void __exit exit_nfs_fs(void)
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_DESCRIPTION("NFS client support");
 MODULE_LICENSE("GPL");
-module_param(enable_ino64, bool, 0644);
+module_param_cb(enable_ino64, &param_ops_enable_ino64, &enable_ino64, 0644);
 
 module_init(init_nfs_fs)
 module_exit(exit_nfs_fs)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8e48053b3069..6d6fa62ede10 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -473,7 +473,6 @@ extern void nfs_file_set_open_context(struct file *filp, struct nfs_open_context
 extern void nfs_file_clear_open_context(struct file *flip);
 extern struct nfs_lock_context *nfs_get_lock_context(struct nfs_open_context *ctx);
 extern void nfs_put_lock_context(struct nfs_lock_context *l_ctx);
-extern u64 nfs_compat_user_ino64(u64 fileid);
 extern void nfs_fattr_init(struct nfs_fattr *fattr);
 extern void nfs_fattr_set_barrier(struct nfs_fattr *fattr);
 extern unsigned long nfs_inc_attr_generation_counter(void);
@@ -668,15 +667,6 @@ static inline loff_t nfs_size_to_loff_t(__u64 size)
 	return min_t(u64, size, OFFSET_MAX);
 }
 
-static inline ino_t
-nfs_fileid_to_ino_t(u64 fileid)
-{
-	ino_t ino = (ino_t) fileid;
-	if (sizeof(ino_t) < sizeof(u64))
-		ino ^= fileid >> (sizeof(u64)-sizeof(ino_t)) * 8;
-	return ino;
-}
-
 static inline void nfs_ooo_clear(struct nfs_inode *nfsi)
 {
 	nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;

-- 
2.54.0


