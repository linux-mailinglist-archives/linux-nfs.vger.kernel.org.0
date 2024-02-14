Return-Path: <linux-nfs+bounces-1928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED656855461
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB41C21126
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8F555C1A;
	Wed, 14 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXR2VcrB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62211B7E2
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943941; cv=none; b=ACWYo6XOp9m7bwrL6lvGJePpKA8/PtgRW8RmKi0DAIoJCCIDDc86P1lsgkNDo6ow14U++M0qxj+5vLwoAKsnW/qxvx5UL0B1zZ+IMIaSoZ6jZts6ld42mgVXeu3F+jtKlLqIo40WbSlkGn17LvHD0D4/FBavkarUeXhA7c5StEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943941; c=relaxed/simple;
	bh=zOnPkG2V7ubTgxXtSbNtAiA/CdkPHSMD/TG9V7uKFtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PJ6EHUWg8jgS3b9rmOOZ1mykjWgZlT93YzHtCzlrGvXidlqBDcjjNlkqpquPwuwLUwDPUeuLF/VNl/UGFRnd0x9XRjSNH5ZwK/+ger8dbpYH1dssXFEdbJXd28OHYlFGCKCWovXsECkQV65TOk4dZ86BZb5cXUUUzn2KusKxW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXR2VcrB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTvpwwiaQwSfAM+MBqWSP4VQ8j+FeFYsVeKBy2DiNuQ=;
	b=TXR2VcrByZydtqCpWix0PLax9RobSuu2km/LeUC984ZX+5dj5hzMBZRrdkbmEClpyg7VrS
	ipH59pRgvyxD9mFiV4hzWrypMbC1TZ5JcUnok9QeB03RH70Pk+ZOU6PR/W8iRJ0Dl+lPpM
	hTFFVutJ/9YeeXStgz7LTUmYmE17ViU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-TnWU65BIMeOmaDnKIT7mDg-1; Wed, 14 Feb 2024 15:52:16 -0500
X-MC-Unique: TnWU65BIMeOmaDnKIT7mDg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78313358d3bso7677885a.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 12:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943936; x=1708548736;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTvpwwiaQwSfAM+MBqWSP4VQ8j+FeFYsVeKBy2DiNuQ=;
        b=GPiBMi49wWOJgXyry8XQcJl46T0p5MXNezTWRPXCL2yVMZKsKMooSfVZDFihLtdfVN
         L46Mj/VeANDIbPQxIzFxaHVQoDdnizS8N5+AMCr2GcSEIrW3nTuOXhZ7tlPZP/oBxDTg
         TXpAKbqbIXVsTpwU9frRiGhvwEiK9cX+cx4M8DWa9FM5q1s0/za68nsTb9P0DOxS0Zdu
         WnEANmLsd6uBIuXeTsY0yp+drQ/A6dd9ODToYjd32kycbWM6DpMIxgLvL/q4imfJ01gC
         sAK3DLary6oL6P8LdlaO9chXSbvrSY+Gu9qXIEA4hEiSeEURh5l2OzqAGgGN+QVc0Eow
         7Oaw==
X-Forwarded-Encrypted: i=1; AJvYcCXq+Qe+qJ+FWv5AeDZgvDKEmN2z+FlBgTg+CcKhC5GnPUGCGYcbs+zC1K1H3cyOl62koWU7p96uywH51PmTl+R35ry478ap4JNX
X-Gm-Message-State: AOJu0YwsAxm3kFt2FYnJGU39ky0GWhsS0f1oS64+3Db8bPaF52zHjiB4
	yxEUJiB3XSyzNCfDGuzF0GRa9iCJQgCjNB0QqTdVWVRtpCRkhjjlYIsstWY+IGMeqoUOHpF1gY+
	Catu3fwg8SdWGdx6+8VIaHTI8ngfAUnow9A0ZQyf3h4PYCsBi2QdvuBPY2k1DKFpwWg==
X-Received: by 2002:a05:620a:2702:b0:787:273b:810a with SMTP id b2-20020a05620a270200b00787273b810amr3938718qkp.2.1707943936124;
        Wed, 14 Feb 2024 12:52:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuna/2Xa9bteg+cxlSCWz0k0iUr3fnqX1eiZOuAzVcaqyXaJIulMCV20FLfM/XmKoQuII+lw==
X-Received: by 2002:a05:620a:2702:b0:787:273b:810a with SMTP id b2-20020a05620a270200b00787273b810amr3938707qkp.2.1707943935908;
        Wed, 14 Feb 2024 12:52:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAXgAWO3jKrJxTMX3JiL9Bpxxe2EcKLL5m7IHv1y6Fg7kHfasQ0sDgFAh5xlNIw7I9aPtd99DJpuJgz9SOWrysiVe1Jh110ZkW
Received: from [172.31.1.12] ([70.105.242.203])
        by smtp.gmail.com with ESMTPSA id da52-20020a05620a363400b007853f736893sm4093837qkb.5.2024.02.14.12.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:52:15 -0800 (PST)
Message-ID: <dcfc5ad2-e994-412b-83b4-dc52fa690479@redhat.com>
Date: Wed, 14 Feb 2024 15:52:15 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs(5): Document the max value "timeo=" mount option
Content-Language: en-US
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, linux-nfs@vger.kernel.org
References: <20240204101821.958-1-chenhx.fnst@fujitsu.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240204101821.958-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/4/24 5:18 AM, Chen Hanxiao wrote:
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Committed!

steved.

> ---
>   utils/mount/nfs.man | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 7103d28e..233a7177 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -186,6 +186,10 @@ infrequently used request types are retried after 1.1 seconds.
>   After each retransmission, the NFS client doubles the timeout for
>   that request,
>   up to a maximum timeout length of 60 seconds.
> +.IP
> +Any timeo value greater than default value will be set to the default value.
> +For TCP and RDMA, default value is 600 (60 seconds).
> +For UDP, default value is 60 (6 seconds).
>   .TP 1.5i
>   .BI retrans= n
>   The number of times the NFS client retries a request before


