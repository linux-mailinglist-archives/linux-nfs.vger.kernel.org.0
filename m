Return-Path: <linux-nfs+bounces-5314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05594EDD8
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D975B2190C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67217BB34;
	Mon, 12 Aug 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEd96fGK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2404179972;
	Mon, 12 Aug 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468545; cv=none; b=V1bEQBUoVBpOR/Xu3u1F+S4wuiLEEDNyVkML9tL3RL7kU9l1le7kYJc7qvbYxHP3m+flgNqqLss2ham4QG4bajp5CBHFzkY9cGLwKyuBo50ksXi/EwzZCC8DohIaxwHBop/OLD35WIispWPUH+oE7cRcX17QiNldX4P4AFhgDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468545; c=relaxed/simple;
	bh=b2taNsVOSHDAiL5vZCEZfHyXJuZFMGwQb/kCF4vcp9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRslFOq1Eq/WE0iQkDw7WFBq2iY+eTxWy3XFg4HpZde62tt1SFabDGNM9PvE+qCc5OkJkdMj9o+v8PWoqymrCI2uVcq4gkB0thfh8WXdZk4V1sry4RKVdFV3twJGK2hguCDuLJX1yhUXRMX1Km24+VfVM74cGOfPczY7wFd56N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEd96fGK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428141be2ddso32552205e9.2;
        Mon, 12 Aug 2024 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723468542; x=1724073342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eq/Rbe9EFIUcL4qxyLeDjWmuO6toIgbXoSQrp2GV54s=;
        b=LEd96fGKGUGkAyD48V/ZX6+sueGSWzO9murCfFPxSc/+uL9XQfPMrPbqRXCo77t0WN
         uoxH8MaRRCWsnkF0Of8rmtDkb0YxxoGksA8YYyYttGvug1KN3beVhfd7+N1lHHY0lf7H
         EEqjCofM+TpMaLFa4x0XYA1nUibF8ulE0P1P7TMvu/a9S5nPbHwy3L4IFLtcar50caep
         mqQECR0llArh0joEw5RmcVJrzqOqoBdDZSDDFJb6MtXA/lx8YydvfvmyvNjlqKR2ti36
         mTfoWZ8SvJ4uut+Ey98HGklPYAl9jEE2KuCKkwE+5CkfNCGSZZOwJohzpdRl+fG4Y8lD
         4OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723468542; x=1724073342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq/Rbe9EFIUcL4qxyLeDjWmuO6toIgbXoSQrp2GV54s=;
        b=e/x1VL5bMIHO5nvUtUx9mZOzQxylAaXZoMDC4s6/mOJvO9KotUcKXZ72UqIls/jEj3
         QBGW/tgB88Io//gaaimbcw4voAu9aNoBrdymEKHiRr/XgHnErAkmJfxv5UOwi7tl6Ri9
         Bf1I+rMapdz1ntldwp5HRD7apDTClpROcQKoKlFn2oprFWdDzpq58ZZozasbxLyigD0C
         OznN478FFNGgeRZGC3zEtnLE6sUq3cKWmALIJxVfLliHNW6k11au+T5mlQRv/XB69jvv
         0AdWInNV21EYxGGBYBWt6yZ146Pw36j4ioIC+KZFb78VXzNp/xJ4fwgZYyBsWULJUkBW
         NaWA==
X-Forwarded-Encrypted: i=1; AJvYcCVpmzMeoxEp2nzQ9a/ZRMsB3Kaq6uy5pfBaIUudZ7tAFYT1cOQPHoQUjsAe36fUKA9rIPgOU/OgWUgNPcoonrifwYgaA420Xr63EY+H8yWXmuLjFSk8zYyVqfJKnizQO9bvt4u7WIPaRL1lMQgIIKN0Ul5hX8/bixrubdpjCw6W
X-Gm-Message-State: AOJu0YxBpQm/LHqlR6GXQH0YbAFJXvawCbHEMhGAXD7xOAgovhc+CDp6
	+NcNF4AwbdPyV1Ql10utgrqG+YUrJC+9A66y5sjjk4bsjd8vBEkz
