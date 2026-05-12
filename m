Return-Path: <linux-nfs+bounces-21493-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNCTKbbTAmrPxwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21493-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:16:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DC51B9CF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACDD230D265D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494D3F23D2;
	Tue, 12 May 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZVW7Qui"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4E357D08;
	Tue, 12 May 2026 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569722; cv=none; b=ZacpkcsJD/F3dELlzrPe8rrb0XbUq3+VehYSBxgHLHxyPrLhm8h1DVTFkKx4vTJ8TGUa6nM1zYNwJzXKMkGrFhIEGUkST6kktVBFLtzSdZkJCpfiblZP+JzP5Z6vKBQ9H5GYmuAl2JNs7UU5DzMhdnmiimNZ3/iJ+eK/VuDjRZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569722; c=relaxed/simple;
	bh=5R+EGY533uqCmLzbRat4246szQJrvxiGXh+zrcNZP8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ/tT+5p2sM4JWHzRLZkPhbZC1yih/gvOJK9nyvA5tVfDW6cvm+Jgvfoy7SevddRJlhhJzGd+WDLpw+TPbpvVvg7LIvcRew3rbikdnLLn5s37GpyGC+PB8Ta6Tmi3H4MAhlusbVHNfD8Jj4bXbiubTFZoOdhU6+BBoIf4vizWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZVW7Qui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6A5C2BCFD;
	Tue, 12 May 2026 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778569721;
	bh=5R+EGY533uqCmLzbRat4246szQJrvxiGXh+zrcNZP8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZVW7Qui1CP12PCsES+DAfGefhgG6ZsGG+IPd29OfkaPW+1CkthidE8AZJwY75U0C
	 4rNrhnRBljNrhbvZDbEiEgSRDdXMcjdraEcCwuiJdxsOXLKnGqhSVmrr/6hhPR2x9L
	 5vwiYRzb+7Elk2tmObpq81hcArgCm9ZegwZDJEAkv9M9iicfMeRn5NaRYpNZWqfPOE
	 2HWszZ/4Gxf/5HGNX9W/seayQBqvEPgMe4Hs7m6wvAkzGhJbO9TvFDGMPWP3Yn5FY9
	 SZ27OhjGJ/CoGsGG5mf9JCFTzQ3uplWm0vr4OAI+NqYEiilCS2Y4tpjuYjp3Qie9BH
	 /RQBnxU6ladzQ==
Message-ID: <03dddf72-8755-4ebf-ba79-456377f0f25d@kernel.org>
Date: Tue, 12 May 2026 16:08:35 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] swap: remove the maxpages variable in sys_swapon
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4E9DC51B9CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21493-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 14:35, Christoph Hellwig wrote:
> Always use si->max which is updated setup_swap_extents instead of copying
> into and out of maxpages.

Checking mm/swapfile.c, I see s->max being set only in swapon(). Is this a typo
or am I misunderstanding this sentence ?

Looks good otherwise, but it would be nice to rename ->max to ->maxpages to make
it clear what this is counting.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9174f1eeffb0..f7ebd97e28a3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3350,10 +3350,9 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
>  }
>  
>  static int setup_swap_clusters_info(struct swap_info_struct *si,
> -				    union swap_header *swap_header,
> -				    unsigned long maxpages)
> +				    union swap_header *swap_header)
>  {
> -	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
> +	unsigned long nr_clusters = DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER);
>  	struct swap_cluster_info *cluster_info;
>  	int err = -ENOMEM;
>  	unsigned long i;
> @@ -3395,7 +3394,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
>  		if (err)
>  			goto err;
>  	}
> -	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++) {
> +	for (i = si->max; i < round_up(si->max, SWAPFILE_CLUSTER); i++) {
>  		err = swap_cluster_setup_bad_slot(si, cluster_info, i, true);
>  		if (err)
>  			goto err;
> @@ -3425,7 +3424,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
>  	si->cluster_info = cluster_info;
>  	return 0;
>  err:
> -	free_swap_cluster_info(cluster_info, maxpages);
> +	free_swap_cluster_info(cluster_info, si->max);
>  	return err;
>  }
>  
> @@ -3440,7 +3439,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	union swap_header *swap_header;
>  	int nr_extents;
>  	sector_t span;
> -	unsigned long maxpages;
>  	struct folio *folio = NULL;
>  	struct inode *inode = NULL;
>  	bool inced_nr_rotate_swap = false;
> @@ -3512,14 +3510,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	}
>  	swap_header = kmap_local_folio(folio, 0);
>  
> -	maxpages = read_swap_header(si, swap_header, inode);
> -	if (unlikely(!maxpages)) {
> +	si->max = read_swap_header(si, swap_header, inode);
> +	if (unlikely(!si->max)) {
>  		error = -EINVAL;
>  		goto bad_swap_unlock_inode;
>  	}
>  
> -	si->max = maxpages;
> -	si->pages = maxpages - 1;
> +	si->pages = si->max - 1;
>  	nr_extents = setup_swap_extents(si, swap_file, &span);
>  	if (nr_extents < 0) {
>  		error = nr_extents;
> @@ -3531,14 +3528,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap_unlock_inode;
>  	}
>  
> -	maxpages = si->max;
> -
>  	/* Set up the swap cluster info */
> -	error = setup_swap_clusters_info(si, swap_header, maxpages);
> +	error = setup_swap_clusters_info(si, swap_header);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  
> -	error = swap_cgroup_swapon(si->type, maxpages);
> +	error = swap_cgroup_swapon(si->type, si->max);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  
> @@ -3546,7 +3541,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
>  	 * be above MAX_PAGE_ORDER incase of a large swap file.
>  	 */
> -	si->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
> +	si->zeromap = kvmalloc_array(BITS_TO_LONGS(si->max), sizeof(long),
>  				     GFP_KERNEL | __GFP_ZERO);
>  	if (!si->zeromap) {
>  		error = -ENOMEM;
> @@ -3597,7 +3592,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		}
>  	}
>  
> -	error = zswap_swapon(si->type, maxpages);
> +	error = zswap_swapon(si->type, si->max);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  


-- 
Damien Le Moal
Western Digital Research

