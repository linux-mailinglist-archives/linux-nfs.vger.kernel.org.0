Return-Path: <linux-nfs+bounces-6869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79699103B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 22:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329D6B27797
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A41E1C30;
	Fri,  4 Oct 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk2gzxdW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C781E1C1F
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071694; cv=none; b=OimNVCKy27H7kC3BygGHeaxEj9uJ3xwRy2KoIEnOotrQODQ+fZvk+Cifv+fsPEATw2YAzyGPd1d5bihOW/rwvwVobcpJ2iBXWEiKdtjvgbIA++7Mlc9pQ5mIkNsAJmGUSbUHeQ5GUVwNKej62rKK7MqP1Zj5keQnwWG2z4d/+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071694; c=relaxed/simple;
	bh=3V0Xs9MubbyvU1re1mq7pnpjw31A+CkaSDuu5/x5CNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rgadM/GvFTNWBA9xsoEj+KY/dEi7A0bVmHpn8PcKtisRxECmyBUhx1nzTVLq/l31kRN1E1z4cddBsd7NSI/4qLvJF5/n0gaSb2rJr3qEWnqJ5fSDQrgeFjlIUDfYdTbPhbMFriady+WM1aZ8wQ0zylpqpxNe8S66RfugwILri9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk2gzxdW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728071691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKIusq3yZOwBj2xdxiLrlUs5PL0QGx+QRnunH2AR/bg=;
	b=hk2gzxdWfrRaCxW5wahXG6KnDSBxAmuSpBY1CGWS5ur7fSEG3dXQbbephUfPxQQq5p8VF0
	WLivxzu0XoLGVb65UIj1k6zjcJWZsfbk70A66IdU5KmijEVRCZsAzvpSPPawahtH8OaN8i
	HOtVA2HKUFd104Xqr+HFOpm/bPmWKnw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-paEmgtPlO6OjAEPX0t7QvA-1; Fri, 04 Oct 2024 15:54:50 -0400
X-MC-Unique: paEmgtPlO6OjAEPX0t7QvA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cb25c3c532so40575906d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 04 Oct 2024 12:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071689; x=1728676489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKIusq3yZOwBj2xdxiLrlUs5PL0QGx+QRnunH2AR/bg=;
        b=JV5jEl//jQ95ZStS9BEcXnZ9nJOlgkpdkG2nijIiWTMakVO2597/RLwILID9QrUYJw
         ++AlAUvBeDiRVth0drQAY+wdXl7VhGREr6ENUlwX5djV0QIQoeRjPdD43yMsPpn87buT
         /eHD1w957/+eUyOtWPqJE1yKiaALBTos29VdDHjMco+Bik/FhNPLY2Th+G02argI6rMo
         tempHy6/fpdLswWUcfJJGeARQKH2p1UkWSiXUpGCdHW0fOAH4pDucV23byClmNkH1nEb
         xbHwiqV8GwYPCzV4H/AZTHYnxiphVs7z6bfR6JNsVELrT8ZafbNqnL1zH6BAtY9A9DfY
         Y+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLC37Tb6oA9phLEuiYtLqSqvfUTwjgkRWrHF828JSihRvfbOTnh2074DJGJhlJPIURnUEaaoNLYio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91DKY6K5yIXiHFwi3oc0nU8mIr/2pGvTxEVU5iiI5yPF8zBRT
	tDSJLvrhzRPWU18HB5YJ2xwHHc7buqK80IOEd0AFM29aCAxjHsCUlU3o4elXZwSAmvRO0pIjw6n
	hSjQkxkeq7VynKhx5qJzvCgxg8gukwqwR3r5JA/diYl4iVzoFo7Bcaq3U355FRLpgEQ==
X-Received: by 2002:a05:6214:2c05:b0:6c5:681e:1d4 with SMTP id 6a1803df08f44-6cb9a4556a6mr52363816d6.34.1728071689338;
        Fri, 04 Oct 2024 12:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiDEHZUVbdlYr6xkmHRqAB05mFdgsduqiqUwVdXxHLZrwFgOPuXl1Yl4soJNruCxvEgGOPPw==
X-Received: by 2002:a05:6214:2c05:b0:6c5:681e:1d4 with SMTP id 6a1803df08f44-6cb9a4556a6mr52363666d6.34.1728071688935;
        Fri, 04 Oct 2024 12:54:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46efc2esm2088926d6.63.2024.10.04.12.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:54:48 -0700 (PDT)
Message-ID: <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
Date: Fri, 4 Oct 2024 15:54:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
To: Charles Hedrick <hedrick@rutgers.edu>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 10/4/24 2:14 PM, Charles Hedrick wrote:
> While looking into a problem that turns out to be somewhere else, I noticed that in gssd_proc.c , getpwuid is used. The context is threaded, and I verified with strace that the thread is sharing memory with other threads. I believe this should be changed to getpwuid_r. Similarly the following call to getpwnam.
> 
> Is this the right place for reports on nfs-utils?
Yes... but I'm not a fan of change code, that been around
for a while, without fixing a problem... What problem does changing
getpwuid to getpwuid_r fix?

Patches are always welcome!

steved.


