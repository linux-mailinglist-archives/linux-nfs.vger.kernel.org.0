Return-Path: <linux-nfs+bounces-21536-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N2zD+thA2oq5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21536-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:22:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53558525C07
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C517E302A9CF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21B385D74;
	Tue, 12 May 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxFaNE5w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D8385D67;
	Tue, 12 May 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605796; cv=none; b=HDylWu2wYINipySPi5qcj6sCgz52UBQYhbhEBClcSEJpyqbIcjspnDDjT2NK0I90Y6m71jEh4GTYo9VU0uxjyW3YSihjfFb6lFa5bUfA8Ruy/j3k9E09HLIAv5Ifp/CnOZAUc1lN/AbZN7qkn33gFm4wAdjLKSmKES2FaotdUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605796; c=relaxed/simple;
	bh=3aHXpzD86WhvrwXcIwdK9qFl/6Uw/9X6ePBZAS123EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4Pc2AUjxedNn12lDvWu2Lv1dtzKoxzc4iQoIShez6QnWyX6h7VNtKYDfhFjTrPStZ6iGeZAsEL3oI1+ra0DFJSuoids67lArBaj8tiXazV7z++mdQMuhykaDtvds8ZKCkvQBGqsFbIDAZ4IuqiaUzdPp2Zja/dQrS8UwjsA2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxFaNE5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD890C2BCC7;
	Tue, 12 May 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605795;
	bh=3aHXpzD86WhvrwXcIwdK9qFl/6Uw/9X6ePBZAS123EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxFaNE5wPAV876f9BvjR4wqLnwTIKIo7fOPGapy+ipTeWdy0jpxo8hQ2Ri0GGHmrp
	 CqEc/osq1V/20la7b58M49nDmb9ZDPQ1HRb652DRaiRlrgV68syhNYSwQ7oTHrZcE6
	 e3va7ElR0K9PdL8DhzMxSzWHChNELJn1/XKK6AOCxoD6uzKfeHErjVWG/d7wnQJObm
	 qV6eLTMTIGPO9wJvaDH523pfBAeOI6zjjN0aAdpxBGGOZXqoEOYhYlGqvV2ZUbFiua
	 kABUvY5GndwreOZSc90aCC87nHpz2HeFvQqE+CWvH5k/2Gj9vksO/G6bmHaKnlQRkP
	 sADrDRhCj51HQ==
Date: Tue, 12 May 2026 10:09:55 -0700
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
Subject: Re: [PATCH 11/12] swap: move struct swap_extent to swapfile.c
Message-ID: <20260512170955.GL9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-12-hch@lst.de>
X-Rspamd-Queue-Id: 53558525C07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21536-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:27AM +0200, Christoph Hellwig wrote:
> struct swap_extent is only used inside of mm/swapfile.c, so move it
> there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Woo, information hiding!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/linux/swap.h | 15 ---------------
>  mm/swapfile.c        | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 916889738f08..95237ee065c2 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -178,21 +178,6 @@ struct sysinfo;
>  struct writeback_control;
>  struct zone;
>  
> -/*
> - * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
> - * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
> - * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
> - * from setup, they're handled identically.
> - *
> - * We always assume that blocks are of size PAGE_SIZE.
> - */
> -struct swap_extent {
> -	struct rb_node rb_node;
> -	pgoff_t start_page;
> -	pgoff_t nr_pages;
> -	sector_t start_block;
> -};
> -
>  /*
>   * Max bad pages in the new format..
>   */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 26852c2ad36e..c0479533f9ef 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -260,6 +260,21 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	return ret;
>  }
>  
> +/*
> + * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
> + * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
> + * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
> + * from setup, they're handled identically.
> + *
> + * We always assume that blocks are of size PAGE_SIZE.
> + */
> +struct swap_extent {
> +	struct rb_node rb_node;
> +	pgoff_t start_page;
> +	pgoff_t nr_pages;
> +	sector_t start_block;
> +};
> +
>  static inline struct swap_extent *first_se(struct swap_info_struct *sis)
>  {
>  	struct rb_node *rb = rb_first(&sis->swap_extent_root);
> -- 
> 2.53.0
> 
> 

