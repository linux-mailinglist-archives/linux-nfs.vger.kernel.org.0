Return-Path: <linux-nfs+bounces-11375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D13AA52A1
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D817201C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69C1E0B86;
	Wed, 30 Apr 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrudvkyZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E019E98B
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034445; cv=none; b=MPsWeQNNO8sGvRBwTmrTfKbUqaoe8TF3oSeH1/ZjKW+06gQeLvEcIv8L6YUjyxEI3YRTS45A0hjo/lwqpUwD69gzfPuAbQNg53xVWUfmh2lBoLI4u80JyPYl1zpodLC3UhC/oJC8H5IFMDUVsCtbEOYb3ESG12lt/kXBwmuuPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034445; c=relaxed/simple;
	bh=Czvs56AQ6HkNlzo1xoC3uvWWsZqoEgIzAT0NDzaECJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdpk+30Sy4ULH2ozhTpJNc/idG3H0H9atQIW68wVAlVfdhz243234it2oJ8fs61NlAyFw05hYJmlIHtGDDE84vEta/N4OKo9FEF4UGCbNnL14Z/MeJzqGmov9WwEleUJesq2/i9a3xAd5XBF3tyfXebufYj+OgnIUkS5u+s5av4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrudvkyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293B8C4CEE7;
	Wed, 30 Apr 2025 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746034444;
	bh=Czvs56AQ6HkNlzo1xoC3uvWWsZqoEgIzAT0NDzaECJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrudvkyZA+MK+6URbWMDi9UCTN6F5tmSpbZlHJIW5iYobrd1DzYleGFz+E6AcW6tt
	 LE33tqxsTICWJ2wW5ULu9x0DwhEhrpHQaPDAxWz4gnlcXUFr6YkdrtffUXHsZMfTGC
	 UV+86GrFADBaH8F3aV8kY4bjj2uVEIIf/3Xd3ZSCrnUszISeabr6rNAb+xyBJPRFE+
	 NxSoIZbic/xGt/s7aSkQTfsq+2lcNLwVAuUAAUKZcs7Db3iCnwZ+ZQZOcmILNZ0sjP
	 w7Ye71Oo/ZHj5mXdDXokSbOMWkFxfWV+Qauf3NlsovEVL2i45MtX//sL/3ek3IwABO
	 g1S700tXiILTw==
Date: Wed, 30 Apr 2025 13:34:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] nfs_localio: protect race between nfs_uuid_put() and
 nfs_close_local_fh()
Message-ID: <aBJfC0geyEDZyGYg@kernel.org>
References: <20250430040429.2743921-1-neil@brown.name>
 <20250430040429.2743921-7-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430040429.2743921-7-neil@brown.name>

Hi Neil,

With this change a simple write to a file (using pNFS flexfiles)
triggers this patch's nfs_close_local_fh WARN_ON:

