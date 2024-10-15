Return-Path: <linux-nfs+bounces-7178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D712D99DCE7
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 05:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D461C21239
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD2170A19;
	Tue, 15 Oct 2024 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw5iXrlu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9C38DE9;
	Tue, 15 Oct 2024 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963619; cv=none; b=V5t/Fx8Q4gXgWrZ1+pxCPEiGWIowyIBL9uSRE1efaC0WOBQmTRS2aJS3JGhCMPhfm5mwwzdxVoirENfxx6YynaXYNO0fJYEVZEmJXS1jRSXfJ9q0BaZ1oR5Xkk4MU0dYetKTT/L5uFrG0DUlFsbZZIAa7+rxMi0s2AhnlLNnaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963619; c=relaxed/simple;
	bh=B5X2vtdgYsGsyYANp4J004prXjxNfyBC1DGPm3C4cIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSnTMu1nhoze0kPaiJ8oD4hWe/5gmRJnkIjRrsLUArQ5PBauUjq/Dw9WljfS3ber575vgxV1v1Y0g9zXIg/kJRzedNSuDKX0bEJWFTsszctvR1w1FvUjT0/4E+7y7FT7s6KDSwY8Z5XfdrJe7v9rRM0GAE1gKawF7Ixco0D/nX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw5iXrlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303B3C4CEC7;
	Tue, 15 Oct 2024 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728963617;
	bh=B5X2vtdgYsGsyYANp4J004prXjxNfyBC1DGPm3C4cIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw5iXrlupqBE9Gj31ni0qxuxPKN+k8WyMPD9SkAEX1GQt54C3VQ086KCtUUQsl2ZF
	 UBXIF8zXlBnp7gCW6UAeUYvDMml1L6n8G8kwa5bFhGaRsshwlo2xNotX2MC9CTby4Z
	 x8gdQ/ICW2QWUMzUT1aJrkf5kLbCwppn9rsG9mdVdrzwZ1c00jUkDtxUHnCMo4dvKv
	 ylD80BBtt1XBvHlUSc8OS+pgKPXItZYsWHDadyAu/kudzYXcDvBM3Ch/ByFPWpBQkB
	 I0GX7urU1i0ZdmnPIfbtLSYX5ZwaDIxrm4grGA9t8ysn1WnONKjd4No2zLjG5SdRw9
	 krSTl1bEwyNtw==
Date: Tue, 15 Oct 2024 03:40:11 +0000
From: sergeh@kernel.org
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, mic@digikod.net,
	linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
Message-ID: <Zw3kG5-Xh4iqDYSz@lei>
References: <20241014151450.73674-1-casey@schaufler-ca.com>
 <20241014151450.73674-2-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014151450.73674-2-casey@schaufler-ca.com>

On Mon, Oct 14, 2024 at 08:14:45AM -0700, Casey Schaufler wrote:
> Add a new lsm_context data structure to hold all the information about a
> "security context", including the string, its size and which LSM allocated
> the string. The allocation information is necessary because LSMs have
> different policies regarding the lifecycle of these strings. SELinux
> allocates and destroys them on each use, whereas Smack provides a pointer
> to an entry in a list that never goes away.
> 
> Update security_release_secctx() to use the lsm_context instead of a
> (char *, len) pair. Change its callers to do likewise.  The LSMs
> supporting this hook have had comments added to remind the developer
> that there is more work to be done.
> 
> The BPF security module provides all LSM hooks. While there has yet to
> be a known instance of a BPF configuration that uses security contexts,
> the possibility is real. In the existing implementation there is
> potential for multiple frees in that case.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks.

Reviewed-by: Serge Hallyn <sergeh@kernel.org>

for the set (as far as affects lsm, of course).

> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c                | 24 ++++++-------
>  fs/ceph/xattr.c                         |  6 +++-
>  fs/nfs/nfs4proc.c                       |  8 +++--
>  fs/nfsd/nfs4xdr.c                       |  8 +++--
>  include/linux/lsm_hook_defs.h           |  2 +-
>  include/linux/security.h                | 35 +++++++++++++++++--
>  include/net/scm.h                       | 11 +++---
>  kernel/audit.c                          | 30 ++++++++---------
>  kernel/auditsc.c                        | 23 +++++++------
>  net/ipv4/ip_sockglue.c                  | 10 +++---
>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++--------------
>  net/netlabel/netlabel_user.c            | 11 +++---
>  security/apparmor/include/secid.h       |  2 +-
>  security/apparmor/secid.c               | 11 ++++--
>  security/security.c                     |  8 ++---
>  security/selinux/hooks.c                | 11 ++++--
>  19 files changed, 167 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 978740537a1a..d4229bf6f789 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3011,8 +3011,7 @@ static void binder_transaction(struct binder_proc *proc,
>  	struct binder_context *context = proc->context;
>  	int t_debug_id = atomic_inc_return(&binder_last_id);
>  	ktime_t t_start_time = ktime_get();
> -	char *secctx = NULL;
> -	u32 secctx_sz = 0;
> +	struct lsm_context lsmctx;
>  	struct list_head sgc_head;
>  	struct list_head pf_head;
>  	const void __user *user_buffer = (const void __user *)
> @@ -3291,7 +3290,8 @@ static void binder_transaction(struct binder_proc *proc,
>  		size_t added_size;
>  
>  		security_cred_getsecid(proc->cred, &secid);
> -		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		ret = security_secid_to_secctx(secid, &lsmctx.context,
> +					       &lsmctx.len);
>  		if (ret) {
>  			binder_txn_error("%d:%d failed to get security context\n",
>  				thread->pid, proc->pid);
> @@ -3300,7 +3300,7 @@ static void binder_transaction(struct binder_proc *proc,
>  			return_error_line = __LINE__;
>  			goto err_get_secctx_failed;
>  		}
> -		added_size = ALIGN(secctx_sz, sizeof(u64));
> +		added_size = ALIGN(lsmctx.len, sizeof(u64));
>  		extra_buffers_size += added_size;
>  		if (extra_buffers_size < added_size) {
>  			binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
> @@ -3334,23 +3334,23 @@ static void binder_transaction(struct binder_proc *proc,
>  		t->buffer = NULL;
>  		goto err_binder_alloc_buf_failed;
>  	}
> -	if (secctx) {
> +	if (lsmctx.context) {
>  		int err;
>  		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
>  				    ALIGN(tr->offsets_size, sizeof(void *)) +
>  				    ALIGN(extra_buffers_size, sizeof(void *)) -
> -				    ALIGN(secctx_sz, sizeof(u64));
> +				    ALIGN(lsmctx.len, sizeof(u64));
>  
>  		t->security_ctx = t->buffer->user_data + buf_offset;
>  		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
>  						  t->buffer, buf_offset,
> -						  secctx, secctx_sz);
> +						  lsmctx.context, lsmctx.len);
>  		if (err) {
>  			t->security_ctx = 0;
>  			WARN_ON(1);
>  		}
> -		security_release_secctx(secctx, secctx_sz);
> -		secctx = NULL;
> +		security_release_secctx(&lsmctx);
> +		lsmctx.context = NULL;
>  	}
>  	t->buffer->debug_id = t->debug_id;
>  	t->buffer->transaction = t;
> @@ -3394,7 +3394,7 @@ static void binder_transaction(struct binder_proc *proc,
>  	off_end_offset = off_start_offset + tr->offsets_size;
>  	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
>  	sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
> -		ALIGN(secctx_sz, sizeof(u64));
> +		ALIGN(lsmctx.len, sizeof(u64));
>  	off_min = 0;
>  	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
>  	     buffer_offset += sizeof(binder_size_t)) {
> @@ -3773,8 +3773,8 @@ static void binder_transaction(struct binder_proc *proc,
>  	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
>  err_binder_alloc_buf_failed:
>  err_bad_extra_size:
> -	if (secctx)
> -		security_release_secctx(secctx, secctx_sz);
> +	if (lsmctx.context)
> +		security_release_secctx(&lsmctx);
>  err_get_secctx_failed:
>  	kfree(tcomplete);
>  	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index e066a556eccb..f7996770cc2c 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1446,12 +1446,16 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
>  
>  void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
>  {
> +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> +	struct lsm_context scaff; /* scaffolding */
> +#endif
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
>  	posix_acl_release(as_ctx->acl);
>  	posix_acl_release(as_ctx->default_acl);
>  #endif
>  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> -	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> +	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
> +	security_release_secctx(&scaff);
>  #endif
>  #ifdef CONFIG_FS_ENCRYPTION
>  	kfree(as_ctx->fscrypt_auth);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index cd2fbde2e6d7..76776d716744 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -138,8 +138,12 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -	if (label)
> -		security_release_secctx(label->label, label->len);
> +	struct lsm_context scaff; /* scaffolding */
> +
> +	if (label) {
> +		lsmcontext_init(&scaff, label->label, label->len, 0);
> +		security_release_secctx(&scaff);
> +	}
>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>  {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3..537ad363d70a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3653,8 +3653,12 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  
>  out:
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	if (args.context)
> -		security_release_secctx(args.context, args.contextlen);
> +	if (args.context) {
> +		struct lsm_context scaff; /* scaffolding */
> +
> +		lsmcontext_init(&scaff, args.context, args.contextlen, 0);
> +		security_release_secctx(&scaff);
> +	}
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>  	kfree(args.acl);
>  	if (tempfh) {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eb2937599cb0..c13df23132eb 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -300,7 +300,7 @@ LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
>  LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
>  	 char **secdata, u32 *seclen)
>  LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
> -LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
> +LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
>  LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
>  LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
>  LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fd690fa73162..1a3ca02224e8 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -225,6 +225,37 @@ extern unsigned long dac_mmap_min_addr;
>  #define dac_mmap_min_addr	0UL
>  #endif
>  
> +/*
> + * A "security context" is the text representation of
> + * the information used by LSMs.
> + * This structure contains the string, its length, and which LSM
> + * it is useful for.
> + */
> +struct lsm_context {
> +	char	*context;	/* Provided by the module */
> +	u32	len;
> +	int	id;		/* Identifies the module */
> +};
> +
> +/**
> + * lsmcontext_init - initialize an lsmcontext structure.
> + * @cp: Pointer to the context to initialize
> + * @context: Initial context, or NULL
> + * @size: Size of context, or 0
> + * @id: Which LSM provided the context
> + *
> + * Fill in the lsmcontext from the provided information.
> + * This is a scaffolding function that will be removed when
> + * lsm_context integration is complete.
> + */
> +static inline void lsmcontext_init(struct lsm_context *cp, char *context,
> +				   u32 size, int id)
> +{
> +	cp->id = id;
> +	cp->context = context;
> +	cp->len = size;
> +}
> +
>  /*
>   * Values used in the task_security_ops calls
>   */
> @@ -556,7 +587,7 @@ int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int security_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> -void security_release_secctx(char *secdata, u32 seclen);
> +void security_release_secctx(struct lsm_context *cp);
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> @@ -1545,7 +1576,7 @@ static inline int security_secctx_to_secid(const char *secdata,
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void security_release_secctx(char *secdata, u32 seclen)
> +static inline void security_release_secctx(struct lsm_context *cp)
>  {
>  }
>  
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 0d35c7c77a74..f75449e1d876 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -105,16 +105,17 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
>  #ifdef CONFIG_SECURITY_NETWORK
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  {
> -	char *secdata;
> -	u32 seclen;
> +	struct lsm_context ctx;
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
> +		err = security_secid_to_secctx(scm->secid, &ctx.context,
> +					       &ctx.len);
>  
>  		if (!err) {
> -			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> -			security_release_secctx(secdata, seclen);
> +			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, ctx.len,
> +				 ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  	}
>  }
> diff --git a/kernel/audit.c b/kernel/audit.c
> index d2797e8fe182..bafd8fd2b1f3 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1221,8 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	struct audit_buffer	*ab;
>  	u16			msg_type = nlh->nlmsg_type;
>  	struct audit_sig_info   *sig_data;
> -	char			*ctx = NULL;
> -	u32			len;
> +	struct lsm_context	lsmctx;
>  
>  	err = audit_netlink_ok(skb, msg_type);
>  	if (err)
> @@ -1472,27 +1471,29 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		break;
>  	}
>  	case AUDIT_SIGNAL_INFO:
> -		len = 0;
>  		if (lsmprop_is_set(&audit_sig_lsm)) {
> -			err = security_lsmprop_to_secctx(&audit_sig_lsm, &ctx,
> -							 &len);
> +			err = security_lsmprop_to_secctx(&audit_sig_lsm,
> +							 &lsmctx.context,
> +							 &lsmctx.len);
>  			if (err)
>  				return err;
>  		}
> -		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
> +		sig_data = kmalloc(struct_size(sig_data, ctx, lsmctx.len),
> +				   GFP_KERNEL);
>  		if (!sig_data) {
>  			if (lsmprop_is_set(&audit_sig_lsm))
> -				security_release_secctx(ctx, len);
> +				security_release_secctx(&lsmctx);
>  			return -ENOMEM;
>  		}
>  		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>  		sig_data->pid = audit_sig_pid;
>  		if (lsmprop_is_set(&audit_sig_lsm)) {
> -			memcpy(sig_data->ctx, ctx, len);
> -			security_release_secctx(ctx, len);
> +			memcpy(sig_data->ctx, lsmctx.context, lsmctx.len);
> +			security_release_secctx(&lsmctx);
>  		}
>  		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
> -				 sig_data, struct_size(sig_data, ctx, len));
> +				 sig_data, struct_size(sig_data, ctx,
> +						       lsmctx.len));
>  		kfree(sig_data);
>  		break;
>  	case AUDIT_TTY_GET: {
> @@ -2180,23 +2181,22 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
>  	struct lsm_prop prop;
> -	char *ctx = NULL;
> -	unsigned len;
> +	struct lsm_context ctx;
>  	int error;
>  
>  	security_current_getlsmprop_subj(&prop);
>  	if (!lsmprop_is_set(&prop))
>  		return 0;
>  
> -	error = security_lsmprop_to_secctx(&prop, &ctx, &len);
> +	error = security_lsmprop_to_secctx(&prop, &ctx.context, &ctx.len);
>  	if (error) {
>  		if (error != -EINVAL)
>  			goto error_path;
>  		return 0;
>  	}
>  
> -	audit_log_format(ab, " subj=%s", ctx);
> -	security_release_secctx(ctx, len);
> +	audit_log_format(ab, " subj=%s", ctx.context);
> +	security_release_secctx(&ctx);
>  	return 0;
>  
>  error_path:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index f28fd513d047..c196dd4c9b54 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1098,8 +1098,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 char *comm)
>  {
>  	struct audit_buffer *ab;
> -	char *ctx = NULL;
> -	u32 len;
> +	struct lsm_context ctx;
>  	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -1110,12 +1109,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmprop_is_set(prop)) {
> -		if (security_lsmprop_to_secctx(prop, &ctx, &len)) {
> +		if (security_lsmprop_to_secctx(prop, &ctx.context, &ctx.len)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			security_release_secctx(ctx, len);
> +			audit_log_format(ab, " obj=%s", ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  	}
>  	audit_log_format(ab, " ocomm=");
> @@ -1371,6 +1370,7 @@ static void audit_log_time(struct audit_context *context, struct audit_buffer **
>  
>  static void show_special(struct audit_context *context, int *call_panic)
>  {
> +	struct lsm_context lsmcxt;
>  	struct audit_buffer *ab;
>  	int i;
>  
> @@ -1401,7 +1401,8 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				*call_panic = 1;
>  			} else {
>  				audit_log_format(ab, " obj=%s", ctx);
> -				security_release_secctx(ctx, len);
> +				lsmcontext_init(&lsmcxt, ctx, len, 0);
> +				security_release_secctx(&lsmcxt);
>  			}
>  		}
>  		if (context->ipc.has_perm) {
> @@ -1560,15 +1561,15 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
>  	if (lsmprop_is_set(&n->oprop)) {
> -		char *ctx = NULL;
> -		u32 len;
> +		struct lsm_context ctx;
>  
> -		if (security_lsmprop_to_secctx(&n->oprop, &ctx, &len)) {
> +		if (security_lsmprop_to_secctx(&n->oprop, &ctx.context,
> +					       &ctx.len)) {
>  			if (call_panic)
>  				*call_panic = 2;
>  		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			security_release_secctx(ctx, len);
> +			audit_log_format(ab, " obj=%s", ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  	}
>  
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..a8180dcc2a32 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -128,20 +128,20 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
>  
>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  {
> -	char *secdata;
> -	u32 seclen, secid;
> +	struct lsm_context ctx;
> +	u32 secid;
>  	int err;
>  
>  	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
>  	if (err)
>  		return;
>  
> -	err = security_secid_to_secctx(secid, &secdata, &seclen);
> +	err = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
>  	if (err)
>  		return;
>  
> -	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
> -	security_release_secctx(secdata, seclen);
> +	put_cmsg(msg, SOL_IP, SCM_SECURITY, ctx.len, ctx.context);
> +	security_release_secctx(&ctx);
>  }
>  
>  static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 6a1239433830..86a57a3afdd6 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -357,10 +357,10 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct,
>  static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  {
>  	struct nlattr *nest_secctx;
> -	int len, ret;
> -	char *secctx;
> +	struct lsm_context ctx;
> +	int ret;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
>  	if (ret)
>  		return 0;
>  
> @@ -369,13 +369,13 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	if (!nest_secctx)
>  		goto nla_put_failure;
>  
> -	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
> +	if (nla_put_string(skb, CTA_SECCTX_NAME, ctx.context))
>  		goto nla_put_failure;
>  	nla_nest_end(skb, nest_secctx);
>  
>  	ret = 0;
>  nla_put_failure:
> -	security_release_secctx(secctx, len);
> +	security_release_secctx(&ctx);
>  	return ret;
>  }
>  #else
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 7d4f0fa8b609..5f7fd23b7afe 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -172,17 +172,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
>  #ifdef CONFIG_NF_CONNTRACK_SECMARK
>  static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  {
> +	struct lsm_context ctx;
>  	int ret;
> -	u32 len;
> -	char *secctx;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	ret = security_secid_to_secctx(ct->secmark, &ctx.context, &ctx.len);
>  	if (ret)
>  		return;
>  
> -	seq_printf(s, "secctx=%s ", secctx);
> +	seq_printf(s, "secctx=%s ", ctx.context);
>  
> -	security_release_secctx(secctx, len);
> +	security_release_secctx(&ctx);
>  }
>  #else
>  static inline void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index d2773ce9b585..37757cd77cf1 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -567,6 +567,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	enum ip_conntrack_info ctinfo = 0;
>  	const struct nfnl_ct_hook *nfnl_ct;
>  	bool csum_verify;
> +	struct lsm_context scaff; /* scaffolding */
>  	char *secdata = NULL;
>  	u32 seclen = 0;
>  	ktime_t tstamp;
> @@ -810,8 +811,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	}
>  
>  	nlh->nlmsg_len = skb->len;
> -	if (seclen)
> -		security_release_secctx(secdata, seclen);
> +	if (seclen) {
> +		lsmcontext_init(&scaff, secdata, seclen, 0);
> +		security_release_secctx(&scaff);
> +	}
>  	return skb;
>  
>  nla_put_failure:
> @@ -819,8 +822,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	kfree_skb(skb);
>  	net_err_ratelimited("nf_queue: error creating packet message\n");
>  nlmsg_failure:
> -	if (seclen)
> -		security_release_secctx(secdata, seclen);
> +	if (seclen) {
> +		lsmcontext_init(&scaff, secdata, seclen, 0);
> +		security_release_secctx(&scaff);
> +	}
>  	return NULL;
>  }
>  
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 1bc2d0890a9f..8303bbcfc543 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -374,8 +374,7 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct net_device *dev;
>  	struct netlbl_unlhsh_iface *iface;
>  	struct audit_buffer *audit_buf = NULL;
> -	char *secctx = NULL;
> -	u32 secctx_len;
> +	struct lsm_context ctx;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
>  	    addr_len != sizeof(struct in6_addr))
> @@ -438,11 +437,10 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(secid,
> -					     &secctx,
> -					     &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +		if (security_secid_to_secctx(secid, &ctx.context,
> +					     &ctx.len) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -473,8 +471,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct netlbl_unlhsh_addr4 *entry;
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
> -	char *secctx;
> -	u32 secctx_len;
> +	struct lsm_context ctx;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -494,10 +491,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  					  addr->s_addr, mask->s_addr);
>  		dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +		    security_secid_to_secctx(entry->secid, &ctx.context,
> +					     &ctx.len) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -534,8 +531,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct netlbl_unlhsh_addr6 *entry;
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
> -	char *secctx;
> -	u32 secctx_len;
> +	struct lsm_context ctx;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -554,10 +550,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  					  addr, mask);
>  		dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +		    security_secid_to_secctx(entry->secid, &ctx.context,
> +					     &ctx.len) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
> +			security_release_secctx(&ctx);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -1069,10 +1065,9 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	int ret_val = -ENOMEM;
>  	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
>  	struct net_device *dev;
> +	struct lsm_context ctx;
>  	void *data;
>  	u32 secid;
> -	char *secctx;
> -	u32 secctx_len;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>  			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		secid = addr6->secid;
>  	}
>  
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
>  			  NLBL_UNLABEL_A_SECCTX,
> -			  secctx_len,
> -			  secctx);
> -	security_release_secctx(secctx, secctx_len);
> +			  ctx.len,
> +			  ctx.context);
> +	security_release_secctx(&ctx);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 81635a13987b..f5e7a9919df1 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -84,8 +84,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  					       struct netlbl_audit *audit_info)
>  {
>  	struct audit_buffer *audit_buf;
> -	char *secctx;
> -	u32 secctx_len;
> +	struct lsm_context ctx;
>  
>  	if (audit_enabled == AUDIT_OFF)
>  		return NULL;
> @@ -99,10 +98,10 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  			 audit_info->sessionid);
>  
>  	if (lsmprop_is_set(&audit_info->prop) &&
> -	    security_lsmprop_to_secctx(&audit_info->prop, &secctx,
> -				       &secctx_len) == 0) {
> -		audit_log_format(audit_buf, " subj=%s", secctx);
> -		security_release_secctx(secctx, secctx_len);
> +	    security_lsmprop_to_secctx(&audit_info->prop, &ctx.context,
> +				       &ctx.len) == 0) {
> +		audit_log_format(audit_buf, " subj=%s", ctx.context);
> +		security_release_secctx(&ctx);
>  	}
>  
>  	return audit_buf;
> diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
> index cc6d1c9f4a47..8b92f90b6921 100644
> --- a/security/apparmor/include/secid.h
> +++ b/security/apparmor/include/secid.h
> @@ -29,7 +29,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int apparmor_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
>  			       u32 *seclen);
>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> -void apparmor_release_secctx(char *secdata, u32 seclen);
> +void apparmor_release_secctx(struct lsm_context *cp);
>  
>  
>  int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 6350d107013a..8d9ced8cdffd 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -120,9 +120,16 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  	return 0;
>  }
>  
> -void apparmor_release_secctx(char *secdata, u32 seclen)
> +void apparmor_release_secctx(struct lsm_context *cp)
>  {
> -	kfree(secdata);
> +	/*
> +	 * stacking scaffolding:
> +	 * When it is possible for more than one LSM to provide a
> +	 * release hook, do this check:
> +	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
> +	 */
> +
> +	kfree(cp->context);
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index 0003d5ace5cc..0c9c3a02704b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4365,14 +4365,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  /**
>   * security_release_secctx() - Free a secctx buffer
> - * @secdata: secctx
> - * @seclen: length of secctx
> + * @cp: the security context
>   *
>   * Release the security context.
>   */
> -void security_release_secctx(char *secdata, u32 seclen)
> +void security_release_secctx(struct lsm_context *cp)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	call_void_hook(release_secctx, cp);
> +	memset(cp, 0, sizeof(*cp));
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 025b60c5b605..1503d398c87d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6624,9 +6624,16 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  				       secid, GFP_KERNEL);
>  }
>  
> -static void selinux_release_secctx(char *secdata, u32 seclen)
> +static void selinux_release_secctx(struct lsm_context *cp)
>  {
> -	kfree(secdata);
> +	/*
> +	 * stacking scaffolding:
> +	 * When it is possible for more than one LSM to provide a
> +	 * release hook, do this check:
> +	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
> +	 */
> +
> +	kfree(cp->context);
>  }
>  
>  static void selinux_inode_invalidate_secctx(struct inode *inode)
> -- 
> 2.46.0
> 

