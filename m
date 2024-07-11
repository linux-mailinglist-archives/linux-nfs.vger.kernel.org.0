Return-Path: <linux-nfs+bounces-4811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EC92E862
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5031B1F22746
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80705157E88;
	Thu, 11 Jul 2024 12:34:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C2156F3C
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701263; cv=none; b=q7WvSqo68vwMJgZCS2eBySdhs8O9vtom5ZmOgQKXdLwZQ9K9LaVrwVnXMZvhDEeJOi63kyNZU0anuii+NnKRncCZSojmC71608giOoQi6Y8AqL9HxO4DSe4yOSSl1OCtlIVKB3o9lOoanYykeHrBVBhj+bRVXMuq3oNXGfomfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701263; c=relaxed/simple;
	bh=ljFujpDfLi301F7Qp9EKRHhjgoglRwu256VoGGy60s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvUCU0F9R6qSoJZrymRGp6ByTLvVmp2xDCNm8ebjjaGPJqoQHicicDFnZlfEDDX3xmoKjSD8ENTh1zbwdPOmW9RT3cCKZAg5fMO0XQZb58eDoRtVWE6Yl6HmeGJTLT+2TO7lUZo2puoPsl7dnnFv8Q0wDTR3OlFqMISRf/vwHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9ebb9cbaso135823e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 05:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701260; x=1721306060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GzFttx0SNdeiMxI1lOpyL0j+sqRtbHV9kWrlZ971Eo=;
        b=rmEikmVKz1yxMOaGjH6wQBtWGVK70dLSnhH8pqEZ1DwrKQa00BXE+xsqXdrWwtNyT0
         Br55j0u0OGY+wCrOH5+/krdYz/L+L4nSLq1Y/mQhS4G81WUABKZBmENzkZgSFvU+ujm7
         17NGyzAhAkUqz3Lt9xWM0exh1IwPbAmsvLheCjxfwP01WQDE9rhccUiVgeruB2xqCSGQ
         uFDvC2N2/xE5c2mVrixAhHTwkMcm8fRB79TFRANlsTclV02pf/BLfDaRtMJTWbKS6k3e
         VBj9uorwyu3HUcfMB7dptuYvyEwi3febugfgg12gTgibCWl1CV2kmEcDCV/VFlYyr/Af
         Ur4g==
X-Forwarded-Encrypted: i=1; AJvYcCU2AXgUselF5AeTRTepRifL3w1FOc3Wx5zp3yCyZ0c31vHYR/uHuMTmdOsZk8Qfvc7HyFeHWFz7a3z0IZzSn6CxzsV+Su9Lru3B
X-Gm-Message-State: AOJu0Ywl/mOjeMyV0Iimv0i2NAmDRrqRezNTNxKLUGJ3fNj4t3G/llVz
	w4HLTChNhL4gKZ99psYY3jL1azQQvOBqALY0b3ztDssy5LgDlzS/+kyifPpK
X-Google-Smtp-Source: AGHT+IHNe6ht3vBlbN+RILs0Hj7YfIjaMmMG6emfHOBtiSKKA4VC94CH+clXPnkWfQXkPumGElsGpw==
X-Received: by 2002:a05:6512:ac6:b0:52c:9ae0:bef3 with SMTP id 2adb3069b0e04-52eb99ff48fmr6631487e87.5.1720701259670;
        Thu, 11 Jul 2024 05:34:19 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f22acsm286260015e9.24.2024.07.11.05.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:34:19 -0700 (PDT)
Message-ID: <ebe40d59-8494-4c8f-86e7-a798e7dae087@grimberg.me>
Date: Thu, 11 Jul 2024 15:34:18 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rpcrdma: improve handling of
 RDMA_CM_EVENT_ADDR_CHANGE
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
 <20240711095908.1604235-2-dan.aloni@vastdata.com>
 <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>
 <20240711122607.4kjooqqjzweqwwxv@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711122607.4kjooqqjzweqwwxv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/07/2024 15:26, Dan Aloni wrote:
> On 2024-07-11 13:11:11, Sagi Grimberg wrote:
>>
>> On 11/07/2024 12:59, Dan Aloni wrote:
>>> It would be beneficial to implement handling similar to
>>> RDMA_CM_EVENT_DEVICE_REMOVAL in the case where RDMA_CM_EVENT_ADDR_CHANGE
>>> is issued for an unconnected CM.
>> I think Chuck has a pending series for handling device removals with a
>> dedicated
>> ib_client. So one would have to rebase against the other...
>>
>> See: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.gittopic-device-removal
>>
>> Other than that, looks good,
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> I ran some testing with `device-removal` branch (merge fe4cef916d91
> v6.10-rc7), and found that the `RDMA_CM_EVENT_ADDR_CHANGE` fix is still
> required and independent of the branch's content.

Yes it isn't related, was just mentioning that Chuck is touching this 
exact area
in the code, so perhaps these patches should be against this branch (if 
indeed it is
heading upstream)? Otherwise Chuck can rebase on top of these fixes, 
which I agree
are needed.

