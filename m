Return-Path: <linux-nfs+bounces-21530-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOFHAQhaA2o35QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21530-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:49:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C365250FA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1550130C5B9F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294CF3D79F2;
	Tue, 12 May 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhDaw5al"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1E3D79EF;
	Tue, 12 May 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604189; cv=none; b=g0c3739c3jP05oKUXfIL72v6g0c2eKECBdlEJ2m7F4AGxZKxgb4eZilFmHvZ1nuQ1j2XYmGPNnzm1ubC/iPgSFCjfdIQMm0XMA07LZc/4bVdy+3DaCrgVJsxRNsPV9S4DkwYVUzlAwH1Yp4j3xABh5n9XJXdDdMft1RQsg904oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604189; c=relaxed/simple;
	bh=PBZrTiN4pAoVDQXCJJ+alWgO2xkZJqjotuEKJ6A2uec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTDCkCTVC3i2MGwkow19dY4IlzgSWYY37xbZE2KoqVtofYlv6tGTasDNGyqt8WCxBtHDq6VgGZ+7OwvS6elqulsuBTFpb04V5LUzSFkuaqpwjuO2SEZ/5A2VaZph2oOB2r/mRFmD6FY+ZeQ/Zjr14AAzew0Ie2xIaCbT8rOH7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhDaw5al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B5C2BCF6;
	Tue, 12 May 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604188;
	bh=PBZrTiN4pAoVDQXCJJ+alWgO2xkZJqjotuEKJ6A2uec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhDaw5alyksUgGWr7B+0tNRNRMhWix5nRIyBwa98tq/kd6I8j+shUG6aVX4PjpvCV
	 T0UPqngSxtLEFupErYJkxP6xFRAzIkRfQwy84MuvBPY0FvI7QEYc94CPrTP2bmwrXX
	 d/otVY/0Kkw1xfrrVmsd2Er2k2zyg56OwnHH3xBSjgLwQu0/pnFnSdhe5iyEuqvWiJ
	 8Q8dB1D3YHgUfms3a7YcngYBDEhhHjo5vNSt2zuw5VNg0vWPLMGb8+TM2WzzgGb37n
	 luePu92paJZ4t8fhc+C51bQBP0YyCtdfc0OkYS94Y5yjSIvG0Ls6lxWYIA4uojhZML
	 lBXUfTYggysNQ==
Date: Tue, 12 May 2026 09:43:08 -0700
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
Subject: Re: [PATCH 05/12] swap: cleanup setup_swap_extents
Message-ID: <20260512164308.GF9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-6-hch@lst.de>
X-Rspamd-Queue-Id: B9C365250FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21530-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:21AM +0200, Christoph Hellwig wrote:
> Reflow setup_swap_extents so that the flag checking is not conditional on
> a swap_activate method.  This is currently a no-op because the swapoff
> code still checks the presence of a swap_deactivate method, but it
> simplifies adding a new check, and also makes the SWP_ACTIVATED flag
> more consistent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 651c1b59ff9f..1b7fc03612f4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
>  {
>  	struct address_space *mapping = swap_file->f_mapping;
>  	struct inode *inode = mapping->host;
> -	int ret;
> +	int ret, error = 0;

/me wonders why not reuse ret instead of declaring a new variable?

--D

>  
>  	if (S_ISBLK(inode->i_mode))
>  		return add_swap_extent(sis, sis->max, 0);
>  
> -	if (swap_file->f_op->swap_activate) {
> +	if (swap_file->f_op->swap_activate)
>  		ret = swap_file->f_op->swap_activate(swap_file, sis);
> -		if (ret < 0)
> -			return ret;
> -		sis->flags |= SWP_ACTIVATED;
> -		if ((sis->flags & SWP_FS_OPS) &&
> -		    sio_pool_init() != 0) {
> -			destroy_swap_extents(sis, swap_file);
> -			return -ENOMEM;
> -		}
> +	else
> +		ret = generic_swap_activate(swap_file, sis);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	return generic_swap_activate(swap_file, sis);
> +	sis->flags |= SWP_ACTIVATED;
> +	if (sis->flags & SWP_FS_OPS)
> +		error = sio_pool_init();
> +	if (error)
> +		destroy_swap_extents(sis, swap_file);
> +	return error;
>  }
>  
>  static void _enable_swap_info(struct swap_info_struct *si)
> -- 
> 2.53.0
> 
> 