X-Google-Smtp-Source: AGHT+IEjLKEw1/hUe0gfaH5SY15kvekVhtaOZ1pZflZnA0WI0Y2FgeK0bx7MHYWLDEA7SNQ7O3me3Q==
X-Received: by 2002:a05:600c:3143:b0:428:e820:37ae with SMTP id 5b1f17b1804b1-429d47f1ec3mr3041105e9.1.1723468541258;
        Mon, 12 Aug 2024 06:15:41 -0700 (PDT)
Received: from [172.27.19.195] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee676sm7494972f8f.49.2024.08.12.06.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:15:40 -0700 (PDT)
Message-ID: <c1096b57-a03f-4fa2-b61f-7418f2304618@gmail.com>
Date: Mon, 12 Aug 2024 16:15:35 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxim Mikityanskiy <maxtram95@gmail.com>, David Howells
 <dhowells@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Mina Almasry <almasrymina@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 drort@nvidia.com
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
 <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
 <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
 <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
 <65a77bbb-b7dc-40d8-b09f-c0cf0cb01271@gmail.com>
 <a11a0502-4174-48d3-a8ad-8584fd304fe1@grimberg.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <a11a0502-4174-48d3-a8ad-8584fd304fe1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2024 21:33, Sagi Grimberg wrote:
> 
> 
> 
> On 11/08/2024 14:21, Tariq Toukan wrote:
>>
>>
>> On 06/08/2024 13:07, Tariq Toukan wrote:
>>>
>>>
>>> On 06/08/2024 11:09, Sagi Grimberg wrote:
>>>>
>>>>
>>>>
>>>> On 06/08/2024 7:43, Tariq Toukan wrote:
>>>>>
>>>>>
>>>>> On 05/08/2024 14:43, Sagi Grimberg wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 05/08/2024 13:40, Tariq Toukan wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>>>>>>> starting from v6.11-rc1.
>>>>>>>
>>>>>>> The kernel crashes. Different runs result in different kernel 
>>>>>>> traces.
>>>>>>> See below [2].
>>>>>>> All of them disappear once patch [1] is reverted.
>>>>>>>
>>>>>>> The issues appears only with "sendfile on and zerocopy on".
>>>>>>> We couldn't repro with "sendfile off", or with "sendfile on and 
>>>>>>> zerocopy off".
>>>>>>>
>>>>>>> The repro test is as simple as a repeated client/server 
>>>>>>> communication (wrk/nginx), with sendfile on and zc on, and with 
>>>>>>> "tls-hw-tx-offload: on".
>>>>>>>
>>>>>>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 
>>>>>>> 5s https://[::2:2:2:2]:20448/16000b.img; done
>>>>>>>
>>>>>>> We can provide more details if needed, to help with the analysis 
>>>>>>> and debug.
>>>>>>
>>>>>> Does tls sw (i.e. no offload) also break?
>>>>>>
>>>>>
>>>>> No it doesn't.
>>>>> Only the "sendfile with ZC" flow of the TX device-offloaded TLS.
>>>>
>>>
>>> Adding Maxim Mikityanskiy, he might have some insights.
>>>
>>>> Not familiar with the TLS offload code, are there any assumptions on 
>>>> PAGE_SIZE contig buffers? Or assumptions on individual
>>>> page references/lifetime?
>>>>
>>>> The sporadic panics you reported look like a result of memory 
>>>> corruption or use-after-free conditions.
>>
>> You can find the original patch that implements it here:
>> c1318b39c7d3 tls: Add opt-in zerocopy mode of sendfile()
>>
>> In this flow (sendfile + ZC), page is shared for kernel and userspace, 
>> and the extra copy is skipped.
>>
>> There were a few code changes in this area since the feature was 
>> introduced.
>> Adding relevant ppl, including David Howells <dhowells@redhat.com>, 
>> who removed the sendpage() routine and added MSG_SPLICE_PAGES support 
>> to tls_device.
> 
> Tariq,
> 
> Can you explain where in your test is NFS used? Is the nginx server runs 
> on an NFS mount?

I checked with the team.
The requested file, as well as the wrk and nginx apps, all reside on an 
NFS mount.

