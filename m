Return-Path: <linux-nfs+bounces-4121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7790FC18
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5E1F24FBA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0722625;
	Thu, 20 Jun 2024 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUMpX/5s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1A37E
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859895; cv=none; b=eq28iK5fxDSoxO4gnw7+ZvKc7wu38lqwwU03M7qbXSW0o3J+WlK+MMHy9z+10/VL8Ks4gJWZPVOIBqstyuGKD1qPwDwmBlBO9iqurxxlCwYCre6DGNHaWVxzP/nnOYf/5fxWhbnHHRbclz7B5O6YJ748Z0eVwr8Xpoc6fipHzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859895; c=relaxed/simple;
	bh=SP2/Yi4YEwbwRkI1Q2iV5+ugwjtLYDmQrzwdzVkYkfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEP5UtD0Gi0IM2pk6rm6BEXpvtyPf9I5gK62SJfKqGc7AgRW3Nq5xHWE+HPfes8RcgysPqNepdmlEzmyDmZfDKtpPW2N8W0FDE5Yj/o0m2U7sY95yqbRZLTcduf2o6uWkcU5HVrMiQ2OZ9s0iRBpv9jJ9PaOkreZqEj9k4Gh3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUMpX/5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF1C2BD10;
	Thu, 20 Jun 2024 05:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718859894;
	bh=SP2/Yi4YEwbwRkI1Q2iV5+ugwjtLYDmQrzwdzVkYkfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUMpX/5s4q0HUrj3K/82q6fL/Ku/syt2ojt2HBbS4d2zY5Ro/gptSFTaxEu6bwBCR
	 rYl7LoHccYJYmDnCNyNLiwuS8mu8+4rmQHHLq/wLmUFwyDew/MQ1miWx0vMuBHdrXY
	 dYbIBLAlAgwsInBMbDnBaF6N2pjD3qBXNyBanS/ArhXZhJ7kmHeLKt2OMonum+LF+K
	 vjcCHO2yVuWMX7MwUfZVXrL3K2Zq1sYBXN/eY4So6BC0in2fRZ6ARrzq/5QTNB2SgI
	 mGdRqbnXrMpB8Nb6x1aAIbfX6RPSQdofO+Sd4r5hL5Y2KtP2MZ3Jf8Y8wLIwcOmiaq
	 X+VNIoPlE+9LA==
Date: Thu, 20 Jun 2024 01:04:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 00/18] nfs/nfsd: add support for localio
Message-ID: <ZnO4dQE-_1lh8RXV@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>

On Wed, Jun 19, 2024 at 04:40:14PM -0400, Mike Snitzer wrote:
> Hi,
> 
> This v6 changes include:
> - Quite a bit of rebasing to eliminate intermediate steps that include
>   throwaway code (thanks to Jeff Layton for calling those out).
> - Moved the Kconfig changes to the end of the series to ensure that
>   localio cannot be enabled until the code is feature complete.
> - Removed needless nfsd_serv_sync() call from nfsd_create_serv().
> - Removed inline from fs/nfsd/localio.c:nfs_stat_to_errno
> - Wrapped localio struct nfs_client members and related
>   fs/nfs/client.c init code with #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> - Requested a unique RPC program number from IANA but switched to
>   using 0x20000002 until one is assigned.
> - Improved the Documentation and some code comments.
> 
> Otherwise, not a lot of actual code changes.
> 
> My git tree is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

FYI, I've staged some will-be v7 improvements (mainly to client code)
in the nfs-localio-for-6.11 branch:

- factored out duplicate localio xdr code
- moved the too-large-to-inline nfs_init_localioclient to localio.c

Just a heads-up without spamming with another patchbomb.

Mike

