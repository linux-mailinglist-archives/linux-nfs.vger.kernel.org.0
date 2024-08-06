Return-Path: <linux-nfs+bounces-5242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D8948874
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 06:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD41C21DA5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD41BA868;
	Tue,  6 Aug 2024 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1HSiPX1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF01B663;
	Tue,  6 Aug 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919435; cv=none; b=uxzjpwavtA9CLxCGnL84Rd6TNPUZAN+k5qtO3TwWhmOF8huZE6wK2hIQCjeWkwpSK1Ko/zMHIIx4TRNDzCThq0VSO6RbKSR8dP1OC4ad6FZTMnOyaY54LemwGstsfbh8zIOXsvvbjYbMBkUqEN1soQlg8TLJ0o/E2ckKBuFblmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919435; c=relaxed/simple;
	bh=6pLFgKtSxEZKAmcpzacBafyKJDI4FEaQQ0HURf4ACl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txWaPCiZKDHlPWANB7vHiiGT0UftjfkQNSpK3Ay9QkHOIjTEfQdvdkjxHFwA2IJ0wGbIexKBQh3EKpnv0VWfTAFatDQixIPVsoRD81VzGf4bo1FFxeB9WE828Ko8zJmJHmJujYreMpJpGkuk/7m5qfSip5ptCoLCVfEiF/78tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1HSiPX1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3684bea9728so72992f8f.3;
        Mon, 05 Aug 2024 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722919432; x=1723524232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kU1s5BI+S/YW2maSR9DltJXUSi9EBeGhP3JD4j+dAU=;
        b=I1HSiPX1KO/5L5W2/zvhBY6q4hN6B4U2YYE7xZf0UyhdjRkN92SKWF//glTGZzNcth
         cKgJg2GntVs03uovkDeNTGiu3gKRnOczjkv0HYwFu0B8c8ut5PF4uVDtVhWOzSxzH0w2
         ZQlmzJ81ylPXM2fn0pZ3pqwXHjetktbbyhO8FRkLcqIoTiJwcp9xWiGIDXZB+qUmH9lB
         nNPCtVBxKVb9Avc/T19auHRdclJ4DkV02vcIS3PfQ8wzDY9yHUAtXRxkjHNlc3g/qQwA
         vKEs2v4i7FYYDVxfuuRTnxFjUhvmjc3N02CKRrStlbDCNtmHxCMRE3tECawRtbv+X9tk
         GCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722919432; x=1723524232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kU1s5BI+S/YW2maSR9DltJXUSi9EBeGhP3JD4j+dAU=;
        b=k9eG2wOZHey3432lpu0YZImT4WjtI3CwrY2XcKMUx7NcAbWhHdvcdLR1rtdxDN2dHj
         GTtscH0yoM+NhL4flxA6OU4BQG5pWI22I86yF6PeLAj5LuAlZNoN0OYEtVhcUHJne2VL
         iTvW5OeBpjidKvf2nePP/gwHx0r5wOJqIY8YQuEagTIr6tfw9T+22SeDJEH0mFD6IiHx
         1YnXypMtHwq7KveWqjKib+KgzzkVDqrcgKcGJjaIb7Cmuj9pHJ8WKFvSxDWqnwCAsOnd
         KUA6tO/GA6Jzy74Ftr/DZgfWa4H7yeltfRYslX0gVV/mFEGGmTSoFVkxh2s1tU2igHlj
         52sg==
X-Forwarded-Encrypted: i=1; AJvYcCXl8Fjrs8G2pB3dHTnT4itovxtgtr2AAuD1GNPzTOwGbh7XO+Ru+LERuY2F4FYeVCqMLBkROIF+KlE3ui1XDh/Avx+bJSmiBC8xVxctc6kuH4uO4WAr8cLRDOFHWaGbidcRsp49boa/nt20M91BAFzj9K0Qphn9wCcnmhZiKC8g
X-Gm-Message-State: AOJu0YxiMVtwm/LRAV6I6Epe3YSBp8+2ahYftr7pyQiyOSYBb73lHFPg
	cIx/dJ+kYJaHg9JuBRMIi6Ro9wBgne/bXWgnyTqNhdN362qdmkBQ
X-Google-Smtp-Source: AGHT+IED5Mx/PH30QMfFytykQ+7Wd5RiJ81T0D1gDX1QjsZH+etLQy9U23ziQnfhYSWJoGvsN6FS7g==
X-Received: by 2002:a5d:6c62:0:b0:369:cbd0:61ff with SMTP id ffacd0b85a97d-36bbc0c4fadmr12473218f8f.9.1722919431435;
        Mon, 05 Aug 2024 21:43:51 -0700 (PDT)
Received: from [192.168.0.107] ([77.124.98.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0261c2sm11647460f8f.57.2024.08.05.21.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 21:43:51 -0700 (PDT)
Message-ID: <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
Date: Tue, 6 Aug 2024 07:43:48 +0300
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
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/08/2024 14:43, Sagi Grimberg wrote:
> 
> 
> 
> On 05/08/2024 13:40, Tariq Toukan wrote:
>> Hi,
>>
>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>> starting from v6.11-rc1.
>>
>> The kernel crashes. Different runs result in different kernel traces.
>> See below [2].
>> All of them disappear once patch [1] is reverted.
>>
>> The issues appears only with "sendfile on and zerocopy on".
>> We couldn't repro with "sendfile off", or with "sendfile on and 
>> zerocopy off".
>>
>> The repro test is as simple as a repeated client/server communication 
>> (wrk/nginx), with sendfile on and zc on, and with "tls-hw-tx-offload: 
>> on".
>>
>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 5s 
>> https://[::2:2:2:2]:20448/16000b.img; done
>>
>> We can provide more details if needed, to help with the analysis and 
>> debug.
> 
> Does tls sw (i.e. no offload) also break?
> 

No it doesn't.
Only the "sendfile with ZC" flow of the TX device-offloaded TLS.

