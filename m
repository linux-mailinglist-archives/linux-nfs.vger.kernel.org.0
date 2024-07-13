Return-Path: <linux-nfs+bounces-4877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C20930638
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098541C20CAB
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85661FD4;
	Sat, 13 Jul 2024 15:47:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from xmailer.gwdg.de (xmailer.gwdg.de [134.76.10.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8B1BC40;
	Sat, 13 Jul 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885655; cv=none; b=dcK0zoI34JKVS0OOkZP9Tex7NJGqXeYrdJetoWUvjhdWEimJ+u5DfnHpjOuVCuSTComCSTH3TgeocOPvDYGF6TAFm7e6AP7eRzz4pXGamz6nqj1hFBo+0Nvh89Q4iDMmAWBbvpfchROzqAqTiZllyKXJcmFtyHwVnF0wXf+VJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885655; c=relaxed/simple;
	bh=S+UaN2pzf9tiXr3mgca+BKasLQdxNloIWhX48I2KP5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTwC6CFM7j8PZ+tidBGuvl8Ln+9/EjaIRos52QQVnUyZG4Psc4VRKz0kGDTkgEpOky6HED9AVQw0UNtNiVj7edn1/Lxl18GkXxhRbWtRg3ykVTqleS5TadjOUkyHusZZERh1yY4NDLdI4yeyCj3hrXk9PO/lgF6xgvDjN4HciRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuebingen.mpg.de; spf=pass smtp.mailfrom=tuebingen.mpg.de; arc=none smtp.client-ip=134.76.10.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuebingen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuebingen.mpg.de
Received: from mailgw.tuebingen.mpg.de ([192.124.27.5] helo=tuebingen.mpg.de)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <maan@tuebingen.mpg.de>)
	id 1sSey2-0007zB-2S;
	Sat, 13 Jul 2024 17:47:22 +0200
Received: from [10.35.40.80] (HELO mailhost.tuebingen.mpg.de)
  by tuebingen.mpg.de (CommuniGate Pro SMTP 6.2.6)
  with SMTP id 59083440; Sat, 13 Jul 2024 17:47:21 +0200
Received: by mailhost.tuebingen.mpg.de (sSMTP sendmail emulation); Sat, 13 Jul 2024 17:47:21 +0200
Date: Sat, 13 Jul 2024 17:47:21 +0200
From: Andre Noll <maan@tuebingen.mpg.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, it+linux-raid@molgen.mpg.de
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
Message-ID: <ZpKhiUxdrRFTM8SO@tuebingen.mpg.de>
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area>
 <Zo_AoEPrCl0SfK1Z@tuebingen.mpg.de>
 <ZpBcG1HPeahYqwDd@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpBcG1HPeahYqwDd@dread.disaster.area>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
X-Spam-Level: $
X-Virus-Scanned: (clean) by clamav

On Fri, Jul 12, 08:26, Dave Chinner wrote
> On Thu, Jul 11, 2024 at 01:23:12PM +0200, Andre Noll wrote:
> > On Thu, Jul 11, 09:12, Dave Chinner wrote
> > 
> > > > Of course it’s not reproducible, but any insight how to debug this next time
> > > > is much welcomed.
> > > 
> > > Probably not a lot you can do short of reconfiguring your RAID6
> > > storage devices to handle small IOs better. However, in general,
> > > RAID6 /always sucks/ for small IOs, and the only way to fix this
> > > problem is to use high performance SSDs to give you a massive excess
> > > of write bandwidth to burn on write amplification....
> > 
> > FWIW, our approach to mitigate the write amplification suckage of large
> > HDD-backed raid6 arrays for small I/Os is to set up a bcache device
> > by combining such arrays with two small SSDs (configured as raid1).
> 
> Which is effectively the same sort of setup as having a NVRAM cache
> in front of the RAID6 volume (i.e. hardware RAID controller).

Yes, bcache is cachevault on the cheap, plus the additional benefit
that bcache tries to detect and skip sequential I/O, bypassing
the cache.

> That can work if the cache is large enough to soak up bursts of
> small writes followed by enough idle time for the back end RAID6
> device to do all it's RMW cycles to clean the cache.
> 
> However, if the cache fills up with small writes, then slowdowns and
> IO latencies get even worse than if you are just using a plain RAID6
> device. Think about a cache with several million cached random 4kB
> writes, and how long that will take to flush to the RAID6 volume
> that might only be able to do 100 IOPS.

Indeed, we also see these stalls occasionally, especially under
mixed workloads where large file copies happen in parallel with heavy
metadata I/O such as a recursive chmod/chown. However, the stalls we
see are usually short. At most a couple of minutes, but not hours.

> Hence deploying a fast cache in front of a very slow drive is not
> exactly straight forward. Making it work reliably requires
> awareness of workload IO patterns. Special attention needs to be
> paid to the amount of idle time.

The problem is that knowing the I/O patterns might be too much to ask
for. In our case, many scientists use the servers at the same time,
and in very different ways. Some are experimenting with closed source
special purpose software that has unknown I/O characteristics. So the
workload and the I/O patterns are kind of unpredictable and vary a lot.

If people complain about slowness or high latencies, I usually
recommend to write to SSD-only scratch space first, then copy over
the results to the large HDD-backed arrays. Sometimes it's the
unsophisticated solutions that work best :)

Thanks
Andre
-- 
Max Planck Institute for Biology
Tel: (+49) 7071 601 829
Max-Planck-Ring 5, 72076 Tübingen, Germany
http://people.tuebingen.mpg.de/maan/

