Return-Path: <linux-nfs+bounces-13630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BAB256DC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 00:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1078A7B5239
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E862FCBE6;
	Wed, 13 Aug 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXGkoLDS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25816302752
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124894; cv=none; b=icv9vgo0HEAA7oKg/+errHqUVZb3E587MVntJBTzXD8s/JmqiGpv3HWmtCLYQ996JeYtfC00r9w1/a6IBZiS+vOSqBdreOIFNa3OazHVdhqJAEh4dyqhxkNUXt/hzOoGdqyASCszszvPnPyvBk1m1rh+eUp64ttmv+C3BDDTrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124894; c=relaxed/simple;
	bh=AnpwWtP79bPgXzywq6IPbqv/YExZGaI8mHh7RHIcCwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYDZSQovG4TcUvGIFxDl62IlIHBVLZClexcRai8Wm7DXsEbiVnIahV5IlwYwglg/zcexP8vJ6Jn+WuA0jhetJCMXCDBQMlh42+M5y9a7qRoLVAlibS5I+6ayQekgrFWwvWbdLd+/Tz7YgdO6ssCc/cznA2QsnrL0A0VgDeVRueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXGkoLDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BD4C4CEEB;
	Wed, 13 Aug 2025 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755124894;
	bh=AnpwWtP79bPgXzywq6IPbqv/YExZGaI8mHh7RHIcCwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXGkoLDSXOD0pPI1wV2n6GMg/qhHsxIJNW4ZnD7TQi+UVzdAR+dptuOSUmm1MKO6z
	 Za4EITDB+2DcN1JW6GajWR4YXecQ/8v0bYeTLmQHkcZfIFAWLTxI9k+JFfbF78qBhm
	 o23+TTyJE0U2xq8k8kX2Xy4zPHGS+IKROl7MJmVs0wol4R2TOoteKbXd4Ej1L7LTTF
	 dg6rfQnbw5/RZop3vlz07OgaO1UnnvVHv2fxqfYqxWrRJUyeIe2UH+IY1qrqCzA4Al
	 t/JfcbOr92Zt1Re4kX0ju1ac2n2BPoG6VSgdmYAX3HE/TUOM1Xl5f0ZNEPsUC+8F4/
	 Q7BifF/ovIBiA==
Date: Wed, 13 Aug 2025 18:41:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v6 0/7] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
Message-ID: <aJ0UnNAA5J-SCtHt@kernel.org>
References: <20250809050257.27355-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809050257.27355-1-snitzer@kernel.org>

On Sat, Aug 09, 2025 at 01:02:50AM -0400, Mike Snitzer wrote:
> Hi,
> 
> Some workloads benefit from NFSD avoiding the page cache, particularly
> those with a working set that is significantly larger than available
> system memory.  This patchset introduces _optional_ support to
> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> support.  The NFSD default to use page cache is left unchanged.
> 
> The performance win associated with using NFSD DIRECT was previously
> summarized here:
> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> This picture offers a nice summary of performance gains:
> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> 
> This series builds on what has been staged in the nfsd-testing branch.
> 
> This code has proven to work well during my testing.  Any suggestions
> for further refinement are welcome.
> 
> Thanks,
> Mike
> 
> Changes since v5:
> - #define NFSD_READ_DIO_MIN_KB (32 << 10)
> - switch to using pre-increment from post-increment.
> - always get DIO alignment when opening regular nfsd_file (dropped
>   patch that only did if NFSD_IO_DIRECT).
> - fixed nfsd_io_cache_{read,write}_set to not set NFSD_IO_UNSPECIFIED
>   if returning -EINVAL due to unrecognized value. 
> - use a switch statement in nfsd_iter_read like nfsd_iter_write
> - Optimize nfsd_iter_read for default being buffered IO, like was done
>   for nfsd_iter_write in v5.

FYI, I've found that in general we _do_ need to verify DIO-alignment
more comprehensively. Which means I've needed to reinstate the use of
a modified iov_iter_is_aligned.

Otherwise the piece-wise checking that Keith suggested, by adding
checks to existing loops and such, results in the underlying
filesystem (XFS) returning -EINVAL due to alignment issues.

So I'm now focusing on correctness and will hopefully be posting v7 of
this patchset by the end of the week.

Mike