[  261.589009] ------------[ cut here ]------------
[  261.589016] WARNING: CPU: 2 PID: 7220 at fs/nfs_common/nfslocalio.c:344 nfs_close_local_fh+0x1dd/0x1f0 [nfs_localio]
[  261.589045] Modules linked in: tls nfsv3 nfs_layout_flexfiles rpcsec_gss_krb5 nfsv4 dns_resolver nfsidmap nfsd auth_rpcgss nfs_acl nft_nat nft_ct nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 veth bridge stp llc nfs lockd grace nfs_localio sunrpc netfs nf_tables nfnetlink overlay rfkill vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vfat fat intel_rapl_msr intel_rapl_common kvm_intel kvm nd_pmem dax_pmem nd_e820 pktcdvd libnvdimm irqbypass ppdev crct10dif_pclmul crc32_pclmul vmw_balloon i2c_piix4 ghash_clmulni_intel vmw_vmci pcspkr joydev i2c_smbus rapl parport_pc parport xfs sr_mod sd_mod cdrom sg ata_generic ata_piix mptspi crc32c_intel libata scsi_transport_spi serio_raw mptscsih vmxnet3 mptbase dm_mod fuse [last unloaded: sunrpc]
[  261.589403] CPU: 2 UID: 0 PID: 7220 Comm: dd Kdump: loaded Tainted: G        W         -------  ---  6.12.24.0.hs.62.snitm+ #15
[  261.589414] Tainted: [W]=WARN
[  261.589417] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
[  261.589423] RIP: 0010:nfs_close_local_fh+0x1dd/0x1f0 [nfs_localio]
[  261.589440] Code: e2 ba 02 00 00 00 48 89 ee 4c 89 e7 e8 9c 9f cb e1 48 8b 43 20 48 85 c0 75 e2 48 89 ee 4c 89 e7 e8 28 a7 cb e1 e9 6f ff ff ff <0f> 0b e8 bc 36 d0 e1 e9 63 ff ff ff e8 02 86 8a e2 66 90 90 90 90
[  261.589447] RSP: 0018:ffffb0fac4d5bc98 EFLAGS: 00010282
[  261.589455] RAX: 0000000000000000 RBX: ffff94354d5f0270 RCX: 0000000000000002
[  261.589461] RDX: ffff943544085040 RSI: ffff9435455559e8 RDI: ffff943544085040
[  261.589466] RBP: ffff943544199e80 R08: 58132c4e3594ffff R09: fffffffae10a4a38
[  261.589472] R10: 0000000000000001 R11: 000000000000000f R12: ffff94354baae380
[  261.589477] R13: ffff94354baae3c0 R14: ffff943546916d08 R15: ffff943546916cf0
[  261.589499] FS:  00007fd6724ff580(0000) GS:ffff943773b00000(0000) knlGS:0000000000000000
[  261.589512] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  261.589518] CR2: 00007fdade5900a8 CR3: 000000010f3a8002 CR4: 00000000001726f0
[  261.589539] Call Trace:
[  261.589545]  <TASK>
[  261.589556]  ff_layout_free_mirror+0x78/0xc0 [nfs_layout_flexfiles]
[  261.589575]  ff_layout_free_layoutreturn+0x64/0x110 [nfs_layout_flexfiles]
[  261.589594]  pnfs_roc_release+0x7e/0x140 [nfsv4]
[  261.589830]  nfs4_free_closedata+0x6c/0x80 [nfsv4]
[  261.590013]  rpc_free_task+0x36/0x60 [sunrpc]
[  261.590209]  nfs4_do_close+0x269/0x330 [nfsv4]
[  261.590398]  __put_nfs_open_context+0xcb/0x150 [nfs]
[  261.590546]  nfs_file_release+0x39/0x60 [nfs]
[  261.590700]  __fput+0xdc/0x2a0
[  261.590713]  __x64_sys_close+0x3e/0x70
[  261.590723]  do_syscall_64+0x7b/0x160
[  261.590736]  ? clear_bhb_loop+0x45/0xa0
[  261.590744]  ? clear_bhb_loop+0x45/0xa0
[  261.590769]  ? clear_bhb_loop+0x45/0xa0
[  261.590777]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  261.590789] RIP: 0033:0x7fd671f2ebf8
[  261.590796] Code: 01 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 65 6b 2a 00 8b 00 85 c0 75 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 c3 0f 1f 80 00 00 00 00 53 89 fb 48 83 ec
[  261.590803] RSP: 002b:00007ffd9826ea88 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  261.590812] RAX: ffffffffffffffda RBX: 0000558223012120 RCX: 00007fd671f2ebf8
[  261.590819] RDX: 0000000000100000 RSI: 0000000000000000 RDI: 0000000000000001
[  261.590826] RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
[  261.590834] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
[  261.590843] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fd67232d000
[  261.590858]  </TASK>
[  261.590864] ---[ end trace 0000000000000000 ]---

