Return-Path: <linux-nfs+bounces-21535-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oElbCxNgA2r65QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21535-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:14:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C0525965
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE9FD304AA9C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF641385D71;
	Tue, 12 May 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOIMsY8R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9484385D63;
	Tue, 12 May 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605767; cv=none; b=fShJJt5lmRuupoyQs+LPiSTDTfT4gylTbMvrpxTFyWKyvb0JRNi1AYh12oCNxlaAwLJViwNkAntfiKZCIDxpRY2zEaClEQnpNNC8eu0f0DBYK8y3ZZFKYSp9wp88ySuqw7Ba0OtwtZQfUaa2bNBKwhxE+huFveA8QUGyyNCToFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605767; c=relaxed/simple;
	bh=Adu4k9PdOIdLwtwgwkK9s/zvDBkfua5WJ/GmI2xgu9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK52STnRxINA+zMcM9V4tVQ3qhjQW8ntOrT9BkwBrlhl4YE0hxKEKScnu+CB8VvO15AVQ2MN6j2PkwLeSxSKmIlJ0recJmEqH9sVfLnqeX3MCOGoAuyseLqUS8Ak20oxA+/FQDaWe0BDgWSJQkCpT4YIH6qqqrdqAHdF+mvAuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOIMsY8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66493C2BCB0;
	Tue, 12 May 2026 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605767;
	bh=Adu4k9PdOIdLwtwgwkK9s/zvDBkfua5WJ/GmI2xgu9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOIMsY8RFaGmBa1B0NfQZRKTTC2Opt5G0UGNWkG2xX+oKei2g/2sY1sAEGHPUfcfE
	 bCnaHbLx2Behy/Q86tImeSUpr4suA18Ov4lpRDztKh8E1mdkpboOF+xdQN+859Ke+k
	 YHA9pQoNGul4pjzyGV+AcILGaOLieox338qli/gOFjxsVI3VZUdR9VCQ/hWphy05U9
	 dBvIgkYEiq6XWk478ZrgLGvSBsP97O+F642Ovkd5vN1N1txh6n6sjbOBn/tivsY95b
	 w8EPdawuqPfAI8KY93US4598VyP4RHdazNd8TO2VApANA5L6CfFSVNFZTlOMQzXONy
	 BQNmYWhO7KwKg==
Date: Tue, 12 May 2026 10:09:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 10/12] swap: add a swap_activate_fs_ops helper
Message-ID: <20260512170927.GK9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-11-hch@lst.de>
X-Rspamd-Queue-Id: D89C0525965
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21535-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:26AM +0200, Christoph Hellwig wrote:
> Add a helper abstracting away the low-level details of enabling
> fs_ops-based swapping.  This prepares for taking swap_info_struct
> private.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/nfs/file.c        | 4 +---
>  fs/smb/client/file.c | 3 +--
>  include/linux/swap.h | 5 +++++
>  mm/swapfile.c        | 7 +++++++
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 10ab2a923835..ce4d860c4e7a 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -588,7 +588,7 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
>  	ret = rpc_clnt_swap_activate(clnt);
>  	if (ret)
>  		return ret;
> -	ret = add_swap_extent(sis, sis->max, NULL, 0);
> +	ret = swap_activate_fs_ops(sis);
>  	if (ret < 0) {
>  		rpc_clnt_swap_deactivate(clnt);
>  		return ret;
> @@ -596,8 +596,6 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
>  
>  	if (cl->rpc_ops->enable_swap)
>  		cl->rpc_ops->enable_swap(inode);
> -
> -	sis->flags |= SWP_FS_OPS;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_swap_activate);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index e1bbc65ce7f3..e11065be1e64 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -3326,8 +3326,7 @@ int cifs_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
>  	 * from reading or writing the file
>  	 */
>  
> -	sis->flags |= SWP_FS_OPS;
> -	return add_swap_extent(sis, sis->max, NULL, 0);
> +	return swap_activate_fs_ops(sis);
>  }
>  
>  void cifs_swap_deactivate(struct file *file)
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b1cbb67ddd8e..916889738f08 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -406,6 +406,7 @@ extern void __meminit kswapd_stop(int nid);
>  int add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
>  		struct block_device *bdev, sector_t start_block);
>  int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis);
> +int swap_activate_fs_ops(struct swap_info_struct *sis);
>  
>  static inline unsigned long total_swapcache_pages(void)
>  {
> @@ -532,6 +533,10 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>  {
>  	return -EINVAL;
>  }
> +static inline int swap_activate_fs_ops(struct swap_info_struct *sis)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_SWAP */
>  #ifdef CONFIG_MEMCG
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2c9d2af736c4..26852c2ad36e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2757,6 +2757,13 @@ add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL_GPL(add_swap_extent);
>  
> +int swap_activate_fs_ops(struct swap_info_struct *sis)
> +{
> +	sis->flags |= SWP_FS_OPS;
> +	return add_swap_extent(sis, sis->max, NULL, 0);
> +}
> +EXPORT_SYMBOL_GPL(swap_activate_fs_ops);
> +
>  /*
>   * A `swap extent' is a simple thing which maps a contiguous range of pages
>   * onto a contiguous range of disk blocks.  A rbtree of swap extents is
> -- 
> 2.53.0
> 
> 

