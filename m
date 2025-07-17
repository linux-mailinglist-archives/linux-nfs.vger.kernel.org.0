Return-Path: <linux-nfs+bounces-13125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D0B0842B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 06:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82628A43280
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B32202F9F;
	Thu, 17 Jul 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vePLrTIz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3EA202F8E
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728167; cv=none; b=F3Vs9KFbgs4At46OzNWdps1Rn/GX5JpnHeJXQaPvREdtyr+WNuqRP9Exjp02cO3ga0csBgWyWsm/XKDVlSP3ULHdLfJFrPo4zrc1Azmb0RTknQMilH3KIIiJN9tP3lseDkaZLktoSVaIzN4z907A2Rv9vy5hIwcBfaHqyXFR54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728167; c=relaxed/simple;
	bh=QSPPpdjiCgbm71LufB9qfPMayTfg7vGy5VVrEX1c/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDcIa23s+LGToEykOsvlC2AUmk4Z11+zehrT8j7acx9pj7M4SWqmmzj1PEMvj+D4J1UA0OcXiLlrvWEhMe6S7dFd3Qfx6kxYjzL4X4VDYkDUuHTMyN+oYFB52VbXEtTX9aSxTi47+XAEnhI8uoWeECjwk2+EjKwkK3BXAZIEMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vePLrTIz; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e5d932ab5so307449a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752728165; x=1753332965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA9OwdCE8eIhbOlePq6ADzlr/9GCVKPNA4d/k7TtyMI=;
        b=vePLrTIzPbviP6AVoE787fgchLw384a41d1VFw9sZc/eKR7l/m7/iFGXSlczySYbK/
         dZ1QaTMPBz2OsRVpnKWi56IMSjzb+NY3AKzkE2ayBJ3zFW3XIQBH9fYQLD5Dk4PjTa/2
         KHp3P1rpVYuvYLZYSLKrmeAHuQ4CGj2iUaqG3CB/0g/hWaYKC9sncoa5GZy6hJjUkVUl
         dvc0rRJ8111MiyXKWNUt1cKC3Tdh6f9cs6i/UiXYJSyNKm0uXmcFzfSsw8HvchdH2rqT
         4Z5ui0PF2BNruVI/BaidpgWp83sL9oIrPViy+lyyLxa5+Cd7+MqFzzzFiZ04xeIe26lP
         asGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728165; x=1753332965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA9OwdCE8eIhbOlePq6ADzlr/9GCVKPNA4d/k7TtyMI=;
        b=tRcMvu7Wobi24IstU/PC2YGB6pVg3LjRkCq5beP0N5l8fiFOgrWI8v+Y7MQWnZJ/Qg
         6dXq4JcriZfpDY42F+WbO4NjNCsJJe6cZ+Tk4GrAiKnJSaJius6RXD4RmlnMQdaOrztG
         8XElL7wKgJqTtjReKJcTXxgCgEZr5LUDPPuW7vXtTL5ONYQ2OOChcuzF3hs9/Rgb5k3B
         pJEucjkpvrvfprobTvVHptMZoJI/r1OlcYCx6lFOJpn4ITOAGwQF9m+N7tIpMOhP09SG
         /oZavRflpIcOpA+W377LyJCYfLnnA4OAAzYeStcykeTU9Es4ssmN9mSsuSk/ipvxh/nT
         PmkA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSX4RtGzio8pI3vg6hH1aTIG/J1P9Bi2/gkkRZNnSDTpy9PCmbfJ5peZ2APdW6EIg5fru/TLmQyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJceUyUHPL2IIf4wP37NE2zBt/RCwuLAe85KJyqgcC7M2+TDe
	XjBEmDUyev4oOo0Wq/sYFHWpjBvRU2bec/wHlqDbUnV58yGIJGyFEp1lK767FXPi2JE=
