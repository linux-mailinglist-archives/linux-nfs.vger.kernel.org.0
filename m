Return-Path: <linux-nfs+bounces-3123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C48B9416
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 07:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF531F25888
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 05:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B11CA81;
	Thu,  2 May 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRyLbR2C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30461C2AF
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626049; cv=none; b=jQoGAR87hgQGiHUXYqAZH/z5RstVI/JeKaJhI6ZokPArCXyZ1LqyMbCM/VhfqedH04buDTDr7Ko2Utcdqn2pPjbxItcYYNnPlL/UE6cgxjNLnbD9Jua4aEbHF+C5YSyWKNZt5Al1GLWjSqCHIRMZlUyyM9nzRTBT1y/FeVCRgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626049; c=relaxed/simple;
	bh=adWPtyXA5pxTYZmUg3Y8h2vz7ylOrxMT8f014ihjlIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAQNoozlzNJnqcZDgmmr2FIXBRK3R5HaGT9fHvQUPNWwy79mMOe6kD0m8MtGUezembK+wDSxXDRyw/aGZaCT5KC3HJRrWefa92at6gdNv2i0IdaQb3dofP2WRbK7shqyKMSoPLmTIHv8n8T4e/0YkjtV7mjcO0eu/4Zk/jCaGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRyLbR2C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5966f5a76bso69446766b.1
        for <linux-nfs@vger.kernel.org>; Wed, 01 May 2024 22:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714626046; x=1715230846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzwIQNpSurTjjH6DuCDHBEaopWdtGsSb8BMfQoLW680=;
        b=cRyLbR2C3dAv13e0EN8lZnEnpZIPZe6YhGdJm6Lm4NV0PgIeyZmlYBfGgJd8fTKoBt
         8uxXs2YTkyzhjfVgatQoi58nZoTL0gMUOePu6GpooDIbvzTPMC28yjsjRCjVHGAIA9aj
         olIP6HVKC7u9x0r9EEZ0zBw+3oSBDq9/R5dnN9nfLMn9yWtRJ5Y2+0vru8GDTR95YNW9
         obJJKU7oJQLBRSRrpMUKnXNooW5/x0L70G/Os/9zd3miO+VGPD7d/EcyzRh/1j07MntN
         vB/ME1piVsmLrgh1vRiBBce/1YhDzkHG6T4WRPtGt6Ch8XeGJziAniwgIIx7bKJV11Ee
         9DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714626046; x=1715230846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzwIQNpSurTjjH6DuCDHBEaopWdtGsSb8BMfQoLW680=;
        b=SedVUvMvzaQin0Fr0zzT7G0E/+Wyv+KEMS0y2yVo5zcTl7KTsOJdM6lxzZqNNyWzXp
         k5P19jO6jUy+dVLBJYQKqH2FonoOHjqHMpvsW45wUX7k92/VXgYROfF4gqU/5flj1B90
         z/ypauoNupeOF/GNorTsgG0bxnOZd3sAf98+3Qpomg04fgtp0r62sOfK1So5UNksrhad
         TM0Nk3ebgTZMZ46DgqcKAf8V2/l/Bohk7dnOK2AidTinJtUPe4rfqI6ghq9WKu6WD1Hv
         4MNsVwJfeMAYcpBR0jIuSRM1wwZtdEdDJoIeMCz1+768zMj/oCJBzrhummsGrDaO8XnR
         tzkw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4iILhpuo/SAAxv0Vrb3W4tjhjKcFzkKGafpeGrp3LTIaz5ei+wA67kJBvtaPERyGxVeCWdxxFZzX8tFarYDh5/LE280XkuPh
X-Gm-Message-State: AOJu0Yy0NHGJuvP1o17gkA5m3ksNgzUKqmjVRYYVd6G43onGZVhuJMvJ
	5X9L5cda77f7C/ONkUoHIL6uSi+AcJeZBS1R9CNNcGail0w6B8/ERc2nXNuy
X-Google-Smtp-Source: AGHT+IHoAEX2YpWtS7fOGMepnfFUeKrq3dkTvfdNn2XB4KfQwY0+zVUcr74kI5NHntbjFMYxPGO9eQ==
X-Received: by 2002:a17:906:4ec9:b0:a58:c550:a102 with SMTP id i9-20020a1709064ec900b00a58c550a102mr1316996ejv.29.1714626045750;
        Wed, 01 May 2024 22:00:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090646c800b00a55358244ffsm83651ejs.204.2024.05.01.22.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 22:00:45 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2B5CFBE2EE8; Thu, 02 May 2024 07:00:44 +0200 (CEST)
Date: Thu, 2 May 2024 07:00:44 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Steve Dickson <steved@redhat.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fails to build on =?utf-8?Q?arm{el=2Ch?=
 =?utf-8?Q?f}_with_64bit_time=5Ft=3A_export-cache=2Ec=3A110=3A51=3A_error?=
 =?utf-8?Q?=3A_format_=E2=80=98%ld=E2=80=99_expects_argument_of_type_?=
 =?utf-8?B?4oCYbG9uZyBpbnTigJksIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHRp?=
 =?utf-8?B?bWVfdOKAmSB7YWthIOKAmGxvbmcgbG9uZyBpbnTigJl9?= [-Werror=format=]
Message-ID: <ZjMd_DCJrV0tHY1K@eldamar.lan>
References: <ZhGfUpXclZeoZ_az@eldamar.lan>
 <A3AAF9FA-95BE-461C-8E7A-C0ED02526519@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A3AAF9FA-95BE-461C-8E7A-C0ED02526519@oracle.com>

Hi all,

On Sat, Apr 06, 2024 at 07:28:58PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 6, 2024, at 3:15 PM, Salvatore Bonaccorso <carnil@debian.org> wrote:
> > 
> > Hi Chuck, hi Steve,
> > 
> > In Debian, as you might have heard there is a 64bit time_t
> > transition[1] ongoing affecting the armel and armhf architectures.
> > While doing so, nfs-utils was found to fail to build for those
> > architectures after the switch, reported in Debian as [2]. Vladimir
> > Petko from Ubuntu has as well filled it in [3].
> > 
> > [1]: https://lists.debian.org/debian-devel-announce/2024/02/msg00005.html
> > [2]: https://bugs.debian.org/1067829
> > [3]: https://bugzilla.kernel.org/show_bug.cgi?id=218540
> > 
> > The report is full-quoted below. 
> > 
> > Vladimir Petko has created a patch in the bugzilla which I'm attaching
> > here as well. If this is not an acceptable format due to missing
> > Signed-off's I'm attaching a variant with a Suggested-by for Vladimir
> > to properly credit the patch origin.
> > 
> > Let me know if that works. I changed it slightly and only casting to
> > long long, and made it almost checkpatch clean.
> 
> I suppose strftime(3) might be nicer, but this works.
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle.com>>

I noticed this is not yet applied to the repository, do you need
anything else from me or did it just felt trouch the cracks or
actually queued?

Asking since if you want to have it done differently I will then
follow suit downstream as well in Debian, where we have for now
applied the submitted patch.

Regards,
Salvatore

