Return-Path: <linux-nfs+bounces-13184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27CB0DFC5
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF963AB121
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D44502F;
	Tue, 22 Jul 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJG49uLg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBE1C84DD
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196274; cv=none; b=QymrEMcfSgYlOu0BASvEuMeK2BVXQ0ikXMPyZw8t0q9mxXsvgQojbVsggRKcxzmBLa0nq/y3GjAoTG5NVV18nSexJUvbIwB6CIQ3ryd80ZsTxPWn5picgvYIWQ4ow9j+HyMZARwcFy/cICkvsXpq0jzGu4q1Hk1+m6p+kNFgBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196274; c=relaxed/simple;
	bh=LVFOLOYWTr/f8iPuybu+Du6UiZYo3qLuKBHm5CH3paY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvhbo6uwZJAq6F9+qsE9tIUaT4kHwwxDmDDZrRf4BxzNd2pRNMMkzDjXihKkNyjiXM6mFVe9EWpi4ndHE7qYmi29arFvUmWmOYoRVWvuuLCZtlj3s+N8UqgT9sYa/DeEQ+tVtNvdmMmk1krq8qWHcbl0x0tPA3r2OmirJBVDyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJG49uLg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so45610085e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753196270; x=1753801070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zO/qpNaZL6HRTHI3HEKODWXsOwp9Ys8unCvpyBJmpe0=;
        b=JJG49uLgdc5f12RqvqrldjaA/BfHZHt1zoeHsh7gdToWYXnR57aTR+wR3+XSmiEy2b
         f/Jh0kY2yn3A/jiTcQ+KP19jVUvIMtu2CWBf0l2uexd9Kqfhiip532L1fiDKeORd81Zi
         5qxFikyPNn7PgoD8jrLyuGXb3AGfbmcWN5RTZYrJsxibQnYFJP7+Rg3R0nZnMd8dnUKX
         ltGOOmQCxBsRe6DPnvAno4Ar5nzRadDR/QHceJp3cB/EVg6KErfLdTcNY9TjcGMDZC17
         Mz5tWePuGWB69otTytFdUcVR/ZHDonLn5zrLn/QO5idmjjbOKMy34jFz6i9TWhduXZv2
         6bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196270; x=1753801070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zO/qpNaZL6HRTHI3HEKODWXsOwp9Ys8unCvpyBJmpe0=;
        b=BKodM4hGotCMm8+R95dO9v+dys/za3vX+m5GkG/k+ToLGN8OclXO9UchTjBjH38xeG
         pYj/UZDcEkty7cCOttxGBaKMZSx+s5slxRDDHihJTsVP7BLOgQBF63xK5TogIXnLSTqE
         eajYdFPi+giMftWPZ5pTshj1cBUIEfxUZkGp9tLu0u4EkpbSMOQe2h5v44NvQIdP4OCH
         XcvQ9FBdR5F/BOohSGUyt8Y5ZoS9FcW7aSrYCYY+oz1unMkVpB/K3WVcflqlx8/GCDhz
         o+6ftfmaFGr3aZvQvIVtTKkneg1hzH6P/2EfJRxmPeZ8ekHNIMoQuHEO7TQin/tm0gkU
         +T9Q==
X-Gm-Message-State: AOJu0Yy/D0BjBeuHMMCKRRseEBQAgDJNdwV1WCtt2D1xFnZAaEkmlYj6
	KKb/4B9iJsBuRoX0xW2e1OJF4KkcCmxOiomo+XtvrhXFRN5xS7h0hEJdr38dgg==
X-Gm-Gg: ASbGnctaziObK4R3hC0yxoZ4Nb/tcrpiOVPuthi2o80u8dGYS7OEcK+yLVbhaPC1GPI
	MDcNv7OEs+W8rNYQKwtwg0izL/hYh22WUDy5mk9+CNjA/7fjiYtFxinF3T3TYullHV9SCsgUGN8
	ANWVTzXnfH0LFdNQOUckNPdhGHMy8+ft8KUmu8DfYdVTHxH4nFlrZTsyKMN1t7vfK9rjdRl8gJk
	d9Qlh6xnP76qgezG77syao1KpohKA+tzJykS3ZuNH8Drh7I60LnBE7NVqHD7olsCFaoSUbzxTYW
	xpI1vEsBqIowhHTQkJtaYMnUG9ksrQNmCJxS2Cxb5tOW4KZ3JnDa73H+3s6zp+1llse7eFHl4gV
	c0jht19NXv4bu8Yywno4rVGztwXntJoQofaEgh94QAb9fSencVAuOpXA0m48raTjMBroPRkQ=
X-Google-Smtp-Source: AGHT+IFOhLOnkri00BBt2gbjvC+sR2adnvcKbzGut5hZgUwFW3jzVbZnNGoXcaro2p0OkttLytW7ZA==
X-Received: by 2002:a05:600c:46d1:b0:456:23e7:2568 with SMTP id 5b1f17b1804b1-45864c16535mr25160125e9.13.1753196270019;
        Tue, 22 Jul 2025 07:57:50 -0700 (PDT)
Received: from [192.168.1.76] (44.248.7.51.dyn.plus.net. [51.7.248.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48cb9sm13862169f8f.45.2025.07.22.07.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:57:49 -0700 (PDT)
Message-ID: <b75f957f-84d2-4be0-83ea-7100823c56da@gmail.com>
Date: Tue, 22 Jul 2025 15:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re-exporting NFS shares with a generated fsid as a UUID?
To: Daire Byrne <daire@dneg.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <054308ba-bad7-4e61-a11d-34f041399543@gmail.com>
 <CAPt2mGOZ2ehyUMb2m6TgDr2Y2ghRozmamxwtjd8NwAAKGBuPDw@mail.gmail.com>
Content-Language: en-GB
From: James Pearson <jcpearson@gmail.com>
In-Reply-To: <CAPt2mGOZ2ehyUMb2m6TgDr2Y2ghRozmamxwtjd8NwAAKGBuPDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm using the reexport=auto-fsidnum option with crossmnt (as Netapp is 
involved) and using fsidd - as there could potentially be hundreds of 
child volumes - which all works well, but I was just wondering if 
instead of using an external service/database to map an export path to a 
fsid, would it be 'better' if that mapping could be done internally by 
creating a UUID hash of the export path?

Thanks

James Pearson

On 22/07/2025 12:36, Daire Byrne wrote:
> We just hard code "fsid=12345" into the /etc/exports for each
> mountpoint on the "re-export" server. We use config management on our
> servers to maintain consistency.
>
> We also mostly use NFSv3 re-exports but that shouldn't matter much.
>
> Things get a bit trickier in the case of something like a Netapp that
> might have multiple "volumes" appear as a single namespace (you have
> to fsid each one in the tree).
>
> Daire
>
>
> On Tue, 22 Jul 2025 at 09:49, James Pearson <jcpearson@gmail.com> wrote:
>> I've been experimenting with re-exporting NFS shares and using the
>> external fsidd service via the 'reexport' option - which all seems to
>> work OK
>>
>> As it is possible to use a UUID as a fsid for an export, would it
>> possible to allow an automatically generated fsid as a UUID - i.e.
>> instead of talking to an external service to provide a fsid, just
>> generate a UUID which would be a hash (of some kind) of the exported
>> path ? i.e. no need to use an external database to supply a consistent
>> fsid ?
>>
>> Thanks
>>
>> James Pearson
>>
>>

