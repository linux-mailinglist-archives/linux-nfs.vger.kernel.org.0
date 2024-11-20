Return-Path: <linux-nfs+bounces-8147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06C9D34ED
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 08:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEAB280E9B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82692158D94;
	Wed, 20 Nov 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYChISHA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5719145A03
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089538; cv=none; b=l2gmXSheQvB0Wdh3CntFK5PBUns71sAx4CwCXwWIOhcqE4+jSNH9OpWgte0oyQEcblzlmwxgw0tpr+Bcz4lmrB+3m/bUV6KnmUGouUQ56Spr94zELN/O06ricOH5uZMi15pPfvkrLv028Jm6r4coWTPhMG9W3XJpVPt3CvGL50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089538; c=relaxed/simple;
	bh=Kpc0ekkAXS2Dcktfvr8SqlVOQyCiVuv87+0B4TZEHkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du/tC/UWkK6i83Hkv96DQm1NA28b9qKNjnSr/rTjUvN7CyiXUcSj0eE7kikXFVxNQMrewFeoPOdRcRhNSal3gl+ssbH8T7gVxQny3NostDbrKb3CRuH78SZoLfzl3di+GhJQlci4asibJMobkf4muTboOx2Hgoj7zpWx1wmszY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYChISHA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so318199366b.3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 23:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732089535; x=1732694335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVh6t4xVXJRavO0WQiDZpATzZ1+6mY3Sm+bw1wuaiOs=;
        b=gYChISHAm8HweuF3fAYrJsRhjEnIlZmQ0bqWk1gg+BM2XjzP4NZXxgneNqUgpYn+2T
         WG7vZUIYAvrt0UczoofCG0IN0FIWcCp5oitZOxwOrNCfjU0jRAlgew61me8Tsi/5EUB2
         L7waIXygbMEqfmJo5fYh7RXrB3fw0dGu0lm0nsTjH656JFIttY4bZ9mhX++a4EgMjrCT
         MGTAgFoxaf3EIg8wIowaTTeAUK6XUjjjov+6A41oRBT6gmnXywW3Ou/9g7cx1gjcZlCK
         XYmimwAt51r3GNxf7F0RtIZADW6S+FPkxSDwKSFez2qJa22SdCkJSbbx1E8ZXVv3QR08
         PNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732089535; x=1732694335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVh6t4xVXJRavO0WQiDZpATzZ1+6mY3Sm+bw1wuaiOs=;
        b=kiVY6rGEUm1NiUQ9qQDaK7grRU3tiX2VE0n8qU/VRg2CG/AjI1RbEKBN/L0eQBXLUr
         3QOamZ2C3xftaZhQQM2U5SXxGxkMSfyS0qC/zD88PmVDSrI20t2123LVrPZ8QsqEeQTR
         GnfUjLRji1TE4gaZcVXbB2E3g5HaDPfQXVdvgU5XGiVvo9WE2HutQsnVEhI2szcVSpsD
         SdE24a02QsEZZge0osIXxH4cSAPZrYCprl/d5WvKE98eN87CQdoHQ9OW/MD4p+s1MRot
         Z7t8zxNP04md348glq2Z8NH2bjzzkPN3hxOuAy8XhjXoawDjDfIvKBwFMF5LI9grPBXQ
         QUWQ==
X-Gm-Message-State: AOJu0YxTokINlPyg3scA0yVTjKQCq5IuDIQ+LRwUIiKtFiS7N0xbTaK7
	/78b5dYJkYQFHrW3xNnyJu+PFI1XmyU586Y78fO1RB1NydadXqtBT3iGN1SktgYQNwuHrPfYUGi
	/fetVWM2t7z2klNCnvc7Merb++nB8uQ==
X-Google-Smtp-Source: AGHT+IFz49lRu2XSfyB9NiYzT1Q60DKD3/HqfVCyiGplg5KbWM4eeSueRKc9I4Dv3jWuwLFCatxEY0vdF9Ka9zZnXi4=
X-Received: by 2002:a05:6402:2689:b0:5cf:c1a3:b109 with SMTP id
 4fb4d7f45d1cf-5cff4ae61c1mr1289243a12.2.1732089534863; Tue, 19 Nov 2024
 23:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119165942.213409-1-steved@redhat.com>
In-Reply-To: <20241119165942.213409-1-steved@redhat.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 20 Nov 2024 08:57:00 +0100
Message-ID: <CALXu0UddnDfi1sF6W5Ca8a9Zzjxad3JNgCQXkmpVuoJyBPLGhw@mail.gmail.com>
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 18:07, Steve Dickson <steved@redhat.com> wrote:
>
> From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
>
> The rsize/wsize values are not multiples of 1024 but multiples of the
> system's page size or powers of 2 if < system's page size as defined
> in fs/nfs/internal.h:nfs_io_size().
>
> Signed-off-by: Steve Dickson <steved@redhat.com>

REJECT. As discussed, this is the WRONG approach. The pagesize is not
not easily determinable (/bin/pagesize not even being part of the
default install), and the page size is flexible on many architectures.
rsize/wsize depending on the page size makes this option non portable
across platforms, or even same platforms with different default
pagesize settings.
In real life, this can prevent puppet from working for NFS root, if
NFS root needs rsize/wsize, and someone switches the default page
size.

I thought the correct fix would be to fix the NFS client to count in
kbytes as documented, and round up/down to the pagesize.

Ced

> ---
>  utils/mount/nfs.man | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> V2: Replaced PAGE_SIZE with "system's page size"
>
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 233a7177..eab4692a 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -215,15 +215,18 @@ or smaller than the
>  setting. The largest read payload supported by the Linux NFS client
>  is 1,048,576 bytes (one megabyte).
>  .IP
> -The
> +The allowed
>  .B rsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +system's page size
> +or a power of two if it is less than
> +system's page size.
>  Specified
>  .B rsize
>  values lower than 1024 are replaced with 4096; values larger than
>  1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>  .IP
>  If an
>  .B rsize
> @@ -257,16 +260,19 @@ setting. The largest write payload supported by the Linux NFS client
>  is 1,048,576 bytes (one megabyte).
>  .IP
>  Similar to
> -.B rsize
> -, the
> +.BR rsize ,
> +the allowed
>  .B wsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +system's page size
> +or a power of two if it is less than
> +system's page size.
>  Specified
>  .B wsize
>  values lower than 1024 are replaced with 4096; values larger than
>  1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>  .IP
>  If a
>  .B wsize
> --
> 2.47.0
>
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

