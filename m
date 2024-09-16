Return-Path: <linux-nfs+bounces-6511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04C097A4A6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8192B292AE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFD21DFCF;
	Mon, 16 Sep 2024 14:56:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38096152517
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498584; cv=none; b=hxv15HpC4x1XHYN594a8HnCLuQswdt4CAAwknLFtMw+nvyVKLzT/vTqeuICKWqERVY2HBqPxbrRcJZTVkR0t7ttpxHgGVYTjPxh4rPfc91t+Jnv2dkLNXHmMzreGitTYtO1kOXNCFQ40Nt03M+FU8QDIEZaJu9xDU6thMonNZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498584; c=relaxed/simple;
	bh=2xtOpnUi2QQjEwlI3GOWED2gbwmtUJT1Ad/N90CgPYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSbEYC06gWg28t9kYH6A/idgRp52+EYbsJ4vTcaLil1dGxXp5K3tfLZXHSVnW3uKKK7TvSBbYFwXzzjdXahcUrGQv7ZExp3pDWVCloCb+/aVoKaLN/Is35aY3EdzaeHV+WQ1zK2rJ1IoHTsj4sbzHx3GmFaXxSo5S5jN40qH52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A3611FB;
	Mon, 16 Sep 2024 07:56:51 -0700 (PDT)
Received: from [10.57.76.90] (unknown [10.57.76.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7983F66E;
	Mon, 16 Sep 2024 07:56:20 -0700 (PDT)
Message-ID: <5c90c3d0-c51f-4012-9ab6-408d023570c8@arm.com>
Date: Mon, 16 Sep 2024 15:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
To: NeilBrown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <172558992310.4433.1385243627662249022@noble.neil.brown.name>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <172558992310.4433.1385243627662249022@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 03:32, NeilBrown wrote:
> 
> I have evidence of an Linux NFS client getting NFS4ERR_BAD_SEQID to a
> v4.0 LOCK request to a Linux server (which had fixed the problem with
> RELEASE_LOCKOWNER bug fixed).
> The LOCK request presented a "new" lock owner so there are two seq ids
> in the request: that for the open file, and that for the new lock.
> Given the context I am confident that the new lock owner was reported to
> have the wrong seqid.  As lock owner identifiers are reused, the server
> must still have a lock owner active which the client thinks is no longer
> active.
> 
> I wasn't able to determine a root-cause but the simplest fix seems to be
> to ensure lock owners are always unique much as open owners are (thanks
> to a time stamp).  The easiest way to ensure uniqueness is with a 64bit
> counter for each server.  That will never cycle (if updated once a
> nanosecond the last 584 years.  A single NFS server would not handle
> open/lock requests nearly that fast, and a Linux node is unlikely to
> have an uptime approaching that).
> 
> This patch removes the 2 ida and instead uses a per-server
> atomic64_t to provide uniqueness.
> 
> Note that the lock owner already encodes the id as 64 bits even though
> it is a 32bit value.  So changing to a 64bit value does not change the
> encoding of the lock owner.  The open owner encoding is now 4 bytes
> larger.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Hi Neil,

I'm seeing issues on a test board using an NFS root which I've bisected
to this commit in linux-next. The kernel spits out many errors of the form:

[    7.478995] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.599462] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.600570] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.615243] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.636756] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.644808] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.653605] NFS: v4 server <ip>  returned a bad sequence-id error!
[    7.692836] NFS: nfs4_reclaim_open_state: unhandled error -10026
[    7.699573] NFSv4: state recovery failed for open file
arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026
[    7.711055] NFSv4: state recovery failed for open file
arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026

(with the filename obviously varying)

The NFS server is a standard Debian 12 system.

Any ideas?

Thanks,
Steve

