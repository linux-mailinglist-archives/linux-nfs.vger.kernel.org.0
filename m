Return-Path: <linux-nfs+bounces-6515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0697A570
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8115028C00A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190491BF24;
	Mon, 16 Sep 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASUaxGdK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9B15747A
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501341; cv=none; b=iYxJzll7mn6W/uy65elZOcAqql6EuoSHKOufVW8xOhoZ58yRvTwHHnXG/jyO8ygRhpHlb0NC+VeK0rpIyK7wJLLPIgA2jltnFhzS5dyZcC7LObjusEtFr3C48KGV5XAwqpPWdJ8ilrVGSf5R6owz9dULZ3XcjxGUyn4b1FeWE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501341; c=relaxed/simple;
	bh=D8iKZrCdO25zawXijiLsdNooSMkyfsCDcvqUN4+/vhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIH1G58UGEvTzDGDAxYr/yT8Xk/UOZGfVVPcEmESuUw2p9v7GPpwVGYH/lnerIdmaCqvk/gUxW9dw5T6MsjbdvJhsfEqMfXgphYKcExSeooFzCxc4XhJGmKgVALfYsU6VTOMU7kh1oF04YeSkcjD7q9YZTg/MDucAbC6QpKnHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASUaxGdK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a843bef98so448281666b.2
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726501337; x=1727106137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLKsbS/p+rQVyLHmU3YqEXC7ll/gzTSeinNwshHe8fY=;
        b=ASUaxGdKyHqFSTByJqEsBrDr33BazR2J2hTRvAVImhIGI2xq/w3eu1tlrkiVwfOsxF
         hruy1NfcEY1F1P3UmVgqe1Mu63hWrW64BMXtrl7CR6CThMoF7JW9h2Hu72Q6eUXFgxc1
         UXF0WvCzeVzpSdnTuH6mnoiu7LeVNsIv7SXGJXVda9C2Pj9sEX2Pr3++DsI7bugDEdhp
         N+iC+quIMn7UvsePHC4qkU8onEXBev1elcBzh/48G1addUaUJOzXfESXXl8ZV8sMYn34
         Umsk8qVT0TKclZqXjF6pGifGFj8hMeo1hXPGzC8navbq5VGPBLk6sRP3M1DWuSwW3V/S
         swjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501337; x=1727106137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLKsbS/p+rQVyLHmU3YqEXC7ll/gzTSeinNwshHe8fY=;
        b=o9Ro//dmzpWBtb3BbB39SqVvu84ukL1ovxmOB6BwXtFHdwKFYS7mQ07r3I8BVYhu+F
         chi0jlLWBVPGVGn6TZYeKqB+arM4aNWaBB/3cd20az/B6RymjLLD5ZH6VFXylwgN4+Yi
         zhA0lipGpEpjnhqXERtUPIVjb6tlNFF/eZn0wpdTQsADMiGxZGFFlxhwKsS81FAk88yv
         lcQqfrf7ObJ8TlHu/ptgPM8V5rxeYmHk4WT9SBCvo3HW/ViFW1FrDGD0f0ZTSp+nYN3o
         zDkTnImBV+1JI7bU9PTHl2IS01zkMSCr3OyM9azwfrt8Xra9ubMvwtDt/JTev+hw5Wla
         nwEA==
X-Forwarded-Encrypted: i=1; AJvYcCUrc0BHJ1aVzmtlY/UbxBAByRba7rYx8XL6IhdBECMCFeP2X5aXh6RWkuG0T2GIdXPeCN9zuz7Y7Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHi6kQV/r63fyVOJBIDui3ZpqbBIi/b+xwKHudiTEEPukX9fXv
	K1JDxzlALI9szF6TEc/IZmXnosO67CDsidKlLSt9FDcI2HYk38Qz
X-Google-Smtp-Source: AGHT+IFYYHsJ/SWRxhAZiV1Pi2cIWtzG0Bycd+Pw+vE+byB3lg/UuWcQqAk/SiV5Z/XAGfqXpn/m5Q==
X-Received: by 2002:a17:907:26c5:b0:a8d:29b7:ecea with SMTP id a640c23a62f3a-a9048152e87mr1372057266b.61.1726501337168;
        Mon, 16 Sep 2024 08:42:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3833sm332755066b.128.2024.09.16.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:42:15 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C164CBE2DE0; Mon, 16 Sep 2024 17:42:13 +0200 (CEST)
Date: Mon, 16 Sep 2024 17:42:13 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sergio.Gelato@astro.su.se, Steve Dickson <steved@redhat.com>
Cc: Kevin Coffman <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <ZuhR1bpMZmDWsNew@eldamar.lan>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
 <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
 <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>

Hi all,

On Mon, Sep 16, 2024 at 02:28:50PM +0200, Sergio.Gelato@astro.su.se wrote:
> On Mon, Sep 16, 2024 at 01:54:35PM +0200, Steve Dickson wrote:
> > It did because it was not in the appropriate format... The patch
> > was an attachment, not in-line, no  Signed-off-by: line and
> > the patch was not create by git format-patch command (which
> > adds PATCH in the subject line).
> 
> I see no mention of formatting requirements at
> https://www.linux-nfs.org/wiki/index.php/Reporting_bugs
> (not even by reference to the Linux kernel tree).

Thank you all for looking into it. Steve, do you need to have it
re-submitted in a git format-patch format? At least a Signed-off-by
line by Sergio would be needed in my understanding.

Regards,
Salvatore

