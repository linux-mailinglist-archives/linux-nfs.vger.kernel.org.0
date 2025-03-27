Return-Path: <linux-nfs+bounces-10919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4DA72894
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 03:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA42170FB2
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671F60DCF;
	Thu, 27 Mar 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI1rqZ6P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425784502A
	for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040804; cv=none; b=i2hqA4h3lCCCKils14lnDykKE4x+0wougdj13DTsQLZL3st7/zjAJJZtKJI1a6dsWjLeSPgBSUuKvgCLV39VpgqTQeEphykOQHluk3XYmtgPwEQhM/WsYpULciY2NmI6f72oiVYdyAKqehRMLznUoLI9W5ycYmERKNweOrMOtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040804; c=relaxed/simple;
	bh=gOV9vOUgL1JGSG+l8uva74S2zuBFGSD6YyWSQe3U/Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS1hU/7xQ3JkAR4D+g06vb9h577B5ZEs4yVwtl4rdJEAM5d1Zz9SfW0seqlbz8e054/5HLzYYrY1zYwSR2RXpqP04dKIFDBoKf9BW9SMN+/8UngfRJqdyehDQ5ZOoa52EeikE9U6SDycmfGH8n4b1uGjBIiPyFU7Pr9VnDGpwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI1rqZ6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79164C4CEE2;
	Thu, 27 Mar 2025 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743040803;
	bh=gOV9vOUgL1JGSG+l8uva74S2zuBFGSD6YyWSQe3U/Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI1rqZ6PHhnPKH5dZDNjwCrM9x4ZftqV83y7uXCyFhJTzSRvX+9I7aQZX/VLKdpzA
	 yvrw+PLcRU59mtCt8euQjMRrV+HwoRQUwCPSxT+vLcjrb/baZJpRKUlcfAAkKyYDjA
	 wCRl+F4F3OW+aJQDYus49Eah75qlwG6j8MZXAKXVn/99dvogAyOw/3HgS8WXrGi/md
	 5SLJgsf2Lc9Cb9ngEx+nSeCKLEMAfTZH5d6lezzUVOEq7++oiAUl8W+brL92S5+Kx3
	 mx/PbpPC8VtbNWG8dt3+d8C/2lLjLveMe3DFMBiHksKrIpCP2kB6mvQx+tn/vs8y4i
	 m41UKzHvM9vgg==
Date: Wed, 26 Mar 2025 22:00:02 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: nfs: add dummy definition for nfsd_file
Message-ID: <Z-SxIk0VIr9aslOK@kernel.org>
References: <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <eedc7b36-6ac1-498e-8e73-1608621d84f7@oss.qualcomm.com>
 <20250326205919.gdxxtcejde2jpil7@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326205919.gdxxtcejde2jpil7@pali>

On Wed, Mar 26, 2025 at 09:59:19PM +0100, Pali Rohár wrote:
> On Wednesday 26 March 2025 08:33:32 Jeff Johnson wrote:
> > On 3/26/2025 8:09 AM, Mike Snitzer wrote:
> > > Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> > > so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
> > > code (rcu_dereference and rcu_access_pointer) to dereference what
> > > should just be an opaque pointer with its use of typeof.
> > > 
> > > So without the dummy definition compiling with older gcc fails.
> > > 
> > > Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
> > > Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> 
> As this change is fixing compile error, should not be there also cc: stable line?

Any commit with a Fixes: tag will automatically be picked up by
stable@ once it is merged.  An explicit cc: sttable@ would be
redundant.

> > 
> > I saw this issue using crosstools/gcc-13.3.0-nolibc and this patch fixes it.
> 
> So maybe the commit message can be adjusted, so it does not say only
> "older gcc"?

I don't see the need to list all compilers, I documented the compiler
that motivated my fix.  Fact that it applicable for
crosstools/gcc-13.3.0-nolibc (which I don't have context for what it
is.. but if this commit is needed for it then it is a suspect "new"
compiler).

> > Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> 
> I have tested this change and it fixed compilation for me too. So:
> 
> Tested-by: Pali Rohár <pali@kernel.org>
> 
> > 
> > > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> > 
> > note this doesn't match the From: address

AFAIK there is no requirement that an S-o-B tag must match the email
header's From.

Mike

