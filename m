Return-Path: <linux-nfs+bounces-3128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354818B9BEA
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC5E2834B6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951675817;
	Thu,  2 May 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzFNJRd+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DDA219F6
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658138; cv=none; b=oEQ3c9V861nUWXMsPJgksnwVhRxhGeIhPqcm98RLjpipjyB4F/6R6vPadfBMTdrAOUvqIDXfLG12B432YNqNQrj4xYJYUwDFjRDDC5ZwuFiqDRci9DUwsclmE4y0dcSxP1+ZAW49+3aeCWQbmPu1dLpLarC2n3Gm7/aHZ+6/8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658138; c=relaxed/simple;
	bh=/Xtcjl6sSDAnz5G6L22+qOigvO9nYN9RrsY9SrRKQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSfixSk/Ny5PAT5SBH3XJu7uoO2/tYDfnzsBLaQG/eNDXkXJN9Dee5dmOFdnOvgI4YJC9C46A+pCxDwIDlvA4fDHZrrbgMCdctYh9/83OugREk62/0rHFpa5SiQJB7RofVdhrbUznLfOx1OijeYd9ehi1IWv/MVG0m3vhwkcWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzFNJRd+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a595c61553cso193853566b.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 May 2024 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714658135; x=1715262935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qST2nI3CEOuYC3mYx1PP+aXfdkjGVEZ3mUlq24ognjA=;
        b=LzFNJRd+8mwa2CEPaTxs7GiuL5+sJlsEdpK6nLlLExiYRa8phRb3zOPSWK7KsxUO3p
         +g1v84VBsAUBI4BW6mKHbrO/7eXiCst+VgC4POVypa6s0453GShNxD+B0YZLam0D+aAZ
         O0T1bZka8TTA6yBAuEAPRSg/t203UNhFntuNO7boBPoD2wdmaDiJAdgtsK/WqtR/3VNB
         QwW9FqeHXtKDdD9Bd/XUGGMiDMlmI3+/m+q6KvCRbaG85vlkZpOaPUGhPibhgWrAK2fG
         MgcFR7piI6kick9fs7tDxrI/+Wg8gIbd6TT915aCnvBsp2QxjwUWynsNisqfLFW6A+Lx
         4o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714658135; x=1715262935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qST2nI3CEOuYC3mYx1PP+aXfdkjGVEZ3mUlq24ognjA=;
        b=t0sslYrpwtRBqATZVxPGOhs/Z9D6AtMhEuhc7dpr/Xf6138aV9vAy6Xe2Ec04I9B5G
         yI+TDp5qztA6+CMH7ytpRkTtjXZtE2x6jcwBKOHyFMdqfviZEi4Uh+YUXY2VChCYmG5N
         Or65h9hgw30N9e9+ukwsB7o/QSb5xbUh1ZfzTnQaaugoQikQWD0wLXn7CaLmWP88jwes
         RDgjP2os8xLP/et2pNo9WLKlbP28sZZeUc6wlXRYyP1QkAjgE+1cfRIeL9IzonGvMwU5
         p+bgpoocjeu94Xy9HEaDJVJvm2MphyZX325LcGYsUrWS/BTm9shAWrCD7oNsW+ceEpZb
         hsZA==
X-Forwarded-Encrypted: i=1; AJvYcCWM/BOzfW/UcvV80LF9u1Rj5mT9qH+oK9jmKi5i5mrx38Mx5P/I0tRKjuIdbvRCSoOH6+jeYb8/IRwbQhEilYETTkQXBq0/nsZt
X-Gm-Message-State: AOJu0YzHUpG4kNCH1PcbJTerzOa7h9TSAXjzF1Ypu4TQeT1HWtw08GM9
	Jt0ftiXx/12UPK763Yr+hSCmyuQz9i/lkiDUMgo7fkKYNVIMND9+
