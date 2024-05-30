Return-Path: <linux-nfs+bounces-3494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE28D51B1
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620741F2411F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658847A58;
	Thu, 30 May 2024 18:20:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09021A04
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093200; cv=none; b=ILrkQBsvSEx5iwZ63mnZE/FoPafKWtj/OagXIzSQM9tENpehAqdcHtiu+6H7228IUFq6WAJT5MEmeVezA9anG/bZti+Kq9lrFM3/C7Sx8QrzO7c7RYyFIZqTubP3lmDns4591+yRmGWv1nhw8ignP6oYFz7cB4A0RCZujKCIWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093200; c=relaxed/simple;
	bh=9HohyzfoXPvm+NEyb2oY5+qnkdQW/HON9GyeYP1ZiYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu1cb9ULaH8R8c/lonF402WVTmGIMMfCXpjEY8VgIRCCj3fsEAOXY3VqicymXr7FnXsZ2gwjKqZ5dkuh8vN9TMTLfWKtT5kzUF+aQepEXeZMLMuGhyYpkye5wNg85OSk7uk2UmU+ocKQJ4HzUGXes0ndExlJ2bmjWewDGwzR97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42110872bf9so1756545e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 11:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093197; x=1717697997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfC7O4dJlF0Ytll/qwBSKCMq6j2E0CpT755Poq8DbWo=;
        b=uhIPXPkm3cAnGTBhk3kW+RO4gLPlNSt6zFiclBVFKd3+cnYRFS+alCAWmP+4YWq1NG
         vdcCdTao54zXtGFWStHwsrewYMSQlGOi5VfiS1wpX4WKwqSBwd9SU1rxja9MgTvB2NCN
         bxEW8wPMVGVYsMwBemsUzo7yMDjhETaOTN2mmH/zNioADtbgxTJeOew4ib71gDAje4AT
         Q5AqmLXLSjaEuicd4jW/O1AhBrSFnPcIkGfoQ4DcHNKtv3L15fdCbtxVzOOcu9En3Z9m
         Sf7CquLk/jSkQyHShxCBzaLTjQEmuppT59rGQlzZT6XHNwpJxlI1vUSQF7ADc7krbCvu
         OTyA==
X-Forwarded-Encrypted: i=1; AJvYcCUC1rmY+XTTVvAiOl50yf5Kai5kx713UTIik3nB5YWmW7ENwHRFRlz86cZr/liInwkOrnJ3t5dzlwUFGqWbGbFR5YwQC0Ec230V
X-Gm-Message-State: AOJu0YzJYihrFbLonlhC9NXWtoXKzIIJghBtXDOmUNUwsvDn8XmU2G43
	1SR72eS2+AFoO3rJpuOERY8PNXFKSqsMJy558HMwIrk07HABxm7u
X-Google-Smtp-Source: AGHT+IGBgAdbzEFEuX087ljy6jtl0d4aEjzuL0RWXyFJUAMCDWC0GBmHKcwk0GF2CQSzhgNo27RTPA==
X-Received: by 2002:a05:600c:1c8f:b0:41b:fdf9:98b5 with SMTP id 5b1f17b1804b1-42128355f85mr20004605e9.4.1717093197002;
        Thu, 30 May 2024 11:19:57 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85b3b7sm2170805e9.26.2024.05.30.11.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:19:56 -0700 (PDT)
Message-ID: <faf945a9-d1bc-45db-9543-057b7bc0ed8d@grimberg.me>
Date: Thu, 30 May 2024 21:19:55 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS write congestion size
To: NeilBrown <neilb@suse.de>
Cc: Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "anna@kernel.org" <anna@kernel.org>
References: <> <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
 <171706807360.14261.8929224868643154972@noble.neil.brown.name>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <171706807360.14261.8929224868643154972@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> btw, I think you meant that *slower* devices may need a larger queue to
>> saturate,
>> because if the device is fast, 256MB inflight is probably enough... So
>> you are solving
>> for the "consumer grade contemporary disks".
> No, faster devices.  The context here is random writes.  The more of
> those that are in the queue on the server, the more chance it has to
> re-order or coalesce requests.

Umm, what would reorder help with if writes are random?

> We don't want the device to go idle so we want lots of data buffered.
> It will take the client some moments to respond to the client-side queue
> dropping below a threshold by finding some pages to write and to submit
> them.  We don't want those moments to be long enough for the server-side
> queue to empty.

Yes I agree. I was just arguing that the faster the device is, the lower 
the completion
latency is. Meaning, if a device has a write-latency of 1us, you need a 
shorter queue than
a device that has a write-latency of 100ms.

Anyways, we're getting side-tracked...

