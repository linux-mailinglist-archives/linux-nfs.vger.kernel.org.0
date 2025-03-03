Return-Path: <linux-nfs+bounces-10450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52112A4DABD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 11:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FF3163DE5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC61FCD11;
	Tue,  4 Mar 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeJd982T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10A1EF0BC;
	Tue,  4 Mar 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084422; cv=none; b=HnxA3rZfZlr8sSHzZs30W12YgXskBqmeX434D3aHdBfQWMseZL2s4zIXEPTCCcVF7JzyLj9DXou0RSeYhv2K1HA7lFCLYSPCgtqj1vMMl/Y2mjy7Xx1Liv8oPW63B7UazL5zzdfDHB96mt1v4ujdJ7NeN1UouTrDxbjOUwhXIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084422; c=relaxed/simple;
	bh=YgbZcILngMRztLMEacwU5Lqg2SqhQWsX2wJDj6udQ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl1F02MysZRMGpBeH+6ApEczFfw8DeQ9lPbc5YR5s1Jm1rhOITk7eqzHhzuVph/5TWO2rNZjW1bdiJ6VzD5sFJbcf8Flpo73LIURGUkert+Nno8DLUBqGJwjaVdGMMC3aC6S6JznfaXgTaZCKQErqLP2zi56PIelfXsBZUx2ZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeJd982T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07348C4CEE5;
	Tue,  4 Mar 2025 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084421;
	bh=YgbZcILngMRztLMEacwU5Lqg2SqhQWsX2wJDj6udQ2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeJd982TqUnyqdTyfF5KwNTpeurNXtL6jiGOcgfBRWhHkVgx6NfqKGojIgLEm5Ptf
	 5d3d3YiLD6KxHkbnzrHgkpBBt7dXqj7mTmwVA8jzWXl2nV1o2dKxGUVkrgUXwSwops
	 sZOecOD8Kgq/GBSCPOjOoPdcmFWtFpG+vS9755QPTmsKi7iCY3eGEBv+wz4bGVodpL
	 GuuqLGf7fLA7nuEHHyzeqjg2fF2TiycnJcUQ37h1p78NC5F/Q57tvqiU4h3BR7Xxf4
	 +nwzJyXmBzBbwGw9KU9BBTDSAw+7nWxXHSB6oMvzBOF8bFXoUiFGEgtTuCAkYmtXD0
	 IEWy7g9stPmLg==
Date: Mon, 3 Mar 2025 14:52:06 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/6] Fixes multiple sysctl bound checks
Message-ID: <fdmspbwoxc7zgabdg4fnbd5tkupx3lasne2ydldvkztwh3iz2y@mnqbpm2w4ibl>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>

On Mon, Feb 24, 2025 at 10:58:15AM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Hi,
> 
> This patchset adds some bound checks to sysctls to avoid negative
> value writes.
> 
> The patched sysctls were storing the result of the proc_dointvec
> proc_handler into an unsigned int data. proc_dointvec being able to
> parse negative value, and it return value being a signed int, this could
> lead to undefined behaviors.
> This has led to kernel crash in the past as described in commit
> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
This patch is slightly different then what you are trying to do here.
Notice that the issue in 3b3376f222e3 ("sysctl.c: fix underflow value
setting risk in vm_table") was that the extra1 value was getting ignored
because it was calling proc_dointvec; replacing it with
proc_dointvec_minmax properly forwards the extra1 value.
What your series is trying to do is to avoid a assignment of a negative
value to a unsigned int.
> 
> They are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
> The proc_handlers have thus been updated to proc_dointvec_minmax.
> 
> This patchset has been written over sysctl-testing branch [1].
> See [2] for similar sysctl fixes currently in review.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-testing
> [2]: https://lore.kernel.org/all/20250115132211.25400-1-nicolas.bouchinet@clip-os.org/
> 
> Best regards,
> 
> Nicolas

In general, I would like for these patches to go into mainline through
their individual subsystem as they would know more about what type fits
best for the ctl_table->data variable. With that said, I'll push the
leftovers through sysctl if there are no takers.

Thx for the series
> 
> ---
> 
> Changes since v1:
> https://lore.kernel.org/all/20250127142014.37834-1-nicolas.bouchinet@clip-os.org/
> 
> * Detached patches 1/9, 2/9 [3] and 3/9 [4]
> * Adapted the cover-letter message to match the reduced patchset
> 
> [3]: https://lore.kernel.org/all/20250129170633.88574-1-nicolas.bouchinet@clip-os.org/
> [4]: https://lore.kernel.org/all/20250128103821.29745-1-nicolas.bouchinet@clip-os.org/
> 
> ---
> 
> Nicolas Bouchinet (6):
>   sysctl: Fixes idmap_cache_timeout bounds
>   sysctl: Fixes nsm_local_state bounds
>   sysctl/coda: Fixes timeout bounds
>   sysctl: Fixes scsi_logging_level bounds
>   sysctl/infiniband: Fixes infiniband sysctl bounds
>   sysctl: Fixes max-user-freq bounds
> 
>  drivers/char/hpet.c            | 4 +++-
>  drivers/infiniband/core/iwcm.c | 4 +++-
>  drivers/infiniband/core/ucma.c | 4 +++-
>  drivers/scsi/scsi_sysctl.c     | 4 +++-
>  fs/coda/sysctl.c               | 4 +++-
>  fs/lockd/svc.c                 | 4 +++-
>  fs/nfs/nfs4sysctl.c            | 4 +++-
>  7 files changed, 21 insertions(+), 7 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 

Joel Granados

