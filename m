Return-Path: <linux-nfs+bounces-16075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C079C37288
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D61CE4EC4CB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B92F28FC;
	Wed,  5 Nov 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plg4+DE+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EB1F3B85
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364015; cv=none; b=asagrYiJ01HaHzqje/XaKXOScuJrxVoUmtxN0QghtsyjQTEN5dmaKT28Gqc5i6iy+blb37aHZf8kJ5NfkNmF4WjxpY73j2T4xn0lU5U3WMHs5dLAN+OyXkpOBuAT1R5tPIfKGtb/qvaZV+aC8Ms8g6HPjJAMj9HBaT0UEUDwa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364015; c=relaxed/simple;
	bh=C5mpsNBA4zLNDTaDii4xKX+WzCeKVA2cw65BS5jhMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q32o+wTcZU5Gl6QBSOGPYtr9nhYqjpGfm9a71mivLJEs470vxI9Y8oZF1ic2aNWrfR7OEGSh6+vIC3R2HFqr9eIwgzf8elkKxEt4yc5i3UWR+vxJUvExpy6lIxTg1tEaJiPs3w3qRGK0g7MvKASEHLCVYTgOiDPjt47RcNTnxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plg4+DE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9C1C4CEF8;
	Wed,  5 Nov 2025 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364014;
	bh=C5mpsNBA4zLNDTaDii4xKX+WzCeKVA2cw65BS5jhMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Plg4+DE+m5S1GxrfD8cdhPGx75+JFzJDnPBBgjUT8k/OX9wop/iPCQk2kAS1MBgsb
	 J1JbYmz11IMX8dmVeSrsSB+D3sNvU643ZsFw4ipQkFHw+SMsNa4Vr8M23njZ3vGrn2
	 2hLEN2Efuew7fDA46isHee3c6mqCJA3E/vkCX7fDTJ5LG+ANOFH56qspoZO700tsi+
	 mM8KRkNHjinB9xGBmVN4eS5plX8p+RegP+I3TRDetU5hnG2LAJvhYPGtGjbLxU4g+y
	 FAwswSg9czqEUb9iaar91N/2FWxCt2e1Q7zKU1kx9Qx5zpUzEF/DqF+6lVj2sh8PZr
	 6Q985bz3GBdrg==
Date: Wed, 5 Nov 2025 12:33:33 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] NFSD: avoid DONTCACHE for misaligned ends of
 misaligned DIO WRITE
Message-ID: <aQuKbSbnKlHutcsB@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
 <aQrsWnHK1ny3Md9g@kernel.org>
 <d2139ff7-58d7-4b49-8ebd-b30d6ba4c9e8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2139ff7-58d7-4b49-8ebd-b30d6ba4c9e8@oracle.com>

On Wed, Nov 05, 2025 at 09:58:28AM -0500, Chuck Lever wrote:
> On 11/5/25 1:19 AM, Mike Snitzer wrote:
> > NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
> > performance if it uses buffered IO (without DONTCACHE) for the
> > misaligned end segment(s) and O_DIRECT for the aligned middle
> > segment's IO.
> > 
> > On one capable testbed, this commit improved streaming 47008 byte
> > write performance from 0.3433 GB/s to 1.26 GB/s.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > v3: drop unrelated change to avoid DONTCACHE if READ is less than 32K
> 
> The direct code path now handles the "no support for direct I/O" case
> in exactly one spot: the "no_dio" label in nfsd_write_dio_iters_init().
> 
> So it seems to me that it would be slightly friendlier overall to not
> set DONTCACHE in nfsd_direct_write(), but then set it just after the
> "no_dio" label. The nf pointer is available in the nfsd_write_dio_args
> structure.

Sure, will post a v4 of this series.