After this last patch is applied, in nfs_close_local_fh() you have:

        /* tell nfs_uuid_put() to wait for us */
        RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
        spin_unlock(&nfs_uuid->lock);
        rcu_read_unlock();

        ro_nf = xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
        rw_nf = xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
        nfs_to_nfsd_file_put_local(ro_nf);
        nfs_to_nfsd_file_put_local(rw_nf);

        rcu_read_lock();
        if (WARN_ON(rcu_access_pointer(nfl->nfs_uuid) != nfs_uuid)) {
                rcu_read_unlock();
                return;
        }
        /* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
         * that we are done.
         */
        spin_lock(&nfs_uuid->lock);
        list_del_init(&nfl->list);
        wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
        spin_unlock(&nfs_uuid->lock);
        rcu_read_unlock();
}

this is bogus right?:

RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
...
if (WARN_ON(rcu_access_pointer(nfl->nfs_uuid) != nfs_uuid))

not sure what you were trying to do, maybe stale debugging? [but you didn't test so... ;) ]

Thanks,
Mike


On Wed, Apr 30, 2025 at 02:01:16PM +1000, NeilBrown wrote:
> nfs_uuid_put() and nfs_close_local_fh() can race if a "struct
> nfs_file_localio" is released at the same time that nfsd calls
> nfs_localio_invalidate_clients().
> 
> It is important that neither of these functions completes after the
> other has started looking at a given nfs_file_localio and before it
> finishes.
> 
> If nfs_uuid_put() exits while nfs_close_local_fh() is closing ro_file
> and rw_file it could return to __nfd_file_cache_purge() while some files
> are still referenced so the purge may not succeed.
> 
> If nfs_close_local_fh() exits while nfsd_uuid_put() is still closing the
> files then the "struct nfs_file_localio" could be freed while
> nfsd_uuid_put() is still looking at it.  This side is currently handled
> by copying the pointers out of ro_file and rw_file before deleting from
> the list in nfsd_uuid.  We need to preserve this while ensuring that
> nfsd_uuid_put() does wait for nfs_close_local_fh().
> 
> This patch use nfl->uuid and nfl->list to provide the required
> interlock.
> 
> nfs_uuid_put() removes the nfs_file_localio from the list, then drops
> locks and puts the two files, then reclaims the spinlock and sets
> ->nfs_uuid to NULL.
> 
> nfs_close_local_fh() operates in the reverse order, setting ->nfs_uuid
> to NULL, then closing the files, then unlinking from the list.
> 
> If nfs_uuid_put() finds that ->nfs_uuid is already NULL, it waits for
> the nfs_file_localio to be removed from the list.  If
> nfs_close_local_fh() find that it has already been unlinked it waits for
> ->nfs_uuid to become NULL.  This ensure that one of the two tries to
> close the files, but they each waits for the other.
> 
> As nfs_uuid_put() is making the list empty, change from a
> list_for_each_safe loop to a while that always takes the first entry.
> This makes the intent more clear.
> Also don't move the list to a temporary local list as this would defeat
> the guarantees required for the interlock.
> 
> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfs_common/nfslocalio.c | 83 +++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index abf1591a3b7f..0aaf0abeb110 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -151,8 +151,7 @@ EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
>   */
>  static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  {
> -	LIST_HEAD(local_files);
> -	struct nfs_file_localio *nfl, *tmp;
> +	struct nfs_file_localio *nfl;
>  
>  	spin_lock(&nfs_uuid->lock);
>  	if (unlikely(!rcu_access_pointer(nfs_uuid->net))) {
> @@ -166,35 +165,47 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  		nfs_uuid->dom = NULL;
>  	}
>  
> -	list_splice_init(&nfs_uuid->files, &local_files);
> -	spin_unlock(&nfs_uuid->lock);
> -
>  	/* Walk list of files and ensure their last references dropped */
> -	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
> +
> +	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
> +					       struct nfs_file_localio,
> +					       list)) != NULL) {
>  		struct nfsd_file __rcu *ro_nf;
>  		struct nfsd_file __rcu *rw_nf;
>  
> +		/* If nfs_uuid is already NULL, nfs_close_local_fh is
> +		 * closing and we must wait, else we unlink and close.
> +		 */
> +		if (nfl->nfs_uuid == NULL) {
> +			/* nfs_close_local_fh() is doing the
> +			 * close and we must wait. until it unlinks
> +			 */
> +			wait_var_event_spinlock(nfl,
> +						list_first_entry_or_null(
> +							&nfs_uuid->files,
> +							struct nfs_file_localio,
> +							list) != nfl,
> +						&nfs_uuid->lock);
> +			continue;
> +		}
> +
>  		ro_nf = xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
>  		rw_nf = xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
>  
> -		spin_lock(&nfs_uuid->lock);
>  		/* Remove nfl from nfs_uuid->files list */
>  		list_del_init(&nfl->list);
>  		spin_unlock(&nfs_uuid->lock);
> +		nfs_to_nfsd_file_put_local(ro_nf);
> +		nfs_to_nfsd_file_put_local(rw_nf);
> +		cond_resched();
> +		spin_lock(&nfs_uuid->lock);
>  		/* Now we can allow racing nfs_close_local_fh() to
>  		 * skip the locking.
>  		 */
>  		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> -
> -		nfs_to_nfsd_file_put_local(ro_nf);
> -		nfs_to_nfsd_file_put_local(rw_nf);
> -
> -		cond_resched();
> +		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
>  	}
>  
> -	spin_lock(&nfs_uuid->lock);
> -	BUG_ON(!list_empty(&nfs_uuid->files));
> -
>  	/* Remove client from nn->local_clients */
>  	if (nfs_uuid->list_lock) {
>  		spin_lock(nfs_uuid->list_lock);
> @@ -302,22 +313,46 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		return;
>  	}
>  
> +	spin_lock(&nfs_uuid->lock);
> +	if (!rcu_access_pointer(nfl->nfs_uuid)) {
> +		/* nfs_uuid_put has finished here */
> +		spin_unlock(&nfs_uuid->lock);
> +		rcu_read_unlock();
> +		return;
> +	}
> +	if (list_empty(&nfs_uuid->files)) {
> +		/* nfs_uuid_put() has started closing files, wait for it
> +		 * to finished
> +		 */
> +		spin_unlock(&nfs_uuid->lock);
> +		rcu_read_unlock();
> +		wait_var_event(&nfl->nfs_uuid,
> +			       rcu_access_pointer(nfl->nfs_uuid) == NULL);
> +		return;
> +	}
> +	/* tell nfs_uuid_put() to wait for us */
> +	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> +	spin_unlock(&nfs_uuid->lock);
> +	rcu_read_unlock();
> +
>  	ro_nf = xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
>  	rw_nf = xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
> +	nfs_to_nfsd_file_put_local(ro_nf);
> +	nfs_to_nfsd_file_put_local(rw_nf);
>  
> +	rcu_read_lock();
> +	if (WARN_ON(rcu_access_pointer(nfl->nfs_uuid) != nfs_uuid)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
> +	 * that we are done.
> +	 */
>  	spin_lock(&nfs_uuid->lock);
> -	/* Remove nfl from nfs_uuid->files list */
>  	list_del_init(&nfl->list);
> +	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
>  	spin_unlock(&nfs_uuid->lock);
>  	rcu_read_unlock();
> -	/* Now we can allow racing nfs_close_local_fh() to
> -	 * skip the locking.
> -	 */
> -	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> -
> -	nfs_to_nfsd_file_put_local(ro_nf);
> -	nfs_to_nfsd_file_put_local(rw_nf);
> -	return;
>  }
>  EXPORT_SYMBOL_GPL(nfs_close_local_fh);
>  
> -- 
> 2.49.0
> 
> 

