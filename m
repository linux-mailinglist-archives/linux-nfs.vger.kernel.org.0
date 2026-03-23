Return-Path: <linux-nfs+bounces-20328-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBHLAzVFwWnpRwQAu9opvQ
	(envelope-from <linux-nfs+bounces-20328-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 14:50:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 825072F3551
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 14:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9458A30DA781
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F9340298;
	Mon, 23 Mar 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEbLmqL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF83AC0FD
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273211; cv=none; b=nBQ4G5lkafhVq5YAmRKnKi50vUqHYANCUCO1gRcM8G+qGa9WaTdRcHtUtnpgl5GGnmtO9qdEYsInGxx+S0lN1hLnzdsRy91LDt9oPY2UscFvSC7VWLEW2qrw3AgPLdvEzidLiHNfkWox5AzBeNbYOPWgJ4fLJZnCCostgRWgybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273211; c=relaxed/simple;
	bh=9Dpyg3x+Sk+U3kRUJdvpysAh9AH8CKJHWEUbI70f5us=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uqTpRZajrzPWYyA1G+zav3aPVppkvLyrmH5uggB9uykckqRQ80BH2hJn3j2edEDi4jvZ5Wc7pXfwbn3HqUYKPPmXP77njYc21GcLX6cg3dlaEmNlS+OGT2Ydffa/MZlbXW3y5r9/F9W2iJmIHjhrU5c3G5ddUvjcCmYN1Q1TwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEbLmqL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D37CC2BC9E;
	Mon, 23 Mar 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273211;
	bh=9Dpyg3x+Sk+U3kRUJdvpysAh9AH8CKJHWEUbI70f5us=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iEbLmqL3bxeG7z+kPGDzfV+tMPVhaJR3/7wlp122wulkvNVO9th6vqm6SiyoRaU0c
	 ywPy2xk8T5vE8KiPgx6UVKDQNHk3bXStuVSdSLlTGz37+1xp/iGh71qS31FFEwdm4C
	 xe5RGWZTAqUDP1VQm1QwxaEmoqGZcTKjMH8A8jbyw6SjTZ2HAryCnahIXaVxUmoA1s
	 7R4s2PfE29JSwKdi/Kdt99Jc9+4sc66T1M3jojzq9m8y/Meh8GFK5V+AdvVmsJn53h
	 2W14EMdSeoC32K8duMyQcCkOC2/MCsb/9PGDn5Q8juAwr/2yZCf5PGFjTVB7956QHH
	 fwAe2QqOplWWQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 13E0AF40077;
	Mon, 23 Mar 2026 09:40:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 09:40:10 -0400
X-ME-Sender: <xms:uULBaSqAvbG5Yihhtfwuzu2qLHTaiLQV7QoHoWTP3PgbscBZ8uiWyw>
    <xme:uULBabchHF18oVppJoR4JAihRtjqTsfEKHYzc1yjszSMsfqVb6VzEBc3XCJZyqUmG
    7QomgeNxacL5EfCiyQR7-BHrSharHt5ThZDGsi0a_bC1BjmiXJj3vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthh
    eslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghl
    phgvhidrtghomh
X-ME-Proxy: <xmx:uULBaemJHQCoN9xafdBNqp3tAHd9Fis9Si_0rmR895Q2lNXPXhKkMA>
    <xmx:ukLBacOMsRlxdYHZ1HyqYOK5B2eP82qTtgVpif9N7ligDfDKmJwcMg>
    <xmx:ukLBaY5CxM87bmFQsfuY_KmoqCWI6T1Vv9fHP2KCiQNZEN9344gUjQ>
    <xmx:ukLBaQaKsa6K-W7z9af17CEEcVDnTbpTJ42uc7vOvjVZ95DptyWJuw>
    <xmx:ukLBaVczC-5AbMzpJn_xtiCUF-2sLeQrEm3SRMi7-FjypberLOAYYNFK>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D88B0780070; Mon, 23 Mar 2026 09:40:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIsm7hYmK1tN
Date: Mon, 23 Mar 2026 09:39:48 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Carlos Maiolino" <cem@kernel.org>, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <1fbdc5d9-d95c-4d1a-816e-028ffd1231b0@app.fastmail.com>
In-Reply-To: <20260323070746.2940140-2-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
 <20260323070746.2940140-2-hch@lst.de>
Subject: Re: [PATCH 1/7] exportfs: split out the ops for layout-based block device
 access
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20328-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 825072F3551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Mar 23, 2026, at 3:07 AM, Christoph Hellwig wrote:

> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..616984fe3873 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2014 Christoph Hellwig.
>   */
>  #include <linux/blkdev.h>
> +#include <linux/exportfs_block.h>
>  #include <linux/kmod.h>
>  #include <linux/file.h>
>  #include <linux/jhash.h>
> @@ -127,6 +128,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
>  {
>  #if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
>  	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
> +	struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
>  #endif
> 
>  	if (!(exp->ex_flags & NFSEXP_PNFS))
> @@ -136,14 +138,11 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
>  	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
>  #endif
>  #ifdef CONFIG_NFSD_BLOCKLAYOUT
> -	if (sb->s_export_op->get_uuid &&
> -	    sb->s_export_op->map_blocks &&
> -	    sb->s_export_op->commit_blocks)
> +	if (bops->get_uuid && bops->map_blocks && bops->commit_blocks)
>  		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
>  #endif
>  #ifdef CONFIG_NFSD_SCSILAYOUT
> -	if (sb->s_export_op->map_blocks &&
> -	    sb->s_export_op->commit_blocks &&
> +	if (bops->map_blocks && bops->commit_blocks &&
>  	    sb->s_bdev &&
>  	    sb->s_bdev->bd_disk->fops->pr_ops &&
>  	    sb->s_bdev->bd_disk->fops->get_unique_id)

block_ops itself is NULL for any filesystem that does not provide
block layout support (everything other than XFS today).

When an admin exports such a filesystem with pNFS enabled
(NFSEXP_PNFS), svc_export_parse() calls nfsd4_setup_layout_type(),
and bops->get_uuid dereferences a NULL pointer.

Something like the following would restore the original behavior:

    if (bops && bops->get_uuid && ...)


-- 
Chuck Lever

