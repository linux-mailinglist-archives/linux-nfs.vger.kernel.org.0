Return-Path: <linux-nfs+bounces-3321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B408CB1F6
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AB91F21E5B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DDC1C2BD;
	Tue, 21 May 2024 16:10:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6B182DB;
	Tue, 21 May 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307858; cv=none; b=b91iy+vr6RVyEPb3T9JE+nksxHmshQu9yYmaXsHYbYCsANLSe2CaqhNj25lGfoSyz1S9/aKVAeayxw5lwC1LqL85wGuLD4FFT191S4CTiYOTOLi70xLjS7jaA9l+k2Pg3XZwizm7bolfUWzOsSa3XGEiNCPL/vdQHtmvTLv7u6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307858; c=relaxed/simple;
	bh=Kg2hpSkIehutlQJJmPI6pFFbasZv4YEbQ4Ah5Rj7gCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqWjJu2wLSjjy5A0ETHDCzvH+BzVqKVCr4o5xzBsCjd16YWzAIV+bFf4eh/RNa73ky6vjxQRku/O+/6/RR3NVrFQF9e2xgLKZTTZSYTLu6PUSYrcRM+cvO9Twfbg2oNycJxK7FodMiyMafvNHC/No04Nq8Yq8uW1pa7YNFlS5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420197fba0eso4532185e9.1;
        Tue, 21 May 2024 09:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307855; x=1716912655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg2hpSkIehutlQJJmPI6pFFbasZv4YEbQ4Ah5Rj7gCE=;
        b=hqDV5Cd7rH5DVCjire4Z64NiI/QLMgid2KuEjBQemGnfiBw3dRsdeg16oB1DTnuEdg
         ilzbHEMq5gqycPAeuJWYXrYipmBUKxkHEZXBuS5Iw2KxoeyVqLLDVWeX5mTSIOIkpLjD
         ZOUyccQmap7+J2Z6qYs4ccjCWcIXPQcy4bQmDXjKY2EIBtMVTM/t3vqEw6HZlPn35h2J
         LZOqespKctyFRVeJpgdjl42sClmzBXFu7PnvtOEcVftFjFfyWFlkqYbbMiMaYqIspZIQ
         nEpBXuDKmWhxlw2FeZNS7/SmVhJ+gaaVetgTp5mcpqB6nLlQhxWHJ5FeNRYlYJDKZ2WQ
         5Jag==
X-Forwarded-Encrypted: i=1; AJvYcCUZlsVkPQX0EoatonppWPV4Tc3up0+kpPhRDizEoM0a9u5JLn7ICXRd12yrTLUea60s5eninpkN9PFEJARDguTomWqCLhNwpItdKk9xfUKX8sJGI4lBsW0TO2v1vuinUr/Hkojvbw==
X-Gm-Message-State: AOJu0YwVnvS8eH6TgVHNRUc8NJlIDwGFhlxvifwdWsxTOSIRgiBxr9uA
	ojPixBOfjhOpi01Wvj8f8+6f/iJizkItGF6gdkjE35T0A1FrQLz1
X-Google-Smtp-Source: AGHT+IGBTAeEuCB4IVXcIlvYyW0Icb/WKTkyC+sGgQ8pGyr+HiVUU+sIzBgsLxnlgTxK9pcD0r5y7w==
X-Received: by 2002:a05:600c:3b0a:b0:41a:3150:cc83 with SMTP id 5b1f17b1804b1-41feac59d8emr239353255e9.2.1716307854762;
        Tue, 21 May 2024 09:10:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm469266905e9.10.2024.05.21.09.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:10:54 -0700 (PDT)
Message-ID: <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
Date: Tue, 21 May 2024 19:10:53 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521152325.GG20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 18:23, Jason Gunthorpe wrote:
> On Tue, May 21, 2024 at 05:12:23PM +0300, Sagi Grimberg wrote:
>>>>>> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
>>>>>> loaded by their userspace counterparts as well (or at least they
>>>>>> should).
>>>>> And AFIAK, these don't have a way to autoload at all. autoload
>>>>> requires the kernel to call request_module..
>>>> nvme/nvmet/isert are requested by the kernel.
>>> How? What is the interface to trigger request_module?
>> On the host, writing to the nvme-fabrics misc device a comma-separated
>> connection string
>> contains a transport string, which triggers the corresponding module to be
>> requested.
> But how did nvme-fabrics even get loaded to write to it's config fs in
> the first place?

Something (/etc/modules-load?) loaded it intentionally.
That something knows about a concrete intention to use nvme though...