X-Google-Smtp-Source: AGHT+IH8p3rXgb79ZvUdxWnBtyhnqPLZDyiGML5lZ07aeayQmXGnoz7WQTKnHOP4eEiBg3e0oVdk1A==
X-Received: by 2002:a17:907:1047:b0:a58:c0a1:f22e with SMTP id oy7-20020a170907104700b00a58c0a1f22emr4065461ejb.2.1714658134296;
        Thu, 02 May 2024 06:55:34 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id k24-20020a17090627d800b00a560ee2db26sm579643ejc.124.2024.05.02.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:55:33 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0842CBE2EE8; Thu, 02 May 2024 15:55:33 +0200 (CEST)
Date: Thu, 2 May 2024 15:55:32 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Steve Dickson <steved@redhat.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fails to build on =?utf-8?Q?arm{el=2Ch?=
 =?utf-8?Q?f}_with_64bit_time=5Ft=3A_export-cache=2Ec=3A110=3A51=3A_error?=
 =?utf-8?Q?=3A_format_=E2=80=98%ld=E2=80=99_expects_argument_of_type_?=
 =?utf-8?B?4oCYbG9uZyBpbnTigJksIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHRp?=
 =?utf-8?B?bWVfdOKAmSB7YWthIOKAmGxvbmcgbG9uZyBpbnTigJl9?= [-Werror=format=]
Message-ID: <ZjObVI2tISaGfIcv@eldamar.lan>
References: <ZhGfUpXclZeoZ_az@eldamar.lan>
 <A3AAF9FA-95BE-461C-8E7A-C0ED02526519@oracle.com>
 <ZjMd_DCJrV0tHY1K@eldamar.lan>
 <ZjONq6cf2MEmVSBK@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjONq6cf2MEmVSBK@tissot.1015granger.net>

Hi,

On Thu, May 02, 2024 at 08:57:15AM -0400, Chuck Lever wrote:
> On Thu, May 02, 2024 at 07:00:44AM +0200, Salvatore Bonaccorso wrote:
> > Hi all,
> > 
> > On Sat, Apr 06, 2024 at 07:28:58PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Apr 6, 2024, at 3:15 PM, Salvatore Bonaccorso <carnil@debian.org> wrote:
> > > > 
> > > > Hi Chuck, hi Steve,
> > > > 
> > > > In Debian, as you might have heard there is a 64bit time_t
> > > > transition[1] ongoing affecting the armel and armhf architectures.
> > > > While doing so, nfs-utils was found to fail to build for those
> > > > architectures after the switch, reported in Debian as [2]. Vladimir
> > > > Petko from Ubuntu has as well filled it in [3].
> > > > 
> > > > [1]: https://lists.debian.org/debian-devel-announce/2024/02/msg00005.html
> > > > [2]: https://bugs.debian.org/1067829
> > > > [3]: https://bugzilla.kernel.org/show_bug.cgi?id=218540
> > > > 
> > > > The report is full-quoted below. 
> > > > 
> > > > Vladimir Petko has created a patch in the bugzilla which I'm attaching
> > > > here as well. If this is not an acceptable format due to missing
> > > > Signed-off's I'm attaching a variant with a Suggested-by for Vladimir
> > > > to properly credit the patch origin.
> > > > 
> > > > Let me know if that works. I changed it slightly and only casting to
> > > > long long, and made it almost checkpatch clean.
> > > 
> > > I suppose strftime(3) might be nicer, but this works.
> > > 
> > > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > I noticed this is not yet applied to the repository, do you need
> > anything else from me or did it just felt trouch the cracks or
> > actually queued?
> > 
> > Asking since if you want to have it done differently I will then
> > follow suit downstream as well in Debian, where we have for now
> > applied the submitted patch.
> 
> Salvatore, can you resend the patch inline (not as an attachment)
>  To: Steve, Cc: linux-nfs@ ?

Yes sure, sorry about it. Here it is submitted:

https://lore.kernel.org/linux-nfs/20240502135320.3445429-1-carnil@debian.org/T/#u

Regards,
Salvatore

