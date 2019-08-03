Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA872807FC
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfHCTH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 15:07:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8216 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfHCTH4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 15:07:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d45db930000>; Sat, 03 Aug 2019 12:08:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 03 Aug 2019 12:07:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 03 Aug 2019 12:07:54 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Aug
 2019 19:07:53 +0000
Subject: Re: [PATCH] NFSv4: Fix a potential sleep while atomic in
 nfs4_do_reclaim()
To:     Trond Myklebust <trondmy@gmail.com>
CC:     <linux-nfs@vger.kernel.org>
References: <20190803144042.15187-1-trond.myklebust@hammerspace.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f90372ee-272b-5bbb-e99a-796bccfa787a@nvidia.com>
Date:   Sat, 3 Aug 2019 12:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190803144042.15187-1-trond.myklebust@hammerspace.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564859283; bh=darQmYzrmBbxKwRZSQXGQM6t2XRY+a8lMC05+ULCTfA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dHjfOBeSrUEg2BMUUBQMC+IFD0G7helvRsUTaaY019gLuGmtcwxq0jStaKdwggzir
         ZGr5u1DbVbk2UutbXMIcLNjrEOJRthfLLkxT57MF2diirB5UKqXVFf+7mw9+AYNSw7
         ohdBnciat995u7Wc/LdTEaX3rHkXGwFMfD5U6fOZDefhPjajxh/4D5n37CO6UKuVHU
         BkXFnU7JLhP+y7+zZJRV5B39Jp1MiCKmZlspj0fVYdGL2mAHCFlLJjAHCPVac3wJ1I
         6pmhcadb3YE2RD/Os9tdkys1gfUGdMqnv/wPUjJFUvxt70gbRQM/BDorTanESvcoGd
         z2YH19TuZm/Iw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8/3/19 7:40 AM, Trond Myklebust wrote:
> John Hubbard reports seeing the following stack trace:
> 
> nfs4_do_reclaim
>    rcu_read_lock /* we are now in_atomic() and must not sleep */
>        nfs4_purge_state_owners
>            nfs4_free_state_owner
>                nfs4_destroy_seqid_counter
>                    rpc_destroy_wait_queue
>                        cancel_delayed_work_sync
>                            __cancel_work_timer
>                                __flush_work
>                                    start_flush_work
>                                        might_sleep:
>                                         (kernel/workqueue.c:2975: BUG)
> 
> The solution is to separate out the freeing of the state owners
> from nfs4_purge_state_owners(), and perform that outside the atomic
> context.
> 

All better now--this definitely fixes it. I can reboot the server, and
of course that backtrace is gone. Then the client mounts hang, so I do
a mount -a -o remount, and after about 1 minute, the client mounts
start working again, with no indication of problems. I assume that the
pause is by design--timing out somewhere, to recover from the server
going missing for a while. If so, then all is well.


thanks,
-- 
John Hubbard
NVIDIA

> Reported-by: John Hubbard <jhubbard@nvidia.com>
> Fixes: 0aaaf5c424c7f ("NFS: Cache state owners after files are closed")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4_fs.h    |  3 ++-
>  fs/nfs/nfs4client.c |  5 ++++-
>  fs/nfs/nfs4state.c  | 27 ++++++++++++++++++++++-----
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index d778dad9a75e..3564da1ba8a1 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -465,7 +465,8 @@ static inline void nfs4_schedule_session_recovery(struct nfs4_session *session,
>  
>  extern struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *, const struct cred *, gfp_t);
>  extern void nfs4_put_state_owner(struct nfs4_state_owner *);
> -extern void nfs4_purge_state_owners(struct nfs_server *);
> +extern void nfs4_purge_state_owners(struct nfs_server *, struct list_head *);
> +extern void nfs4_free_state_owners(struct list_head *head);
>  extern struct nfs4_state * nfs4_get_open_state(struct inode *, struct nfs4_state_owner *);
>  extern void nfs4_put_open_state(struct nfs4_state *);
>  extern void nfs4_close_state(struct nfs4_state *, fmode_t);
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 616393a01c06..da6204025a2d 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -758,9 +758,12 @@ int nfs41_walk_client_list(struct nfs_client *new,
>  
>  static void nfs4_destroy_server(struct nfs_server *server)
>  {
> +	LIST_HEAD(freeme);
> +
>  	nfs_server_return_all_delegations(server);
>  	unset_pnfs_layoutdriver(server);
> -	nfs4_purge_state_owners(server);
> +	nfs4_purge_state_owners(server, &freeme);
> +	nfs4_free_state_owners(&freeme);
>  }
>  
>  /*
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index d03b9cf42bd0..a4e866b2b43b 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -624,24 +624,39 @@ void nfs4_put_state_owner(struct nfs4_state_owner *sp)
>  /**
>   * nfs4_purge_state_owners - Release all cached state owners
>   * @server: nfs_server with cached state owners to release
> + * @head: resulting list of state owners
>   *
>   * Called at umount time.  Remaining state owners will be on
>   * the LRU with ref count of zero.
> + * Note that the state owners are not freed, but are added
> + * to the list @head, which can later be used as an argument
> + * to nfs4_free_state_owners.
>   */
> -void nfs4_purge_state_owners(struct nfs_server *server)
> +void nfs4_purge_state_owners(struct nfs_server *server, struct list_head *head)
>  {
>  	struct nfs_client *clp = server->nfs_client;
>  	struct nfs4_state_owner *sp, *tmp;
> -	LIST_HEAD(doomed);
>  
>  	spin_lock(&clp->cl_lock);
>  	list_for_each_entry_safe(sp, tmp, &server->state_owners_lru, so_lru) {
> -		list_move(&sp->so_lru, &doomed);
> +		list_move(&sp->so_lru, head);
>  		nfs4_remove_state_owner_locked(sp);
>  	}
>  	spin_unlock(&clp->cl_lock);
> +}
>  
> -	list_for_each_entry_safe(sp, tmp, &doomed, so_lru) {
> +/**
> + * nfs4_purge_state_owners - Release all cached state owners
> + * @head: resulting list of state owners
> + *
> + * Frees a list of state owners that was generated by
> + * nfs4_purge_state_owners
> + */
> +void nfs4_free_state_owners(struct list_head *head)
> +{
> +	struct nfs4_state_owner *sp, *tmp;
> +
> +	list_for_each_entry_safe(sp, tmp, head, so_lru) {
>  		list_del(&sp->so_lru);
>  		nfs4_free_state_owner(sp);
>  	}
> @@ -1865,12 +1880,13 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
>  	struct nfs4_state_owner *sp;
>  	struct nfs_server *server;
>  	struct rb_node *pos;
> +	LIST_HEAD(freeme);
>  	int status = 0;
>  
>  restart:
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
> -		nfs4_purge_state_owners(server);
> +		nfs4_purge_state_owners(server, &freeme);
>  		spin_lock(&clp->cl_lock);
>  		for (pos = rb_first(&server->state_owners);
>  		     pos != NULL;
> @@ -1899,6 +1915,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
>  		spin_unlock(&clp->cl_lock);
>  	}
>  	rcu_read_unlock();
> +	nfs4_free_state_owners(&freeme);
>  	return 0;
>  }
>  
> 
