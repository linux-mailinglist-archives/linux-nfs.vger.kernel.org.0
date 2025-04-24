Return-Path: <linux-nfs+bounces-11279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6804A9B9F4
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1E4681EC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB41F4297;
	Thu, 24 Apr 2025 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udbAG8De"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2D1EDA35;
	Thu, 24 Apr 2025 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530568; cv=none; b=gWR2Krk8iHsTPtdQJH24qFvKyBvSRsb+x3vcsOkhLKfuVmD6o80bvmftcSaau9uFMb6lBaSYpwlY2pwKOZDNOvMf+8jMPPVnRuRJrJSbZGmHuCmb1q8G1ZqnfPFuelWumsUXuaeYOnAfPaBpCr79robhes/C57DAEDh7WGybhkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530568; c=relaxed/simple;
	bh=zcTxWBk7XOqU+gn7WbR/P1YbWH0b7bd7N0Rm5jmwxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSeVTuYBP7Ri0c2VBxvKixgC7P5rvb5ohYt4yrnXKG0gmOhxWH/s1uRZv3jVr1aho1Lmwr2cUudYsgb/4ojJuVWmrq9fH/kA+Vq7Y5qUyi8EdD8V9QeYqY7aBI1p50OwrunY63yn0cpCiiArBKJ9KIWCdwOWf7Xa7jaBDCIHqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udbAG8De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE8C4CEE3;
	Thu, 24 Apr 2025 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530567;
	bh=zcTxWBk7XOqU+gn7WbR/P1YbWH0b7bd7N0Rm5jmwxIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udbAG8Derv6eXO+sV9vQNAEgdtp9uurxi+Et2Ka0AmBLA2Cxq5FgC8IhIAATV/HLd
	 +5l7+zD0DOgtn0iBAaC3HmY1+ESt1USraMODO9ydKncw03fwcMMte9fx5h1xFgJNEn
	 Z/Dx0VPE1JZq/7XhkI+0XOH+DhiFALPUuPjHqbsbdWBNPXKdKHhvEtRYG77PYaUWB0
	 vpnmq17KrOyYtxSwDdEC/IEJJjWdyuOtl3BylBR4kXCgxsqbnbPmP6b2j0rSpUdQS3
	 JFQpxr6tpRlpXif5raJElkTscJfT7wJu++GC8QNB2e7gyzEMBM+Df4cLwMeQuVHyry
	 WhtRETI6vJbUg==
Date: Thu, 24 Apr 2025 14:36:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/033: Check that the 'fzero' operations supports
 KEEP_SIZE
Message-ID: <20250424213607.GF25667@frogsfrogsfrogs>
References: <20250424195730.342846-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424195730.342846-1-anna@kernel.org>

On Thu, Apr 24, 2025 at 03:57:30PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> Otherwise this test will fail on filesystems that implement
> FALLOC_FL_ZERO_RANGE but not the optional FALLOC_FL_KEEP_SIZE flag.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  tests/generic/033 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/033 b/tests/generic/033
> index a9a9ff5a3431..a33f6add67bf 100755
> --- a/tests/generic/033
> +++ b/tests/generic/033
> @@ -20,7 +20,7 @@ _begin_fstest auto quick rw zero
>  
>  # Modify as appropriate.
>  _require_scratch
> -_require_xfs_io_command "fzero"
> +_require_xfs_io_command "fzero" "-k"

I wonder, does this test even need KEEP_SIZE?  It writes 64MB to the
file, then it fzeros every other 4k up to (64M-4k), then fzeroes
everything else.  AFAICT the fzero commands never exceed the file
size...though I could be wrong.

--D

>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount
> -- 
> 2.49.0
> 
> 

