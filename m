Return-Path: <linux-nfs+bounces-20553-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AzyJa0PzGnGNgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20553-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:17:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C202D36FD63
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E85306727D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E4543DA31;
	Tue, 31 Mar 2026 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3OANtEv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F270330315;
	Tue, 31 Mar 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980049; cv=none; b=gQ/6wDL2v+3a0XgTOGU8l4gB2KFE9oGtm3Yo6Pwn2o+Ku8gu8gCz+HCDcoALLvhZTdqCDgdHTNMX/z+NsE9s25p+KOFXqtr+TmcjwqteKg213TJVS2x8O6ehlmWmEWa0SDHLxQH8seX4PvjHy2qnfWbwxCE6jE3urYcDa1lBGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980049; c=relaxed/simple;
	bh=dv9DtVxcdAIdJ+XqPqe9tbrFlat1e5l9/W/8NUAs9R4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tUZwLiq+Msmq0xmjIAtpE5rFixM9+qL4/aSZYEpPloeBKUNmDEOYt5KV2nzoi9UTsr9lrG82ijKppMnRMlcUfKwtvcAn48DnSW4d3J73Wv79ZnJ8Uc2waF/zIBD0Xj9oA2q8t2QuVsEvSudD7DVK+gdtn6yo1Wx2UVfQZX4KpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3OANtEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E81C19423;
	Tue, 31 Mar 2026 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980048;
	bh=dv9DtVxcdAIdJ+XqPqe9tbrFlat1e5l9/W/8NUAs9R4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=P3OANtEvbj37G8atFO01FmBT96bmoANwwLj9QWHzfbQXRwAdZocXCmtwpsYceSBWh
	 hZ3gmfMELpdUFqNVrLflbuVbYtDDPwpG/DJ7cc/1oK49F2Lpkj/HarLM0nO3QFO+YC
	 cLb/sqrRPYC96ITxVLH38g3YtvKYtoHsMseE4zWFat0loLQFq63j/RBcgmJXdae1Cb
	 PDCmebUNZ6IoaviUtmUGyp7g0uvreqEA4757uWC64r33AAryrsUwiku0iZfkSzP4vF
	 Pl0TUARzvZRZHiP9An22IB/yDi4jNlZFz9Yz7pDklhsMJcmI5hhSw9P9mlc7EpuO0e
	 8BzZiWWkL5Y0g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 13032F40075;
	Tue, 31 Mar 2026 14:00:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 14:00:47 -0400
X-ME-Sender: <xms:zgvMaQtoj14zwhTRQ_g0d7T2xfVXvn2x49bLtLMzG_rbveZVtC6BfQ>
    <xme:zgvMaYQCPGrxJmoSwy3K_aV-x7_32u_99VqOufTr7TI0bU-VQOrOgMmLfLHE7TYCN
    NdI7FdoXKTaleKQUPCkIfTpCrf6LGv2xfdyWY_Z6uyL51vlFEhfopzO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegurghirdhnghhosehorh
    grtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zwvMad4M11ITgEgoDYYXAiXCgK1fpWE0nUzVLrWwUgweiKvwMNHA0g>
    <xmx:zwvMaQ5myrT8Ef568XdzV_1rotwrzfUyITspzjV-jWsayCN2SKYBpQ>
    <xmx:zwvMafRwhp7Ry3Cnsp7B40R5iHpaLtxwMTMq7wYAKE4KRnnEiY1T5g>
    <xmx:zwvMaY9gG8Qw9njMBUrIrtxaJq8xLyo8MOL_SpxwrwEkmLh8YP-Fuw>
    <xmx:zwvMaQZZt6e7dH3hjggunV1EtlOy4mz18n5zZjSmjkgAntePltW8IwIU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E0A57780070; Tue, 31 Mar 2026 14:00:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AY177NKMEKMk
Date: Tue, 31 Mar 2026 14:00:25 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <2ab53378-7faf-4518-a337-8bbb0fdae9a5@app.fastmail.com>
In-Reply-To: <20260331153406.4049290-5-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
 <20260331153406.4049290-5-hch@lst.de>
Subject: Re: [PATCH 4/4] exportfs,nfsd: rework checking for layout-based block device
 access support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20553-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.825];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C202D36FD63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Mar 31, 2026, at 11:33 AM, Christoph Hellwig wrote:

> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index c53eb67969eb..7b849b637b5e 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (c) 2014 Christoph Hellwig.
>   */
> -#include <linux/blkdev.h>
>  #include <linux/exportfs_block.h>
>  #include <linux/kmod.h>
>  #include <linux/file.h>
> @@ -126,28 +125,17 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, 
> const struct svc_fh *fhp,
> 
>  void nfsd4_setup_layout_type(struct svc_export *exp)
>  {
> -#if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
>  	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
> -	struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
> -#endif
> -
> -	if (!(exp->ex_flags & NFSEXP_PNFS))
> -		return;
> +	expfs_block_layouts_t block_supported = exporfs_layouts_supported(sb);

^exporfs^exportfs

throughout the patch.


> -#ifdef CONFIG_NFSD_FLEXFILELAYOUT
> -	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
> -#endif
> -#ifdef CONFIG_NFSD_BLOCKLAYOUT
> -	if (bops && bops->get_uuid && bops->map_blocks && bops->commit_blocks)
> +	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
> +		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
> +	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
> +	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))
>  		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
> -#endif
> -#ifdef CONFIG_NFSD_SCSILAYOUT
> -	if (bops && bops->map_blocks && bops->commit_blocks &&
> -	    sb->s_bdev &&
> -	    sb->s_bdev->bd_disk->fops->pr_ops &&
> -	    sb->s_bdev->bd_disk->fops->get_unique_id)
> +	if (IS_ENABLED(CONFIG_NFSD_SCSILAYOUT) &&
> +	    (block_supported & EXPFS_BLOCK_OUT_OF_BAND_ID))
>  		exp->ex_layout_types |= 1 << LAYOUT_SCSI;
> -#endif
>  }
> 
>  void nfsd4_close_layout(struct nfs4_layout_stateid *ls)


-- 
Chuck Lever

