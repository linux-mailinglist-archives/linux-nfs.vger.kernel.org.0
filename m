Return-Path: <linux-nfs+bounces-9729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A3A21837
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 08:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6096C3A30E3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9C198A19;
	Wed, 29 Jan 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcvLJSzy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB21799F
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135996; cv=none; b=DCJr5vNiHj9ltKLfAr1kG//AY84N9GfuJqs4pML89FzfVoF8rO92m2iqJmRGtgpDjxPGnqeLnalRXgrButp432i2jpB2Q0YgPLMFNHRn+LZqys4kiY4+1Pxe914+6XRxeL4LI5DGcrO18NZudtKWoLy7Dg/2S2TabEk+hZwDzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135996; c=relaxed/simple;
	bh=BCDNf02Im6sKSyZYpKgkFnxOBY7Jqc4OXbhJXoDxNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jqu1bPV/icgt0xqquq4SmLjOGXoMTCrzuYYUi011KwRTweOFgBVjkX8iqMrmzzXkjjSRRhoA422PXFh+9BosFSYXNiX+n984wZ1SdHTwEWPnASd931cI8rC4zY2DyRXxunYB6r1ltHi8dDWVXyeG8kdjVVVPo6omy5HBaUWwhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcvLJSzy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso9098984a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 23:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738135994; x=1738740794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJpt70HhAwb7NUZU+3L5/dGiIe0V7lUx+tITGKm+q48=;
        b=hcvLJSzybasPJewIzP4+AiDr+EMx/pcYFEhWChUMD3orsYoPRCq9HwBYrsbgLqmkUR
         ewmfE1TW2qxCBebCoheC9Z2cEz593ZtzYEclMPyPyhYKAWPmdnWA6PKDSzLYbib1OdBK
         wm/MYOw4hUrn2hkd2rVcQMzLWDzqHfz0jj62kyuzZrCXr3aCLaQtUmMSSUO7EKzzB8VR
         bcrf0KQkv8oTFy4WU2GBbnm7uzmgG/WSQXiIo9tB5DgHZOp0+SXX2BDYpGMWoZG4aWGM
         DbgQIxUmzlritsl0aBwYmxnOINUcUtSMfDcVmMw7t7YhXVm8GEnI7vAznnGJhLLNZNHc
         gB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738135994; x=1738740794;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJpt70HhAwb7NUZU+3L5/dGiIe0V7lUx+tITGKm+q48=;
        b=etCe1lXYXzW99QAKzXIVKDPVz/iEh9C7olph2nOf6Rlx7OsrgKm5zNFYq0zd1jSJwD
         3D91OFlu74OdnwES2FTQ9oAxST0DZMRdrVVy3kCXmsCKD/FzykFd8mTc3cngVj4Q0oHu
         EPtSvLzT95bijctPk+iqoKMhtEY6i/SbjV4YE0nT3YwgL6eEkrqU0R8FcbE8KA52vuy9
         XgL9T/m9I9/1N2EYKevd0wAFA2kfCTJDhgFXYjvdig9PiO7yYr/uYE2WbN/DEEiwKoKQ
         g6wF4xdXPqXdUE54KDuETypilLF4IVaQ5FFuCTMh4amrA0YkYL0SAQLsHIszSSoqx/Vd
         rA+Q==
X-Gm-Message-State: AOJu0YzPGoaZn06s24WpoVv75g5UeDD7Hlcg1gY6SRsFzuWRV149D42/
	tK4mKzwWEArgpgnbIa0f0YM2pPJPXrjuEgSNi7PVRLBVnHeF11t8BxqXHbcTuPvgZze4ZzArlg7
	RIHeF3jbYJhaCyKuwcZHVFW/LClTtd1s+
X-Gm-Gg: ASbGncssTx26b+0GtyIW1q7bckjA+Aykko7o7cwx5F9KlZcVwMUpOYOX7zHF3X7eoZF
	ckzuBT1KpNYOFXXvBzbwPmDwuBv/SbciB4bikKiX6IBOo03U4ZN4GbovRuuFSLVSQZQUFnBfACR
	IDaWC+CQO9
X-Google-Smtp-Source: AGHT+IGtcvEcdc3/yKYPXPkJkVq1fsBnhy42Qc1VRz6wyICda+nu0LlQN5hNQ68mfM782FGwjCz9tt2NWISjhFQkIAM=
X-Received: by 2002:a17:90b:264e:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f83abb3574mr2946172a91.3.1738135994351; Tue, 28 Jan 2025
 23:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
In-Reply-To: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 29 Jan 2025 08:32:00 +0100
X-Gm-Features: AWEUYZm7YBaUdgjWGYudP96kpo-aDCDjYgT6HF5IsyGb3u1Aqfev5Emyhjx_748
Message-ID: <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
> giving the NFSv4.1 session mechanism some headroom for negotiation.
> For over a decade the default value is 1M (1*1024*1024u), which IMO
> causes problems with anything faster than 2500baseT.

The 1MB limit was defined when 10base5/10baseT was the norm, and
100baseT (100mbit) was "fast".

Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
10000baseT is fast.
Just the 1MB limit is now in the way of EVERYTHING, including "large
send offload" and other acceleration features.

So my suggestion is to increase the buffer to 4MB by default (2*2MB
hugepages on x86), and allow a tuneable to select up to 16MB.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

