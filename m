Return-Path: <linux-nfs+bounces-6290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0996E65B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 01:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049871C236C2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4411A727D;
	Thu,  5 Sep 2024 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1jajGzU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D254F87;
	Thu,  5 Sep 2024 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579343; cv=none; b=IPlnunm+2A24eGcsu5zF+a/6fKftA7p0e5XKn3UzFauj2Lp2VY0yRfX/HWesBuwRz+Meu1lHrYvJJJq3isQB/dY4p44MgDx8JeemQn+jAVJpSxAEfbroj2eCpek/OF2GseDNh1ykytcMnlQHWfTtQQijchhK6jTzt8MwJwuiujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579343; c=relaxed/simple;
	bh=kdJBJm07vSWsMujAWNUkpnWYrq/ajC+MWp90UGPtRbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhR4+1na9d3O6CmLLwVwyXG/8tMDKLAgXP1pr46bwkB9XDLcgPCdXIMlu2Onl1eGnc8CiRUMwzzvXPucu15nIffBVyL2rNIC5DnyDuHCDZXw4HeaC8rh5B7pQ8Jkye91bcwRO1IJxRk0jp1J5RHRKSPv1KE8Lkg/T90JSkTUcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1jajGzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FA6C4CEC3;
	Thu,  5 Sep 2024 23:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725579343;
	bh=kdJBJm07vSWsMujAWNUkpnWYrq/ajC+MWp90UGPtRbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1jajGzUrXBq4LkcyHu9Gawoocw7falpk/v+3iLXUWwe0zfR6FB9ddMFQ5lHxbzVF
	 NybCr2auPZbMJ6AjlNFbPuH4I3ustsyovf4+UZ3UAG9X9IDlYgdsDMfjYLcIeDTikx
	 UVGePWLQ/7mJo7Yn8EVL6x0o7GEXLQ5/weIy4GYj4pLoAZEw9J0Bqc+mFKuKq2lAl2
	 gwN3KPjfat0dhVFHYjpyMusXWkyxxwEsXjJG7cdCuC8hGG4lJZpSoJZHw6v8FQpPfQ
	 uKgv07v5u1309uNVSwj6OJLDH0hBmcQt+VeofpTBj0l4uENtngmrt7fwBpheI3NQ5d
	 17hw0avXtMsmQ==
Date: Thu, 5 Sep 2024 19:35:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sami Tolvanen <samitolvanen@google.com>, linux-nfs@vger.kernel.org
Subject: sharing rescuer threads when WQ_MEM_RECLAIM needed? [was: Re: dm
 verity: don't use WQ_MEM_RECLAIM]
Message-ID: <ZtpATbuopBFAzl89@kernel.org>
References: <20240904040444.56070-1-ebiggers@kernel.org>
 <086a76c4-98da-d9d1-9f2f-6249c3d55fe9@redhat.com>
 <20240905223555.GA1512@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905223555.GA1512@sol.localdomain>

On Thu, Sep 05, 2024 at 03:35:55PM -0700, Eric Biggers wrote:
> On Thu, Sep 05, 2024 at 08:21:46PM +0200, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 3 Sep 2024, Eric Biggers wrote:
> > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Since dm-verity doesn't support writes, the kernel's memory reclaim code
> > > will never wait on dm-verity work.  That makes the use of WQ_MEM_RECLAIM
> > > in dm-verity unnecessary.  WQ_MEM_RECLAIM has been present from the
> > > beginning of dm-verity, but I could not find a justification for it;
> > > I suspect it was just copied from dm-crypt which does support writes.
> > > 
> > > Therefore, remove WQ_MEM_RECLAIM from dm-verity.  This eliminates the
> > > creation of an unnecessary rescuer thread per dm-verity device.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Hmm. I can think about a case where you have read-only dm-verity device, 
> > on the top of that you have dm-snapshot device and on the top of that you 
> > have a writable filesystem.
> > 
> > When the filesystem needs to write data, it submits some write bios. When 
> > dm-snapshot receives these write bios, it will read from the dm-verity 
> > device and write to the snapshot's exception store device. So, dm-verity 
> > needs WQ_MEM_RECLAIM in this case.
> > 
> > Mikulas
> > 
> 
> Yes, unfortunately that sounds correct.
> 
> This means that any workqueue involved in fulfilling block device I/O,
> regardless of whether that I/O is read or write, has to use WQ_MEM_RECLAIM.
> 
> I wonder if there's any way to safely share the rescuer threads.

Oh, I like that idea, yes please! (would be surprised if it exists,
but I love being surprised!).  Like Mikulas pointed out, we have had
to deal with fundamental deadlocks due to resource sharing in DM.
Hence the need for guaranteed forward progress that only
WQ_MEM_RECLAIM can provide.

All said, I'd like the same for NFS LOCALIO, we unfortunately have to
enable WQ_MEM_RECLAIM for LOCALIO writes:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=85cdb98067c1c784c2744a6624608efea2b561e7

But in general LOCALIO's write path is a prime candidate for further
optimization -- I look forward to continue that line of development
once LOCALIO lands upstream.

Mike

