Return-Path: <linux-nfs+bounces-10247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89DA3EE98
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25766171ABC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D281FBC9E;
	Fri, 21 Feb 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0LSJYU5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE22AEF1;
	Fri, 21 Feb 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126200; cv=none; b=GHt4KwOFOeguwBV1IwaW4v3G8ys6lZP79kMI8d4azgDiR0Fx5vYF6Ieip50DgVpLYe8Bdk+PLvNiN7BzaESE8PeRW2dfRGV2/Ejj84GlAaaW++PmBQMhCFgHb47fbbyisDphoR+k3R2WBn8pTeH+1ZBNVxe6k2D7DYeRAJVbcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126200; c=relaxed/simple;
	bh=rfDIIQH5mrDRATR5TGl8kCDlcFHPJIwo/TE0dNwgcqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQi1RRS8V23kWquzhUzu+heRA2x8ic+m6J0SgqzDkf1V3HcKMdLoqnW9xP53qzPIMyEeMY5uRs8mDl7Wdz44BNHXyIb4Ka6YdBZQdEEtJRZivXdpuQLHO9HIBGes2mUN/vJ8Lc+JNuzMTDO5nkuHc11LW8APPA/tdMs+8nJ2Opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0LSJYU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B689C4CED6;
	Fri, 21 Feb 2025 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740126199;
	bh=rfDIIQH5mrDRATR5TGl8kCDlcFHPJIwo/TE0dNwgcqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0LSJYU5KyWZzwrQDlUAUR1+8PdJD+JaUQ+RLHCwHnImb/aTfszjDTaUmt201JjQq
	 3NSxzfU1CmNjl0LDjhcjrM1Rrwm/4QMYSfHwN0G/QTNX89WIPkfon9hKuX6Ht7F5Mm
	 zaYOVfJcV2g0J8ojXaojC2FZrHA/SkmbWC4d1Y3C+C3RjCIno5WK6acxsxs6MX02qS
	 JRqXk9WvCkGis8RAaDwX7YXG+B+rFn3G86rUyzPhJyzUx4jhoEOvIUf6KFH48J/CZz
	 Hmctg7CCe/8hgZINR8gwlxcOqQnb13s8DsCpP3TVIeFJ1onvx9Kt5NSk2yCKY/VU5U
	 FuL78IkEAbnaA==
Date: Fri, 21 Feb 2025 09:23:14 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, Leon Romanovsky <leon@kernel.org>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 0/9] Fixes multiple sysctl bound checks
Message-ID: <d56pptdshudhgubqmgcag5gwfadwzntg2tz3av6wfijn77lvui@dxtbse27guev>
References: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>

On Mon, Jan 27, 2025 at 03:19:57PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Hi,
> 
> This patchset adds some bound checks to sysctls to avoid negative
> value writes.
> 
> The patched sysctls were storing the result of the proc_dointvec
> proc_handler into an unsigned int data. proc_dointvec being able to
> parse negative value, and it return value being a signed int, this could
> lead to undefined behaviors.
> This has led to kernel crash in the past as described in commit
> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> 
> Most of them are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
> nf_conntrack_expect_max is bounded between SYSCTL_ONE and SYSCTL_INT_MAX
> as defined by its documentation.
> 
> This patchset has been written over sysctl-testing branch [1].
> See [2] for similar sysctl fixes currently in review.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-testing
> [2]: https://lore.kernel.org/all/20250115132211.25400-1-nicolas.bouchinet@clip-os.org/
> 
> Best regards,
> 
> Nicolas
I see that you have received several reviews suggesting that you post
some of the patches in this series separately. Please remove these for
your V2 so we do not duplicate efforts.

Thx

> 
> ---
> 
> Nicolas Bouchinet (9):
>   sysctl: Fixes nf_conntrack_max bounds
>   sysctl: Fixes nf_conntrack_expect_max bounds
>   sysctl: Fixes gc_thresh bounds
>   sysctl: Fixes idmap_cache_timeout bounds
>   sysctl: Fixes nsm_local_state bounds
>   sysctl/coda: Fixes timeout bounds
>   sysctl: Fixes scsi_logging_level bounds
>   sysctl/infiniband: Fixes infiniband sysctl bounds
>   sysctl: Fixes max-user-freq bounds
> 
>  drivers/char/hpet.c                     |  4 +++-
>  drivers/infiniband/core/iwcm.c          |  4 +++-
>  drivers/infiniband/core/ucma.c          |  4 +++-
>  drivers/scsi/scsi_sysctl.c              |  4 +++-
>  fs/coda/sysctl.c                        |  4 +++-
>  fs/lockd/svc.c                          |  4 +++-
>  fs/nfs/nfs4sysctl.c                     |  4 +++-
>  net/ipv4/route.c                        |  4 +++-
>  net/ipv6/route.c                        |  4 +++-
>  net/ipv6/xfrm6_policy.c                 |  4 +++-
>  net/netfilter/nf_conntrack_standalone.c | 12 +++++++++---
>  11 files changed, 39 insertions(+), 13 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 

Joel Granados

