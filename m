Return-Path: <linux-nfs+bounces-11194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC6A94849
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Apr 2025 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B56170984
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Apr 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C622AD14;
	Sun, 20 Apr 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKJMsXvL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7081B7F4
	for <linux-nfs@vger.kernel.org>; Sun, 20 Apr 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745165544; cv=none; b=W+5cvUtZP+VY1LbkvK38HUhjvacvncrwYp5awRCxwjOBUvAQCHypz6QicjcmKHCb6jxLVw0W4r2aARDkenRqxpUIw9LQvbzitz9mx1gxdJ523xFu+mflAjH5j1y7PnDU7/GKc+HJXp3FN/5pHGbc5jk+uYizZEAE1T+CS56j4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745165544; c=relaxed/simple;
	bh=PhLN9WPy26R4/HU6CpnNBB5ApwGq05HaIDJAmJbOlyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW2LihWCNW2MjgXvrXR7y7vhQrFHIpnlzU4AOu8A/9hpBwsTebNw7q3h8lFcq1wJCUvHfvqEVvIvpIjyhIKq/55gEDDNkZlUZq47KAhBf53Kl0FWsaZWUnzW57+gP8FmSFN+VYfAW5vmcwYgkhEKGEDaa/vm4msCXk0mOuG1QOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKJMsXvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3A3C4CEE2;
	Sun, 20 Apr 2025 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745165543;
	bh=PhLN9WPy26R4/HU6CpnNBB5ApwGq05HaIDJAmJbOlyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKJMsXvLoOGPlHBr/EkXukwxvoqLd8NCKkw+kZjDYkvCnGNleDuX2H+ydoxAGTGen
	 8Ni/A/faxTqb0Byn8ALJRp2PiOMezi6tp26PcGjVM9M6KTc9iU/8gNGNNVHI2myY0+
	 LgZ5W+kr1RCXq5BwZa010U7NbaKDgDttQvTqqmUP5jf7QYkNHSHke9QSI42hizLMwQ
	 36AiWzUd3+FPCMYq1j7nyTnETNN07Oeqr3w2kIJlNz7vSGPr/jXXiOXLCzf5NoxqGq
	 2ESDDbN0Zc+DWJvrvtgkitWZ0Pr1MTJII4ar5jrKJ0kYRhtkIvHTdkov2kLylxzEZh
	 C9o8kVWS2z1tg==
Date: Sun, 20 Apr 2025 12:12:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <aAUc5m5_dv5xllqm@kernel.org>
References: <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
 <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
 <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>
 <aALFdnEGTxF03uQd@kernel.org>
 <a3ff6c97-3ea5-4baf-aeaa-77e29e1d7216@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3ff6c97-3ea5-4baf-aeaa-77e29e1d7216@oracle.com>

On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> >>> +CC: Neil Brown
> >>> +CC: Olga Kornievskaia
> >>> +CC: Dai Ngo
> >>> +CC: Tom Talpey
> >>> +CC: Trond Myklebust
> >>> +CC: Anna Schumaker
> >>>
> >>> (just to make sure that anyone listed in
> >>>
> >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> >>>
> >>> get copied).
> >>>
> >>> Here is the link to the full thread:
> >>>
> >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> >>>
> >>>
> >>> On 10/04/2025 at 11:09, Mike Snitzer:
> >>>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
> >>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> >>>> what should just be an opaque pointer (by using typeof(*ptr)).
> >>>>
> >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> >>>> Cc: stable@vger.kernel.org
> >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> >>>> Tested-by: Pali Rohár <pali@kernel.org>
> >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>>
> >>> Hi everyone,
> >>>
> >>> The build has been broken for several weeks already. Does anyone have
> >>> intention to pick-up this patch?
> >>>
> >>> (please ignore if someone already picked it up and if it is already on
> >>> its way to Linus's tree).
> >>
> >> I assumed that, like all LOCALIO-related changes, this fix would go
> >> in through the NFS client tree. Let me know if it needs to go via NFSD.
> > 
> > Since we haven't heard from Trond or Anna about it, I think you'd be
> > perfectly fine to pick it up.  It is a compiler fixup associated with
> > nfd_file being kept opaque to the client -- but given it is "struct
> > nfsd_file" that gives you full license to grab it (IMO).
> > 
> > I'm also unaware of any conflicting changes in the NFS client tree.
> 
> Hi Mike -
> 
> I just looked at this one again. The patch's diffstat is:
> 
>  fs/nfs/localio.c           | 8 ++++++++
>  fs/nfs_common/nfslocalio.c | 8 ++++++++
> 
> Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> definitely a client file. I'm still happy to pick it up, but technically
> I would need an Acked-by: from one of the NFS client maintainers.
> 
> My impression is that Trond is managing the NFS client pulls for v6.15.

Sure, that's my understanding too.  Feel free to offer your Acked-by
(for fs/nfs_common/) and hopefully it'll get picked up.  I can
followup with Trond later this coming week if/as needed.

Thanks,
Mike

