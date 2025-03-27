Return-Path: <linux-nfs+bounces-10920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91924A72B78
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 09:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5131714DA
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C032054EB;
	Thu, 27 Mar 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVH3mjeQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AB17F7
	for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064129; cv=none; b=iYftIpDq3BbiMWdMeNJkgPSri+QwE1AqEG8/Nzeoz7ICH/kaOgmnpGimKod18O25SwpAgYGjRtRaOJDEqHJYLAdLS5c3MYO6dxB382Zsp8iFWcMxXorgK9FDzSZ0hAw+zbaFbegeJaLWRSReWQdoWNDgxtne0lRkwzh6+vT8rB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064129; c=relaxed/simple;
	bh=C268l/OQv5sf7GJ6BdVeCZgqQiwY6TJth6S3Tu3p3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKadFrM8A+b3u/LuwH/JkrKGNSCyNaZIh5icCFIu+VYV2WSpjVnxrL0WXAl9L58hDhIjQJXsXe81lDhxF1tzqT4tMvNobB+hqCKSqe1k+QCme58Z/yFF+YV3K+gjIdOT84imptqabOGno9WLWHRSe4cdKIzRCvn2ZfKR3wmq994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVH3mjeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A69C4CEDD;
	Thu, 27 Mar 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743064128;
	bh=C268l/OQv5sf7GJ6BdVeCZgqQiwY6TJth6S3Tu3p3KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVH3mjeQFW3vnxpbtOIuUq0iMXUP+aIxyEoB2MtVgC8NN6QkUG+bd6bUE+KPkwK8M
	 lpPFXUJAINONxtGwg+jUm1vk61+2Gjb1vY4AQuE9LMmp6ke8KoFZMdRIFcRQbxP259
	 ubrG7RMsxt/9SwBqDdJ6C/E+cu6xSeZRuMdOFNfCPnUxRi/Z2vOWIawmazUZ0td5+/
	 YA/S/p5RC6EoXyVGmBXfC/1rk1LOgDoD9IqVE49VNaUBfV9n/dNfQi3n9O7rZlTpYg
	 d9fsdQF98n516dX7ngj9ZBAdPYDVcOz5dbO3pgqLMffXAY/LHIfjnTyA7WOwAByZZn
	 M1HabjrrWUvzA==
Received: by pali.im (Postfix)
	id 52D15816; Thu, 27 Mar 2025 09:28:33 +0100 (CET)
Date: Thu, 27 Mar 2025 09:28:33 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: nfs: add dummy definition for nfsd_file
Message-ID: <20250327082833.l2w3cdlgjdzixskp@pali>
References: <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <eedc7b36-6ac1-498e-8e73-1608621d84f7@oss.qualcomm.com>
 <20250326205919.gdxxtcejde2jpil7@pali>
 <Z-SxIk0VIr9aslOK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-SxIk0VIr9aslOK@kernel.org>
User-Agent: NeoMutt/20180716

On Wednesday 26 March 2025 22:00:02 Mike Snitzer wrote:
> On Wed, Mar 26, 2025 at 09:59:19PM +0100, Pali Rohár wrote:
> > On Wednesday 26 March 2025 08:33:32 Jeff Johnson wrote:
> > > On 3/26/2025 8:09 AM, Mike Snitzer wrote:
> > > > Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> > > > so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
> > > > code (rcu_dereference and rcu_access_pointer) to dereference what
> > > > should just be an opaque pointer with its use of typeof.
> > > > 
> > > > So without the dummy definition compiling with older gcc fails.
> > > > 
> > > > Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
> > > > Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> > 
> > As this change is fixing compile error, should not be there also cc: stable line?
> 
> Any commit with a Fixes: tag will automatically be picked up by
> stable@ once it is merged.  An explicit cc: sttable@ would be
> redundant.

From my experience, when the backporting of commit with both Fixes:+Cc:
fails then the committer of the patch and also other is informed by
robot email. If there is only Fixes: without Cc: then people are not
informed.

So I used the Fixes:+Cc: for such build issues or important issues to
ensure that the change is really backported.

> > > 
> > > I saw this issue using crosstools/gcc-13.3.0-nolibc and this patch fixes it.
> > 
> > So maybe the commit message can be adjusted, so it does not say only
> > "older gcc"?
> 
> I don't see the need to list all compilers, I documented the compiler
> that motivated my fix.  Fact that it applicable for
> crosstools/gcc-13.3.0-nolibc (which I don't have context for what it
> is.. but if this commit is needed for it then it is a suspect "new"
> compiler).

My impression was that the commit is fixing just the compilation with
old gcc versions. But it seems that also new are affected. That is why I
suggested to adjust it, so it would be clear that it applies for new gcc
versions too.

> > > Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > 
> > I have tested this change and it fixed compilation for me too. So:
> > 
> > Tested-by: Pali Rohár <pali@kernel.org>
> > 
> > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> > > 
> > > note this doesn't match the From: address
> 
> AFAIK there is no requirement that an S-o-B tag must match the email
> header's From.
> 
> Mike

