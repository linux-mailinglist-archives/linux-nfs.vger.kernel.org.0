Return-Path: <linux-nfs+bounces-16131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B28C3BCAC
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9020188DF1C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301B33F8DD;
	Thu,  6 Nov 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8u3gMiq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FAD31A80D;
	Thu,  6 Nov 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439610; cv=none; b=VigLvWoFi4D36LBM+zt7Cx/aPLeMs+rAzq/zoSYg3ItO2Or5w4QruSAP7w928pGd3UA5lnO1m15RURX4wkdOfiPYMTJV0hhO6tMD38/E7ZHTeDlBx85v2652JkAtJfasOCj9J8n+FbibTztx2RQBj5xhGlP2yruwPhOn1XdHAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439610; c=relaxed/simple;
	bh=0wSHlM09iOhzFBw498LhHwkOc0mjGo5Tmr0ceb2EkkQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=M0sBXDZIySaDFCdZs3udkBdBfidqW5z3VVw6xE8rGEoL3M0Xf1YS6YP6a9KT2t2q0+KHwfVCyccDBWpzTzpBuA38EW60EZccbnudiCTxG4ErcQH/qQAgfcQdZndiDeztH1+hZq+7Q87Vr2qo5eruTHD/YemNUMawQI83xIEYe9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8u3gMiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69460C116D0;
	Thu,  6 Nov 2025 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439610;
	bh=0wSHlM09iOhzFBw498LhHwkOc0mjGo5Tmr0ceb2EkkQ=;
	h=Date:Subject:References:To:Cc:From:In-Reply-To:From;
	b=U8u3gMiqvXcE1IVfbLOWbXBxDliYkBclkIbFGDvc5MONPdchzOilNcljsqoyDv0hR
	 JpFKc4yim6QUNcoczIQvUPbIWNt+2xmDspxvTRy6VnWMDFYLZt78gifNCiKPg6D3tD
	 3sSCfERfI6JAJMfb+SH6Zz0IpQpQYIsRC1eQWcd6IXmcVH+VT3ni9D1iiU5dvLoXJe
	 Pk+ImE01klQuuCURJ0G2ToPr30+BpZ4Iew2RCXkDLWLDzL4buaPHWSawgTAdfIeF3j
	 iBbysaiXiwJNxHSAG2qTwxpa3rm5COFBZ2HD0mB1XfvQhz5lRJPAt7rk9QKydaw5v7
	 GYqlKi1oT/1XQ==
Message-ID: <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
Date: Thu, 6 Nov 2025 09:33:28 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
X-Forwarded-Message-Id: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

FYI

https://bugzilla.kernel.org/show_bug.cgi?id=220745


-------- Forwarded Message --------
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit
slotsize greater than high limit total_avail/scale_factor
Date: Thu, 06 Nov 2025 07:29:25 -0500
From: Jeff Layton <jlayton@kernel.org>
To: Mike-SPC via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
neilb@ownmail.net, trondmy@kernel.org, linux-nfs@vger.kernel.org,
anna@kernel.org, neilb@brown.name

On Thu, 2025-11-06 at 11:30 +0000, Mike-SPC via Bugspray Bot wrote:
> Mike-SPC writes via Kernel.org Bugzilla:
> 
> (In reply to Bugspray Bot from comment #5)
> > Chuck Lever <cel@kernel.org> replies to comment #4:
> > 
> > On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:
> > > Mike-SPC writes via Kernel.org Bugzilla:
> > > 
> > > > Have you found a 6.1.y kernel for which the build doesn't fail?
> > > 
> > > Yes. Compiling Version 6.1.155 works without problems.
> > > Versions >= 6.1.156 aren't.
> > 
> > My analysis yesterday suggests that, because the nfs4state.c code hasn't
> > changed, it's probably something elsewhere that introduced this problem.
> > As we can't reproduce the issue, can you use "git bisect" between
> > v6.1.155 and v6.1.156 to find the culprit commit?
> > 
> > (via https://msgid.link/ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org)
> 
> 
> Yes, your analysis is right (thanks for it).
> After some investigation, the issue appears to be caused by changes introduced in
> include/linux/minmax.h.
> 
> I verified this by replacing minmax.h in 6.1.156 with the version from 6.1.155,
> and the kernel then compiles successfully.
> 
> The relevant section in the 6.1.156 changelog (https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.156) shows several modifications to minmax.h (notably around __clamp_once() and the use of
> BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...)), which seem to trigger a compile-time assertion when building NFSD.
> 
> Replacing the updated header with the previous one resolves the issue, so this appears
> to be a regression introduced by the new clamp() logic.
> 
> Could you please advise who is the right person or mailing list to report this issue to
> (minmax.h maintainers, kernel core, or stable tree)?
> 

I'd let all 3 know, and I'd include the author of the patches that you
suspect are the problem. They'll probably want to revise the one that's
a problem.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

