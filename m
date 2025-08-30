Return-Path: <linux-nfs+bounces-13960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF10B3CEDD
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 20:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200097C0897
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8C2D9ED5;
	Sat, 30 Aug 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGBICztY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841191DE8AE
	for <linux-nfs@vger.kernel.org>; Sat, 30 Aug 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579983; cv=none; b=f4wr7Z1nwSP3+dsqoj6gUbW5LoQ+xWOU2igzYX+9u6nTxhzk/bdMh8kA/2qYTiSM7vRiq30Og2CdTuiwWoz9brcD8HFXmp7o90qnqvZUoVgaTdWaFoNf7SE1Daj+UnkGGC34UHBRoLW76iawFlEiy8l0zOnc9/FuoRXEHErZKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579983; c=relaxed/simple;
	bh=IvQY722kEUSjgUIrvslxkOnXffDG52zgcexjvjT9RuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGZnx4b2pMBp2azCQzc/S4uH5q44IaXPGmEFOKKRr3a4rmIenFACyRKk36+uS6VfOtfVFqGoMxHYm/3nVF5/5D7zSRDwvTDbPcbYpLKLy7YInVa+TVh+DzXVNuxUcC1wDaQf7qwsTBQP8VO7awIltrRZmLIKLmBxq2JLwBj3Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGBICztY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DDEC4CEEB;
	Sat, 30 Aug 2025 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756579983;
	bh=IvQY722kEUSjgUIrvslxkOnXffDG52zgcexjvjT9RuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGBICztYVYRFV9V4Fhfw3xBmGQ49KZq5VyFj+6DFCDs+GVKo0nzFYLiUT91NecEVG
	 Fvo5n4RtE6IfME5aE8Ku3TlLy+YSfNk2HllvKbEbCHhZ9An9kdMv/MMMjSqO55h77Z
	 PyRXK2fCOyevFxutPqpsAvsg+dBrBHjVR/zJMHkRJRgEFOZr+QBLmDmWhid0ju0te6
	 FwablSm9YFFjZbgkln6D/83plJJojKFbCxA1itRZOl/v2ztoTHN9y75E3/J3LMTyQR
	 KzmBOu9D4aEuPAnlE+vhzFFiO3RUYemlJrwGbSmsy12eiaPzinLZ6R9aBLXgOv8kVg
	 grmpKVtjVzyWg==
Date: Sat, 30 Aug 2025 14:53:01 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] some progress on rpcrdma bug [was: Re: [PATCH v8
 5/7] NFSD: issue READs using O_DIRECT even if IO is misaligned]
Message-ID: <aLNIjQHRg1Yf0Vxb@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830173852.26953-1-snitzer@kernel.org>

On Sat, Aug 30, 2025 at 01:38:50PM -0400, Mike Snitzer wrote:
> Hi Chuck,
> 
> Hopeful these 2 patches more clearly demonstrate what I'm finding
> needed when using RDMA with my NFSD misaligned DIO READ patch.
> 
> These patches build ontop of my v8 patchset. I've included quite a lot
> of context for the data mismatch seen by the NFS client, etc in the
> patch headers.
> 
> If I'm understanding you correctly, next step is to look closer at the
> rpcrdma code that would skip the throwaway front-pad page from being
> mapped to the start of the RDMA READ payload returned to the NFS
> client?
> 
> Such important adjustment code would need to know that the rq_bvec[]
> that reflects the READ payload doesn't include a bvec that points to
> the first page of rqstp->rq_pages (pointed to by rqstp->rq_next_page
> on entry to nfsd_iter_read) -- so it must skip past that memory in
> the READ payload's RDMA memory returned to NFS client?
> 
> Thanks,
> Mike
> 
> Mike Snitzer (2):
>   NFSD: fix misaligned DIO READ to not use a start_extra_page, exposes rpcrdma bug?
>   NFSD: use /end/ of rq_pages for front_pad page, simpler workaround for rpcrdma bug
> 
>  fs/nfsd/vfs.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> -- 
> 2.44.0
> 

Another important detail to mention, I've been working ontop of a
6.12.24 stable baseline that I've backported all NFS and NFSD changes
through 6.17-rc1 + (slightly stale) nfsd-testing to, please see:

https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing-snitm.18-testing

Not sure if rebasing to the latest nfsd-testing would show this
issue... I'm thinking yes, but cannot say for sure.  Needing the
ability to test/develop Hammerspace and pNFS stuff has prevented me
from simply rebasing.  But it should be doable without too much
effort.

Mike

