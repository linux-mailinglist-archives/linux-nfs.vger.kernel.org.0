Return-Path: <linux-nfs+bounces-2796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E498A4090
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Apr 2024 08:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C4281CED
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Apr 2024 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954681C687;
	Sun, 14 Apr 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCsIvchc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9B1799D;
	Sun, 14 Apr 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713075221; cv=none; b=m9Rh/cwOh4Dg+LRMDPf92tknExMww6RMu12gsU31dHeo2wBgGjC6PDXiGV1bwmoza3NlPCaAk/9BsUJv7ycMMHHs9NwQ+zZq96FRnCk7EQFC8arlir7R8qCGcyUoasFDFKHK283gsoN7LCqC0++CfFeRU8ClmERwuo7UXza/9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713075221; c=relaxed/simple;
	bh=a/UKSDLT2RB4LLEbvIebaNm82geJbaWNHm2MRarQ+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDIJ9nlK3dH0N1VuQPYbWA/nqWXvNLDq/0SK2K3+p4ucMk1scgrO06Y8Fhq2ztjFP0uHRVsximpcw8sH24lU9tTPpEGm9bu0SFxl4e8SaN/7W/RQyl/blzMVFvDPEOQjMxXqx9sCBSI1ZLpgVD8w9xjf82NL6P50DDZSwich2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCsIvchc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366CCC072AA;
	Sun, 14 Apr 2024 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713075220;
	bh=a/UKSDLT2RB4LLEbvIebaNm82geJbaWNHm2MRarQ+Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCsIvchccziDtRuYg+jt7ur0f12+B8TRORh546ABw8naHDV7Wj2hT4e0/w29T+WO+
	 GYYOM0WN6jfCNES09XbvxtFum081za5gfLFVphj4pEJ7dN3JHcX5A5md4L/YunAMZ0
	 GB+w39gjhTPRliv+ZNC1RoggBAt4m5tx7WQV0fCU=
Date: Sun, 14 Apr 2024 08:13:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"patches@kernelci.org" <patches@kernelci.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
	"srw@sladewatkins.net" <srw@sladewatkins.net>,
	"rwarsow@gmx.de" <rwarsow@gmx.de>,
	"conor@kernel.org" <conor@kernel.org>,
	"allen.lkml@gmail.com" <allen.lkml@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	Calum Mackay <calum.mackay@oracle.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <2024041402-impeach-charting-60f5@gregkh>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
 <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
 <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
 <11019956-95c4-4c35-b690-b8515b439eb2@oracle.com>
 <ZhqrH0II0ZJj0dzW@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhqrH0II0ZJj0dzW@tissot.1015granger.net>

On Sat, Apr 13, 2024 at 11:56:15AM -0400, Chuck Lever wrote:
> On Sat, Apr 13, 2024 at 03:04:19AM +0530, Harshit Mogalapalli wrote:
> > Hi Chuck and Greg,
> > 
> > On 13/04/24 01:53, Chuck Lever wrote:
> > > On Sat, Apr 13, 2024 at 01:41:52AM +0530, Harshit Mogalapalli wrote:
> > > > # first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd:
> > > > introduce safe async lock op
> > > > 
> > > > 
> > > > Hope the above might help.
> > > 
> > > Nice work. Thanks!
> > > 
> > > 
> > > > I didnot test the revert of culprit commit on top of 5.15.154 yet.
> > > 
> > > Please try reverting that one -- it's very close to the top so one
> > > or two others might need to be pulled off as well.
> > > 
> > 
> > I have reverted the bad commit: 2267b2e84593 ("lockd: introduce safe async
> > lock op") and the test passes.
> > 
> > Note: Its reverts cleanly on 5.15.154
> 
> Harshit also informs me that "lockd: introduce safe async lock op"
> is not applied to v6.1, so it's not likely necessary to include here
> and can be safely reverted from v5.15.y.

Chuck, can you send a series of reverts for what needs to be done here
as these were your original backports?

thanks,

greg k-h

