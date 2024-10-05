Return-Path: <linux-nfs+bounces-6888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD2991916
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB3B208A6
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF291158208;
	Sat,  5 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6TT0kWF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4B1581E1;
	Sat,  5 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151010; cv=none; b=dtCocVkx8iqhdx1TZoKtjtI7oQkyxPaZmF0h/jwjSpUDV3CXILeHtvKguaRMpDmLnj851XHvfZTMIoXyJq8iuEqAXh/89zuE3g8I2Z7T03/zVacNQdXfNcT7E4bihGOAKMae7Y9l6Zq6NOAaizUWKsyhY5CY6gctBGDrCrCxl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151010; c=relaxed/simple;
	bh=dgNgJ+V3/jchFcCB/v1xzNk9zxKx9tULsyoiFHQLeSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEVBbBpmAl7ODJwHPbnGpeGmbHV/KTBY4+r5PMWyPbJtRyfnEAl/UXwiEPMptbXjdihghRrCVlQ8IyfIfmx2XLmCrqhreARuAkXmFoA/omQQGG4pjBMIJKeOurQ4aW5oGzFQAIloXbM0BTAWpqUkfYwShRPVLfk1iOYfgqM4Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6TT0kWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049EEC4CEC7;
	Sat,  5 Oct 2024 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151010;
	bh=dgNgJ+V3/jchFcCB/v1xzNk9zxKx9tULsyoiFHQLeSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6TT0kWFy0daybnaAnXcM9fLpOH+gzK8cikxi7D7ZDIrX1V6aTKDheB00TZ7K7Abo
	 HN5z4Zy//BjDAn7b60QvDXl4FAevnBzaJRB6BbJf7RoNIylhNweoYAOZVPQstgJeCZ
	 LfsCQrkgT2SufCHVWBQ8WmhulSJdo31ZpmXYzQvH/bAsDaC1lEl/9XU7ZiDtjHvLjM
	 W2IAUt/eXYAusR+0d4R9xrC4/2ooWYm7/cyPi9TDx/xoyNJO4QrzIgp2owVwlFu1EA
	 uc+qG+YVU+/FAZEH5KYROnYjMQGNtzSr1wohAMCIGOU1IhtSf08YOjmsyx8Y1Py216
	 IdCqipBGkv1TQ==
Received: by pali.im (Postfix)
	id 4644A648; Sat,  5 Oct 2024 19:56:44 +0200 (CEST)
Date: Sat, 5 Oct 2024 19:56:44 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Message-ID: <20241005175644.usygr3set3txtu76@pali>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
 <20240912232207.p3gzw744bwtdmghp@pali>
 <20240912232820.245scfexopvxylee@pali>
 <ZuN6ah3nI0giafGl@tissot.1015granger.net>
 <20241005165125.rbtgxzz4olvv4sqn@pali>
 <01C90EC0-1C3E-4880-9D33-ADCDA5B35483@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01C90EC0-1C3E-4880-9D33-ADCDA5B35483@oracle.com>
User-Agent: NeoMutt/20180716

On Saturday 05 October 2024 17:52:13 Chuck Lever III wrote:
> > On Oct 5, 2024, at 12:51 PM, Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Thursday 12 September 2024 19:34:02 Chuck Lever wrote:
> >> On Fri, Sep 13, 2024 at 01:28:20AM +0200, Pali Rohár wrote:
> >>> On Friday 13 September 2024 01:22:07 Pali Rohár wrote:
> >>>> On Friday 13 September 2024 09:10:45 NeilBrown wrote:
> >>>>> On Fri, 13 Sep 2024, Pali Rohár wrote:
> >>>>>> NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> >>>>>> original Sun implementation is used for RPC loopback callbacks from statd
> >>>>>> to lockd services. Linux does not use nor does not implement NLMv2.
> >>>>>> 
> >>>>>> Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> >>>>>> compatible with NLMv1. Fix comment.
> >>>>>> 
> >>>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>>>>> ---
> >>>>>> fs/lockd/clntxdr.c | 4 +++-
> >>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>> 
> >>>>>> diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> >>>>>> index a3e97278b997..81ffa521f945 100644
> >>>>>> --- a/fs/lockd/clntxdr.c
> >>>>>> +++ b/fs/lockd/clntxdr.c
> >>>>>> @@ -3,7 +3,9 @@
> >>>>>>  * linux/fs/lockd/clntxdr.c
> >>>>>>  *
> >>>>>>  * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> >>>>>> - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> >>>>>> + * NLM version 3 is backwards compatible with NLM version 1.
> >>>>>> + * NLM version 2 is different protocol used only for RPC loopback callbacks
> >>>>>> + * from statd to lockd and is not implemented on Linux.
> >>>>>>  *
> >>>>>>  * NLM client-side only.
> >>>>>>  *
> >>>>> 
> >>>>> Reviewed-by: NeilBrown <neilb@suse.de>
> >>>>> 
> >>>>> Do you have a reference for that info about v2?  I hadn't heard of it
> >>>>> before.
> >>>>> 
> >>>>> NeilBrown
> >>>> 
> >>>> I have just this information in my notes. I guess it should be possible
> >>>> to gather more information about v2 from released Sun/Solaris source
> >>>> code via OpenSolaris / Illumos projects.
> >>> 
> >>> Just very quickly I found this Illumos XDR file for NLM:
> >>> https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/common/rpcsvc/nlm_prot.x
> >>> 
> >>> And it defines NLMv2 with two procedures numbered 17 and 18, plus there
> >>> is a comment in file header about v2.
> >>> 
> >>> So probably the best reference would be the Illumos source code.
> >> 
> >> What you see in the Illumos code is not something that is part
> >> of the standard NLM protocol, but rather a private upcall protocol
> >> between the kernel and user space that is special sauce added
> >> by each implementation of NLM/NSM.
> > 
> > Ok. But this applies for v2, no?
> 
> On Linux, those operations are part of the NLMv1/3/4
> protocol implementation, so essentially the NLM v2
> functionality is a part of all NLM versions on Linux.
> 
> 
> >> Also note the way NLMv3 is defined in this file: it defines only
> >> a handful of new operations. The other operations are inherited
> >> from NLMv1.
> > 
> > Yes, v3 is there and is inherited from v1. This is also what I pointed
> > in the comment. That v3 inherits from v1, not v2.
> 
> Generally this is an abuse of the purpose of the RPC
> program versioning mechanism. Linux has a very similar
> upcall mechanism, but uses NLM procedure numbers that
> are set aside for this purpose instead of abusing a
> moribund protocol version.

I agree that this abuse of the versioning scheme. But it is there and
used in this way for a very long time.

> 
> > In header file of that nlm_prot.x is written:
> > 
> > * There are currently 3 versions of the protocol in use.  Versions 1
> > * and 3 are used with NFS version 2.  Version 4 is used with NFS
> > * version 3.
> > *
> > * (Note: there is also a version 2, but it defines an orthogonal set of
> > * procedures that the status monitor uses to notify the lock manager of
> > * changes in monitored systems.)
> > 
> > Which sounds like version 3 has nothing with version 2.
> > 
> > My understanding of that comment is that version 2 contains only those
> > private upcall protocol between kernel and userspace about which you
> > wrote, and therefore version 3 is not backward compatible with version 2.
> > 
> >> IMO the comment is accurate and does not warrant a change.
> 
> How about this replacement:
> 
>  * XDR functions to encode/decode NLM version 1 and 3 RPC
>  * arguments and results. NLM version 2 is not specified
>  * by a standard, thus it is not implemented.

That is perfect! Covers everything.

