Return-Path: <linux-nfs+bounces-14114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2AEB47873
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 03:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCAA3C11AF
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC23315D4A;
	Sun,  7 Sep 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK5FVccp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7102315D38
	for <linux-nfs@vger.kernel.org>; Sun,  7 Sep 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757207765; cv=none; b=dbu9zkaMXkMgZK42aQZQUztQJGtyYcWJ2Qi+UI94Tv9Ph2RTRdaOQ8/GE8mZ+NnysQP8agGvXvWMDK0X102mymKaLVKySXy0cZdBrQ4jc2vEc1UaZYsBGsOsPBRGl1bBivUksdTY20CAIJZ6AQvIgr5c35ExIEfAiH91VDUak5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757207765; c=relaxed/simple;
	bh=dyAm4KoVvKdNJiO3MlpZ0xwXmirRtvFldxYS8uul0oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy/f7wxIAQWE6Bnsl28rILE8k8muOiWAz65XT+3ZGdi/3exOXgz7NUB7OlHc0bUAWlIQRTDDNTYIrKlRBGiqKU3dKMoi0Dejgs7WRknOoDbAeC+dSKeWrLMCbKgN7JA58HMjDLfsJNObCm1jnk4xnQGs5MgFO6ASCZ4CsKk6acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK5FVccp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA9CC4CEE7;
	Sun,  7 Sep 2025 01:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757207765;
	bh=dyAm4KoVvKdNJiO3MlpZ0xwXmirRtvFldxYS8uul0oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK5FVccp2WbkAOigJxQLNYMeP1XFqIpMzC+k33pX/Kpc0MKQsNzOoOIfTtsLE7KHb
	 ybke8kVoTiaiSUNcao/a25E95zxhtdP2xGpMSrzlAtoxcz3YidoempJ0yE6Zy8gqIl
	 6zUnOfdbyMZCTwOFao9g1u0Fg7+856PHCpqghFIFDo1PkdS59cPPUkOlCObwH4MIxp
	 3HPMjZzP1ik7d8R/aqJ46ROkVYlpXifZ19n41HrAviEqkE5jZCsCzhhqG9+DFJmYEx
	 Ot7exXDJ6eEOxDtlIT4Xvjdg2mP9C1RpPqBWNJc+FLV+ktMRAqJzIxGgzL10gk+eDJ
	 jzhVuR5Oadttw==
Date: Sat, 6 Sep 2025 21:16:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Add io_cache_{read,write} controls to debugfs
Message-ID: <aLzc0_bdqliymMXr@kernel.org>
References: <20250906212511.9139-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906212511.9139-1-cel@kernel.org>

On Sat, Sep 06, 2025 at 05:25:11PM -0400, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> Add 'io_cache_read' to NFSD's debugfs interface so that any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=1).
> 
> io_cache_read may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
> 
> Add 'io_cache_write' to NFSD's debugfs interface so that any data
> written by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=1).
> 
> io_cache_write may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_write
> 
> The default value for both settings is NFSD_IO_BUFFERED, which is
> NFSD's existing behavior for both read and write. Changes to these
> settings take immediate effect for all exports and NFS versions.
> 
> Currently only xfs and ext4 implement RWF_DONTCACHE. For file
> systems that do not implement RWF_DONTCACHE, NFSD use only buffered
> I/O when the io_cache setting is NFSD_IO_DONTCACHE.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  9 +++++
>  fs/nfsd/vfs.c     | 21 +++++++++++
>  3 files changed, 123 insertions(+)
> 
> Changes since v1:
> - Corrected patch author
> - Break back to NFSD_IO_BUFFERED when exported file system does not
>   support RWF_DONTCACHE
> - Smoke tested NFSD_IO_DONTCACHE with NFSv3,v4.0,v4.1 on xfs and
>   tmpfs

Looks good, thanks.

Mike

