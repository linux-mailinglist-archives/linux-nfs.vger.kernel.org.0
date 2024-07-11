Return-Path: <linux-nfs+bounces-4808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D814292E768
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BED2849FF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87615534D;
	Thu, 11 Jul 2024 11:48:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from xmailer.gwdg.de (xmailer.gwdg.de [134.76.10.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7732904;
	Thu, 11 Jul 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698484; cv=none; b=UoJ8PsMvezVkw13xWcXJ8FQogMqSljADer4XlpbHAtzIW1hw3k6v373SrMWj9NJ8jp1Y69TfKVFVzlIhZBaglqEt1vR7grxYnud9mXR3c2nKVdTb8zZLmLGKzqseCbkbPEbNW/A0ziNDgf2t/h/gNF0beF9HTowmDAIdUtvzPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698484; c=relaxed/simple;
	bh=jxYhJAW9FsXI8+iwIzytS+MQhfBzOQ/G2qYzaJ8TymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXivORQwbBlD2wi5Nc8D5ixj4inFuxwBv3cuFasVYHZoN+w8N7PHcuWjVbtZYxVQoau84I1tYXUONa6R2jhsApPRPWvWrNjUaQvf1xMLMgfrTov3+5LKpXUo2f/zmCWrqBejcy3SDDWQ8k1r5fafv35amGE81W5VRAbC+KVnMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuebingen.mpg.de; spf=pass smtp.mailfrom=tuebingen.mpg.de; arc=none smtp.client-ip=134.76.10.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuebingen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuebingen.mpg.de
Received: from mailgw.tuebingen.mpg.de ([192.124.27.5] helo=tuebingen.mpg.de)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <maan@tuebingen.mpg.de>)
	id 1sRrtJ-000Veo-1u;
	Thu, 11 Jul 2024 13:23:13 +0200
Received: from [10.35.40.80] (HELO mailhost.tuebingen.mpg.de)
  by tuebingen.mpg.de (CommuniGate Pro SMTP 6.2.6)
  with SMTP id 59008868; Thu, 11 Jul 2024 13:23:12 +0200
Received: by mailhost.tuebingen.mpg.de (sSMTP sendmail emulation); Thu, 11 Jul 2024 13:23:12 +0200
Date: Thu, 11 Jul 2024 13:23:12 +0200
From: Andre Noll <maan@tuebingen.mpg.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, it+linux-raid@molgen.mpg.de
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
Message-ID: <Zo_AoEPrCl0SfK1Z@tuebingen.mpg.de>
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zo8VXAy5jTavSIO8@dread.disaster.area>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
X-Spam-Level: $
X-Virus-Scanned: (clean) by clamav

On Thu, Jul 11, 09:12, Dave Chinner wrote

> > Of course it’s not reproducible, but any insight how to debug this next time
> > is much welcomed.
> 
> Probably not a lot you can do short of reconfiguring your RAID6
> storage devices to handle small IOs better. However, in general,
> RAID6 /always sucks/ for small IOs, and the only way to fix this
> problem is to use high performance SSDs to give you a massive excess
> of write bandwidth to burn on write amplification....

FWIW, our approach to mitigate the write amplification suckage of large
HDD-backed raid6 arrays for small I/Os is to set up a bcache device
by combining such arrays with two small SSDs (configured as raid1).

Best
Andre
-- 
Max Planck Institute for Biology
Tel: (+49) 7071 601 829
Max-Planck-Ring 5, 72076 Tübingen, Germany
http://people.tuebingen.mpg.de/maan/

