Return-Path: <linux-nfs+bounces-15678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7342C0E3D1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5DF04FF266
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996B2DE1E6;
	Mon, 27 Oct 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRVyQbrH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65559231A23
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573316; cv=none; b=VGnRX00sp4WSDUaPQSYtCIwf/OIBBHsZs1Mo4fiABX8lyJsrCcXSab6ChaZ8ByX+dw751BGy07iiLVskeQtuseffJwF0lJp6ekNdDMGTDEh3qqgWgyhppUOYe27Fln1aQCG7tS/JuMxVpga1hq2k+9hqD7oEdceExkPCfll+UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573316; c=relaxed/simple;
	bh=3oN20YFKF3Dd9pQGT13P4lnNhqwhdNLNtXpCH4DswK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D63gPQkX/x4XFeCEoxo89ZQxAO4ZmPEZ+3P5weOWEoxve/r5yLZQSdgl7ATBp3FG50/vuWBuWcJYZE4oY6jNksOGcct0QKzg+QkmRXCPLMFay771DQbmVjDjqezsJ6EQSR3FoHZ10BA8R77B3O1AWRm5gQaYEv8SWb8lF29gNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRVyQbrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B77FC4CEFF;
	Mon, 27 Oct 2025 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573316;
	bh=3oN20YFKF3Dd9pQGT13P4lnNhqwhdNLNtXpCH4DswK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRVyQbrHvafVUlJqE88xWbzeJsvKTAsEJaCXvn8h5ZWc8EsKxDB0dTpuazHXDr8Jr
	 LBuOU8P8YJms5VVRXG4+a27XdhORcd9GSUpK+QZtMs8utJU+CxxjlDI0iqRO/5ib8m
	 HndUxRgWSxYW6Y/W1ZG+xh6kyWNgKhP2FPdpmZAkk4KI1C1RbZQRmIq5EoGiAcmQd8
	 Gf1E0r32ZDPIZvF/qF42tjMZHwzjjOg/+K0Cu9k4vVJW6q6o0eUfoifW2kZA3QonTu
	 ElVz8W35UyYsdyLxh9zugI3DOhFx1JfqgjT4iYTQUW1kmgaUmdZD/UuFPqIAG26ojD
	 KqUCl7Gf9kKqA==
Date: Mon, 27 Oct 2025 09:55:14 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb
 IO associated with NFS pgio header
Message-ID: <aP95wjsM2LndIY1X@kernel.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
 <20251027130833.96571-3-snitzer@kernel.org>
 <aP9xVCiY5mYowEoN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP9xVCiY5mYowEoN@infradead.org>

On Mon, Oct 27, 2025 at 06:19:16AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 09:08:32AM -0400, Mike Snitzer wrote:
> > Improve completion handling of as many as 3 IOs associated with each
> > misaligned DIO by using a atomic_t to track completion of each IO.
> > 
> > Update nfs_local_pgio_done() to use precise atomic_t accounting for
> > remaining iov_iter (up to 3) associated with each iocb, so that each
> > NFS LOCALIO pgio header is only released after all IOs have completed.
> > But also allow early return if/when a short read or write occurs.
> 
> Maybe just split the pgio instead?  That's what a lot of the pnfs code
> does. 

I already tried that, in terms of frontend fs/nfs/direct.c and then
supporting fs/nfs/pagelist.c changes; ended up being pretty nasty (and
overdone because in general the NFS client doesn't need to do this
extra work if its not using LOCALIO).

We only need this misaligned DIO splitting for LOCALIO's benefit
because in general the NFS client is perfectly happy handling
misaligned DIO (and sending it out over the wire).

