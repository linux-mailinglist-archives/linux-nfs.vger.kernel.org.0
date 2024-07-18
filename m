Return-Path: <linux-nfs+bounces-4979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F39348B2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37871280D59
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932E770E1;
	Thu, 18 Jul 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qhCbkG1+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741267640D;
	Thu, 18 Jul 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287280; cv=none; b=fSz8RfpXCb3GiA/X55KEgg5zOquyusGCelheEajNcxWUpYv1pJEvfyZ2ZCAXsHsIdB3C9lc7nDTPtLb4GrFB/vbC60OMZea/zfmVQGzm0wogna21YB3ZN323A6yAh3LXE9rhoyiXWfB+WWI5QaZEGPm6vxmw5aZmreBtxUwDSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287280; c=relaxed/simple;
	bh=rodPdMqWswALPyc0nwR+ZLXdTdPhBNCc7nsEqwfJorg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdSaIDXMvUMOHI+OqIWq4FM9L7s0cuj49DAgzC1hmYlZBX9tAISyvh87a7zt++pp35KHOdTKb6eh+VtJ2wrvxrgtb78wS0xQR0+sfHG6VqVSxCLXpJu84uEl2+8VYjyz99TRZ3gBwyelQLkCsxZcumO8czcstkED31DuTUI8uAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qhCbkG1+; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A5CB414C2DD;
	Thu, 18 Jul 2024 09:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721287271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+rjvZQyHsJdpSR3htCONCiGKfa6XBkiGv3YmAB7J5z4=;
	b=qhCbkG1+jEOVDWmzJOc62uCMpfeosooVgbok4QKuln+P4Wuj7r3ruNughtAa6lMtpdB6QA
	bdic9LwIiLUK4oxByrSIhPJqMO+1elVoURS/Z0NlhPKlvRZSaVFbTQo68lUVWTgW/F3DrQ
	sLGVRzcmcETc5FomeW38PX0xHTlYB6uG6N45hQOf/f/Dnfp2HvPSHGLa9QD2pOJPmyvXkp
	8tV7m/6xtSASrJ9POWX0yPdO2QatKzu4mKBflk9Pcs+XBifMS/iHxKp05kTCeCMwkhWOys
	t/h6M6PvPowNZuCFRz7WiU5GM5b6b/ANNrQjv464F/kOXnucKVUd75pgbt0BUw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5c794c3b;
	Thu, 18 Jul 2024 07:21:06 +0000 (UTC)
Date: Thu, 18 Jul 2024 16:20:51 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5.10 762/770] nfsd: separate nfsd_last_thread() from
 nfsd_put()
Message-ID: <ZpjCU1rS15JBasOV@codewreck.org>
References: <20240618123407.280171066@linuxfoundation.org>
 <20240618123436.685336265@linuxfoundation.org>
 <ZnjyrccU0LXAFrZe@codewreck.org>
 <3afa32d75feeae84d894e7e71ce8e24372df78f3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3afa32d75feeae84d894e7e71ce8e24372df78f3.camel@kernel.org>

(Sorry for the slow reply)

Jeff Layton wrote on Tue, Jun 25, 2024 at 11:45:22AM -0400:
> > Jeff, you're the one who suggested reverting the two back then, sorry
> > to
> > dump it on you but do you remember the kind of problems you ran into?
> > Is there any chance it would have gone unoticed in the 5.15 tree for
> > 2.5 months? (5.15.154 was April 2024)
> 
> Sorry, I don't think I kept a record of that panic that I hit at the
> time. I do think that I looked at the original bug report and it looked
> like it was probably the same problem, but I don't remember the
> details.
> 
> I think I just mentioned reverting them because I didn't see the
> benefit in taking those into an old kernel. These are privileged
> anyway, so even if they are bugs I don't seem them as particularly
> critical.

Right, normal users can't stop the nfsd so you're correct it probably
doesn't matter as far as security goes (and this correctly doesn't have
any of the shiny new CVEs assigned); I'm now curious why it got
backported to all these trees at all if nothing needs it.

Anyway, I really just started looking at it because it got reverted in
6.1 so was wondering why it didn't get reverted in other trees, but if
it hadn't made it to any tree I wouldn't have cared at all...

As long as there doesn't seem to be a problem with older trees (and at
least I'm not getting any weird hang or crash on shutdown on my 5.10)
let's leave things as they are.

> > (Bonus question: if that is really all there is, would that make
> > sense
> > / should we take the commits back in 6.1 with that extra fix?)
> 
> Maybe? The problem is that someone has to do the testing for this.
> These interfaces aren't currently part of any testsuite, so a lot of
> that tends to be a manual effort.

Agreed, let's not add more work there if no-one can quickly test this.

If it turns out some later commit that actually needs this gets
backported to 6.1 we can always bring the pair of commits back when
someone notices.

Thanks!
-- 
Dominique

