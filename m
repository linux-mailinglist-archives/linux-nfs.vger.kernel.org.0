Return-Path: <linux-nfs+bounces-14785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD40BAA329
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA987A2B75
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD90214813;
	Mon, 29 Sep 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcbO9B9J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25872614
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167594; cv=none; b=YJtzrfYZc0QhGRceBhLaaQU9+2v9xxhkQRNM7No95DzWnkMetU/YWwuHmYxOSQ4iA7ptDnIaqyM4DL+7e7YUm39eTIRD11ngC2RrKr0rJTWkKWOa7na2OLUwkVaPAQTfd9WmrRdiGBx51A/C7oxbEOpsbd6cE6HEYDaIkZcLQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167594; c=relaxed/simple;
	bh=fB36ur4EUQyKyEoy/I7+nLZR4Nvt0HY4/9JY0Pt8SVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjy/NsqUvGxWM8oxIJAWwxV5SGgU3chxVks4frA6NazAr495WJJVOOxiNKo9bngCu0uxo9mfiGDVA4OI9Re+Of4EZA6S+1rgtXtBFuo1CJLgrjYJ3X5HOq7HwQqTvEpfa4PbUkFWEn0yfnwSEIQTYQvMSWLbwuRKVTA8LL34ITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcbO9B9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F8CC16AAE;
	Mon, 29 Sep 2025 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167594;
	bh=fB36ur4EUQyKyEoy/I7+nLZR4Nvt0HY4/9JY0Pt8SVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcbO9B9JiXFAPY3xwKY9H9EbzWxGGTmpGRWAGMoxIbNewIam9CWRoxT2SHukPXFGT
	 gPi9bJljpkydhcT8udPWJaQlr43hFSnYTcgKMR5TIJQxT3qlSRco4BiXBWRVfAAhif
	 78Eo/zZg/nFRxbwLjdO2tpX9Vg7tmWSsbAqidneXcShZSzO9AF+TuWTmbprviyRKw9
	 fUypsdEPfQt9CiCqcDdOHky3crD4l3AonErwrz4sDrr/z4CL1GkvKQ6MoruV9vOf37
	 iq5SBbg9rtEg3JYJxfFTSeIMATs7o278kTq7tWFQsyBE5c/cDm3VrLZ7US7Eza6YkU
	 9UTjk31YIIWnw==
Date: Mon, 29 Sep 2025 13:39:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 6/6] NFSD: Ignore vfs_getattr() failure in
 nfsd_file_get_dio_attrs()
Message-ID: <aNrEaBYk6KoqTZky@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-7-cel@kernel.org>

On Mon, Sep 29, 2025 at 11:56:46AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> A vfs_getattr() failure is rare but not totally impossible.
> 
> There's no recovery logic in that case; nfsd_do_file_acquire()'s
> caller will fail but the wonky nfsd_file is left in the file cache.
> 
> It doesn't seem necessary for nfsd_file_do_acquire() to fail
> outright if it successfully opened the file but some problem
> prevented the collection of the dio alignment parameters.
> 
> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