> ---
>  fs/nfs/client.c           |  6 ++----
>  fs/nfs/nfs4_fs.h          |  2 +-
>  fs/nfs/nfs4state.c        | 15 ++-------------
>  fs/nfs/nfs4xdr.c          |  6 +++---
>  include/linux/nfs_fs_sb.h |  3 +--
>  include/linux/nfs_xdr.h   |  2 +-
>  6 files changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 8286edd6062d..3fea7aa1366f 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -997,8 +997,8 @@ struct nfs_server *nfs_alloc_server(void)
>  	init_waitqueue_head(&server->write_congestion_wait);
>  	atomic_long_set(&server->writeback, 0);
>  
> -	ida_init(&server->openowner_id);
> -	ida_init(&server->lockowner_id);
> +	atomic64_set(&server->owner_ctr, 0);
> +
>  	pnfs_init_server(server);
>  	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
>  
> @@ -1037,8 +1037,6 @@ void nfs_free_server(struct nfs_server *server)
>  	}
>  	ida_free(&s_sysfs_ids, server->s_sysfs_id);
>  
> -	ida_destroy(&server->lockowner_id);
> -	ida_destroy(&server->openowner_id);
>  	put_cred(server->cred);
>  	nfs_release_automount_timer();
>  	call_rcu(&server->rcu, delayed_free);
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index c2045a2a9d0f..7d383d29a995 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -83,7 +83,7 @@ struct nfs4_minor_version_ops {
>  #define NFS_SEQID_CONFIRMED 1
>  struct nfs_seqid_counter {
>  	ktime_t create_time;
> -	int owner_id;
> +	u64 owner_id;
>  	int flags;
>  	u32 counter;
>  	spinlock_t lock;		/* Protects the list */
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 877f682b45f2..08725fd416e4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -501,11 +501,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
>  	sp = kzalloc(sizeof(*sp), gfp_flags);
>  	if (!sp)
>  		return NULL;
> -	sp->so_seqid.owner_id = ida_alloc(&server->openowner_id, gfp_flags);
> -	if (sp->so_seqid.owner_id < 0) {
> -		kfree(sp);
> -		return NULL;
> -	}
> +	sp->so_seqid.owner_id = atomic64_inc_return(&server->owner_ctr);
>  	sp->so_server = server;
>  	sp->so_cred = get_cred(cred);
>  	spin_lock_init(&sp->so_lock);
> @@ -536,7 +532,6 @@ static void nfs4_free_state_owner(struct nfs4_state_owner *sp)
>  {
>  	nfs4_destroy_seqid_counter(&sp->so_seqid);
>  	put_cred(sp->so_cred);
> -	ida_free(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
>  	kfree(sp);
>  }
>  
> @@ -879,19 +874,13 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
>  	refcount_set(&lsp->ls_count, 1);
>  	lsp->ls_state = state;
>  	lsp->ls_owner = owner;
> -	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
> -	if (lsp->ls_seqid.owner_id < 0)
> -		goto out_free;
> +	lsp->ls_seqid.owner_id = atomic64_inc_return(&server->owner_ctr);
>  	INIT_LIST_HEAD(&lsp->ls_locks);
>  	return lsp;
> -out_free:
> -	kfree(lsp);
> -	return NULL;
>  }
>  
>  void nfs4_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
>  {
> -	ida_free(&server->lockowner_id, lsp->ls_seqid.owner_id);
>  	nfs4_destroy_seqid_counter(&lsp->ls_seqid);
>  	kfree(lsp);
>  }
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 7704a4509676..1aaf908acc5d 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1424,12 +1424,12 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
>   */
>  	encode_nfs4_seqid(xdr, arg->seqid);
>  	encode_share_access(xdr, arg->share_access);
> -	p = reserve_space(xdr, 36);
> +	p = reserve_space(xdr, 40);
>  	p = xdr_encode_hyper(p, arg->clientid);
> -	*p++ = cpu_to_be32(24);
> +	*p++ = cpu_to_be32(28);
>  	p = xdr_encode_opaque_fixed(p, "open id:", 8);
>  	*p++ = cpu_to_be32(arg->server->s_dev);
> -	*p++ = cpu_to_be32(arg->id.uniquifier);
> +	xdr_encode_hyper(p, arg->id.uniquifier);
>  	xdr_encode_hyper(p, arg->id.create_time);
>  }
>  
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 1df86ab98c77..e1e47ebd83ef 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -234,8 +234,7 @@ struct nfs_server {
>  	/* the following fields are protected by nfs_client->cl_lock */
>  	struct rb_root		state_owners;
>  #endif
> -	struct ida		openowner_id;
> -	struct ida		lockowner_id;
> +	atomic64_t		owner_ctr;
>  	struct list_head	state_owners_lru;
>  	struct list_head	layouts;
>  	struct list_head	delegations;
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 45623af3e7b8..96ba04ab24f3 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -446,7 +446,7 @@ struct nfs42_clone_res {
>  
>  struct stateowner_id {
>  	__u64	create_time;
> -	__u32	uniquifier;
> +	__u64	uniquifier;
>  };
>  
>  struct nfs4_open_delegation {


