Return-Path: <linux-nfs+bounces-15969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24EBC2E25C
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0CD1896FBC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFD2C2374;
	Mon,  3 Nov 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaIO0Mmy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8351C8631
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205153; cv=none; b=q4iPoJH424+d9CDH/T31qz8vWk/NS4chCV5UrA4sIVEBuRJPsTdZ1cHUXo/GUOClMxrbWpnAicFCNFwGlyNO1xlD1JnI3LXisnaol7JyQ6u/k0HuwWEvETk+fl2Y/vaI8GazXSeefUCuP3t0FAt0Xpk+l87WJ28tZxZ+TFxSdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205153; c=relaxed/simple;
	bh=MR1MljRamxtutH8ruSps9QuaUDUmApA5Cj20Ruu4BAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouR5YHQKW4Mx3qj64Vl7vZ4x/LiS1Ns4NKSmXRNxpQgR3zPiD7MdIyOhoEBKpaEP1p+trtGxNMrQgGBpUk2MrD7+y/XdJwoIm83qBIhazX6fdeKmEVdUYvpa6AL/VQtnCO6/WWpAAvqgDdOCfR1vrC4jFG0AZAbJX5hx7iKEULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaIO0Mmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A10C113D0;
	Mon,  3 Nov 2025 21:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762205152;
	bh=MR1MljRamxtutH8ruSps9QuaUDUmApA5Cj20Ruu4BAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaIO0MmyI4D6SQ1N1AtkKNHUWwb4bExwPcst5eq0FqpohOj+uHFRZF8+nfuk2My7b
	 bcZiXkLuhQH6a1Rfg7vmIsmYcYBJwR3BMGxuQPt73+vMIbrLOrE9e14Jc5WWzH/SBo
	 o+c+pDVGhhMsKLDFyQ22+7yewTil6x0PvnKkPMvE22pgKh505BIFH7Izsp0tnbLu4y
	 +BvCP4KAjuHXjCjSWHP/YGG6K3hCwkYnhUqplFXgen/qbbVquAc6j5LWVvupKcyupG
	 2wmR1vAuNJLhrHaXLQ3EwPSe14nyUP/m6oA58gqA9JXQlo6yr+Vpm68KGui6lZfPUr
	 FqT1Un9TRtjwQ==
Date: Mon, 3 Nov 2025 16:25:51 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 12/12] NFSD: add
 Documentation/filesystems/nfs/nfsd-io-modes.rst
Message-ID: <aQkd34A5URFA6wM6@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-13-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-13-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:51AM -0500, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> This document details the NFSD IO modes that are configurable using
> NFSD's experimental debugfs interfaces:
> 
>   /sys/kernel/debug/nfsd/io_cache_read
>   /sys/kernel/debug/nfsd/io_cache_write
> 
> This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
> debugfs interfaces are replaced with per-export controls).
> 
> Future updates will provide more specific guidance and howto
> information to help others use and evaluate NFSD's IO modes:
> BUFFERED, DONTCACHE and DIRECT.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

Most of this document holds up, but the tracing section is stale:
nfsd_analyze_{read,write}_dio was removed.
nfsd_write_direct was added.

But I'll go over it all and backfill analysis like asked, will send an
incremental diff (probaby tomorrow).

Mike

