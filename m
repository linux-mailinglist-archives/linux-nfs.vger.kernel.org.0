Return-Path: <linux-nfs+bounces-5243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E4948AE9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8E3283ADF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE6816A95E;
	Tue,  6 Aug 2024 08:09:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EA15C13F;
	Tue,  6 Aug 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931761; cv=none; b=q19h6IBVFQApRxQSD3GkHqSZJ3DliXVLgvfWxIVyXbP9EIdiT6JWXCXF3CyFdIS/EQpkRCTKwL8Uaiudf9y1pxGbNikra7Bcwz+eDR92DApqr2QFZeqVLNtX5hTHXXytsOQMi/1eydZWak0fISUdJ0C5aJYtBHWf3SwxqvDSs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931761; c=relaxed/simple;
	bh=beyHSYBieZI3CZU5FP8/iT3zRZq+/OgGy04GtJ01Th8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIS6T0IXWxIectSrZDc9n0r8TD/Oc/lS+K9pvDsZZqAryRBkwFqpXNG6AGpHvUfztLIO6Zf5Pl3+UcOzlwH4j8MTVE3ApKz+UUBrbelA1OWdn6y7xAi/0KyqymKvKVNOp7d7jjdGXiQHEFwBw4AddKkDvbsq68c2XxECTbFHZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef260c4467so1287591fa.0;
        Tue, 06 Aug 2024 01:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722931758; x=1723536558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycqh2pwlK6r2cYmvEN3+PY0sntc26+ciy5su8bbFD3s=;
        b=H5nnvC6+MoPHV0j8fS9FaSX6rYx3PD2OvgT6yZj0cok95o9QGOa6+Eqn7GvbjkeuU6
         RUhV4eShJNE5gVzno2S5/lsRkQDa7buMBZ5LCFaDnDS+a4AKfhQVk2piJo6Sm8jPlZ+l
         QOCQcMr+ieIrSm4+tYg8GaLS3czxdg1JKLpWRkvNdbkKZ8L/MYiYG9KZjoL3WI2+JO5Q
         SqvVROvI6mebH4t4oju2IozbrlY0oggm2Ii5y5QrfghWAeIi3JVBL9ZmlLmLk/2I4OXc
         nB/Bvm1t7UQS06GUc09rvj23BMVRxnxT7XyfvcMQ2ksfTcEiKAs7wtT6Qx9r3sDMpix3
         /9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX8iEJzqj5JDXk/0THKUYQ7WybFB5KsE4zIn3lEYTXGqf/gZjJftnlf0cQxbtdCsiJ59dCDZ4mz@vger.kernel.org, AJvYcCXsOCvd28dmoJlInMdEkDQYyoZM2d4DA39/10VQEZk/rCUf8PLKY/Qxl3IQ3uOaqzLQqcnf5rHEONkI@vger.kernel.org, AJvYcCXwZ8ufta6peFW/RxIBGTu1rz/pSp82rksFz2UgljFT8J9IZKdsi3znt31JbR1jQxTZktKePyyWUtGlrMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJS5hpkeUzWVje6w/QrY+IWB9Vqvi0zFeSjZb/NFcegf8hPe84
	3SVD2tCMaN/WiesLWIqII760h/p/VuWWoV1oblfRw9X2he3sKlVD
X-Google-Smtp-Source: AGHT+IGYNgV6SlgCygfBUA1epWAqIFzsZgG9TYZ4qeaj3oBTneDJBRw4IXcmBgYUXtQdSZKJET7pMA==
X-Received: by 2002:a2e:830b:0:b0:2ef:2d96:15f4 with SMTP id 38308e7fff4ca-2f15ab0474cmr54401891fa.5.1722931757579;
        Tue, 06 Aug 2024 01:09:17 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba4f1sm229483755e9.23.2024.08.06.01.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:09:17 -0700 (PDT)
Message-ID: <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
Date: Tue, 6 Aug 2024 11:09:14 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Tariq Toukan <ttoukan.linux@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
 <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 06/08/2024 7:43, Tariq Toukan wrote:
>
>
> On 05/08/2024 14:43, Sagi Grimberg wrote:
>>
>>
>>
>> On 05/08/2024 13:40, Tariq Toukan wrote:
>>> Hi,
>>>
>>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>>> starting from v6.11-rc1.
>>>
>>> The kernel crashes. Different runs result in different kernel traces.
>>> See below [2].
>>> All of them disappear once patch [1] is reverted.
>>>
>>> The issues appears only with "sendfile on and zerocopy on".
>>> We couldn't repro with "sendfile off", or with "sendfile on and 
>>> zerocopy off".
>>>
>>> The repro test is as simple as a repeated client/server 
>>> communication (wrk/nginx), with sendfile on and zc on, and with 
>>> "tls-hw-tx-offload: on".
>>>
>>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 5s 
>>> https://[::2:2:2:2]:20448/16000b.img; done
>>>
>>> We can provide more details if needed, to help with the analysis and 
>>> debug.
>>
>> Does tls sw (i.e. no offload) also break?
>>
>
> No it doesn't.
> Only the "sendfile with ZC" flow of the TX device-offloaded TLS.

Not familiar with the TLS offload code, are there any assumptions on 
PAGE_SIZE contig buffers? Or assumptions on individual
page references/lifetime?

The sporadic panics you reported look like a result of memory corruption 
or use-after-free conditions.

