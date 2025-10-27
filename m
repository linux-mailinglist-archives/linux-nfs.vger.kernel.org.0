Return-Path: <linux-nfs+bounces-15690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BFC0EF3D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C002500178
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D619D092;
	Mon, 27 Oct 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWb3JMS9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E0309F13
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578394; cv=none; b=s7A530pdoHM5Neobyv5I7VV5mLWj4blx53IqqHaKKf3rv1u5UIAFKD1b/YjfDq0Zh9TbbRVI7qxXEozIi3ZOI4nrE+dcQEetByW/Z7Q2P2NDwPXGc3a1LzVi6t9GL//emr0GCRfl0189S0SwfiV0XF2Ewn/UszCBKtnTkaQoDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578394; c=relaxed/simple;
	bh=LVbFEnXvaAEdnO6nPCdiGV/PQAdS5u8wgflWYdzpv78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay+ry++1csq0s8FkXQiaZn5fORj1F0rRr+SfPp8tBG2cG/gj5lftsAaI2jEBRyPHVq4jJTbAlXCuIlFWjRn4upCnUNqXWsYF4ujJGjn4XoV9ekBZk39ZQeg8lLrkDWv+n0yibnEuYvxbeeDE3IoSHAP2LklLmiltv2F4Bsp32sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWb3JMS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165EDC4CEF1;
	Mon, 27 Oct 2025 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761578393;
	bh=LVbFEnXvaAEdnO6nPCdiGV/PQAdS5u8wgflWYdzpv78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWb3JMS9Nq3HoT8t99B8lcCwWO1SIwv4Ad5EqohBhM+rlvCQLl6+MhyhU14lTRXqH
	 zTSaZ4TifY8t2p2mAS+WbIkaHzP25CUd9KUDW7T4as/5gQfhErb7pyHR5VMcy9DJFp
	 6mHjoZBWbbeIZVbh+gpHBsb60st60qbwjKK6imTIeROkSTorXc4Qu7OYMWA9hh94sX
	 ABsYAVRoLSKqoFu2wDtgjvZ874mPqilQ3ynHfArhdkiqsnBHsMzuvKIxZ1+qd4dJAC
	 b2Cie7MnJTvT3bAZiA0aorNPcJRwgSEfBUcTwXzomVcZ+u/gdm7kALS1fb3bs6hTpL
	 zZC+1h+9IY4jw==
Date: Mon, 27 Oct 2025 11:19:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP-NmNDnpiVK59rT@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org>
 <aP-CW5_egXzHS1jz@kernel.org>
 <aP-DYgcrcd2zSzrI@infradead.org>
 <aP-Ii3DgzEaI5Bw4@kernel.org>
 <7093445f-604a-4bfd-9104-b9f70138ed07@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7093445f-604a-4bfd-9104-b9f70138ed07@kernel.org>

On Mon, Oct 27, 2025 at 11:04:47AM -0400, Chuck Lever wrote:
> On 10/27/25 10:58 AM, Mike Snitzer wrote:
> >>> The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
> >>> really well on modern NVMe servers.
> >> NVMe does not implement a concept called servers.
> > But you're aware that servers have NVMe devices in them.. that's all I
> > meant.  All of these NFSD_IO_DIRECT changes have been developed and
> > tested in modern servers with 8 NVMe, see:
> > https://www.youtube.com/watch?v=tpPFDu9Nuuw
> > 
> > (NOTE: results covered in this session did _not_ have the benefit
> > of NFSD responding to client with NFS_FILE_SYNC to avoid COMMIT, the
> > ability to do so was discussed at Bakeathon and was acted on with
> > these latest NFSD Direct patchsets).
> 
> This is why I suspect that leaving direct writes as UNSTABLE, rather
> than promoting them to FILE_SYNC, is probably not going to make much
> difference to Jonathan's benchmark results. That's just a guess though.
> 
> IOW the memory costs of sticking with UNSTABLE + COMMIT have already
> been demonstrated, and it's low.
> 
> The v8 of this series will go back to that idea, and if you want, you
> can benchmark it again. If it regresses, we can stick with FILE_SYNC.
> It's just ones and zeroes, as they say.

OK.

