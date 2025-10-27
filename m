Return-Path: <linux-nfs+bounces-15687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E54C0EBD8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4447519C3641
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE9305960;
	Mon, 27 Oct 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1LDJdoT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A12C21CC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577100; cv=none; b=N7eAqTR01VcUVAARo65kLENeb7YQEOG5HRDiZIQkIK8shEjqlNO7bb2B9MKQpb7AlheO7qcls8n8z5xjlJfHlv+DgGWaeHHRavrxKFuKN2fCSK/1taxMQfZs3lV5JhycKDt3EVKtolQhpBBtUoNewAeyl+HlRNAzP3Xt+468EI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577100; c=relaxed/simple;
	bh=83kMcPmKzFogi/5DxHT4yRcoxobVz9HUXxbPRTYTjgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkA7nec4Axp7Y5HglE9N8ocj18WmWoDO82Nq/kS+Oa2SNjgGLvMpzWecPnfw3TYgNOijZdeHPRxDFF0vg40WtoF2KvW0kBDwux0RKT0ftK5ylRO5JNDd91knTpPF3HiwmO8QPgO5CBHmKueUCSvO59teOdBVpzZSRHHTawlZqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1LDJdoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36995C4CEF1;
	Mon, 27 Oct 2025 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577100;
	bh=83kMcPmKzFogi/5DxHT4yRcoxobVz9HUXxbPRTYTjgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1LDJdoTEsKfProSXueBSOonf4c5Ooy21uKUbAzxyTdB01ynPEgveQ9i+4xsFpUVz
	 cmsOlRNWZHAvJfjS5n1RLgRZqO0FlviW/7vOlF/QUcF8RZjlMQ5N9fVdOxlh9G+Ciy
	 hwMpFQVxi5PygiqD/0xdnN62+ysOMajrDlwhrtgRll+7JA7Fvyieri17VIR2Il/0tP
	 BNPmgaQgo5Y3leQm0rzADg+QpQgqrpfOVn7pD5qZT7zyKYyG+WzlHyh8j+qp57UP1V
	 JOCtsmMn+op/UTbpAeLrEZ/tXVuhchwa1YDEF1NE1q+Ef9xVwyUYybZNM14qYssHVV
	 JmMzvD+u9FO6w==
Date: Mon, 27 Oct 2025 10:58:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP-Ii3DgzEaI5Bw4@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org>
 <aP-CW5_egXzHS1jz@kernel.org>
 <aP-DYgcrcd2zSzrI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-DYgcrcd2zSzrI@infradead.org>

On Mon, Oct 27, 2025 at 07:36:18AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 10:31:55AM -0400, Mike Snitzer wrote:
> > > that.  High-end enough device won't have one, but a lot of devices that
> > > people NFS-export do.  For pure overwrites the file system could
> > > optimize this way by using the FUA flag, and at least the iomap direct
> > > I/O code does implementation that optimization for that particular case.
> > 
> > NFSD_IO_DIRECT isn't meant to be uniformly better for all types of
> > storage.  Any storage that has a volatile write cache is probably best
> > served by existing NFSD default (NFSD_IO_BUFFERED).
> 
> That's a very odd claim.  Also what does it have to do with the rest of
> the discussion here?

What's an odd claim?  That shitty storage shouldn't be the bad apple
that spoils the bunch?  You seem to be advocating for requiring
additional NFSD resources as part of the NFSD_IO_DIRECT
implementation.

But we could make NFSD's behavior tuneable such that it can signal to
NFS client NFS_FILE_SYNC or not.

The goal is to walk before expanding to running with other
permutations of how to tune NFSD's IO modes.

> > The client doesn't control if/when NFSD would make use of O_DIRECT
> > (other than if it sends misaligned IO and NFSD must do what it can to
> > ensure it safely hits stable storage).
> 
> Sure.
> 
> > In addition, the use of NFSD_IO_DIRECT is intended to allow for
> > systems large _and_ small to get the advantage of lower memory
> > utilization.  Buffered IO is one extreme, but even using a model where
> > NFSD were to not impose NFS_FILE_SYNC would create a situation where
> > more memory needed batch IO and then wait for client to send COMMIT.
> 
> Why?

Because NFSD will then need to hold the IO until the COMMIT operation.
That requires extra NFSD resurces right?

> > The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
> > really well on modern NVMe servers.
> 
> NVMe does not implement a concept called servers.

But you're aware that servers have NVMe devices in them.. that's all I
meant.  All of these NFSD_IO_DIRECT changes have been developed and
tested in modern servers with 8 NVMe, see:
https://www.youtube.com/watch?v=tpPFDu9Nuuw

(NOTE: results covered in this session did _not_ have the benefit
of NFSD responding to client with NFS_FILE_SYNC to avoid COMMIT, the
ability to do so was discussed at Bakeathon and was acted on with
these latest NFSD Direct patchsets).