X-Gm-Gg: ASbGnctsfD9xnRVGol8qCyuekgUoP98xEheVt/h9nX5rLVKEd6xnNxvWSFAjsfPKd/1
	znW1IEStSxKYnVNevXRYopOmSM7WVwO3BgWxj9i2Yprlr8tyMVhKKBkvFeyOlY0IbL840rdnxBg
	DbGrH/WRQxLFPAwtIqU33fIwJokrZeyckBvHmLe94qBz8I+9+3Zwu7yOSlJ7KVmpA/KUv+4qxGh
	w8LfdDP5XqOTdmYG49KbftKbl4eWpqzcCQj5+teBk48rqIeZnSy8HmiuKQRYYgA1RcIbZiCbYtM
	Oc9J+ryyYMpXGzCq5ppb7OilnGnX4RLjl2Ibl971ndm/yAIT3pvgpg5OVxBSmCzu11xdLs6uAYm
	r3PPrxxH6MA6fzFVv4gO35StJpJWpIqX0Pk/dM7o=
X-Google-Smtp-Source: AGHT+IGR0DWY+RgBfgz02jJwa7z2iGG+/Sq+0RXAC0URhjVOZTXMc0+fpwm5U0mKQklYBMr0tBVsEg==
X-Received: by 2002:a05:6870:9626:b0:2d5:ba2d:80df with SMTP id 586e51a60fabf-2ffb21eb6a6mr3622667fac.8.1752728164899;
        Wed, 16 Jul 2025 21:56:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff111c36a0sm4116929fac.2.2025.07.16.21.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:56:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 07:56:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Antonio Quartulli <antonio@mandelbit.com>, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>

On Thu, Jul 17, 2025 at 03:27:50AM +0300, Sergey Bashirov wrote:
> On Wed, Jul 16, 2025 at 04:38:48PM +0200, Antonio Quartulli wrote:
> > In ext_tree_encode_commit() if no block extent is encoded due to lack
> > of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
> > despite it being uninitialized.
> 
> This static check warning appears to be a false positive. This is an
> internal static function that is not exported outside the module via
> an interface or API. Inside the module we always use a buffer size
> that is a multiple of PAGE_SIZE, so at least one page is provided.
> The block extent size does not exceed 44 bytes, so we can always
> encode at least one extent. Thus, we never fail on the first iteration.
> Either ret is zero, or ret is nonzero and at least one extent is encoded.
> 
> > Fix this behaviour by bailing out right away when no extent is encoded.
> >
> > Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> > Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> > Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> > ---
> >  fs/nfs/blocklayout/extent_tree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
> > index 315949a7e92d..82e19205f425 100644
> > --- a/fs/nfs/blocklayout/extent_tree.c
> > +++ b/fs/nfs/blocklayout/extent_tree.c
> > @@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
> >  		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
> >  			(*count)--;
> >  			ret = -ENOSPC;
> > +			/* bail out right away if no extent was encoded */
> > +			if (!*count) {
> 
> We can't exit here without setting the value of lastbyte, which is one
> of the function outputs. Please set it to U64_MAX to let upper layer
> logic handle it properly. Or, see the alternative solution at the end.
>   +				*lastbyte = U64_MAX;
> 
> > +				spin_unlock(&bl->bl_ext_lock);
> > +				return ret;
> > +			}
> >  			break;
> >  		}
> >
> 
> If we need to fix this, I'd rather add an early check whether the buffer
> size is large enough to encode at least one extent at the beginning of
> the function. Before spinlock is acquired and ext_tree traversed. This
> looks more natural to me. But I'm not sure if this will satisfy the
> static checker.
> 

No, it won't.  I feel like the code is confusing enough that maybe a
comment is warranted.  /* We always iterate through the loop at least
once so be_prev is correct. */

Another option would be to initialize the be_prev to NULL.  This will
silence the uninitialized variable warning.  And everyone sensible runs
with CONFIG_INIT_STACK_ALL_ZERO set in production so it doesn't affect
run time at all.  Btw, we changed our test systems to set
CONFIG_INIT_STACK_ALL_PATTERN=y a few months ago and immediately ran
into an uninitialized variable bug.  So I've heard there are a couple
distros which don't set CONFIG_INIT_STACK_ALL_ZERO which is very daring
when every single developer is testing with uninitialized variables
defaulting to zero.

regards,
dan carpenter


