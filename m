Return-Path: <linux-nfs+bounces-13130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B7B08EC8
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9076AA64A04
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090C2F6FA0;
	Thu, 17 Jul 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOudqMFQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208112F6FA6
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760957; cv=none; b=uWWxj1Evubm27VO9n/DZuA8otyNxj0+7OxMfBVdCpylZ3whupLnPS+MXAvldZ06x0r7qBgY403nH/FhR/76aHwfY6IW+zpJVE7n7iS0isWrcIlJ2PutmBC7yB50mwDDhuVgmLj5GurYGO9DcVGjXktTGgP1+H63kWxf0y8IIQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760957; c=relaxed/simple;
	bh=jvjvNJ9/Hi0d0NH4OHDfhDk41aQZnW4W5eEeryeEQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9K0DRTSMWza4mGqTKlN69xhvzkamZp/1aseZIjKwefxdRgynIEBdsZ/n5HWzT2uh+rM+ZQUSgV1+Yrme2J3O+frE0nENkTOWj6Sgo6OJssbgQRt1t3KoGpHopFM2nPPGAPQPPMXSCEG+0MyowKRQ/nR/hSBEkVne3Li/yCMXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOudqMFQ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ffa1b10918so643775fac.2
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752760955; x=1753365755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/lGwtVvChzSLtqkQCS9MrMJ9VNP21TZnjqYYKZiq4I=;
        b=sOudqMFQBI/K4o1vSwg0X2pqwEsWMmd+/3Wi8Hjk5j3/K9e8EBJmHtqH+61PVlT7p7
         O0ZeTI1n/M+MJL3wJvdhs71Jue5nMHDIrNUBkeAEJGoPYslYU25nheq6XC8r6Tpfq5Sa
         5Iwze7XczfLS+IJdtTL81vVrrLH8OOEk8QsUJBxCoeT0mnXx1abeQkmDHNs2nbd72j9+
         R7benStUo2EgF8dj+/Yf0NlL0It0t675cpavNLmx4dWz8sxGF9h/2K4+BjijCHXwuX+s
         bbW/HaIfoFgZ1k9TT/giC6SAUAof9X/fGHth7LygBVPbfpmNPrrHJkCQbkJTRX6agmBQ
         jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760955; x=1753365755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/lGwtVvChzSLtqkQCS9MrMJ9VNP21TZnjqYYKZiq4I=;
        b=a2GfCATL8qTAjxR1Dg4BfF7+uuDmX49ZkkjQLNA9nEsT/oykT3nwyGzI2xBuxqVlSh
         9mLQtR13Vr3JoKQKWgTUv0JgyAj9X1c/aN3fYayPK7g/+hJ3SzfB7l5sbMG0Opov3TVs
         KJ/JTdosC4MGgTUJ0EgGMQEQpaVdJpkAmPTVKtffvcCAsbZfuxa5DHNXQpiXwqhwmPxD
         RxWAeoDQ8Xno4yGp9W+74SSOl4jAt4OBv6VUowesgK4kR2Lf4SdFid3JQykGhTk6HiBs
         7ltHNmajUt5quv6nI63PpDtmsmmHnX79QXmsKcp86klf2iKo4NFlGJt+M44kupuMqhP4
         DGyg==
X-Forwarded-Encrypted: i=1; AJvYcCVYgyXK79ugzmGoLBqhE/PcH6ixvP+UjzCX3SFW22WeaFCw2rycP3MvhaDOBpNLXyUjA3ogt5C27gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/msOPY9T7utqnSfpkahxc6VuBJLKYJZtJ3+DIZ0UrOE6vDj4g
	/NwKYQKCHx4IlOMUSk6MUvWCJ2Epx81MP69favIhG1v2ylltgXLdE9UoIQzhpIt8Xtg=
X-Gm-Gg: ASbGncuKXHt72/qMApL0OvHfls7emLOQ3R1fmIpbQOFJLqmJtQKIRTZ22qUV/ym80+N
	XLGdXmyiC4t8hXF3pziyEtIoRBh6Vpw3ufgPkaBsAYSICp/NKw5HGA/dPA4DrLTwgLy0fkghwlH
	0dK/QjM3dO0QW0vkb/J8u3fAh2rIIICPQsZ/O1cDJUUtMFBUziiC5ICi6CmRabMni8fxg1r1uTB
	VLJMTQao+8PgK/DXyeoYRsleSlOocfak1g2mIcxiJCc7S/bhENPlVAEJoyIVZjdtXUEJ9v2aXLQ
	9gFN9AGKxU+m/kc+V/fVrtpxmpsx1MC5zOc3Gfz6+FVAtdbwIj3Y3Raj2ByFgEgUy4vPmN8Fb+b
	K2SzqAexkG9FwEy/cmOYxpYd3/cHY
X-Google-Smtp-Source: AGHT+IFLK3PoG0Ry9cupN+1Gy4j1J9SSXaeHm73Z+F4q8Igvf8Tt9wX4mzY9/+JFGf1Gd8BqtKEL3g==
X-Received: by 2002:a05:6871:7b0a:b0:2d5:b7b7:2d6e with SMTP id 586e51a60fabf-2ffd2abcf70mr2255355fac.38.1752760954743;
        Thu, 17 Jul 2025 07:02:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e7b586ba3sm275626a34.40.2025.07.17.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:02:34 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:02:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <90cddfa9-2d0c-4806-b3df-6a5ddd13c97f@suswa.mountain>
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
 <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
 <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>

On Thu, Jul 17, 2025 at 10:01:42AM +0200, Antonio Quartulli wrote:
> 
> I agree a comment would help.
> 
> > Another option would be to initialize the be_prev to NULL.  This will
> > silence the uninitialized variable warning.
> 
> But will likely trigger a potential NULL-ptr-deref, because the static
> analyzer believes we can get there with count==0.
> 

I don't know how Coverity does this.  In my experience, writing Smatch
I had to treat initializations to NULL as "ignore this variable".  We
used to have an uninitialized_var() macro to silence uninitialized
variables.  It did an assignment to itself something like:

#define uninitialized_var(x) x = x

But we removed it and changed all those places to just initialize the
variables to zero.

Even before, initializing things to zero was the standard way to silence
GCC uninitialized variable warnings, so warning about NULL pointer
dereferences tended to be prone to false positives and the worst kind of
really complicated false positives too.

regards,
dan carpenter


