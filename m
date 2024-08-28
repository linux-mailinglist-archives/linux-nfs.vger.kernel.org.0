Return-Path: <linux-nfs+bounces-5836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD9961B43
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631911F23DA6
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F721BC2F;
	Wed, 28 Aug 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGJhG/Pz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC51BC23
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807314; cv=none; b=clTOMHSpZIBdlXB2qmEG7nhwOtiOGPju2s8eGlA0BU0/Bn5Q8tuvC8HqqPKgaFseauaX4dkU5iFh++fGird2Mg/7SnokL82f8QrDxG8egp7Qs/oBMhs2SbjabRCAYIi/JikT0an9344yKpVLnGfMR/XWNpV32mF+gkyLwgdUjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807314; c=relaxed/simple;
	bh=IWcwUlsZyV4vo/escVpLEutqsfRra8Yeily4FmQqoso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA73gBrxFhwquhWxCfycCitHx7PagQsX5bs/lpufkZJoYIhf+nfKirvzYyGWF81EspbR3H/VBbEqZWAOZCjVkzOxwfbMT7yMmhoPbcwsigcmchRWKfRpkDh4h19oEWttKnq8VNBwUiOj8Kh7QM1yvBxBfU2J6lGUdI6O0j+talM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGJhG/Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B3C4DE01;
	Wed, 28 Aug 2024 01:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724807314;
	bh=IWcwUlsZyV4vo/escVpLEutqsfRra8Yeily4FmQqoso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGJhG/PzJra3n/yRp+d3iBpXnKVia35F5mJpP3DOL+sHAu94tAvNt46dDc7BP/Nye
	 0S9Lf4iv2NWYJ8AbkkeLANprphUdqR8PtVRRGax8CuZuwxFCHl0Mg2Strq5AE8YzMF
	 mvc++PkErGAm5uKnUelnDpnG1eEDHQRYvok9T9ERIMLyVPwdXUmc32pfeN1o58gP0x
	 DQYE1MO506sL89jkKz4vncFgODxwAyxM26QXqRQ8/+1D7Ckg3Y0VeisbfTiEplc4n7
	 jF1IouO/cMi1EZd6iRkFOHhXfZygxTRfNRnBltgu6nFvbVq5ARxDbhr0Dwfszyq4Ns
	 PZPxuUAU2Z35g==
Date: Tue, 27 Aug 2024 21:08:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/6] Split up refactoring of fh_verify()
Message-ID: <Zs54kI1KA407SDqQ@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>

On Tue, Aug 27, 2024 at 08:44:39PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> These six patches are meant to replace:
> 
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
> 
> I've removed the @nfs_vers parameter to __fh_verify(), and tried
> something a little different with the trace points. Please check
> my math.
> 
> These have been compile-tested, but no more than that. Interested in
> comments.

Reviewed quickly just now, nicely done!

I'll go over it very carefully now by replacing the 2 patches you
noted and updating the localio patches thaa follow.  I noticed some
typos and mentioning nfs_vers usage in a header despite you having
removed the need to pass it. So I'll fix up those nits along the way.

But I just wanted to immediately say: thanks!

> Chuck Lever (2):
>   NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
>   NFSD: Short-circuit fh_verify tracepoints for LOCALIO
> 
> NeilBrown (4):
>   NFSD: Handle @rqstp == NULL in check_nfsd_access()
>   NFSD: Refactor nfsd_setuser_and_check_port()
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
> 
>  fs/nfsd/export.c    |  29 ++++--
>  fs/nfsd/filecache.c |  61 +++++++++++--
>  fs/nfsd/filecache.h |   3 +
>  fs/nfsd/lockd.c     |   6 +-
>  fs/nfsd/nfsfh.c     | 210 ++++++++++++++++++++++++++------------------
>  fs/nfsd/nfsfh.h     |   5 ++
>  fs/nfsd/trace.h     |  18 ++--
>  7 files changed, 223 insertions(+), 109 deletions(-)
> 
> -- 
> 2.45.2
> 

