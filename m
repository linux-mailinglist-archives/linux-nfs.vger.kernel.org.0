Return-Path: <linux-nfs+bounces-11286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA3A9CD95
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB941798C0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E842741B0;
	Fri, 25 Apr 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTaelvcm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED72586FE;
	Fri, 25 Apr 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596287; cv=none; b=Ttt8rqyv1lwYVH61oGQPKYKp9BXIGdvJiuSG7uSQwO/Bw5bvg25DE/hkGjVRByYNO8EKA6WE5Qc6YXFkFCMztrm2QIvhtqBmV0/jtIAqHg/68I/hHc2NSR2jfvAv164W5s8AskAsmM3l8Mi9d9KRu0Cb1xIkgdByltlu6dvHY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596287; c=relaxed/simple;
	bh=XqTE9dEmLO6DpOwkOstdXEh9MlJpQlgMtld0lHdoMco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTX24Sz6RuuIj77V2+rKUOjzF3pX3D2aoxYY2AAWQ92CVXmQNJ/MTjuu7ftKHxlk5kW8B5mOdbgDwf6CXqoLzmda4lW+eqw46evDe1rmay/hxvtmZ/ycgrApfsF0wOC5BFyiYsOU75PEeeMf9BNFxo0eda6fVxiHiG1KEVsrScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTaelvcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70E1C4CEE4;
	Fri, 25 Apr 2025 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745596286;
	bh=XqTE9dEmLO6DpOwkOstdXEh9MlJpQlgMtld0lHdoMco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTaelvcmvIF+aEWvkMCTGmeYqKl4EX1l/6rIsUnCABOjiazPhZzzFeotvSm7R0rEh
	 n2DVJFdgX2h8J90NxscFN4yVHSxIgVswQ4le/OIc6lwtjvnnKJO9NFLBisk5+M1Unc
	 xcwTYbXVEG9cG1GB3tK9lO0wFVQF7axLNVJtB8OMV4YseoFlE2XjqUXvKYBSy+Uw0w
	 FeCnI0NUTUYvHF4CWDKFdXTNOQYmX9NdEO/TvLfjwj8OUL2jYtsJ7B0kFbazEgknvd
	 K+6xSrYvFjzdjrHdZRxaKI+z6Y97rWW5Vp6RAgQRzBfjOCUrN4j7rct40r8Y5I8p2i
	 LP0ez8kw7y0aQ==
Date: Fri, 25 Apr 2025 08:51:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/033: Don't call 'fzero' with the KEEP_SIZE
 flag
Message-ID: <20250425155126.GI25667@frogsfrogsfrogs>
References: <20250425152452.105188-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425152452.105188-1-anna@kernel.org>

On Fri, Apr 25, 2025 at 11:24:52AM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> None of the fzero calls in this test end up writing past the end of the
> file, so this flag is unnecessary and can cause the test to fail on
> filesystems that don't implement FALLOC_FL_KEEP_SIZE.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/033 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/033 b/tests/generic/033
> index a9a9ff5a3431..b7df56b82619 100755
> --- a/tests/generic/033
> +++ b/tests/generic/033
> @@ -37,12 +37,12 @@ $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file >> $seqres.full 2>&1
>  # delalloc blocks and convert the ranges to unwritten.
>  endoff=$((bytes - 4096))
>  for i in $(seq 0 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  # now zero the opposite set to remove remaining delalloc extents
>  for i in $(seq 4096 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  _scratch_cycle_mount
> -- 
> 2.49.0
> 
> 

